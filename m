Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496907F5308
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbjKVWMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjKVWMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:12:41 -0500
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618C410C;
        Wed, 22 Nov 2023 14:12:37 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35aa6107e9fso996535ab.0;
        Wed, 22 Nov 2023 14:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691156; x=1701295956;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sK7kv4eKhyN2VRY462hcU4dvihYdA9xvtn9OEHW15Ho=;
        b=LROf73TQKDRVlZt9L8bOefE2MsSRWep4zvW0aP6cKWM4lFParlzs/yTfeyu8kfMhlt
         le7cZ2dv3ixopMniF5JpfRvJvQXzJkLU7fhbS2ktld1JydqVpMXnvIEqjBJHM7Qem59y
         M4mIemUyHV4fzBAdMMjQtvQTbEN9kx3laZjYUDmXvCpWLZEaKp+F+kveNLv7YbSqTCGS
         dO+Lr5TKMr41q9sWnD/LRbX3Hmoz8EiuoDDoINpEpoJWITib+csl5/jfYzyOt/FnajxU
         8evXegFhWnvzMamqX4v7fMEW627Y3yBJKFk9gZGloz93KCZNbwAx29kl9ECtBgfQMC9q
         6rkQ==
X-Gm-Message-State: AOJu0Yx6McJT3Hrtdxf/HFYEnV+bewo3YQkcuKqLvyRDGFYU8jKk2yj2
        DOEcVOxue0b9MZwdWBAM2g==
X-Google-Smtp-Source: AGHT+IFYn0a0pfyS8tB9352GHm+FwUQVdn+U2e30V+Foljp37QPIyDstNnI1NzA0G1xwCDRADRCyWg==
X-Received: by 2002:a92:c685:0:b0:358:104:679d with SMTP id o5-20020a92c685000000b003580104679dmr4053847ilg.28.1700691156570;
        Wed, 22 Nov 2023 14:12:36 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y36-20020a029527000000b004665e39708esm88692jah.147.2023.11.22.14.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:12:35 -0800 (PST)
Received: (nullmailer pid 2753833 invoked by uid 1000);
        Wed, 22 Nov 2023 22:12:33 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/4] kbuild: Per arch/platform dtc warning levels
Date:   Wed, 22 Nov 2023 15:12:31 -0700
Message-Id: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM98XmUC/x3MQQqAIBBA0avIrBNyBLGuEi1ER5uNhUYF4d2Tl
 m/x/wuVClOFWbxQ6OLKe+7AQYDfXE4kOXQDjqiVQpTh9PJ2JXNOVU7Gxmi1s4YC9OQoFPn5d8v
 a2gcKn3iHXgAAAA==
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

This series adds support to set the dtc extra warning level on a per 
arch or per platform (directory really) basis.

The first version of this was just a simple per directory override for 
Samsung platforms, but Conor asked to be able to do this for all of 
riscv.

For merging, either I can take the whole thing or the riscv and samsung 
patches can go via their normal trees. The added variable will have no 
effect until merged with patch 2.

v1:
 - https://lore.kernel.org/all/20231116211739.3228239-1-robh@kernel.org/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (4):
      kbuild: Move dtc graph_child_address warning to W=2
      kbuild: Allow arch/platform override of dtc warning level
      riscv: dts: Always enable extra W=1 warnings
      arm/arm64: dts: samsung: Always enable extra W=1 warnings

 arch/arm/boot/dts/samsung/Makefile  |  3 +++
 arch/arm64/boot/dts/exynos/Makefile |  3 +++
 arch/riscv/boot/dts/Makefile        |  3 +++
 scripts/Makefile.lib                | 16 +++++++++-------
 4 files changed, 18 insertions(+), 7 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231122-dtc-warnings-968ff83a86ed

Best regards,
-- 
Rob Herring <robh@kernel.org>

