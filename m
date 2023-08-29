Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAA78C783
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjH2O0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbjH2O0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:26:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3A6122;
        Tue, 29 Aug 2023 07:26:09 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37TC53S0016602;
        Tue, 29 Aug 2023 15:40:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=fUZCKmv
        n1npPDCOhK3S0jk8SDzGzr+LS8tr677k25J8=; b=N5b5Dy6usDnLsjxAE3qc+wJ
        tnEKae8EVKH4enXub6ura/sik/FwVUMVwIe6oa8nJ9smOsju5RaDcR9+dLvAC/c4
        ClstWfwPuZ0zEqrPYHQSxbmxlNbU+BZKW2aW3a/+JMkNpWLfohydqciaLw4fTKS1
        WDsuiV+R8D6p3FLOVIxgyAG1PCAVCiGXdXa4oGkI3QtlCnmy0yntAS/39NkzeYX9
        Fsk/Uf6tVseF419Q4zn214EJ806vE+OSFiqd1bZKGWFT100oowhvFZFUmRjF8g4y
        bx/M/i1F+UkhwV1xzxohQXfXIZZI3RUGKw70X2Xbweykc2eFbDkR/nowxSaykVQ=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqtxysy5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 15:40:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6D9B210005E;
        Tue, 29 Aug 2023 15:40:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 647F02207DB;
        Tue, 29 Aug 2023 15:40:56 +0200 (CEST)
Received: from localhost (10.201.22.39) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 29 Aug
 2023 15:40:54 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>, <lee@kernel.org>
CC:     <alexandre.torgue@foss.st.com>, <fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] counter: fix, improvements and stm32 timer events support
Date:   Tue, 29 Aug 2023 15:40:21 +0200
Message-ID: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.39]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series combines some fix and improvements to the counter interface,
found while stm32 timer counter driver developements.
It also introduces a new tool that can be used for testing.

Then, it improves the stm32 timer counter driver by introducing new signals,
e.g. counting frequency, and missing channels.
It also adds support for interrupt based events using the chrdev interface.
Two event types are added in this series: overflows and capture.

Up to now, stm32 timer counter driver focused mainly on quadrature
encoder feature. With this series, all timer instances can be enabled
for simple counting (with overflow and capture events).

Fabrice Gasnier (8):
  counter: chrdev: fix getting array extensions
  counter: chrdev: remove a typo in header file comment
  tools/counter: add a flexible watch events tool
  mfd: stm32-timers: add support for interrupts
  counter: stm32-timer-cnt: rename quadrature signal
  counter: stm32-timer-cnt: introduce clock signal
  counter: stm32-timer-cnt: populate capture channels and check encoder
  counter: stm32-timer-cnt: add support for events

 drivers/counter/counter-chrdev.c     |   4 +-
 drivers/counter/stm32-timer-cnt.c    | 585 ++++++++++++++++++++++++++-
 drivers/mfd/stm32-timers.c           |  46 +++
 include/linux/mfd/stm32-timers.h     |  26 ++
 include/uapi/linux/counter.h         |   2 +-
 tools/counter/Build                  |   1 +
 tools/counter/Makefile               |   8 +-
 tools/counter/counter_watch_events.c | 348 ++++++++++++++++
 8 files changed, 998 insertions(+), 22 deletions(-)
 create mode 100644 tools/counter/counter_watch_events.c

-- 
2.25.1

