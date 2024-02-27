Return-Path: <linux-kernel+bounces-83771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABA2869E49
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC28F28461E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324C4EB32;
	Tue, 27 Feb 2024 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiavqekT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC994E1CB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056219; cv=none; b=K5RNL4AIUD4rDpBWdrgoLZpjNeO53suYAPJAnTXknZCOeJWJtv4SuXWF1pPn1g3dWsqjImccaBO/pDUN0yYt+8fRU5yQ+vkJ7NZLUc5S5oZTFYHlXWtqKgE4dVImdU+/FoKYPzoIOdLkPvVTL3NStU/AekoQUFqehFE0M7T8aXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056219; c=relaxed/simple;
	bh=DDIKRf6Ufecl9u57nNBqnT2apz/dSFBQ9/B2HzYZIKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uL330ZwkPdDT/ljKznWaf+PSoSUjJUaz0E+I+iO2UNrIgLKEldTNdzZHQdaszv61pOf0d6eifQPKRiC11JDliEF9RuyCl142vC/K0HoW5lqwS3gpwud7epUgv5jpaNBTZDdG95gIvpUysWY3/GJ6zmkpWINseE/qzjPw2dFu9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiavqekT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226DDC433F1;
	Tue, 27 Feb 2024 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056219;
	bh=DDIKRf6Ufecl9u57nNBqnT2apz/dSFBQ9/B2HzYZIKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiavqekT8D8nUaX8Elm1x2Eu9AMmI2cT+u3IkMJ9CSglk2muojEs+Y49uOoEuqYv1
	 mbPo+W/3LR01UUG7RnQgOSrJMzzZ+lLZxueIEWbCTFbxuIsP7YELh1pGfcuD7W+NW0
	 nZN4yT37tv0ebz6G6jckbv6AVNrpBWoQYzpTYxFtmiTDqCYG5fzlYetCOgjh4tr8mt
	 zQRi4DSaVHM/6/gnShQkQyVfvSo9b2bB3/4G2qeGRdW5td0adH84w2IySP2V4BMS1F
	 YupOmDsM9mSqb8QR2kG7XkIBohQ9D2lU70KdApgbqz+WIhpqbxt+No8jCL/0SKPmlJ
	 xvYBKRJCnCaJQ==
Date: Tue, 27 Feb 2024 09:50:17 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] f2fs: fix to don't call f2fs_stop_checkpoint in
 spinlock coverage
Message-ID: <Zd4g2SgQn3v_ZJMj@google.com>
References: <20240222121851.883141-1-chao@kernel.org>
 <20240222121851.883141-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222121851.883141-2-chao@kernel.org>

On 02/22, Chao Yu wrote:
> f2fs_stop_checkpoint(, false) is complex and it may sleep, so we should
> move it outside segmap_lock spinlock coverage in get_new_segment().

Chao, I merged this patch into

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=f3b576d209983b5d6e1cb130bfc8ca1f0bbcad6d

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d0209ea77dd2..8edc42071e6f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2646,6 +2646,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
>  	bool init = true;
>  	int i;
> +	int ret = 0;
>  
>  	spin_lock(&free_i->segmap_lock);
>  
> @@ -2671,9 +2672,8 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  		secno = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
>  		if (secno >= MAIN_SECS(sbi)) {
> -			f2fs_stop_checkpoint(sbi, false,
> -				STOP_CP_REASON_NO_SEGMENT);
> -			f2fs_bug_on(sbi, 1);
> +			ret = -ENOSPC;
> +			goto out_unlock;
>  		}
>  	}
>  	segno = GET_SEG_FROM_SEC(sbi, secno);
> @@ -2704,7 +2704,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  	f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
>  	__set_inuse(sbi, segno);
>  	*newseg = segno;
> +out_unlock:
>  	spin_unlock(&free_i->segmap_lock);
> +
> +	if (ret) {
> +		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
> +		f2fs_bug_on(sbi, 1);
> +	}
>  }
>  
>  static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
> -- 
> 2.40.1

