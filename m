Return-Path: <linux-kernel+bounces-144273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDB8A43F7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9942B2811D0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2BF1369A4;
	Sun, 14 Apr 2024 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EK5HXlNs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE3135A46;
	Sun, 14 Apr 2024 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713112610; cv=none; b=uF7RMWsdEKc+g7d4/CMziFYGsHZrQPULZcE86ay+///70hpkuoH8xAsR7GsWlMHQ/mfxyNQaKPvtr852gxXKyvy2Kzgjmf1LsZEXaflXgOb2OqRb15SOx+qqiZGBY5LNi/ePWD1OFN/rq3b/hPjYKhUppV6HpDRCySxn3j5wqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713112610; c=relaxed/simple;
	bh=hnKa56uMP1uBuqcYlrLCoROyDjHVEOMKzsZF5kAUvag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVCnhUzd2Z9wYjnbfivnzJeGO/ZO0yFqK87tdNEUH5ao7i0iorMHsQTRyeM4cbVpcJhuR76WTw8AVK6VFbUcc2NaR107b741H+BxEUTsOeS2rAj30fthNCjBrrhFDDBa2Ia+9oNjyhfDf9H6bJPMKo4vxKoRC4v30CmRQVW5mpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EK5HXlNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445A3C2BD10;
	Sun, 14 Apr 2024 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713112610;
	bh=hnKa56uMP1uBuqcYlrLCoROyDjHVEOMKzsZF5kAUvag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EK5HXlNsWOmG45NXxmpqfEyacm9qOKTm+qh4cjvBjAjuwL56zzZB953sTj0xGM+mr
	 wK1+i83da3/zSyqHOF36apUEV9dcctQ34H5lgvXYZ57u86M2CiTBZJcHXs++xAY1mK
	 bVrMpvgp1i/QrcqycvCYDxxa84P+9+gghc4ncfC9E3bInYoJqXjJcbkMGWIxl2TOmH
	 4pwDaTtI5FmlbauYgmrL8wT7c8bX3ZfWcggNwC9XL+P7rh+0oeNCghaTWCz3GqcR4f
	 DE22/rgK7p57sdJEdHG2kVBCEsyCUcGqTPgjcbKRrFUGfPeKpgOxXZ9V/K6aoWNchS
	 ++g69M6gW+g/g==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 18:36:03 +0200
Subject: [PATCH 05/18] backlight: ili922x: Constify lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-video-backlight-lcd-ops-v1-5-9b37fcbf546a@kernel.org>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=krzk@kernel.org;
 h=from:subject:message-id; bh=hnKa56uMP1uBuqcYlrLCoROyDjHVEOMKzsZF5kAUvag=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHAX3qsL8Hzg65pI/n33WGw1cOHusS9qLWrvz2
 9ysY0cPEgaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwF9wAKCRDBN2bmhouD
 153UD/46OO0GE9u+PnAEwY2y//MxFK/BvQjDKIdN5VeJAxZsJBdtVmM7ek4ABnR9x/8q76Xk2fc
 CEj8VRjGDVJlljjwgajs9mNYJf7ny7+/RR+HDlcdCJu8QsoFIPcci1SR6QOgDXd2Mjg2AVlEfMM
 36fuYootU1898/VrCemeiu/BG1eNfk5OHCpQMDaXLSIdkYb576YfHrKcBsrKfDuJirG/gbuXO0P
 aucq6fITr+Cro/vn7Yluir5g0rE75cNzpZgzaefkADukmZTR/XqcrD57cIsOvjchneaxGmuzDxr
 pKgIr4j2KFBXovrz6aoII9pjENXjr1LJ5OAhAkWZw4aeNhme0euPqJbf9X6E0JjSpdSpl4e3+ku
 PMk12pFjqyC2fNwude2R47V/YqXx8l+a2Ie7QmUDWNZTP5kl5S8H8BNZsgb4MlHBW7cr7ccRDen
 DFCxXQDetnr1lF8vZDZc/oeRfcmBijltAlpPccnyMnyTeGNy+CJJ0fKn78dArOUai5QqUuAwKMF
 MmTi92oynvX5UTLwvBMb4GIuTkWGvTZpxS24k8N8V6+PB9Xl+ACz1ZuiXR9OHp8QGRDYfDQlrmU
 v9PIeNQTPxUUpYkJK6rPfHLk893dCLP06sDEx+ROtOzZpG05SML31DQBFAcJ8UI51ClNVr/d9yT
 p3dT5FwBG/kXSPQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct lcd_ops' is not modified by core backlight code, so it can be
made const for increased code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/video/backlight/ili922x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/ili922x.c b/drivers/video/backlight/ili922x.c
index c8e0e655dc86..7683e209ad6b 100644
--- a/drivers/video/backlight/ili922x.c
+++ b/drivers/video/backlight/ili922x.c
@@ -472,7 +472,7 @@ static int ili922x_get_power(struct lcd_device *ld)
 	return ili->power;
 }
 
-static struct lcd_ops ili922x_ops = {
+static const struct lcd_ops ili922x_ops = {
 	.get_power = ili922x_get_power,
 	.set_power = ili922x_set_power,
 };

-- 
2.34.1


