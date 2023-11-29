Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553F7FDE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjK2RWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK2RWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:22:44 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5A10A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:22:50 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35cd70d7735so12329885ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701278569; x=1701883369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y4u1Nj+AksGSx6UaBsaN0nYrI4rh/YV1H5l1JuASz8=;
        b=S0pOlmHW2VPjUFW+5TNlX261QsSnndlMt/A+4NzyI8KPmJ7vF6C7nFujTKrRbGjirO
         e9ivrtaukox3+U3/WLpR7KoghAyHjP6m6Xm/47KeSFrb92PhHY7CzYuTsKnXFzHLu6g/
         XoPU+AauCI8F46oLLPXKpxV5LgjWeNiCZbHmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701278569; x=1701883369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Y4u1Nj+AksGSx6UaBsaN0nYrI4rh/YV1H5l1JuASz8=;
        b=Ws9bDIr7SkMbXMm+s9zTK9QCj0kO8zDSaarfyk2Ka871n1uEEoz26BqE0veRJGB3uv
         2S1N7JzupNSBwmC0sf0aKcKUawO554yej8CGF/HPvAPygBp/hpWo3Xcnsu78wop+FjWJ
         LFPBh9+7yUBOQM7vqhD2JFmcGS0sPGqpIJwH8JjUT7aHV01yc+sgqTjlngXuNzL1BFPI
         oD9eRQHnwFhNIrepf1ZtXlaeeuhO4P73eQ1zdDEpLgPIpy3nRsdzV9h6Oj21AeSryK4B
         Hil7+90E1aCX2E+o21A+tEahSw5MboJCbSy9CsOEN7+tuVsutclaN4t/nqN4IkJNF0bd
         VDkg==
X-Gm-Message-State: AOJu0Yz04+zN9HsVDl0rlhx0MNPQvtmNYExHE8bADLPUGxp8rR97BfGR
        06SAa8okCDzxzkVoS2n+aU1ESQ==
X-Google-Smtp-Source: AGHT+IGoKYqPmZAGwWLDW7tQod2JEp4OUoLYANKOnDLWolFNogzs1E68dUptxIsNKOqzFj5oWiR7Qw==
X-Received: by 2002:a92:cc49:0:b0:35c:8738:7e52 with SMTP id t9-20020a92cc49000000b0035c87387e52mr17451545ilq.4.1701278569521;
        Wed, 29 Nov 2023 09:22:49 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:f4fd:5056:45a8:b749])
        by smtp.gmail.com with ESMTPSA id di5-20020a056e021f8500b0035d2fc4ce47sm471212ilb.9.2023.11.29.09.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 09:22:49 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v7 1/2] arm64: Add BOOT_TARGETS variable
Date:   Wed, 29 Nov 2023 10:21:52 -0700
Message-ID: <20231129172200.430674-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231129172200.430674-1-sjg@chromium.org>
References: <20231129172200.430674-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variable containing a list of possible targets. Mark them as
phony. This matches the approach taken for arch/arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Drop the kbuild tag

Changes in v6:
- Drop the unwanted .gz suffix

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9a2d3723cd0f..1bd4fae6e806 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -159,7 +163,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 vmlinuz.efi: Image
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.43.0.rc2.451.g8631bc7472-goog

