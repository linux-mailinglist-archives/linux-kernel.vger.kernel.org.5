Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8487F5315
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbjKVWMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344637AbjKVWMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:12:52 -0500
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93881D53;
        Wed, 22 Nov 2023 14:12:48 -0800 (PST)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b350130c3fso6485339f.3;
        Wed, 22 Nov 2023 14:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691168; x=1701295968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvKVScUhvKKHq5yH2cV8DV0lJfU3kh2MuS6ZYH4ebh8=;
        b=HiFRz5NnDAw1OP/A8dBJikYWxNB6udr/LmxBA+xh6y6ObJQxLUFsF++WmF7XMkT6NU
         U4srEvw8Wn7/T+qqbFdUU7CALMDXGALWdNwHJZxnTd6oEwlrEx4RicSGoFwrmVb+H2sJ
         nPRe5TYdx59t4LWVAaQea4Kzcq0/4icA2XRPrAu5sUg0e8eJTBzG1pRaUiPInCVuADLe
         lXxh1NvMeLloZcr5NRSd4KM8ymrgfZ/UdrcE7KUHSt4MSBUOcwD5wVQBAf6itQiWJVZU
         5Vdzv71F0CY4M1Lcakdk4UUE3MV4hjvBTT145+GMnN/E7w7VyUUQGSUY9bVopYtu8w3G
         FHJQ==
X-Gm-Message-State: AOJu0YzrahSUME/P+8BubZTGpuQAGnnQs3pC6N7u6k+YOrGNUWvTNS0h
        t+3pAnw+fHxKaqPJf5fH9w==
X-Google-Smtp-Source: AGHT+IGLO9xpcHV8HSJx4kSfogE9LNdREnwsjAbOU8PWDbp45WItqfhi9+N7Ml1bG8W7Xsf1CyrYyw==
X-Received: by 2002:a05:6602:2c96:b0:792:8d16:91ef with SMTP id i22-20020a0566022c9600b007928d1691efmr4004136iow.18.1700691167790;
        Wed, 22 Nov 2023 14:12:47 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q10-20020a02a30a000000b0043a0aa909bfsm83341jai.159.2023.11.22.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:12:47 -0800 (PST)
Received: (nullmailer pid 2753838 invoked by uid 1000);
        Wed, 22 Nov 2023 22:12:33 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Nov 2023 15:12:33 -0700
Subject: [PATCH v2 2/4] kbuild: Allow arch/platform override of dtc warning
 level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-dtc-warnings-v2-2-bd4087325392@kernel.org>
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
In-Reply-To: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow enabling extra dtc warnings on a per arch or platform
basis, define a new variable, KBUILD_EXTRA_WARN_DTC, which contains the
warning level and can be set by an arch or platform independently of
KBUILD_EXTRA_WARN. The default value is KBUILD_EXTRA_WARN as before.

The platform setting and command line setting are merged. For example,
with a platform that defaults to W=1, one can run 'make W=2 dtbs' which
will enable both level 1 and 2 warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index a67f781ae8ee..53a74e53e0ca 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -341,8 +341,10 @@ quiet_cmd_gzip = GZIP    $@
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
 
+KBUILD_EXTRA_WARN_DTC += $(KBUILD_EXTRA_WARN)
+
 # Disable noisy checks by default
-ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
+ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN_DTC)),)
 DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-avoid_unnecessary_addr_size \
 	-Wno-alias_paths \
@@ -353,7 +355,7 @@ DTC_FLAGS += \
         -Wunique_unit_address_if_enabled
 endif
 
-ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
+ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN_DTC)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
 	-Wproperty_name_chars_strict
 else

-- 
2.42.0

