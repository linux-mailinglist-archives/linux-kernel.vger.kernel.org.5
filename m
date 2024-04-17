Return-Path: <linux-kernel+bounces-148797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61B8A878D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3044C1F251E1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A52147C65;
	Wed, 17 Apr 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3A5zOfQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59C1411E8;
	Wed, 17 Apr 2024 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367634; cv=none; b=nl/OihOlyqst5VB3kTcfowKaWkD4BHBMuqcA3RCkgFDbC9Bn3FMOPIxeLtU9IVxtL39AVBIFFd9ouK74eZdeBR26NDtf43VtOPItAOCEN67/pN8kH7mhDTmVfOViNg+CG3OXidJ3i521aBsCQlaKHqJI8GgnStgY2xQTioixN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367634; c=relaxed/simple;
	bh=dg5WTB8j8TY3F8bg0Hm8Zm5lJvymLzPO2JHZ5Byw+sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTT/KaUX7xWGMn+V012x5ZVdl1cKIZhABg4J6WWfe3hd3EPJgJf7FyGPbjRSFvMUYDA8W0LqS+HonLTFHohcsNks4kQ/lM2aAMg81ScC1YQwStrqcmK1NR554Gjz5VjD6Aj/arM275kXMUjAuRY4/5/AEDVqkJM51TjqNHzqJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3A5zOfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91EC072AA;
	Wed, 17 Apr 2024 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367633;
	bh=dg5WTB8j8TY3F8bg0Hm8Zm5lJvymLzPO2JHZ5Byw+sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3A5zOfQz3bv0stRAQ3CvC2UK+3R2lF57xEGF/cnQeNosW6hBZFI7PFMT8BOAE24s
	 nVzdYex+MnlZDKf/Bjzn5UdCo1GxU3U8VcZ862jPQ1Fke+JMhCtWD3hlCd/LvUDr/D
	 OSNdXLu7vsRoYLADmZUrAsIVzboJow/OEjo+bPCg/nBztF/IFaeTDDr0sQ0EKaH43k
	 9z7ajxWu8uG8UTF/WNdW9bh82x4htyz/nsjll7BicYz3+BL4jED+t6WOBduwjcVlaR
	 MvXZqaRMaNrvDD/68mBAVO/7Kh5AFXlrXCtriTd9DItXfV07b9EGjH6bgRjhaDQYHg
	 amApZglwgxvfA==
Date: Wed, 17 Apr 2024 08:27:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: alexjlzheng@gmail.com
Cc: david@fromorbit.com, chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH v3 RESEND] xfs: remove redundant batch variables for
 serialization
Message-ID: <20240417152713.GX11948@frogsfrogsfrogs>
References: <20240417120734.853960-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417120734.853960-1-alexjlzheng@tencent.com>

On Wed, Apr 17, 2024 at 08:07:35PM +0800, alexjlzheng@gmail.com wrote:
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> Historically, when generic percpu counters were introduced in xfs for
> free block counters by commit 0d485ada404b ("xfs: use generic percpu
> counters for free block counter"), the counters used a custom batch
> size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
> this patch attempted to serialize the program using a smaller batch size
> as parameter to the addition function as the counter approaches 0.
> 
> Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> ("xfs: use generic percpu counters for free block counter") mentioned
> above and said that "Because the counters use a custom batch size, the
> comparison functions need to be aware of that batch size otherwise the
> comparison does not work correctly". Then percpu_counter_compare() was
> replaced with __percpu_counter_compare() with parameter
> XFS_FDBLOCKS_BATCH.
> 
> After commit 8c1903d3081a ("xfs: inode and free block counters need to
> use __percpu_counter_compare"), the existence of the batch variable is
> no longer necessary, so this patch is proposed to simplify the code by
> removing it.
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
> Changelog:
> 
> v3: Resend for the second time 
> 
> v2: https://lore.kernel.org/linux-xfs/20230918043344.890817-1-alexjlzheng@tencent.com/
> 
> v1: https://lore.kernel.org/linux-xfs/20230908235713.GP28202@frogsfrogsfrogs/T/#t

..you still haven't answered my question from V1: What problem are you
solving with this patch?

--D

> ---
>  fs/xfs/xfs_mount.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index aed5be5508fe..8e47a3040893 100644
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
> 2.39.3
> 
> 

