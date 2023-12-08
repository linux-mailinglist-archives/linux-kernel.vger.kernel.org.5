Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA438098DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572937AbjLHByZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjLHByY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:54:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705AC172E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:54:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96A2C433C7;
        Fri,  8 Dec 2023 01:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702000445;
        bh=IbytOVy5a5Ro3NMM8xBisbXuTVHMAHlkl7zTvD7m19A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zg1FE4qf0sTdnrrs3eBPGg9iLNs4Vfd+Z3Iy4bb/6U5V57LH7phO3IzAnPvr4nWlE
         A1gbHxrIB6ERvp0KTHLhC3yOra9gljcNl3ge3qK7irtlTJaJCQVypSC0lYcdaP279F
         yzkjQR7DnFVviW/ErNQCSJppVa76cQ7tH8Ta1xNG5kZFdd2olxAeOaKIU8EYA+phuY
         Dt7/9qHxVxvhPxo/MmY+S5FDgmoABVLPHOBiGTUPART9eK+HCMtsjrC+cp/VDvaYAA
         th+81aDF71nnnkigmmdlqBDuDUfmlmCcIBKo85n64NbrBiDijS9PowaTRPW7TOrnw1
         WFxIvkhymekJA==
Date:   Thu, 7 Dec 2023 17:54:03 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev
Subject: Re: [PATCH v2] dm verity: Inherit I/O priority from data I/O when
 read FEC and hash from disk
Message-ID: <20231208015403.GB1160@sol.localdomain>
References: <83e8ea6c-1d9-36d5-1c23-da686dbfaf80@redhat.com>
 <20231206113935.9705-1-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206113935.9705-1-hongyu.jin.cn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 07:39:35PM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> when read FEC and hash from disk, I/O priority are inconsistent
>  with data block and blocked by other I/O with low I/O priority.
> 
> Add dm_bufio_prefetch_by_ioprio() and dm_bufio_read_by_ioprio(),
> can pecific I/O priority for some I/O.
> Make I/O for FEC and hash has same I/O priority with data I/O.
> 
> Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> ---
> Changes in v2:
>   - Add ioprio field in struct dm_io_region
>   - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
>   - Add two interface
> ---
>  drivers/md/dm-bufio.c           | 50 ++++++++++++++++++++++-----------
>  drivers/md/dm-integrity.c       |  5 ++++
>  drivers/md/dm-io.c              |  1 +
>  drivers/md/dm-log.c             |  1 +
>  drivers/md/dm-raid1.c           |  2 ++
>  drivers/md/dm-snap-persistent.c |  2 ++
>  drivers/md/dm-verity-fec.c      |  3 +-
>  drivers/md/dm-verity-target.c   | 10 +++++--
>  drivers/md/dm-writecache.c      |  4 +++
>  include/linux/dm-bufio.h        |  6 ++++
>  include/linux/dm-io.h           |  2 ++
>  11 files changed, 66 insertions(+), 20 deletions(-)

Changing so many things in one patch should be avoided if possible.  Is there a
way to split this patch up?  Maybe first add ioprio support to dm-io, then add
ioprio support to dm-bufio, then make dm-verity set the correct ioprio?

>  void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
>  		    struct dm_buffer **bp)
> +{
> +	return dm_bufio_read_by_ioprio(c, block, bp, IOPRIO_DEFAULT);
> +}
> +EXPORT_SYMBOL_GPL(dm_bufio_read);
> +
> +void *dm_bufio_read_by_ioprio(struct dm_bufio_client *c, sector_t block,
> +		    struct dm_buffer **bp, unsigned short ioprio)
>  {
>  	if (WARN_ON_ONCE(dm_bufio_in_request()))
>  		return ERR_PTR(-EINVAL);
>  
> -	return new_read(c, block, NF_READ, bp);
> +	return new_read(c, block, NF_READ, bp, ioprio);
>  }
> -EXPORT_SYMBOL_GPL(dm_bufio_read);
> +EXPORT_SYMBOL_GPL(dm_bufio_read_by_ioprio);
>  
>  void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
>  		   struct dm_buffer **bp)
> @@ -1909,12 +1918,19 @@ void *dm_bufio_new(struct dm_bufio_client *c, sector_t block,
>  	if (WARN_ON_ONCE(dm_bufio_in_request()))
>  		return ERR_PTR(-EINVAL);
>  
> -	return new_read(c, block, NF_FRESH, bp);
> +	return new_read(c, block, NF_FRESH, bp, IOPRIO_DEFAULT);
>  }
>  EXPORT_SYMBOL_GPL(dm_bufio_new);
>  
>  void dm_bufio_prefetch(struct dm_bufio_client *c,
>  		       sector_t block, unsigned int n_blocks)
> +{
> +	return dm_bufio_prefetch_by_ioprio(c, block, n_blocks, IOPRIO_DEFAULT);
> +}
> +EXPORT_SYMBOL_GPL(dm_bufio_prefetch);
> +
> +void dm_bufio_prefetch_by_ioprio(struct dm_bufio_client *c,
> +		       sector_t block, unsigned int n_blocks, unsigned short ioprio)

I think it would be cleaner to just add the ioprio parameter to dm_bufio_read()
and dm_bufio_prefetch(), instead of adding new functions.

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 26adcfea0302..5945ac1dfdff 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -51,6 +51,7 @@ static DEFINE_STATIC_KEY_FALSE(use_tasklet_enabled);
>  struct dm_verity_prefetch_work {
>  	struct work_struct work;
>  	struct dm_verity *v;
> +	struct dm_verity_io *io;
>  	sector_t block;
>  	unsigned int n_blocks;
>  };

Isn't it possible for 'io' to complete and be freed while the prefetch work is
still running?

- Eric
