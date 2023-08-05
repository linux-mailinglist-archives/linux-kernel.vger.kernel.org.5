Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742B771083
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjHEQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHEQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:23:17 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050EBCD
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:23:15 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qSK3T-0000d8-2m;
        Sat, 05 Aug 2023 16:23:03 +0000
Date:   Sat, 5 Aug 2023 17:22:53 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v2 0/7] mtd: ubi: allow UBI volumes to provide NVMEM
Message-ID: <cover.1691252291.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series is a follow-up and contains all patches of the previous
series "mtd: ubi: behave like a good MTD citizen"[1] which was meant in
preparation for implementing the NVMEM provider.

The goal is to support embedded Linux devices which got NVMEM bits
stored inside a UBI volume. Representing the UBI volume in the Device
Tree, adding a phandle to be referenced by NVMEM consumers allows such
devices to come up with their correct MAC addresses and device-specific
Wi-Fi calibration data loaded.

In order to be available for other drivers, attaching UBI devices has
to be moved from late_initcall (which is too late for other drivers) to
happen earlier. As an alternative to the existing kernel cmdline
parameter the Device Tree property 'compatible = "linux,ubi";' inside
an MTD partition can be used to have that MTD device attached as UBI
device. MTD partitions which serve as UBI devices may have a "volumes"
firmware subnode with volumes which may be compatible with
"nvmem-cells".

In this way, other drivers (think: Ethernet, Wi-Fi) can resolve and
acquire NVMEM bits using the usual device tree phandle, just this time
the NVMEM content is read from a UBI volume.

[1]: https://patchwork.ozlabs.org/project/linux-mtd/list/?series=353177&state=%2A&archive=both

Changes since v1:
 * include patch to fix exiting Kconfig formatting issues
 * fix typo and indentation in Kconfig

Daniel Golle (7):
  mtd: ubi: improve Kconfig formatting
  mtd: ubi: block: don't return on error when removing
  mtd: ubi: block: use notifier to create ubiblock from parameter
  mtd: ubi: attach MTD partition from device-tree
  mtd: ubi: introduce pre-removal notification for UBI volumes
  mtd: ubi: populate ubi volume fwnode
  mtd: ubi: provide NVMEM layer over UBI volumes

 drivers/mtd/ubi/Kconfig  |  72 ++++++++-------
 drivers/mtd/ubi/Makefile |   1 +
 drivers/mtd/ubi/block.c  | 186 +++++++++++++++++++++++---------------
 drivers/mtd/ubi/build.c  | 160 ++++++++++++++++++++++++---------
 drivers/mtd/ubi/cdev.c   |   4 +-
 drivers/mtd/ubi/nvmem.c  | 189 +++++++++++++++++++++++++++++++++++++++
 drivers/mtd/ubi/ubi.h    |   6 +-
 drivers/mtd/ubi/vmt.c    |  36 ++++++++
 include/linux/mtd/ubi.h  |   2 +
 9 files changed, 507 insertions(+), 149 deletions(-)
 create mode 100644 drivers/mtd/ubi/nvmem.c

-- 
2.41.0
