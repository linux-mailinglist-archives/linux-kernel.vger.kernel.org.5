Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97FD7E4215
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjKGOtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjKGOt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:49:27 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7A9102
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:49:24 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35957d77afcso12018225ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699368564; x=1699973364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
        b=YmFFeNUC5KZ7lzAMYl03QjdBl9onDbkVjOrSh7GMG4AgP9P8wXdbZVwgagkmY/Cpwd
         ELa2bEBBAfFnNaU6hG2Vn6hkPu3tijNfeKW6GRy5JfOPNNYvjFKbr/QtWagelBcRHDg8
         88ErWDV/DV8stC/bFx34DcGWMFoxNULpXqWNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699368564; x=1699973364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
        b=qbWHG+MaBAy1pFMgGQh/5nrstGqM7Pk3W2c82N5ZuQPcgNtmy75EsFEENbWsoffpg+
         +ymULA04OKAWZUy6lZzsaWzHr7ulSZOqisNvIXXCo7JEmZM+cfDOWeuKV0iJGXfiJz9k
         3TQEzv3hptFJwFOCWOBMB0SuYYF6/I7QsOvINbKigd7Exkx1tYzvysuUVtCkzOQde5+3
         ee3v+M1r2pTZ0oP0bANUtFNxFYuJ2DHH+gXA2KMw1WT6VbTErEL6yvmTfUo01S+xJW37
         ePWtwGC3ycjxjG708uI48Whkkx05aZMMoqhuempyEuJif4tKjVIvpUxm1eeGNCXL+j0L
         k8Jw==
X-Gm-Message-State: AOJu0YzWZoEckbyMLW1rpWhWNdZPnuDTW+GVURa/teLHpQWLnNKX5EEL
        vxWz6wnLKWEPcNq9yG43de65KA==
X-Google-Smtp-Source: AGHT+IFwrc4laN5WRGczr1HIoLEY3sGt0wG6iwQWSFLgABNJrxoQEvucY/YLmMfcQGEwsAJ+0F9v4Q==
X-Received: by 2002:a05:6e02:1bc3:b0:359:3491:9042 with SMTP id x3-20020a056e021bc300b0035934919042mr3014205ilv.9.1699368564218;
        Tue, 07 Nov 2023 06:49:24 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id b16-20020a05663801b000b0045a66a26208sm2815200jaq.128.2023.11.07.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:49:24 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] kbuild: arm64: Add BOOT_TARGETS variable
Date:   Tue,  7 Nov 2023 07:48:49 -0700
Message-ID: <20231107144917.48304-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107144917.48304-1-sjg@chromium.org>
References: <20231107144917.48304-1-sjg@chromium.org>
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

(no changes since v1)

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4bd85cc0d32b..7b77b63e978f 100644
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

