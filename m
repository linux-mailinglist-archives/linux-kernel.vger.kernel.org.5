Return-Path: <linux-kernel+bounces-145350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CA68A538B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5761A1C21670
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30C1757EA;
	Mon, 15 Apr 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="h5atUVqF"
Received: from outbound11.mail.transip.nl (outbound11.mail.transip.nl [136.144.136.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9F78685;
	Mon, 15 Apr 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191238; cv=none; b=BrvkBTtvm/5nfPFPr0waFz/9N2c7VD0tV+4K+uILws0wpuAynhuwqHPcDWnOGvRuUamR7jPG+i/GOMl1i/MIdglWJ6amPAS1iafozWsdpsJHwV2To5XxfHMEYh6QclivloYcTGBnz/gz5nXiUi1KxWIn+tj07Ln34xK10AROmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191238; c=relaxed/simple;
	bh=SHKa031b3gssZAFMARLpJsBsZfy5fESYEginTqV3/ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgea8RMH2tesNB1aCDnvv/w275oeCOU98KXux0RrG+q1popR+eWHMsAOdXL6Ak3N0DVDRtcIo37qheYFC6bRNztLV7+XtxNURYCCRGa+5BxW1CUEdlMVjn07H5AWWZ5E2tZlIKUNab9ty78vxl1wdPxH1TYe6DeV5TukhOpg9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=h5atUVqF; arc=none smtp.client-ip=136.144.136.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission10.mail.transip.nl (unknown [10.103.8.161])
	by outbound11.mail.transip.nl (Postfix) with ESMTP id 4VJ8QP5nM7zkQP07;
	Mon, 15 Apr 2024 16:17:49 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission10.mail.transip.nl (Postfix) with ESMTPA id 4VJ8QK5yFzz1gwrT;
	Mon, 15 Apr 2024 16:17:45 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: andersson@kernel.org
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Herman van Hazendonk <github.com@herrie.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: qcom-ssbi: add support for PM8901
Date: Mon, 15 Apr 2024 16:17:43 +0200
Message-Id: <20240415141743.1983350-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission10.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713190666; h=from:subject:to:cc:date:
 mime-version; bh=j8qU9SmIWp5C34F+ofmR8Pu30Ccwt3X51g+H9Nuh7A4=;
 b=h5atUVqF1ARXA1ZT9Ta/tETSzL+MoTcyHRQeRFsqk23K87LfdSaVsRrwrp2I65Z8nCC+ln
 pYXLUxSU3ExKYW+RW6KhVKbMpXWUJCWNJ51HH78uzXclUTxYydg2OVmkUcIchAfRzgLqfx
 MXDTM6ZIVcS4IyvVah2XmIVOo4LARZblOea3tkQuM/Ii42EQ1T6U+Z44OyZGtFkQ3Eg6r7
 zJVBUaVqqtTEwxdbRDmu3bJ9lKGjz6clNAhQmHuTGcGl1Apvpzq30cI661QEuYcKrnOEuj
 Vr0YU6g2c8a2gObJV1o6MnMS/xncSoYimoYtO37zjNvXhi0dOCem36aS8mKW+A==
X-Report-Abuse-To: abuse@transip.nl

The PM8901 is used alongside the APQ8060/MSM8660 on the APQ8060 Dragonboard
and HP TouchPad. It works the same as all others, so just add the
compatible string for this variant.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index fe717d8d4798..43146709e204 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,pm8038-mpp
               - qcom,pm8058-mpp
               - qcom,pm8821-mpp
+              - qcom,pm8901-mpp
               - qcom,pm8917-mpp
               - qcom,pm8921-mpp
           - const: qcom,ssbi-mpp

