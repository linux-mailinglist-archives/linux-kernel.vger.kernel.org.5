Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692178133ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573644AbjLNPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573628AbjLNPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:05:18 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9695C8E;
        Thu, 14 Dec 2023 07:05:24 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9LR9u002199;
        Thu, 14 Dec 2023 07:04:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=pfpt0220; bh=nuCTvLv1
        hEiBtVDRf9IkTWr4PLGW6KCIaFlBnMtgA7s=; b=MRuaR3JNtNCoywy4odo1u1C6
        Dy2upz9T1DLA/8ZDK5GSFku3LrGspV2Za3SGU4fwHAiee+iCDTZSyK4C73deDFBK
        uIpu6CIOC7NsIEmgNj1Omw42SkhFzPdWzoUNToxTSqwm85y2qJVb0rK+g1QHzbwk
        m5wVh4ELywTBI+DDUlvq7Ory5XNZz0kYku6BYk0H/NaV+DAGjrJd6mmu8CgWPKG3
        eWxlP011bF3lg56PHPejDv4KT/C4f0RwbNRPm2rfjKRqoSdbzUqKCrDORfQMbspF
        47P/Up0H9V2x614FwhzD1VLhq4lGiXAjmQnkBErulLc7jCwzRFTuaw0jauYOcA==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uyy0m93t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 07:04:22 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Dec
 2023 07:04:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 14 Dec 2023 07:04:21 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 06B023F7085;
        Thu, 14 Dec 2023 07:04:16 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <gregory.clement@bootlin.com>,
        <chris.packham@alliedtelesis.co.nz>, <andrew@lunn.ch>,
        <fu.wei@linaro.org>, <Suravee.Suthikulpanit@amd.com>,
        <al.stone@linaro.org>, <timur@codeaurora.org>,
        <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 0/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Date:   Thu, 14 Dec 2023 17:04:11 +0200
Message-ID: <20231214150414.1849058-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: d39ptV3d-6NQ6WrNs6UhFmrKMspK0cKi
X-Proofpoint-ORIG-GUID: d39ptV3d-6NQ6WrNs6UhFmrKMspK0cKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add support for Marvell ac5/x variant of the ARM
sbsa global watchdog. This watchdog deviates from
the standard driver by the following items:

1. Registers reside in secure register section.
   hence access is only possible via SMC calls to ATF.

2. There are couple more registers which reside in
   other register areas, which needs to be configured
   in order for the watchdog to properly generate
   reset through the SOC.

   The new Marvell compatibility string differentiates between
   the original sbsa mode of operation and the Marvell mode of
   operation.


Elad Nachman (3):
  dt-bindings: watchdog: add Marvell AC5 watchdog
  arm64: dts: ac5: add watchdog nodes
  watchdog: sbsa_gwdt: add support for Marvell ac5

 .../bindings/watchdog/arm,sbsa-gwdt.yaml      |  52 +++-
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi |  14 +
 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |   8 +
 drivers/watchdog/sbsa_gwdt.c                  | 247 ++++++++++++++++--
 4 files changed, 298 insertions(+), 23 deletions(-)

-- 
2.25.1

