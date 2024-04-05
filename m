Return-Path: <linux-kernel+bounces-133153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D87899FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2278282FFB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D4D16EBFF;
	Fri,  5 Apr 2024 14:28:56 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6716EC02
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327336; cv=none; b=CMkJepTU64kUi5MI5fp+WgMCucEuSOhwoclqEqbfPd9miRHPSIduFYpWqeGSoSH7ugwJ3SpDsWrvCx4VRnLAYCHltpvyMgmTCkSsjVSxLeLi+9cvvCR64hvpz3WKFbqzmiMXVFLsQqhyWKAApn09vVj/8TKNJ/ow6AOnEODKvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327336; c=relaxed/simple;
	bh=ZKPxNyJ/POC7lEeU2rV6nn5Qm8glSbPgLQjlLHnJ+L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqhZhKf3QJu4MJ4EYZCMJVtp0iKtpiZ6ceUonvR+t3HZieMWFLBisH16WNMoqVWet9JUoiu4h7rhxTx8rWUh02eSRF33771anhwqsQcJyDYoxtJbxqtYFbdboj6/RPwjuVXwyRHJQgaoXNI3OSoIi8i4Vj+mXUn323QQvRrIng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 435ESKvB018214;
	Fri, 5 Apr 2024 23:28:21 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Fri, 05 Apr 2024 23:28:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 435ESKSm018210
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Apr 2024 23:28:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0b49d91b-511f-449e-b7c3-93b2ccce6c49@I-love.SAKURA.ne.jp>
Date: Fri, 5 Apr 2024 23:28:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/04 1:12, Russell King (Oracle) wrote:
> Therefore, there is _no way_ for fpa_set() to overwrite anything
> outside of thread_info->fpstate, because sizeof(struct user_fp)
> is smaller than sizeof(thread->fpstate).
> 
> Syzbot appears to be wrong in this instance.
> 

Thanks for clarification.

I came to suspect that commit 08626a6056aa ("arm: Implement thread_struct
whitelist for hardened usercopy") missed that ptrace(PTRACE_SETFPREGS)
needs to declare a usercopy whitelist. It seems to me that
https://syzkaller.appspot.com/text?tag=Patch&x=14c42099180000 can fix
this problem, but I'm not sure whether this is safe/correct. Can you check?


