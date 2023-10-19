Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2B7D01E6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbjJSSiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbjJSSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:38:02 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F5018D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:55 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5079f9675c6so9476594e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740673; x=1698345473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wupshIMCpdF3An7/GpORSd/SdDVEO5hCiOARToeFhp4=;
        b=G4dN4T+iQ9RhfZgZo5JMAx8xp1JWxJgufdkEjDs2lnVQSQHAK2TmVvqAtF5vHLaLMn
         HCE5xN2Nh4xnEKi41SJ11dnBwU84zCtqrvsb97wPKz8NoATznNa08nFyMzRJmcNEJZzU
         lbV2hWaYXQNNEKW0IPh+6dsa2yffq8zOwwcD3lnCYVzclQmGAbtRl0olvWXcRunjEXtI
         zNDwdH7mGevbr9cCkpEqY5i4MzpYJKNytVYwe4ZxYgv6uZzhNdHzLK3aDx/Ah+Sme89M
         5z9GvRZxGA+VXe0QNbYpNztuvW8IDQGw9nj8wzoWRdpi+4R8GdliaQCJ4NtTDGbyPW5b
         eIkg==
X-Gm-Message-State: AOJu0YxOAE7yHkuWEYysa3NdvpEUwjAivwSuQCFwXOOuWUDsYoAU4wbD
        podlWgpCLbQeZVn+saO9lYg=
X-Google-Smtp-Source: AGHT+IERw/Z4fWcqQ0qZ6hbmv4XyawsxWzOg8QM/CrRaAWH1yy94SMiMZL20cguWjuFYmi6A/wiwEw==
X-Received: by 2002:ac2:4827:0:b0:4fe:347d:7c4b with SMTP id 7-20020ac24827000000b004fe347d7c4bmr2019060lft.7.1697740673276;
        Thu, 19 Oct 2023 11:37:53 -0700 (PDT)
Received: from localhost (fwdproxy-cln-021.fbsv.net. [2a03:2880:31ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090671c600b009920a690cd9sm23712ejk.59.2023.10.19.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:37:52 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 11/12] x86/bugs: Create a way to disable GDS mitigation
Date:   Thu, 19 Oct 2023 11:11:57 -0700
Message-Id: <20231019181158.1982205-12-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019181158.1982205-1-leitao@debian.org>
References: <20231019181158.1982205-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
 arch/x86/Kconfig           | 16 +++++++++++-----
 arch/x86/kernel/cpu/bugs.c |  7 ++++---
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7a283602b257..a5cada7443ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2566,15 +2566,21 @@ config MITIGATION_SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
+config MITIGATION_GDS
+	bool "Mitigate Gather Data Sampling"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Gather Data Sampling (GDS). GDS is a hardware
+	  vulnerability which allows unprivileged speculative access to data
+	  which was previously stored in vector registers. The attacker uses gather
+	  instructions to infer the stale vector register data.
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

