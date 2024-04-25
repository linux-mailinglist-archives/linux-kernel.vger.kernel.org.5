Return-Path: <linux-kernel+bounces-159024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B518B2841
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8B283AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF6114F9F5;
	Thu, 25 Apr 2024 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWZvYf3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1939ADB;
	Thu, 25 Apr 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070302; cv=none; b=E37WWjHqXungJ+bpCD2SNbfKToSPWU4z6Za5QQ94lCD0eQfN6SbO2Gu83vyxw26HH7U6+HYwJhsEDF0KV2BnZtswfao7OazxwMe4pJnNquyu/OQtgKzsvrcnUXaaF/OOdg5XZr2lX9dJMlnpNbKV/AcrnvX6p44Tsk19VfZYJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070302; c=relaxed/simple;
	bh=3Qz2w/LYMH//NJIJesW4PxnUYz/48yQay5iwVA8Zzxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B84IF02oACl4ohH8VWkFk9TuFzBcfssY+p4OJIfCJJpvaZFTflWqWSU9eOSPZQ9bL0wwcl7USUYsi6zbduNO6nD+YmoP7xzL+kLDgWtDl7UfQdXYKY24guhri4UcYDYXzQMyv2dSAK0AO7lXcD3ZHTBSNZrT2M/Y3dEwYy+MxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWZvYf3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063B9C2BD11;
	Thu, 25 Apr 2024 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714070302;
	bh=3Qz2w/LYMH//NJIJesW4PxnUYz/48yQay5iwVA8Zzxk=;
	h=From:To:Cc:Subject:Date:From;
	b=tWZvYf3LEvWYuXkFqetOiJ0KF3hLu2DIYYfvsklAmOe+KcmrisLxhE+ZMYl9jeEoN
	 8CkpdplVPecLLQFy3hBUPiyT1NbDH7xwVam+ZgO4vR4CkbhHrU1f7l74EZnznK7AF6
	 CiVmHe38f/mbfgNTFauuEhVCLDaibVbdgc6PnWBDnQk8dx5W8cqdt09BAfH9pJl+/w
	 wxL/aUTjSy+wLkKuDfLA8awgrl8T23ZjQB/I4p+f3gKTRvDHjX9o4o9YK0lrRajx0B
	 9p7Bb+SNe/8cPWCf20plbshn51HJ3xEbtR24QHaSoj51ObZeeHJzVorLOxrXb0sWRn
	 b4FjwJSFIXQ2Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: fixed: Define a preferred node name
Date: Thu, 25 Apr 2024 13:38:09 -0500
Message-ID: <20240425183810.3079069-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define "clock-<freq>" as the preferred node name for fixed-clock and
fixed-factor-clock. There isn't much of an existing pattern for names of
these nodes. The most frequent patterns are a prefix or suffix of "clk",
but there's a bunch that don't follow any sort of pattern. We could use
"clock-controller-.*", but these nodes aren't really a controller in any
way. So let's at least align with part of that and use 'clock-'.

For now this only serves as documentation as the schema still allows
anything to avoid lots of additional warnings for something low priority
to fix. Once a "no deprecated" mode is added to the tools, warnings can
be enabled selectively.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/fixed-clock.yaml  | 7 +++++++
 .../devicetree/bindings/clock/fixed-factor-clock.yaml     | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
index b0a4fb8256e2..d287bd092054 100644
--- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
@@ -11,6 +11,13 @@ maintainers:
   - Stephen Boyd <sboyd@kernel.org>
 
 properties:
+  $nodename:
+    anyOf:
+      - description: Preferred name is 'clock-<freq>'
+        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
+      - description: Any name allowed
+        deprecated: true
+
   compatible:
     const: fixed-clock
 
diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
index 8f71ab300470..962a1fe85416 100644
--- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
@@ -11,6 +11,14 @@ maintainers:
   - Stephen Boyd <sboyd@kernel.org>
 
 properties:
+  $nodename:
+    anyOf:
+      - description:
+          Preferred name is 'clock-<freq>' if the input frequency is fixed
+        pattern: "^clock-([0-9]+|[0-9a-z-]+)$"
+      - description: Any name allowed
+        deprecated: true
+
   compatible:
     enum:
       - fixed-factor-clock
-- 
2.43.0


