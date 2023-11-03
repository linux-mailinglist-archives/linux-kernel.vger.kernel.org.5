Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209867E0601
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjKCQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjKCQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:00:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF4191;
        Fri,  3 Nov 2023 09:00:49 -0700 (PDT)
X-QQ-mid: bizesmtp64t1699027236t5ijv5ky
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:00:33 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: rZJGTgY0+YOXiDRtSv5jrBH+Ok8Gp19fhcj4KioUSMpuqQklo5ZZQc/JPJ8NP
        EtrPZ1izysnRKGJpccJps5x7PACRlaGOgqrbhQsoXPYIL0wptOzTr59TlmxVaci9hDwmWW3
        p2AG5vAakwXzlGOvAVJVj+6geI4kiy35fnAl8Hxgjur7eOzsHK3fr/I5H8UeJZfgM66PbGn
        yeYjqTHLgymXpyzEuYFaXxOuqvZ/uCI5ZmMmOhTzMnqvs5W/vD7crDXrQQkhlJGtCD99gYw
        TlsX5JstKOh466iu7/6cBHsznx3S3ZdcSo34kwI/IMvXXT09A715opfHEEVuc05iI+uAU/L
        64Ij+YmTR0MwCKVFG9rPTnOMLXFsQg6LeXI01q9jVrDUx/zPUETEnoZ/zd554YXkD/vc5qy
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8259172485907225114
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 07/14] DCE/DSE: add HAVE_SECTION_NO_KEEP_SUPPORT option
Date:   Sat,  4 Nov 2023 00:00:31 +0800
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

