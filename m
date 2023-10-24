Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABFF7D4753
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjJXGUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjJXGUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:20:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240010C6;
        Mon, 23 Oct 2023 23:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128447; x=1729664447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Dcfv80fwqkTrnHzYXDt90mV7PVNibcyla57Py1ydYHw=;
  b=BV8DmNoZSZ19E1ujlr+ztnYRbBDvizESX7F32YxbVnfeD3YmUuSBrK93
   ehlUGSKkf3/AvyrcPC7Y4ougAdd53IUMFQpiC/2eL/ckdPsIO2V11WNVl
   X+ULzt01R8hWl+wzWW3rlp9a/XMzyQo4J2A94NgtkraU7kEu1g86rW5Va
   vW1EO90hEGtpk3dioSlOrIgNfkFAPd+2wCYCOUlEa3zJ6o39Hx8GjIUOk
   n959oSPJ6OsPTbIEmv28Sh2EwvxkovySMpRbITa0O+xwGI307FoVwXxZK
   Pc3UAS7zSLgCuhLwZ3eHFuRg1WRV91xuPv/fGv3HvX27QwT3b5dqLpIFH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806564"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806564"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751891335"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751891335"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2023 23:20:42 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net,
        Jonathan.Cameron@Huawei.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 2/6] pinctrl: intel: use acpi_dev_uid_match() for matching _UID
Date:   Tue, 24 Oct 2023 11:50:14 +0530
Message-Id: <20231024062018.23839-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert manual _UID references to use the standard ACPI helper.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3be04ab760d3..999f453344d2 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1694,7 +1694,7 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 		unsigned int i;
 
 		for (i = 0; table[i]; i++) {
-			if (!strcmp(adev->pnp.unique_id, table[i]->uid)) {
+			if (acpi_dev_uid_match(adev, table[i]->uid)) {
 				data = table[i];
 				break;
 			}
-- 
2.17.1

