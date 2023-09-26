Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803407AF3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbjIZTI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbjIZTIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:08:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBD69F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695755327; x=1727291327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vr4DyiomFZ1CexH6Of/72fHCetBiilFqUbM1YUVAzbk=;
  b=CCFWIGXzT5rsUnVDKMt8EVl2qxdLg/Kz3bteUhlLGFaBtcwqBn6qIKMW
   JlgQtVqu7dqez+YxHZZe9Cb+gYlPG6zrLhDSMBxHuUVHck7rccrXw9HNm
   1O1/4KIBjhsEQFiAlEjOfsX7Y5M1MdAIZBRfcewiTx5n9l0w9Pl7OYxOo
   1lJjZRHYe4BDqRM+aJPYcMM+JYhly79jjFrZ63lSf45WZdJf9qjXclfqf
   0lap5q23Do1/gXepZMe5Ac0L0xHCS/PjdqZ5/FXW48z9olQOqQkHOi2Gn
   +hnoYwoOMoEjqv/V86zi7NmerDIDr0DmcKXDD/FwUlTDhvkDXnfUlnGoM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448142636"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="448142636"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:08:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819142537"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819142537"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2023 12:08:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 153B387; Tue, 26 Sep 2023 22:08:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 2/4] mfd: lpc_ich: Convert gpio_version to be enum
Date:   Tue, 26 Sep 2023 22:08:32 +0300
Message-Id: <20230926190834.932233-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230926190834.932233-1-andriy.shevchenko@linux.intel.com>
References: <20230926190834.932233-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have an anonymous enum for the GPIO versions. Make it named
and use this type for the gpio_version member of struct lpc_ich_info.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/mfd/lpc_ich.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
index ea4a4b1b246a..83621e0ccf33 100644
--- a/include/linux/mfd/lpc_ich.h
+++ b/include/linux/mfd/lpc_ich.h
@@ -15,7 +15,7 @@
 #define ICH_RES_GPE0	1
 
 /* GPIO compatibility */
-enum {
+enum lpc_gpio_versions {
 	ICH_I3100_GPIO,
 	ICH_V5_GPIO,
 	ICH_V6_GPIO,
@@ -29,7 +29,7 @@ enum {
 struct lpc_ich_info {
 	char name[32];
 	unsigned int iTCO_version;
-	unsigned int gpio_version;
+	enum lpc_gpio_versions gpio_version;
 	enum intel_spi_type spi_type;
 	u8 use_gpio;
 };
-- 
2.40.0.1.gaa8946217a0b

