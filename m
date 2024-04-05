Return-Path: <linux-kernel+bounces-133104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0E3899EE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE4284140
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E116DEB9;
	Fri,  5 Apr 2024 14:02:21 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CB16D32D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325741; cv=none; b=BIPRieUZUqzQlSGfucmnk/a3VCuk8m1yuf3zfRsWVr+IOONuAZNFeiPmExFzHERsQslZgRJxCZSqzNHL7kRhFtO3FLXu+5f72UVMsZwg/LwS1r5gdP/4P0aWMGArJgnByaDGyYGoohBCrduB7eyhF5CPrnO2Ief6v9vOCbZzdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325741; c=relaxed/simple;
	bh=9AmGGy1+OYUQuSHOnG2dQOkuvK2E3pExzjH3QuzmLj0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=g9jZGwkpfH4NbAF4irCavWvedTOmJp/J7UBAIbW5ZVwaTNPb3b+jxtzzrcY8cCqapdX5gfZmQWZ8RfNhN4TZXTgn7BFWmzlU04iJ4ycOOMeCMksfatt617uodl/6NgwhlK1lWdhH6ZPBqrJHfAle1dG2vWiqwe91mrVViKtY2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 435E28IJ013713;
	Fri, 5 Apr 2024 23:02:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Fri, 05 Apr 2024 23:02:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 435E28Oo013710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 5 Apr 2024 23:02:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cb6d724f-7afb-44c6-835c-6c8c229b70a0@I-love.SAKURA.ne.jp>
Date: Fri, 5 Apr 2024 23:02:05 +0900
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
 <f42ee0ef-8754-4acc-94ea-9574de83c9c9@I-love.SAKURA.ne.jp>
In-Reply-To: <f42ee0ef-8754-4acc-94ea-9574de83c9c9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84..347611ae762f 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -583,10 +583,15 @@ static int fpa_set(struct task_struct *target,
 		   const void *kbuf, const void __user *ubuf)
 {
 	struct thread_info *thread = task_thread_info(target);
+	const unsigned int pos0 = pos;
+	char buf[sizeof(struct user_fp)];
+	int ret;
 
-	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-		&thread->fpstate,
-		0, sizeof(struct user_fp));
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 buf, 0, sizeof(struct user_fp));
+	if (!ret)
+		memcpy(&thread->fpstate, buf, pos - pos0);
+	return ret;
 }
 
 #ifdef CONFIG_VFP



