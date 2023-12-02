Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1C3801A51
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjLBDz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBDzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:55:22 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ABEDD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:55:28 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b8929269a0so998309b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701489328; x=1702094128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
        b=MEJJgvMUWWmg/A1MhuNm5pq/h2Thxl1NsIjfXH7ulBsHyh76WGLYBIV6/6hkfyqFiP
         3hM1pn7HDb24Q95aJrx0jsQEWwmv8zcppr+3gpI23Z2l2L8kVB1gJoRL2fut/+LYI4Kg
         JGEfmET8ti+JnqeOfhFd3YkXjt4xvrQa6nJKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701489328; x=1702094128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
        b=ITSncaORu/dL8N0lBP+nB7WX0Stw5Wlq+gsjAFivDUmfIn8zvHU0s+qSxdNtjrvn8w
         IFi6Id6TLXIsiNA0+cPOaWaZjH2VrpHp3Ve2+AnpZYk4vVHdHXCko1A+JAhKryvgzBDF
         semj1p9KSElTfQeUBqT4071fwU7xVnddVbAIoQmf4YZ2tT5mU73/LQuMj6tuI1+/WIPw
         T5XeUs/xC32rI2K4caC4nKEuW34ONU3XGJbDiMMFgqd2X7hQFNDt39De7nltDG0IyhI4
         k9IfGkypoIYj6dbu1zbxljbnrJvraiCOViQ+LpU5jKvbLw0GIvSvSRYNt85cro3OeCRG
         EreQ==
X-Gm-Message-State: AOJu0YyO+sy919/p+/2YjSjz03yxDtXRB4AdKJrz09DDm+clmM28nnJS
        L/8KsD68f12UUkkAiznVL5S3KQ==
X-Google-Smtp-Source: AGHT+IFgoGP3RdjYMguEz+gFvB+CJ/dknLHJUw0d0IBBZ00hhH7Fobb6d/sWCE0AymKAln1gR9YdLA==
X-Received: by 2002:a05:6808:1506:b0:3b8:b063:504c with SMTP id u6-20020a056808150600b003b8b063504cmr850392oiw.77.1701489328310;
        Fri, 01 Dec 2023 19:55:28 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
        by smtp.gmail.com with ESMTPSA id t7-20020a62d147000000b006cb60b188bdsm3866565pfl.196.2023.12.01.19.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 19:55:28 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/2] arm64: Add BOOT_TARGETS variable
Date:   Fri,  1 Dec 2023 20:54:41 -0700
Message-ID: <20231202035511.487946-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231202035511.487946-1-sjg@chromium.org>
References: <20231202035511.487946-1-sjg@chromium.org>
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

