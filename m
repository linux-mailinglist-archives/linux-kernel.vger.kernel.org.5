Return-Path: <linux-kernel+bounces-116536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DE188A072
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552B81C3756E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266548CDC;
	Mon, 25 Mar 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Cr8F266c"
Received: from mail-m603.netease.com (mail-m603.netease.com [210.79.60.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810CF82D8A;
	Mon, 25 Mar 2024 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711343528; cv=none; b=nEhwOSeDv7maXCRu1oUyoj1O+dwvb8weMXgG0b1XjewrsD1U7i1Bcu0F6x1OoQutImmvrhAIlIv14jSC19S5kUVy0uHmqyV46eTcW8JHGTyoo/2xHlaD9mcBpqBUBOonlcX9jzBJELbpAgX9nAu574bvPD+FWuzqJrwelj0vY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711343528; c=relaxed/simple;
	bh=/0L7xsGt62dkaztuu5tiwX1KwkzZV+OEKc1C03nGwrY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Pr+vtfcDx1NMZn1PU+4xiOQzM00M8xwgPhbPlCJ+9Q8jxKicrvoPY3/6JKe5viSNovzsZWQdgQ5OFB5Ef9lr2g1UYaH4EZVK7Kk5Lk3Rx2Ixi3fE2k5AhyLN+N1NbAaVv3ORfvkN+VaEmxgNlIy6pG76GauPj43KnVzGOgp9PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Cr8F266c; arc=none smtp.client-ip=210.79.60.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=Cr8F266cslnVeJPW43tYw1VZzCe+7ZQ8hKsz6tY+cx1mPkbzRjP3mTNbcbKX7AkkrrxPqn0nn/ttQVFoeH0pe1msroUelpJjilWcQls+p0Xk9dT2Zxq8xWIFsy2xqWEj4jxu3SeC0MDDEQyUs22KZFIyu4s5YDW6C6Fy6ET6h1I=;
	c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=YBEeTq7OGXH4yuF3fO8G/YM9YDxHqOm8d/+z2DqcRk0=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 15AA57C0487;
	Mon, 25 Mar 2024 12:16:44 +0800 (CST)
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Patches for rockchip clk input / output switch
Date: Mon, 25 Mar 2024 12:16:28 +0800
Message-Id: <1711340191-69588-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0lMS1YfQk1DSE8eSU4YSx5VEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
	tLWQY+
X-HM-Tid: 0a8e73d3328609d2kunm15aa57c0487
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pzo6TRw6PjMQAg0uMw4BNAoC
	AhgKFDlVSlVKTEpKSE9LSUtOS09IVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
	WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSUtPQjcG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

These patches add support for rockchip clk input / output switch.


Sugar Zhang (2):
  clk: rockchip: Add support for clk input / output switch
  dt-bindings: clock: rockchip: Add support for clk input / output
    switch

 .../bindings/clock/rockchip,clk-out.yaml           | 107 +++++++++++++++++++++
 drivers/clk/rockchip/Kconfig                       |   6 ++
 drivers/clk/rockchip/Makefile                      |   2 +
 drivers/clk/rockchip/clk-out.c                     |  99 +++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-out.yaml
 create mode 100644 drivers/clk/rockchip/clk-out.c

-- 
2.7.4


