Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B17E05EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjKCP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344362AbjKCP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:59:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A5D4E;
        Fri,  3 Nov 2023 08:59:08 -0700 (PDT)
X-QQ-mid: bizesmtp86t1699027134tyw2b1v4
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Nov 2023 23:58:50 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: eSZ1CZgv+JCVHfF1wGxh8nF1q0geFQVjdp7+4eC2s5jBRXYvF4MCh5LGR7B+E
        8+fmWyYidCbzrgu0MyIjfriJ59BganbsFbgX/5YcVpNzFbubzZ6dLiMjHahc457QS0HWkpM
        Fs+rI0pdcMyYCTK4SUwz0pMd3PBl01wPTUvQesEcQq+EJG/XuR2vXuTHrlODVWPty+yV/29
        2Vnc8zaKv9YE6DbotW/r8+csDUkR1pa5ZtDVaUUN5+YVN0eCeGjKznkQB0jsEaGSMDKdrln
        4vKFNLZIoLjH5UocAwhtcmVuhVONXyw1aSP1/0oQeB7WlrjtTw1rgFghaFSj/mHgl+ZkWO2
        yA9Fx5mYFZAXRB61jZpB7Sq3gDPes8pPxQZSZMLehfXO4a96th3jTtVgpf52ywStnBsM5Uq
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9783515542256517097
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 02/14] compiler: add a global __QUITE_UNIQUE_ID()
Date:   Fri,  3 Nov 2023 23:58:49 +0800
Message-Id: <152d812cb6fa2c6018794ea7f05f487631542d6e.1699025537.git.tanyuan@tinylab.org>
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

From: Zhangjin Wu <falcon@tinylab.org>

Differs from __UNIQUE_ID(), __QUITE_UNIQUE_ID() also appends the
__COUNTER__ info to make it more unique.

Besides, seems assembly code also require such a unique id, let's make
it global, the same to the required __PASTE macro.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
I am not sure whether it is proper to put the __QUITE_UNIQUE_ID and
other stuff later in compiler.h. Welcome discussion as this is just
a preliminary approach.

 include/linux/compiler.h       | 5 +++++
 include/linux/compiler_types.h | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a18b24f..405b19cf6cf3 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -227,6 +227,11 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
+/* Quite-unique ID. */
+#ifndef __QUITE_UNIQUE_ID
+# define __QUITE_UNIQUE_ID(prefix) __PASTE(__PASTE(prefix, __LINE__), __COUNTER__)
+#endif
+
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c523c6683789..0b79e19d1017 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -70,10 +70,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __builtin_warning(x, y...) (1)
 #endif /* __CHECKER__ */
 
-/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
-#define ___PASTE(a,b) a##b
-#define __PASTE(a,b) ___PASTE(a,b)
-
 #ifdef __KERNEL__
 
 /* Attributes */
@@ -308,6 +304,10 @@ struct ftrace_likely_data {
 
 #endif /* __ASSEMBLY__ */
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a, b) a##b
+#define __PASTE(a, b) ___PASTE(a, b)
+
 /*
  * The below symbols may be defined for one or more, but not ALL, of the above
  * compilers. We don't consider that to be an error, so set them to nothing.
-- 
2.34.1

