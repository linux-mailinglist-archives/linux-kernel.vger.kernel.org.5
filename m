Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1176499B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjG0H5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjG0H5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:57:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C32685
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:54:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E7E521AF8;
        Thu, 27 Jul 2023 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690444492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wSxwMI6iTWlc8CQ5+CmIo2ka2i1bO3cYp5kFn1ZMdYI=;
        b=EfLy4/WAskIouv5rxvEmdHlFj3FESHYvCBQIeMk066Gamse8nqqzhOc9v7r186DjuVTx0w
        IxBX3vZGZdKCEe1S9ciYupkB8ZCGLkRERbnkmeupIkZV4h9fgjrevxyZujANz2qoI5eONC
        n/CqicCMfepooCttUnGlOFr/9/HN8C0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A503138E5;
        Thu, 27 Jul 2023 07:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NxPDB8wiwmR4PwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Thu, 27 Jul 2023 07:54:52 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     bp@alien8.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/cpu/amd: Report zenbleed in sysfs
Date:   Thu, 27 Jul 2023 10:54:46 +0300
Message-Id: <20230727075446.1749969-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial submission of Zenbleed fix omitted reporting the bug in sysfs.
There's no reason why it shouldn't be reported so let's add it among
the other vulnerabilities.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 .../ABI/testing/sysfs-devices-system-cpu          |  1 +
 arch/x86/kernel/cpu/amd.c                         | 15 +++++++++++++++
 drivers/base/cpu.c                                |  8 ++++++++
 include/linux/cpu.h                               |  2 ++
 4 files changed, 26 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ecd585ca2d50..30bb4196e451 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -524,6 +524,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
 		/sys/devices/system/cpu/vulnerabilities/retbleed
+		/sys/devices/system/cpu/vulnerabilities/zenbleed
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 26ad7ca423e7..3ab9745eafc5 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1279,6 +1279,21 @@ u32 amd_get_highest_perf(void)
 }
 EXPORT_SYMBOL_GPL(amd_get_highest_perf);
 
+ssize_t cpu_show_zenbleed(struct device *dev, struct device_attribute *attr, char *buf)
+{
+
+	if (!cpu_has_amd_erratum(&boot_cpu_data, amd_zenbleed) ||
+	    !boot_cpu_has(X86_FEATURE_AVX) ||
+	    boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return sysfs_emit(buf, "Not affected\n");
+
+	if (!cpu_has_zenbleed_microcode()) {
+		return sysfs_emit(buf, "Mitigation: Chickenbit\n");
+	} else {
+		return sysfs_emit(buf, "Mitigation: Microcode\n");
+	}
+}
+
 static void zenbleed_check_cpu(void *unused)
 {
 	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c1815b9dae68..49c963a0f362 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -577,6 +577,12 @@ ssize_t __weak cpu_show_retbleed(struct device *dev,
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_zenbleed(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -588,6 +594,7 @@ static DEVICE_ATTR(itlb_multihit, 0444, cpu_show_itlb_multihit, NULL);
 static DEVICE_ATTR(srbds, 0444, cpu_show_srbds, NULL);
 static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
+static DEVICE_ATTR(zenbleed, 0444, cpu_show_zenbleed, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -601,6 +608,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_srbds.attr,
 	&dev_attr_mmio_stale_data.attr,
 	&dev_attr_retbleed.attr,
+	&dev_attr_zenbleed.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6e6e57ec69e8..8ed8fa142067 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -70,6 +70,8 @@ extern ssize_t cpu_show_mmio_stale_data(struct device *dev,
 					char *buf);
 extern ssize_t cpu_show_retbleed(struct device *dev,
 				 struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_zenbleed(struct device *dev,
+				 struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
-- 
2.34.1

