Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6DB7D7D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJZH17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjJZH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:27:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F219F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:52 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c87a85332bso4731245ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698305272; x=1698910072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5HROyknCuzezfPnKKu8GDq6Ak0A1oqAWU9OMPRzgBc=;
        b=eOSg+QfQnvK4iJwflaHilWiUIJOir2Za0dxYXpG65BaQ1bl371yS2Rqg4PFrxcdiO/
         hTwzKBcTreEPC+o+vppNNzKcoj3FwuWS9SnxyeqdkCiMdpxTBgY1gfVPioWL9Fu12Z0p
         Eag0LMHlsA3nPb5C0JeiHlUCoH1PQg0UJR/70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698305272; x=1698910072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5HROyknCuzezfPnKKu8GDq6Ak0A1oqAWU9OMPRzgBc=;
        b=t50qCiiLxOomqK/y7aBokEr9Io5O6FeOQOVzmroQirI9Ztr/C0/4Ld/JwQu8TmdRwW
         WRYpZzbZ6r74kCYLBSj25sJ0G3Kk9yHfaQoUwEcbtc47lNgCO3+Jvg16/Hub73edZ7wV
         MhxKAxljCdHuW5xjT6V70LrYX6XJYY0RrQI12tuYXbw1jH+ZwFA1itfIZjE9Rr+pUwE+
         QFsLKV+AF6CvPmlBKhPoNEXNVr90BeNM3QnPyrzD2hJghO4tsnA9p7DrJTCmBrroVShk
         W57byoSb4ala6hc7BEA5o+fV3q/09mTr5ZgaHa5RmiqdyTBfBsC3SjI/wesfLiWP1c5m
         XkTg==
X-Gm-Message-State: AOJu0YyP3JokUBcVmkk19pRm5eVC2NT60ggrhJPV4BGWbOQGyGo644UG
        Ulpt9/rSeeax70mAwloAx0DR2X8scX3BhHqgOyh1mg==
X-Google-Smtp-Source: AGHT+IHLgMaOOEK4ReQTWHExwr7/eZYHbMKrsEkSXncJZod4bQAJS7bbZdeJ3aYm6Bj6VZxgH+W5gw==
X-Received: by 2002:a17:903:200d:b0:1ca:754a:692e with SMTP id s13-20020a170903200d00b001ca754a692emr15633418pla.30.1698305271862;
        Thu, 26 Oct 2023 00:27:51 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001b7cbc5871csm10294023plf.53.2023.10.26.00.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:27:51 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Simon Glass <sjg@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] kbuild: arm64: Add BOOT_TARGETS variable
Date:   Thu, 26 Oct 2023 20:26:24 +1300
Message-ID: <20231026072628.4115527-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231026072628.4115527-1-sjg@chromium.org>
References: <20231026072628.4115527-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new variable containing a list of possible targets. Mark them as
phony. This matches the approach taken for arch/arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.42.0.758.gaed0368e0e-goog

