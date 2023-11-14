Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBFC7EB2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjKNOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjKNOqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:46:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD710D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:45:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C316C433C7;
        Tue, 14 Nov 2023 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699973158;
        bh=z1pm6buW7ZPrKt2TauADLrqPVq3fh/nOdfjF6mt+BNM=;
        h=From:To:Cc:Subject:Date:From;
        b=rVQqLCH9RYYQG1ODw4+cBHyWhY++NX4ltchJARQctk6OlmOtkOd3az2gsGOYxRSYP
         Up51X/vof2D1AhJHxsWYCgF8n6iIWYtHiVGw+VqA3mysv3bx0uoIaldLBsFCMPAgMA
         8Mn0GyRbJ4d6gdy8HQX8FayG+ERzSyuFtbfOOdokZnCFdM76cq3zTulshU8i285m2z
         2nn99hFfJ2wUTFhELpboyLoclS+0RMcnOd7Zm8I6jRAohKzFnPDThsXl18SDE2kSGL
         gfCjwKS4AgRzvaFTS+X9x/k9k5ygbuBamr7ulspl74jBmszEoJMltbF+YT1Gv4gnhx
         7KSqrOPTm6tdA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/2] riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
Date:   Tue, 14 Nov 2023 22:33:36 +0800
Message-Id: <20231114143338.2406-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we use alternative mechanism to dynamically patch
the CMO operations for THEAD C906/C910 during boot for performance
reason. But as pointed out by Arnd, "there is already a significant
cost in accessing the invalidated cache lines afterwards, which is
likely going to be much higher than the cost of an indirect branch".
And indeed, there's no performance difference with GMAC and EMMC per
my test on Sipeed Lichee Pi 4A board.

Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
the alternative code, and to acchieve Arnd's goal -- "I think
moving the THEAD ops at the same level as all nonstandard operations
makes sense, but I'd still leave CMO as an explicit fast path that
avoids the indirect branch. This seems like the right thing to do both
for readability and for platforms on which the indirect branch has a
noticeable overhead."

To make bisect easy, I use two patches here: patch1 does the conversion
which just mimics current CMO behavior via. riscv_nonstd_cache_ops, I
assume no functionalities changes. patch2 uses T-HEAD PA based CMO
instructions so that we don't need to covert PA to VA.

since v4:
  - rebase on 6.7rc1

since v3:
  - collect Reviewed-by tag

since v2:
  - collect Reviewed-by tag (but missed them in fact)
  - fix typo

since v1:
  - collect Tested-by tag
  - add patch2 to use T-HEAD PA based CMO instructions.

Jisheng Zhang (2):
  riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
  riscv: errata: thead: use pa based instructions for CMO

 arch/riscv/Kconfig.errata            |  1 +
 arch/riscv/errata/thead/errata.c     | 69 +++++++++++++++++++++++++++-
 arch/riscv/include/asm/errata_list.h | 50 +++-----------------
 3 files changed, 74 insertions(+), 46 deletions(-)

-- 
2.40.0

