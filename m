Return-Path: <linux-kernel+bounces-110003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FD38858CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78311B22F56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE876038;
	Thu, 21 Mar 2024 12:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Aqknb3oE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873656B68
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022781; cv=none; b=JDR/GpMCvZW1tIeDQinlmeA/4mGeMm4uj6QOn1mR1xuH1eXHw08UBImmLHEg3jPcMs7gyS3udb+KY57EwlftLnzwD0BxqE+r9yO/7njIYk+8raHTDhViybzyFdrv/ChN4gxmTnqkkxsOBzmz0acvDYyzdawB1fQQpYOGUFlb0hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022781; c=relaxed/simple;
	bh=A7RJjWlAGI8CtF0OU7CmXLgv2MrfCPr3PXMxfn9uCMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DI/S91Z2iBTAh2Yg51gWdI8N/6xZEabfbVoVasAHnCsCfwFOpGHo/byDvh2CixoAgPN4so6G76zqT+VAmpOwQImyhK9juKyEDm/log9MrNnc1z2S/xA+X6J2rCIAkEVp1s8AxuizA5QJpvaQq1TaCSn76qHS2i+6IYP4jHzL6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Aqknb3oE reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E54ED40E00B2;
	Thu, 21 Mar 2024 12:06:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bLAo5SHRcaL3; Thu, 21 Mar 2024 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711022761; bh=cRIs5S35iTwQ4qLJwKJGXvbF6pOfrVvqFCP0yOzyOes=;
	h=From:To:Cc:Subject:Date:From;
	b=Aqknb3oEcO8QGYbhiDF+aySV0B5AhjJfbmEAUOGujslJHwKTr51QrH006vdWkz+pI
	 mM1ypTViGEHeKrreS3hLypv/m+YI0AhQYy4AF+4ChL9nPKjzspxFkZUWjMbAHH0kGL
	 u7tsVQMqaFRSShicRYsa4Eqf50wZnfq1emUJwbyW9ZT4mVftsq+a2wegmhZ3vyT5fm
	 Ij9n1oUuqfyE04G/Xo3DxlkZvk4c9e71OuavfN2HxzRRSaUaW+Wrc1yjf3a5NQSJDU
	 WDm/cD4FqjLGaw/vW5qzOCxAcxrgQ0NAxd+sJQHaWjQRWHxCWzQTV9bP79oLxfMKle
	 LCpF5rU9qCxQlzo7qRpN6HS2ik/Y2YBgs2W3jWgN1OqEtg5Exj680/80UEmMw6wQFV
	 4CGJqCYuldP9D5VXCPWzt+WkoX1O1n7t1yC4l8WPpb6nq/IGoOHMdJlPF33+C1LT6R
	 2v4ZM8m1g6Vp7RBdf8NAxdFu+sutI6fAUGbhnc3FxOStVFrowiykZqgKcw2hCS8qU6
	 FHhR50NUrzuZWQEQONpzJEmkbWH4w5FsAlSQFAW2FMse8TnQW7JbS525kokPCm3HB0
	 +LNbkWfyxz4Snzuv6+6KRgyVlrdHh4YtOykPidd9EuG/VtTTzDn6IwgWhHkvMutsjr
	 0gBMIhJIKDwRHeIERvbMxlMQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71E0940E0174;
	Thu, 21 Mar 2024 12:05:58 +0000 (UTC)
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	John Allen <john.allen@amd.com>
Subject: [PATCH 1/2] x86/microcode/AMD: Add a patch revision number union
Date: Thu, 21 Mar 2024 13:05:47 +0100
Message-ID: <20240321120548.22687-1-bp@alien8.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add a structure which will be used to split the Zen generation of
microcode revision numbers into its corresponding elements. This will be
used to match microcode patches a lot easier and obviate the need for
a equivalence table.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: John Allen <john.allen@amd.com>
---
 arch/x86/include/asm/microcode.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/micr=
ocode.h
index 695e569159c1..c1de0a6aefbc 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -47,6 +47,18 @@ struct microcode_intel {
 	unsigned int			bits[];
 };
=20
+union zen_patch_rev {
+	struct {
+		__u32 rev	: 8,
+		      stepping	: 4,
+		      model	: 4,
+		      __resv    : 4,
+		      ext_model	: 4,
+		      ext_fam	: 8;
+	};
+	__u32 ucode_rev;
+};
+
 #define DEFAULT_UCODE_DATASIZE		(2000)
 #define MC_HEADER_SIZE			(sizeof(struct microcode_header_intel))
 #define MC_HEADER_TYPE_MICROCODE	1
--=20
2.43.0


