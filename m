Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721098111B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378869AbjLMMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378938AbjLMMuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:50:09 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC1F2;
        Wed, 13 Dec 2023 04:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+T8kn3k9b5NRBjWSUweuCxqkK4fxT1FVGeJHMIqvr6c=; b=rkyEttm/kwtrIQTS1tSEUUuy10
        b9f4MBsDpOC7fICaT9EKK+Erd3u3912ckPVBYTTp9qSDOl75HckFt2qX6y4YCvnlnnFH14GeyAlCD
        Li+m9IPqogcUFaNQ7kQHxE4OpBhAZYtFI73RMlMLVN/fOwXSoM636lHWmCwWwcFfIS24kketvfMg0
        EU7oxLVMKZRpauGDtcKWJQe8L2+C4eMsQ9rGXcJRTKtsWv+vOvGMNbx0tW/5qZx4LHU0G5Ov/QN7B
        +CzbJp4H7r/dgAdh7yyBwxBVH4y/8nMxcj74KZ3bUuRotM59px0g35yT9z1oC88KgqotI5CkI10kd
        HXtcF17Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50928 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1rDOga-0008F6-2I;
        Wed, 13 Dec 2023 12:50:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1rDOgc-00DvkW-PZ; Wed, 13 Dec 2023 12:50:02 +0000
In-Reply-To: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Subject: [PATCH RFC v3 10/21] ACPI: Check _STA present bit before making CPUs
 not present
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rDOgc-00DvkW-PZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Wed, 13 Dec 2023 12:50:02 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

When called acpi_processor_post_eject() unconditionally make a CPU
not-present and unregisters it.

To add support for AML events where the CPU has become disabled, but
remains present, the _STA method should be checked before calling
acpi_processor_remove().

Rename acpi_processor_post_eject() acpi_processor_remove_possible(), and
check the _STA before calling.

Adding the function prototype for arch_unregister_cpu() allows the
preprocessor guards to be removed.

After this change CPUs will remain registered and visible to
user-space as offline if buggy firmware triggers an eject-request,
but doesn't clear the corresponding _STA bits after _EJ0 has been
called.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
---
Changes since RFC v3:
 * Move IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU) into separate patch.
Outstanding comments:
 https://lore.kernel.org/r/20230914153110.00003e38@Huawei.com
 https://lore.kernel.org/r/518859b1-64a9-d723-963c-56c7f6fc2da1@redhat.com
  This contains a repeat of the IS_ENABLED() issue which we don't think
  is a problem - but there is another issue mentioned in that comment.
---
 drivers/acpi/acpi_processor.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 01c460881662..19fceb3ec4e2 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -458,16 +458,13 @@ static int acpi_processor_add(struct acpi_device *device,
 }
 
 /* Removal */
-static void acpi_processor_post_eject(struct acpi_device *device)
+static void acpi_processor_make_not_present(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
 	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
 		return;
 
-	if (!device || !acpi_driver_data(device))
-		return;
-
 	pr = acpi_driver_data(device);
 	if (pr->id >= nr_cpu_ids)
 		goto out;
@@ -504,6 +501,29 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 	kfree(pr);
 }
 
+static void acpi_processor_post_eject(struct acpi_device *device)
+{
+	struct acpi_processor *pr;
+	unsigned long long sta;
+	acpi_status status;
+
+	if (!device)
+		return;
+
+	pr = acpi_driver_data(device);
+	if (!pr || pr->id >= nr_cpu_ids || invalid_phys_cpuid(pr->phys_id))
+		return;
+
+	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return;
+
+	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
+		acpi_processor_make_not_present(device);
+		return;
+	}
+}
+
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 bool __init processor_physically_present(acpi_handle handle)
 {
-- 
2.30.2

