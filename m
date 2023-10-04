Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047CA7B83C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjJDPix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjJDPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:38:52 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75254BF;
        Wed,  4 Oct 2023 08:38:49 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af609c3e74so1499762b6e.2;
        Wed, 04 Oct 2023 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696433929; x=1697038729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvpIgA1NrzZoExz057WGLdJuiKTT6FN12MIO7ifzbic=;
        b=aMVs+eg9yhgQfEhjsdSIuB3/cRfh5ZEBmp0vcDsTesNp6KKAmsfgwi3wO9414s5/lm
         lGGSSqDbt8D9HIxLVE+2Or923wwuE5LiZ8X4DU1fZNWq+LWVc2ZyEsP+8i/hZGlWUfT1
         MN4stLQedYdLBuQvyNqmG6qr1VD1sFlS6oUkJoPWgBeZZd+WAGLa20CJjy8MMWb8oOr2
         ck8trxyIq2ZLZ8TwLD2N4qX2SKJf5y88oa/Q/DPmohyyII/4sG6uiBt3jd5vaR0wpLD7
         zNfnJprEeJH2bRMq09dffNgG9IFWBC/IPbGDCpeLdfvQAl10pgWP7fQaMKq2Tzh7a69D
         hVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696433929; x=1697038729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvpIgA1NrzZoExz057WGLdJuiKTT6FN12MIO7ifzbic=;
        b=aHULSexLSizxn1f9J3nCnoXCerG0Pu+TWiYfq2A2s2ClbjeP/wjN40sM4zIZ0JlLQ3
         f99CDJoWxF7O27tNRHz2BsJXrrdxQgRQlrfsZRTLMdFk1DPx3AWwqwgktYrpkBe6uTnA
         D4SZ4DgHwwLtsN2qILzHBXW6fr2ZKXdFxk6XNTpSPeOHCotnWusTGc1PHy2UwrHIUkHk
         RLs9K3VjUKqoDjIpeioVWeR6zyShgDV3qhqKaEdmhp8OCa7vEC+UuXGUcI9sroKdZSEM
         UZQOw4Uq77LXIckImqCfh49ZDaaeP0sdHV3RZF7cTBON7EfYMeE+tXfjkw8aW/bBPXD+
         XX0A==
X-Gm-Message-State: AOJu0Yz1McMiQ/sGHPK3DcjkxEqYJCuyfWP19HmQtyevq1qQp4xp1wpH
        zU7iG/jaJLDsmO9vfx5EehQ=
X-Google-Smtp-Source: AGHT+IF6NBfKh7H6lOBUPb8/5Av2JxoQiA0M+JJQ1P26d/Dn8ttnK9MCbFGsUzJJC5LJ6rSsak9IuA==
X-Received: by 2002:a05:6808:1829:b0:3ab:84f0:b49d with SMTP id bh41-20020a056808182900b003ab84f0b49dmr3646541oib.3.1696433928750;
        Wed, 04 Oct 2023 08:38:48 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id b24-20020aca1b18000000b003ae24b38f99sm541000oib.2.2023.10.04.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:38:48 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 01/10] riscv: Add SOPHGO SOC family Kconfig support
Date:   Wed,  4 Oct 2023 23:38:39 +0800
Message-Id: <46e7460668bcd88f35fbcc3cc55a96d1fd2a1fea.1696433229.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696433229.git.unicorn_wang@outlook.com>
References: <cover.1696433229.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
cores.

Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/Kconfig.socs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 6833d01e2e70..d4df7b5d0f16 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -22,6 +22,11 @@ config SOC_SIFIVE
 	help
 	  This enables support for SiFive SoC platform hardware.
 
+config ARCH_SOPHGO
+	bool "Sophgo SoCs"
+	help
+	  This enables support for Sophgo SoC platform hardware.
+
 config ARCH_STARFIVE
 	def_bool SOC_STARFIVE
 
-- 
2.25.1

