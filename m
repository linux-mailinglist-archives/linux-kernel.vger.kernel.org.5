Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0682381125B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379105AbjLMNCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379083AbjLMNCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:02:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B90125
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:02:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CCFC433C8;
        Wed, 13 Dec 2023 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702472559;
        bh=oucTferbO8z09uzRC+QN/9ilQDasa9VaUoOZvOLBlL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMGDvekulMiLgPyCQAmQWR/eYvFAOux9M1LrBgXpjuHKi5GdnupdLCcjMmHeANAZw
         NDWN1eQkHCW2Sw+pfLuqq2pfj/JcgsDdVtA22OmSnHNJxYpw+yR1FExTe1nE8Z/wZs
         akM7+FPs9zpIm5sPjIcHPvfZPn+4KlneeGqG3rOB6Je1SWsz2emIBCRZySFkAzIPeA
         xA8qRf8Vl62kxL6qdWQBsLnN2r/BrbU0YpgQxCdD/1rH6ftoAJoKvEHvCU6oG3Umxf
         wyUryDjEKQZG4E1FVlzWMllV3UPLfXuBS3NdhfbgQtbEkbPuCgd+tR20WHysGMMqwt
         MUW7KhdPyiXlw==
Date:   Wed, 13 Dec 2023 14:02:31 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com,
        jaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v2 04/16] fs: Increase fmode_t size
Message-ID: <20231213-gurte-beeren-e71ff21c3c03@brauner>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-5-john.g.garry@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:08:32AM +0000, John Garry wrote:
> Currently all bits are being used in fmode_t.
> 
> To allow for further expansion, increase from unsigned int to unsigned
> long.
> 
> Since the dma-buf driver prints the file->f_mode member, change the print
> as necessary to deal with the larger size.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/dma-buf/dma-buf.c | 2 +-
>  include/linux/types.h     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 21916bba77d5..a5227ae3d637 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1628,7 +1628,7 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
>  
>  
>  		spin_lock(&buf_obj->name_lock);
> -		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
> +		seq_printf(s, "%08zu\t%08x\t%08lx\t%08ld\t%s\t%08lu\t%s\n",
>  				buf_obj->size,
>  				buf_obj->file->f_flags, buf_obj->file->f_mode,
>  				file_count(buf_obj->file),
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 253168bb3fe1..49c754fde1d6 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -153,7 +153,7 @@ typedef u32 dma_addr_t;
>  
>  typedef unsigned int __bitwise gfp_t;
>  typedef unsigned int __bitwise slab_flags_t;
> -typedef unsigned int __bitwise fmode_t;
> +typedef unsigned long __bitwise fmode_t;

As Jan said, that's likely a bad idea. There's a bunch of places that
assume fmode_t is 32bit. So not really a change we want to make if we
can avoid it.
