Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298B7773F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjHHQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjHHQsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:48:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF7F16AEF;
        Tue,  8 Aug 2023 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510229; x=1723046229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4qHoQ61kt/ubZaH0cR5klgayLMXxQJJPKzr9xSPkeQQ=;
  b=HLgjFRtOY8zpDz8d6XFB9JfStwl9vrZ6sB8UWeDnylCUZdfYTxc/+mK2
   CWlh35OMuUl2mQWs2U8KYIMHnHIxHKa5UJWpWPIFr8fm59o5XYvghomTN
   ShkBrW5cXW0DdXKvr/nUDfInmTQzbxj+WVnE/RmmCpn9xMSvcvY+vH54d
   NNxc8jWDIkrESRtL35zSRFbsRIyAw1aV4tCeEld3jsfAB+wDvtTYzneEI
   29Tatsfs+32QNxu0yTjHDC7FEsF+LcZbH2ukOAH/S4jE8jdH1CN1q0blg
   rJLAj79ivJa+k2+wLngj9vGT1MJxvhHjewvb/JZAcX8ncFBZuc0+FPFTa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369675703"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="369675703"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731337624"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="731337624"
Received: from romanagn-mobl1.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.49.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:47:12 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        peter.ujfalusi@linux.intel.com, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de
Subject: [PATCH] tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition
Date:   Tue,  8 Aug 2023 12:48:36 +0300
Message-ID: <20230808094836.31473-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch which made it to the kernel somehow changed the
match condition from
DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
to
DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL")

Revert back to the correct match condition to disable the
interrupt mode on the board.

Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalusi@linux.intel.com/
Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11")
---
 drivers/char/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ac4daaf294a3..3c0f68b9e44f 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 		.ident = "UPX-TGL",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
 		},
 	},
 	{}
-- 
2.41.0

