Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F217FE604
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjK3Bc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3Bc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:32:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C016198;
        Wed, 29 Nov 2023 17:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701307985; x=1732843985;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=OZ7QBhsz/McCUCLn0s7kP4b8+WfiCMEVWPXNRdn2ufI=;
  b=FxPqlOzmNpUCRsp6Z1dM2VECYF0sLzeiqHMpPDhiqS1+dX5Ia/fgSByx
   8oS/ECKqnQkR0QRre8FSgst3i/N6xKLJBJuX1GAOHaLBL+GldLss6m3XE
   qfDnEaOtFlq1JKOOcPFHypqMtM5ZvhCeIVM7e82dK94DVLEz+7+K1+B5S
   RvZEDmT0P29E4BFSU8GKDpoX0T56DMp9Y9jQ+7AQcdum1KeDi0GQk8tOU
   OuOQav9DuzTfwxe68+TYxCXvlnf1SeHgrmlGeuJE15d5y+7Ay+ocLgKa+
   4jxBXHSleiGEcoYrzIm1FsUnYqDXyI6V3immE/iMFhM94pzyu9f4KMqoG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="131545"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="131545"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016467440"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016467440"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.173.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:33:03 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/2] cxl/cdat: Fixes for CXL CDAT processing
Date:   Wed, 29 Nov 2023 17:33:02 -0800
Message-Id: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7mZ2UC/22OQQ7CMAwEv4J8xqg2VYs48Q/UQ+o4NBKkKKkiU
 NW/k/TMcawd766QNHpNcD2sEDX75OdQgI8HkMmEh6K3hYEbPhNRj85/UKxZUBKai9qeVZjbFoo
 xmqQ4RhNkqo4zAa1YtJqx+kiE1NXgO2r5s9feh8KTT8scv/uKTPX6vzATNuic8EjUienk5sOiz
 5PMLxi2bfsB65cEwc8AAAA=
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701307983; l=862;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=OZ7QBhsz/McCUCLn0s7kP4b8+WfiCMEVWPXNRdn2ufI=;
 b=5CoAcq80TbPUWWrIEW1Gl8BbeiOlYgrfzNiC+LYv+YwwlKufAmr+pL0l26c/uTAMcOfcWkako
 AUAThdmLB/QCT/FGK5J4Oclly9ZOXugn7Lb8zvuo5c62ah/y/A2s+LL
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a couple of fixes needed for DCD processing.  The first is via
code inspection and the second was found as a result of the kernel bug
found previously.[1]

[1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- [iweiny: add fixes tags]
- [djiang: remove do {} while (0);]
- Link to v1: https://lore.kernel.org/r/20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com

---
Ira Weiny (2):
      cxl/cdat: Handle cdat table build errors
      cxl/cdat: Fix header sum value in CDAT checksum

 hw/cxl/cxl-cdat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
---
base-commit: abe893944bb3fb3ca59aaeaa8d48e52dfdc0f3db
change-id: 20231117-fix-cdat-cs-a8ed72ec2244

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

