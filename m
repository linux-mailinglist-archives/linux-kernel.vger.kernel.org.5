Return-Path: <linux-kernel+bounces-17492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7E824E57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE2E284792
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3B1DFEA;
	Fri,  5 Jan 2024 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="L5u3D4lM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95561C687;
	Fri,  5 Jan 2024 05:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4054arbI003594;
	Thu, 4 Jan 2024 21:59:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=/kpB6uKvM6IIxucLSprmQNlmg5KdSSBcohRcUnYd4mk=; b=L5u
	3D4lMdKd92xrGjLnrq0w+1yyPdvBAVMn6SHAFsOJH9wolinu+6KyPR03Sv5D/o8R
	L5yODxIDwynwkBLzAgqQSD4B9UEsiLBhzutjOUZRdruhKjWHSRNwgR9V/n8Q4OEV
	QCge+RosMtMuEYiTxtxEOAtQzlcKpFNuQPUoP84SOc4MkwMhDLo2UCq62WhjJTxZ
	kH5JTA50zcvnQZklzsXa4eOHZmU7ze0Fusd/wJO3n9+jvG6ImXqtZtdzKToPWwJn
	GcZ0Bm5Nkdjr8z6nNVJa/u0NeTr4vlcNvLMoAf+FIbH1ZslMscx43VtCTLP9HTOb
	UM/gINSWNU7hWbJRCVw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3veaw005ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 21:59:04 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 Jan
 2024 21:59:02 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 4 Jan 2024 21:59:02 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id 162283F704F;
	Thu,  4 Jan 2024 21:58:57 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/7] dt-bindings: arm: coresight-tmc: Add "memory-region" property
Date: Fri, 5 Jan 2024 11:28:34 +0530
Message-ID: <20240105055840.1977897-2-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105055840.1977897-1-lcherian@marvell.com>
References: <20240105055840.1977897-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: F9EL23i8e5G9Vr-rySMmEJUzOzbGKmV5
X-Proofpoint-ORIG-GUID: F9EL23i8e5G9Vr-rySMmEJUzOzbGKmV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

memory-region 0: Reserved trace buffer memory

  TMC ETR: When available, use this reserved memory region for
  trace data capture. Same region is used for trace data
  retention after a panic or watchdog reset.

  TMC ETF: When available, use this reserved memory region for
  trace data retention synced from internal SRAM after a panic or
  watchdog reset.

memory-region 1: Reserved meta data memory

  TMC ETR, ETF: When available, use this memory for register
  snapshot retention synced from hardware registers after a panic
  or watchdog reset.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v5:
* Added Reviewed-by

 .../bindings/arm/arm,coresight-tmc.yaml       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index cb8dceaca70e..6d266ac0016b 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -101,6 +101,28 @@ properties:
           and ETF configurations.
         $ref: /schemas/graph.yaml#/properties/port
 
+  memory-region:
+    items:
+      - description: Reserved trace buffer memory for ETR and ETF sinks.
+          For ETR, this reserved memory region is used for trace data capture.
+          Same region is used for trace data retention as well after a panic
+          or watchdog reset.
+          This reserved memory region is used as trace buffer or used for trace
+          data retention only if specifically selected by the user in sysfs
+          interface.
+          The default memory usage models for ETR in sysfs/perf modes are
+          otherwise unaltered.
+
+          For ETF, this reserved memory region is used by default for
+          retention of trace data synced from internal SRAM after a panic
+          or watchdog reset.
+      - description: Reserved meta data memory. Used for ETR and ETF sinks
+          for storing metadata.
+  memory-region-names:
+    items:
+      - const: tracedata
+      - const: metadata
+
 required:
   - compatible
   - reg
@@ -115,6 +137,9 @@ examples:
     etr@20070000 {
         compatible = "arm,coresight-tmc", "arm,primecell";
         reg = <0x20070000 0x1000>;
+        memory-region = <&etr_trace_mem_reserved>,
+                       <&etr_mdata_mem_reserved>;
+        memory-region-names = "tracedata", "metadata";
 
         clocks = <&oscclk6a>;
         clock-names = "apb_pclk";
-- 
2.34.1


