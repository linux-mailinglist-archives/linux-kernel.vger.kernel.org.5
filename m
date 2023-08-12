Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25DD77A06E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjHLOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHLOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:25:47 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFCC1BF8;
        Sat, 12 Aug 2023 07:25:48 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37CDlnKJ032543;
        Sat, 12 Aug 2023 07:25:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=y2h9nLbuSwl/QP82jn4J6bzXMjp3EQhSL/4Ks3F3V/s=;
 b=FdAbGgtghg6UlsJFoJs1FeCY/rbRpHtI6BLQGyqu75AFhlkRVyorj5suam7rVVDJsAlK
 IRFJQtGz2ze23c5WGCnPrhsCH+EkCASLo6q65lwBGc0xXLg55cPX77UCzPHtCc3FdCm9
 6cnvTd88oBg3AmpP/7f77WTQdp8QODG11aLAqUBahHAD+nnPVCW3+aEdsAz9PhKNXVhM
 r2615TmuAvnHaASBpT9Isc9SbF/lc1rwYzEDy7Q0bumOiv57sfcNrsS+5RLesAWwVsnx
 0ziFmwtrSfD3GFOW5cXKxpiCIfYJY0Me7PXWcl1phVQVBToJLqRn0L9nQfSxREWPaP4y xg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kj09cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 07:25:32 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 12 Aug
 2023 07:25:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 12 Aug 2023 07:25:30 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 6CFAA3F7041;
        Sat, 12 Aug 2023 07:25:26 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v2 0/6] Marvell Odyssey uncore performance monitor support
Date:   Sat, 12 Aug 2023 19:55:12 +0530
Message-ID: <20230812142518.778259-1-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: g5vlqzJJGrtv5BOOzV_DbhUQ5QUq_Yg5
X-Proofpoint-ORIG-GUID: g5vlqzJJGrtv5BOOzV_DbhUQ5QUq_Yg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_14,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches introduces support for uncore performance monitor
units (PMUs) on the Marvell Odyssey platform. The PMUs covered in this
series include the PEM PMU, LLC-TAD PMU and DDR PMU.

Patches 1, 3 and 5 adds support for PEM pmu, LLC-TAD pmu, DDR pmu
respectively.
Patches 2, 4 and 6 deal with their respective device tree bindings.

v1->v2:
- Changed DT binding file names to match with compatible
- Added missed validations in perf event init
- Fixed Comment style

Gowthami Thiagarajan (6):
  perf/marvell: Marvell PEM performance monitor support
  dt-bindings: perf: Add Marvell PEM performance monitor unit
  perf/marvell : Odyssey LLC-TAD performance monitor support
  dt-bindings: perf: Add Marvell Odyssey LLC-TAD pmu
  perf/marvell: Odyssey DDR Performance monitor support
  dt-bindings: perf: Add Marvell Odyssey DDR PMU

 .../perf/marvell,odyssey-pem-pmu.yaml         |  38 ++
 .../perf/marvell,odyssey-tad-pmu.yaml         |  63 +++
 .../bindings/perf/marvell-cn10k-ddr.yaml      |   9 +-
 MAINTAINERS                                   |  16 +
 drivers/perf/Kconfig                          |  14 +
 drivers/perf/Makefile                         |   2 +
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 435 ++++++++++++++---
 drivers/perf/marvell_odyssey_tad_pmu.c        | 424 +++++++++++++++++
 drivers/perf/marvell_pem_pmu.c                | 437 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 10 files changed, 1369 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell,odyssey-pem-pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/perf/marvell,odyssey-tad-pmu.yaml
 create mode 100644 drivers/perf/marvell_odyssey_tad_pmu.c
 create mode 100644 drivers/perf/marvell_pem_pmu.c

-- 
2.25.1

