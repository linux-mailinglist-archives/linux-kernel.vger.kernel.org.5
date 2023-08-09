Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C1577570D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjHIK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjHIK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:27:39 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB1C2112
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:27:38 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5FFA40E01A2;
        Wed,  9 Aug 2023 10:27:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CMOzuCbjzq-X; Wed,  9 Aug 2023 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691576854; bh=Kqk9iB23zva22rrtFW2VbzZ/5CKBSXXVyARTF51x9QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGka17EZMGm4JXxnMyDhLYGVtgljDnAdoSMNtZ2lOkPViuraS2B0tGP87U1A5YOU6
         pLU5TwFMdeQHwELL4ZBX6r6zyp4O3mHl7b5Pwse17QGn9Ggdd2mrstQBqEHGRcPm6P
         5TDN/bJpeO0PoU7qOLuD8jA8+XJHxyaVg8r2FeJKFrfsOR8eHQZY4dJwAtFInMxC2E
         hc9BZlAp4lIOJuN61fgp9Yfc/Lfu7oB+FhF2cP9VF/0uPZY9+afMdBqzyPDZMd9ZQU
         NdtOFo8/44V08gFZt9Yx2WGA8dNnjDnEF9AdSUqtG5doXaa7SVkcFgkcg0+yfpDTGi
         5nhpi77l4y6muTjA/MECzXAGAvoONSr2c+ukmItFPLtSaJa/iiV5Z4OexUI/3Pxih3
         WDmES3fA80yPoza+Osx1I58FdbJ+2wKT36Z3PLVWNVHUxAx2vqoynTdirOKug5nq5L
         I81VgWACQAwOhIc630PxOq2dmuGhIobCpozVlP6L+Df8HbAfkb+F3LRFd2gz6Ie8uu
         1MuNcOk1qYv1k4LSF8+iFeSfeV3C03p1BjMQxE/6VaaXP1wkiwV5EkAiEGOAJq60qY
         2JlwyTwmu8pt1VhxvwYeHnplKUecCGmNPFa0kA93Jk5S411atMzYOdSXb0lST1+C8G
         BxOydA0/12OUtG7QeIT2vuCQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6874140E0140;
        Wed,  9 Aug 2023 10:27:30 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] driver core: cpu: Unify redundant silly stubs
Date:   Wed,  9 Aug 2023 12:26:59 +0200
Message-ID: <20230809102700.29449-3-bp@alien8.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809102700.29449-1-bp@alien8.de>
References: <20230809102700.29449-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Make them all a weak function, aliasing to a single function which
issues the "Not affected" string.

No functional changes.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/base/cpu.c | 86 ++++++++++------------------------------------
 1 file changed, 18 insertions(+), 68 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 52df435eecf8..971771347aa6 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -509,79 +509,29 @@ static void __init cpu_dev_register_generic(void)
 }
=20
 #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
-
-ssize_t __weak cpu_show_meltdown(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spectre_v1(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spectre_v2(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spec_store_bypass(struct device *dev,
-					  struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_l1tf(struct device *dev,
-			     struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_mds(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_tsx_async_abort(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_itlb_multihit(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_srbds(struct device *dev,
+ssize_t cpu_show_not_affected(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "Not affected\n");
 }
=20
-ssize_t __weak cpu_show_mmio_stale_data(struct device *dev,
-					struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_retbleed(struct device *dev,
-				 struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
-
-ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
-					     struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "Not affected\n");
-}
+#define CPU_VULN_FALLBACK(func)						\
+	ssize_t cpu_show_##func(struct device *,			\
+				  struct device_attribute *, char *)	\
+		 __attribute__((weak, alias("cpu_show_not_affected")))
+
+CPU_VULN_FALLBACK(meltdown);
+CPU_VULN_FALLBACK(spectre_v1);
+CPU_VULN_FALLBACK(spectre_v2);
+CPU_VULN_FALLBACK(spec_store_bypass);
+CPU_VULN_FALLBACK(l1tf);
+CPU_VULN_FALLBACK(mds);
+CPU_VULN_FALLBACK(tsx_async_abort);
+CPU_VULN_FALLBACK(itlb_multihit);
+CPU_VULN_FALLBACK(srbds);
+CPU_VULN_FALLBACK(mmio_stale_data);
+CPU_VULN_FALLBACK(retbleed);
+CPU_VULN_FALLBACK(spec_rstack_overflow);
=20
 ssize_t __weak cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf)
--=20
2.41.0

