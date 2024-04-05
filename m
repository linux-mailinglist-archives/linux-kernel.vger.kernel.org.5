Return-Path: <linux-kernel+bounces-132918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADA899C06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BB3B21C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FFE16C698;
	Fri,  5 Apr 2024 11:43:14 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB216C44C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317394; cv=none; b=PNudVDL0Jj+m5/CPhxD7LDFSZfGAAGjpMyy9rUmzJeQklGg/OoWlSCLejrLtJFiB471OXyqnWbEFpTnCW3XTFXjgwSC3nnd1kprGFhObGuKKPEl4cQPtdbSMvBQVNDeUjyURL1VnfQ4deG+hintRJkzV33Eaky4mpsHNeVLoZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317394; c=relaxed/simple;
	bh=OYC/BHBrryNr61zuhgQB7gUOSHiQe+sjz+Ihr/W+x4Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IFVwqfzt+AGv2DAhjS6HxENASRA2Sbffle25Gnwi4y4cRBePED1AXsXcG4fWO2Bj2Cc6GuRVBuZLJ6wJ2S+RBulk9bLse2y6eU2SZIWaYzeJXQrUiw8G3KtFyfiGYU/2YM5VFzQtZFHpCXoqlu7C2KM9F5OvO/8j/V8Hx1gi7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 435Bgu6F078881;
	Fri, 5 Apr 2024 20:42:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Fri, 05 Apr 2024 20:42:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 435BguG5078876
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Apr 2024 20:42:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f42ee0ef-8754-4acc-94ea-9574de83c9c9@I-love.SAKURA.ne.jp>
Date: Fri, 5 Apr 2024 20:42:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Kees Cook <keescook@chromium.org>
References: <0000000000004cf5c205faf1c7f3@google.com>
 <1fec6a8b-7083-4b08-858a-0793f996ed52@I-love.SAKURA.ne.jp>
 <aeb26d27-cd0f-4992-b303-f21abeacab21@I-love.SAKURA.ne.jp>
In-Reply-To: <aeb26d27-cd0f-4992-b303-f21abeacab21@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 326864f79d18..0f70a68d730a 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -37,14 +37,11 @@ struct thread_struct {
 	struct debug_info	debug;
 };
 
-/*
- * Everything usercopied to/from thread_struct is statically-sized, so
- * no hardened usercopy whitelist is needed.
- */
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
-	*offset = *size = 0;
+	*offset = offsetof(struct task_struct, thread_info);
+	*size = sizeof(struct thread_info);
 }
 
 #define INIT_THREAD  {	}



