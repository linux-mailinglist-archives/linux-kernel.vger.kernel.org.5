Return-Path: <linux-kernel+bounces-164567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D98B7F65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D03B285240
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865FD181BB4;
	Tue, 30 Apr 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSJtY/Qv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D9175560;
	Tue, 30 Apr 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500298; cv=none; b=TQgoNaYQEy7aauWLDOmA5D8yqLLWTLteU418XsALvN3k9/6WW1Nhcf2SjCV3SIJfZLoKoaYfVxOeFOEBj9viQtprnq7qI0olrniXr7QvU1GEV2pmTtP2slgcEdd5MLMm5pTS0HSown/+nRc9BfhdDLNxrJZY7JSZXin05WzqmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500298; c=relaxed/simple;
	bh=jz73RuQd4HFNSDYi2UqJP9KQ4zUfUOQNSb6BLXUEHwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imantSBPUTaRX0TAW7OeBq3ResXgmOq099sT99pzRrHOfo7Mypf1B5UeUZoWPmP1SfaAciX6GdYyzhE98ec7BIjt/Qi9hUrmL1QC+INZK+qBDun5yzuLqBJjCN83Nujp5iGiPfouRzXDmoolGAVXZTk+0oWvLS7YaZexVedUDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSJtY/Qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E61CC2BBFC;
	Tue, 30 Apr 2024 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714500298;
	bh=jz73RuQd4HFNSDYi2UqJP9KQ4zUfUOQNSb6BLXUEHwg=;
	h=From:To:Cc:Subject:Date:From;
	b=NSJtY/QvQALgQFXBeHV7rY3KeJCSZ9+AonDpJ2HFpC29toNWlNk+gqsdtxpbebs00
	 q3tEDlPd8Wts/wDUW1S7Zy/khgJb7aNcLlPi7tsr6T6KpiSNHlH1dLXL/Yxpl+6QDs
	 DmtzORqjy4aN7H49O4GyESjB+3L1I5V7TjMC0kndfCtJ1hwUoiybMzwmvULoK5DQPK
	 QRzbvfyWnhTIZj0PZE48fbcmc/iUyLporwdTSIn3FObt5Ne9pLnWop5hMRdl0v/p8X
	 O6qy8SU4UCRMqKdQqNt3yvcVobX3wdRIlqMuadCVdTA1bKuHu0bIduhrGV19tj81+w
	 f+hm4i6Pf0utQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: clock: fixed: Define a preferred node name
Date: Tue, 30 Apr 2024 13:04:14 -0500
Message-ID: <20240430180415.657067-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define "clock-<freq>" as the preferred node name for fixed-clock and
fixed-factor-clock where <freq> is the output frequency of the clock.
There isn't much of an existing pattern for names of these nodes. The
most frequent patterns are a prefix or suffix of "clk", but there's a
bunch that don't follow any sort of pattern. We could use
"clock-controller-.*", but these nodes aren't really a controller in any
way. So let's at least align with part of that and use 'clock-'.

For now this only serves as documentation as the schema still allows
anything to avoid lots of additional warnings for something low priority
to fix. Once a "no deprecated" mode is added to the tools, warnings can
be enabled selectively.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/fixed-clock.yaml | 9 +++++++++
 .../devicetree/bindings/clock/fixed-factor-clock.yaml    | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
index b0a4fb8256e2..90fb10660684 100644
--- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
@@ -11,6 +11,15 @@ maintainers:
   - Stephen Boyd <sboyd@kernel.org>
 
 properties:
+  $nodename:
+    anyOf:
+      - description:
+          Preferred name is 'clock-<freq>' with <freq> being the output
+          frequency as defined in the 'clock-frequency' property.
+        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
+      - description: Any name allowed
+        deprecated: true
+
   compatible:
     const: fixed-clock
 
diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
index 8f71ab300470..4afdb1c98f5f 100644
--- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
@@ -11,6 +11,15 @@ maintainers:
   - Stephen Boyd <sboyd@kernel.org>
 
 properties:
+  $nodename:
+    anyOf:
+      - description:
+          If the frequency is fixed, the preferred name is 'clock-<freq>' with
+          <freq> being the output frequency.
+        pattern: "^clock-([0-9]+|[0-9a-z-]+)$"
+      - description: Any name allowed
+        deprecated: true
+
   compatible:
     enum:
       - fixed-factor-clock
-- 
2.43.0


