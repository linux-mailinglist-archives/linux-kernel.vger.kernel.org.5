Return-Path: <linux-kernel+bounces-39558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6483D2CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B8B28F08A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECB1BE6B;
	Fri, 26 Jan 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwh+7oDE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9BBA50;
	Fri, 26 Jan 2024 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238138; cv=none; b=lEQaxwaBWrgsAsyDda/i5Cbnl0STzIxNTbEQupeEEcYOSr0kmmD2DCBe6IyncYVjoMT2r9FwGE3A/2J7r5jVDZ6CeFj4eIertuhkoKNdsf1ZCE8+iJoOQS6B9d0fUFWQM0r05bJmFkVesbuYPrL49higfKdla5knBAaHV8cPH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238138; c=relaxed/simple;
	bh=y4t6+bKbc+c5WN0p8b8GZauAdDFYaN0tlfAeOmI40wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrSHEeMrpPvhfHEJyPqRxFx06PQpaWeEJJbWE6h8upZf8EGhnx9h4aG4C2zTjJiYHv9JwOmeGf4CiC+Qj4QLr5pltPDxW5EWNffO0/uuZLm5Dt63t9EhwndGs9FSI+AJHcjWFPa92RNbBBPYkyrQWFKuuXPZ9P92F3ecuCQDeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwh+7oDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD21C43399;
	Fri, 26 Jan 2024 03:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706238138;
	bh=y4t6+bKbc+c5WN0p8b8GZauAdDFYaN0tlfAeOmI40wM=;
	h=From:To:Cc:Subject:Date:From;
	b=Nwh+7oDEPxFsa42ieelkaA9P+XLa6XRgRdqkDsONfOSnKo5yzBeciCzdE0GfPHEwK
	 B3fkLv31PHNgyhZ0XY57YxzpBhHyZExgBkyFU4ydUQCB3RexKHtRlFpznTrIqcaCyW
	 L139+5DeEASso+1IIq0PF6SJyKXg9Q8O2ACuHcPg0ihzY23BwN4flvnbNpCvNDYNjU
	 TFwwlHD507NBjo/Uit3MNyYiT/gCYQywkFMmWAU1AbsrsIFf0Bzft7WXZAQn4aeRV6
	 hZ3iPhR+CS/hzRUB3MLdYu8YjDWAsmORXSntPxFr9dGlSyvXhuTBhwJk2XnNrkydep
	 Qvuze+G9sa0Tg==
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: fixed-cell: Simplify nested if/then schema
Date: Thu, 25 Jan 2024 07:46:44 -0600
Message-ID: <20240125134645.2549051-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason to have a nested if/then schema as checking for compatible
being present and containing 'mac-base' can all be done in one 'if' schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/nvmem/layouts/fixed-cell.yaml    | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index ac2381e66027..8b3826243ddd 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -36,20 +36,18 @@ properties:
 
 allOf:
   - if:
+      properties:
+        compatible:
+          contains:
+            const: mac-base
       required: [ compatible ]
     then:
-      if:
-        properties:
-          compatible:
-            contains:
-              const: mac-base
-      then:
-        properties:
-          "#nvmem-cell-cells":
-            description: The first argument is a MAC address offset.
-            const: 1
-        required:
-          - "#nvmem-cell-cells"
+      properties:
+        "#nvmem-cell-cells":
+          description: The first argument is a MAC address offset.
+          const: 1
+      required:
+        - "#nvmem-cell-cells"
 
 required:
   - reg
-- 
2.43.0


