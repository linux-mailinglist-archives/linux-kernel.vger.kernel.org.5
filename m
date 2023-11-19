Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E287F0700
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjKSPCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSPCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:02:40 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7049E1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:02:35 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7aca968a063so152009839f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700406155; x=1701010955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPDLaEBsiuaLoWhERQwxK3nM6Hz04+6uU6ZsB6GmVKQ=;
        b=KWGFHmne20E8qkdoBvrTXcmVOr+EMQh/wLZj3+3175rh9yGgUtMzsy+KLNdsS23AqU
         wvWorwuD5Ak+nf9O9SmF8UhckoPbkoYEoU6sTm2P81O9XBGnXfpn+/u6trvfk4Wvk40U
         /ugulVeZtFPLkTYI6w7VaaxqAqTa15KB9R1XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406155; x=1701010955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPDLaEBsiuaLoWhERQwxK3nM6Hz04+6uU6ZsB6GmVKQ=;
        b=bDYfd5Ixf9xmjHEG2tzOjJsi8TkPIxTTbkQhXT1JkgTt+W1ssMZyIov2gOhhVlN8Rf
         A+PJ8+m8bZANxGXWEAuZiWiUf8eVJ+U6WRcp9HFk3Il5OoKSUo91/iFGNeU02G3a6nEC
         QIVc2iY9+kGSA398KB91ATfaYUBykZRVzkG8o7ce/9NL2uLGryvPygTd/EmkYqu7BEu2
         npyULWPHjfih+90ZzZfXI2gknIB/kcG52mZp+CUsq2NyCxY/xb+TqwH/j4zNDNunEExu
         Kcs11adG3Q21hrRzZOcx6M0gCN5m55mGgSSjEkhBJ/PJOc4qqwwWcZDb7E16jLXYGeOz
         Jhbg==
X-Gm-Message-State: AOJu0YzL5mgKF3SLRSqJnoM1P+q1n5Am8q+hW0cNTm1nG4QncQapJzCN
        Wud2ixcqxR+0PVDYdBHG28qfdA==
X-Google-Smtp-Source: AGHT+IEx7n9lWgQ5ZHDpFV/rohuH4tUzvXPoC9/I4DFizrOn2jcqxdjt/zGZCjyAWhAQMdYpGaWrNQ==
X-Received: by 2002:a05:6602:c7:b0:79a:b667:4e97 with SMTP id z7-20020a05660200c700b0079ab6674e97mr5843610ioe.0.1700406155245;
        Sun, 19 Nov 2023 07:02:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id w24-20020a056638379800b004665bec29d1sm79923jal.128.2023.11.19.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:02:35 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] kbuild: arm64: Add BOOT_TARGETS variable
Date:   Sun, 19 Nov 2023 08:01:14 -0700
Message-ID: <20231119150229.634424-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119150229.634424-1-sjg@chromium.org>
References: <20231119150229.634424-1-sjg@chromium.org>
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

Changes in v6:
- Drop the unwanted .gz suffix

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4bd85cc0d32b..ae0c5ee8c78b 100644
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
 
 
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.43.0.rc0.421.g78406f8d94-goog

