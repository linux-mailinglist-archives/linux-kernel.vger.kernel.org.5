Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420777407C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjHHREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHHRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:03:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351119763;
        Tue,  8 Aug 2023 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510491; x=1723046491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9CE+7ZXBx0kDEsrZcd8WmXKJp5Uc9a7coM9bHeY+W38=;
  b=NGWtKyleihfGlLsrmKwqP5TSq0taBaniKg5kzURT+NCn5VS1J2RzJGmQ
   oDOHKeET7N0m9eMu3A8iWsFQcUGXtlVAqQj/+CdgqBd0yYF5ej66reyi+
   GyPXjJhZ69vfm27VHdf8ktoCi1qUME3W0czGsk2WsClWbRCc32RyufLg7
   Chf4dt7K9uTa5O+36oZ532IN7HC5jb9ygzU60H1ukU29KDt2V9nm7NakA
   RJtduB0O7Yi/h37C5t/DRg21pb5JxeCGjk8+Sjsb57cEpTHfNh8XMVxKT
   HfHSYykAC8zon2E7WmTO8TS50U8d5uIlGSAleorAAwtJ0nvtswxK71vYz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373486331"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="373486331"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 23:16:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874608255"
Received: from romanagn-mobl1.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.49.59])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 23:16:55 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        peter.ujfalusi@linux.intel.com, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de
Subject: [PATCH] tpm: tpm_tis: Fix UPX-i11 DMI_PRODUCT_VERSION string
Date:   Tue,  8 Aug 2023 09:18:16 +0300
Message-ID: <20230808061816.15695-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch which made it to the kernel somehow lost the "01" from the
string, making the match to not work anymore.

Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalusi@linux.intel.com/
Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11")
---
Hi Jarkko,

Can you send this patch for the 6.5 cycle?
edb13d7bb034 was applied in 6.5-rc3 and I just updated my work tree to notice
the regression.

Thank you,
Peter

 drivers/char/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ac4daaf294a3..2bb9901a329a 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 		.ident = "UPX-TGL",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL01"),
 		},
 	},
 	{}
-- 
2.41.0

