Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763CD79376A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjIFItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbjIFItB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:49:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4225E6B;
        Wed,  6 Sep 2023 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693990126; x=1725526126;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QnEYZmewzQcMJtN7H2Ym8u5UlCnKVrIEBx/esVRkV3Q=;
  b=ToP/hqjSOqBn3Q+oKKl6QHFxmf0ikfVHkacAHUPwE/l/RDaSgUkOu6WZ
   fPA0VjrXW1u4f26V4+EmlA0yWL4M0ncTb2PJ/1AqZj5aQcoXapigYmTjN
   NuOY7tA4tbjvVfB5jTgLCfYPaRNXaMTCIe3v6x/OWeM4p+MhVoqeXI9Gq
   11PXQ8XfXhPTpLuebrW2Z/0RWxYEoRf6MsJp5k5ADVPd/vzWXuaO/42y8
   CAMFledKQalqrozKTrr9ANAwSrvVs8uMv/YGOBHxC1M9PmMCHWMzPmJz2
   9oGqMdck6DNFGTIZHHWeTo/212MzcWryAfAFIRuyaoy3cLIef4Z9jJBLr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="379723145"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="379723145"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 01:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884615744"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884615744"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2023 01:48:32 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Saranya Gopal <saranya.gopal@intel.com>
Subject: [PATCH] usb: typec: ucsi: Fix NULL pointer dereference
Date:   Wed,  6 Sep 2023 11:48:42 +0300
Message-Id: <20230906084842.1922052-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making sure the UCSI debugfs entry actually exists before
attempting to remove it.

Fixes: df0383ffad64 ("usb: typec: ucsi: Add debugfs for ucsi commands")
Reported-by: Dave Hansen <dave.hansen@intel.com>
Closes: https://lore.kernel.org/linux-usb/700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com/
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: Saranya Gopal <saranya.gopal@intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/ucsi/debugfs.c b/drivers/usb/typec/ucsi/debugfs.c
index 0c7bf88d4a7f..f67733cecfdf 100644
--- a/drivers/usb/typec/ucsi/debugfs.c
+++ b/drivers/usb/typec/ucsi/debugfs.c
@@ -84,6 +84,9 @@ void ucsi_debugfs_register(struct ucsi *ucsi)
 
 void ucsi_debugfs_unregister(struct ucsi *ucsi)
 {
+	if (IS_ERR_OR_NULL(ucsi) || !ucsi->debugfs)
+		return;
+
 	debugfs_remove_recursive(ucsi->debugfs->dentry);
 	kfree(ucsi->debugfs);
 }
-- 
2.40.1

