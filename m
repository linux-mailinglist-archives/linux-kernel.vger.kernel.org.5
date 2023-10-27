Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6485E7D9D32
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345505AbjJ0PnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJ0PnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:43:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BAEC1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:43:06 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ca82f015e4so19285435ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698421386; x=1699026186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NUEyjjvZD3sZIgVAZcZlQ2UsD1JGHJJKuO7MaTqPDY=;
        b=lmqEV6ET13z2PsKvwqudYfcrD7hjZDGYvjf5RsS4Zq8zTGJZeaOC10BM4NmeM0PFlz
         fnq8FKyZPhE1WlsiuG6Y1zCrhKLTGREN8AL2w+EDiVc6Lskhl8DytD20ExJpWEwQ9WrW
         mEwKYbfHidkIrGccDVpEi6OnLxL2XDpiCfMfUqHdQxEQVfOVLDeP1WkQBiwVyyUcXiWd
         ZEEDJplfkHHjksAw9sS7IK5nL/R4+p7AeyGmZAKFznuhB8Xbi3N0+fRxDPaex3SNA/QY
         wq/r6pMDIujIMxggb4z6ZSo32emgSLEGqaLLtmNbj4jw7L2oL8c2Epr4QfOsZe3FbysC
         2oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421386; x=1699026186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NUEyjjvZD3sZIgVAZcZlQ2UsD1JGHJJKuO7MaTqPDY=;
        b=lbQKSBmB7Qv0ulKcxxVKlHnmpto5MyQYMVWhn0GK4QfLDQFmAlarmSxGorvPNzeadO
         +x2TYJXvqokhGs/SqzmCh9e7ohIE1i374XZCiYPhZPaoPA2t6wuLZa2zznqWW8H80x+y
         vi/wgrqmq7tPdC7gZyafyB2s/wDCrbW2RwJdJ0QVJ8+CBvtZSdQw/gcmoYzVtgmGoN7j
         les/YlBHV8uBwaqzJoUbx9heQJR31Sj8bPGKTgbnQolQUFKZ2Ex21j0+kslE9vFVOUDl
         +k3COIKyT8KYcsZ6Kr2gJP4NXp95ntm6fT/6enlCprbVQ/LHomp1PTBTl20geTC94IIT
         +q0A==
X-Gm-Message-State: AOJu0YzOM0Ma74IW5ggVb8GWhquIMuQAPXztHLqp+DM/D4UOzWzEjsuW
        Bq30hPFDze7kQsfMav/QSScsyw==
X-Google-Smtp-Source: AGHT+IEx/N0OUV5A9FXLided5UkCLjMqnc16wgrRBNTOukMY6YYFjgFSJXzCBeVlqx4V+2JX11pH3w==
X-Received: by 2002:a17:903:234d:b0:1c4:16f:cc3e with SMTP id c13-20020a170903234d00b001c4016fcc3emr2759246plh.35.1698421385688;
        Fri, 27 Oct 2023 08:43:05 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001b9e9edbf43sm1729246plh.171.2023.10.27.08.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:43:05 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Linux RISC-V AIA Preparatory Series
Date:   Fri, 27 Oct 2023 21:12:52 +0530
Message-Id: <20231027154254.355853-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first three patches of the v11 Linux RISC-V AIA series can be
merged independently hence sending these patches as an independent
perparatory series.
(Refer, https://www.spinics.net/lists/devicetree/msg643764.html)

These patches can also be found in the riscv_aia_prep_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Use imperative wording in PATCH1 commit description
 - Dropped PATCH3 since it is already merged by Thomas

Anup Patel (2):
  RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
  of: property: Add fw_devlink support for msi-parent

 arch/riscv/kernel/cpu.c | 11 ++++++-----
 drivers/of/property.c   |  2 ++
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.34.1

