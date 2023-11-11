Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DF77E86F0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbjKKA3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjKKA3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:29:37 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE9B3C39
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:33 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d0ceba445so15109686d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699662573; x=1700267373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et5CNEbbpEZc7/GZDGct9Q6Ku2JLjZggspOXrOUtq84=;
        b=jCJRr3OKUZEcYzMNJOYm1t2coSht7aLjNgoGjN0LaN5whas+IGLRWasNAF0WsD17Eg
         bz3z4SrNAKkLMo+cg300sH0YUaE4Pns8Kg4JtWcTB6RZ2V2AKcK1MeJyylfLFPKG9VzP
         2sORn4m1q+Zv2RckZpFBv164xVJ52KhQeUsjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662573; x=1700267373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=et5CNEbbpEZc7/GZDGct9Q6Ku2JLjZggspOXrOUtq84=;
        b=YYGzQRgNh0oCa5RFO7CtZkSDJODvHIBy+h0A6RVjJQZHRv6IWx7iS+zsB8+AbD5292
         hkfAiZwZPl5W0NpUT5dkY6vcDIaP3Vg9hJHrvgI4tRuzwkB8DzehlVn/vqHH0f5AJP3w
         5129Z7WQA+GWNZHv0SOJ3LqxONfeYR1WYfDi8u9lRQSR4PHoFpiQkraD8FdkZBoFQEdG
         lPUDTFmomnYLBLMrWWwmqslGrnAlvWXQVk32BBS91IiqEDHfOC6Ow0dWzN9ZUCwTU3n5
         NOEFtGxXlUWr+YoqTquS0YkOtmwE18Ut7jAKNxU5Zm8rUthbXXTFoSxOw6VyC+HxOVA5
         qEHg==
X-Gm-Message-State: AOJu0YytERyY/CmSuYmJfwkes0tc+gYmcv/DiGmTGzyoTW+02jSKQ95o
        PAO8GSwFEjGoyN+4onEeoY5VBA==
X-Google-Smtp-Source: AGHT+IEN8beePUf5tFQkONDRQomBUyxK3TsSyakryn92MhWDO9HPDNzsR0zDFHQT0xvjn7EW56ku0Q==
X-Received: by 2002:ad4:45b4:0:b0:658:1eec:408a with SMTP id y20-20020ad445b4000000b006581eec408amr734218qvu.40.1699662573056;
        Fri, 10 Nov 2023 16:29:33 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5104:5a27:f95d:21d1])
        by smtp.gmail.com with ESMTPSA id l16-20020a056214029000b00677adcfd261sm55898qvv.89.2023.11.10.16.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:29:32 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     lkml <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v5 1/3] kbuild: arm64: Add BOOT_TARGETS variable
Date:   Fri, 10 Nov 2023 17:28:00 -0700
Message-ID: <20231111002851.1293891-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231111002851.1293891-1-sjg@chromium.org>
References: <20231111002851.1293891-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variable containing a list of possible targets. Mark them as
phony. This matches the approach taken for arch/arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2d49aea0ff67..cd9bca2358d2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image.gz vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -159,7 +163,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.42.0.869.gea05f2083d-goog

