Return-Path: <linux-kernel+bounces-92283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA6871DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A21A1F2B56D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3980D5B209;
	Tue,  5 Mar 2024 11:31:55 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6459B62
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638314; cv=none; b=TXkGbxU9CF4sLQQFLQbf79bUI26umCNpWjcfZvL18n9M+jIV3xyifsG9ylPRr8RCwFYlF9dbAgwUl2W9QTQESJpgCPyFiXJvOlovnkZxCW6ub6mtouFFTRYU3MkF/nbd6nuoqFUZ1J7acg/ZrqSme8HGu9gsgMO443r36HUhsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638314; c=relaxed/simple;
	bh=Eq7aeNGjONd1fpt7pBZhX1cgNq4mlV4aurE5+rGBSUU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UBO3E6UW6qmkq21eRVaBWBzn14MmR0pbZ2QqFIKkrNczJkXwso0v2ZKLNIHlOFDeJbL+Tk5femM+n1tAXQeybZJ6fK/hDR4fNdvI/VKWcVMPFrox81tMzDEu+tWkLB/DJ58D7pHR6Zg/owGNMq4TuJMEaaimPvdGNhx/5MS1d1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 425BVEM1099162;
	Tue, 5 Mar 2024 20:31:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Tue, 05 Mar 2024 20:31:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 425BVDtT099159
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 5 Mar 2024 20:31:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
Date: Tue, 5 Mar 2024 20:31:13 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
In-Reply-To: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Ping?

This is current top crasher.
I hope this patch is applied before the merge window opens.

On 2024/03/02 7:52, Tetsuo Handa wrote:
> dump_emit_page() caused a false-positive KMSAN warning, for
> memcpy_from_iter_mc() is called via iterate_bvec() by setting "struct
> iov_iter"->copy_mc to true.
> 
> Fallback to memcpy()/copy_user_generic() when KMSAN is enabled.
> 
> Reported-by: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
> Changes in v2:
>   Update description.
> 
>  arch/x86/lib/copy_mc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


