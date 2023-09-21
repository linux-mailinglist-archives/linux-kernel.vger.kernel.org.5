Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37387A9B97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjIUTCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjIUTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:09 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB988CC93;
        Thu, 21 Sep 2023 10:42:40 -0700 (PDT)
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 7757D29BF;
        Thu, 21 Sep 2023 16:36:59 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 14592134.A48E4
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:140:242:ac11:1d])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 14592134;
        Thu, 21 Sep 2023 16:36:38 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1695306997;
        bh=BlYdRr32xxxqfktzP+vlGnAtIlq3iaZb2FkzpNho4RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cShiXCCWe/OoXhNS8r6JSF7j3nH5EkpMOg+XanBJ0o+CM1MsZs+bS8+nZ9OD3zYiQ
         MZ0ZAsWK/b6bQkiUPeYet8zdD+eId4xI46Ql4plR6m242BM9ExSO9tKvBAciVxigq8
         2K5CpVDR5eyFarD+JDZO2BgTYHWDsRBJAA1bCvks=
Received: from localhost.localdomain (ptr-82s0fs8p4onqm1q5sl7.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:c962:1db3:c9ed:fdfb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id CEF58D4F38757;
        Thu, 21 Sep 2023 16:36:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v6 02/13] selftests/sgx: Fix uninitialized pointer dereferences in encl_get_entry
Date:   Thu, 21 Sep 2023 16:35:53 +0200
Message-Id: <20230921143604.6561-3-jo.vanbulck@cs.kuleuven.be>
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

Ensure sym_tab and sym_names are zero-initialized and add an early-out
condition in the unlikely (erroneous) case that the enclave ELF file would
not contain a symbol table.

This addresses -Werror=maybe-uninitialized compiler warnings for gcc -O2.

Fixes: 33c5aac3bf32 ("selftests/sgx: Test complete changing of page type flow")
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/load.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 94bdeac1cf04..c9f658e44de6 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -136,11 +136,11 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
  */
 uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 {
+	Elf64_Sym *symtab = NULL;
+	char *sym_names = NULL;
 	Elf64_Shdr *sections;
-	Elf64_Sym *symtab;
 	Elf64_Ehdr *ehdr;
-	char *sym_names;
-	int num_sym;
+	int num_sym = 0;
 	int i;
 
 	ehdr = encl->bin;
@@ -161,6 +161,9 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 		}
 	}
 
+	if (!symtab || !sym_names)
+		return 0;
+
 	for (i = 0; i < num_sym; i++) {
 		Elf64_Sym *sym = &symtab[i];
 
-- 
2.25.1

