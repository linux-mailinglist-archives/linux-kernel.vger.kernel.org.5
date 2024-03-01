Return-Path: <linux-kernel+bounces-88973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA4486E8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674171F26D38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B63FB0D;
	Fri,  1 Mar 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G5KnqcSv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C933EA90
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319405; cv=none; b=W9NqyJ8eNWw7vfnnGea19rm+Dbe7ZFJThHTkP+XLYN9gsYlePMisurfU7zfp8Q4erFJ9W+RybFUI18SuXL2mHq9a0473T1CwtHD/1fVhJeDo2oCI7cX2PsfZruQbFpKnBzaVqu9c84GBuLm+G0hLzkF0FsRdcdAnlUkCpSNxVAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319405; c=relaxed/simple;
	bh=TfcfErpuT6t/nH9b4l53LwwZsv95+LrrGJa3N4lUvOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMoR/2VbcyEgN6hRE4wjFalAXEfK4fqRhV8fl6UdZaquudb0CX7BplSOA4WEBHcnirQFUnUa4+/BpBVQpgxVtQbR9OSdfcpstlouTaFs0gR+Wlb9sJDSVRvIlbEs4irZGw6YbQBv4ifoFh3tkhavixGOHoWYk1KCAbPWdGSrntM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G5KnqcSv reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2EDB640E0185;
	Fri,  1 Mar 2024 18:56:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KvZZqETTfLv7; Fri,  1 Mar 2024 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709319398; bh=/WQ87890KHEPpK3lVDVLOKrC8uxI03kb24WeEwvSTNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5KnqcSvp3UKf77rC9RFyaG1IliKafm7uUCpqaVp7D+RP5RotbtDeghd4Zh1djaa1
	 y8aQ7oZvUC8OV7NykSK3oWy810kyME/1fZXjZ+Ce7fieGpttZqnNpEEyfVxq/i3mmz
	 3a6yWY1L2OQhUk3UGiURYKiVmYSRcALe6wSOCBhE6DrvwnWbcB5Hmui/A+kPhkIkzC
	 eoUBvUhrB7Qrbl3OJ1M8ThrOaUbO4fMSVciV3VVPPPY6LiItKHorUPOY1OxUmjDfcK
	 +6aZhjfijjiyqxtDfdSIVBYlYAlRqUEqbQ5J9Cko0FIWc6MqK+b7mbyOvYu/4H1XAm
	 7AbSbIuW+HrlZenwQDrCnlil75hp+hNNqtMYIGz+V6swvWjFCQ5CsZoTIvCvjnt7dj
	 71gO0TKvZrojVit3Zet/6N0S/EvmXDEsH8Q6YlZHpbwImdf30zN8cQJPEuQa9X0FPy
	 ssdkaULYfUsxFywQJo7IZ0YnwOnW7ivKe7N0RDyY0ZLo/Q76oOzu+fN/cmROIagfOw
	 ttExE4HQGCKArrH+Gs/I88PQlmbi5qzlOyao6UgZ4dunREw88iDOVw6puYgQCqg8WH
	 n1wgrrXPLKetCa/uNTVBD0bcNUtE2bs/lEsDgp2F7HxSKsiNfjJKt9gtzLLIf9+FEe
	 KoPoI5g6etZqPxU5UJw5tTgM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D93CC40E00B2;
	Fri,  1 Mar 2024 18:56:35 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/2] Revert "x86/boot: Add xloadflags bits to check for 5-level paging support"
Date: Fri,  1 Mar 2024 19:56:18 +0100
Message-ID: <20240301185618.19663-3-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240301185618.19663-1-bp@alien8.de>
References: <20240301185618.19663-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

This reverts commit f2d08c5d3bcf3f7ef788af122b57a919efa1e9d0.

This whole dynamic switching support is silly. I don't see a use case
where one would use an old kernel with CONFIG_X86_5LEVEL disabled to
kexec into. I.e., you use pretty much the same kernel.

But I'm open to corrections.

Commit message of

  f2d08c5d3bcf ("x86/boot: Add xloadflags bits to check for 5-level pagin=
g support")

claims:

    The flags will be used by the kernel kexec subsystem and the userspac=
e
    kexec tools.

but they're nowhere to be found in kexec tools:

  [ ~/src/kexec-tools> git describe
  v2.0.28-4-g6ee2ac1bf739
  [ ~/src/kexec-tools> git grep XLF_5LEVEL
  [ ~/src/kexec-tools>

Zap it all.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/header.S                | 12 +-----------
 arch/x86/include/uapi/asm/bootparam.h |  2 --
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index a1bbedd989e4..0f261224acef 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -364,17 +364,7 @@ xloadflags:
 # define XLF4 0
 #endif
=20
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_X86_5LEVEL
-#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
-#else
-#define XLF56 XLF_5LEVEL
-#endif
-#else
-#define XLF56 0
-#endif
-
-			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56
+			.word XLF0 | XLF1 | XLF23 | XLF4
=20
 cmdline_size:   .long   COMMAND_LINE_SIZE-1     #length of the command l=
ine,
                                                 #added with boot protoco=
l
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uap=
i/asm/bootparam.h
index 4a38e7917756..b53b524f6ed2 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -22,8 +22,6 @@
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
 #define XLF_EFI_KEXEC			(1<<4)
-#define XLF_5LEVEL			(1<<5)
-#define XLF_5LEVEL_ENABLED		(1<<6)
=20
 #ifndef __ASSEMBLY__
=20
--=20
2.43.0


