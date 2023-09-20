Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B27A7090
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjITCdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjITCdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:33:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B02AC;
        Tue, 19 Sep 2023 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695177197; x=1726713197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9oH2vhb+i0DF046ABw0g6rni0Rw6+7eJnY/NOkScvqA=;
  b=g3sGF92lCkjQcDuei2AGryk8cge9hvpm6E1ZbK16WxCvxugvgtzmPkd4
   nLC8Q6Kmx46aRl8MDVyOgA0COPa+EjwcgIvLxTEckS4tNqQzSzbYC06QN
   frZ9XEjR9Wi9REt73MpMyRIm481Dh8NViVY5kys9vh+xfuWWyQ01FI8k9
   Aq2Ym9YQZMQuEy0qsGvscvvhDF03+Yei7PXH0/qp299EedZ0MLD9DCpdA
   n7d+kMUVx/5l/6YRlw7kPPZLCQCHdBDqs7c0f7LmBst7pB/h/A/B84n90
   VNQZF/9nOSMn73f+6cLGPxhtosdcVGSCd+/LfunoW+zWeQy0GKXy/L14V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466422451"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="466422451"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 19:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816690726"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="816690726"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.215])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2023 19:33:13 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev, andriy.shevchenko@linux.intel.com,
        bleung@chromium.org, Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v4 3/5] usb: pd: Add helper macro to get Type C cable speed
Date:   Tue, 19 Sep 2023 19:32:41 -0700
Message-Id: <20230920023243.2494410-4-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a helper macro to get the Type C cable speed when provided the
cable VDO.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v4:
- Added this patch back in this series with Reviewed-by tag from Heikki.

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

