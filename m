Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B127E400A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjKGN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjKGN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:26:35 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246529E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:26:32 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a94a3b0a49so204474239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699363591; x=1699968391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
        b=kHusprIMaj5aHX467GCbunc3iTkxfEPkGHGYqIcJgrDBba86R4LYxPwqiLmhfME2uo
         BGFK53qsVTLyeV/oCUwbCp7uSINAhFybNPtG0AIR/wSPd1KOneogMi6jzYfFXyB6HHBP
         I1m6MkhtsQCOp2VxgRx4MO5GEZfSf/lMUuC2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363591; x=1699968391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
        b=WASg/rzq3wJ+MhKut7KXGGnvqnR4Pl/StzQ92Ms6rbJspVqNLpx7aPv0YJcuYk2vf2
         7/G6UYGLzJp8r4Hdrn73RkQROQ1NrAHuAY89wGQCt6vpJzTtgqC9+POU0DZ99OizFLtB
         VjgicTJCMCwGmZdHBR84VIQRfUwaBClEolij4xyR+2iSU8WYsWZu1WiCqFe8d2xYBqfa
         +GKcAHLZcbbzd6FBghWyPoe8Rh8dni//LJwbn1kSdFL3MAgEZxFExJ9yerpzu180AArJ
         jHzI5rT/r1zIIjdQiNf5SYrYAMtnUrvWnP5/KiqM94AdR8B9R1QBK8L7n7GPqpzqTjwg
         TO4w==
X-Gm-Message-State: AOJu0Yz7px3NWDZ+s0Y7Qmm03rzzXL+mpreElOC5pCPnBf8fcsQM4KRy
        YEzyvJfXZCfFbShWM5EB3rn99Q==
X-Google-Smtp-Source: AGHT+IFA2Meg21EeLlaQDzpshWitOcfdYqDCyk1R7zr9wR5+pxet1yylcylsnJ+ZznmSM2QLqVbohw==
X-Received: by 2002:a05:6e02:1847:b0:359:4199:1fe4 with SMTP id b7-20020a056e02184700b0035941991fe4mr3384295ilv.10.1699363591508;
        Tue, 07 Nov 2023 05:26:31 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id db8-20020a056e023d0800b003596056a051sm3141589ilb.71.2023.11.07.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:26:31 -0800 (PST)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] kbuild: arm64: Add BOOT_TARGETS variable
Date:   Tue,  7 Nov 2023 06:25:53 -0700
Message-ID: <20231107132619.34062-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107132619.34062-1-sjg@chromium.org>
References: <20231107132619.34062-1-sjg@chromium.org>
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

