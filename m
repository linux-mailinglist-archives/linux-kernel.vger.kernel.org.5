Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5978E26F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbjH3WkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjH3WkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:40:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E78B4;
        Wed, 30 Aug 2023 15:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435200; x=1724971200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iyz4sar60FjU2iFbaIbTMzum/E5QGedIc3sn/3jPfuU=;
  b=S9ESJklCxG+y/SbiZCdQHH2A6CQxz+3x/r15qf0togEyZdQKxu3idJ9g
   ORTlcmch2Yt9FmMPpNiRADiVp6b0IVWzkkmIW5jTZcgg9DlcuPg7fd9Yo
   vZFWy8ScdT/g2vvlCF7ljW9XMBSO4gMkgiKxeAHRkRVIKsnDp0TK+cpqW
   e4c/TenaKJdBw9YnqqfuzIrvhg3qlgEjiBhRYvx7i1DhXSI4TJuz9YNsH
   PytYERjoC69VSZv3lDsCqC/7VeI5V6kSmabm3888pyxAWX3DapI+/rusc
   xGSvZ0pIKrVwOz0wWnwQub4ZYfNBWYcofk9ygfOu94Wpd/vTTp5BjIeLH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="374677345"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="374677345"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="774259649"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="774259649"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.97])
  by orsmga001.jf.intel.com with ESMTP; 30 Aug 2023 15:39:46 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        chrome-platform@lists.linux.dev
Cc:     andriy.shevchenko@linux.intel.com, bleung@chromium.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 2/5] usb: typec: Add Active or Passive cable defination to cable discover mode VDO
Date:   Wed, 30 Aug 2023 15:39:47 -0700
Message-Id: <20230830223950.1360865-3-utkarsh.h.patel@intel.com>
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

As per USB Type-C Connector specification v2.2 section F.2.6, BIT25
represents Active or Passive cable. Added BIT25 defination to the
Thunderbolt 3 cable discover mode VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v2:
- This change is being added as new patch in this series.
 
 include/linux/usb/typec_tbt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
index 63dd44b72e0c..c7a2153bd6f5 100644
--- a/include/linux/usb/typec_tbt.h
+++ b/include/linux/usb/typec_tbt.h
@@ -46,6 +46,7 @@ struct typec_thunderbolt_data {
 #define TBT_CABLE_OPTICAL		BIT(21)
 #define TBT_CABLE_RETIMER		BIT(22)
 #define TBT_CABLE_LINK_TRAINING		BIT(23)
+#define TBT_CABLE_ACTIVE_PASSIVE	BIT(25)
 
 #define TBT_SET_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
 #define TBT_SET_CABLE_ROUNDED(_g_)	(((_g_) & GENMASK(1, 0)) << 19)
-- 
2.25.1

