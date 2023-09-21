Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D2D7A9FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjIUU0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjIUU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:23 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [134.58.240.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A508C636;
        Thu, 21 Sep 2023 10:42:34 -0700 (PDT)
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id B5E6829C1;
        Thu, 21 Sep 2023 16:36:59 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 96C42201CD.A1001
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140:242:ac11:1d])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 96C42201CD;
        Thu, 21 Sep 2023 16:36:38 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1695306998;
        bh=Lb2+T441LiI82u8EVjTlye28KOPs3IBWtbHHHpL7OIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R2Ei+GEi/hDD8+8/+nOt5SZytgdT85gKA8+H0HKhVkFPOKG81ZJIK3naQvOfne7EG
         kTFatmYSbW9m7cacCaLoOKqNDGsmsGHIZtxYYezoNWc33qsH62ouXslnDz70ekTcIv
         KyCFML5bNjiKLTdbmq/q1MA0m0kCArwwP/W0lDtI=
Received: from localhost.localdomain (ptr-82s0fs8p4onqm1q5sl7.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:c962:1db3:c9ed:fdfb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 5C6ABD4F30837;
        Thu, 21 Sep 2023 16:36:38 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v6 04/13] selftests/sgx: Separate linker options
Date:   Thu, 21 Sep 2023 16:35:55 +0200
Message-Id: <20230921143604.6561-5-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921143604.6561-1-jo.vanbulck@cs.kuleuven.be>
References: <20230921143604.6561-1-jo.vanbulck@cs.kuleuven.be>
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
 tools/testing/selftests/sgx/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 50aab6b57da3..dcdd04b322f8 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,9 +12,11 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
-ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_LDFLAGS := -z noexecstack -lcrypto
+ENCL_CFLAGS += -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
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

