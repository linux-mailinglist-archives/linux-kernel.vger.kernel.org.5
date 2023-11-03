Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CB7E0095
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjKCIsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjKCIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:48:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570BD5E;
        Fri,  3 Nov 2023 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699001291; x=1730537291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pgGJxu22SuOko7jFYhtpgXsdMllFfBeSM101ozpIhzo=;
  b=XVk89u7TqoH56DMFL2Zr2HGqAPdC1fevrvR0Eg4cBOGHWBkYEUfzoMKm
   a72Ec0bwa06gjgLPEvDHpM8Mm42WInjb5rtkZCQFIKcJph/5P4STYH6so
   6I7Pp/86bPqSCtcWuxPiWdOW2QNax4OonXw0ecCd90AxK21uBQ/UUpJ+O
   VXmb1DQ1iZRGDA8NMojKlFqwZD4oJqcm6MOOznzd+L9rGxwANhnOODEcm
   0uKLdarRC3tYNhWRJwWFEbXuXAzUSsyqT3bBoqvYri+cqpkazxtmwfT6Y
   gHGYG80lYvXdIW7A9PpDNLh8bLEMv85ckUpfBvaALwgsKivPt1N9ah3Rb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="391774470"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391774470"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796556409"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="796556409"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:48:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <korneld@chromium.org>,
        Radoslaw Biernacki <biernacki@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Bhavya Kapoor <b-kapoor@ti.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Thierry Reding <thierry.reding@gmail.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] mmc: block: Fixes for CQE error recovery recovery
Date:   Fri,  3 Nov 2023 10:47:14 +0200
Message-Id: <20231103084720.6886-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Some issues have been found with CQE error recovery.  Here are some fixes.

As of V2, the alternative implementation for the patch from Kornel Dulęba:

	https://lore.kernel.org/linux-mmc/e7c12e07-7540-47ea-8891-2cec73d58df1@intel.com/T/#u

is now included, see patch 6 "mmc: cqhci: Fix task clearing in CQE error
recovery")
	
Please also note ->post_disable() seems to be missing from
cqhci_recovery_start().  It would be good if ->post_disable()
users could check if this needs attention.


Changes in V2:

      mmc: cqhci: Fix task clearing in CQE error recovery
            New patch

      mmc: cqhci: Warn of halt or task clear failure
            Add fixes and stable tags


Adrian Hunter (6):
      mmc: block: Do not lose cache flush during CQE error recovery
      mmc: cqhci: Increase recovery halt timeout
      mmc: block: Be sure to wait while busy in CQE error recovery
      mmc: block: Retry commands in CQE error recovery
      mmc: cqhci: Warn of halt or task clear failure
      mmc: cqhci: Fix task clearing in CQE error recovery

 drivers/mmc/core/block.c      |  2 ++
 drivers/mmc/core/core.c       |  9 +++++++--
 drivers/mmc/host/cqhci-core.c | 44 +++++++++++++++++++++----------------------
 3 files changed, 31 insertions(+), 24 deletions(-)


Regards
Adrian
