Return-Path: <linux-kernel+bounces-69433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED68588F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF328198C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21B14E2E5;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs1znpqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A214AD0E;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123022; cv=none; b=UJAriLQXOqVC5qeoF90TMHZI70tvnbp1b1r0C37VdzqJOEOPknYRipbjezV+3uwDKim31MGq6uBC2NWDDuPkmRtpXnb1zYeUf9aob46QgCdsW0Nxlsnqc9Jo7jSoVHyCSI+i+36ikmupDBEQVMpAhyJ+k4yz/VCd4a+kmTxbPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123022; c=relaxed/simple;
	bh=2Rf/qADjPS/HdwZc3ACrJCkDkpnzYWtpsvVoZxBWBCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BArnl8b0JtkqMdHr3A+YTI5NMkBySf5ntIrB1ix/ZjZBnPM00qXrCsQ67XlqlgKZiG/cgK/do1vpPLkYzxTS0yOvRzYXKAN0OBlc9Lh5v4NpsUw+F3mD3nAlaJ3g/A4i7wfJKgTTGKMRk5+GANLvgyHV5yQT5dXBmAyNsSKqxYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs1znpqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEFBC43394;
	Fri, 16 Feb 2024 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=2Rf/qADjPS/HdwZc3ACrJCkDkpnzYWtpsvVoZxBWBCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bs1znpqpO84ZWZbo0UXpQxKqYq8FuCnex9pmQ8pmEZQo3hiV/A7f3XWeeBjk9I2ms
	 jozXqofqcTrIdoZHFbZ0r/NW7Y8kSbyc7gb7lskrlm1pxYELhRfHNXgDtpc/GAXDgx
	 RZPPo/ns1Rjd/kIkhqPpo3tEA+xmzavwAFWuzyFLgHy0KfGSyuS2OE4vXXTL5ruV3z
	 TAxH2KpR4RJQjPJSXEm8xoWnB8ju7A4wBFWNVniPe5V6smQ4DxiyKfF11a91mCX13U
	 8HPNU5i4kzZXs+uCwG0bjBMPhT/LRzP8VdwMkC/v5LQmXzoxVGCNc4ofmC5PftpQDJ
	 jNYqddrSidlcA==
Received: by mercury (Postfix, from userid 1000)
	id B062210633C9; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Yackavage <michaely@ips-yes.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 07/16] dt-bindings: fsl-imx-sdma: fix HDMI audio index
Date: Fri, 16 Feb 2024 23:34:26 +0100
Message-ID: <20240216223654.1312880-8-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDMI Audio has been added to the DT binding documentation with an
incorrect index. DT and the driver use index 26. This happened,
because the binding is missing MULTI_SAI type, which is using
index 25.

Reported-by: Michael Yackavage <michaely@ips-yes.com>
Fixes: 7bdbd87d4008 ("dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
index b95dd8db5a30..37135fa024f9 100644
--- a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -92,7 +92,8 @@ properties:
               description: needs firmware more than ver 2
           - Shared ASRC: 23
           - SAI: 24
-          - HDMI Audio: 25
+          - Multi SAI: 25
+          - HDMI Audio: 26
 
        The third cell: transfer priority ID
          enum:
-- 
2.43.0


