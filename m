Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2F176CB88
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjHBLON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjHBLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:14:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9382114
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690974841; x=1722510841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+upP9bsbQbhCuHLUsyHfsie8k02JT+wkJ/OXUvH+dCU=;
  b=gcOWHv7+ygYl28PCWEJl3c7atCF1zN8t/9qoXSlyb3Fc7ZjWja+YgNep
   2Uu1b5qs7/uDGWOCPdheXkpyJyDejplXQ57u6/FBmi+SIl6HOxnXs757n
   C1c2om1fBepswrkKI2oAicypR9N+41rgZLlU5O2T2NAXgpz8Gf2M0r/7W
   4HESq+NEJuB7pS0wlR1+lBsQGeHFErc5+fWLrupA5ruNrpc8v4veYo9Sr
   1p+NqwGBrScv5MRZQrqzk0/HkCCrzfeci8g8obakulJOBwoITN2cfwmJB
   bwEK7rZqt4K7y/r1dprFL+G4Tuo7XPvv5WjRpL/FaFxUs36q0rOZy/qEo
   A==;
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="223462648"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 04:14:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 04:13:53 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 04:13:50 -0700
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
Subject: [RFT 2/2] Revert "RISC-V: mark hibernation as nonportable"
Date:   Wed, 2 Aug 2023 12:12:53 +0100
Message-ID: <20230802-chef-throng-d9de8b672a49@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802-purse-hydrant-6f44f77364b0@wendy>
References: <20230802-purse-hydrant-6f44f77364b0@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=+upP9bsbQbhCuHLUsyHfsie8k02JT+wkJ/OXUvH+dCU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmnrIwVuNwC93y7J2XVkK/6/9F8O97lc2RvBM9Z2Hh3YuHx rK2OHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI5ktGhomZ9d+dS0QK2WJO3ZFgdt WqPFWSUuq47fa0t5zly3yCaxn+KR3+ObNs0/lPHaUnqg1CpG8tu+WnzOdkF1E/j89m+dYj/AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Revert commit ed309ce52218 ("RISC-V: mark hibernation as nonportable")
as the kernel now has a way to handle the "no-map"-less, PMP protected,
reserved memory nodes for the affected versions of OpenSBI.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4c07b9189c86..47aef21073f9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -866,11 +866,8 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
-# Hibernation is only possible on systems where the SBI implementation has
-# marked its reserved memory as not accessible from, or does not run
-# from the same memory as, Linux
 config ARCH_HIBERNATION_POSSIBLE
-	def_bool NONPORTABLE
+	def_bool y
 
 config ARCH_HIBERNATION_HEADER
 	def_bool HIBERNATION
-- 
2.40.1

