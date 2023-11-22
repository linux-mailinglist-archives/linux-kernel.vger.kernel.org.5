Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F25A7F530E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjKVWMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVWMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:12:47 -0500
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB01B9;
        Wed, 22 Nov 2023 14:12:43 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7a93df91813so6579539f.2;
        Wed, 22 Nov 2023 14:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691162; x=1701295962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU6Wnghj5KH1Ld3lLkNyhwgfAXJhDGyB0CCvRi7u8mk=;
        b=UthVPCrkPmuaSKUpj8hiQFvad2Bn3BhipezxF0q9MXsmZXF2YcmG67xt4d0EwJcAlt
         1EGHrqmIS+C3trWjV+xrjV4+9QUxOzTmZ05uo0hlD/B7JSjAiLa026Tm62EmkbEda06t
         WEJk2EH85L7uFCpVtYQq/HFNuCoPQBCRgYecP5JKIbfu+v//01SyhKoA1f+f2HvjO/oL
         CSLwdjWd1S+RCnfJOMXHnHgVlmx7ayvUGGcqdkocLFPtW+u39r7HQMN8Rab2+0i8hnKz
         sza2ZakkiflBqx+x1KHtUkJmItDpQxZs0YSlT3q5a/8f6fs+pUblaILtz8AY2++7+5/Q
         INiA==
X-Gm-Message-State: AOJu0YzL8w2dcOTnHFBHPGQZTRKtumb2Ljq4zhuVhxU5Kme2gs/ZYh27
        jKitkDsZ8Z6nUMFEQugiY5x37Nh92w==
X-Google-Smtp-Source: AGHT+IF8osr8TMYr2K7RbdJl1f0Qs0a8Vvy9ayPPg6W5HhHI5G6ri/6sDydnhfguLO7f2AvVQEKSig==
X-Received: by 2002:a92:908:0:b0:359:d397:c806 with SMTP id y8-20020a920908000000b00359d397c806mr4100582ilg.18.1700691162319;
        Wed, 22 Nov 2023 14:12:42 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r3-20020a92cd83000000b00357ce043118sm159221ilb.79.2023.11.22.14.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:12:41 -0800 (PST)
Received: (nullmailer pid 2753836 invoked by uid 1000);
        Wed, 22 Nov 2023 22:12:33 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Nov 2023 15:12:32 -0700
Subject: [PATCH v2 1/4] kbuild: Move dtc graph_child_address warning to W=2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-dtc-warnings-v2-1-bd4087325392@kernel.org>
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

There are cases where having a single child node with a unit-address is
valid. For example, other child nodes may be optional or added via a
DT overlay. This hasn't mattered until now, but as platforms become
free of W=1 warnings, we want to enable W=1 by default on a per
platform basis. So move the warning to W=2.

In the process, the logic can be reworked a bit to avoid specifying a
given warning in multiple places.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 scripts/Makefile.lib | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..a67f781ae8ee 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -340,8 +340,6 @@ quiet_cmd_gzip = GZIP    $@
 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc
-DTC_FLAGS += -Wno-interrupt_provider \
-	-Wno-unique_unit_address
 
 # Disable noisy checks by default
 ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
@@ -357,9 +355,11 @@ endif
 
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
-	-Wproperty_name_chars_strict \
-	-Winterrupt_provider \
-	-Wunique_unit_address
+	-Wproperty_name_chars_strict
+else
+DTC_FLAGS += -Wno-interrupt_provider \
+	-Wno-unique_unit_address \
+	-Wno-graph_child_address
 endif
 
 DTC_FLAGS += $(DTC_FLAGS_$(basetarget))

-- 
2.42.0

