Return-Path: <linux-kernel+bounces-83369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74908695CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6371F2C0D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D4014534E;
	Tue, 27 Feb 2024 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="c0MEvqrL"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E831420B3;
	Tue, 27 Feb 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042714; cv=none; b=INTEF96AEvgIYobPj4csHHaD7Y5NpGz2XlVsxP7vkz/0E223W4knIwjOBMK51rfmK40fHcef4Msn9KMTZ5n4YnKG5kfoBIk5VmNFkPsaiMxnm99CnZRDb/gtVBxizEteAATYdW4/bJus7U8aAV3uQQxRHHvzH03M8RucD1lU0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042714; c=relaxed/simple;
	bh=ROXC9XFT8HNDRbWxYhHY2D/L904usz1YVAl5inJlhGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iaoNciAwzidJ+1OyoG29xYPPSQN2APuChnYf0xfQnBu1LhdeM9I0rnO0PclprcNyA2i6GA/s5Uc/rsrodwwt0XYyXsOQ7GOBaSE7ylG8jWY7KfPT1zXH+bPQTW84bhm7a0y+t3dENjsueeckXJDmO3iPTpbq/YDttlRDLMSFDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=c0MEvqrL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709042702; x=1709647502; i=w_armin@gmx.de;
	bh=ROXC9XFT8HNDRbWxYhHY2D/L904usz1YVAl5inJlhGk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=c0MEvqrLpDu70Jk33JtQbIIL3fUa9sTy35IY8UOIk0VLjsJiCFQVGeXN3L+KyjDs
	 jHkdtbcDSPswuytfPIhzI3ZZyar6B7SgdirnUFc2KTJ/LlDegphMZiPo31ExskrfG
	 LnkvVXZiGy9UWKlVHjMuJ9nzcaN9W29uOSmcgaFXQlGgaSES/eg5oi1KeMQnNLDS7
	 XsueaguuGM59/SXCLgGWbYACaRzL6WFHGtkzgRAu4omW/NCbb/JHoIWWTxwiQbFKp
	 NYV6eDYBZFPXBWhulxRzVCoRj0oyF44lPIyoe/OZQgWYpIeoUMGlmyMTgF4uXZpeb
	 cZjWCctw5NJ8/P1ucw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbAcs-1r3QOs2Sfw-00beWD; Tue, 27 Feb 2024 15:05:02 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86/amd/pmf: Do not use readl() for policy buffer access
Date: Tue, 27 Feb 2024 15:04:59 +0100
Message-Id: <20240227140500.98077-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C6aJtexdwYmUh9Ddv7QlNY/6bRDo3vx1aY3rneKfsYaNVPw/Plg
 JqNWbcFLJ8FcYdUI/IyCq3iNw57NBDmbNi0sSjbbDxopWqLVulKRm8L3fm5LeoMaYGV2Scg
 pTP8/rQGx/T1IqD0k/yZa7g2Ev0bGLyKOFQwJlELfOuoBqZ7nTgK1Pa09uDs7M1EqtYpO0H
 c2QlGTsmkAwpAB1ijInnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:elZWmxoBk8Y=;CxMYko5Aj/lRL5QnnxQnlfAlxNu
 ViGcnuNGRP5uql0hSD4VvVnx7Q4z44KAFVsx3Eb8KnlH3+EP/O8uU3e2d2AW4Q2V2xSpxzE/E
 gyp1wZbVuC/OSt+VgQLvPYfXZnx/rsLXoo4zZQR1LKzjHZmVkSj2+jlPEAorHj9onsmOoOo94
 YV3hmgl2jI1V+8W539C4yovoHGHWq2XRTd/eyVBOxcygpzMjT8feKmxEBUGO2J44WLXFEmdHT
 xBILXLLcAgtIZfMsmZfcti6DsJ+hnCs8n+Ix1Eh3glcvdnlNRR+pCnNt+dkwBU2ZLpqYBEMSI
 Sbb8MrtLZmAX/ydicobnURYz9R2HWfC8bdoiqykPcd/T3tvlq691bNZ87nTRYcjQml85l5BpN
 YlkhhMjjhyZQDbtQJRXBW1YpqscY0L5y/ckH98iu4jlXveFUxyAXu8wSAEbZL8QrcwWYkVl8d
 9dU4s5DCqLO61HhCBRtr9caPDIgH4PDUMCqIuA9fgz2MRAQiv2uuo398ObP535Lxtn6c+TpsI
 vwgQcnEXLKC9EesbuvdLIIeeKmG8XTXH90xp7mzopIpMWz3afT2blRrYZ4qyKHPAQaJmuxOEm
 CRG1SgAU1OHBicVDBShf407zrPsXUo1HjNpa4pYhi8GLc7mnPQQK1xOaXLnUMGrPONdNxvcIm
 HR5WmcMWXoTFfWUC8dUwwj2WuS+v12UjpEByi9MUyjJeCTgAgvJdy32oIPn19Xckyc/wKuwd0
 QpCJPj5S2so4cEKRMEPOUEZNPH3x4frWPkQI9fKgf1dJT9GEj9uWhNC9952msROp8w1rda1pC
 tORionmXDgUl998fi/xgtaVwbapabigUmax82zymLNDro=

The policy buffer is allocated using normal memory allocation
functions, so readl() should not be used on it.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 16973bebf55f..70d09103ab18 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -249,8 +249,8 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_=
dev *dev)
 	u32 cookie, length;
 	int res;

-	cookie =3D readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
-	length =3D readl(dev->policy_buf + POLICY_COOKIE_LEN);
+	cookie =3D dev->policy_buf[POLICY_COOKIE_OFFSET];
+	length =3D dev->policy_buf[POLICY_COOKIE_LEN];

 	if (cookie !=3D POLICY_SIGN_COOKIE || !length)
 		return -EINVAL;
=2D-
2.39.2


