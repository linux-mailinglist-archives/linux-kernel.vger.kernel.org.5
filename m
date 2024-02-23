Return-Path: <linux-kernel+bounces-78102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D3860EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7991F23430
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6705D46D;
	Fri, 23 Feb 2024 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEz3FMCV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEE5CDC9;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683023; cv=none; b=NPQrqAEimxl97ndlqhUiG15yy5B5PBj3NqSpFyk8t7fv0PJODuay05gfJ6C/0LhXWkn9kubKYzr6N9qcQvWQE0pYirK0tL1Exp4dA/uiD7MJ9C2RKGdY6keE+bd/YU/b5+41nWFxCUajzJGu3kCPYnpIk6GXfUNlbf5DfuhpDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683023; c=relaxed/simple;
	bh=VDASn16XHrLArVByFssljGzmfnx3iO+5GYIVlAb71rE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=To8+9GnpwjLoAxNcaimVXQ3b+92HpVR+IQNxE3IIVbvbZjhlHlnFGZSHMgmVsFjZjtfnW7QgQYuGKAcBE0BiYL/u3ZCCWVDis6nT888j6IVYUe+teLX8Iq34qGG//5AWTthICO5XDlMdgHKp8sRweA0wpbI1a2MzyfkdmMnTnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEz3FMCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A40F2C433C7;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708683022;
	bh=VDASn16XHrLArVByFssljGzmfnx3iO+5GYIVlAb71rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uEz3FMCVFHZ2f0Y/uJSxdXiserLR63OK+2LAqLrXBxnYwYPZyD+obRcT6jZWeOi6a
	 gbaBj5V6BhxjQWw/zvUFray6c5w1PvpG6K8BFfhq05Bgtehp5bO+AkFSsl1Ld6SJU7
	 G1NsBbhRy6EjH/4qOmwUGxHk7VCCmjEsyHbdI3kh2Mxg5dIWteNapd8tC8QkmvksiQ
	 Yi3CNGAR1WkKZiNtPKgLrgqsT/6yUbZecHUtc1v8YPP8ryZREgv/drIP5hD1Uzz+t4
	 tZGlG+Z2Amo/kGDKNlr9cn53GazkseGgDF5MgDxHfwjUamTWiHbMc4n3yMGlgs7+8O
	 iGjzAIwf26XXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB6C54E4A;
	Fri, 23 Feb 2024 10:10:22 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 18:10:19 +0800
Subject: [PATCH v2 1/2] dt-bindings: simple-pm-bus: Add optional resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-bus-v2-1-da8ba83c1a5f@outlook.com>
References: <20240223-b4-bus-v2-0-da8ba83c1a5f@outlook.com>
In-Reply-To: <20240223-b4-bus-v2-0-da8ba83c1a5f@outlook.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708683020; l=1517;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=ycKXPbq/zZox0Tf/d90/44XzLN+X/N07MSaWt6t/K2E=;
 b=agOw8170TwGFqV8jVC0eJJD007zcKmXbtsVJ7/McHN+JkYskRh7W/CLBCbTwN9IkhIkfE3ixC
 RQGbOxnuHdhAzTsd3e/4fXB+HmhrsluteP4CT/LZ/dUTfl8av+2qs2R
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

For some on-soc buses, it is also needed to deassert the resets before
access. Document it in the binding.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/bus/simple-pm-bus.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml b/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
index 182134d7a6a3..430638104980 100644
--- a/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
+++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
@@ -14,8 +14,9 @@ description: |
   driver, as it's typically initialized by the boot loader.
 
   However, its bus controller is part of a PM domain, or under the control
-  of a functional clock.  Hence, the bus controller's PM domain and/or
-  clock must be enabled for child devices connected to the bus (either
+  of a functional clock, and it might have a reset control signal.  Hence,
+  the bus controller's PM domain and/or clock must be enabled, reset control
+  signal must be deasserted for child devices connected to the bus (either
   on-SoC or externally) to function.
 
   While "simple-pm-bus" follows the "simple-bus" set of properties, as
@@ -49,6 +50,8 @@ properties:
     # Required if clocks is absent, optional otherwise
     minItems: 1
 
+  resets: true
+
 required:
   - compatible
   - '#address-cells'

-- 
2.43.0


