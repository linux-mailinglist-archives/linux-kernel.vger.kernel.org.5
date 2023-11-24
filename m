Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68337F6F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjKXJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjKXJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:10:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F910EF;
        Fri, 24 Nov 2023 01:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700817011; x=1732353011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=66TLivhScrf9PDmhJ5Qy/pTIXujF0a8LJJSvL83bbzY=;
  b=mLbBx5hKKnigSec5QNzGIf4VS5jO637IueqGnXW9/HYzVYbBpp1x4vYS
   w+Qz7zG4aF3Nn+QflC+JPgh06zeuXrb0xCAqgvGLVaW2tWPBsUoucquEc
   S7FEgUBm8RGDAlLSKOrGFYJxu9RkZoHq64121wbmOJQrHHRnhZ8jqWqC5
   PuQhECYoW7CEH138YySVyUwtZETynP8BAUhFeFQ+WUDZhWOSaAw/LmiJ0
   885+k6TN1vPOrpafAdkIOQHjCMhAzt+MlzYYbxU7TuqVQtjtNQveMlNFs
   sxdXyS63zSeJaDiaiNvv4quegVMQEvDEb3aMIzJCJX3dSsgf2ESzE8S5I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478603519"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="478603519"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:10:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="15911703"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:10:09 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/6] bcma: Use PCI_HEADER_TYPE_MASK instead of literal
Date:   Fri, 24 Nov 2023 11:09:18 +0200
Message-Id: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace literal 0x7f with PCI_HEADER_TYPE_MASK.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/bcma/driver_pci_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
index aa0581cda718..ed3be52ab63d 100644
--- a/drivers/bcma/driver_pci_host.c
+++ b/drivers/bcma/driver_pci_host.c
@@ -280,7 +280,7 @@ static u8 bcma_find_pci_capability(struct bcma_drv_pci *pc, unsigned int dev,
 	/* check for Header type 0 */
 	bcma_extpci_read_config(pc, dev, func, PCI_HEADER_TYPE, &byte_val,
 				sizeof(u8));
-	if ((byte_val & 0x7F) != PCI_HEADER_TYPE_NORMAL)
+	if ((byte_val & PCI_HEADER_TYPE_MASK) != PCI_HEADER_TYPE_NORMAL)
 		return cap_ptr;
 
 	/* check if the capability pointer field exists */
-- 
2.30.2

