Return-Path: <linux-kernel+bounces-79966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187A862909
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29DC51C20C41
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD027476;
	Sun, 25 Feb 2024 03:59:44 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D06110
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708833584; cv=none; b=eenlE/Asj/kCMeHSOQuD7lfnMjpxLNKv/6EiaD/qbg684K3g5Pm4QT9P8gQWoIF+ALlex90LxtNE9Zg6iIc2hwdXdGRlygbzV8i12rmm6FS3JamKGaD2C9RjTA1Fl4xl0efjILLAbPD5rSjrPRYXZb/Xzi0mzFwyRjcs9Eokzqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708833584; c=relaxed/simple;
	bh=MUsdO6w7ERvP2PkLq4b3h828tT6GKDziyED4AzcUEJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GVXr9YKho/rIRD+6L5H16370SK65lvqbKrJo3fgspBDJ97T8tMsCj2ulY1+1iBh56prxhAGcspc1LUTjJXgoUM9VishISI5Mx5zHHB1ZD8cm6sGsqhvfNACDFuPEp6OiPtbm6eznGAWEXmfOWz9cI3ddNG13KzdZ3xovBJA1Xdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3652275e581so19635695ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 19:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708833582; x=1709438382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cg4O/UrkhasJYvwgjNZJ6K6JARSDn+LYxb+PQ32Q3I=;
        b=dkdlbl0QkL4AjzXom6/Q0HkfV4+yqdG4sDpBY7zv+sKcWghDLrVeYv2RgVEPUBt5CV
         K3V2yhKIKj3sZNhRCQvmoAjgKqtENj3Zvwq5lRPMEk3UFHAqdqQAqDFf0Fwlf5+MyFer
         YotBaHiunDSfWXY+wUWznCEntZUf2UGXVGT7Z+f4sj0GG5NSgfoklDi2BlMKoNML23Q1
         veStl/STys7Fcz+mPxfQIJ0dy85IOMeFYCtd+b3Bz+8b1NyVDwZ4XIngk88AvIxuz/p/
         INx8Jv9scZ5ICxuwfXo44UF3qe8pKwpqaIB2smJAGdWlxKOl8fI6P1/YPb9rRlj/J/cw
         aZlg==
X-Gm-Message-State: AOJu0Yzb+4R53Y2Fj8g28EGu3erbvHA9EtkqS69Fb1PlmM/y1pJE6XS0
	gBDn++9IiLEuScShlrwYeryLq3uEIBIq135EqV8MQ6XWGYqBS95/SIfF9w7VDsj2fBM5+WEhymB
	+EAaRxBUpUtTWbmSngRLeGHCbvJydNRQiFg1WWaeLLoQliz24NeMbuEohxA==
X-Google-Smtp-Source: AGHT+IFaIcgPNhoH5vx+m4lcsKPx+gR3Tdm4UkceB/ydTgFuCPeNNGAP47cABHty2xriHNnA6ii/Wwn8i7r4PZ1gysO7Zrm2enXv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ec:b0:365:3088:eae6 with SMTP id
 q12-20020a056e0220ec00b003653088eae6mr323765ilv.6.1708833581902; Sat, 24 Feb
 2024 19:59:41 -0800 (PST)
Date: Sat, 24 Feb 2024 19:59:41 -0800
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1340206122cd249@google.com>
Subject: Re: [syzbot] Re: [syzbot] [virtualization?] KMSAN: uninit-value in
 virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
Author: penguin-kernel@i-love.sakura.ne.jp

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7

syzbot is reporting a false-positive KMSAN warning upon coredump, for
dump_emit_page() path reaches memcpy_from_iter_mc() via iterate_bvec()
by setting "struct iov_iter"->copy_mc to true.

Make arch/x86/lib/copy_mc.c not to call arch/x86/lib/copy_mc_64.S
when KMSAN is enabled.

Reported-by: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
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



