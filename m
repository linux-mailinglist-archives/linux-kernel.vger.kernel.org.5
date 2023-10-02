Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7947B585D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbjJBQTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjJBQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:19:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D8CDE;
        Mon,  2 Oct 2023 09:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696263549; x=1727799549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5q/ryLz/eJWv6HpUt5GYTqF30dvGM85K4SmBspi369M=;
  b=WeMv0O/wOILo+u+wWmbAWweKoGXVuIAvQ1/4uPIow4morT9Ttydha9ka
   atMEBrs220fhIp+kCOjRAb+/Y1pF2F++0IU0V54lfxnrK0aevlOsdJUMc
   GRGrr5o/SYFQKsThLm6k22WsF+aaJ6oL/RCH0mEuncsufL3XLQM1KfN8E
   KAa337IL3wVLq9aMZvgiEy6GhPNkT2/e99yicJ5+A564t7f2pgaeJhT+d
   FPWzfmPuGoJoh9MP2cJUVCeRH4tF403nVscm57LYID3fwVAY9HEfeUgBZ
   rNoIymHQuNOltoSnWKVSV7MTVGQUqDfHai0R27B8S2yn7zYHvXJfubR7Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382588661"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382588661"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841031518"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="841031518"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Oct 2023 09:16:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6600614B3; Mon,  2 Oct 2023 19:16:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 07/10] xhci: dbc: Replace custom return value with proper Linux error code
Date:   Mon,  2 Oct 2023 19:16:07 +0300
Message-Id: <20231002161610.2648818-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
References: <20231002161610.2648818-1-andriy.shevchenko@linux.intel.com>
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

Replace the custom return value with proper Linux error code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 2332133c6581..617d057aa5f8 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -593,7 +593,7 @@ static int xhci_do_dbc_start(struct xhci_dbc *dbc)
 static int xhci_do_dbc_stop(struct xhci_dbc *dbc)
 {
 	if (dbc->state == DS_DISABLED)
-		return -1;
+		return -EINVAL;
 
 	writel(0, &dbc->regs->control);
 	dbc->state = DS_DISABLED;
-- 
2.40.0.1.gaa8946217a0b

