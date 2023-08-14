Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3E77B0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjHNFk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjHNFkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:40:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D79E71;
        Sun, 13 Aug 2023 22:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691991646; x=1723527646;
  h=from:to:cc:subject:date:message-id;
  bh=nYZF3okRMBxK/5mEwcejYZOl3UpHDjty5L9+0uR6/cU=;
  b=hxi1yc4yCaGhlNYo8FXvus9fPfnkUS+67UrqIyw03iFMNsPKT9mF7PUi
   z7hA1jyBvKSA9YKdiqHEshKGz36dMfdiVf5J3Hgompk1xm22EM5j0jma5
   PM7e1DXAX5XANElwkjw9G+wrrntqtVqxMp/bSYXhZhhMOMNXj5966ht4N
   KvQIK9IGKxNIsyzAesGzfVXgkwyiqw4saR8tpEn7hUqZ3MvAbIt3G4KDU
   UXmECYSbLAj44hP/zgJfvE8DvWkfortlrK7NU9AfqW5KGxkBtCEiKBjuB
   WQfJyOTy5asjG7KFinoheZ5bmZuzntkJOy9bgvTpx0ybQ72FtB/NuX1r4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="435860567"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="435860567"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 22:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="847511992"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="847511992"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 13 Aug 2023 22:40:43 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/3] Introduce Intel Tangier pinctrl driver
Date:   Mon, 14 Aug 2023 11:10:30 +0530
Message-Id: <20230814054033.12004-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merrifield and Moorefield pinctrl driver implementations are similar
in terms of how they access the hardware. We can consolidate their
pinctrl functionalities into a common library driver.

This patch set introduces:

1. Intel Tangier driver that supports the common pinctrl functionalities
   for Merrifield and Moorefield platforms.

2. Intel Tangier adaptation for Merrifield pinctrl driver.

3. Intel Tangier adaptation for Moorefield pinctrl driver.

Tested on Intel Edison platform.
No deviation observed in the contents of below entries before and after
this patchset.

- /proc/interrupts
- /sys/kernel/debug/gpio
- /sys/kernel/debug/pinctrl/*/pins 

Raag Jadav (3):
  pinctrl: tangier: Introduce Intel Tangier driver
  pinctrl: merrifield: Adapt to Intel Tangier driver
  pinctrl: moorefield: Adapt to Intel Tangier driver

 drivers/pinctrl/intel/Kconfig              |  23 +-
 drivers/pinctrl/intel/Kconfig.tng          |  33 +
 drivers/pinctrl/intel/Makefile             |   1 +
 drivers/pinctrl/intel/pinctrl-merrifield.c | 677 +--------------------
 drivers/pinctrl/intel/pinctrl-moorefield.c | 640 +------------------
 drivers/pinctrl/intel/pinctrl-tangier.c    | 589 ++++++++++++++++++
 drivers/pinctrl/intel/pinctrl-tangier.h    |  92 +++
 7 files changed, 778 insertions(+), 1277 deletions(-)
 create mode 100644 drivers/pinctrl/intel/Kconfig.tng
 create mode 100644 drivers/pinctrl/intel/pinctrl-tangier.c
 create mode 100644 drivers/pinctrl/intel/pinctrl-tangier.h

-- 
2.17.1

