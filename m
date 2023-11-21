Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852BF7F397A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjKUWut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjKUWuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:50:46 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D51BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:50:42 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1f9601fd9b1so127734fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700607041; x=1701211841; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DUyHc0j6Ju2SfAIga/ld56HvjwbN/U3s1rsaQ7X5kEY=;
        b=wp+If7pALqTqDsawYixQveY1G23oCiVSzSK79Zazqlapm6zXN+XKea4Y0DhaKU1mMC
         r3jzDkF2cPeNU1HNJL4BoXzctFaYaoQenElMgrBSC/Q5RdJJrtzbFqFEQArO5+xpis6N
         G4z2Kp++say7z3918OycjM6MRvDDde+59EqL5CstvbjypSEuD7vA9Zhe1ZulaRI4ktAr
         /sgMBimn4EumNjyp+d1tW1LR74xacryVPmTB4wmuy4N5aXEktZd3A1nVqocs8jtGB7+/
         u5uZDyM9S6F2OLg/5acFznHDPypE4gniRFN80C6/BJulorhG4bT91Ny7PyqwQB1phrq5
         nYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607041; x=1701211841;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUyHc0j6Ju2SfAIga/ld56HvjwbN/U3s1rsaQ7X5kEY=;
        b=oKEzOWBp0kqxdPniVjlbGzYiacrLx3GubFhbHflA8msO5FBb8+YdKnmeTu3HTXla9Q
         eimi9F+UvUofEr9a+1gAGxwD/mhzC70hNW84GmGf8L5YIdjO84FwWHKhll8N2DQsCEh5
         pMCMKfxgRFuKQpPKgqDqY6kJoZd6NZb+DTTTr5z1Cp9tOf/6pQ/2N2nUloUu1di0WeDd
         FHuCC0SNpjghdf3DEvKktVlXrV587JQuI46RNdkSek21DDeOY7rstFuo/KM0mv9Fe/OT
         RiPU8zjpF3/jlXxt0UnoMt0shSptjPIq+FNrqFJN4JCfZRBap1oQ+jQz7Dit3nv+8lN5
         22gQ==
X-Gm-Message-State: AOJu0Yxt85CyAa4jn7rovduSj5UzUILjW2pdxazZRDFCcrXxHPZBIuQo
        gD3+YbfYW3bUWuBmBPe7f9bL/lE7uk5JvpglRHw=
X-Google-Smtp-Source: AGHT+IGMIBWqRvMREzONSNPjvDKkKSJ4l9c+zeFDM9OJ5MF1Lsu7kknkgcAeKdMOtQd/CTHfWvVeHQ==
X-Received: by 2002:a05:6870:aa94:b0:1f9:5310:90ab with SMTP id gr20-20020a056870aa9400b001f9531090abmr388557oab.3.1700607041535;
        Tue, 21 Nov 2023 14:50:41 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z2-20020a056870384200b001f40abd9fdbsm1924965oal.2.2023.11.21.14.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:50:41 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 21 Nov 2023 14:50:37 -0800
Subject: [PATCH v2] riscv: Safely remove entries from relocation list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-module_linking_freeing-v2-1-974bfcd3664e@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIADw0XWUC/4WNUQrCMBBEr1L220izJVj98h5SSpNu2sU2kUSDU
 nJ3Yy/g1/AG5s0GkQJThEu1QaDEkb0rgIcKzDy4iQSPhQFrbKTEWqx+fC3UL+zu7KbeBqKSArU
 aGo1KaUVQxo9Alt+7+NYVnjk+ffjsP0n+2r/KJIUU1tpWjidsz9ZcAycf2Zmj8St0Oecv4suSS
 b8AAAA=
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700607040; l=7292;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BPxSfHiD/1CoNWAadGRWfCiIZVum0NpgMbJUCXfSyxQ=;
 b=OSv5WsCH1yJPN+gH6kzzLT3/R3XxrdSfng66ZLM1H5O7KATPtJ9oBxNDt6QdxKQHjbE1pFmX1
 yOWFSEG6iL8AvxpARIRUmFe2hWe03M2aKE5bF3SJcZQB6DhK5AdGN1g
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safe versions of list and hlist iteration to safely remove
entries from the module relocation lists. To allow mutliple threads to
load modules concurrently, move relocation list pointers onto the stack
rather than using global variables.

Fixes: 8fd6c5142395 ("riscv: Add remaining module relocations")
Reported-by: Ron Economos <re@w6rz.net>
Closes: https://lore.kernel.org/linux-riscv/444de86a-7e7c-4de7-5d1d-c1c40eefa4ba@w6rz.net
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v2:
- Support linking modules concurrently across threads.
- Link to v1: https://lore.kernel.org/r/20231120-module_linking_freeing-v1-1-fff81d7289fc@rivosinc.com
---
 arch/riscv/kernel/module.c | 76 +++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 56a8c78e9e21..f53e82b70dff 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -40,14 +40,17 @@ struct relocation_handlers {
 				  long buffer);
 };
 
-unsigned int initialize_relocation_hashtable(unsigned int num_relocations);
-void process_accumulated_relocations(struct module *me);
+unsigned int
+initialize_relocation_hashtable(unsigned int num_relocations,
+				struct hlist_head **relocation_hashtable,
+				struct list_head *used_buckets_list);
+void process_accumulated_relocations(struct module *me,
+				     struct hlist_head **relocation_hashtable,
+				     struct list_head *used_buckets_list);
 int add_relocation_to_accumulate(struct module *me, int type, void *location,
-				 unsigned int hashtable_bits, Elf_Addr v);
-
-struct hlist_head *relocation_hashtable;
-
-struct list_head used_buckets_list;
+				 unsigned int hashtable_bits, Elf_Addr v,
+				struct hlist_head **relocation_hashtable,
+				struct list_head *used_buckets_list);
 
 /*
  * The auipc+jalr instruction pair can reach any PC-relative offset
@@ -604,7 +607,9 @@ static const struct relocation_handlers reloc_handlers[] = {
 	/* 192-255 nonstandard ABI extensions  */
 };
 
-void process_accumulated_relocations(struct module *me)
+void process_accumulated_relocations(struct module *me,
+				     struct hlist_head **relocation_hashtable,
+				     struct list_head *used_buckets_list)
 {
 	/*
 	 * Only ADD/SUB/SET/ULEB128 should end up here.
@@ -624,18 +629,25 @@ void process_accumulated_relocations(struct module *me)
 	 *	- Each relocation entry for a location address
 	 */
 	struct used_bucket *bucket_iter;
+	struct used_bucket *bucket_iter_tmp;
 	struct relocation_head *rel_head_iter;
+	struct hlist_node *rel_head_iter_tmp;
 	struct relocation_entry *rel_entry_iter;
+	struct relocation_entry *rel_entry_iter_tmp;
 	int curr_type;
 	void *location;
 	long buffer;
 
-	list_for_each_entry(bucket_iter, &used_buckets_list, head) {
-		hlist_for_each_entry(rel_head_iter, bucket_iter->bucket, node) {
+	list_for_each_entry_safe(bucket_iter, bucket_iter_tmp,
+				 used_buckets_list, head) {
+		hlist_for_each_entry_safe(rel_head_iter, rel_head_iter_tmp,
+					  bucket_iter->bucket, node) {
 			buffer = 0;
 			location = rel_head_iter->location;
-			list_for_each_entry(rel_entry_iter,
-					    rel_head_iter->rel_entry, head) {
+			list_for_each_entry_safe(rel_entry_iter,
+						 rel_entry_iter_tmp,
+						 rel_head_iter->rel_entry,
+						 head) {
 				curr_type = rel_entry_iter->type;
 				reloc_handlers[curr_type].reloc_handler(
 					me, &buffer, rel_entry_iter->value);
@@ -648,11 +660,13 @@ void process_accumulated_relocations(struct module *me)
 		kfree(bucket_iter);
 	}
 
-	kfree(relocation_hashtable);
+	kfree(*relocation_hashtable);
 }
 
 int add_relocation_to_accumulate(struct module *me, int type, void *location,
-				 unsigned int hashtable_bits, Elf_Addr v)
+				 unsigned int hashtable_bits, Elf_Addr v,
+				struct hlist_head **relocation_hashtable,
+				struct list_head *used_buckets_list)
 {
 	struct relocation_entry *entry;
 	struct relocation_head *rel_head;
@@ -667,7 +681,7 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
 
 	hash = hash_min((uintptr_t)location, hashtable_bits);
 
-	current_head = &relocation_hashtable[hash];
+	current_head = &((*relocation_hashtable)[hash]);
 
 	/* Find matching location (if any) */
 	bool found = false;
@@ -693,7 +707,7 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
 				kmalloc(sizeof(struct used_bucket), GFP_KERNEL);
 			INIT_LIST_HEAD(&bucket->head);
 			bucket->bucket = current_head;
-			list_add(&bucket->head, &used_buckets_list);
+			list_add(&bucket->head, used_buckets_list);
 		}
 		hlist_add_head(&rel_head->node, current_head);
 	}
@@ -704,7 +718,10 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
 	return 0;
 }
 
-unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
+unsigned int
+initialize_relocation_hashtable(unsigned int num_relocations,
+				struct hlist_head **relocation_hashtable,
+				struct list_head *used_buckets_list)
 {
 	/* Can safely assume that bits is not greater than sizeof(long) */
 	unsigned long hashtable_size = roundup_pow_of_two(num_relocations);
@@ -720,12 +737,12 @@ unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
 
 	hashtable_size <<= should_double_size;
 
-	relocation_hashtable = kmalloc_array(hashtable_size,
-					     sizeof(*relocation_hashtable),
-					     GFP_KERNEL);
-	__hash_init(relocation_hashtable, hashtable_size);
+	*relocation_hashtable = kmalloc_array(hashtable_size,
+					      sizeof(*relocation_hashtable),
+					      GFP_KERNEL);
+	__hash_init(*relocation_hashtable, hashtable_size);
 
-	INIT_LIST_HEAD(&used_buckets_list);
+	INIT_LIST_HEAD(used_buckets_list);
 
 	return hashtable_bits;
 }
@@ -742,7 +759,13 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	Elf_Addr v;
 	int res;
 	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
-	unsigned int hashtable_bits = initialize_relocation_hashtable(num_relocations);
+	struct hlist_head *relocation_hashtable;
+	struct list_head used_buckets_list;
+	unsigned int hashtable_bits;
+
+	hashtable_bits = initialize_relocation_hashtable(num_relocations,
+							 &relocation_hashtable,
+							 &used_buckets_list);
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
@@ -823,14 +846,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		}
 
 		if (reloc_handlers[type].accumulate_handler)
-			res = add_relocation_to_accumulate(me, type, location, hashtable_bits, v);
+			res = add_relocation_to_accumulate(
+				me, type, location, hashtable_bits, v,
+				&relocation_hashtable, &used_buckets_list);
 		else
 			res = handler(me, location, v);
 		if (res)
 			return res;
 	}
 
-	process_accumulated_relocations(me);
+	process_accumulated_relocations(me, &relocation_hashtable,
+					&used_buckets_list);
 
 	return 0;
 }

---
base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
change-id: 20231120-module_linking_freeing-2b5a3b255b5e
-- 
- Charlie

