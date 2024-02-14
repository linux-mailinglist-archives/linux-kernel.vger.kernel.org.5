Return-Path: <linux-kernel+bounces-65000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C69A854668
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AA828E9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1B171C9;
	Wed, 14 Feb 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKjmJTUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23150168D9;
	Wed, 14 Feb 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904110; cv=none; b=SFBnDTIdH3pDuAAg65K3HrTfYqP+wm19uwc7+fSLpsKGLiuVhYpUywaFV/R6AlgcgJ3a6j49bcJopM/I8O6qKsk6B1FG8/s8A2/ySh6sHkrP4i/y7CeDjFXXPcQOeoCL+yViI8xdqZXSEvaHUm1LY7RZLRn+8biE1orscyRY4fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904110; c=relaxed/simple;
	bh=+YQjj12fvrN7EjejQqd3eEjgJcWm5h707zbaTCa9ejU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajPFk7snkWzm4NEUqh+2Arg8p+uqq7jwbnJ9LtDd/GDEoUO/S3xC1MqVCuIT0Q+/VJEn7zoNWMo1gv4IrRC6PChmBJ3NrG0WCqhiMMJBMzolZ6sz2E5G0FhH3TLchEarUdrVq2NmQy+l+mItzkNpWGS/5Ifdwqomsh/8nh1VrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKjmJTUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFB8C43394;
	Wed, 14 Feb 2024 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707904110;
	bh=+YQjj12fvrN7EjejQqd3eEjgJcWm5h707zbaTCa9ejU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bKjmJTUQj2yBIN2wpUGr14Yr6l0OUDmUSV8BPyGagMMqITK75ZRI/L4M0OWxneqe+
	 B1bjStVSwuHQKGyN6zj1JMlVsXPmcuk94z8Moli5VgK83vpms+JUt74IMJmbJCf5uo
	 RBMDEv8o7I3h6Ot5OkNgLxVchHYguAjlxYl5v1mTW+R1bQs02jAPYlz4Q/8H4MM97n
	 ijF/gOHMaGObKSnURWyf4vBjfV+7UnfRCGShM0EVIIfY1HKJnMXDB8TM8YMrRNw4/H
	 q0eMuM3Hyt8S5uZ4Ra5Rs4cFIfwNaDtblleUvTMPshOng+4NDTxFpn1nHRgmTx5YAL
	 8+DIS37FicCfQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 14 Feb 2024 11:46:45 +0200
Subject: [PATCH v3 1/5] usb: dwc3-am62: call of_platform_depopulate in
 .remove()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-for-v6-9-am62-usb-errata-3-0-v3-1-147ec5eae18c@kernel.org>
References: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
In-Reply-To: <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: nm@ti.com, r-gunasekaran@ti.com, afd@ti.com, b-liu@ti.com, srk@ti.com, 
 francesco@dolcini.it, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=+YQjj12fvrN7EjejQqd3eEjgJcWm5h707zbaTCa9ejU=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBlzIxm/mKZq8OtOjZItcAd8wThW9h0JFYQc7raM
 yf82a5YMiSJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZcyMZgAKCRDSWmvTvnYw
 k8SPEACEmoUKIWlvznsye4hkR7g9jVgwtch++eLoryntJwaU3XU6RhkzquPaZr/dKLparniV2ON
 0tjnxNu/KtJXw+HbNbtYRskkO9FfXTHQK4n80LmicbxNM7c8BsYyUAHxuc5NdNuGUduQw6Py+jO
 iPGQGc0n7Id1qYQ12lT6WCDq8XV/eAldvo5ovEx1FLSW3Axilp2Z00nrviSIm2kh1T6Gm8bih98
 Bsu8OFgzJTOkMmsXf2o1w/UcyVK+2GSJgW87ccabJSzlH/aAg4rENXhmyJuLDF2v0kOtiHTjF3+
 UsYrcrdHQdD0UIif4BPlAHsXGYwu1ZbnqeUOeHm0WiEUHMNu19Mr4jngVQbVaijhGFFfWVMnGRN
 aZUQmPKtLHiq9lxIlETSmnNHXmx3e63X1nwQuv2wAz/9MoQuqiMYtk+9fKD1bmPK4vWw3FNi3IB
 BP7igbzLcGc7lfJuayfRC0itrRoJCfHY9ovPUtUeFNLgjllr86WB/CH+9jA10C3U4MArTZFkyg0
 CsXBgsB40hAg7m/3iRIsmw/8PmyhcZHLa3HLEmz4uuODi4EJJTm5mbetHBJePv3weM7jLci1Fkv
 ADdu/aHUDcGiiUiXEL4ziWDA0/OrIh7OLfL2mmmIRHmnhuRxUYCpPZ1j0rabcGMq4ufNUKYSCAa
 k2VVCawk/gknC2Q==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

We called of_platform_populate() in .probe() so call the
cleanup function of_platform_depopulate() in .remove().

Get rid of the now unnnecessary dwc3_ti_remove_core().

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changelog:

v3: no change
v2: no change
	https://lore.kernel.org/all/20240205141221.56076-2-rogerq@kernel.org/
v1: https://lore.kernel.org/all/20240201121220.5523-2-rogerq@kernel.org/
---
 drivers/usb/dwc3/dwc3-am62.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 90a587bc29b7..1bfc9e67614f 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -267,21 +267,13 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dwc3_ti_remove_core(struct device *dev, void *c)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-
-	platform_device_unregister(pdev);
-	return 0;
-}
-
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
-	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
+	of_platform_depopulate(dev);
 
 	/* Clear mode valid bit */
 	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);

-- 
2.34.1


