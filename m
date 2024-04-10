Return-Path: <linux-kernel+bounces-137796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26E689E7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C7D1F237A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF0EDE;
	Wed, 10 Apr 2024 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTfyx2fr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75364A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712304; cv=none; b=TWu9kvYV9843TE0D0Q8Cr3R4JPeD7LqCyE1QQznUx0gRgJNE2f3qzXjvIs8szpSf3LxAO7r5bulLza09fDTpxK0VYApp2tI6WKI0+kXeQ0pj2Svf/Js3dewdtB7M2mGjrr7XZIgNwrCowwbR6Koqwqfqz1hq1wInedltXFeN+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712304; c=relaxed/simple;
	bh=Gx9bCHrk1d77GFAb42nNEx6SxHXDuHF529fcfh61eHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tf447yklh/FUDBXTXPlIVPmd+ue0U2z6/m1AmuPySL7kQ3ftNH2fWHHXlMAzeUcvbDe6FFf6cziFKGjaVy559knSI358AKEkINTI98AudC11+ZC9a16WYC4HIE+EggJdoY89kwgWcrnuxa03aRKG1eSZR8Tz1xU+H65k8WZp6lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTfyx2fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF1C433C7;
	Wed, 10 Apr 2024 01:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712712303;
	bh=Gx9bCHrk1d77GFAb42nNEx6SxHXDuHF529fcfh61eHU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DTfyx2frpgj15Wx6eJlg+u5fV/fmpIM4AfEo+DxtWGjhn/Cmt1p05Z5d7JEmvob4u
	 xySbZvEzzSJxd2r7RSDkZqr/UyK9ATc6nZZYTN08boj7i1DyMEyyNCOg2ggc31R4OX
	 sUPivJD17j0XyliKhbyXB4tV6gLcHogm1pEBhgKo1TbDIYEuoa/IXlbWRDn2SWCB5X
	 HobqGPjiUHixyzPY2GFVCh45yHOcnhOCnoZDXL7srypRZIpu7Yw6yCZuEMHatB+6ra
	 1f2HT2dlRBInnMRkCLnAYLhZWM+UAp6vfx4ML+KmQSj6Zm4UMdUapyzmeUQJZ9n5SD
	 Le5G4IC2HgEBA==
Message-ID: <33644d72-e32f-40bf-9d81-b915b509bde9@kernel.org>
Date: Wed, 10 Apr 2024 09:24:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't set RO when shutting down f2fs
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 =?UTF-8?B?TGlnaHQgSHNpZWggKOisneaYjueHiCk=?= <Light.Hsieh@mediatek.com>
References: <20240404195254.556896-1-jaegeuk@kernel.org>
 <2c195fee-c71c-4e44-b24f-9880b3c1b6c4@kernel.org>
 <ZhVrJh3rackEiIfL@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZhVrJh3rackEiIfL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/10 0:21, Jaegeuk Kim wrote:
> On 04/09, Chao Yu wrote:
>> On 2024/4/5 3:52, Jaegeuk Kim wrote:
>>> Shutdown does not check the error of thaw_super due to readonly, which
>>> causes a deadlock like below.
>>>
>>> f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
>>>    - bdev_freeze
>>>     - freeze_super
>>>    - f2fs_stop_checkpoint()
>>>     - f2fs_handle_critical_error                     - sb_start_write
>>>       - set RO                                         - waiting
>>>    - bdev_thaw
>>>     - thaw_super_locked
>>>       - return -EINVAL, if sb_rdonly()
>>>    - f2fs_stop_discard_thread
>>>     -> wait for kthread_stop(discard_thread);
>>>
>>> Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/super.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index df9765b41dac..ba6288e870c5 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -4135,9 +4135,16 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>>>    	if (shutdown)
>>>    		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>> -	/* continue filesystem operators if errors=continue */
>>> -	if (continue_fs || f2fs_readonly(sb))
>>> +	/*
>>> +	 * Continue filesystem operators if errors=continue. Should not set
>>> +	 * RO by shutdown, since RO bypasses thaw_super which can hang the
>>> +	 * system.
>>> +	 */
>>> +	if (continue_fs || f2fs_readonly(sb) ||
>>> +				reason == STOP_CP_REASON_SHUTDOWN) {
>>> +		f2fs_warn(sbi, "Stopped filesystem due to readon: %d", reason);
>>>    		return;
>>
>> Do we need to set RO after bdev_thaw() in f2fs_do_shutdown()?
> 
> IIRC, shutdown doesn't need to set RO as we stopped the checkpoint.
> I'm more concerned on any side effect caused by this RO change.

Okay, I just wonder whether we need to follow semantics of errors=remount-ro
semantics, but it looks fine since shutdown operation simulated by ioctl
could not be treated as an inner critical error,

errors=%s                Specify f2fs behavior on critical errors. This supports modes:
                          "panic", "continue" and "remount-ro", respectively, trigger
                          panic immediately, continue without doing anything, and remount
                          the partition in read-only mode. By default it uses "continue"
                          mode.

Also, it keeps the behavior consistent w/ what we do for errors=panic case.

	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC &&
				!shutdown && !system_going_down() &&
				^^^^^^^^^
				!is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
		panic("F2FS-fs (device %s): panic forced after error\n",
							sb->s_id);

Thanks,

> 
>>
>> Thanks,
>>
>>> +	}
>>>    	f2fs_warn(sbi, "Remounting filesystem read-only");
>>>    	/*

