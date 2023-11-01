Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB687DDD50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjKAHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjKAHit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:38:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB17E4;
        Wed,  1 Nov 2023 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698824324; x=1730360324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KagOix17M6bQzQZUD36jEg+Kj080AKQxOTN/L7teNfM=;
  b=JkO9uUKI4kcVJGjZEajLuDkkolxfNn995ubZ6NgicQOSRir4LnWl/Ha8
   rnuE2wvmIvcRKoskaJjsjUo2y8L2mtqOLWrz3Tjq05zTmbxy2D2xWhWMe
   k9/UBBv/TIZ+w8QQFNd8O8h4OuJpk1nMZTcgszH/iLnLVR8egYjAXeOC2
   YyZWLopYGKrE/QC/Q9r20xp1PfeS5fLjot4k2pdTKeQTYeHwjdTgb7lVD
   qh8bGUROFh13xHhZ4tnQ6qtTsueGWXqZ887plU07JPASK7SMfn1/64hJA
   N6UCfjo7K4/WAWL4BFSyLlqNM8WomdsuB6JIwRC8y+oyjFu2fsxBd3q33
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="9982612"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="9982612"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="934357503"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="934357503"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.34.17])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:38:37 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mmc: block: Fixes for CQE error recovery recovery
Date:   Wed,  1 Nov 2023 09:38:22 +0200
Message-Id: <20231101073827.4772-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Some issues have been found with CQE error recovery.  Here are some fixes.

There is also a patch from Kornel Dulęba:

	https://lore.kernel.org/linux-mmc/e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com/T/#u

which is still under review.
	
Please also note ->post_disable() seems to be missing from
cqhci_recovery_start().  It would be good if ->post_disable()
users could check if this needs attention.


Adrian Hunter (5):
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: cqhci: Increase recovery halt timeout
      mmc: block: Be sure to wait while busy in CQE error recovery
      mmc: block: Retry commands in CQE error recovery
      mmc: cqhci: Warn of halt or task clear failure

 drivers/mmc/core/block.c      |  2 ++
 drivers/mmc/core/core.c       |  9 +++++++--
 drivers/mmc/host/cqhci-core.c | 12 ++++++------
 3 files changed, 15 insertions(+), 8 deletions(-)


Regards
Adrian
