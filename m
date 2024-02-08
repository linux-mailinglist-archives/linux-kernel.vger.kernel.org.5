Return-Path: <linux-kernel+bounces-57329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50F84D70D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F8DB22BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 00:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01261E534;
	Thu,  8 Feb 2024 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQzIFv1B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30781E49D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351419; cv=none; b=D8rtuwimPNjLGw9sJ/89nDb4cQeyIY5g4dIPfQREj9PUjAVraO8fpI1oBCyleTlR/OA3pEfbNUhTjt1nVH61X76TIgel2sar8PTDZgSAPlYuqSyvaMG9VMN/ygnXPINBlbHVRP5DNvRKc7VCQS+4qpH63PfHoXT4KZQYVRIsAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351419; c=relaxed/simple;
	bh=2egm5jFqueRjaknu6E3h71ZQadfGobiAaLx45nwM9Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZF2lGfU9Pp3hZagEbgx/JO6OxMnf53QinUAD21cO8X91i2R7E3b7pUPLAaBC4mmAk0wsdQaqs7Vswt0QjPr79YqBKgP6PHVYmy1UL7tZCr9Jk5IRBpPDR5z9dSxYjvvFJcAaEV63V/AVLlDBpUt4lMr1CSQSY+RxnneYGA/tz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQzIFv1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F04FC433C7;
	Thu,  8 Feb 2024 00:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707351418;
	bh=2egm5jFqueRjaknu6E3h71ZQadfGobiAaLx45nwM9Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQzIFv1BZLrFWf4h0rnDxPP9adLZD6yoVFpeVsHTIpdoxkKoChEcGwXyQh0Zar9x5
	 3qdzFj0z5ciW4kd15ko/hCrAuZbN1yc2cTa+jckrKHdKQgr0q08er/c2FPOfTApzV3
	 1bSnlCsMZ9eIYTD/3wGAth+cZ4u3DNOY6VCympad9heCzANDrZQkLk5ADgZXRjwkPe
	 /qeZJPMpJTRulmKCPtWpHnIFs3G5XvlOBE/oyAVb1XhwWxtrYUdhk3iMHnJPlvJaJz
	 4EPM2jzGQtnM6NigHZ8Okd3SWrMVecicim94SFd0Q4SBrzos8ltLrrE7G5pbHgUo3F
	 BeLWyix3PJghw==
Date: Wed, 7 Feb 2024 16:16:56 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Subject: Re: [PATCH v2 4/4] f2fs: stop checkpoint when get a out-of-bounds
 segment
Message-ID: <ZcQdeC4e7rnr9pCr@google.com>
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <1707271264-5551-5-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1707271264-5551-5-git-send-email-zhiguo.niu@unisoc.com>

On 02/07, Zhiguo Niu wrote:
> There is low probability that an out-of-bounds segment will be got
> on a small-capacity device. In order to prevent subsequent write requests
> allocating block address from this invalid segment, which may cause
> unexpected issue, stop checkpoint should be performed.
> 
> Also introduce a new stop cp reason:  STOP_CP_REASON_OUTOF_RAGNE.

OUT_OF_RANGE?

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/segment.c       | 12 ++++++++++--
>  include/linux/f2fs_fs.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6772ad4..6fe2baf 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2666,7 +2666,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  		if (dir == ALLOC_RIGHT) {
>  			secno = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> +			if (secno >= MAIN_SECS(sbi)) {
> +				f2fs_stop_checkpoint(sbi, false,
> +						STOP_CP_REASON_OUTOF_RAGNE);
> +				f2fs_bug_on(sbi, 1);
> +			}
>  		} else {
>  			go_left = 1;
>  			left_start = hint - 1;
> @@ -2682,7 +2686,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  		}
>  		left_start = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
> +		if (left_start >= MAIN_SECS(sbi)) {
> +			f2fs_stop_checkpoint(sbi, false,
> +					STOP_CP_REASON_OUTOF_RAGNE);
> +			f2fs_bug_on(sbi, 1);
> +		}
>  		break;
>  	}
>  	secno = left_start;
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 053137a0..72c6782 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -81,6 +81,7 @@ enum stop_cp_reason {
>  	STOP_CP_REASON_CORRUPTED_SUMMARY,
>  	STOP_CP_REASON_UPDATE_INODE,
>  	STOP_CP_REASON_FLUSH_FAIL,
> +	STOP_CP_REASON_OUTOF_RAGNE,
>  	STOP_CP_REASON_MAX,
>  };
>  
> -- 
> 1.9.1

