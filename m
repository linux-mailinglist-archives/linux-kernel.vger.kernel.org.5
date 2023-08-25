Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983F7888B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbjHYNd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245113AbjHYNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:33:22 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A72126;
        Fri, 25 Aug 2023 06:33:20 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 8085720214.AFCE7
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 8085720214;
        Fri, 25 Aug 2023 15:33:17 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970397;
        bh=t4C5q/+PO5uca+hi5oGFJcAQVHSICyFgXT2ejy9I+M8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NDpTvHhBxP+3Snu7d1e3rjP3vJ6AAl63SUgF/DguHeUhn/4PI0x3VNq7WxBIM8N/0
         /Zs1QgsMdQcXR5k63ZQDrBaU8GGOVILZ0+A8HZz/+xOL+n26U5h2uSGUSZLHUqyodq
         iRlg+IU7k4An/vREpaWJHLwZ/5dWxx4eu0wyR9ZU=
Received: from localhost.localdomain (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 45648D4EB98F8;
        Fri, 25 Aug 2023 15:33:17 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v4 08/13] selftests/sgx: Separate linker options
Date:   Fri, 25 Aug 2023 15:32:47 +0200
Message-Id: <20230825133252.9056-9-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes "'linker' input unused [-Wunused-command-line-argument]" errors when
compiling with clang.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 1d6315a2e5f5..2de970f7237c 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,9 +12,11 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS := -Wall -Werror -static-pie -nostdlib -nostartfiles -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
+ENCL_LDFLAGS := -Wl,-T,test_encl.lds,--build-id=none
 
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
 TEST_FILES := $(OUTPUT)/test_encl.elf
@@ -28,7 +30,7 @@ $(OUTPUT)/test_sgx: $(OUTPUT)/main.o \
 		    $(OUTPUT)/sigstruct.o \
 		    $(OUTPUT)/call.o \
 		    $(OUTPUT)/sign_key.o
-	$(CC) $(HOST_CFLAGS) -o $@ $^ -lcrypto
+	$(CC) $(HOST_CFLAGS) -o $@ $^ $(HOST_LDFLAGS)
 
 $(OUTPUT)/main.o: main.c
 	$(CC) $(HOST_CFLAGS) -c $< -o $@
@@ -45,8 +47,8 @@ $(OUTPUT)/call.o: call.S
 $(OUTPUT)/sign_key.o: sign_key.S
 	$(CC) $(HOST_CFLAGS) -c $< -o $@
 
-$(OUTPUT)/test_encl.elf: test_encl.lds test_encl.c test_encl_bootstrap.S
-	$(CC) $(ENCL_CFLAGS) -T $^ -o $@ -Wl,--build-id=none
+$(OUTPUT)/test_encl.elf: test_encl.c test_encl_bootstrap.S
+	$(CC) $(ENCL_CFLAGS) $^ -o $@ $(ENCL_LDFLAGS)
 
 EXTRA_CLEAN := \
 	$(OUTPUT)/test_encl.elf \
-- 
2.25.1

