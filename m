Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E47E2C29
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjKFSlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjKFSlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:41:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784BFD57
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699296059; x=1730832059;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nDaE5gZt44QLBdwS8FvZ6dreGzaftv8+ViIX+mgmasM=;
  b=Y3O0hyLwLqClC2gOpufm6/5V3uPGD8+vsTHdWxVOCpm1EO6/6DBEj8GW
   4q2+Wzw82LvEOShbQNrD5Nev1AmiKD1eFCpi/Nu0a0z4t1GgfDd5puul0
   +Uq4/Du9hgZ/0ZCswk0wUJBqtoW3F5mtk0k9xY7T5SuAdWCNxFWpYk/s6
   j4PamHpFVF6HRKDmIk8zE0Rnn3w7+wQdAD5W1+6IfTZWfuQxBCPXDcQId
   KTzdSM5j5xRwX5LvDaTqX8PZ86WIB1dxGJ/Madf1h9ya3eFiBIA7nBc1e
   mIZnsDTEC+Vqj20hpMkihZdiK+BM+EA4SgwlVRMWzLEgsuyYUfLWkZL+8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="7975895"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="7975895"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 10:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="832807950"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="832807950"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2023 10:40:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 365961A5; Mon,  6 Nov 2023 20:40:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen Ni <nichen@iscas.ac.cn>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v3 0/2] mfd: intel-lpss: refactor PCI probe and common IRQ check
Date:   Mon,  6 Nov 2023 20:40:50 +0200
Message-Id: <20231106184052.1166579-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCI code can be refactored to use respective PCI APIs instead of
direct dereference of struct pci_dev members.

With that, we may unshadow the error code that is promoted in the irq
field of info structure. PCI core shouldn't propagate 0 as a value
there, and in case it happens it reveals a bug somewhere else.

Changelog:

v2 -> v3:
1. Refactored PCI glue driver a bit (a new patch)
2. Updated commit message in the original patch

v1 -> v2:
1. Update commit message
2. Fix IRQ check in intel_lpcc_probe()

Andy Shevchenko (1):
  mfd: intel-lpss: Use PCI APIs instead of derefereincing

Chen Ni (1):
  mfd: intel-lpss: Amend IRQ check

 drivers/mfd/intel-lpss-pci.c | 8 ++++++--
 drivers/mfd/intel-lpss.c     | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.40.0.1.gaa8946217a0b

