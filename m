Return-Path: <linux-kernel+bounces-92191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE944871C86
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53841F26351
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04FF22097;
	Tue,  5 Mar 2024 10:55:56 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38B1DDF4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636156; cv=none; b=dnS3r+UuVbSuKjThMrTo+g1n3izbapsUIab2+BPqHCHcqayJbB0GXxZvsJ8N8fRS6nco5iKC6+58UGDFFdm8fNYUYb3+B3QVW1415n0jTwJk7I212j7CYxxeNBRlIvx68yjCrtoYdUIJIfwqyV4kekSZjA3ZWMUk2MZDAZ8vH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636156; c=relaxed/simple;
	bh=psG4RFtCydwdXA85upU/kataFifVqreazrTjPoPV2/g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=c+xe40z94b7y1H3MaAt2hsM8x2umWd+dIhCWjPUMQANuKf8LEzQQSfnbkfhJD87jfkjP2P6L3ll+X95PveaXF4AkJUO9W78YdTb2XMUUx7T5jcK1AzK2eCWlD77W3+dkzq2lyWrA0KY37+iIQcn1C1LiSMMBikCuvwP5XDbUlLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 425Atj1w090055;
	Tue, 5 Mar 2024 19:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Tue, 05 Mar 2024 19:55:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 425AtjbA090052
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 5 Mar 2024 19:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <aeb26d27-cd0f-4992-b303-f21abeacab21@I-love.SAKURA.ne.jp>
Date: Tue, 5 Mar 2024 19:55:45 +0900
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
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004cf5c205faf1c7f3@google.com>
 <1fec6a8b-7083-4b08-858a-0793f996ed52@I-love.SAKURA.ne.jp>
In-Reply-To: <1fec6a8b-7083-4b08-858a-0793f996ed52@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index c421a899fc84..b47e56a87dfa 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -573,8 +573,10 @@ static int fpa_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   struct membuf to)
 {
-	return membuf_write(&to, &task_thread_info(target)->fpstate,
-				 sizeof(struct user_fp));
+	struct thread_info *thread = task_thread_info(target);
+
+	return membuf_write(&to, &thread->fpstate,
+				 sizeof(thread->fpstate));
 }
 
 static int fpa_set(struct task_struct *target,
@@ -586,7 +588,7 @@ static int fpa_set(struct task_struct *target,
 
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 		&thread->fpstate,
-		0, sizeof(struct user_fp));
+		0, sizeof(thread->fpstate));
 }
 
 #ifdef CONFIG_VFP
@@ -690,7 +692,7 @@ static const struct user_regset arm_regsets[] = {
 		 * of sizes, so pretend that the registers are word-sized:
 		 */
 		.core_note_type = NT_PRFPREG,
-		.n = sizeof(struct user_fp) / sizeof(u32),
+		.n = sizeof(union fp_state) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
 		.regset_get = fpa_get,



