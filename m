Return-Path: <linux-kernel+bounces-126613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394D3893A63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B201C21057
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DAA33986;
	Mon,  1 Apr 2024 10:50:45 +0000 (UTC)
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EF1200CD;
	Mon,  1 Apr 2024 10:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968643; cv=none; b=E/Utu0yTby8MxV8HT9saugbEKoSOh3jeKGBFVjIXmuIe0sbcFSUPiR1J+o+9WzSHKT2cf13n0DSSKsR+Enh4+NZlxdu/xHwzugU7LO7JVGFet+rX2dbyCJ6psOdECQmH/+rq6awOV8jeSjqVgbJ5ySOCJ1ONw3BnqhXGQ8OKG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968643; c=relaxed/simple;
	bh=e5RgIIoBjoGLrQasjIh4BM2qQ5hIEJfXSJEBzAqwjhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NEZ/PCT3u6bEst/YeqD8Y5HkMWQsuJR05+11WPpYy1FQ+3RuelhoiFTncKMBx+VArYIu63Ov5X8Sf+DRjMM3n4+IabOGrliWBcg8im/bgXRo75JB6r0tRTm8ZKUlhTBMV7D+J/jy/qyNY4i35o83xlrdi5VCUJcJNZq4OpongxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 431AoSFj027708;
	Mon, 1 Apr 2024 05:50:28 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 431AoRQW027706;
	Mon, 1 Apr 2024 05:50:27 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v3 12/12] Activate the configuration and build of the TSEM LSM.
Date: Mon,  1 Apr 2024 05:50:15 -0500
Message-Id: <20240401105015.27614-13-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240401105015.27614-1-greg@enjellic.com>
References: <20240401105015.27614-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. Greg" <greg@enjellic.com>

Complete the implementation by integrating TSEM into the
configuration and kernel build infrastructure.  This includes
registration of TSEM with the LSM infrastructure and the
assignment of an LSM identifier number.
---
 include/uapi/linux/lsm.h |  1 +
 security/Kconfig         | 11 ++++++-----
 security/Makefile        |  1 +
 security/security.c      |  3 ++-
 security/tsem/Kconfig    | 36 ++++++++++++++++++++++++++++++++++++
 security/tsem/Makefile   |  2 ++
 6 files changed, 48 insertions(+), 6 deletions(-)
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile

diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 33d8c9f4aa6b..6b63c158c1df 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -64,6 +64,7 @@ struct lsm_ctx {
 #define LSM_ID_LANDLOCK		110
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
+#define LSM_ID_TSEM		113
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index 412e76f1575d..a7802eb29034 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -192,6 +192,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/tsem/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -231,11 +232,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECURITY_DAC
+	default "tsem,landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 59f238490665..1d4e0a698a2d 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_TSEM)		+= tsem/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/security.c b/security/security.c
index 7e118858b545..0c91579f2912 100644
--- a/security/security.c
+++ b/security/security.c
@@ -51,7 +51,8 @@
 	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
 	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
-	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
+	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_TSEM) ? 1 : 0))
 
 /*
  * These are descriptions of the reasons that can be passed to the
diff --git a/security/tsem/Kconfig b/security/tsem/Kconfig
new file mode 100644
index 000000000000..2e9d54eb3acc
--- /dev/null
+++ b/security/tsem/Kconfig
@@ -0,0 +1,36 @@
+config SECURITY_TSEM
+	bool "Trusted Security Event Modeling"
+	depends on SECURITY
+	depends on NET && INET
+	select SECURITY_NETWORK
+	select SECURITYFS
+	select CRYPTO
+	select CRYPTO_SHA256
+	select CRYPTO_HASH_INFO
+	select TCG_TPM if HAS_IOMEM && !UML
+	select TCG_TIS if TCG_TPM && X86
+	select TCG_CRB if TCG_TPM && ACPI
+	default n
+	help
+	  This option selects support for Trusted Security Event
+	  Modeling (TSEM).  TSEM implements the ability to model
+	  the security state of either the system at large or in a
+	  restricted namespace on the basis of the LSM security
+	  events and attributes that occur in the scope of the model.
+	  The model may be implemented either in the kernel proper
+	  or exported to an external Trusted Modeling Agent (TMA).
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_TSEM_ROOT_MODEL_PCR
+	int "TPM PCR index for root domain"
+	depends on SECURITY_TSEM
+	range 8 14
+	default 11
+	help
+	  This configuration variable determines the TPM Platform
+	  Configuration Register (PCR) that the coefficients of
+	  security events for the root modeling domain are extended
+	  into.  The default value is one register above the default
+	  value that IMA uses for its integrity measurements, in order
+	  to avoid a conflict between the two sub-systems.  If unsure,
+	  leave the value at its default value of 11.
diff --git a/security/tsem/Makefile b/security/tsem/Makefile
new file mode 100644
index 000000000000..d43cf2ae2142
--- /dev/null
+++ b/security/tsem/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_SECURITY_TSEM) := tsem.o model.o namespace.o map.o event.o fs.o \
+	export.o trust.o
-- 
2.39.1


