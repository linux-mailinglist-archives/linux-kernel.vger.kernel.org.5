Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21017FACF1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjK0WFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjK0WFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:05:11 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5CC1AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:05:17 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d7fa93afe9so2829603a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701122716; x=1701727516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvIAmFcw54BmQHj1+eMPXZ5lcgdN4IW5nDHalxa3vjw=;
        b=NZ+Y9pbwFjtILupUaf/B14UeNIyLrDxYjPOicEBDMIUPVvXh7pHFxNbz7wRsp37x8f
         EO65kSSOhy55htbGU1t8mGWmD2+I1xX3/0ZqY79MUTMvYoRKHq3+WbJFUru4KKKlH6bj
         C0/wGG41s/JBg3oMajl6flCEHvS0a3qQrSzGdU7AIbndiFPq6Zk4eLh7KwUBedwjDW1V
         Mrb1Lwne+k3el2dUrAdKtYF3cZGWwCyh6LjQnRTxUE3Jb6rpE+8clBzZR5OpISv71FA6
         akFYdosTYkjpKHzA93hlmb9S25/ntyJUnOjWTVI9pB2CgCRLtC1tyhU0ESQDNwQHFEaD
         AH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122716; x=1701727516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvIAmFcw54BmQHj1+eMPXZ5lcgdN4IW5nDHalxa3vjw=;
        b=RjXfhV0E3sv6E9SjTbnG73/B/4+KWei+LDdec36dNFL5QjNR9lKDCnMnsLVy1n34BC
         /SclmvyNoOu2QR2hHfHRmXGxolwMXybA7aHiOEDHhhFTGAH4VJYx2uw1HIzR8OCzAcv/
         l7x2knAAheEV2M9SoOht8CPxIT2osbGG80tFqYxNOw7GFRwJP8Yvq3yE25zvmFJFotfO
         Iyhx/qM2oqFOgV2R9hr3A2e+z4J/zS5B6BGVpu+/XZ+yqqtBAtw92q5B4N7A1waAZvgX
         fIabpAcDvpG5JCbAiC4/T2wudEjQud8gQlJFkdYdvfVpaQSiNqz+e/WvYRryDVHMbosH
         0SvA==
X-Gm-Message-State: AOJu0Yw3kFxB9m5CHywxkKEu/yOFYuDpNUaq0XBprdUQiwWZah3DJJOs
        FLiT8LuGxMzy5Yzf0vLJqaORWw==
X-Google-Smtp-Source: AGHT+IFmkvCuwcOw1xy7dTJFWWmToF7QUcjaDSuGwTEsalpnCblJK80onm7AEdmQGhsJIMI/FXTsrA==
X-Received: by 2002:a05:6870:524c:b0:1fa:3014:ada9 with SMTP id o12-20020a056870524c00b001fa3014ada9mr10561965oai.54.1701122716534;
        Mon, 27 Nov 2023 14:05:16 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x23-20020a056830115700b006d679b53e8asm1458890otq.24.2023.11.27.14.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 14:05:16 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon, 27 Nov 2023 14:04:59 -0800
Subject: [PATCH v4 1/2] riscv: Safely remove entries from relocation list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-module_linking_freeing-v4-1-a2ca1d7027d0@rivosinc.com>
References: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
In-Reply-To: <20231127-module_linking_freeing-v4-0-a2ca1d7027d0@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Ron Economos <re@w6rz.net>,
        Samuel Holland <samuel.holland@sifive.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701122714; l=7889;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=oWHW0TwoEipPebbTedSb6UcR9/YptErZBNQ3JSBym2M=;
 b=J5XMWA4G1aZEqzAa6mZIwB3AtKNSf780SvwoUHh01Oa9Q5isHKUpK6W2FqqHwdQoqVDzg7SH4
 N7r+wwuHq2TA6ly2xMZb23IDdNT8rKFQ9sZX+tbiCNwdqUw6gwDZ6QI
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
 arch/riscv/kernel/module.c | 110 +++++++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 56a8c78e9e21..53593fe58cd8 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -40,15 +40,6 @@ struct relocation_handlers {
 				  long buffer);
 };
 
-unsigned int initialize_relocation_hashtable(unsigned int num_relocations);
-void process_accumulated_relocations(struct module *me);
-int add_relocation_to_accumulate(struct module *me, int type, void *location,
-				 unsigned int hashtable_bits, Elf_Addr v);
-
-struct hlist_head *relocation_hashtable;
-
-struct list_head used_buckets_list;
-
 /*
  * The auipc+jalr instruction pair can reach any PC-relative offset
  * in the range [-2^31 - 2^11, 2^31 - 2^11)
@@ -604,7 +595,10 @@ static const struct relocation_handlers reloc_handlers[] = {
 	/* 192-255 nonstandard ABI extensions  */
 };
 
-void process_accumulated_relocations(struct module *me)
+static void
+process_accumulated_relocations(struct module *me,
+				struct hlist_head **relocation_hashtable,
+				struct list_head *used_buckets_list)
 {
 	/*
 	 * Only ADD/SUB/SET/ULEB128 should end up here.
@@ -624,18 +618,25 @@ void process_accumulated_relocations(struct module *me)
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
@@ -648,11 +649,14 @@ void process_accumulated_relocations(struct module *me)
 		kfree(bucket_iter);
 	}
 
-	kfree(relocation_hashtable);
+	kfree(*relocation_hashtable);
 }
 
-int add_relocation_to_accumulate(struct module *me, int type, void *location,
-				 unsigned int hashtable_bits, Elf_Addr v)
+static int add_relocation_to_accumulate(struct module *me, int type,
+					void *location,
+					unsigned int hashtable_bits, Elf_Addr v,
+					struct hlist_head *relocation_hashtable,
+					struct list_head *used_buckets_list)
 {
 	struct relocation_entry *entry;
 	struct relocation_head *rel_head;
@@ -661,6 +665,10 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
 	unsigned long hash;
 
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+
+	if (!entry)
+		return -ENOMEM;
+
 	INIT_LIST_HEAD(&entry->head);
 	entry->type = type;
 	entry->value = v;
@@ -669,7 +677,10 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
 
 	current_head = &relocation_hashtable[hash];
 
-	/* Find matching location (if any) */
+	/*
+	 * Search for the relocation_head for the relocations that happen at the
+	 * provided location
+	 */
 	bool found = false;
 	struct relocation_head *rel_head_iter;
 
@@ -681,19 +692,45 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
 		}
 	}
 
+	/*
+	 * If there has not yet been any relocations at the provided location,
+	 * create a relocation_head for that location and populate it with this
+	 * relocation_entry.
+	 */
 	if (!found) {
 		rel_head = kmalloc(sizeof(*rel_head), GFP_KERNEL);
+
+		if (!rel_head) {
+			kfree(entry);
+			return -ENOMEM;
+		}
+
 		rel_head->rel_entry =
 			kmalloc(sizeof(struct list_head), GFP_KERNEL);
+
+		if (!rel_head->rel_entry) {
+			kfree(entry);
+			kfree(rel_head);
+			return -ENOMEM;
+		}
+
 		INIT_LIST_HEAD(rel_head->rel_entry);
 		rel_head->location = location;
 		INIT_HLIST_NODE(&rel_head->node);
 		if (!current_head->first) {
 			bucket =
 				kmalloc(sizeof(struct used_bucket), GFP_KERNEL);
+
+			if (!bucket) {
+				kfree(entry);
+				kfree(rel_head);
+				kfree(rel_head->rel_entry);
+				return -ENOMEM;
+			}
+
 			INIT_LIST_HEAD(&bucket->head);
 			bucket->bucket = current_head;
-			list_add(&bucket->head, &used_buckets_list);
+			list_add(&bucket->head, used_buckets_list);
 		}
 		hlist_add_head(&rel_head->node, current_head);
 	}
@@ -704,7 +741,9 @@ int add_relocation_to_accumulate(struct module *me, int type, void *location,
 	return 0;
 }
 
-unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
+static unsigned int
+initialize_relocation_hashtable(unsigned int num_relocations,
+				struct hlist_head **relocation_hashtable)
 {
 	/* Can safely assume that bits is not greater than sizeof(long) */
 	unsigned long hashtable_size = roundup_pow_of_two(num_relocations);
@@ -720,12 +759,13 @@ unsigned int initialize_relocation_hashtable(unsigned int num_relocations)
 
 	hashtable_size <<= should_double_size;
 
-	relocation_hashtable = kmalloc_array(hashtable_size,
-					     sizeof(*relocation_hashtable),
-					     GFP_KERNEL);
-	__hash_init(relocation_hashtable, hashtable_size);
+	*relocation_hashtable = kmalloc_array(hashtable_size,
+					      sizeof(*relocation_hashtable),
+					      GFP_KERNEL);
+	if (!*relocation_hashtable)
+		return -ENOMEM;
 
-	INIT_LIST_HEAD(&used_buckets_list);
+	__hash_init(*relocation_hashtable, hashtable_size);
 
 	return hashtable_bits;
 }
@@ -742,7 +782,17 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	Elf_Addr v;
 	int res;
 	unsigned int num_relocations = sechdrs[relsec].sh_size / sizeof(*rel);
-	unsigned int hashtable_bits = initialize_relocation_hashtable(num_relocations);
+	struct hlist_head *relocation_hashtable;
+	struct list_head used_buckets_list;
+	unsigned int hashtable_bits;
+
+	hashtable_bits = initialize_relocation_hashtable(num_relocations,
+							 &relocation_hashtable);
+
+	if (hashtable_bits < 0)
+		return hashtable_bits;
+
+	INIT_LIST_HEAD(&used_buckets_list);
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
@@ -823,14 +873,18 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		}
 
 		if (reloc_handlers[type].accumulate_handler)
-			res = add_relocation_to_accumulate(me, type, location, hashtable_bits, v);
+			res = add_relocation_to_accumulate(me, type, location,
+							   hashtable_bits, v,
+							   relocation_hashtable,
+							   &used_buckets_list);
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

-- 
2.42.0

