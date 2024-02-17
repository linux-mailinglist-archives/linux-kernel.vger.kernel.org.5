Return-Path: <linux-kernel+bounces-69844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03074858F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9831C1F22C08
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A217AE74;
	Sat, 17 Feb 2024 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCJqqLOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1997A724;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708174337; cv=none; b=RN4Y/PyTz+LyPeveOowWJ73o0j9DFwCot5VregBYyYw/QdI0dNlA80WbJZrFgT5pTCbs3HLmqMABETEvGS+U4nddmAwafeHdeiPq9QrCL9yxPx3jZoBQGSA/thbs5nutD8tQfyqNRclMbsV4oulUZjWxAhBTC/mA5orohLjzOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708174337; c=relaxed/simple;
	bh=26asYT9Pch/6BET0RjGLiuk5j1AaaNkgzH3IDcRoKJQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mj/lw19FwlE7wcBmgeX10JzlCrgDawvJz7gQq/cHnK8odFnJEyQyS7QY1FXh8HQAm6FSV1/F5AWonlygyc5cRtxDt7DO9R5xwC0vcrV4+iiWuCS5ZSByssk/+1YUqSoDbtUY4hJ4HA69ib+SFDqZD24fiWH3SYpr/04NTtxEKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCJqqLOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84096C433F1;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708174336;
	bh=26asYT9Pch/6BET0RjGLiuk5j1AaaNkgzH3IDcRoKJQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NCJqqLOLQ+zfr4eotRtrCXoVtGCykND8YYaIX8cBLA5s/LJMlrocZ+2I5FCeBdu8o
	 2NnAN3FjI8nV6hZeoKikXERVLY2dCVLNUqrZnDjYZIdQa+TH9HjcWO6KZ2Zu5DD5cQ
	 gEHVARtWFJ6ZyNhbdtfZ9FH7N3G+gbH6bE75JTzF3qLBKFHQycOXOcc9jZFr72IsD+
	 npZiGmMaa2PEsFQspDp6HTdsaH5vvXN/hkwrzH98x8/Pt2Mpr3LreumBxaQv7C/y8d
	 VJq2yjJrorwHLBnZtznSkpe8oAd6GQZc26RMNe7tjxXhEQMFZ+41sIEIdEFnHfty1I
	 qaQeBJmNwlZ2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F20C48BC3;
	Sat, 17 Feb 2024 12:52:16 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC v2 0/5] clk: hisilicon: add support for Hi3798MV200
Date: Sat, 17 Feb 2024 20:52:05 +0800
Message-Id: <20240217-clk-mv200-v2-0-b782e4eb66f7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPWr0GUC/22MywrCMBBFf6XM2kgylWBcCQU/wK10EcbRhj4iS
 Q1Kyb8bsnZ57j2cDSIHxxFOzQaBk4vOLwVw1wANdnmycPfCgBIPEpUWNI1iTiilIDqS5dZoZgn
 FfwV+uE9t3eB66aAv4+Di6sO39pOq159UUkIKi8YSo2Hd6rN/r5P34578DH3O+QeVpxlfqQAAA
 A==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708174332; l=2029;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=26asYT9Pch/6BET0RjGLiuk5j1AaaNkgzH3IDcRoKJQ=;
 b=nAb9AVMdHX/f2z6emI9t8+7+o1w6aec07MJGqfIwL1KkyGN24rLI+xipHXWAwSujd6wAkehaT
 LmxTY8U6EHqAw16+re/9sQioCZs9wNFOYgI4J4DnapxnjZuWOEZIpl8
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

This SoC is similar to Hi3798CV200 with a few more clocks in CRG module.

Note this driver is still ongoing, many clocks are not registered in the
driver now. Feedback is welcomed, especially from HiSilicon people.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- s/dt-binding/dt-bindings in commit logs: (Krzysztof Kozlowski)
- fix bot error by adding "hisilicon,hisi-sdmmc-dll" to syscon.yaml (Rob
  Herring)
- hi3798mv200-crg: assign fixed rate parents to some gates
- hi3798mv200-crg: s/ETH/FEMAC, add GMAC ctrl clock
- Link to v1: https://lore.kernel.org/r/20240216-clk-mv200-v1-0-a29ace29e636@outlook.com

---
Yang Xiwen (5):
      dt-bindings: clock: histb-clock: Add missing common clock and Hi3798MV200 specific clock definition
      clk: hisilicon: add CRG driver for Hi3798MV200 SoC
      dt-bindings: clock: merge all hisilicon clock bindings to hisilicon,clock-reset-generator
      dt-bindings: mfd: syscon: Add hisilicon,sdmmc-sap-dll compatible
      dt-bindings: clock: hisilicon,clock-reset-controller: add Hi3798MV200 SoC support

 .../devicetree/bindings/clock/hi3660-clock.txt     |  47 ---
 .../devicetree/bindings/clock/hi3670-clock.txt     |  43 --
 .../devicetree/bindings/clock/hi6220-clock.txt     |  52 ---
 .../devicetree/bindings/clock/hisi-crg.txt         |  50 ---
 .../clock/hisilicon,clock-reset-generator.yaml     | 175 +++++++++
 .../clock/hisilicon,hi3559av100-clock.yaml         |  59 ---
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
 drivers/clk/hisilicon/Kconfig                      |   8 +
 drivers/clk/hisilicon/Makefile                     |   1 +
 drivers/clk/hisilicon/crg-hi3798mv200.c            | 436 +++++++++++++++++++++
 include/dt-bindings/clock/histb-clock.h            |  21 +
 11 files changed, 642 insertions(+), 251 deletions(-)
---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240216-clk-mv200-cc8cae396ee0

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


