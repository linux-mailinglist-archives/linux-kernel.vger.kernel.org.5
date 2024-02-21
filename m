Return-Path: <linux-kernel+bounces-74669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D380E85D783
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E43B22E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A83E4C615;
	Wed, 21 Feb 2024 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX2NLF7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0E482C1;
	Wed, 21 Feb 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516606; cv=none; b=BxQwdomUoVJjn4cgheNp0ayvt83ODclqcINRA3tebXoiUEqiyd1IIoXpZ+3+iNgD5871sJtjppopwgfmhT/aAAw6zGvnBxSK5hmwZrAOP8jYvSqE8/kBPssIv7pqi+uRuoE3CI6C3gmONpATdywOh4Uhc59FwYExw/tXjKdf7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516606; c=relaxed/simple;
	bh=cVP9oDcFqMe3HIWN3U9hzMH6sEfnqnfkj+cc6SDEDc4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uiiOKS59NBDLk4HA1m7qI6uRGHb+JiyhAxWFQB89uDI5x0ez+ivJDxLHT75QerWKuD2B/1KFkKiLiuAz2ayse/dVjmiigPjxpAsgSV885CznFjXGToXA2yAJcAOQisD1pVvlmLBPJu3zh4eY8LADooomhIMkMOdxc1orVFLPIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX2NLF7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B71A7C433C7;
	Wed, 21 Feb 2024 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708516605;
	bh=cVP9oDcFqMe3HIWN3U9hzMH6sEfnqnfkj+cc6SDEDc4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VX2NLF7NT/k0riswUv+ozEtEs5Tmuz0vQTBtwd3VL0Y4dtoenK8m5dEo0nPy/Fr1b
	 U5fL1nL4EpxaMZWzRv3TiYqeJks8tJD9XnyJJFI52glsOqrvYMdbj39h2n8fl3Yb4d
	 LwkMdjNtq4QPZ1bj/yfZ5R7JmYIt4eKKYdtgwCijIqBJGC3FAhMzshRSXGtbZ/HQFZ
	 CqX3e11lEIFSu86HUuQ8mxvHn8fIRfOMfc6w1IowPyVEI8surusfZ0xb72EC7wtkM2
	 S9d9TY1JTwRanWhCR1XjB4HLgoPrLmJbCzZGDspfNJc4USluujcpNdmV18p0D2n63u
	 AyNuK7D/xtCog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90848C48BC3;
	Wed, 21 Feb 2024 11:56:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v3 0/2] watchdog: sp805: add reset control support
Date: Wed, 21 Feb 2024 19:56:40 +0800
Message-Id: <20240221-hisi-wdt-v3-0-9642613dc2e6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPjk1WUC/22Myw6CMBBFf4XM2pp2gGJd+R/GBX0ojUpNwaoh/
 XcHVpi4PDf3nAkGF70bYF9MEF3ygw89QbkpwHRtf3HMW2JAjhVH0bCOLuxlR1bqGlUjWlkrAXR
 /RHf27yV1PBHTcQzxs5STmNc/kSQYZ8ZqZa1ptZK7Q3iOtxCuWxPuMGcSrlTkKxVJlaWzplKy1
 pX5VXPOX5MVvqLdAAAA
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708516604; l=1002;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=cVP9oDcFqMe3HIWN3U9hzMH6sEfnqnfkj+cc6SDEDc4=;
 b=OF1L8JvpFPNieb8IzziAiUU/l2TgBSIHHY+WX5+VPGsxwuQ2zJ3cXaqgEPm4geb0nX4u3ynVi
 fvcIG6wx3DsBTZvCcsahf5yDbT2cOVcM3vy/2s2uhVx+JEZZbpepCnb
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

Deassert the reset if it's available.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v3:
- move reset to local variable, get reset exclusively (Philipp Zabel)
- Link to v2: https://lore.kernel.org/r/20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com

Changes in v2:
- commit log: dt-binding->dt-bindings (Krzysztof Kozlowski)
- binding: remove "|", join two lines. (Krzysztof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20240217-hisi-wdt-v1-0-cdb9ddcab968@outlook.com

---
Yang Xiwen (2):
      watchdog: sp805_wdt: deassert the reset if available
      dt-bindings: watchdog: arm,sp805: document the reset signal

 Documentation/devicetree/bindings/watchdog/arm,sp805.yaml | 5 +++++
 drivers/watchdog/sp805_wdt.c                              | 8 ++++++++
 2 files changed, 13 insertions(+)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240217-hisi-wdt-3b52971a6591

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


