Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA079B8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347328AbjIKVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbjIKNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:16:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB10EB;
        Mon, 11 Sep 2023 06:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694438176; x=1725974176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hhntH08KwDzWZFhlYntAoxLtfPyiIglkNSydQprvVBY=;
  b=RV7fzJqTsQdOG9xacXnLCeJFPasq0HpTZnEF/cxL3e2LiOv3h+/hWsI+
   G0lKUGCdUAEBEgXi96Nw6mPVejtj0cwvA8DFFbupuoS7TOgAt6+J3JSp6
   vbPZg3tcKNDadsZgCMl8movxIHL30v6OtJ3bxQxC8Ga4bFHFDs4/pMA45
   N9D4j8OF21Wl7/SntIB+upI2nchbx8ejXGE2cBIwIkZru6HSOQApHvhTI
   hfza0geP2LvybY+0gb9lSrXHsjMHROmZObywDJj38+uzBiHdJDCzoVQDN
   Rs7NFXn9Z+onaN2vYi/S3Spr+qwHSDgJzj209vkcRmn8tT1itAL+qNTfb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377990534"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377990534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="719982415"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="719982415"
Received: from unknown (HELO bapvecise024..) ([10.190.254.46])
  by orsmga006.jf.intel.com with ESMTP; 11 Sep 2023 06:16:12 -0700
From:   sharath.kumar.d.m@intel.com
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, dinguyen@kernel.org, kw@linux.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lpieralisi@kernel.org, robh@kernel.org, sharath.kumar.d.m@intel.com
Subject: [PATCH v3 0/2] PCI: altera: add support to agilex family
Date:   Mon, 11 Sep 2023 18:46:47 +0530
Message-Id: <20230911131649.1775971-1-sharath.kumar.d.m@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906110918.1501376-3-sharath.kumar.d.m@intel.com>
References: <20230906110918.1501376-3-sharath.kumar.d.m@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

added new callback for
1) read,write to root port configuration registers
2) read,write to endpoint configuration registers
3) root port interrupt handler

agilex and newer platforms need to implemant the callback and generic root 
port driver should work ( without much changes ) , legacy platforms (arria
 and startix) implement configuration read,write directly in wrapper 
api _altera_pcie_cfg_read/_altera_pcie_cfg_write

changelog v2:
saperated into two patches
1.refactored the driver for easily portability to future Altera FPGA
platforms
2.added support for "Agilex" FPGA

this driver supports PCI RP IP on Agilex FPGA, as these are FPGA its up
to the user to add PCI RP or not ( as per his needs). we are not adding
the device tree as part of this commit. we are expecting the add device
tree changes only if he is adding PCI RP IP in his design

changelog v3:
incorporate review comments from Bjorn Helgaas


D M Sharath Kumar (2):
  PCI: altera: refactor driver for supporting new platforms
  PCI: altera: add support for agilex family fpga

 drivers/pci/controller/pcie-altera.c | 305 ++++++++++++++++++++++++---
 1 file changed, 275 insertions(+), 30 deletions(-)

-- 
2.34.1

