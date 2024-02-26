Return-Path: <linux-kernel+bounces-82344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92E86830D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753081F2308A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2097F1332AE;
	Mon, 26 Feb 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgkyYwYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE0133280;
	Mon, 26 Feb 2024 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982869; cv=none; b=U+Qtzk2GZmqrftAEX0EZbpsCc9daexKmJb29Wnm1ncPU+E/ALvCBBRQyoaYEXgfmslro49aVRG8PeDncvhQvsKNtAnleGVQH4Pw5HiMZziFloN/L90/2G5wncPqzknYaDttDU3ujcGdne4sP9adqDDLSwIhNSHnxlgNRLzHRsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982869; c=relaxed/simple;
	bh=2Rf/qADjPS/HdwZc3ACrJCkDkpnzYWtpsvVoZxBWBCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN+oO1ks9XS+dOR8G4iEZwINzpnIoxiEmaJKBZvE3F5sdBExRD04KLkWyDMnQ7+E8VBUEKJnQJp/iX0zOZx/QApNTRDyLdPclxSDcZVru/ZCtFPeeI1ns2r+LOO309rrRw8rbgf4VQljQhifoztXpPD6u5jCsBs5qROMRFnyCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgkyYwYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E338DC43601;
	Mon, 26 Feb 2024 21:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982869;
	bh=2Rf/qADjPS/HdwZc3ACrJCkDkpnzYWtpsvVoZxBWBCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgkyYwYaB6UD0+pYwkj6qc4isNvozuTcPx7hT3fwmofG2vysO6UVHpjMxN+hqVUVV
	 YUJg3TjMqN1nlubz2ETqsA23cOnl8+WQYeUXeVqOe41E8wnWy0gVqNBDo+UlH2xXxD
	 Rosnrr/HcmuSG+MICFkfs8k/xSZBB+8ETG5FgUdPAGLt6e7ASB4kHBkFdjFV73xNYO
	 ZcMTI7b91MN4/01BWlm0mPLdmpSOTjkkJ4g0xA9ieDynyagXhWaTg1iG4+geuLvRKH
	 llbTVSV6lMvK5Qe2KLWrAkn+OCY9In5rnLE0fYkPO6P/qmSRA2L9WjD2B/USPCHhZ9
	 wCWhmxV50mNjA==
Received: by mercury (Postfix, from userid 1000)
	id BF6431060E89; Mon, 26 Feb 2024 22:27:41 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Yackavage <michaely@ips-yes.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 5/6] dt-bindings: fsl-imx-sdma: fix HDMI audio index
Date: Mon, 26 Feb 2024 22:26:27 +0100
Message-ID: <20240226212740.2019837-6-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226212740.2019837-1-sre@kernel.org>
References: <20240226212740.2019837-1-sre@kernel.org>
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


