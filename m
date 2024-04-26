Return-Path: <linux-kernel+bounces-160716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B698B4183
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85D81F20F44
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AF376E7;
	Fri, 26 Apr 2024 21:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o41Woglf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19712C68A;
	Fri, 26 Apr 2024 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714168315; cv=none; b=E4UO65tDtrwgEZJL+lVmxcUB8+5SdZDVlP7YOlbCP+xU7eJgff6V2fzr9GP1ldTUcSeZUYlDsBIA971FLtkFf5WU4jmlXHO7E/KHGtlF25Rj8TJUU0FHSBeN87+yZeV6J2uB3+07SDX3/TtcQCRVFPFpGoj0P/Gg3JUXBrSgERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714168315; c=relaxed/simple;
	bh=LnQUtM/J37UGWUE9G3tzqEynRSFSqZxD5vF2HRp0+DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8e5lZKDrUlOORxuDqLsjATx71o+ihCLqSNPp5o2cMH6hvXV7EPkapb6IlQQmQCgTIf5ytXZFsH1yNMpqMp+9bPfjf5q66bpe/vrmBrnCvmBzBII11OdOE1SYImeyELe5ncyxc3LKh5mAA8PBKvnpcCXYWppyl946oxLh/fhfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o41Woglf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1E4C113CD;
	Fri, 26 Apr 2024 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714168314;
	bh=LnQUtM/J37UGWUE9G3tzqEynRSFSqZxD5vF2HRp0+DE=;
	h=From:To:Cc:Subject:Date:From;
	b=o41Woglf8gg8y4NYEnXcC7I2MMcczhaJNoclfmI5vx4Wqv+bsDluC9Bb/PnmQSHSY
	 UxxtcXE+8O8CAOBrFvkpg+tVni74yApzh0keESOVBwhWNZSgl0QlDevoElSU/PLPJA
	 56DjgzSnW5tYFxJ0uMcO9Vo1YqAQZmzC31d1tshwXLp/5kQ2WsqgsFpc4ndCuHKCf/
	 GtNw+pn+W3lWVRbK2DqoVMQaOQKCAJhhXF8JaGdDLtdLOgKXFLfWDbXtX5K4S735RS
	 TRlNx3+brRmXwK+ji6RIi7gI/UEPTeRpZ0MwAjgObmbFv8urAFNyLr23wbsueLQQux
	 PsCFyMjDv38qg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: fixed-regulator: Add a preferred node name
Date: Fri, 26 Apr 2024 16:51:46 -0500
Message-ID: <20240426215147.3138211-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define "regulator-[0-9]v[0-9]" as the preferred node name for fixed
regulators. Other suffixes with names are also accepted. Combined,
these make up about half of the existing names in use.

For now this only serves as documentation as the schema still allows
anything to avoid lots of additional warnings for something low priority
to fix. Once a "no deprecated" mode is added to the tools, warnings can
be enabled selectively.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/regulator/fixed-regulator.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index 9ff9abf2691a..51e2f6fb7a5a 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -41,6 +41,13 @@ allOf:
         - gpios
 
 properties:
+  $nodename:
+    anyOf:
+      - description: Preferred name is 'regulator-[0-9]v[0-9]'
+        pattern: '^regulator(-[0-9]+v[0-9]+|-[0-9a-z-]+)?$'
+      - description: Any name allowed
+        deprecated: true
+
   compatible:
     enum:
       - regulator-fixed
-- 
2.43.0


