Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11B7F31B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjKUO4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKUO4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:56:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F085A98
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:56:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598F7C433C8;
        Tue, 21 Nov 2023 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700578572;
        bh=goyE925j68b1sxQIGmM2p3n/Pv4DT5HZh2Zf6o8Dplk=;
        h=From:To:Cc:Subject:Date:From;
        b=Vb3OCJ/bzT++FdX+q066N3VO4wDu8sqSY6geuAKT9GNoRGC9D1r6P1G1TcZAA/I+f
         dr0Nv4SXyTP0TEH7MQWZjh3O8c8i3WguLumLdc2fnIHHKub12hMuywxBioal0TdnNg
         Ws1NOMoabop79fPpC4iO4jbBvpqDqz/n/DcR2366tYfx1M+7MIAJHgHBy9rT9nUJwJ
         GtUirmde6czIQGiAZ+n8cyktLgVq6A3bdVYp7fqhfjgIz8YMUnsBuDJEFgN9uUksxB
         BAW94RhNifuLk1BB3/hOw+gCG+0VZdKeWQvT8k712EKVWS/F7dTu8JsYlUppPuj0y1
         FUKn9URfOxx/w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: select ARCH_HAS_FAST_MULTIPLIER
Date:   Tue, 21 Nov 2023 22:43:40 +0800
Message-Id: <20231121144340.3492-1-jszhang@kernel.org>
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

Currently, riscv linux requires at least IMA, so all platforms have a
multiplier. And I assume the 'mul' efficiency is comparable or better
than a sequence of five or so register-dependent arithmetic
instructions. Select ARCH_HAS_FAST_MULTIPLIER to get slightly nicer
codegen. Refer to commit f9b4192923fa ("[PATCH] bitops: hweight()
speedup") for more details.

In a simple benchmark test calling hweight64() in a loop, it got:
about 14% preformance improvement on JH7110, tested on Milkv Mars.

about 23% performance improvement on TH1520 and SG2042, tested on
Sipeed LPI4A and SG2042 platform.

a slight performance drop on CV1800B, tested on milkv duo. Among all
riscv platforms in my hands, this is the only one which sees a slight
performance drop. It means the 'mul' isn't quick enough. However, the
situation exists on x86 too, for example, P4 doesn't have fast
integer multiplies as said in the above commit, x86 also selects
ARCH_HAS_FAST_MULTIPLIER. So let's select ARCH_HAS_FAST_MULTIPLIER
which can benefit almost riscv platforms.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..e4834fa76417 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,7 @@ config RISCV
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
-- 
2.42.0

