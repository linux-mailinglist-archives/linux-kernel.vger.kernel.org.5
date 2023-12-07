Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3DA8096D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjLGX5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGX46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:56:58 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754F171B;
        Thu,  7 Dec 2023 15:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701993424; x=1733529424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcjJtNzwZqIq07uHL5b0sq0gIckWX9Rvrzf/I8qlMrk=;
  b=NgCmlZBFmmBIx+2mM+VgFYBnA+MqQIgiNP2Q+H37nyM3y47fMS6xOJaV
   wcJDztUYbAEhEPCHdY7/AMQ7kR4ZVHf8gmQmsnp9w27DOixUgb1XAwAuu
   Xle78EhBULvSVwpmspV71iC0obWxEBhaneyIuBpoVAan6hvxZhOl9O/w+
   w=;
X-IronPort-AV: E=Sophos;i="6.04,259,1695686400"; 
   d="scan'208";a="381501661"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 23:56:59 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
        by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id 74BA560C74;
        Thu,  7 Dec 2023 23:56:58 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:33393]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.7:2525] with esmtp (Farcaster)
 id 460010c9-1d60-4616-8139-c6fc277160fd; Thu, 7 Dec 2023 23:56:58 +0000 (UTC)
X-Farcaster-Flow-ID: 460010c9-1d60-4616-8139-c6fc277160fd
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 23:56:57 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 23:56:56 +0000
From:   Alexander Graf <graf@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        James Gowans <jgowans@amazon.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] initramfs: Expose retained initrd as sysfs file
Date:   Thu, 7 Dec 2023 23:56:54 +0000
Message-ID: <20231207235654.16622-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
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

With this patch applied, there is a new /sys/firmware/initrd file when
the kernel was booted with an initrd and "retain_initrd" command line
option is set.

Signed-off-by: Alexander Graf <graf@amazon.com>
Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

---

v1 -> v2:

  - Reword commit message to explain the new file path
  - Add a Documentation/ABI/testing/sysfs-firmware-initrd file

v2 -> v3:

  - Only expose file when initrd is present (James Gowans)
---
 .../ABI/testing/sysfs-firmware-initrd          |  8 ++++++++
 .../admin-guide/kernel-parameters.txt          |  5 +++--
 init/initramfs.c                               | 18 +++++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-initrd

diff --git a/Documentation/ABI/testing/sysfs-firmware-initrd b/Documentation/ABI/testing/sysfs-firmware-initrd
new file mode 100644
index 000000000000..20bf7cf77a19
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-initrd
@@ -0,0 +1,8 @@
+What:		/sys/firmware/initrd
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		When the kernel was booted with an initrd and the
+		"retain_initrd" option is set on the kernel command
+		line, /sys/firmware/initrd contains the contents of the
+		initrd that the kernel was booted with.
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
index 8d0fd946cdd2..76deb48c38cb 100644
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
+	} else if (do_retain_initrd && initrd_start) {
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



