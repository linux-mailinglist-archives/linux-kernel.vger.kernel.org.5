Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B008678EED5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbjHaNmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345312AbjHaNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:42:10 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54917CFC;
        Thu, 31 Aug 2023 06:42:07 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 2CD6E72.A7973
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:1e])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 2CD6E72;
        Thu, 31 Aug 2023 15:42:05 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#OURIPS#-35.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693489325;
        bh=qKbX2SWQobU0T2TnOqQF1i9y4ywemPrA3c6dALyT5oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XWaueKtMX3lPlc8ohhw7i4nViev/IKITVVXLDjGrIcuWg9/E2XDCpix+YE/MKDa44
         1q1v9Lt38naEblHtG9v7NwtmBTjg3EQCD6zZB5AT9Y402PF7NHPH4wbBPvVGrymOEd
         mXqt+piqG4cn9ngkjyTsl+cD7YjiFdRmGpTM1oBs=
Received: from localhost.localdomain (unknown [10.45.168.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id E5D1CD4F6440C;
        Thu, 31 Aug 2023 15:42:04 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
To:     jarkko@kernel.org, kai.huang@intel.com, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Subject: [PATCH v5 02/13] selftests/sgx: Fix uninitialized pointer dereferences in encl_get_entry
Date:   Thu, 31 Aug 2023 15:41:33 +0200
Message-Id: <20230831134144.22686-3-jo.vanbulck@cs.kuleuven.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
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

