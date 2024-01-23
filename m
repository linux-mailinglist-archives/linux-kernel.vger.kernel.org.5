Return-Path: <linux-kernel+bounces-34661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6134A8385D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194801F2279F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BEE17CA;
	Tue, 23 Jan 2024 02:57:03 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888FA3F;
	Tue, 23 Jan 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978622; cv=none; b=pSnh3rG/5+3nevo8f+Zi6D38sX7udq3FpSBu7h9gxANlg2MsCt+OMX8W5/8f9pPRNIyUJUTx76AAFtz/ImGsayE4o+tZs0ZgEXHVYS3xZAIQGqv++ua6lyu61JejywjSXWuA6pg2/z/s34dk9wCnlOZgr9cbOeNJPyjLDK+ke4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978622; c=relaxed/simple;
	bh=JOW/XeQYTThgjoVl3ERNjpuhgv/rV3WIl3niYr63tOE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JZ8nyD3KpQ1wxmb14nWFU1WmcPfZf6zzyGfGh8KFaWQ+2wGuw9v2KgIUU7GiZPTPIM2kIXwDW5PVuQGrSiPm2JD5wkW3NnSNA1uxSh8Uukx6qZ+bifGq5Iv3KK99Ocffq4c/cUC5prMZu/veLl7F+HcAK16WJChRaAgYs9v5YJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40N2uHJC022672;
	Tue, 23 Jan 2024 10:56:17 +0800 (+08)
	(envelope-from zhifeng.tang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx04.spreadtrum.com [10.0.1.214])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJs3r1HN8z2S7xxn;
	Tue, 23 Jan 2024 10:48:56 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx04.spreadtrum.com
 (10.0.1.214) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 23 Jan
 2024 10:56:15 +0800
From: Zhifeng Tang <zhifeng.tang@unisoc.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH V4 0/3] Add reset controller driver for ums512
Date: Tue, 23 Jan 2024 10:56:10 +0800
Message-ID: <20240123025613.3976-1-zhifeng.tang@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx04.spreadtrum.com (10.0.1.214)
X-MAIL:SHSQR01.spreadtrum.com 40N2uHJC022672

From: "zhifeng.tang" <zhifeng.tang@unisoc.com>

In most of Sprd SOCs,The clock controller register block also
contains reset bits for some of these peripherals,so reset
controller and clock provider are combined together as a block,
and put it under the driver/clk/.

Changes in v4:
  - Add description why reset controller put it under the driver/clk/

Changes in v3:
  - Fix the driver patch is overwritten by cover letter
  
Changes in v2:
  - The binding file is combined into one patch

zhifeng.tang (3):
  dt-bindings: reset: Add reset controller bindings for Unisoc's ums512
  clk: sprd: Add reset controller driver for ums512
  arm64: dts: sprd: Add reset controller driver for UMS512

 .../bindings/clock/sprd,ums512-clk.yaml       |   3 +
 arch/arm64/boot/dts/sprd/ums512.dtsi          |   9 +
 drivers/clk/sprd/Makefile                     |   1 +
 drivers/clk/sprd/common.c                     |   1 +
 drivers/clk/sprd/common.h                     |   2 +
 drivers/clk/sprd/reset.c                      |  78 ++++++
 drivers/clk/sprd/reset.h                      |  30 +++
 drivers/clk/sprd/ums512-clk.c                 | 240 ++++++++++++++++++
 include/dt-bindings/reset/sprd,ums512-reset.h | 203 +++++++++++++++
 9 files changed, 567 insertions(+)
 create mode 100644 drivers/clk/sprd/reset.c
 create mode 100644 drivers/clk/sprd/reset.h
 create mode 100644 include/dt-bindings/reset/sprd,ums512-reset.h

-- 
2.17.1


