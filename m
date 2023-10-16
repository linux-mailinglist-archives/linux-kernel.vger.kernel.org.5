Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2019C7CA8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjJPNKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjJPNJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F56F5;
        Mon, 16 Oct 2023 06:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461791; x=1728997791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/NysSCadA0TJULbiXS8GGWTrMOochBOaLvqBFQytEY=;
  b=dC5wpAJm7y7MTeUb3vuR/ZipZ93XxyoXmL3P9mVZK7jXi/a4pYq+If3J
   KsAnOWNpgkn48dwxO81XCQdBrmvbI5yun99QVyOvPGQm7+ZfIzsUcBVeL
   3aolT2THksFfzKdXudti1N0MRnYNm+mK3rh6G3MmPtZ17ySei9kU+EgJs
   GZ170kqBGY8TfG9sLy7wZSVhWZ8/oYoQhQrq4t32Yzz8Eiuwj85mBKwx9
   hPw+9Vqq7DS58N7zFpOeZ+oQ7aniRUzc9Hxg26+mw0GTlsuWg83zm3DFw
   1pNuqg+0+XJActXXs2cdSTyR767pW1NHDnNa8IkzUWuXFiBQlueng5Gxc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4133305"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4133305"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1087067145"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087067145"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 06:09:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4DCC2A59; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 08/10] xhci: dbc: Use sizeof_field() where it makes sense
Date:   Mon, 16 Oct 2023 16:09:32 +0300
Message-Id: <20231016130934.1158504-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
References: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of doing custom calculations, use sizeof_field() macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 779a564ad698..0c9fd61e9c5b 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -374,7 +374,7 @@ static void xhci_dbc_eps_init(struct xhci_dbc *dbc)
 
 static void xhci_dbc_eps_exit(struct xhci_dbc *dbc)
 {
-	memset(dbc->eps, 0, sizeof(struct dbc_ep) * ARRAY_SIZE(dbc->eps));
+	memset(dbc->eps, 0, sizeof_field(struct xhci_dbc, eps));
 }
 
 static int dbc_erst_alloc(struct device *dev, struct xhci_ring *evt_ring,
-- 
2.40.0.1.gaa8946217a0b

