Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E27F8947
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjKYIeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjKYIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:34:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F288CDE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 00:34:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5559CC433C8;
        Sat, 25 Nov 2023 08:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700901247;
        bh=yNvTs5UAx1BPwJURTZLeQZMlvThqxFtraUOhYepUN5M=;
        h=From:To:Cc:Subject:Date:From;
        b=UjamK1+9ds2rJGs2WYR5sxyO4tcp6KWr2aF1r20jgEr59ZYHAzGTRPAC1pWeqHUq6
         eqBJmXhEmwS2V3z+4K3ONEYLkC4ijNo6z/9Q/4otmf4kCPE5zsbnP1BLekrGVYeATV
         Vn9M79nY6o8gIbBPet/QBUnOOsst56flsG8QUNklHC6IH9voZfb9qn8gUzAPyBzS4Q
         M9e8Ghy3DF6Ne0z3+irHpZ9fsn4oz3LprYK6O6eE8DwXqlmKd4DOMvtTx+j9SiBDIZ
         dmwC+I9tGn1ZU8uNTnXHkkJ4dTizhS45yLz+8s+NDE85jqq56MK/xQamaRSp8dDGgT
         yDJrnB07prqUQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv: enable lockless lockref implementation
Date:   Sat, 25 Nov 2023 16:21:42 +0800
Message-Id: <20231125082144.311-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series selects ARCH_USE_CMPXCHG_LOCKREF to enable the
cmpxchg-based lockless lockref implementation for riscv. Then,
implement arch_cmpxchg64_{relaxed|acquire|release}.

After patch1:
Using Linus' test case[1] on TH1520 platform, I see a 11.2% improvement.
On JH7110 platform, I see 12.0% improvement.

After patch2:
on both TH1520 and JH7110 platforms, I didn't see obvious
performance improvement with Linus' test case [1]. IMHO, this may
be related with the fence and lr.d/sc.d hw implementations. In theory,
lr/sc without fence could give performance improvement over lr/sc plus
fence, so add the code here to leave performance improvement room on
newer HW platforms.

Link: http://marc.info/?l=linux-fsdevel&m=137782380714721&w=4 [1]

Jisheng Zhang (2):
  riscv: select ARCH_USE_CMPXCHG_LOCKREF
  riscv: cmpxchg: implement arch_cmpxchg64_{relaxed|acquire|release}

 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/cmpxchg.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.42.0

