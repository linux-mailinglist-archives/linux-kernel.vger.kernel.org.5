Return-Path: <linux-kernel+bounces-144379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9948A4531
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C702028181D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB8137914;
	Sun, 14 Apr 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="z9ennMOz"
Received: from mail-108-mta69.mxroute.com (mail-108-mta69.mxroute.com [136.175.108.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751557329
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713127026; cv=none; b=RZZLHxNaofYX5rRfUwpQPXN+3klf1GZCz232yUo88qWzQ2mleSqx5AD2mKJoRYV34ljJwEHD1yUYGRzBX+9hAz+q84NBO1lO4Nf1NyOQ8EUl7yP9BmhK0gGGHmFSPiV5mZK4zvyBorghFfWGSsUdBoJA7NNitjZEuLAF/yTboH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713127026; c=relaxed/simple;
	bh=kWUJVImZ5IklLlFB8DTQulLWi9Rv8qTjNzSixFmmAgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4yzVZlBdOSyF+wx1cul+HtzVIet9XNG8b8nWlKfmEFGksSq4hU00Iy9ToR6toot+pEsNNKlUWCLUECF0gLoKyGOcGcp/rLLmnr9n81REb7FsIJ0NIVxp9fh9ZQzjRemGoJFPqUrdT0BSaAwdbErZgsvOfyfiOfdjW9I12rEIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=z9ennMOz; arc=none smtp.client-ip=136.175.108.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta69.mxroute.com (ZoneMTA) with ESMTPSA id 18ede52dd650003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 14 Apr 2024 20:35:56 +0000
X-Zone-Loop: 53380fe12b4c7546e10ac2212b7dbb13798404bda427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=siFshzAcODGq1KHpD5czuRrfXWqJe4EzMc07ufXwg7w=; b=z9ennMOzTNw3UUX1VoLMiZL9jU
	IJjjo15m9JiAn2kbi3x5wVrJKDh+LG2pQDZyhIUPjjej34/D/rCDvGU8I5hUAEETuKCLS8J/T0RoC
	+i3S9fpAlz9lZmcn7L7Ou+d0ibmhEPo0PVjpY4+lqAJdq3m108MMPRPeYryGvHOSKgJMg6X5WYCQe
	kPL6Yhcc2lCTFG0v39FeaOKSw1daU62rQC3pwLQiUTIYqLLYZYrWc36OloBGqnhJZSs4eH1fS2W0t
	Ei5lmeIAM2Arlxu+CJmdCO00KKkP8JFHo4+h6ogWBIklLYsKTpfkHkmv28MtBqFjNa5jiBSlKUzbY
	lsR6YsDA==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>,
	Ondrej Jirman <megi@xff.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 21/25] dt-bindings: media: imx258: Add binding for powerdown-gpio
Date: Sun, 14 Apr 2024 14:34:59 -0600
Message-ID: <20240414203503.18402-22-git@luigi311.com>
In-Reply-To: <20240414203503.18402-1-git@luigi311.com>
References: <20240414203503.18402-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Luis Garcia <git@luigi311.com>

Add powerdown-gpio binding as it is required for some boards.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
index c978abc0cdb3..33338139e6e8 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
@@ -36,6 +36,10 @@ properties:
   reg:
     maxItems: 1
 
+  powerdown-gpios:
+    description:
+      Reference to the GPIO connected to the PWDN pin, if any.
+
   reset-gpios:
     description: |-
       Reference to the GPIO connected to the XCLR pin, if any.
-- 
2.44.0


