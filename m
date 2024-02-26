Return-Path: <linux-kernel+bounces-80356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5186674F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931EF1C209D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B52594;
	Mon, 26 Feb 2024 00:23:06 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8A101C4;
	Mon, 26 Feb 2024 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708906986; cv=none; b=Jrc43syaclhzp+ImM08PtpwqQTUcx1oUfHWKbqEL2KFN1mpUPQwaGroKb0bEpsn6CwJIGNDcEtHX0/ngomo4sIY6HLqfpB0lZi/EhtefC+H5gCo0PAe+HyojDafNwKXC9D2tkhv4IdzN6d8mLW/mxKNB9uZ+65vjH71kDqoyTWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708906986; c=relaxed/simple;
	bh=N97TvJmYkqRtFZI8fRGBr8qsUHt2POR7C0eus3UEHh0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q14vubhqo6/hKQzh468R9Tid+BvGeWDfffoyDM6nFE20rTZK+uf1AKMumG2zOUddSAr8rYSL16C1iTwoWthC1AMXk9yblirprBUUctgqfBSp4LSCc0D7t1D277Y1kNQmlfK6rlUtk1LmKUoXDjbEifb4XGcV0cEkar3HBi+/jeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1reOlm-0001no-2S;
	Mon, 26 Feb 2024 00:22:58 +0000
Date: Mon, 26 Feb 2024 00:22:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/7] dt-bindings: mtd: ubi-volume: allow UBI volumes to
 provide NVMEM
Message-ID: <6b45ddaa344cc3958fa25f2e8f15a73c006f58fa.1708906456.git.daniel@makrotopia.org>
References: <cover.1708906456.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708906456.git.daniel@makrotopia.org>

UBI volumes may be used to contain NVMEM bits, typically device MAC
addresses or wireless radio calibration data.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/linux,ubi.yaml  | 10 ++++++++++
 .../devicetree/bindings/mtd/partitions/ubi-volume.yaml |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
index 7084a1945b310..27e1ac1f252e4 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
@@ -59,6 +59,16 @@ examples:
                 ubi-volume-caldata {
                     volid = <2>;
                     volname = "rf";
+
+                    nvmem-layout {
+                        compatible = "fixed-layout";
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+
+                        eeprom@0 {
+                            reg = <0x0 0x1000>;
+                        };
+                    };
                 };
             };
         };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
index 1e3f04dedc01d..19736b26056b2 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
@@ -24,6 +24,11 @@ properties:
     description:
       Match UBI volume ID
 
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
+    description:
+      This container may reference an NVMEM layout parser.
+
 anyOf:
   - required:
       - volid
-- 
2.44.0

