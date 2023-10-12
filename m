Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799707C70B0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378910AbjJLOuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjJLOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:49:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45ABD6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:49:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDD7C433C8;
        Thu, 12 Oct 2023 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697122196;
        bh=WqvrIw3PkN3YYn1wVpzhO2s/Fo/gP7GkrtfWS3/rmZA=;
        h=From:To:Cc:Subject:Date:From;
        b=enA3mxvR1zssOjbMXwEkzY9UzGSeZWl8gFLi51c+AwxhAtznYQ+wxowCIkgqt5gCu
         SerfeCocbYsySI2epiFJ4mrEWZN5FY9S6ql3+YOJlO2P+YnDesvFUL0aIiELNvIhPW
         7/eh5/rZebfsGWqxsyNRvXSmvH8qPbT49rtiagODqPdOyuIaBxjt1f5jxLkbNsTXwv
         gXuzIkLSbHF7y1SThaLtR95hjW7xTIPdcQovCr8Iqx8zEY0FvjZZx3AHNzukqY20JJ
         xE/wAG61GALMnatOvFTjz+SvTEzRmJ+sABCXrE6y3VK97EWnpuM3eNNl0J6faSiyKl
         F2i/sBbGz49eA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] riscv: errata: thead: use riscv_nonstd_cache_ops for CMO
Date:   Thu, 12 Oct 2023 22:37:44 +0800
Message-Id: <20231012143746.454-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Hi Guo,

I didn't use wback_inv for wback as you suggested during v1 reviewing,
this can be left as future optimizations.

Thanks

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
2.40.1

