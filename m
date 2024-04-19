Return-Path: <linux-kernel+bounces-151861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38D8AB4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3631C20E84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0AA13B7A7;
	Fri, 19 Apr 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mvx56pSR"
Received: from sonic311-24.consmr.mail.ne1.yahoo.com (sonic311-24.consmr.mail.ne1.yahoo.com [66.163.188.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE8130A5B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550479; cv=none; b=D6iTVuvfBL6fR6HTFNNL0lanP+ehogeYjyzSfB7QJ4dP7juh+pCYA6scN+7GTlHEKegOtpi26E7dnDg0K9V4Rr5qXE24EM//fwOQN75ywRE9q20RgEfpsHaf4qkki2QVAFNy6ijWKEAVD0b77VRux3oSENOnh3SQVOSHq0lo69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550479; c=relaxed/simple;
	bh=blljeHd9x0gxpn93U2C8DaW0yA8kvS6g/Q5C5nSZpfE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version:
	 References; b=QKck1vHKB7MS1HU8qYL85/HfypP2fmyC1xO/XV/Vcn7H9HNmvWDE4PWlPl4OCV1SzqXpExI3JGhshH87r3VmrBHhIS6Dae6MAy3Xkn16mYxBg+4/CMfjZdl4lwOkzKhVlq93WBR9s4pQd8gFsKHxkiyD4XmMlDr5K9W9nCcg4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mvx56pSR; arc=none smtp.client-ip=66.163.188.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713550471; bh=RG/96UbEdQ52BT0k7TkxJ3eNd7aF8qeJn1MJEz+axZc=; h=Subject:From:To:Cc:Date:References:From:Subject:Reply-To; b=mvx56pSRocA3B3RMVerE6cY48cXcoXoZP/St2NzhNRh/sHirQnjKxcKwzvkGwXOhY36c6sKqrbnBZr1zvvtCbsV5LA1b3ipunizXyPRT7f8qPUBkBiW1XbT3Md6UwR5FkA5+V2zJFqNe5CIgYiteWj43Q+ncUhxRpu260M/EVAtZ/VoaMNw1f3l1HvEZl9TThKWHdmPCJMvTDH/q1Sz0jx/9LNdDFmm83t4/9N42ozcDFjt3VXSpndf5J//LobbixzcakBY6cug2IUopN9twKdfhxwGgHsy4qB4T9/gZHzWx2yVrb4Z36JEwUYpe7/txjJeXmcbp4k02XkX2K4NaoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1713550471; bh=GqCDJfJ6uV6yTTZvse16TSVk35ZsiZCSzV2gOcwK+7R=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=kBiHAJ2iM2o/nft0rxVhAmeRUIKUr8HraZ29/lAWdbRY8Hgndkiuyy7bD65EJxHKdvFI6jx48oV/UbfkX1AH5J0ckQMMGE7tYstLcubAPBQaEiGlfjknLZ4FLazJVTXSEZaH+V/LDY8NMB8V2W9ox6H9WcLyUiRISplbU6ksiD8zG+o7o3GPb6ro3BmMKHidwdZQUsFX0AV6RvryVo+UYMPPRQFKZCNQdpiddodyHprrSb77LmPXnnDA+45yy1GdVJhrhmNYpS+nfhzDgeHDCYKsBlG8xwKdWuRhsoT7MffX2d8w4A0+bulzlIRC5O1cq5Fe+xIsS1ux87VZw83iQg==
X-YMail-OSG: e3gt4eoVM1nSYo.FK8LfKpIhGX4b9fecFRCvCnUBSr0WQrciss7EyRTloalubBa
 evlFHT1GrinFRAOhXeHK6yXFR.q8TqByobyZ11NzOg6wwQ0FsTelCw6FtrXZKHuOh09v7T65XcXG
 c93m_oaHdaJOPm89vxLvFrAIMsYH5CbxvKnDvU44_Jl_j_jxQvnh7m37Z_fTR6m54PEkclTr9B9l
 Tw8Q48bda4f4QPNuwjgIyuAQkBd61EEx2qqjEuvCyfHLprAnbdq4KWJrkX09d1xBK1PBcNCLmVDd
 AzCxEwBSoi6y59gfRxqNcjow7Q4g9_.o1Sff4TuTE6nlmRew_kKTsAWsFqgavvtFysIF2gFzNzTC
 XLFfU0JPEw_sG0nYSTRQEv0wDbYayEiKJNnoC.Ms9DcyK5R_jqMYFYA4rHbw2OopW.1M_6JHaUrF
 U5SMAz4oRHdpWvFqdzp7I1A65IQjFOL1QeF2FQO3QeUDvy9nUfQuLFq88RCz4iJIsLl8mtIl9buT
 cE.2BAwy4V7XA1i4jcBmIUMB92KItRoTaR37dmPXoIlWStIG.EOypwwj1eYOYSZNcGBVchYUkMUe
 kDXD2tMq0c_Ho6a82R2Hor8u_CBAkwpVXUY0uVcXEcEN2ej1PGE6BN3DYh97If3nxlqzf8b4sHLc
 aRVacWi9wq7iDDiqURn5l1jcX7wXLzD3hoU5MXntdqZtk.yelaxVh5S6sEpEQdoMdiqLckqANI.f
 YAhcSoK2RMkFIrB69QYqwIdr7k9cl2wvdsznB3SiyZ1T2FVpkg6YdGVNYCjDespEdHvVe10ijW_6
 mRfuSt_IKyawsHyb5xGsOh3x7pLxmZL6iecezqknA9XMyjJzHsdZk7Ra5KcawBnSqLnXZzYpROH4
 3h_Pzq8TK8S4i.qREWgedGl6l.LYZ2Lha_yLgXSWZnLTqp1tALivXx5nxLedBIxXhhFst4cnjSdA
 Wx6YQQt6JZTBA9QtCZtRE02WJdzw8J.5TMQOpI1DT5f847IO9GDw682jYZVs.2VasAp7E54O8In4
 PObCWFYlKVYxLgOmZ0I3rkWwtJmfsPbwsPUHeCajcl5EsU5i._nQKSbKhnDNhH2PInAAVVoo_hvg
 hgloVBRhKwHPi8uoXGWYSfqiXTHFohfNdfYYmkTf5tJOPU5d0D_FyA3W922IwfQBm3T_hBJJ4sew
 qhHbOAwRQ6T58c9lw5o3X7TxxMUJbBcdYHUMvpl1m2G_Xczg5BNyxu8oZAvudKoo7kCBFuGcETCw
 PPttj7ZQmBSLQSAhGho5BWIhKzSLGuXEU7lXp7A74.k99PG0NpKrWbzLVZPffeOtSGzSgLS51dex
 rWderropquae7ISoo51qrxjTTyolWecnHUWPhnP6_tKus_jWP5UXYvqpV2VyRSSkZ9E5eSDHhVAS
 gGFOhPFC.mCGdK671VM0S_riM3ZNY3UbgY.R2GfEx1LqAB2M.bwn068M.6ABKCXkqXQQq2c8rAYX
 GxXaiTUjvV3i_b9W.s_qE._Lh3NAKzCaSJQ.mE8oRcBHjfebbbHbE9clOXHA1QIhYUSPDMVoijyL
 llzYG8.MQv2zbJLOwRceXXJwH5flSChhkpcbKZ_yIwYf6.hQG.YJSdjSJP6EEHdu_6AOhdsiBGUG
 m63ulRslibRTGsZV3wpf.gjA_rWOfhD.nS4S5tG5pv2OAZcccg9brpbgeSI2Idy4T5Z1ufiptbv7
 94.CjaaV7EIxzEGNedmQOn_eaHHSVu8HHNZpusGmWMRDbYSd1QK.UzZd6CFdCzorg.boPTh1bAN_
 8nQqhyUb.MnSQ1xro31c2N2AoM_uNN3DmDEdxuQN3.Fz0fLdKRHCq78yxYI75IbXjbO8JDs1eM_G
 yvCztbZiXrCFzVRtFbZV_7DSR.Y5VN8_hSJBM4ddhFOdnEjhmSlAk_2XANNsBh.AUgmr4dPEemZW
 aK_lCKLjbIqETWwvN8QheQM2c.emmT6bBtXbY7Q4k0ZEcmQ4Vlz7g2qvEPdqS7LaU2dVo4V7O_N.
 HiCv5vUO5a0arvHwIHKlfRaLbizTTfNgx4AWFTcNcNSpZ3nyjgxBC7GdLKO0Uz930ZefL0OONtHj
 zK8Ee9qDnmseHDnodSr9i5NJpSwLUU5tpZzDnn0Yfi8BGNaFaCMD.5HNoR8tt05KuY4gXix2eS1y
 Wt.vx0U696NEOp6FCH1VTVMoGYx3HEKjayiof6oN76uWrGLGPyFNvtAGSY9M3KTz405aOstV_t5Q
 SqM9QJ_7zgjlFnON_5wka2ih2VZS7mMXe4oT4QDlPfGB01oaR9_mjS5JkhfGXEFhWfePTWuVS6MC
 _SnW3Opp0fjXXNM_iRGoMF.5LGjluVfQydZFxg99f
X-Sonic-MF: <ashokemailat@yahoo.com>
X-Sonic-ID: 78246457-ecc3-42ca-977f-d023cbde13c7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 19 Apr 2024 18:14:31 +0000
Received: by hermes--production-bf1-5cc9fc94c8-2vdn9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ee5c49b4a47ca886366b559aa52960a3;
          Fri, 19 Apr 2024 18:04:23 +0000 (UTC)
Message-ID: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel@yahoo.com>
Subject: [PATCH] staging:fbtft:fb_ili9320 Removed redundant Parentheses
From: A <ashokemailat@yahoo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	outreachy@lists.linux.dev
Cc: ashokemailat@yahoo.com
Date: Fri, 19 Apr 2024 11:04:21 -0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel.ref@yahoo.com>
X-Mailer: WebService/1.1.22256 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

From 51e98164e314a2d1d834d2a9baea21a9823650bb Mon Sep 17 00:00:00 2001
From: Ashok Kumar <ashokemailat@yahoo.com>
Date: Fri, 19 Apr 2024 10:32:48 -0700
Subject: [PATCH] staging:fbtft:fb_ili9320 Removed redundant
 Parentheses

Adhere to Linux kernel coding style.
Reported by checkpatch

CHECK: Unnecessary parentheses around 'devcode !=3D 0x0000'
+       if ((devcode !=3D 0x0000) && (devcode !=3D 0x9320))

Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
---
 drivers/staging/fbtft/fb_ili9320.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9320.c
b/drivers/staging/fbtft/fb_ili9320.c
index 0be7c2d51548..409b54cc562e 100644
--- a/drivers/staging/fbtft/fb_ili9320.c
+++ b/drivers/staging/fbtft/fb_ili9320.c
@@ -37,7 +37,7 @@ static int init_display(struct fbtft_par *par)
 	devcode =3D read_devicecode(par);
 	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code:
0x%04X\n",
 		      devcode);
-	if ((devcode !=3D 0x0000) && (devcode !=3D 0x9320))
+	if (devcode !=3D 0x0000 && devcode !=3D 0x9320)
 		dev_warn(par->info->device,
 			 "Unrecognized Device code: 0x%04X (expected
0x9320)\n",
 			devcode);
--=20
2.34.1



