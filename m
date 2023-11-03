Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CD7E0605
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbjKCQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjKCQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:01:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D615191;
        Fri,  3 Nov 2023 09:01:08 -0700 (PDT)
X-QQ-mid: bizesmtp90t1699027252t9kbwhgd
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:00:49 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: CR3LFp2JE4mhkRVIWx93LBUmhAe9K8E83iOUA42iJlD/ysMdwtv2Jg9+XFACH
        SQSIO5fAX3mLZ19bQUyf6+J2iJt5DAjSeZV8qd5TE7eRt5KTZPkIZ6MWDw6Stc1eobVw93T
        gJ4ltxRG2FXmdNS7NmXkj3WgOs5v2VPGM4tvPuFna/ww4QE5CexKC+EWjDMgCqFU4oFIurf
        04A2MWJtSQmGlk7Xbi7gY2JlW9ZYdjss3fPnCMib7PN/ZLq8esLub33NFPpqVdkxYy765bT
        dmhJ3S1WoVATpjTbe80GKxgF5cqoLGZ4QoMY5o2aAaRmVLmqoAbUkrLgQcCrLUQan+LETLa
        Kb+pGigu2qXH7uopncaqVHXmBHosfv5VsdzaPOv/VMUfjDEgt2sahS/z5ppiA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3924603848668096724
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 07/14] DCE/DSE: add HAVE_SECTION_NO_KEEP_SUPPORT option
Date:   Sat,  4 Nov 2023 00:00:47 +0800
Message-Id: <494854689a6f6f91da151ae4bd9a7a6132092271.1699025537.git.tanyuan@tinylab.org>
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

Once there's SECTION_SHF_LINK_ORDER_SUPPORT or
SECTION_SHF_GROUP_SUPPORT, there won't be any orphan section and won't
need KEEP() anymore.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 4296c97cfc84..9834dbb0ddae 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1462,6 +1462,11 @@ config HAVE_TRIM_UNUSED_SYSCALLS
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	default n
 
+config HAVE_SECTION_NO_KEEP_SUPPORT
+	bool
+	depends on HAVE_SECTION_SHF_LINK_ORDER_SUPPORT || HAVE_SECTION_SHF_GROUP_SUPPORT
+	default y
+
 config HAVE_SECTION_SHF_LINK_ORDER_SUPPORT
 	bool
 	depends on AS_IS_GNU && AS_VERSION >= 23500
-- 
2.34.1

