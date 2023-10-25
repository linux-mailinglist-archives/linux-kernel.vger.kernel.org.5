Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E287D6EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjJYO2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjJYO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:28:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E47136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so4662838b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698244114; x=1698848914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qEwjrIZXUzvnboalMTbBIVYhD3jIm+zf9phzakfFM5w=;
        b=aNIVV7LVubhMjpbKp2s1zpvHXSliz1YeOBJMCTvRE43ny5WEeJ61HZbq4PXFNFmsSy
         VWlmLGeoVSgrzYMRMWO62IEzCBtvYldphJid8Fus+YNsqJ5z603lytzZcY/oEC7FVnyA
         aY3oQuJJQ5Ee8zJT5vnFtw/MRGGesN8zlFAyeNIth1Wq0ar8l1qneElLpekYl++zBKPg
         WuvyxwFdXIj3ildQH48GuT2TCEl3KN5HwDGP0KIVuIyU6iQe1XtvySPYd3TJKG81ao4u
         8kXNBFr95yVM8nrR5VXVpmKElTX3RqGn1A2BCSPyRqxpkge+8hz+VC83K7/zrHiVEOBH
         vrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244114; x=1698848914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEwjrIZXUzvnboalMTbBIVYhD3jIm+zf9phzakfFM5w=;
        b=DJVHGxlabDfVAknNjHInZ2yHs5e4Bbv6n7JjTR8+wC8UyTmAYTY2FPF3Nn8J8qzYL1
         JHBOd1UOPlIYNzJGk7P3AkBLwm1w0A3yKQLO3Mv5fP0rD2yFs+DBQ8cMUeWKjQu7zGS8
         Y4MSlT31N1A3RIBRNQrtz6r9ephGP8YpmeWZYLo1OC8gLcr8/KvHVNOqFcW+rk4Pjp47
         Q7hZr3VzBHg4HPpp6eVuC0U4lQGEDMvppdZvJdk1/+8MaiPTkrxmKaqDeGIDdKVQ8JEn
         lzfv1Aq7y6WYXkGHxeR8RMbVlw+oqtRZ3YrCab+1twhVKoknqiwo5Xc53LPPULzBTjjd
         lwTw==
X-Gm-Message-State: AOJu0YwAYYFU7ARg3cLUF5Up1cdQXYdnI9ahTRsELAUF9N2n6d4RaYJ1
        Zwi0EMrqfa/YW0e8CRdqkROisw==
X-Google-Smtp-Source: AGHT+IGqHSfZyCCoNbFPfpUZAAjL1u1VHnmwQd86TL9A12x8J8QFDFGPslh4kvKAvGwIbEI0Ix5ZpQ==
X-Received: by 2002:a05:6a00:1a4f:b0:690:3b59:cc7b with SMTP id h15-20020a056a001a4f00b006903b59cc7bmr13717214pfv.32.1698244114269;
        Wed, 25 Oct 2023 07:28:34 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id g2-20020aa796a2000000b0068ff6d21563sm9817411pfk.148.2023.10.25.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:28:33 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/3] Linux RISC-V AIA Preparatory Series
Date:   Wed, 25 Oct 2023 19:58:17 +0530
Message-Id: <20231025142820.390238-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first three patches of the v11 Linux RISC-V AIA series can be
merged independently hence sending these patches as an independent
perparatory series.
(Refer, https://www.spinics.net/lists/devicetree/msg643764.html)

These patches can also be found in the riscv_aia_prep_v1 branch at:
https://github.com/avpatel/linux.git

Anup Patel (3):
  RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
  of: property: Add fw_devlink support for msi-parent
  irqchip/sifive-plic: Fix syscore registration for multi-socket systems

 arch/riscv/kernel/cpu.c           | 11 ++++++-----
 drivers/irqchip/irq-sifive-plic.c |  7 ++++---
 drivers/of/property.c             |  2 ++
 3 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.34.1

