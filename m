Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC19977EDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347155AbjHPXYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347146AbjHPXXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:23:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8AE271E;
        Wed, 16 Aug 2023 16:23:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-318015ade49so6280203f8f.0;
        Wed, 16 Aug 2023 16:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692228224; x=1692833024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgdXOP4yR6ZnH/y1qGFKmHKWNqRrRuobjN/2x4b+FbA=;
        b=WEB4xO5LWij5oKfwGh1OEk4FXjhCGsMXw/ewx7R6a0QjvqDafEoSNlCkRtFivEPFen
         TLR8FfJ6EfvqoNSpjp+UlLgLKbHENMneStqXnyRRfQ/MX1+zGq+MIaqXmVITtO7AnLBB
         6wgS2VYD3PZxXGqdMPzVw5YO8XpveYZZYBUMicCNZRSpqU9+0avSQ4edpW8fzJySwGps
         D46siM0ztdasxWVy1ROb7n/oytocnGykiUrW+1zzTSoVokhEMB+/RKb+ZL6R9bmJ2DLX
         9zVRSB0ExIhEmvCeXAk9SooDtsu9BtzefewFaDXf/8agZccM2E5kxe+eINljjw/4ikJl
         CiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692228224; x=1692833024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgdXOP4yR6ZnH/y1qGFKmHKWNqRrRuobjN/2x4b+FbA=;
        b=bI0R5Djic3DFLmie3W+jkE8HWULmR31RWHaydHBnckgaZpuUb9dJ1YzOX+CWCg2CRq
         o31bVG8MCFE+gH0mztRlRpyxSt3ATIwWO9UK3e5mhfR3m6eLDTdGWVxLmyB/+4+tkf9V
         fRsAfMb7b00vzAHKfI9xxd9ZvyFBNrgTh9NmKJFSeyvbx7LeuVIW2z8UG3sIVWtqpW7F
         T0Mmay/8OsxAhHWb5avmWGq6e2eAT+PqN5w3Fc3ih+5oPB5ejkk4Er0SCaIH4lY60oVc
         L8sOs77ir2FeSeyfKNBWUfYCLjn1vKYyOB7HxQZb3hXM9M+7pyc//C6f8xv3jywU6GDS
         lI8Q==
X-Gm-Message-State: AOJu0YzcObQawDMpUTKqSY6+9VlsvOXdP5pfNsaxKyBuTKgUmCV2pc9R
        cHCv36IXV3vAeORsvUgF3gg=
X-Google-Smtp-Source: AGHT+IEOsLQXTtu9Ww1G9TMwF+CJtQ5zAjl4dANCkwAMo4lC/cxbVGxVfQfn4ev6QwpY38US7Fbrmg==
X-Received: by 2002:adf:db48:0:b0:317:74ce:3e27 with SMTP id f8-20020adfdb48000000b0031774ce3e27mr2422087wrj.67.1692228223853;
        Wed, 16 Aug 2023 16:23:43 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:aeb8:832b:ebc0:1bbf])
        by smtp.gmail.com with ESMTPSA id q4-20020adff944000000b003143c9beeaesm22752617wrr.44.2023.08.16.16.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:23:42 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/3] riscv: dma-mapping: unify support for cache flushes
Date:   Thu, 17 Aug 2023 00:23:33 +0100
Message-Id: <20230816232336.164413-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch series is a subset from Arnd's original series [0]. Ive just
picked up the bits required for RISC-V unification of cache flushing.
Remaining patches from the series [0] will be taken care by Arnd soon.

Cheers,
Prabhakar

v2->v3
* Got rid of dma-sync.h and included the changes directly into dma-noncoherent.c

v1->v2
* Dropped others archs
* Included RB and ACKs
* Fixed checkpatch issues

V1:
[0] https://patchwork.kernel.org/project/linux-riscv/cover/20230327121317.4081816-1-arnd@kernel.org/

Arnd Bergmann (2):
  riscv: dma-mapping: only invalidate after DMA, not flush
  riscv: dma-mapping: skip invalidation before bidirectional DMA

Lad Prabhakar (1):
  riscv: dma-mapping: switch over to generic implementation

 arch/riscv/mm/dma-noncoherent.c | 60 ++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 9 deletions(-)

-- 
2.34.1

