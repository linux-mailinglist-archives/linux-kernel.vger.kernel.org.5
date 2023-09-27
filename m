Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2F7AFBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjI0HWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0HWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:22:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB78BF;
        Wed, 27 Sep 2023 00:22:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FB5C433CB;
        Wed, 27 Sep 2023 07:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695799349;
        bh=ie+gDwMLwUQ8Z89F6h2q5E8Syfe9PDI3vuz9pSKTnG0=;
        h=From:To:Cc:Subject:Date:From;
        b=gCFdqpmx9M72kPP7CNAQQGCOQmOE3LpCAmQ7oxYgX1FAzceSh53vZTXDqWK521DCP
         N2LENb/9ieHXwkGBQMjNyoGFrcfFqfhaaiSQuiUyTYnZ2mxoloO6iHHeWtSI/zGhQ3
         abBsJPJTyQp+/nW54GsFeXrMGlX7XeybL6I97AjNyE3vLWG7VowMDx2au2HQqYlgVT
         NHMoXKe7etrDw8ITUnIg+q9drfFcxNxcQcY5KF3mrrGGWKb+pv9ZlGoz3AAvYXJgfq
         4xVBCbDVhR+FNR+UksAazFv1PUDFea7B51i3gEr+W2o8NqqnsA5t/Msf5/EHzcN6q7
         ZGS1UD6VY+O5A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: rework CONFIG_IMA dependency block
Date:   Wed, 27 Sep 2023 09:22:14 +0200
Message-Id: <20230927072223.2555698-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Changing the direct dependencies of IMA_BLACKLIST_KEYRING and
IMA_LOAD_X509 caused them to no longer depend on IMA, but a
a configuration without IMA results in link failures:

arm-linux-gnueabi-ld: security/integrity/iint.o: in function `integrity_load_keys':
iint.c:(.init.text+0xd8): undefined reference to `ima_load_x509'

aarch64-linux-ld: security/integrity/digsig_asymmetric.o: in function `asymmetric_verify':
digsig_asymmetric.c:(.text+0x104): undefined reference to `ima_blacklist_keyring'

Adding explicit dependencies on IMA would fix this, but a more reliable
way to do this is to enclose the entire Kconfig file in an 'if IMA' block.
This also allows removing the existing direct dependencies.

Fixes: be210c6d3597f ("ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 security/integrity/ima/Kconfig | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 4e559bd1fd41c..a6bd817efc1a6 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -29,9 +29,11 @@ config IMA
 	  to learn more about IMA.
 	  If unsure, say N.
 
+if IMA
+
 config IMA_KEXEC
 	bool "Enable carrying the IMA measurement list across a soft boot"
-	depends on IMA && TCG_TPM && HAVE_IMA_KEXEC
+	depends on TCG_TPM && HAVE_IMA_KEXEC
 	default n
 	help
 	   TPM PCRs are only reset on a hard reboot.  In order to validate
@@ -43,7 +45,6 @@ config IMA_KEXEC
 
 config IMA_MEASURE_PCR_IDX
 	int
-	depends on IMA
 	range 8 14
 	default 10
 	help
@@ -53,7 +54,7 @@ config IMA_MEASURE_PCR_IDX
 
 config IMA_LSM_RULES
 	bool
-	depends on IMA && AUDIT && (SECURITY_SELINUX || SECURITY_SMACK || SECURITY_APPARMOR)
+	depends on AUDIT && (SECURITY_SELINUX || SECURITY_SMACK || SECURITY_APPARMOR)
 	default y
 	help
 	  Disabling this option will disregard LSM based policy rules.
@@ -61,7 +62,6 @@ config IMA_LSM_RULES
 choice
 	prompt "Default template"
 	default IMA_NG_TEMPLATE
-	depends on IMA
 	help
 	  Select the default IMA measurement template.
 
@@ -80,14 +80,12 @@ endchoice
 
 config IMA_DEFAULT_TEMPLATE
 	string
-	depends on IMA
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
 	default IMA_DEFAULT_HASH_SHA1
-	depends on IMA
 	help
 	   Select the default hash algorithm used for the measurement
 	   list, integrity appraisal and audit log.  The compiled default
@@ -117,7 +115,6 @@ endchoice
 
 config IMA_DEFAULT_HASH
 	string
-	depends on IMA
 	default "sha1" if IMA_DEFAULT_HASH_SHA1
 	default "sha256" if IMA_DEFAULT_HASH_SHA256
 	default "sha512" if IMA_DEFAULT_HASH_SHA512
@@ -126,7 +123,6 @@ config IMA_DEFAULT_HASH
 
 config IMA_WRITE_POLICY
 	bool "Enable multiple writes to the IMA policy"
-	depends on IMA
 	default n
 	help
 	  IMA policy can now be updated multiple times.  The new rules get
@@ -137,7 +133,6 @@ config IMA_WRITE_POLICY
 
 config IMA_READ_POLICY
 	bool "Enable reading back the current IMA policy"
-	depends on IMA
 	default y if IMA_WRITE_POLICY
 	default n if !IMA_WRITE_POLICY
 	help
@@ -147,7 +142,6 @@ config IMA_READ_POLICY
 
 config IMA_APPRAISE
 	bool "Appraise integrity measurements"
-	depends on IMA
 	default n
 	help
 	  This option enables local measurement integrity appraisal.
@@ -304,7 +298,6 @@ config IMA_APPRAISE_SIGNED_INIT
 
 config IMA_MEASURE_ASYMMETRIC_KEYS
 	bool
-	depends on IMA
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
 	default y
 
@@ -323,7 +316,8 @@ config IMA_SECURE_AND_OR_TRUSTED_BOOT
 
 config IMA_DISABLE_HTABLE
 	bool "Disable htable to allow measurement of duplicate records"
-	depends on IMA
 	default n
 	help
 	   This option disables htable to allow measurement of duplicate records.
+
+endif
-- 
2.39.2

