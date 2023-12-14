Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113AD812452
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjLNBLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNBLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:11:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FBB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:11:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6B2C433C8;
        Thu, 14 Dec 2023 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702516284;
        bh=XwoFjsJDwQ9a2+DWM4rjeegVkzh/lxFGbWD3rYfyGcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSq1uGLrFIRUTnVT3AS20PIwVXDWLgO8ozWsfsDZWaPJjk8n3u8l/eWwAv50O0EMd
         u8lxxL9Y4sSkGifdgqH3/YI4+EmFlAIdAVSI/mgcQl9karZZTwtudxVBlp5VpjaMxu
         SjagbjSDOcAhlUiBn/nkeM13SGJb/wwTwxfblLge9zGFRonPJ2SBordG8cRqdYFNpI
         3vAf2yXumJqwsUhu2Qb2L2P3bTvd2tZKU5prXoqDMiIFx8b91cZLKRNAPDnqn2anJK
         4lsRsLROKyVu60uG6cdSuihgOfEcCuT+ZirEHhGzdijeXu7TpvPoxov1wnMfqIDbmI
         CMP4+mM/C2Qxg==
Date:   Wed, 13 Dec 2023 17:11:21 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        dm-devel@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v18 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <ZXpWOaxCRoF7dFis@kbusch-mbp>
References: <20231206100253.13100-1-joshi.k@samsung.com>
 <CGME20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7@epcas5p2.samsung.com>
 <20231206100253.13100-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206100253.13100-3-joshi.k@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:32:34PM +0530, Kanchan Joshi wrote:
>  static inline bool bio_has_data(struct bio *bio)
>  {
> -	if (bio &&
> -	    bio->bi_iter.bi_size &&
> -	    bio_op(bio) != REQ_OP_DISCARD &&
> -	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	if (bio && (bio_op(bio) == REQ_OP_READ || bio_op(bio) == REQ_OP_WRITE))
>  		return true;

There are other ops besides READ and WRITE that have data, but this is
might be fine by the fact that other ops with data currently don't call
this function.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 7c2316c91cbd..bd821eaa7a02 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -393,6 +393,10 @@ enum req_op {
>  	/* reset all the zone present on the device */
>  	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
>  
> +	/* copy offload dst and src operation */
> +	REQ_OP_COPY_SRC		= (__force blk_opf_t)19,

Should this be an even numbered OP? The odd ones are for data
WRITEs.

> +	REQ_OP_COPY_DST		= (__force blk_opf_t)21,
