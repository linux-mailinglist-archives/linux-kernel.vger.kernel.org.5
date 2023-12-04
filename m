Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3E803CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjLDSTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:19:54 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46324AA;
        Mon,  4 Dec 2023 10:19:59 -0800 (PST)
Received: from localhost.ispras.ru (unknown [10.10.165.9])
        by mail.ispras.ru (Postfix) with ESMTPSA id 176CB40F1DE9;
        Mon,  4 Dec 2023 18:19:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 176CB40F1DE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1701713996;
        bh=hapnOCz7N50/xiqT9sjD7kWuwPtxGk7RX/cUkNtJPic=;
        h=From:To:Cc:Subject:Date:From;
        b=jZskYT+XqqFEn/TsdlSKf3xUncApwt4Zq8OjXuB0tBwvGcf1MxQmyjrTqUzDMRZ40
         6xmsz1HQ0CoIP3gR/z1wJ2rMDw8vEgBhnAQxdCLWHlmbPyIsOBNiFTovZFO4Rzo1Il
         YvPUUuQxfL48lJHbirWNnjJYn7slbaSTlj+lYkr4=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] apparmor: fix possible memory leak in unpack_trans_table
Date:   Mon,  4 Dec 2023 21:19:44 +0300
Message-ID: <20231204181945.5903-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.0
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

If we fail to unpack the transition table then the table elements which
have been already allocated are not freed on error path.

unreferenced object 0xffff88802539e000 (size 128):
  comm "apparmor_parser", pid 903, jiffies 4294914938 (age 35.085s)
  hex dump (first 32 bytes):
    20 73 6f 6d 65 20 6e 61 73 74 79 20 73 74 72 69   some nasty stri
    6e 67 20 73 6f 6d 65 20 6e 61 73 74 79 20 73 74  ng some nasty st
  backtrace:
    [<ffffffff81ddb312>] __kmem_cache_alloc_node+0x1e2/0x2d0
    [<ffffffff81c47194>] __kmalloc_node_track_caller+0x54/0x170
    [<ffffffff81c225b9>] kmemdup+0x29/0x60
    [<ffffffff83e1ee65>] aa_unpack_strdup+0xe5/0x1b0
    [<ffffffff83e20808>] unpack_pdb+0xeb8/0x2700
    [<ffffffff83e23567>] unpack_profile+0x1507/0x4a30
    [<ffffffff83e27bfa>] aa_unpack+0x36a/0x1560
    [<ffffffff83e194c3>] aa_replace_profiles+0x213/0x33c0
    [<ffffffff83de9461>] policy_update+0x261/0x370
    [<ffffffff83de978e>] profile_replace+0x20e/0x2a0
    [<ffffffff81eac8bf>] vfs_write+0x2af/0xe00
    [<ffffffff81eaddd6>] ksys_write+0x126/0x250
    [<ffffffff88f34fb6>] do_syscall_64+0x46/0xf0
    [<ffffffff890000ea>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

Call aa_free_str_table() on error path as was done before the blamed
commit. It implements all necessary checks, frees str_table if it is
available and nullifies the pointers.

Found by Linux Verification Center (linuxtesting.org).

Fixes: a0792e2ceddc ("apparmor: make transition table unpack generic so it can be reused")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 security/apparmor/lib.c           | 1 +
 security/apparmor/policy_unpack.c | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/lib.c b/security/apparmor/lib.c
index 4c198d273f09..cd569fbbfe36 100644
--- a/security/apparmor/lib.c
+++ b/security/apparmor/lib.c
@@ -41,6 +41,7 @@ void aa_free_str_table(struct aa_str_table *t)
 			kfree_sensitive(t->table[i]);
 		kfree_sensitive(t->table);
 		t->table = NULL;
+		t->size = 0;
 	}
 }
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index fc21952aca6b..887010692538 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -478,6 +478,8 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_str_table *strs)
 		if (!table)
 			goto fail;
 
+		strs->table = table;
+		strs->size = size;
 		for (i = 0; i < size; i++) {
 			char *str;
 			int c, j, pos, size2 = aa_unpack_strdup(e, &str, NULL);
@@ -520,14 +522,11 @@ static bool unpack_trans_table(struct aa_ext *e, struct aa_str_table *strs)
 			goto fail;
 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
 			goto fail;
-
-		strs->table = table;
-		strs->size = size;
 	}
 	return true;
 
 fail:
-	kfree_sensitive(table);
+	aa_free_str_table(strs);
 	e->pos = saved_pos;
 	return false;
 }
-- 
2.43.0

