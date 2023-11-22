Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F127F4BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344090AbjKVQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKVQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:02:19 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2125.outbound.protection.outlook.com [40.107.22.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD5D8;
        Wed, 22 Nov 2023 08:02:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKc7hLB7Au1IYBeHqB9L/HAnSOM2rHQSUvYF/6X80OTFxu6a1XV5RhdKaP5FgfuubefdI2+KYpfR5Ngr+oy0Ej5xpmNgDAf3/QWM+k2RoU7QamKf6q+BugvQXLZAHsXKM13hYb3ltH8ZrhYz1efJbQey/jgUvYYnGwInqkw0P2DYchfUX8V+dIkGm9MqjM12wApzKMnydHd23YdFXnhwss8EBsWUdovnLjyY80JxM1tGppI4o48zZEhgA8iLtBohgxzD6e8+deNM9+A8rinGBCuHYKxXqUIjBstcV5agl/2ucz6vnLHz/UcTTGqX3cBf6QetmXIR99zcfyaiBwN5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsU9ILfuRC/5eWTiILi67PMBmVNgHMOPJcgIO8N/CbA=;
 b=RjiA69hA9YWrUhK52XHBzuX1jaU+3QTQ5PhULk6//2D8S6+XdG34y+rk56av/cjkChh/UDxvfhls5D/HjOfM4FVAFrgk3DvcONzkLA+RIHddiKnDuXtacfF1W6COL5mFFziYQGC5aSEG/QDB5A64sBY6yACYXuAbrAhTb2y+Xre/qdZ7JJs58eo5jaAAooFT/pb2vDcMCG/ALvESCxpNI72yRgTmcJWc9rGiIar7VaSYPZDCdBeI9OUSryZ8bRcG8Y1yr4ZwdVJ85SKCGsOFGlXIir9ClGFr7DSyUIR6Mvu7eCxfqFDxCAAV3IldrS7QrTP5GOPX5ffD7am9CHOC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsU9ILfuRC/5eWTiILi67PMBmVNgHMOPJcgIO8N/CbA=;
 b=ciilTqVcoTRK4yHVdaYyElCBBMjua8cirW8k5UpH7GCrryKogw//KzGVAtC04wOyAJFjzj0GFQi4xRIbKzThh4yNqiGpsenMuigFPnUq5SefeVFHdZ92WAzjtPpwFlQPDIOhn0VE3AwCvr3PmnauyrZhOb0LJfUY5CgHsiFofsU=
Received: from DU6P191CA0050.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::13)
 by PAVPR03MB9504.eurprd03.prod.outlook.com (2603:10a6:102:303::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 16:02:12 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::d0) by DU6P191CA0050.outlook.office365.com
 (2603:10a6:10:53e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Wed, 22 Nov 2023 16:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.7025.13 via Frontend Transport; Wed, 22 Nov 2023 16:02:11
 +0000
Received: from esd-s20.esd.local (jenkins.esd [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTPS id 864CF7C16C5;
        Wed, 22 Nov 2023 17:02:11 +0100 (CET)
Received: by esd-s20.esd.local (Postfix, from userid 2044)
        id 70DD32E2605; Wed, 22 Nov 2023 17:02:11 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v11 0/2] can: esd: add support for esd GmbH PCIe/402 CAN interface
Date:   Wed, 22 Nov 2023 17:02:09 +0100
Message-Id: <20231122160211.2110448-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|PAVPR03MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 0958697e-dfad-4cb4-4d91-08dbeb74635f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kC1Z6TJl3exUkWGbqJiIqo/avPJiDTQU1APMdRwXM3vKA9hps2gG36gu2kgMAp04hBdAvfz0mVSN1XgDLWOSGa6XlnW3toxR4n/zI8NfX0+a3oQ6BPMPsUxb5uS0W+2k2K3mDyRTB3SI5GZC+urxEfEMLodNgoAZ6imoca4WEsir7wvdfqOxUvA02q+l/KehuWQXm1O4ASyZpszwXZ9otZyf/d7Xdsw2ZGXtR+/8kWQtVQSJfijNO2w+8P1V6hpfEd/wNViSk/9Rzln7OyWvMWQsUiWS+M0fJMkmpRIl8Xnc4d7dQupJjJjUfo4lmyoqOmneFeqJgpwOcvUayTz/i+WAAcKbMj0Gt+tAfZTD14n/lwzwBevQ/fVgSst90s1882Z44hxNNvvVQVVjfAFnL4au1EsnFSuz8ElaRrg48IBL3Tt06+A7CyqE9egjGZpBqY/kQR7zc7hHoSXnKvOXzwwzerBjhpIgcXYKXRYOgstfrt48QQMPrO3xzlIeaD9Av9otT6NedPxS+UbEetY3bUxQTjINfB4RrZY7CxBThAiZ+G++DBfGhcRSNMMhfP6evvpOtr2q/f2kVZWzCAJE9DYlYez0o4pia1g5ZVauHxF3FwweJ3DvWz2n60C2ukug9I7VcOfaPA5IH+tLKz5On31ZYGTHn8LOclJ5+69Yv5qnBNl8m8AAh2SPeAhjqee2sv0yF+HtA7cFTlsSgUtoAhLj36axQNB9QhUSHM0YlpkNZBh+SjBHrX0xsPXXrGf0
X-Forefront-Antispam-Report: CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39840400004)(396003)(230922051799003)(230273577357003)(230173577357003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(36840700001)(46966006)(41300700001)(40480700001)(86362001)(8676002)(2906002)(5660300002)(83380400001)(81166007)(356005)(4326008)(36756003)(70586007)(42186006)(54906003)(316002)(966005)(8936002)(2616005)(478600001)(26005)(1076003)(6266002)(66574015)(336012)(36860700001)(47076005)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 16:02:11.8043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0958697e-dfad-4cb4-4d91-08dbeb74635f
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9504
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patch is to introduce a new CAN driver to support
the esd GmbH 402 family of CAN interface boards. The hardware design
is based on a CAN controller implemented in a FPGA attached to a
PCIe link.

More information on these boards can be found following the links
included in the commit message.

This patch supports all boards but will operate the CAN-FD capable
boards only in Classic-CAN mode. The CAN-FD support will be added
when the initial patch has stabilized.

The patch is reuses the previous work of my former colleague:
Link: https://lore.kernel.org/linux-can/1426592308-23817-1-git-send-email-thomas.koerper@esd.eu/


The patch is based on the linux-can-next main branch.

Changed in v11:
  No functional, only editorial changes due to feedback on v10.
  - Make lifetime of macros used for hardware timestamp calculation
    very short by #undef-ing them after use.
  - Fixed insertion order of new entry in MAINTAINERS file.

Changed in v10:
  Most changes due to feedback by Vincent Mailhol
  https://lore.kernel.org/linux-can/CAMZ6RqLOAC930GNOU+pWuoi6FgYwFOuFrSyAzVjvE2fuVgy8oA@mail.gmail.com/
  - Add support for ethtool operations by using default operations 
    provided by the can_dev module for drivers with hardware time
    stamp support.
  - Factor out core unregistration into pci402_unregister_core().
  - Factor out getting next TX fifo index into acc_tx_fifo_next().
  - Stop counting alloc_can_err_skb() failures in rx_dropped statistic.
  - Add CAN_ERR_CNT flag in CAN error frames as needed.
  - Rework function acc_reset_fpga(). To clear I^2C bus enable bit
    is not necessary after FPGA reset.
  - Simplify struct acc_bmmsg_rxtxdone layout.
  - Additional non functional changes due to feedback by Vincent
  - Some spelling corrections: ESDACC -> esdACC

Changes in v9:
  - Fix returning success error code in case of allocation failure in
    pci402_probe().

Changes in v8:
  - Rebased to 6.6-rc2 on linux-can-next branch main

Changes in v7:
  - Numerous changes. Find the quoted with inline comments about changes
    below after the changes list. Stuff that I don't understand and
    where I have questions is marked with ????.
    Unfortunately I will be AFK till 28th of November.

Changes in v6:
  - Fixed the statistic handling of RX overrun errors and increase 
    net_device_stats::rx_errors instead of net_device_stats::rx_dropped.
  - Added a patch to not increase rx statistics when generating a CAN
    rx error message frame as suggested on the linux-can list.
  - Added a patch to not not increase rx_bytes statistics for RTR frames
    as suggested on the linux-can list.

    The last two patches change the statistics handling from the previous
    style used in other drivers to the newly suggested one.

Changes in v5:
  - Added the initialization for netdev::dev_port as it is implemented
    for another CAN driver. See
    https://lore.kernel.org/linux-can/20211026180553.1953189-1-mailhol.vincent@wanadoo.fr/

Changes in v4:
  - Fixed the build failure on ARCH=arm64 that was found by the Intel
    kernel test robot. See
    https://lore.kernel.org/linux-can/202109120608.7ZbQXkRh-lkp@intel.com/

    Removed error monitoring code that used GCC's built-in compiler
    functions for atomic access (__sync_* functions). GCC versions
    after 9 (tested with "gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04)")
    don't implement the intrinsic atomic as in-line code but call
    "__aarch64_ldadd4_acq_rel" on arm64. This GCC support function
    is not exported by the kernel and therefore the module build
    post-processing fails.

    Removed that code because the error monitoring never showed a
    problem during the development this year.


Changes in v3:
  - Rework the bus-off restart logic in acc_set_mode() and
    handle_core_msg_errstatechange() to call netif_wake_queue() from the
    error active event.
  - Changed pci402_init_card() to allocate a variable sized array of
    struct acc_core using devm_kcalloc() instead of using a fixed size
    array in struct pci402_card.
  - Changed handle_core_msg_txabort() to release aborted TX frames in
    TX FIFO order.
  - Fixed the acc_close() function to abort all pending TX request in
    esdACC controller.
  - Fixed counting of transmit aborts in handle_core_msg_txabort().
    It is now done like in can_flush_echo_skb().
  - Fixed handle_core_msg_buserr() to create error frames including the
    CAN RX and TX error counters that were missing.
  - Fixed acc_set_bittiming() neither to touch LOM mode setting of
    esdACC controller nor to enter or leave RESET mode.
    The esdACC controller is going active on the CAN bus in acc_open()
    and is going inactive (RESET mode) again in acc_close().
  - Rely on the automatic release of memory fetched by devm_kzalloc().
    But still use devm_irq_free() explicitely to make sure that the
    interrupt handler is disconnected at that point.
    This avoids a possible crash in non-MSI mode due to the IRQ
    triggered by another device on the same PCI IRQ line.
  - Changed to use DMA map API instead of pci_*_consistent compatibility
    wrappers.
  - Fixed stale email references and updated copyright information.
  - Removed any traces of future CAN-FD support.


Changes in v2:
  - Avoid warning triggered by -Wshift-count-overflow on architectures
    with 32-bit dma_addr_t.
  - Fixed Makefile not to build the kernel module always. Doing this
    renamed esd402_pci.c to esd_402_pci-core.c as recommended by Marc.

previous versions:
v1 - https://lore.kernel.org/linux-can/20210728203647.15240-1-Stefan.Maetje@esd.eu/
v2 - https://lore.kernel.org/linux-can/20210730173805.3926-1-Stefan.Maetje@esd.eu/
v3 - https://lore.kernel.org/linux-can/20210908164640.23243-1-stefan.maetje@esd.eu/
v4 - https://lore.kernel.org/linux-can/20210916172152.5127-1-stefan.maetje@esd.eu/
v5 - https://lore.kernel.org/linux-can/20211109155326.2608822-1-stefan.maetje@esd.eu/
v6 - https://lore.kernel.org/linux-can/20211201220328.3079270-1-stefan.maetje@esd.eu/
v7 - https://lore.kernel.org/linux-can/20221106224156.3619334-1-stefan.maetje@esd.eu/
v8 - https://lore.kernel.org/linux-can/20231025141635.1459606-1-stefan.maetje@esd.eu/
v9 - https://lore.kernel.org/linux-can/20231107184103.2802678-1-stefan.maetje@esd.eu/
v10 - https://lore.kernel.org/linux-can/20231120175657.4070921-1-stefan.maetje@esd.eu/


Stefan Mätje (2):
  MAINTAINERS: add Stefan Mätje as maintainer for the esd electronics
    GmbH PCIe/402 CAN drivers
  can: esd: add support for esd GmbH PCIe/402 CAN interface family

 MAINTAINERS                            |   7 +
 drivers/net/can/Kconfig                |   1 +
 drivers/net/can/Makefile               |   1 +
 drivers/net/can/esd/Kconfig            |  12 +
 drivers/net/can/esd/Makefile           |   7 +
 drivers/net/can/esd/esd_402_pci-core.c | 514 +++++++++++++++++
 drivers/net/can/esd/esdacc.c           | 764 +++++++++++++++++++++++++
 drivers/net/can/esd/esdacc.h           | 356 ++++++++++++
 8 files changed, 1662 insertions(+)
 create mode 100644 drivers/net/can/esd/Kconfig
 create mode 100644 drivers/net/can/esd/Makefile
 create mode 100644 drivers/net/can/esd/esd_402_pci-core.c
 create mode 100644 drivers/net/can/esd/esdacc.c
 create mode 100644 drivers/net/can/esd/esdacc.h


base-commit: 93e7eca853ca0087b129433630ddd89288d2b8b4
-- 
2.34.1

