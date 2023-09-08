Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40C7992EF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjIHX5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjIHX5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:57:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4BB133;
        Fri,  8 Sep 2023 16:57:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B072FC433C7;
        Fri,  8 Sep 2023 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694217433;
        bh=6lBmqZwY26Xt/+O04ezUlGJ2Cb+N+JDZhJqABHZhfVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpVDQiMPRbcujh8GgkYcsvP6L0FAi7z+U+uKsteB79xgyiyHvGArD1YkA7CEy5tnu
         hGVS/1jRaQn1dkiM5xhPMi0gOcVDaKsfBzyBQHxj6zJoOspXL5EvnN2W7tJ32k5T0B
         XqIOJWGQg6c2IMuxgJ/KXJhJ03d91QYBcUF41jojbJKcRAiu0Vybp9dYvF+c/pmwQs
         0BS51x38CUMrzuE53SRY8p1WV2o1pRWoIB4LCEVPrew1XFu1Hs/E84RuTbucglunjh
         Y4Oe5ZVJx191J8BECnlBU24fiXYBCwD6gmnNcZdBVVU/ITZdhG6d2990yCSax/OPAO
         fLwwfHfH9g0ng==
Date:   Fri, 8 Sep 2023 16:57:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     alexjlzheng@gmail.com
Cc:     chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH] xfs: remove redundant batch variables for serialization
Message-ID: <20230908235713.GP28202@frogsfrogsfrogs>
References: <20230907123017.1049345-1-alexjlzheng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907123017.1049345-1-alexjlzheng@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:30:18PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> Historically, when generic percpu counters were introduced in xfs for
> free block counters by commit 0d485ada404b ("xfs: use generic percpu
> counters for free block counter"), the counters use a custom batch size.
> In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(), this
> patch attempts to serialize the program using a smaller batch size as a
> parameter to the addition function as the counter approaches 0.
> 
> Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> ("xfs: use generic percpu counters for free block counter") mentioned
> above and said that "Because the counters use a custom batch size, the
> comparison functions need to be aware of that batch size otherwise the
> comparison does not work correctly".
> 
> After commit 8c1903d3081a ("xfs: inode and free block counters need to
> use __percpu_counter_compare"), the existence of the batch variable is
> no longer necessary, so it was removed to simplify the code.

It *was removed*?  It looks like this patch is _doing_ the removing.

I don't get it, what problem are you having?

--D

> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  fs/xfs/xfs_mount.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 0a0fd19573d8..72dab39376b7 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -1144,7 +1144,6 @@ xfs_mod_freecounter(
>  	int64_t			lcounter;
>  	long long		res_used;
>  	uint64_t		set_aside = 0;
> -	s32			batch;
>  	bool			has_resv_pool;
>  
>  	ASSERT(counter == &mp->m_fdblocks || counter == &mp->m_frextents);
> @@ -1177,20 +1176,6 @@ xfs_mod_freecounter(
>  		return 0;
>  	}
>  
> -	/*
> -	 * Taking blocks away, need to be more accurate the closer we
> -	 * are to zero.
> -	 *
> -	 * If the counter has a value of less than 2 * max batch size,
> -	 * then make everything serialise as we are real close to
> -	 * ENOSPC.
> -	 */
> -	if (__percpu_counter_compare(counter, 2 * XFS_FDBLOCKS_BATCH,
> -				     XFS_FDBLOCKS_BATCH) < 0)
> -		batch = 1;
> -	else
> -		batch = XFS_FDBLOCKS_BATCH;
> -
>  	/*
>  	 * Set aside allocbt blocks because these blocks are tracked as free
>  	 * space but not available for allocation. Technically this means that a
> @@ -1204,7 +1189,7 @@ xfs_mod_freecounter(
>  	 */
>  	if (has_resv_pool)
>  		set_aside = xfs_fdblocks_unavailable(mp);
> -	percpu_counter_add_batch(counter, delta, batch);
> +	percpu_counter_add_batch(counter, delta, XFS_FDBLOCKS_BATCH);
>  	if (__percpu_counter_compare(counter, set_aside,
>  				     XFS_FDBLOCKS_BATCH) >= 0) {
>  		/* we had space! */
> -- 
> 2.31.1
> 
