Return-Path: <linux-kernel+bounces-79339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C1A862102
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEBBB24520
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72F7625;
	Sat, 24 Feb 2024 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poc3sjpR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01040182;
	Sat, 24 Feb 2024 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733293; cv=none; b=jCLovEcyACF8SJCyyFnMnnxKrnpeQc5PhdpN/5AdIX6XZwddg/QPKWJ8ZWrJQaSVG4LigV4wQPr0Xwu10UFuhhvVQA1D0ZkpuP078xqdCsnbpUEGbxh92GNcrndLdFOMzDqVOeXSDule1aMVqQUWvVVhWsn1I70JrkhnZlkJDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733293; c=relaxed/simple;
	bh=ajpTJsTTp0MgBwoG+Xc7ugNQltQSLk5IW3xSgWzGdRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHiy7G/jNSRpAzypZP3LQzZuiLBTb0cq7WnE70lo/HGmfkDEsVjXqLylKOQtf/CSCt3lRNebCWRqVuPNeRxIOZ7dglDDnUA+wG+dIKsS5cnpNSSERXUhvrRTtsqE7h0NDeXjqLFBxu8m+6kLzlzhxewG9dHnBc+ewk07Xox130M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poc3sjpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435B1C433C7;
	Sat, 24 Feb 2024 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708733292;
	bh=ajpTJsTTp0MgBwoG+Xc7ugNQltQSLk5IW3xSgWzGdRc=;
	h=From:To:Cc:Subject:Date:From;
	b=poc3sjpRxABHFj6+RdIKH9bzBibIM3yiGZza+h9X+eoTrswGlkGvP8MQejfsFzRN+
	 LneOiVAxpgJIexV7pjx4QTKbViOB3lwg3HVvchX8e3BIKpCwtr9EMcbXK+Mm9FUpOf
	 N/l7lznQNIc/DEbfXLbxyPDrODaobq+vYdXYU08uL0InuCm0OyWQyGMdOBs4wPpiLK
	 7ZmQQt0l6gchvLZcJGIS5lWIGYhjugoF7eBCNFG5r+AuhU7czHqbpopKhhEtlo6rrs
	 n1e3AFGyFq6B0VX9cylw7rPalbPZx0sdGIx7hlIHou1p5CkCRWFgSMOX6gcjFsRD9z
	 ZGtkhtSF8FmZw==
From: Rob Herring <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] regulators: dt-bindings: gpio-regulator: Fix "gpios-states" and "states" array bounds
Date: Fri, 23 Feb 2024 17:07:51 -0700
Message-ID: <20240224000752.3830665-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The minimum number of array entries for "gpios-states" was not not
specified, so the the default is the same as the max (8).

The minimum is also missing from "states", and the maximum is also wrong
as it should be 2^(# of GPIO lines). Since there can be 1 to 8 GPIOs,
the "states" range should be 2 to 256.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/regulator/gpio-regulator.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
index f4c1f36e52e9..a34e85754658 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
@@ -47,6 +47,7 @@ properties:
         1: HIGH
       Default is LOW if nothing else is specified.
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
     maxItems: 8
     items:
       enum: [0, 1]
@@ -57,7 +58,8 @@ properties:
       regulator and matching GPIO configurations to achieve them. If there are
       no states in the "states" array, use a fixed regulator instead.
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
-    maxItems: 8
+    minItems: 2
+    maxItems: 256
     items:
       items:
         - description: Voltage in microvolts
-- 
2.43.0


