Return-Path: <linux-kernel+bounces-67977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE28573DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBF51F24AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776ACFBE5;
	Fri, 16 Feb 2024 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oS3aj4AN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082E149DF0;
	Fri, 16 Feb 2024 02:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708052328; cv=none; b=sdervX72DobXSTG/EbtP3Ldkzj5MMV+hrT9a63e6/9MkqbTYbY+LjrdFNNtj3KVYAKl9FiL/ASv9u2iK4A7k4gdDMIfBmiflGv7EaNJXsA4rfc6+88JcGnSec+sc/yfevt5oMTUetDlvSHgDRvAQFnWH19monc9SfNvCS0cxUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708052328; c=relaxed/simple;
	bh=Dw6xFa910yf8PFp/BingwUN3pEDovkOdIvr/lh+1AC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qckcA7LiI201oqi0HGRItf5kq03eS0KXvbNUlY6GlZoI/mt3yXIuwlOLln4tjNrobbvnJPkqROgL0fRyJWrpiZ9uUGUgZ90EvjeXH9QU3ngDaG74Bntpg/d/MAbJJ2zjPkDrKX7x9sft/UYyB4Xht5Gire7MHvRct98NM7r1ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oS3aj4AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B83C433F1;
	Fri, 16 Feb 2024 02:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708052328;
	bh=Dw6xFa910yf8PFp/BingwUN3pEDovkOdIvr/lh+1AC8=;
	h=From:To:Cc:Subject:Date:From;
	b=oS3aj4AN3LJDY9J/rltigvGkJ5wEt10GNxAbz+1Dh22F61vWSD+0HpMrjwQ8xGOJ6
	 xJf0AyPNmrQ4vT5CypTl7d5Y4Q9YXgOe9me8UDd/o5aJmpDk0Rwbl3+Jj4IVL57LlY
	 Y1FYeAV7ObEmIQE09ARKrB8HR4sDyjoJDwa/UgSvsK/n9hbAnROt7x0y+pshP5T+1R
	 +9M2siqDW+OrHVE1wSyy100Iia4AS3vJ5l1FR+ZcUoVSEUFgtNRFmUA9qPZ3buQLl/
	 SkW4ze6uWerw+TAzwL+2jOcH+VM6FBKtAGFDgkiLXdZAD4wL+GXIrkz/Ony9fSZKby
	 Bth9zRG7si/3Q==
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: vendor-prefixes: Add missing prefixes used in compatibles
Date: Thu, 15 Feb 2024 20:58:29 -0600
Message-ID: <20240216025839.902288-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A new check for vendor-prefixes used in compatibles finds some missing
ones. Add the missing ones already in use.

This omits some ancient prefixes in powerpc and arm32 as there are a
bunch of out of business one-offs that take too much time to track down
who they were.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/vendor-prefixes.yaml  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..08d5d63cb646 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -230,6 +230,8 @@ patternProperties:
     description: ByteDance Ltd.
   "^calamp,.*":
     description: CalAmp Corp.
+  "^calao,.*":
+    description: CALAO Systems SAS
   "^calaosystems,.*":
     description: CALAO Systems SAS
   "^calxeda,.*":
@@ -478,6 +480,9 @@ patternProperties:
     description: EZchip Semiconductor
   "^facebook,.*":
     description: Facebook
+  "^fairchild,.*":
+    description: Fairchild Semiconductor (deprecated, use 'onnn')
+    deprecated: true
   "^fairphone,.*":
     description: Fairphone B.V.
   "^faraday,.*":
@@ -542,6 +547,8 @@ patternProperties:
     description: Giantec Semiconductor, Inc.
   "^giantplus,.*":
     description: Giantplus Technology Co., Ltd.
+  "^glinet,.*":
+    description: GL Intelligence, Inc.
   "^globalscale,.*":
     description: Globalscale Technologies, Inc.
   "^globaltop,.*":
@@ -601,6 +608,8 @@ patternProperties:
     description: Honestar Technologies Co., Ltd.
   "^honeywell,.*":
     description: Honeywell
+  "^hoperf,.*":
+    description: Shenzhen Hope Microelectronics Co., Ltd.
   "^hoperun,.*":
     description: Jiangsu HopeRun Software Co., Ltd.
   "^hp,.*":
@@ -631,12 +640,16 @@ patternProperties:
     description: Hyundai Technology
   "^i2se,.*":
     description: I2SE GmbH
+  "^IBM,.*":
+    description: International Business Machines (IBM)
   "^ibm,.*":
     description: International Business Machines (IBM)
   "^icplus,.*":
     description: IC Plus Corp.
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
+  "^iei,.*":
+    description: IEI Integration Corp.
   "^ifi,.*":
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
@@ -821,6 +834,8 @@ patternProperties:
     description: LSI Corp. (LSI Logic)
   "^lunzn,.*":
     description: Shenzhen Lunzn Technology Co., Ltd.
+  "^luxul,.*":
+    description: Lagrand | AV
   "^lwn,.*":
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
@@ -899,6 +914,9 @@ patternProperties:
     description: Miniand Tech
   "^minix,.*":
     description: MINIX Technology Ltd.
+  "^mips,.*":
+    description: MIPS Technology (deprecated, use 'mti' or 'img')
+    deprecated: true
   "^miramems,.*":
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
@@ -993,6 +1011,9 @@ patternProperties:
     description: Novatek
   "^novtech,.*":
     description: NovTech, Inc.
+  "^numonyx,.*":
+    description: Numonyx (deprecated, use micron)
+    deprecated: true
   "^nutsboard,.*":
     description: NutsBoard
   "^nuvoton,.*":
@@ -1536,8 +1557,12 @@ patternProperties:
     description: Voipac Technologies s.r.o.
   "^vot,.*":
     description: Vision Optical Technology Co., Ltd.
+  "^vscom,.*":
+    description: VS Visions Systems GmbH
   "^vxt,.*":
     description: VXT Ltd
+  "^wacom,.*":
+    description: Wacom
   "^wanchanglong,.*":
     description: Wanchanglong Electronics Technology（SHENZHEN）Co.，Ltd.
   "^wand,.*":
-- 
2.43.0


