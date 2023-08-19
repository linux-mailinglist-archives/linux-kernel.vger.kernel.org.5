Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B257818E8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjHSKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjHSKkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:33 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9C14965A;
        Sat, 19 Aug 2023 02:44:48 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: D6543201B5.AC493
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id D6543201B5;
        Sat, 19 Aug 2023 11:44:46 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692438286;
        bh=UOZtsVaNgkzXGOb4N6ool94oopVkI7IpovoYou7Ds9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ny7KfS3mTfzGwJ1R8/VirbEsp34iYZYSaSWbOM0In7N7z73t/FecU76fqIa1BODIH
         Y9QB4RQjWpLullfVtmLtZMLIxnHD/IUjklfYQ2+RG3GzDG+Lyws/jAM9os015qHOAv
         zoMuCabYdDsRTVG1EId+XGtPWDe+qqGPW9k2FKns=
Received: from localhost.localdomain (ip-185-104-137-32.ptr.icomera.net [185.104.137.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id CBAC1D4EB61BA;
        Sat, 19 Aug 2023 11:44:45 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v3 8/9] selftests/sgx: Separate linker options
Date:   Sat, 19 Aug 2023 11:43:31 +0200
Message-Id: <20230819094332.8535-9-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
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
---
 tools/testing/selftests/sgx/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 1d6315a2e..2de970f72 100644
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

