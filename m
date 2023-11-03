Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869C17E062B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbjKCQEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344453AbjKCQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:04:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9041BC;
        Fri,  3 Nov 2023 09:04:31 -0700 (PDT)
X-QQ-mid: bizesmtp78t1699027456tnrc347s
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:04:13 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: mot7IUESEd/O3Ye3RvUm0u0JfDP8ilGw6DJ+bg2ku9yW02xqru4czyWnDR4JC
        EQdnw8q1TsviTHclgFaJRSxxEJSFDKoZfMUzfWIOoWQW5FI9+0rOhbgL2xFjAIQLOk/WiNb
        Ze0d8K6zH/AYLaKpQIAtAZG4jS7M72shuT9euUEJaCCA/CcImxoiQrXkdoAg+grDS7lI/xU
        DnpaZjUvJet9LH1I1tXUT2k+8t0nGwPGjmBS7XYMcEABQ3GlVXZx8/iDCsrMmgIy1Mf4YxT
        25ig0IbUsLLwVXn/38HbQVCzou/49TJyeRhZOCpzf0rKiNfEg1KrsIRdd33Cz5XTnn7Ws/O
        zQ60yzEUchZNK3VB1+XcP3Ha7KKHjs9ib0py4O2
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6096022325544553150
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 13/14] DCE/DSE: add SECTION_NO_KEEP_SUPPORT option
Date:   Sat,  4 Nov 2023 00:04:10 +0800
Message-Id: <4ad1b8cb7cd54c57e74e877235f64b5be5bbbe8f.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699025537.git.tanyuan@tinylab.org>
References: <cover.1699025537.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is able to drop the brute KEEP() keyword for some sections, when the
sections are able to link or group together with one of the used
sections.

Some syscalls are actually orphan sections.
SECTION_SHF_LINK_ORDER_SUPPORT or SECTION_SHF_GROUP_SUPPORT creates
references for these sections, eliminating the need for the KEEP()
directive.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 include/asm-generic/vmlinux.lds.h | 24 ++++++++++++++++++------
 init/Kconfig                      |  9 +++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ea8170e11ab1..f10afc42a1ac 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -201,18 +201,30 @@
 # endif
 #endif
 
-#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#ifdef CONFIG_SECTION_NO_KEEP_SUPPORT
+#define NO_KEEP(sec) sec
+#else
+#define NO_KEEP(sec) KEEP(sec)
+#endif
+
+#define _BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _KEEP_, ...)	\
 	_BEGIN_##_label_ = .;						\
-	KEEP(*(BSEC_MAIN(_sec_)))					\
+	_KEEP_(*(BSEC_MAIN(_sec_)))					\
 	_END_##_label_ = .;
 
-#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)	\
+#define BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, ...)		\
+	_BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, ##__VA_ARGS__, KEEP)
+
+#define _BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _KEEP_, ...)\
 	_label_##_BEGIN_ = .;						\
-	KEEP(*(BSEC_MAIN(_sec_)))					\
+	_KEEP_(*(BSEC_MAIN(_sec_)))					\
 	_label_##_END_ = .;
 
-#define BOUNDED_SECTION_BY(_sec_, _label_)				\
-	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
+#define BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, ...)		\
+	_BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, ##__VA_ARGS__, KEEP)
+
+#define BOUNDED_SECTION_BY(_sec_, _label_, ...)				\
+	_BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop, ##__VA_ARGS__, KEEP)
 
 #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
 
diff --git a/init/Kconfig b/init/Kconfig
index 9599d2de44e8..aeb859e410b2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1467,6 +1467,13 @@ config HAVE_SECTION_NO_KEEP_SUPPORT
 	depends on HAVE_SECTION_SHF_LINK_ORDER_SUPPORT || HAVE_SECTION_SHF_GROUP_SUPPORT
 	default y
 
+config SECTION_NO_KEEP_SUPPORT
+	bool
+	depends on SECTION_SHF_LINK_ORDER_SUPPORT || SECTION_SHF_GROUP_SUPPORT
+	default y
+	help
+	  This option allows some sections unkept so they can be GC
+
 config HAVE_SECTION_SHF_LINK_ORDER_SUPPORT
 	bool
 	depends on AS_IS_GNU && AS_VERSION >= 23500
@@ -1765,6 +1772,7 @@ config RESTRICTED_TRIM_UNUSED_SYSCALLS
 config SECTION_SHF_LINK_ORDER_SUPPORT
 	bool "Using SHF_LINK_ORDER attribute (EXPERIMENTAL)" if EXPERT
 	depends on HAVE_SECTION_SHF_LINK_ORDER_SUPPORT
+	select SECTION_NO_KEEP_SUPPORT
 	help
 	  Say Y here to trim more 'unused' syscalls wrongly kept by __ex_table
 	  like sections in kernel space.
@@ -1778,6 +1786,7 @@ config SECTION_SHF_LINK_ORDER_SUPPORT
 config SECTION_SHF_GROUP_SUPPORT
 	bool "Using SHF_GROUP attribute (EXPERIMENTAL)" if EXPERT
 	depends on HAVE_SECTION_SHF_GROUP_SUPPORT
+	select SECTION_NO_KEEP_SUPPORT
 	help
 	  Say Y here to trim more 'unused' syscalls wrongly kept by __ex_table
 	  like sections in kernel space.
-- 
2.34.1

