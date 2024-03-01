Return-Path: <linux-kernel+bounces-89208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C586EC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BA01C21E05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982525EE6A;
	Fri,  1 Mar 2024 22:52:55 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEDB58ABA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333575; cv=none; b=Ywv5BUSGNVqyo74YIh86JCyzM2WwxnKGllEBJMItNsn5Zigjdj6AMnIc3quV68jU3091I9gla4gYnPolwCgQXINtQSajlEFZhuL+t549CSCuoam4hcZ75ivrx4lwo7MmALhv4k0ZJ5vzFYLlFIM+uM26b0Sik9x3FWLuYeNdUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333575; c=relaxed/simple;
	bh=h7u+V/a49gDC3kOpBKD2JWBdLjdDqCdnslQEF8xrLYA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MLQBWzO/XKNfB/66QIbK8k4sUcdKCOP3cet7eaS0hE2mSxv1BMh0yqwD9gcPa9vKnQJe+Mv11vYvlGfyJIb1XHLxO2ZhUeRpcd6s4gpE5K1yB6qlk5lPrhZKLiL1m2fahwl/+31sbBTR4oaNtlqmUtG16qdIWpyP4jqUhpom4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 421MqM1A094475;
	Sat, 2 Mar 2024 07:52:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sat, 02 Mar 2024 07:52:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 421MqMRc094468
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 2 Mar 2024 07:52:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
Date: Sat, 2 Mar 2024 07:52:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

dump_emit_page() caused a false-positive KMSAN warning, for
memcpy_from_iter_mc() is called via iterate_bvec() by setting "struct
iov_iter"->copy_mc to true.

Fallback to memcpy()/copy_user_generic() when KMSAN is enabled.

Reported-by: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
---
Changes in v2:
  Update description.

 arch/x86/lib/copy_mc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 6e8b7e600def..c6a0b8dbf58d 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -61,9 +61,9 @@ unsigned long copy_mc_enhanced_fast_string(void *dst, const void *src, unsigned
  */
 unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigned len)
 {
-	if (copy_mc_fragile_enabled)
+	if (!IS_ENABLED(CONFIG_KMSAN) && copy_mc_fragile_enabled)
 		return copy_mc_fragile(dst, src, len);
-	if (static_cpu_has(X86_FEATURE_ERMS))
+	if (!IS_ENABLED(CONFIG_KMSAN) && static_cpu_has(X86_FEATURE_ERMS))
 		return copy_mc_enhanced_fast_string(dst, src, len);
 	memcpy(dst, src, len);
 	return 0;
@@ -74,14 +74,14 @@ unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, un
 {
 	unsigned long ret;
 
-	if (copy_mc_fragile_enabled) {
+	if (!IS_ENABLED(CONFIG_KMSAN) && copy_mc_fragile_enabled) {
 		__uaccess_begin();
 		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
-	if (static_cpu_has(X86_FEATURE_ERMS)) {
+	if (!IS_ENABLED(CONFIG_KMSAN) && static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
 		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
-- 
2.34.1

