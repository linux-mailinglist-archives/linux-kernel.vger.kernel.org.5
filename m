Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C451E7E486B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbjKGSlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjKGSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:41:11 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2127.outbound.protection.outlook.com [40.107.104.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BD2116;
        Tue,  7 Nov 2023 10:41:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh9sS1j5VLgtSeGm1RAm79fXm/5zaFuu6xeo0+yHrQWrd+3uKteJW5Z7YJGvyIFvxku4OefnyvSabxxcJi2j2XTbRIsuDKx9PytePkpGLoDLt/rI2engzE6Lfqvhcbvd9THVMFTuKMFeTD27aU9s/vZMeGsbC+XCPIm8JIWI/qo4uN1K5X6/CVIrE6vllfzK0m8LfS9+C1Z6ke9dp1jSLW8AhUzAfpZlLMN833z+b5FNzc3LvTP7wP6cr/TiPvJZCBeUNPD93AiaG0csAtf2sboh2HgNS4IZ1PYx/98sF2LCcJO2UnuyPxrnkyhwHs89lJHER8hA8byDHFEFpJg5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI6dtr7mDyzUnl9YQNWjQC8BHqVulDEKIYKi/lFBcj4=;
 b=bfL/NwqOYpHXpulwdC6JUXMq/Xog/PWhRlZCl3go+ydit0EK62wA4W09NbC/9c1xQHiQl+jVo4TbeovTORxuVwk1jZRG9pgCPj9lg4fgh4amZLXUxjyKCq+tgTSfXU4RhC7/0gMhyObgJPryw1/1HxwsAKl03K6iusIM5iqs1bpqQNo84q7rFWAiyAAtuJqGCzyC52LKNBAiXOzQTn9Fr6ufdBX7QdMvqslyOkgjAMMqRhawKcjTYI/4SU6pQL8PnW/obGHBso8hP0VnbHBeMk/Ve0LSIOPi8QKmr6iKZAy2hWukeg1TRjBrnE+xs77eaT+K7QW90CaZOECqJa4JAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 80.151.164.27) smtp.rcpttodomain=davemloft.net smtp.mailfrom=esd.eu;
 dmarc=none action=none header.from=esd.eu; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI6dtr7mDyzUnl9YQNWjQC8BHqVulDEKIYKi/lFBcj4=;
 b=PdxEmwLbIMugvDYDaDPQzdPUwvoj7xwg4RPLqput1u3Sj8+EPbh4EF3KnXV3GRHYklxUwHnzn97gHu2ih+6DepKQ00PijxJC83XM6W6r3cB+BZHUeqf4dBUq3B6fi5pm4/K2k55y6yzkmOZplcsnI44v1LbAkGMP+jpjsyfEoXw=
Received: from AM6PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:20b:2e::14)
 by GV1PR03MB8544.eurprd03.prod.outlook.com (2603:10a6:150:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 18:41:04 +0000
Received: from AM4PEPF00025F98.EURPRD83.prod.outlook.com
 (2603:10a6:20b:2e:cafe::74) by AM6PR05CA0001.outlook.office365.com
 (2603:10a6:20b:2e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Tue, 7 Nov 2023 18:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 80.151.164.27) smtp.mailfrom=esd.eu; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning esd.eu
 discourages use of 80.151.164.27 as permitted sender)
Received: from esd-s7.esd (80.151.164.27) by
 AM4PEPF00025F98.mail.protection.outlook.com (10.167.16.7) with Microsoft SMTP
 Server id 15.20.7002.1 via Frontend Transport; Tue, 7 Nov 2023 18:41:03 +0000
Received: from esd-s20.esd.local (debby [10.0.0.190])
        by esd-s7.esd (Postfix) with ESMTPS id 7575D7C16C5;
        Tue,  7 Nov 2023 19:41:03 +0100 (CET)
Received: by esd-s20.esd.local (Postfix, from userid 2044)
        id 62A6A2E446A; Tue,  7 Nov 2023 19:41:03 +0100 (CET)
From:   =?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v9 0/2] can: esd: add support for esd GmbH PCIe/402 CAN interface
Date:   Tue,  7 Nov 2023 19:41:01 +0100
Message-Id: <20231107184103.2802678-1-stefan.maetje@esd.eu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|GV1PR03MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bbd583-d6e0-40e2-dc77-08dbdfc1189f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9Q1x6FSbvliAkt6u/L4lQZWyE6p+yw1Lhh2SWzBfx6Eu5m+DxkdJ1knW+Ed9N4QHdbvBN8f6N97zEOPElMze0aQ9bHiy9gb6RXy4kjey+RnpEtm/wZ/pmM5igdRwTESBI26Z8E1cEmwxk5f3u/NFbS+7qdeLhqoEHsuils5gbLNW1CCtTfJvkC8KlFBd35UrxeUbQWHhgncNdj9FA41tLgFrm/QRwwmntZudeVVsLKgkI5x3iAZcfCZ8tc/FXxZjJ6xGP8BijXm0YrA7+HHlPAeeYZVu/LNf4JFGhsdjziR4pLL7Gd67quy2ATiQolQVgj1hAsIYFqrZAo31YMamoexwhB5ClNabEY8gfPl0mrc0xIEhnyhJXjXgLYqEyExM6Q0prXcuQzLbLDrADmeADhKa3NjKuLed8hU4Mcw9BbmVBpanWSqCai5B/DnKzCAdPu6LOxp3aHWTguc/nC+BhdApjJfgzciex25dijOU6rdtpU8OmPNdaM7fu6vqIMgtveQ1ipOc/aaB1zY+uhbNq3GknTkT5k3a4aGXJpOgqGIzmipF0PJDECseYebv5RCxAxLOPhlsxelxP8YKJqf7aKwZhVrmjdLL2vVtaAFogsc5ZzZSUDuLYHWSkKALoQv5xdZaI6+DeuCweguXHxp/+VcSQUg8IrUv5DIlu6XnqJcSvpWgv8elPaNKt9Tbd65EuVaHM2pbLe7ENlDB4qiwNcbK4Vd9YEyaIr7CB6xKLMx+2Gyzzn0Ey6ik81i+rQ/
X-Forefront-Antispam-Report: CIP:80.151.164.27;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:esd-s7.esd;PTR:p5097a41b.dip0.t-ipconnect.de;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39840400004)(230173577357003)(230273577357003)(230922051799003)(82310400011)(1800799009)(451199024)(64100799003)(186009)(36840700001)(46966006)(2616005)(356005)(40480700001)(81166007)(86362001)(478600001)(966005)(36756003)(8676002)(4326008)(336012)(26005)(8936002)(47076005)(41300700001)(54906003)(66574015)(42186006)(70586007)(83380400001)(70206006)(316002)(1076003)(36860700001)(2906002)(6266002)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:41:03.7087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bbd583-d6e0-40e2-dc77-08dbdfc1189f
X-MS-Exchange-CrossTenant-Id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5a9c3a1d-52db-4235-b74c-9fd851db2e6b;Ip=[80.151.164.27];Helo=[esd-s7.esd]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8544
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch picks up the work from last year. Any comments on needed or
recommended changes are appreciated.

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



Stefan Mätje (2):
  MAINTAINERS: add Stefan Mätje as maintainer for the esd electronics
    GmbH PCIe/402 CAN drivers
  can: esd: add support for esd GmbH PCIe/402 CAN interface family

 MAINTAINERS                            |   7 +
 drivers/net/can/Kconfig                |   1 +
 drivers/net/can/Makefile               |   1 +
 drivers/net/can/esd/Kconfig            |  12 +
 drivers/net/can/esd/Makefile           |   7 +
 drivers/net/can/esd/esd_402_pci-core.c | 512 ++++++++++++++++
 drivers/net/can/esd/esdacc.c           | 771 +++++++++++++++++++++++++
 drivers/net/can/esd/esdacc.h           | 393 +++++++++++++
 8 files changed, 1704 insertions(+)
 create mode 100644 drivers/net/can/esd/Kconfig
 create mode 100644 drivers/net/can/esd/Makefile
 create mode 100644 drivers/net/can/esd/esd_402_pci-core.c
 create mode 100644 drivers/net/can/esd/esdacc.c
 create mode 100644 drivers/net/can/esd/esdacc.h


base-commit: 93e7eca853ca0087b129433630ddd89288d2b8b4
-- 
2.34.1

