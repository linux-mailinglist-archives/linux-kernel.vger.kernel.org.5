Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE587780305
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356910AbjHRBUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356887AbjHRBUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:33 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073513AA1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:20:31 -0700 (PDT)
Received: from 104.47.11.176_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id C136E100004F6;
        Fri, 18 Aug 2023 01:20:30 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321630.482000
X-TM-MAIL-UUID: 8ce9f07e-2a60-479d-b66e-f9789796d75d
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.176])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 75C9810000405;
        Fri, 18 Aug 2023 01:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaG8Wgfqheufo0+2kOMEKuEJxA7tsbFocsCST/1XUgtvp1EUT2mAbfFFFbhZNBD8tfg/MLFY/AerOcqxjycLR3m0fFkB9ZjgC51V+lRgszLKqFx+dAEivGTRVwIQQH6C0SdWKzrPdjLWsP/uI0VGHM3EhPDGzRx23xYpxeEOsAI16sTsYBjCpr+rNLFJnxblGQADGNIAnwAL467ZDgIEHTFmsbMhzTIBbVjCohj+Mqdf6Gw10aBWFBwZl7hdyycLAWx//Ti4WBkaZ9cE8CBOW3K1lVpvwqvo1ggtczLjjVi00ZMZhWvp4qhyrFlCd8Mh7vTXg2KwGZTm25Gz/tncyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRne8kbkNKVt6kbFg+jUd0MiRWYGUPi2gLv6PHBaxsY=;
 b=DkmH8KEeWch8MBm6fl7KR7SFAxpwrUJ5182NpjMcCP2em08JK2qlFfkNhhZ7bj89LU8B/rpWuDMTZGb8yOrqnXKgWYnnvnURUSjYb9nn3tblRmqG3+IRnLXpZg9sX5JlpfkNOA/B2CniCaIRqJfVQHn7L/c8YX70lp6wrVkSEVMaRkm5ZSX1rNL5eO5LZD+Dqpgfr2nA34p3aRW0l4Yfa5/ZUETnCMLu1qjjCSvUuDwYeeSMcQup0eRSlpXEAWsBMisbqBoczlovH89btmzy1czkf01TFiaIyQnhvmbixTmRr5P0zeT3+tKJiHghWYPAzQXDJYwOU9IdjZjUoPkkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=arm.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH v2 6/6] virtio_rtc: Add Arm Generic Timer cross-timestamping
Date:   Fri, 18 Aug 2023 03:20:12 +0200
Message-Id: <20230818012014.212155-7-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818012014.212155-1-peter.hilber@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT036:EE_|BE1P281MB1633:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f657f974-fa40-46fa-d2ae-08db9f894efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHPJPMUaG9820kU0+SvG3x5fCuzDVtMDS3pxepBvPBeAlVYydCncuE3/dZgKeCoObKV63mgsiLbfvwlA+9/8SlJcvLTwoeuE7H5DEzapeAIsmgK9aIfyq8Dn57pFWZgCQJGthQazmUbqpwf6fqczqLqwGukNdXaqMwJJsLyI4lKNEb/RaHC6Ns4tBDzMFT6rVJ2gkGm7I4piKPB8U1/GRu8EVYqHMbyDmtf2iSs9PfUTdeswPmgIYlbwlTcCYrm0y17lwqBiWozoVm6y+yaYs8CnjLf1xRe1NsWMCxBNfuiRK11lJ5jw3VnXhwfUpQ9GMxITUc7bSAuK/tXoR7vzY0/8GSoHlFI0L0E2nj/4u1Hkjf4Ogn5Eqfp0jX+34gYDoOE9EQ8gNOnplbCZRxRTULdaemPEhgaKQENVxhUkpaDOuCFXDv6LR6NuYBBwkCAXAIdCAFUVkWLBz8E64tsQY4Hyq7K1B4S2bo9CGvgzRr+TkHjzfoZUFjwgkwYQxlOiui7CMfzzKcZROC/6DEqAzkH2jlE9jv/adLGP6MbC+xS+Qbmg40TldQZn2HbXQ4hkHUgCsdhgOj0LV8Z5fNZNdMm9MVPJAAyCoS8LdxA/Ol6A4NIIRJwQpzTMDlmuD+r2Ih8b/WRgJ8GLWqIuB0YrYDsfMg/C1QeMSsM5bGgLBjK+7T86G+5vllnVHnLX7g1wQEJEIviw8+MaRedwLd3JKwKO/F8IlsbyRGN+RTfx2jEGM/ZueKqvX7z4Ejjq5xSlnbRrF3yGEkJUdtuC0/nYuy+JQsHBvglH7gwXq3+MN8BKzcqR7/pozSFaIpvVM39ZY6ZP+rvgZCmY75n/klBOeQ==
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39850400004)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40480700001)(36756003)(86362001)(81166007)(12101799020)(70206006)(42186006)(54906003)(316002)(478600001)(70586007)(41300700001)(82740400003)(26005)(47076005)(1076003)(336012)(2616005)(8676002)(8936002)(5660300002)(4326008)(7416002)(2906002)(44832011)(36860700001)(83380400001)(41533002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:20:28.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f657f974-fa40-46fa-d2ae-08db9f894efb
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT036.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1633
X-TM-AS-ERS: 104.47.11.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--18.516800-4.000000
X-TMASE-MatchedRID: ZAkTtSyZ7B7c1YtpVABxhScOunEIf0eXRyG5SSR7mMFHwPpoS7xiTQ3u
        hqemVNab4tr/y+kNIhx+41laLbgwdzURLmZdK2fK9K6xgLnDQNjrlkvw0pZ13MhGESF2QtYSsgk
        fnaHAFPzm9Tc/GgfFJwFtWueZlMH0Hw0ziwm/5yd81fikUYgyLUMxQVRV15qN9zxz+98nLbrqqp
        KNT13hEpMgmvUQU/w2ftTV5S2xLn0yxlgWcGNdNffKbx7F+zg4FkXEytHxBjkweIyZbRlQ2yzec
        Bj190z12HlzhM3zNtns9WQVYycKfw3lGTiQlxzIv9rSd36EgUI+Mqg+CyrtwA==
X-TMASE-XGENCLOUD: 6732af28-3a27-4945-a6cc-85283e71368a-0-0-200-0
X-TM-Deliver-Signature: 73D683A371F90B08169AE946A9213147
X-TM-Addin-Auth: OcQ9Z0y6ljBysb/AZ7MXi5bwj0+XjALf+IL7xbmWb/5E6gEWl6Mu5v/EbRW
        6M3hwtnwvq5QPEEMkFq5RAOjPzJuGlXNa+uvPVtiENiK+mIzzjjxI2SnRt4WoIsLcUv+EIFnFvM
        cPkpT0TK+agSaHVyljgDJDgNfjpMvyikvZdTwjt1KZi/38ND4xKig8Dym3yjf0Uw+4qC9QI5Alu
        bsPSyebREq6H55xS2wL6W4Iw1rtPr7nfANdKniV2dzoSdtUA58LCke5oz72QFiQM+ITck53A6lV
        m2U+W0lQ8l+IYRM=.OxyiOyDLdq/fNFKkan2VNxG5E6L8m2MZzckGU6JXS/t4n5M7Wsu+vhKY8B
        nwonNzBoiB+hcv23U31U/KJiB6DyictX3Q1/DMpCuSnqpun/m0fXVHwlVwpRf/ykIoPaO9PxgGJ
        v0AXSvXUA4+U3t2MTIMzFWsC4Eshm2TM43use1hZwbrzE/khW1XEJGxEpCvkRg4zcyptHgLFBpl
        QKC6hCQeG+j2IzTTmNtgsKR9npg0eIfQ8wsss7SL0NWfRrHqzaasBSZckoGnVpjYCSFuFeqyx+m
        MOIsnJaEJhUI8bwQQ/JsZ2rEpKkUJXX55J6m334Ubx7mrUGZ2iPdrySiW4w==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321630;
        bh=jqtbhrHfjn9VDfVwg/FXcIMDSJtBMetyIWRdox0bdck=; l=2909;
        h=From:To:Date;
        b=jIxkWM5PW0jonaCNu0CZkUicYCQPZ/fR4BQ7u6s8hIm1JFPgq8HOmikwAY5eXxB84
         jETUWD2iQ5lvlJtEGcD8RD/LLtDnQqJmgcSz4JJ+qOPC1/5UgLaKhbtBFof9/OI8EY
         YvgDlqCRE/lDDec0b3Zdh1Ami3J4t/gHdqxqE3JKEDSvZ8Y7MF+nK380F6F1Z26U5O
         en6eAz/QDeHfQbc6vu8jeDlPCYuOqKQ3Sa0UL/UQokO/D5N2oocL8wDn0216ICLqJS
         y2JvcijQU54o4o93irnZ5yoivqoDk/guZex1FIDtYoPLshIF0yrLNGkILS29EV+1w4
         qtSaXfQaWav+Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PTP_SYS_OFFSET_PRECISE2 support on platforms using the Arm Generic
Timer.

Always report the CP15 virtual counter as the HW counter in use by
arm_arch_timer, since the Linux kernel's usage of the Arm Generic Timer
should always be compatible with this.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v2:
    
    - Depend on prerequisite patch series "treewide: Use clocksource id for
      get_device_system_crosststamp()".
    
    - Return clocksource id instead of calling dropped arm_arch_timer helpers.
    
    - Always report the CP15 virtual counter to be in use by arm_arch_timer,
      since distinction of Arm physical and virtual counter appears unneeded
      after discussion with Marc Zyngier.

 drivers/virtio/Kconfig          | 13 +++++++++++++
 drivers/virtio/Makefile         |  1 +
 drivers/virtio/virtio_rtc_arm.c | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 7369ecd7dd01..ed3f541032a0 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -203,4 +203,17 @@ config VIRTIO_RTC_PTP
 
 	 If unsure, say Y.
 
+config VIRTIO_RTC_ARM
+	bool "Virtio RTC cross-timestamping using Arm Generic Timer"
+	default y
+	depends on VIRTIO_RTC_PTP && ARM_ARCH_TIMER
+	help
+	 This enables Virtio RTC cross-timestamping using the Arm Generic Timer.
+	 It only has an effect if the Virtio RTC device also supports this. The
+	 cross-timestamp is available through the PTP clock driver precise
+	 cross-timestamp ioctl (PTP_SYS_OFFSET_PRECISE2 or
+	 PTP_SYS_OFFSET_PRECISE).
+
+	 If unsure, say Y.
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 4d48cbcae6bb..781dff9f8822 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
 obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 virtio_rtc-y := virtio_rtc_driver.o
 virtio_rtc-$(CONFIG_VIRTIO_RTC_PTP) += virtio_rtc_ptp.o
+virtio_rtc-$(CONFIG_VIRTIO_RTC_ARM) += virtio_rtc_arm.o
diff --git a/drivers/virtio/virtio_rtc_arm.c b/drivers/virtio/virtio_rtc_arm.c
new file mode 100644
index 000000000000..5185b130b3f1
--- /dev/null
+++ b/drivers/virtio/virtio_rtc_arm.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Provides cross-timestamp params for Arm.
+ *
+ * Copyright (C) 2022-2023 OpenSynergy GmbH
+ */
+
+#include <linux/clocksource_ids.h>
+
+#include <uapi/linux/virtio_rtc.h>
+
+#include "virtio_rtc_internal.h"
+
+/* see header for doc */
+
+int viortc_hw_xtstamp_params(u16 *hw_counter, enum clocksource_ids *cs_id)
+{
+	*hw_counter = VIRTIO_RTC_COUNTER_ARM_VIRT;
+	*cs_id = CSID_ARM_ARCH_COUNTER;
+
+	return 0;
+}
-- 
2.39.2

