Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D5A7BFB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjJJMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjJJMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:33:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C443DB4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:33:23 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4Zwd3MMszVlR7;
        Tue, 10 Oct 2023 20:29:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 20:33:21 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <mark.rutland@arm.com>, <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
        <wanghuiqiang@huawei.com>, <wangwudi@hisilicon.com>,
        <guohanjun@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 0/3] Add HiSilicon system timer driver
Date:   Tue, 10 Oct 2023 20:30:30 +0800
Message-ID: <20231010123033.23258-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

HiSilicon system timer is a memory mapped platform timer compatible with
the arm's generic timer specification. The timer supports both SPI and
LPI interrupt and can be enumerated through ACPI DSDT table. Since the
timer is fully compatible with the spec, it can reuse most codes of the
arm_arch_timer driver. However since the arm_arch_timer driver only
supports GTDT and SPI interrupt, this series support the HiSilicon system
timer by:

- refactor some of the arm_arch_timer codes and export the function to
  register a arch memory timer by other drivers
- retrieve the IO memory and interrupt resource through DSDT in a separate
  driver, then setup and register the clockevent device reuse the arm_arch_timer
  function

Using LPI for the timer is mentioned in BSA Spec section 3.8.1 (DEN0094C 1.0C).

Yicong Yang (3):
  clocksource/drivers/arm_arch_timer: Split the function of
    __arch_timer_setup()
  clocksource/drivers/arm_arch_timer: Extend and export
    arch_timer_mem_register()
  clocksource/drivers: Add HiSilicon system timer driver

 drivers/clocksource/Kconfig          |  10 +++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/arm_arch_timer.c | 123 +++++++++++++++------------
 drivers/clocksource/timer-hisi-sys.c |  68 +++++++++++++++
 include/clocksource/arm_arch_timer.h |   2 +
 5 files changed, 148 insertions(+), 56 deletions(-)
 create mode 100644 drivers/clocksource/timer-hisi-sys.c

-- 
2.24.0

