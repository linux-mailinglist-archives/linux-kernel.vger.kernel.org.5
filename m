Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3E756FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGQW33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGQW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:29:27 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB56B3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:29:26 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8bbce9980so29504755ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689632966; x=1692224966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XFPVhrUWRZQSAaKQnnj1TZG9poZqEqSu3fVdFJa8KKE=;
        b=YHbmAyIqg8BYpJU1Jk+XnlqKZH3UCVovE5VLeCN3tuNUrY/YLOl0HTKZydaosVQ0mi
         bZ/+W7LaITxuZQ7V0/ZvDUCbe8DuZA62WoXOTwBKy/EH1GOSsAU1WER+eLG5I3bcGQ8g
         9RubTwXoJcDUl8g3IOnz3/GFqSZACjnxzTlCj+4JqoaaXj6mcm/Pbnow99OvOfjdCBkR
         juCPV3H7FJFjkVSd1lhUxp3cd0E0Pg7TUp1lyVgFshzwbhi8ju8hQFNSyiHsXMlks4Mu
         tF6014MG/tDwXw6owFkRGs3p712Y0TRM+xwwZ4ZAyVtu+hsrNEFxxR0Y0OuIfe9awYnk
         teCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689632966; x=1692224966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFPVhrUWRZQSAaKQnnj1TZG9poZqEqSu3fVdFJa8KKE=;
        b=EZ+gsGVVveNwnlZS9FhiJDX26l1BlIo7egXQ5dreiMoYrtWx+naQ8WsgwlOl5Tccef
         +lfY5v6NfCFDRzPpqNO8B85jN9mtSTYqkhQOO6q7jSq1XTF2YNN+LrFrYF7odTybWGpP
         7wNne0GXUWWCh4egR+y6rkhUiuwtXL0754cNgLiZS66KHTPJ0JWLC+lvy47dDuqh3Dt/
         HR3CgsLd6vweGjbWT922q5uPwZHMrslddTerupUyPNeGBz/7t7kbB35nal7S9hCQ8cyH
         A8Fo/Yn3wJZ/Xq6b/XoIbqxUv2CFmlJFo8dAff+TQ1p0HQWzxmj0CMxr8v1JAXTsETu5
         4Vog==
X-Gm-Message-State: ABy/qLYd1ok+NlrgPMx41+rRWQK27LwkQrDi4QEmlfP43kbpm5zlUTKe
        KdjNeJ1m6NER3aYqrFnGYxfBXA==
X-Google-Smtp-Source: APBJJlGcyS1478AzqSwi9033GBaEO4A6Ib9Gvs0E+TYvAHuX+SPIhJ/+F5b4vj5CO2kQ+M8+NIDK/A==
X-Received: by 2002:a17:902:9a4b:b0:1b9:c03b:39d9 with SMTP id x11-20020a1709029a4b00b001b9c03b39d9mr10939188plv.53.1689632965727;
        Mon, 17 Jul 2023 15:29:25 -0700 (PDT)
Received: from sw06.internal.sifive.com ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b9e8e833f3sm375704plg.61.2023.07.17.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 15:29:25 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Tom Rix <trix@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] drm/amd/display: Allow building DC with clang on RISC-V
Date:   Mon, 17 Jul 2023 15:29:23 -0700
Message-Id: <20230717222923.3026018-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang on RISC-V appears to be unaffected by the bug causing excessive
stack usage in calculate_bandwidth(). clang 16 with -fstack-usage
reports a 304 byte stack frame size with CONFIG_ARCH_RV32I, and 512
bytes with CONFIG_ARCH_RV64I.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/gpu/drm/amd/display/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index bf0a655d009e..901d1961b739 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -5,7 +5,7 @@ menu "Display Engine Configuration"
 config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
-	depends on BROKEN || !CC_IS_CLANG || X86_64 || SPARC64 || ARM64
+	depends on BROKEN || !CC_IS_CLANG || ARM64 || RISCV || SPARC64 || X86_64
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
 	select DRM_AMD_DC_FP if (X86 || LOONGARCH || (PPC64 && ALTIVEC) || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
-- 
2.40.1

