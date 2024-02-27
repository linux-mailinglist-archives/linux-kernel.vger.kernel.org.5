Return-Path: <linux-kernel+bounces-83435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7F586992F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 024DFB22E98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818E113EFE9;
	Tue, 27 Feb 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GROJXJV6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5411384B7;
	Tue, 27 Feb 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045718; cv=none; b=bGeDqkiyvrH59QdkdbdvjXmSDT4+NLPO3NwdUiHfSUqeEJCBkiepNpzgHyooNCckA0N54XdbOHWz/I4QXwktBuHs1kA28NSY4xfAm/Riyrdqk9Yj2qgovDmOUw30H8Md7Tg/3pnA0kjjM61Ic6fBscilbKfg8EVUW9aOascw6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045718; c=relaxed/simple;
	bh=MrYA11ydrptEowbuZ9sMuc147woy6xuJ/hcpq4qtb0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=moDtMIEYJtq697N+ALhclXw9loMd+N9z402RsPg7crggppbjIW+2Wrnq6NHQ4DmQCK9gq60eeq1pLKFQZjGCGmHQrluDBeI92EajJzk4EMfnK26WfVVbwTVnM+64LRAmNy6l/q4UBLllOZ3Sc57vJ2Hz6044VFhSDWNr27393FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GROJXJV6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709045706; x=1709650506; i=w_armin@gmx.de;
	bh=MrYA11ydrptEowbuZ9sMuc147woy6xuJ/hcpq4qtb0o=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=GROJXJV6thfdkh43yYiA7pMg6bBQOIT85UIY2BBvW8PraCp8lSdVh2HkPBenDk/W
	 /uvBXAk2Ifa3F59oU81IugDQqew4NSWDNheGx1gqXwDilghN9z52Wz1u1DLyO7Nks
	 2JLS9Wg0xELMgi7KO5HSpdQHpSzGkxluC12HgFhgao3jJHCtRyhN90Nda4nMHd1jy
	 j/BQ+Aly9EfDuXasZ2tAaJH0N+9F4LNBV15+U52UYNBeH4OyGwhh0tufCb9xTPI5h
	 YQROsq3dFwBx8zzRhTeNYg1jMNd0lsTG4c1Q0ne/8Vdy2QZtZREsd6GP3goBG0Tn8
	 trZoKtyNx7aQUL9dgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MMofc-1rMCzO1mZI-00Inal; Tue, 27 Feb 2024 15:55:06 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86/amd/pmf: Do not use readl() for policy buffer access
Date: Tue, 27 Feb 2024 15:54:59 +0100
Message-Id: <20240227145500.299683-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8KiUowxFm24zflRHFezo2yJ/cJrOmOMZY/AlS3xfkTVnNy3VTYI
 +ddf09NQGCU6gAYOyOdu/nk3Kf6bSDjeekjJT8paBINFzSi2kIDQDFy4v7hmdAdm1xkrS10
 nUr7QTQ4bB11MfW2BpVnXbmBo3fil38YTEamanCLMeV1c/oHvXPx6tzmA3DpCfKiQGXR4/v
 73uB/UMRQr0gl4KvkoK8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a4bzPwQIcSM=;Eb8EQESCSjhnNAP1ad25UgGA6P6
 b8CyjvkK1xvlXuGq7oXhYdLvjJ7nS6I39M41B/dYxMWP1hUbOguCBF21UfXqMeBjAv1+P6Mi9
 BD6sCqAzPaVkviWaj9AEt+lwz2jaKcy4PLm1bDbdjk665kllTTUSc+sOb6qv/+9u4PE3ECl/B
 rhYeuTb5L9O7P3sc8xyBGYM49S8WPNUsVaD05DuLAcIau/5FIlxsLwaFYLFH0J89b6ClWTb5A
 +Bv+vWOCcerPMMIv3fRO91jem2Jp9kR/9oVgiRksFQlH5dkEydAww+H5l5c2tB0ba2FcEt1dr
 KXMSo/I7BKFEZo6OO4Qb0hNR+jDC+zT6ByEB8DANNp37Hc3EhN4qlZ29yJawsA3UGbC1/Gpon
 yrlYr7cgLM4/gD7ceezsCF/pzgovJx3vjF5J4qNIWKvp3HocBlZaApq54ourw8us1Kz+yPtrL
 NWMzaXslIXCp7ohAfHz91rS7GQTOb9Lmvw1iK+pr2Hw1zrTN6TLQuHQc6SW7jey56AaByJssk
 yK9r+uKWMcyqOSZ/BRSIeqVPiMHNnTliXbxITPDGuUaqVWjTKe8fNxPzW9CUmrC8t3aS8TCiI
 3wAxrRL8S1goLkwgucNcycDsxFWbXkNf/CtO46890G0mkdjJRTHAzOlSi7jNqR69Qll2tZ3af
 5PEUVIXfrEVreyvxUE/ZTiXLAfw6oFJzJQg6nvmM5J5iBv9Vyc6qOaPwFrLmyR6le1vLeow8I
 ce/mcmRDaMUGguGlzZhhak1BMZuX/0l/n4GkM8Qrc1d7Tro0Xb7EvmLbd9y265o3EZRBdg87N
 5GM6JvBI44a+TWTjJ65sB8wVXFT++AsaYCtBMMlif35QU=

The policy buffer is allocated using normal memory allocation
functions, so readl() should not be used on it.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- get the full dword instead of only 8 bits
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 16973bebf55f..b3491268b6a0 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -249,8 +249,8 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_=
dev *dev)
 	u32 cookie, length;
 	int res;

-	cookie =3D readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
-	length =3D readl(dev->policy_buf + POLICY_COOKIE_LEN);
+	cookie =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
+	length =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);

 	if (cookie !=3D POLICY_SIGN_COOKIE || !length)
 		return -EINVAL;
=2D-
2.39.2


