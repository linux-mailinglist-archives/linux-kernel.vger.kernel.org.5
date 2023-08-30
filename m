Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8578E272
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbjH3Wk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbjH3WkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:40:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627D28F;
        Wed, 30 Aug 2023 15:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435208; x=1724971208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bvi/oisHOe9cHxLUzm0gVtHD94w7IdsGsLjbydiAZFY=;
  b=H9wibPTphdR8m5USVwW1inJDlnQs9Pgi1UtSmCL1nSMQaM1q1QVEViuT
   UETB7SyVUSxpBpem8ARREenMyK3uRcUgumdzxzE+1YzlI8nNqeBpI38bV
   SqQbs6a4OnkLs6c9CbqdyIuHFn1yrmqb+3VUL/Umb+knT+U4kUP9g2KYv
   0qiW5zR1Q71ZztcSd750k3zHmb3eMH7kC+Gr65foGYsY0Iaf519KWmSuR
   uvivrvY8FuaWX0fzsdjTC5B+fRhA1m9DwRnhedrI4WZh+gksV4d9wxVLT
   NN62a6PeGw6X5Xms0X6pciSLahXjqh84HgfpF83KkzL4/Dbrnyo8QkWkI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374677349"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374677349"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774259652"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774259652"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.97])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 15:39:46 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev
Cc:     andriy.shevchenko@linux.intel.com, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 3/5] usb: pd: Add helper macro to get Type C cable speed
Date:   Wed, 30 Aug 2023 15:39:48 -0700
Message-Id: <20230830223950.1360865-4-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a helper macro to get the Type C cable speed when provided the
cable VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v2:
- This change is being added as new patch in this series.

 include/linux/usb/pd_vdo.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index b057250704e8..3a747938cdab 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -376,6 +376,7 @@
 	 | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) << 5	\
 	 | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
 
+#define VDO_TYPEC_CABLE_SPEED(vdo)	((vdo) & 0x7)
 #define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
 
 /*
-- 
2.25.1

