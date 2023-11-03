Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE137E060E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjKCQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344745AbjKCQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:02:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37180D4E;
        Fri,  3 Nov 2023 09:02:13 -0700 (PDT)
X-QQ-mid: bizesmtp66t1699027320t0x8xgof
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:01:57 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: WQH7Uj+YMzXZTIeeYrzzH5itva0gXKImwAhNhNH+6I4DrfveqC5LRL/AcrFVZ
        2/7bONsuYtIn2ySjQU5hL5gWFOT7EvhlXQ1iFCFG8OaKZP82pUKHeAwChH+M65VreM8t5le
        MEaIGsQTivG4RvqDkHbOYJyCINDKGWbhCKa0dUgjtXcRjNQmYo+pBt7KJc23OgX11rPo9HH
        eolIdA7eZrnIQZKidwNzLUodbR1P5fT1YDTe/GJ96w1sqVpiiORBTxHvJJR8fCReTgImbhn
        xk8Hctv3kJsMKpvxmjJqlVVP2vs4VDq6gBW71Z2pzucXzcbSYEcpsDNDwo0ITDvRO3EglyR
        gZFh+VYSI8gOs/YSPsMhwdqkvgrOUqcnzKKQlenAv7mO2o1OXg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8381555887930633905
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 09/14] DCE/DSE: inhibit .size directive for SHF_GROUP
Date:   Sat,  4 Nov 2023 00:01:55 +0800
Message-Id: <7807078d4612beaa3f450df9f3f3cf70b2bccb4a.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699025537.git.tanyuan@tinylab.org>
References: <cover.1699025537.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.size directive fails in some functions with SHF_GROUP, this is not
really required for normal building, inhibit it to silence the compiling
failures with SHF_GROUP.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index a4e522b747cb..f67b6e8d2c45 100644
--- a/Makefile
+++ b/Makefile
@@ -936,6 +936,9 @@ endif
 # `rustc`'s `-Zfunction-sections` applies to data too (as of 1.59.0).
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
+ifdef CONFIG_SECTION_SHF_GROUP_SUPPORT
+KBUILD_CFLAGS_KERNEL += -finhibit-size-directive
+endif
 KBUILD_RUSTFLAGS_KERNEL += -Zfunction-sections=y
 LDFLAGS_vmlinux += --gc-sections
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION_DEBUG
-- 
2.34.1

