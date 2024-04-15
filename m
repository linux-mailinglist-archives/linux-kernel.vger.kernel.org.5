Return-Path: <linux-kernel+bounces-144919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A48A4C99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396F21C210CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0635B697;
	Mon, 15 Apr 2024 10:35:35 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCA59155
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177335; cv=none; b=DRnk0BFL65I+8h/VNIYJAhpxEkHc3oRmTLcvu+RpUGn2yhBJ9DUT4F6O1SNxxYMknC6+QTSLyfuOLV01lSl0zjOiixpJ90/f1PwJkLDzTqqY507sNwbBVp3zh3r0zgJjWCakfgl6RcDv4MBXVM3vhbmLttS71sid/3/PaR0RHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177335; c=relaxed/simple;
	bh=i7kl6gVzz/rcqz5Ofjqm0TusNLII/PSkB02AHrTvw4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmd+ySWkeierNvUnxey6vBr1d4gUn6/E7aF+nE6KwzH++D2am4hxAI8tvF3aghXGh1UmgmEGKUootmtXJpwugqz6w8a3LBMPzUeFBYfC6gmCEaGVq1BfpGUUTzDXxicUsbemHK8j5BpGaLH2p4Dla3TibehO8u4o2scl4IK/9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43F9cXf4009055;
	Mon, 15 Apr 2024 18:38:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Mon, 15 Apr 2024 18:38:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43F9cXM1009052
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Apr 2024 18:38:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c5a3598d-16dd-4aeb-904e-2084fafef9fe@I-love.SAKURA.ne.jp>
Date: Mon, 15 Apr 2024 18:38:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
To: Mark Rutland <mark.rutland@arm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk> <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/15 18:02, Mark Rutland wrote:
>   08626a6056aad824 ("arm: Implement thread_struct whitelist for hardened usercopy")
> 
> That commit says that all accesses are bounce-buffered and bypass the check,
> but AFAICT the fpa_set() code hasn't changed since then, so either that was
> wrong or the user_regset_copyin() code has changed.

Then, can we go with https://lkml.kernel.org/r/0b49d91b-511f-449e-b7c3-93b2ccce6c49@I-love.SAKURA.ne.jp ?


