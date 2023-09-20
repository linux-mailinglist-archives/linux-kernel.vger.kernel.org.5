Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2A7A72D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjITGfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjITGfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:35:19 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F089D;
        Tue, 19 Sep 2023 23:35:14 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5733d431209so3974209eaf.0;
        Tue, 19 Sep 2023 23:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695191713; x=1695796513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJKym/P7NcQpPeyWI/De6RmfTQNyyp1oM7Xyf6Kr9tg=;
        b=OraYkHedPP7L9XxT2KXYJB4iWmcBjKLPobvTsi5AASjhp9deyqG+252NEWP+CyoP7d
         3Zg4M7zZA+oRMJqa+x9N3bQC7FeYD7OU+p3kAF2tkPpM/3KiZCSyxAM4le6owmipQ+on
         Q6O122KP8kbiC+iWGRx3ijGb4lo3fU0og9mxNUkBplPSMCM0EP6hyekkryP8S24DII/k
         8rBikHRZZInIKgiJncrN3dTrk57TrvGQsgYuQSI7xKAURHecKVjGUULE2KeLhHp2u5xe
         w1Tg1ON2svwnWThMuyd/hv6G+2shtMDQQLWMxcoVQp12T/6+gdRokJkXAI3xj7BQD283
         xFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695191713; x=1695796513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJKym/P7NcQpPeyWI/De6RmfTQNyyp1oM7Xyf6Kr9tg=;
        b=hn3+6Qquu7UOuXn1IckMxmqDPlWM3m1weHPv7ZMKRxkWsPsAMSPW9Dvtm56S6558Z2
         ZkZ396ZP3P5xI+iph2KpV3NlMN3hVRIbdBF9J19UHTLQ/vQGS16X7xj7oZOOR3DMeuWL
         u8DTJcYF4BtIG4rE3nO7b6Eu8Gd2K8OHdc+ewmu6c6M8hmaZyTyW1bY6ScLBh8RFC4I3
         BcF0vKV7PxkULmszm6eysePy/Yz08QTn85aXd+YrvxR6eL/d7/sT0QZVODu5f+uEW0kp
         wD9ByvrEAG1CKXo2BNfN8Q80FCkTvHi948RTb39Qv4pKAGu+ccJmf3xSB4BRmxMmpOzV
         ae7g==
X-Gm-Message-State: AOJu0Yw+LVhq8rV0O5PiaIf6ZOjPMneHQhwxoksnZq2G7FjP4bVSijsZ
        m2HzyEh4nJvVSL87ux4Qqto=
X-Google-Smtp-Source: AGHT+IFcCvZ7DH/DLj4tiOetrouvt4X4bFb6UmU1YoBl42O/swqeXpXlzf7XZf26OrcDRxE4zkol4Q==
X-Received: by 2002:a05:6870:fb8d:b0:1be:f46d:a26c with SMTP id kv13-20020a056870fb8d00b001bef46da26cmr1796917oab.27.1695191713449;
        Tue, 19 Sep 2023 23:35:13 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id ci11-20020a056871c48b00b001d53c57b55asm6746735oac.57.2023.09.19.23.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:35:13 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 01/11] riscv: Add SOPHGO SOC family Kconfig support
Date:   Wed, 20 Sep 2023 14:34:44 +0800
Message-Id: <2c6db3d2db0d27d4b2b8364e0c03be3da292101e.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
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

The first SoC in the SOPHGO series is SG2042, which contains 64 RISC-V
cores.

Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
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

