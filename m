Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9600F7AB3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjIVOkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjIVOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:40:12 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0113100;
        Fri, 22 Sep 2023 07:40:06 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38M9t6lk014993;
        Fri, 22 Sep 2023 16:39:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=Mr6LkXE
        w8sIJ8BcE3bjActArsfoXf80+QAQbdeESybU=; b=UdzA6JPVKFv5JkdXhOrdWLF
        b0A6m1IF3zizMZZFoM9heTrmMIITnirPvb+T7AjR5AJQqSOBTiuol5D2Q+Ep63dM
        EywqJxhoepRolz7SBouwpn9PCZPG8WlIzn6pw8jTgvZlecRFkIiebeMJtS6z+1zR
        BA/L+94mvVblJd6J+reReRR+ptI14BBn6l8AZ4eR1RCC1OdFRxb0QEq2wB+fmHxJ
        IRpRxAwDVwesf417MThgqP2BIKGDPD1/d9yhhgWelqDLZpOqfzYemSDIS0cUEgf8
        Pk5qxurSbFb9RpkW3gmcP7TiefJeJ+Qb+McEbWNGOheXSxgyrP5utK7INg5vuNg=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t8tt03wg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 16:39:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7B91100051;
        Fri, 22 Sep 2023 16:39:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C81AF235F24;
        Fri, 22 Sep 2023 16:39:43 +0200 (CEST)
Received: from localhost (10.252.14.82) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 16:39:43 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <william.gray@linaro.org>
CC:     <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] counter: fix, improvements and stm32 timer events support
Date:   Fri, 22 Sep 2023 16:39:14 +0200
Message-ID: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.14.82]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
- counter fix and improvement patch applied, hence dropped in v2 series
- mfd patch applied, hence dropped in v2 series
- revisit watch events tool (mainly command line interface)
- add one patch to rename STM32 Timer counter
- various review comments from v1

Fabrice Gasnier (6):
  tools/counter: add a flexible watch events tool
  counter: stm32-timer-cnt: rename quadrature signal
  counter: stm32-timer-cnt: rename counter
  counter: stm32-timer-cnt: introduce clock signal
  counter: stm32-timer-cnt: populate capture channels and check encoder
  counter: stm32-timer-cnt: add support for events

 drivers/counter/stm32-timer-cnt.c    | 558 ++++++++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h     |  15 +
 tools/counter/Build                  |   1 +
 tools/counter/Makefile               |  12 +-
 tools/counter/counter_watch_events.c | 368 ++++++++++++++++++
 5 files changed, 934 insertions(+), 20 deletions(-)
 create mode 100644 tools/counter/counter_watch_events.c

-- 
2.25.1

