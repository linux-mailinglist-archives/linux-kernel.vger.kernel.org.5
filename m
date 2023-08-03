Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DCE76F357
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjHCTSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHCTSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:18:38 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A13588;
        Thu,  3 Aug 2023 12:18:37 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76cb0d2fc9cso96329185a.2;
        Thu, 03 Aug 2023 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691090315; x=1691695115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY28iagrJLfVYSbAhmLtSB9c0xcC11OH45+Lk5Kbw3Q=;
        b=dVUZOw7thQWBtKgV0D+U0kQgJDYZMvCVPmfhxXqx1FwNyWnDAjodctuQTkmMjZtBV6
         b3yy0n0ipIL7FennmHgL0o8hYFpuofhndOpMpWizs8vGxJpDdVewdJuA6oaEAjc3lWfp
         P/C0TR35nK/p8e+CXPqYDNtd5lkeDCXYEC0Nd0tSYpovRU0ay4UBMwSN9PoAYgAhpYXI
         KWcwV+QPTh/0cfZPk6MiqRzH5OlRvvkb4zpJTlmkgooWr31m33cPr7iphNsSbAYY/YMZ
         zoE9VWZgUdXRcUSzpIxCMYTwDzv+Fp1wcz++3E73BiJB3+i22CEoJYnh7XHBFAUdMZB9
         ASdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691090315; x=1691695115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UY28iagrJLfVYSbAhmLtSB9c0xcC11OH45+Lk5Kbw3Q=;
        b=JWHNAvt4ypWcsvKfjHKHJlACnUY0csl+E3/+OQ+aDBuAEdU8jicfVjWf6HKK+vNsup
         TAssN2jTAnD0FRxmLVAiDDwvDFePnEsFo0dhdfpPIEer9w4FGGOR282dHNXPB6+CH10j
         ZHtGOaRzk3ba6P840RVCPPMI3YrlfDoMlss+TIZ28H865t2drVqL04+ghVC5stEPVdPS
         JeGHlHq7fk6da7R2jsylDxJ6hRleiJFdx5Jb9kMCjQvsYqfYVsgNi6xALr7DGRxnh7qo
         KBqXf0HaRjeyWqPkkCm6nYSeLP97CG4NpDnVhnZ71O2QSJB4Y5iaNnyrPbJijiwYvZCg
         MJqw==
X-Gm-Message-State: ABy/qLY62Sei6NXk1I8ErQpKijIaRWtPpcyyrEUCpdv+FVCxjIziL0dn
        +dATfztcIokPu+qR2aBTYKhR4ebe1Is=
X-Google-Smtp-Source: APBJJlH8oeGNGxEL7tM0WkeeF89Q3/UmN90zxj2vF5Ao0jcBZ7WHWHeStSvp4mBJvNrZ+7jpxy5BLg==
X-Received: by 2002:a05:6214:12e:b0:637:87eb:bbba with SMTP id w14-20020a056214012e00b0063787ebbbbamr20447795qvs.8.1691090315609;
        Thu, 03 Aug 2023 12:18:35 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id n20-20020a0ce494000000b0063762ab2f90sm108897qvl.83.2023.08.03.12.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:18:34 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] arch/*/configs/*_defconfig cleanup: drop CONFIG_IP_NF_TARGET_CLUSTERIP
Date:   Thu,  3 Aug 2023 15:18:16 -0400
Message-ID: <20230803191821.36793-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
In-Reply-To: <20230803191821.36793-1-twoerner@gmail.com>
References: <20230803191821.36793-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CONFIG_IP_NF_TARGET_CLUSTERIP as it was removed in commit 9db5d918e2c0
("netfilter: ip_tables: remove clusterip target").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 arch/arm/configs/keystone_defconfig        | 1 -
 arch/arm/configs/omap2plus_defconfig       | 1 -
 arch/loongarch/configs/loongson3_defconfig | 1 -
 arch/mips/configs/ip22_defconfig           | 1 -
 arch/mips/configs/malta_defconfig          | 1 -
 arch/mips/configs/malta_kvm_defconfig      | 1 -
 arch/mips/configs/maltaup_xpa_defconfig    | 1 -
 arch/mips/configs/rm200_defconfig          | 1 -
 arch/powerpc/configs/ppc6xx_defconfig      | 1 -
 9 files changed, 9 deletions(-)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 1cb145633a91..61179b75cf1f 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -98,7 +98,6 @@ CONFIG_IP_NF_MATCH_TTL=y
 CONFIG_IP_NF_FILTER=y
 CONFIG_IP_NF_TARGET_REJECT=y
 CONFIG_IP_NF_MANGLE=y
-CONFIG_IP_NF_TARGET_CLUSTERIP=y
 CONFIG_IP_NF_TARGET_ECN=y
 CONFIG_IP_NF_TARGET_TTL=y
 CONFIG_IP_NF_RAW=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a87d7d4001b9..047b625e677f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -190,7 +190,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index d64849b4cba1..04665c517c74 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -227,7 +227,6 @@ CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_NETMAP=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 44821f497261..dc49b09d492b 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -127,7 +127,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 743209047792..ae1a7793e810 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -127,7 +127,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index dd2b9c181f32..c07e30f63d8b 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -131,7 +131,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 97c2d7f530b3..0a5701020d3f 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -128,7 +128,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_defconfig
index e0e312dd968a..5c5e2186210c 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -90,7 +90,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 1034aeabdd6c..eaf3273372a9 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -183,7 +183,6 @@ CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_TARGET_ECN=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
-- 
2.41.0.327.gaa9166bcc0ba

