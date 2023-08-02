Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77076CB85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjHBLOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHBLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:13:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199D41FED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690974837; x=1722510837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qJbAs5HMKRLq8pv1x3gsaXQhtOfOsBxY/cBd1OZrCpA=;
  b=NLWgSPuCLiKsGQQCPGi3rgJWJIpz/f1Ns82OgDABTPdTFT8jzxwgyU67
   aM8Gzx6OelliJerfSWPZGqBgRjtEG/sHFH5Bg3oxTZ1AN7iL4vhM3eHyM
   Yf1y4SQwgdyzT9WeXQOqju4+lR2e+MrAulp9trIVmN3RM53CL/MqrZN5Q
   HpWM31EyBQYa9mtEjbgIHWj74QubgQx9Y9VGj7coTU5CPpoxkXKLeBB/A
   5OsFSfkDbKm1srq4bnx28VjhjeG/FVOIcEPLbqR5fj1cmx+GqD7qjmWUC
   8ZtYeCtAIZtQh9nXiB1MoFczVBhczOQxyOkqVX6X16b1UfLps4t+6lphD
   g==;
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="223462614"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 04:13:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 04:13:46 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 04:13:43 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        "Petr Tesarik" <petrtesarik@huaweicloud.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFT 0/2] RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected regions
Date:   Wed, 2 Aug 2023 12:12:51 +0100
Message-ID: <20230802-purse-hydrant-6f44f77364b0@wendy>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=qJbAs5HMKRLq8pv1x3gsaXQhtOfOsBxY/cBd1OZrCpA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmnrIyUMh3FdPfWh8x8ZyRaH3s8U945pkIuYx5f08e6FpuA Iz86SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMJHcaYwMnxLuyxof779m9+tJD2vJh1 NJOx2WXa011v2xq8jUNPvZJkaGBy+LRfv+zHsVwsGzq/Jo1q+HrFeW2ERVKz/74O1y4LcYJwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

I was kinda sitting around hoping that someone who cared about
hibernation would decide to go and work on some patches that permitted
using it without having to use NONPORTABLE, but that has not yet
happened so here I am.

I've marked this RFT as I have not got a setup to test hibernation on a
system that suffers from the OpenSBI issue, nor have I used crash
kernels at all.

Thanks,
Conor.

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Atish Patra <atishp@rivosinc.com>
CC: Anup Patel <apatel@ventanamicro.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Alexandre Ghiti <alexghiti@rivosinc.com>
CC: Björn Töpel <bjorn@rivosinc.com>
CC: Song Shuai <suagrfillet@gmail.com>
CC: JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC: Petr Tesarik <petrtesarik@huaweicloud.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  RISC-V: handle missing "no-map" properties for OpenSBI's PMP protected
    regions
  Revert "RISC-V: mark hibernation as nonportable"

 arch/riscv/Kconfig           |  5 +----
 arch/riscv/include/asm/sbi.h |  5 +++++
 arch/riscv/kernel/sbi.c      | 42 +++++++++++++++++++++++++++++++++++-
 arch/riscv/mm/init.c         |  3 +++
 4 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.40.1

