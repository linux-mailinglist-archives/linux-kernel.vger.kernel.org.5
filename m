Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A6E7B45C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjJAHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjJAHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:14:12 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C227BF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 00:14:08 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id mqeRqDkx1FUAImqeRqiyTX; Sun, 01 Oct 2023 09:14:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696144446;
        bh=Dz1UeOwZ8D3gWqhd347/K4+hqBwOzPrkQWzzaVtlMzY=;
        h=From:To:Cc:Subject:Date;
        b=PQawNpi9kuc2NtZ7RgyVhcDO425+uGUgiUz6D13ulhKLSwmkQA6wWu5hiT3J7Y8jk
         yNpNrMK0R4GbtAYoC2a2VMHMzWQ9V6tvquetNHnhGvTEs0SQ5gdTplEfBq1YQS9oSo
         oBXRPQBNWDuHO8Pxj0lh898dN6EUpyq1V36bV1nORSquzqw9j6G7wVlN4byFgd6Gys
         9x8wYJabPmpFjO6ito9ye6c8yerJR22PSZNtmTNz1TtPlUoEFGRxwtTVa5i7i9JRQG
         nw37iCpgVbnGPr7+1Su7hBZBnhnCPkGur3OSgLSK22yUrj8Vb20JHP3FN/MZNrebVi
         Kgr34PBPFnnmg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 09:14:06 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-bcachefs@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] bcachefs: Use struct_size()
Date:   Sun,  1 Oct 2023 09:13:54 +0200
Message-Id: <120b638f99b088f91d5a4491c800463c554e70b8.1696144401.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() instead of hand writing it.
This is less verbose and more robust.

While at it, prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with __counted_by
can have their accesses bounds-checked at run-time checking via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions).

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a work done in parallel of what is currently worked
on by Kees Cook.

My patches are only related to corner cases that do NOT match the
semantic of his Coccinelle script[1].

In this case, struct_size() was not used to compute the size needed for the
structure and its flex array.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
---
 fs/bcachefs/disk_groups.c | 3 +--
 fs/bcachefs/super_types.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/bcachefs/disk_groups.c b/fs/bcachefs/disk_groups.c
index b292dbef7992..224efa917427 100644
--- a/fs/bcachefs/disk_groups.c
+++ b/fs/bcachefs/disk_groups.c
@@ -166,8 +166,7 @@ int bch2_sb_disk_groups_to_cpu(struct bch_fs *c)
 	if (!groups)
 		return 0;
 
-	cpu_g = kzalloc(sizeof(*cpu_g) +
-			sizeof(cpu_g->entries[0]) * nr_groups, GFP_KERNEL);
+	cpu_g = kzalloc(struct_size(cpu_g, entries, nr_groups), GFP_KERNEL);
 	if (!cpu_g)
 		return -BCH_ERR_ENOMEM_disk_groups_to_cpu;
 
diff --git a/fs/bcachefs/super_types.h b/fs/bcachefs/super_types.h
index 597a8db73585..78d6138db62d 100644
--- a/fs/bcachefs/super_types.h
+++ b/fs/bcachefs/super_types.h
@@ -46,7 +46,7 @@ struct bch_disk_group_cpu {
 struct bch_disk_groups_cpu {
 	struct rcu_head			rcu;
 	unsigned			nr;
-	struct bch_disk_group_cpu	entries[];
+	struct bch_disk_group_cpu	entries[] __counted_by(nr);
 };
 
 #endif /* _BCACHEFS_SUPER_TYPES_H */
-- 
2.34.1

