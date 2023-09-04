Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DE3791C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjIDSN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIDSN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A91712;
        Mon,  4 Sep 2023 11:12:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D451961862;
        Mon,  4 Sep 2023 18:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B968BC433C7;
        Mon,  4 Sep 2023 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693851137;
        bh=giqsozg8yzFsr9l35aF4ia0ZabVHrLqwjYV8WecnZiw=;
        h=From:To:Cc:Subject:Date:From;
        b=hfk1W9JfuxXT30Bmh0QGLo7Q6ZN8QHP1h7lo0+PkEYgbV+P0fyZupCI5PzjzzfvJo
         bA1cc+XFws0Kb3tzwtk6RAFDWHfcBJQxOEDY8o9py0b/qPWymEvXE0UATbOfqXyVcC
         ak51nGuh9NnWcNqbKfFqSaSNZRHJ0u52+sjKeymQ43jNKrtd1R/amFj0U5WanDxXUM
         V90E7lsNyDOUjKVkTpZIEtYT5WGmof/zIz1BADG6TusZDf+14NHIp9XbFZdx5gQiSv
         jTx7LmRD2R+BnECfHiO0WLTKglGyDS1GexDvdF9sipdj/nuj3SM3rbGEbG5my0nqtG
         3+HEcypemvb6Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Patrick Steinhardt <ps@pks.im>,
        Raymond Jay Golo <rjgolo@gmail.com>,
        Ronan Pigott <ronan@rjp.ie>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] tpm: Enable hwrng only for Pluton on AMD CPUs
Date:   Mon,  4 Sep 2023 21:12:10 +0300
Message-Id: <20230822231510.2263255-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
reported systems the TPM doesn't reply at bootup and returns back the
command code. This makes the TPM fail probe on Lenovo Legion Y540 laptop.

Since only Microsoft Pluton is the only known combination of AMD CPU and
fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
aware of this, print also info message to the klog.

Cc: stable@vger.kernel.org
Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
Reported-by: Patrick Steinhardt <ps@pks.im>
Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
Reported-by: Ronan Pigott <ronan@rjp.ie>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v4:
* Report the victim: Lenovo Legion Y540
* Add reported-by's back due popular request.
v3:
* Forgot to amend config flags.
v2:
* CONFIG_X86
* Removed "Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>"
* Removed "Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>"
---
 drivers/char/tpm/tpm_crb.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 65ff4d2fbe8d..ea085b14ab7c 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -463,28 +463,6 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
 	return (cancel & CRB_CANCEL_INVOKE) == CRB_CANCEL_INVOKE;
 }
 
-static int crb_check_flags(struct tpm_chip *chip)
-{
-	u32 val;
-	int ret;
-
-	ret = crb_request_locality(chip, 0);
-	if (ret)
-		return ret;
-
-	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
-	if (ret)
-		goto release;
-
-	if (val == 0x414D4400U /* AMD */)
-		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
-
-release:
-	crb_relinquish_locality(chip, 0);
-
-	return ret;
-}
-
 static const struct tpm_class_ops tpm_crb = {
 	.flags = TPM_OPS_AUTO_STARTUP,
 	.status = crb_status,
@@ -827,9 +805,14 @@ static int crb_acpi_add(struct acpi_device *device)
 	if (rc)
 		goto out;
 
-	rc = crb_check_flags(chip);
-	if (rc)
-		goto out;
+#ifdef CONFIG_X86
+	/* A quirk for https://www.amd.com/en/support/kb/faq/pa-410 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	    priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+		dev_info(dev, "Disabling hwrng\n");
+		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
+	}
+#endif /* CONFIG_X86 */
 
 	rc = tpm_chip_register(chip);
 
-- 
2.39.2

