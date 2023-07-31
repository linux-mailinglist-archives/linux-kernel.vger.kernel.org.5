Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71A576938C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjGaKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjGaKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:50:49 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45D01BDB;
        Mon, 31 Jul 2023 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1690800563; bh=fZV1fPQDaoUXxVRY9TfX1xjDSukj+7ktchYSGtV8aSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wX0NIVvFJefytOowE9WrM4HpblaYyO+f40zMQV+9se7Rny8ZAaTnQKbuxgBs8aYbK
         zqIbGyWU/5gZh1FE5Yu+6+JUKDZlHHMimTi+9JgpF+MKPPq7x97bP+bGzLW3UEpfYc
         o15PXdUIiIuUfhdyvc5znN1GekOQQtdy8F99Ruho=
Received: from ld50.lan (unknown [101.88.28.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B296F60555;
        Mon, 31 Jul 2023 18:49:23 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 5/5] raid6: test: only check for Altivec if building on powerpc hosts
Date:   Mon, 31 Jul 2023 18:49:11 +0800
Message-Id: <20230731104911.411964-6-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230731104911.411964-1-kernel@xen0n.name>
References: <20230731104911.411964-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Altivec is only available for powerpc hosts, so only check for its
availability when the host is powerpc, to avoid error messages being
shown on architectures other than x86, arm or powerpc.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 lib/raid6/test/Makefile | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
index 143cda60faa12..1f693ea3b980c 100644
--- a/lib/raid6/test/Makefile
+++ b/lib/raid6/test/Makefile
@@ -35,6 +35,12 @@ ifeq ($(ARCH),aarch64)
         HAS_NEON = yes
 endif
 
+ifeq ($(findstring ppc,$(ARCH)),ppc)
+        CFLAGS += -I../../../arch/powerpc/include
+        HAS_ALTIVEC := $(shell printf '$(pound)include <altivec.h>\nvector int a;\n' |\
+                         gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
+endif
+
 ifeq ($(IS_X86),yes)
         OBJS   += mmx.o sse1.o sse2.o avx2.o recov_ssse3.o recov_avx2.o avx512.o recov_avx512.o
         CFLAGS += -DCONFIG_X86
@@ -44,15 +50,10 @@ ifeq ($(IS_X86),yes)
 else ifeq ($(HAS_NEON),yes)
         OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
         CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
-else
-        HAS_ALTIVEC := $(shell printf '$(pound)include <altivec.h>\nvector int a;\n' |\
-                         gcc -c -x c - >/dev/null && rm ./-.o && echo yes)
-        ifeq ($(HAS_ALTIVEC),yes)
-                CFLAGS += -I../../../arch/powerpc/include
-                CFLAGS += -DCONFIG_ALTIVEC
-                OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
-                        vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
-        endif
+else ifeq ($(HAS_ALTIVEC),yes)
+        CFLAGS += -DCONFIG_ALTIVEC
+        OBJS += altivec1.o altivec2.o altivec4.o altivec8.o \
+                vpermxor1.o vpermxor2.o vpermxor4.o vpermxor8.o
 endif
 
 .c.o:
-- 
2.40.0

