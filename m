Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1B77CB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbjHOKgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjHOKfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:35:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37D1987
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:35:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FB7F1F38D;
        Tue, 15 Aug 2023 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692095736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=EHgfTGo331RLPVXZ/xeaNmO0JfnBMv1OFCIB4OSMpaI=;
        b=AkmIWBonKT9ykk3UUPcpUDx195hMy33WNcKCSEeZ9xNZDIIXOtljlZwP5jaZn4XvDILP3p
        ESgyKkN+PtUDGxFhhQ5XP0zKms/O/IzGy5jQT9OGezJNpVV7O98WIhCAXRk+fwrtP5cToo
        W+UrQgJ1y87sAbc5g26yZreV3LTV+Ps=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B09D213909;
        Tue, 15 Aug 2023 10:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dRnGJvdU22SjXgAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Tue, 15 Aug 2023 10:35:35 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] objtool: Cache number of return sites recorded
Date:   Tue, 15 Aug 2023 13:35:09 +0300
Message-Id: <20230815103509.309443-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an allyesconfig currently the kernels emits 454324. No point in
making around half a million iterations just to count them. Simply
increment a counter at the time of creation of each site.

Quick measurements shows a meager 200ms improvement when running
    objtool --rethunk --prefix=64 --no-unreachable --stats   --link

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 tools/objtool/check.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8936a05f0e5a..bb71c5d8859f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -33,6 +33,7 @@ static struct cfi_init_state initial_func_cfi;
 static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
 static struct cfi_state force_undefined_cfi;
+static unsigned long nr_rethunk_sites;
 
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -802,15 +803,12 @@ static int create_return_sites_sections(struct objtool_file *file)
 		return 0;
 	}
 
-	idx = 0;
-	list_for_each_entry(insn, &file->return_thunk_list, call_node)
-		idx++;
-
-	if (!idx)
+	if (!nr_rethunk_sites)
 		return 0;
 
 	sec = elf_create_section_pair(file->elf, ".return_sites",
-				      sizeof(int), idx, idx);
+				      sizeof(int), nr_rethunk_sites,
+				      nr_rethunk_sites);
 	if (!sec)
 		return -1;
 
@@ -1473,8 +1471,10 @@ static void add_return_call(struct objtool_file *file, struct instruction *insn,
 	insn->type = INSN_RETURN;
 	insn->retpoline_safe = true;
 
-	if (add)
+	if (add) {
 		list_add_tail(&insn->call_node, &file->return_thunk_list);
+		nr_rethunk_sites++;
+	}
 }
 
 static bool is_first_func_insn(struct objtool_file *file,
-- 
2.34.1

