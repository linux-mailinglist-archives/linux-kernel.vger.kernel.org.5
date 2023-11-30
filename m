Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC27FFC91
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376725AbjK3UeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376345AbjK3UeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:34:02 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A110E6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:34:08 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35c18e55633so4146965ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701376448; x=1701981248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
        b=PMYS0HwfzKU65GsBpCN6x+25XDvfJcRAYk3azA12qAsUa0I6PesBXrIGGs894X5Ap0
         xcMjuIjlHGGa9LP3Al/eLO+NWKQDJx/kK9uKUZRF0kuoAlPtThNUq51yag7cNIUqTqlt
         cdP/vunitgRlsCtM7k/g0PBBoXDicQg/wOj5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701376448; x=1701981248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
        b=rGmdZ0Y2XwdIXbvrVs6gw34b61Gk4RxXrye7a4P5AuTDWDDZe7nfc0hlI3adJEr6FR
         S/U7zbT6e5XgNmtIUBGfwbw/wrN7IifOvPqooygapPY87qPAaM90Ap3nTIYEAkJMnAxG
         CDCXq1t5eayF+/v/mrh3i3tylkfbRMiX8KRiiwLmYXx5qZX5UsFcMODorDY6bIOyQJsP
         MKpaLvrR4yYbaipnmqyDTlstNHOQakMo/jObu2I6IBUrmPq1XP8jxpxnCm3fqBh5AN+d
         3EBx5A076gTY5vf1f3hEbViB9UtupB8RLqyER1h1XsHGfZzBQjeBcKp7eBCWEJBJ+q1r
         Cl1A==
X-Gm-Message-State: AOJu0YxwX0/jewsReI0S24AA+cgHFeMMITquLm8Eo+GmeOS50a37j1YO
        CUEWfxo8knlOE5LEPJbTvnnfhg==
X-Google-Smtp-Source: AGHT+IH+ngzFDU9faV0d7Hcc2/3b486G+AlJvx/x6A8mnmzkSgzG/ZftC3rccgUkt+jcZs/DxZicRg==
X-Received: by 2002:a05:6e02:1748:b0:35d:42e5:f751 with SMTP id y8-20020a056e02174800b0035d42e5f751mr3946346ill.15.1701376448283;
        Thu, 30 Nov 2023 12:34:08 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:d134:ced6:d34f:38a6])
        by smtp.gmail.com with ESMTPSA id r21-20020a056638101500b004665c3f56ebsm484788jab.15.2023.11.30.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:34:07 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v8 1/2] arm64: Add BOOT_TARGETS variable
Date:   Thu, 30 Nov 2023 13:33:54 -0700
Message-ID: <20231130203358.879796-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130203358.879796-1-sjg@chromium.org>
References: <20231130203358.879796-1-sjg@chromium.org>
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

(no changes since v7)

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

