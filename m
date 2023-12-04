Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAF8029A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 01:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjLDA4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 19:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjLDA4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 19:56:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ECBD7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 16:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701651375; x=1733187375;
  h=from:to:cc:subject:date:message-id;
  bh=zb8oftfqk82UeCnS01ntPGlL3LP4p1h8hJr37z80CQY=;
  b=jL2rUAPXKbQnqsfIr5Uy7M2E0ul5anMgv6yS2l2q4eHyVwu8s15oCITm
   TMol3sZGhdZeeLF+idipl7V41GCciU23RO4/JeWq7J9tnaqo3rMqmVHuK
   yK49cEOSCXI/GSwIh4U6CkeM0ZqEWRjYPkhuhGh03pLqWDJrVy2XLLVJn
   uAnPfIMRXqKiNEq8LVhWvre9Yxnpoz6YK3BNMD7vkV1XbsR/GpgXy3D1w
   CmS0MxoY0wxEZQNmfaFl7bl+075tvzwbvAl5Un6qeVdk2RXDo29QJulJc
   Mj6FuGrlJeIYMmmq9C1iwVHmpBLTrYULX5k+z6tBF9rVpBMsZr/BXkYXy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="393406170"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="393406170"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 16:56:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="861212183"
X-IronPort-AV: E=Sophos;i="6.04,248,1695711600"; 
   d="scan'208";a="861212183"
Received: from shsensorbuild2.sh.intel.com ([10.239.134.197])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2023 16:56:01 -0800
From:   Wentong Wu <wentong.wu@intel.com>
To:     gregkh@linuxfoundation.org, tomas.winkler@intel.com,
        hdegoede@redhat.com, krzk@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, sakari.ailus@linux.intel.com,
        alexander.usyskin@intel.com, zhifeng.wang@intel.com,
        linux-kernel@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v2 0/2] misc: mei: Add support for IVSC device
Date:   Mon,  4 Dec 2023 08:55:42 +0800
Message-Id: <1701651344-20723-1-git-send-email-wentong.wu@intel.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel visual sensing controller (IVSC) device is designed to
control the camera sharing between host IPU for media usage and
IVSC for context sensing (face detection).

IVSC is exposed to host as a SPI device and the protocol used
for communicating with host is MEI. This driver implements the
transport protocol and MEI hardware interfaces for IVSC device.

The firmware downloading for IVSC device is implemented as well.

---
v2:
  - change to `depends on INTEL_MEI_VSC_HW` for INTEL_MEI_VSC Kconfig
  - remove MODULE_ALIAS and add MODULE_DEVICE_TABLE in platform-vsc.c

Wentong Wu (2):
  mei: Add transport driver for IVSC device
  mei: Add MEI hardware support for IVSC device

 drivers/misc/mei/Kconfig         |  24 ++
 drivers/misc/mei/Makefile        |   7 +
 drivers/misc/mei/platform-vsc.c  | 450 +++++++++++++++++++++
 drivers/misc/mei/vsc-fw-loader.c | 822 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/vsc-tp.c        | 555 ++++++++++++++++++++++++++
 drivers/misc/mei/vsc-tp.h        |  50 +++
 6 files changed, 1908 insertions(+)
 create mode 100644 drivers/misc/mei/platform-vsc.c
 create mode 100644 drivers/misc/mei/vsc-fw-loader.c
 create mode 100644 drivers/misc/mei/vsc-tp.c
 create mode 100644 drivers/misc/mei/vsc-tp.h

-- 
2.7.4

