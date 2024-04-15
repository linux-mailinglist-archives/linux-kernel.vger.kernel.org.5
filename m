Return-Path: <linux-kernel+bounces-145332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D4F8A52EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1DA2852D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1667757E1;
	Mon, 15 Apr 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="Kq8Hix0p"
Received: from outbound6.mail.transip.nl (outbound6.mail.transip.nl [136.144.136.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F873175;
	Mon, 15 Apr 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190706; cv=none; b=lpHs7pw221YsYRYAMZbK3XO7RNwzF0WcDSaItLTd54ZeVPdk/S17mdbnxjCYH1ojYZHwYCAb09iuUNku5TdxI7heOGddhbh4FwK3gXQoW9cbIqRBf0pzkKQT9RfwgDez6c0XGN2Wa3l3X1OfI7TH1BeijlABBG60zCLKLoft0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190706; c=relaxed/simple;
	bh=KsjfUPGlpRzaRp0MgK7YOyBeifgjIE37Gi21vj0GW8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NcpcC354fZJfALoI2vjVCp7sh7zxm0f8cmnUNAvDQgPnAvRd/y7BKzvudZGdshlOGJ4G5FqtvuVDSgkMKy19Bqs4V4v6qWIbcPVX4DCf9xePdNtnu25vnb9cxxbZT21ArtDdaYb681//0j7lQlHG2gpqPEOvnCCujGWCIBs6PfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=Kq8Hix0p; arc=none smtp.client-ip=136.144.136.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission6.mail.transip.nl (unknown [10.103.8.157])
	by outbound6.mail.transip.nl (Postfix) with ESMTP id 4VJ8Qy3hCFzwLJF8;
	Mon, 15 Apr 2024 16:18:18 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission6.mail.transip.nl (Postfix) with ESMTPA id 4VJ8Qw0tNWz12Ly6;
	Mon, 15 Apr 2024 16:18:16 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: andersson@kernel.org
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Herman van Hazendonk <github.com@herrie.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: qcom-ssbi: add support for PM8901
Date: Mon, 15 Apr 2024 16:18:13 +0200
Message-Id: <20240415141814.1983384-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission6.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713190696; h=from:subject:to:cc:date:
 mime-version; bh=4LHW9kxjWfO5y9vNvAIQy58sYhzSG2Pz9C7+L2RBBBA=;
 b=Kq8Hix0pHcXXF2GwFOfclW1BS9wkAVu7TL5ChHqO1NzWCPOmyslVdqvOD/bmVWGpJBk/25
 ZXDdSR0Nnla9XLQnTkoi79m3Hgdqyxt+crElakM0Xb3Z47XS7cur4lhFdR1PUFJxR3kaMZ
 lVRmhy5FrP/OMFkpBkiuuEOcLuZk1t75VXM8Q5lhAigF6ks0D3eZbmz2RELdugzVcFhFaC
 o31oEvqBZBdpl2gC86OwoLoVfkCUsm2aXftVCItun6kyNBIkwGWIGyoMpj+r08GYYMVeBA
 zhT5eEkgVE/jA91KGviYAfrrrlxyLX7jz4iIi2RUHbRr1Bti+W2KsykeueMQuA==
X-Report-Abuse-To: abuse@transip.nl

The PM8901 is used alongside the APQ8060/MSM8660 on the APQ8060 Dragonboard
and HP TouchPad. It works the same as all others, so just add the
compatible string for this variant.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 3aee6835a2de..82221d0c813b 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -808,6 +808,7 @@ static const struct of_device_id pm8xxx_mpp_of_match[] = {
 	{ .compatible = "qcom,pm8038-mpp", .data = (void *) 6 },
 	{ .compatible = "qcom,pm8058-mpp", .data = (void *) 12 },
 	{ .compatible = "qcom,pm8821-mpp", .data = (void *) 4 },
+	{ .compatible = "qcom,pm8901-mpp", .data = (void *) 4 },
 	{ .compatible = "qcom,pm8917-mpp", .data = (void *) 10 },
 	{ .compatible = "qcom,pm8921-mpp", .data = (void *) 12 },
 	{ },

