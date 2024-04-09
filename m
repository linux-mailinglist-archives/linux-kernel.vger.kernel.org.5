Return-Path: <linux-kernel+bounces-136197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72489D0FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73561F24DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26C76BB20;
	Tue,  9 Apr 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYICjupj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CF6A031
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633022; cv=none; b=Upo81ZwKfW6c8AY9dAd8+w3swugDcfNoTeCmNhZYNIjLJ3A8yPXJiiQwmm5x2f3DEsFunZEJDdGm8qqkyCL4AFIvSNg3yWo7QnLpW6cDdFg4c3F1EbK2UzY3U/iPV38PH2Id7wmmA2SHwcL9QOJBMp+Rl5RFfm4rrlv1QFWvsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633022; c=relaxed/simple;
	bh=heUw+z02lSXePDybJSxjPXBkHjsdfr4yAQ0XueZUSJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpwSrwpZDrs5JQxi7p8GEf9A2Vy+4qL54mT2zrllyMmuwr9FcQQ/R4mVaKNJjIgcBWDp+0vRnhgBC6Fko6m3/27BiLFpPPBODIUUYnwPYmQKrGn7NZ7QsKdQagA2mgHLkSxCUikBBU9rlV9S04E8rIBFfG2zPvY82esELoKVES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYICjupj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F30C433C7;
	Tue,  9 Apr 2024 03:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633021;
	bh=heUw+z02lSXePDybJSxjPXBkHjsdfr4yAQ0XueZUSJk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uYICjupj82TBb6nIGAbyn88j7LHfRu7Wk7jQeWX6ZT9X+LEDbRpziV5Kd8hSQ5WaW
	 mL+yaggUIwPAXoDRbs+XteqO1J0Wbcc64kButb8DlqCcbesM2OWoSlAsrZ3h64iyao
	 Uo/MKW6lLKM2WkuhB1E2L0M7cD9Q+cksn/WjEpdThtnggokrcw4mfsTkfkNQVCKKZx
	 zMkG10+3k4EvfwOJ52LKpO+u4TL6cRhCa2EZKhxGnvXXQac6WNwXGZE8TA65jXYg8U
	 UKIiJ4aDcoISjq+D3sxk9rqgHTVjjZkfjJPNOodkZk2kofNe8riTyPE8je2bS+lQbj
	 2eC4AI+hMXNwA==
Message-ID: <2c195fee-c71c-4e44-b24f-9880b3c1b6c4@kernel.org>
Date: Tue, 9 Apr 2024 11:23:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't set RO when shutting down f2fs
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Cc: =?UTF-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
References: <20240404195254.556896-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240404195254.556896-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/5 3:52, Jaegeuk Kim wrote:
> Shutdown does not check the error of thaw_super due to readonly, which
> causes a deadlock like below.
> 
> f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
>   - bdev_freeze
>    - freeze_super
>   - f2fs_stop_checkpoint()
>    - f2fs_handle_critical_error                     - sb_start_write
>      - set RO                                         - waiting
>   - bdev_thaw
>    - thaw_super_locked
>      - return -EINVAL, if sb_rdonly()
>   - f2fs_stop_discard_thread
>    -> wait for kthread_stop(discard_thread);
> 
> Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/super.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index df9765b41dac..ba6288e870c5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4135,9 +4135,16 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>   	if (shutdown)
>   		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>   
> -	/* continue filesystem operators if errors=continue */
> -	if (continue_fs || f2fs_readonly(sb))
> +	/*
> +	 * Continue filesystem operators if errors=continue. Should not set
> +	 * RO by shutdown, since RO bypasses thaw_super which can hang the
> +	 * system.
> +	 */
> +	if (continue_fs || f2fs_readonly(sb) ||
> +				reason == STOP_CP_REASON_SHUTDOWN) {
> +		f2fs_warn(sbi, "Stopped filesystem due to readon: %d", reason);
>   		return;

Do we need to set RO after bdev_thaw() in f2fs_do_shutdown()?

Thanks,

> +	}
>   
>   	f2fs_warn(sbi, "Remounting filesystem read-only");
>   	/*

