Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E716B7E10CD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjKDTmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjKDTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:42:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5B1BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 12:42:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7aca968a063so116896939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699126950; x=1699731750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
        b=JuuEgsV6qW+QChu9bexGZ7OLp+YfIShJ5hC9hzqyOTt9hyLodlODeL3TGk3ro8V/wG
         cWgQbGArskn9UePiW87pjOcPZ8qrmGgeUHBsZKQIlL8Ft7ix3Dd2iWO8EeCtMSjZlZLJ
         zR+/La44r9iodDfL6nt4LYsTeWrEC7yFNan0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699126950; x=1699731750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
        b=dH2C8qZmh6tVdmiSo/iYyr3TUAUhIjnBL+v3sS2vXNtM0Cb4+UrnscX/WjR3zBcoDm
         aTR0UDmVxBByIz5Fgt+vLYKq90t06AZT3Ni4+3q3dGkaDHaKCn0jQGyKF2A2rRJ+B02I
         9+GDYULvkZZ0vetdbXR2/cBuIJrAF5MsFtuZC2cEL/Ca4b+ZAlPqhFAHar/tTvuN9tta
         icbSXjEtTdTS17wiA7xYTe0FPYoG7EZ+7+TTx8h3doiwjtYnZ+IBF3ZPcIU5gkr2GLz2
         5IjRbH/2P+xtSaGs6PE6CVgqbl8EmenODCZsaZWtHhaUn1tdMgixxcu/hu/H98mZvqNg
         jnEQ==
X-Gm-Message-State: AOJu0YxjccLfy5H1XUWHLdLZTBglZADurG3pND4fVYmvudvwqYa4sEv4
        fsY3s2O/fqZZZCjo7lDkM2QG/Q==
X-Google-Smtp-Source: AGHT+IF/fXvPBrPumTSxUQEBjtRyCDMgeyWz6G5jCVwdriNrUNr0MdYxjACyDjlaZtmvTvcGBTB3Yw==
X-Received: by 2002:a05:6602:1592:b0:790:a073:f122 with SMTP id e18-20020a056602159200b00790a073f122mr37121229iow.2.1699126950221;
        Sat, 04 Nov 2023 12:42:30 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id o4-20020a6b5a04000000b0079fbb834232sm1293318iob.19.2023.11.04.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 12:42:29 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] kbuild: arm64: Add BOOT_TARGETS variable
Date:   Sat,  4 Nov 2023 13:42:02 -0600
Message-ID: <20231104194207.3370542-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104194207.3370542-1-sjg@chromium.org>
References: <20231104194207.3370542-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

