Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA481094F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378525AbjLMFAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjLMFAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:00:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8868FCF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 21:00:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79E6C433C8;
        Wed, 13 Dec 2023 05:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702443614;
        bh=gC1lI3x4vsiQ2Y+IPRczMggA/qnBBXkC9wbtK1snAjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPqmlW9JQYQlGE3yHwf4cPkd0c5YBzdIU1rOS063bQ7ze5ymieEBqLPQ1YiXRIMMH
         h044fS0Mn8kaUsY1io0PFKV79y1EHayMztCy52QlmJhBL8/MgDgD5MYoXWM87VIScT
         wZsvv5MKHoLwS8+e3DQjitaZ716HuCtB964zlZYGjNNL/qe71F/gW7YxMz+80snL25
         R56YU4xRJrsc8c+iaGtvkw1BQBTLXZCi1t7/Pw2oXIt4vVu4ymguwVRJIVik5tV3lU
         rSumXjFwxKbyrtm5qm2s/bq2CYTxI7Y7sgXDXp44mPUVtp9gvC4M7ieuMlSKm/Tkpg
         0wXBy5F7m4xQQ==
Date:   Tue, 12 Dec 2023 21:00:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
        yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dm-bufio: Support I/O priority
Message-ID: <20231213050012.GD1127@sol.localdomain>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
 <20231212111150.18155-4-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212111150.18155-4-hongyu.jin.cn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:11:48PM +0800, Hongyu Jin wrote:
>  static void use_dmio(struct dm_buffer *b, enum req_op op, sector_t sector,
> -		     unsigned int n_sectors, unsigned int offset)
> +		     unsigned int n_sectors, unsigned int offset, unsigned short ioprio)

The ioprio argument to this function is unused.

>  bool dm_bm_is_read_only(struct dm_block_manager *bm)
> diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
> index 75e7d8cbb532..d270d48891f7 100644
> --- a/include/linux/dm-bufio.h
> +++ b/include/linux/dm-bufio.h
> @@ -11,6 +11,7 @@
>  #define _LINUX_DM_BUFIO_H
>  
>  #include <linux/blkdev.h>
> +#include <linux/ioprio.h>
>  #include <linux/types.h>

It's not necessary to include linux/ioprio.h here.

- Eric
