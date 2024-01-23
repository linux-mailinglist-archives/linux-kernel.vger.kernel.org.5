Return-Path: <linux-kernel+bounces-35398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E18839060
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CEFB23808
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B945F54F;
	Tue, 23 Jan 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="J7dIHlxu"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DF5F542
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017451; cv=none; b=lJtt2NgsJ3983NQk0ocuU5eePrO9z7kqYoJZteiOh6WBWBQhBnKbKHqAG8/fWMHm3iLfilv5dQiOFS0uPaVSFhxWd6un4P8/mCxnzJeSmi9IdC/2gWBhWtUY0TBrHrJnshwuaWQRVPh12Mm739RV/CD/lMWJcNAI4v21DDhvwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017451; c=relaxed/simple;
	bh=ExZ4NFkkuHvqMfw5R0w3oCp++semdFNY6lhfSzlIdsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9vHqSiLjKsLbZ21V2/L3BIljkFCLnyB9J7oUz0Oy+lrxfYUdkV4vlmcG5PB9tMSjc3RKICmlBMb5lq6XwZgDEvZsyE9u80+6HUmpXu7KmpX1gCXE1BqoLct/2pkk1X3SSwU0sxaUkhs3Xy5OsqQ/WBtQIwAoBdeGPK3lPqi90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=J7dIHlxu; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 29372 invoked from network); 23 Jan 2024 14:44:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1706017442; bh=SGKrS9LRKzEP5X+pGg5+m7DPAJetrgd1g3M8vKpTTPo=;
          h=From:To:Cc:Subject;
          b=J7dIHlxupngsXkpVgRurup3wTR0762+POm9PoYVX2g1qiT1DVCtwqNhYp1KRGnSCO
           HaBqpwFGbTauYAtmEf6WjE+SiX5lKaT9+NDUSAugiifgVkcTV5OylMH3aTU7b4dPXm
           HvgP5NiIH0WcDD3nSEfUkNpJU6RbizhYOrm5do1k=
Received: from public-gprs378234.centertel.pl (HELO localhost.localdomain) (deweloper@wp.pl@[37.47.108.187])
          (envelope-sender <deweloper@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <tglx@linutronix.de>; 23 Jan 2024 14:44:02 +0100
From: Aleksander Mazur <deweloper@wp.pl>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Matthew Whitehead <tedheadster@gmail.com>
Cc: Aleksander Mazur <deweloper@wp.pl>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/Kconfig: Transmeta Crusoe is cpu family 5, not 6
Date: Tue, 23 Jan 2024 14:43:00 +0100
Message-ID: <20240123134309.1117782-1-deweloper@wp.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <30A7BB83-E44A-4082-B5DE-AB9FBF0AB555@zytor.com>
References: <30A7BB83-E44A-4082-B5DE-AB9FBF0AB555@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-WP-MailID: 8f61489bb4525c394e16f739b86cdb1f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [McPU]                               

The kernel built with MCRUSOE is unbootable on Transmeta Crusoe.
It shows following error message:

> This kernel requires an i686 CPU, but only detected an i586 CPU.
> Unable to boot - please use a kernel appropriate for your CPU.

Fix this by removing MCRUSOE from condition introduced in 25d76ac88821,
effectively changing X86_MINIMUM_CPU_FAMILY back to 5, what matches CPU
family given by CPUID.

Tested on HP t5300.

Fixes: 25d76ac88821 ("x86/Kconfig: Explicitly enumerate i686-class CPUs in Kconfig")
Acked-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Aleksander Mazur <deweloper@wp.pl>
---
 arch/x86/Kconfig.cpu | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index b9224cf2ee4d..2a7279d80460 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -379,7 +379,7 @@ config X86_CMOV
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
-- 
2.43.0


