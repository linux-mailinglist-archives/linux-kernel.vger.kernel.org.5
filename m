Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C809C80ABC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbjLHSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574516AbjLHSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F4E9;
        Fri,  8 Dec 2023 10:13:03 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:13:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JgRl1YckNu9AO65EXo8Bm075gAidFqIf9saLES6tuQE=;
        b=NvuCypa6ECU3uFtOiIQ6LVTsB142ORjYQLiX8vKY9mW+dwJGswDGx6YKwfPWPYmHnhcTkk
        zgYjXt/RGs2X1VJeB+TvsfUFD+E4aQ2g/YgkRuzrNHacft84YhlbUTUF/TW6QvrmMVJ0or
        12n05BkeFXUD8Tqshvmvj9COjq63T8pAXU8GtzRv6m8jqNdXHL2/WW9gl/P6wlChnb2Ufd
        puvnK58JO2wLe9jMDTn3mtys9CsQ0IjoTL8ClwPt+XjqZvttac1hbFBzH8vi9IqWluwBtx
        uWWLq/zyzLElkS9OXe0Byl/iT3lAFnM+MHlLsFBso9AA/pcNwZv2Gena6JDhJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=JgRl1YckNu9AO65EXo8Bm075gAidFqIf9saLES6tuQE=;
        b=VLCdbRZbcNsL2u6afzsgQRjrrJBs3ugMIc+PYBnfoq7TOgnwpDPWo5wdUtw4wC8/A+nm9f
        /RdJIuLWmpof3aDg==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Specify freestanding environment for
 enclave compilation
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205918152.398.15533995692034132041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     304b259e63b94c4f825e0648b33b15f8962955c7
Gitweb:        https://git.kernel.org/tip/304b259e63b94c4f825e0648b33b15f8962955c7
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:46 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Specify freestanding environment for enclave compilation

Use -ffreestanding to assert the enclave compilation targets a
freestanding environment (i.e., without "main" or standard libraries).
This fixes clang reporting "undefined reference to `memset'" after
erroneously optimizing away the provided memset/memcpy implementations.

Still need to instruct the linker from using standard system startup
functions, but drop -nostartfiles as it is implied by -nostdlib.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231005153854.25566-6-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index dcdd04b..7eb890b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -14,7 +14,7 @@ endif
 INCLUDES := -I$(top_srcdir)/tools/include
 HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
 HOST_LDFLAGS := -z noexecstack -lcrypto
-ENCL_CFLAGS += -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+ENCL_CFLAGS += -Wall -Werror -static -nostdlib -ffreestanding -fPIC \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
 ENCL_LDFLAGS := -Wl,-T,test_encl.lds,--build-id=none
 
