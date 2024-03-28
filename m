Return-Path: <linux-kernel+bounces-122524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301C88F910
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97068B251D8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3880052F6D;
	Thu, 28 Mar 2024 07:45:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F722EF3;
	Thu, 28 Mar 2024 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611952; cv=none; b=X44ooSORAI8j5jmjEgLc5B6wtpMWaXEtuvQQsQm10OAqNlpEGXoYINtOhO8b1/eIfuzyrg3/iDQlzZ4Ot6wVH/XDMTOn8CZgw35VfPAhR1jFspq/HzS12Vx5n0blx57eT23TJkGJaGWwPtnWqRp0pcpfDzNHkIqNAcEsciNF28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611952; c=relaxed/simple;
	bh=BQQm0MwYZwtUPVAMQWA4zVgpFyYCNsyn0Og5MTeZSH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FpDDn3t5UgFhybTUjvtqIQ6WQT/4scqKadKCNTSIQYVXwUuR187nDcG6L5LHfbpgvgcr3899ss7ipjspiMyPAoYUmzPmC7cGJs7oDWZ756ltEEeVqRec/tw7b3NLKxVbj/Hckhk9mdD7lROsS9mlqwTo4at3j0y+oPWQ9pqmedU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CF0C433C7;
	Thu, 28 Mar 2024 07:45:48 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: pm6150: correct Type-C compatible
Date: Thu, 28 Mar 2024 08:45:44 +0100
Message-Id: <20240328074544.5076-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first part of the compatible of Type-C node misses ending quote,
thus we have one long compatible consisting of two compatible strings
leading to dtbs_check warnings:

  sc7180-idp.dtb: usb-vbus-regulator@1100: compatible:0: 'qcom,pm6150-vbus-reg,\n qcom,pm8150b-vbus-reg' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\-._/]+$'
  sc7180-idp.dtb: /soc@0/spmi@c440000/pmic@0/usb-vbus-regulator@1100: failed to match any schema with compatible: ['qcom,pm6150-vbus-reg,\n          qcom,pm8150b-vbus-reg']

Reported-by: Rob Herring <robh@kernel.org>
Fixes: f81c2f01cad6 ("arm64: dts: qcom: pm6150: define USB-C related blocks")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 11158c2bd524..b20a639cddf3 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -71,8 +71,8 @@ pm6150_vbus: usb-vbus-regulator@1100 {
 		};
 
 		pm6150_typec: typec@1500 {
-			compatible = "qcom,pm6150-typec,
-				      qcom,pm8150b-typec";
+			compatible = "qcom,pm6150-typec",
+				     "qcom,pm8150b-typec";
 			reg = <0x1500>, <0x1700>;
 			interrupts = <0x0 0x15 0x00 IRQ_TYPE_EDGE_RISING>,
 				     <0x0 0x15 0x01 IRQ_TYPE_EDGE_BOTH>,
-- 
2.34.1


