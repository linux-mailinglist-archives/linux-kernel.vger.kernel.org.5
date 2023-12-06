Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA0B807218
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378733AbjLFOQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378679AbjLFOQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:16:28 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB0D1;
        Wed,  6 Dec 2023 06:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701872195; x=1733408195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dEqIQbLlIVTzw0VxjeAKELJLS94IbUU15V0jKQEwvfU=;
  b=MCRQwt/ndh0UTuTChppJ5si022ZOEqI8H43be19hg1wnwgJu1wovCOtA
   LgZTR2M8JbIGr7e2eK+9L42UZ8941/7cnXgHNfspJ7UpyfKPE0P0ysBbL
   5y6dTPor6f2ncGi1ZD4bDcGikLfOMkskDOHBEhcE8/7+wUgwuRwDdi7f6
   o=;
X-IronPort-AV: E=Sophos;i="6.04,255,1695686400"; 
   d="scan'208";a="372164326"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 14:16:32 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 73912A3643;
        Wed,  6 Dec 2023 14:16:31 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:19177]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.143:2525] with esmtp (Farcaster)
 id ef31892a-0527-48c6-a5bc-f1717b01c540; Wed, 6 Dec 2023 14:16:31 +0000 (UTC)
X-Farcaster-Flow-ID: ef31892a-0527-48c6-a5bc-f1717b01c540
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 14:16:30 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 14:16:29 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>
Subject: [PATCH] initramfs: Expose retained initrd as sysfs file
Date:   Wed, 6 Dec 2023 14:16:27 +0000
Message-ID: <20231206141627.91659-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel command line option "retain_initrd" is set, we do not
free the initrd memory. However, we also don't expose it to anyone for
consumption. That leaves us in a weird situation where the only user of
this feature is ppc64 and arm64 specific kexec tooling.

To make it more generally useful, this patch adds a kobject to the
firmware object that contains the initrd context when "retain_initrd"
is set. That way, we can access the initrd any time after boot from
user space and for example hand it into kexec as --initrd parameter
if we want to reboot the same initrd. Or inspect it directly locally.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../admin-guide/kernel-parameters.txt          |  5 +++--
 init/initramfs.c                               | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..51575cd31741 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2438,7 +2438,7 @@
 			between unregistering the boot console and initializing
 			the real console.
 
-	keepinitrd	[HW,ARM]
+	keepinitrd	[HW,ARM] See retain_initrd.
 
 	kernelcore=	[KNL,X86,IA-64,PPC]
 			Format: nn[KMGTPE] | nn% | "mirror"
@@ -5580,7 +5580,8 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
-	retain_initrd	[RAM] Keep initrd memory after extraction
+	retain_initrd	[RAM] Keep initrd memory after extraction. After boot, it will
+			be accessible via /sys/firmware/initrd.
 
 	retbleed=	[X86] Control mitigation of RETBleed (Arbitrary
 			Speculative Code Execution with Return Instructions)
diff --git a/init/initramfs.c b/init/initramfs.c
index 8d0fd946cdd2..25244e2a5739 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -574,6 +574,16 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+static ssize_t raw_read(struct file *file, struct kobject *kobj,
+			struct bin_attribute *attr, char *buf,
+			loff_t pos, size_t count)
+{
+	memcpy(buf, attr->private + pos, count);
+	return count;
+}
+
+static BIN_ATTR(initrd, 0440, raw_read, NULL, 0);
+
 void __init reserve_initrd_mem(void)
 {
 	phys_addr_t start;
@@ -715,8 +725,14 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!do_retain_initrd && initrd_start && !kexec_free_initrd())
+	if (!do_retain_initrd && initrd_start && !kexec_free_initrd()) {
 		free_initrd_mem(initrd_start, initrd_end);
+	} else if (do_retain_initrd) {
+		bin_attr_initrd.size = initrd_end - initrd_start;
+		bin_attr_initrd.private = (void *)initrd_start;
+		if (sysfs_create_bin_file(firmware_kobj, &bin_attr_initrd))
+			pr_err("Failed to create initrd sysfs file");
+	}
 	initrd_start = 0;
 	initrd_end = 0;
 
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



