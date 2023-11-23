Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD407F6193
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbjKWOeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345842AbjKWOek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:34:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E994DD4F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:34:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28243C433C7;
        Thu, 23 Nov 2023 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700750086;
        bh=2IIUNX5jKc+M5fhmvdUI02XyPwbOQktGxlJKInijJuI=;
        h=From:To:Cc:Subject:Date:From;
        b=aQdNthO7a7rwwou48QT1q4YfT21UDqnVCR72Ffa/4PegDCV/DHufmlm8pB2rgHGcQ
         irZcpvIsEfqSTOA8w4pLrfmwRT0XLq/LGbDuCAIPYpAFa/w2BSxxParN54rx0nvxza
         D6rfqht0Ybzb0VVUIc0xi2ZlfaDgxMtJevufLHpl5n/EtZkLuvX6lXlWm2Ad+TUUqw
         PXvMSs0H4Z6TJ3RFaRld/dVlG79CNCLwFWm7zNtEyI8PFJCGyO8dzKLe01YxhMEnnv
         CwCnudU7SWBDfreKmWIX1X5aUIrJOiOeM9lTXnKyF6fNdEXdnBnMDjAq1qP4ynCr8D
         DKdrUvQygdkYg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Select ARCH_WANTS_NO_INSTR
Date:   Thu, 23 Nov 2023 22:22:23 +0800
Message-Id: <20231123142223.1787-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in the help of ARCH_WANTS_NO_INSTR entry in arch/Kconfig:
"An architecture should select this if the noinstr macro is being used on
functions to denote that the toolchain should avoid instrumenting such
functions and is required for correctness."

Select ARCH_WANTS_NO_INSTR for correctness.

PS: The reason we didn't find any issue so far is that the
CC_HAS_NO_PROFILE_FN_ATTR is true.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e4834fa76417..433ec617703e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -60,6 +60,7 @@ config RISCV
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
+	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
-- 
2.42.0

