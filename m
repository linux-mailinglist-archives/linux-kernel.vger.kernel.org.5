Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE5D7F34A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjKURNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjKURMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:12:54 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059E10CF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:48 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9fa2714e828so472101066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586766; x=1701191566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyQP3CLH+UgiYNt7ar9Le/i9ANxBjXIZotdCtvdYulE=;
        b=fobVewVqHZrW4qNm7js+THnvNaF5aSqNFfkZ95tUhp7KL5BrqIWhSAymHgPwqnwDJd
         fizFOK7L/4H8c0yC3EoqJMEU/BxWAQJHeRWylAatl3hnPm1BFSSACZV32PdnbeKzk5E/
         RGcsV+cjkp9dw4XrMJAFqq8DWGycivpzBAjCb/vWN2AnzyMLf1hV4BavjUiQpekzOO2E
         nbvvYhx1Pc2KcAqR1DYh0sljmdgjEFCSCAgdIdDH3fr/i+ULu6R4Vamuzkv+fQrst/7l
         6PElO4+PCuUgvIvghUvI8b1xoh79XbHGJ8TW7EmrjUjyE19Jlx0ZaBz91hUmz9xnOwGP
         GOsQ==
X-Gm-Message-State: AOJu0YweSpIM0m4kAJbAjueIgfM/H5jpWutIvOVHgz6GBgIwRG1oukYb
        I5QKcZ3L6X5KHQU77SvnZXg=
X-Google-Smtp-Source: AGHT+IG48Z9JWBg8iiCy4FgrT4+Bjxjb/xXCJUe+75rKUWqXMFbSLBkqRFrJiXPzEftHLYTjgJeINw==
X-Received: by 2002:a17:906:10c:b0:a01:1cee:53cc with SMTP id 12-20020a170906010c00b00a011cee53ccmr2552111eje.66.1700586766579;
        Tue, 21 Nov 2023 09:12:46 -0800 (PST)
Received: from localhost (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id lh3-20020a170906f8c300b009dd7097ca22sm5530302ejb.194.2023.11.21.09.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:12:46 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/13] x86/bugs: Create a way to disable GDS mitigation
Date:   Tue, 21 Nov 2023 08:07:38 -0800
Message-Id: <20231121160740.1249350-12-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no way to disable GDS mitigation at build time.
The current config option (GDS_MITIGATION_FORCE) just enables a more
drastic mitigation.

Create a new kernel config that allows GDS to be completely disabled,
similarly to the "gather_data_sampling=off" or "mitigations=off" kernel
command-line. Move the GDS_MITIGATION_FORCE under this new mitigation.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 18 +++++++++++++-----
 arch/x86/kernel/cpu/bugs.c |  7 ++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ee939de1bb05..b1a59e5d6fb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2590,15 +2590,23 @@ config MITIGATION_SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATION_GDS
+	bool "Mitigate Gather Data Sampling"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Gather Data Sampling (GDS). GDS is a hardware
+	  vulnerability which allows unprivileged speculative access to data
+	  which was previously stored in vector registers. The attacker uses
+	  gather instructions to infer the stale vector register data.
+	  See also
+	  <file:Documentation/admin-guide/hw-vuln/gather_data_sampling.rst>
+
 config MITIGATION_GDS_FORCE
 	bool "Force GDS Mitigation"
-	depends on CPU_SUP_INTEL
+	depends on MITIGATION_GDS
 	default n
 	help
-	  Gather Data Sampling (GDS) is a hardware vulnerability which allows
-	  unprivileged speculative access to data which was previously stored in
-	  vector registers.
-
 	  This option is equivalent to setting gather_data_sampling=force on the
 	  command line. The microcode mitigation is used if present, otherwise
 	  AVX is disabled as a mitigation. On affected systems that are missing
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f2775417bda2..0172bb0f61fe 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -671,10 +671,11 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-#if IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE)
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
+#if IS_ENABLED(CONFIG_MITIGATION_GDS)
+static enum gds_mitigations gds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE) ? GDS_MITIGATION_FORCE : GDS_MITIGATION_FULL;
 #else
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
+static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_OFF;
 #endif
 
 static const char * const gds_strings[] = {
-- 
2.34.1

