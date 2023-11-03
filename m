Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4777E05F5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbjKCP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344505AbjKCP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:59:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39327D5F;
        Fri,  3 Nov 2023 08:59:29 -0700 (PDT)
X-QQ-mid: bizesmtp64t1699027156tvs9nek9
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Nov 2023 23:59:13 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: znfcQSa1hKbGuZsoOVNlc1WvbvEkFGnTx1nx7spI6Tuzd0sHLnkw7AiMgni3t
        ZggaII50uNhW4y9QfvuvOyeS4F6auFyNTJw8NQCg+vLjRI5V2SC6LCN9adAn0v67sJ3OSX/
        ApylcxyFajCfrERC+YlFJVy8SGFJrBzCX2pVZ4xg8IbilwZDlWfF607cx65tZkc/N5v0pBo
        5KJ44BzBG+chXyP6BguFE6wzB2WGXdJq47gbtwJbgnW6dVctfCnU818SNsx7tWsczxLqyqh
        u4yC+u7f5c5hMGNKdyDBqUc2ZmUsHeTUO2gp5wzAo1jI1qkf08kTw9ItQQe6yQ05zfvbyXV
        s7UC4ZqDN0fbnt0BzlvuczseCniFWDH+IfzMMqsezOL6Jc3njt6dIop1FXbag==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3788500215190827511
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 04/14] compiler: add unique LABEL_NAME()
Date:   Fri,  3 Nov 2023 23:59:11 +0800
Message-Id: <db3498efc33b3065a0acb534d034f7d33ad03e19.1699025537.git.tanyuan@tinylab.org>
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

unique LABEL is required by SHF_LINK_ORDER support.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 include/linux/compiler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5a9cc3209b12..b178f5d51ad6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -246,6 +246,12 @@ static inline void *offset_to_ptr(const int *off)
 #endif
 #endif
 
+/* Unique Label NAME. */
+/* Label is file scope, __LINE__ is enough, and not change in the same macro call */
+#ifndef __LABEL_NAME
+# define __LABEL_NAME(prefix) __stringify(__PASTE(__PASTE(prefix, _), __LINE__))
+#endif
+
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
-- 
2.34.1

