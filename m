Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30027EC9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjKORht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjKORhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:38 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D82D42
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:33 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-777754138bdso463506385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069852; x=1700674652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDtZpQP+OF9Ls+8v3KDmKE8Uj5TeqYlQFmL5zNUIneg=;
        b=gnShT4zMGR0c3+n4L/hevwdxmAABbJpv8jF3Oc/oqHKDky/oFKNzdnGUZEuqlIxY9M
         1NBk2OKtza+mnOC34AL2odoj9uNXUpaMiB5JKgp5daXstN+qdWdAmDyNEwgNgi2m6ZHp
         VBI0MizUZqR0BJgr/HUTap0Uy5N2CAdndoRQkXzGYL3upDkkPbA9L0f7KF7231D2UEqK
         nbiOSObLCJpNg0pX3WTnQu6qyvDFZgpjueN6zlz4+OnruTaQde/a3tWq9OvZehGMtDy+
         AWdVPF6ccBTLc/VrmnAVaAipH45rsiff3Tz0nSEFml6sSzTmXsB0n6dfa9T/5Ba8y8KS
         049Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069852; x=1700674652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDtZpQP+OF9Ls+8v3KDmKE8Uj5TeqYlQFmL5zNUIneg=;
        b=WMyU12fZ/gKiJIDMJHWyIGDaCd+XvlpSmr5g/dNMd63JAuEzn5eMY0nmzCWBYpokbF
         SWNOBuS1hw0zypYj1MGnn2hQwyuxqUr9F2pE3puiZe2FKvvUar72xDRz1Pl6RSx30XKK
         T17SHISB4A/kgjq6IE6wNo/AOW0ZhiyMXnOAeEO/XXZ62krr29dA3jx2BaaFhp8hOz13
         FxIiiofLzRlN9okj1jIOtxYCkQ+4bwS0KglsN9btSUSeV2hddMlqzRQKQBvWKofEKGct
         q84L+3TLt2tsPkXzMK3yjIMlVrodfwC24Dy5GcHXVJ5q4ObpQkXrGKmV5l0gTeM6YzDA
         8qyA==
X-Gm-Message-State: AOJu0Yylnw9qt9LLIsk/IbY6wrFpqBRAymMOgqbCxFs5+6f/pLUmvPJB
        f+/B0u2boyQNWbVgNYLulbAVcNJeew==
X-Google-Smtp-Source: AGHT+IG9Qzm4oanuaHXMTBkxXo9dMyTjXWqZwFaz23KZ036fGHKDJU5ReaE4228kHI4VhQrnVl7fCQ==
X-Received: by 2002:a05:620a:8418:b0:778:92fb:a8c4 with SMTP id pc24-20020a05620a841800b0077892fba8c4mr5312357qkn.30.1700069852549;
        Wed, 15 Nov 2023 09:37:32 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:31 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 06/14] objtool: Allow adding relocations to an existing section
Date:   Wed, 15 Nov 2023 12:37:00 -0500
Message-ID: <20231115173708.108316-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to add relocations to existing sections (e.g. ".rela.text"),
encapsulate the reloc array in a block header to allow chaining blocks
to add more relocs without moving and relinking the existing ones.
This adds minimal memory overhead, while still being able to easily
access the arrays by index.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 tools/objtool/check.c               |  2 +-
 tools/objtool/elf.c                 | 99 +++++++++++++++++++++++------
 tools/objtool/include/objtool/elf.h | 84 +++++++++++++++++++-----
 3 files changed, 148 insertions(+), 37 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e94756e09ca9..ac304140c395 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4409,7 +4409,7 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 		return 0;
 
 	WARN_FUNC("data relocation to !ENDBR: %s",
-		  reloc->sec->base, reloc_offset(reloc),
+		  reloc->block->sec->base, reloc_offset(reloc),
 		  offstr(dest->sec, dest->offset));
 
 	return 1;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d27983dc908..cfb970727c8a 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -277,7 +277,7 @@ struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *se
 	for_offset_range(o, offset, offset + len) {
 		elf_hash_for_each_possible(reloc, reloc, hash,
 					   sec_offset_hash(rsec, o)) {
-			if (reloc->sec != rsec)
+			if (reloc->block->sec != rsec)
 				continue;
 
 			if (reloc_offset(reloc) >= offset &&
@@ -333,6 +333,7 @@ static int read_sections(struct elf *elf)
 		sec = &elf->section_data[i];
 
 		INIT_LIST_HEAD(&sec->symbol_list);
+		INIT_LIST_HEAD(&sec->reloc_list);
 
 		s = elf_getscn(elf->elf, i);
 		if (!s) {
@@ -850,7 +851,7 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 				    unsigned long offset, struct symbol *sym,
 				    s64 addend, unsigned int type)
 {
-	struct reloc *reloc, empty = { 0 };
+	struct reloc *reloc;
 
 	if (reloc_idx >= sec_num_entries(rsec)) {
 		WARN("%s: bad reloc_idx %u for %s with %d relocs",
@@ -858,15 +859,18 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 		return NULL;
 	}
 
-	reloc = &rsec->relocs[reloc_idx];
+	reloc = get_reloc_by_index(rsec, reloc_idx);
+	if (!reloc) {
+		WARN("%s: %s: reloc %d out of range!",
+		     __func__, rsec->name, reloc_idx);
+		return NULL;
+	}
 
-	if (memcmp(reloc, &empty, sizeof(empty))) {
+	if (reloc->sym) {
 		WARN("%s: %s: reloc %d already initialized!",
 		     __func__, rsec->name, reloc_idx);
 		return NULL;
 	}
-
-	reloc->sec = rsec;
 	reloc->sym = sym;
 
 	set_reloc_offset(elf, reloc, offset);
@@ -930,19 +934,45 @@ struct reloc *elf_init_reloc_data_sym(struct elf *elf, struct section *sec,
 			      elf_data_rela_type(elf));
 }
 
+static struct reloc_block *alloc_reloc_block(struct section *rsec, size_t num_relocs)
+{
+	struct reloc_block *block;
+	size_t block_size = sizeof(struct reloc_block) + sec_num_entries(rsec) * sizeof(struct reloc);
+	int i;
+
+	block = malloc(block_size);
+	if (!block) {
+		perror("malloc");
+		return NULL;
+	}
+
+	memset(block, 0, block_size);
+	INIT_LIST_HEAD(&block->list);
+	block->sec = rsec;
+	block->start_idx = rsec->num_relocs;
+	block->len = num_relocs;
+
+	for (i = 0; i < num_relocs; i++)
+		block->relocs[i].block = block;
+
+	rsec->num_relocs += num_relocs;
+	list_add_tail(&block->list, &rsec->reloc_list);
+
+	return block;
+}
+
 static int read_relocs(struct elf *elf)
 {
 	unsigned long nr_reloc, max_reloc = 0;
 	struct section *rsec;
-	struct reloc *reloc;
-	unsigned int symndx;
-	struct symbol *sym;
 	int i;
 
 	if (!elf_alloc_hash(reloc, elf->num_relocs))
 		return -1;
 
 	list_for_each_entry(rsec, &elf->sections, list) {
+		struct reloc_block *block;
+
 		if (!is_reloc_sec(rsec))
 			continue;
 
@@ -956,15 +986,15 @@ static int read_relocs(struct elf *elf)
 		rsec->base->rsec = rsec;
 
 		nr_reloc = 0;
-		rsec->relocs = calloc(sec_num_entries(rsec), sizeof(*reloc));
-		if (!rsec->relocs) {
-			perror("calloc");
+		block = alloc_reloc_block(rsec, sec_num_entries(rsec));
+		if (!block)
 			return -1;
-		}
+
 		for (i = 0; i < sec_num_entries(rsec); i++) {
-			reloc = &rsec->relocs[i];
+			struct reloc *reloc = &block->relocs[i];
+			struct symbol *sym;
+			unsigned int symndx;
 
-			reloc->sec = rsec;
 			symndx = reloc_sym(reloc);
 			reloc->sym = sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
@@ -1100,6 +1130,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	memset(sec, 0, sizeof(*sec));
 
 	INIT_LIST_HEAD(&sec->symbol_list);
+	INIT_LIST_HEAD(&sec->reloc_list);
 
 	s = elf_newscn(elf->elf);
 	if (!s) {
@@ -1170,6 +1201,7 @@ static struct section *elf_create_rela_section(struct elf *elf,
 					       unsigned int reloc_nr)
 {
 	struct section *rsec;
+	struct reloc_block *block;
 	char *rsec_name;
 
 	rsec_name = malloc(strlen(sec->name) + strlen(".rela") + 1);
@@ -1192,11 +1224,9 @@ static struct section *elf_create_rela_section(struct elf *elf,
 	rsec->sh.sh_info = sec->idx;
 	rsec->sh.sh_flags = SHF_INFO_LINK;
 
-	rsec->relocs = calloc(sec_num_entries(rsec), sizeof(struct reloc));
-	if (!rsec->relocs) {
-		perror("calloc");
+	block = alloc_reloc_block(rsec, sec_num_entries(rsec));
+	if (!block)
 		return NULL;
-	}
 
 	sec->rsec = rsec;
 	rsec->base = sec;
@@ -1204,6 +1234,37 @@ static struct section *elf_create_rela_section(struct elf *elf,
 	return rsec;
 }
 
+int elf_extend_rela_section(struct elf *elf,
+			    struct section *rsec,
+			    int add_relocs)
+{
+	int newnr = sec_num_entries(rsec) + add_relocs;
+	size_t oldsize = rsec->sh.sh_size;
+	size_t newsize = newnr * rsec->sh.sh_entsize;
+	void *buf;
+	struct reloc_block *block;
+
+	buf = realloc(rsec->data->d_buf, newnr * rsec->sh.sh_entsize);
+	if (!buf) {
+		perror("realloc");
+		return -1;
+	}
+
+	memset(buf + oldsize, 0, newsize - oldsize);
+
+	rsec->data->d_size = newsize;
+	rsec->data->d_buf = buf;
+	rsec->sh.sh_size = newsize;
+
+	mark_sec_changed(elf, rsec, true);
+
+	block = alloc_reloc_block(rsec, add_relocs);
+	if (!block)
+		return -1;
+
+	return 0;
+}
+
 struct section *elf_create_section_pair(struct elf *elf, const char *name,
 					size_t entsize, unsigned int nr,
 					unsigned int reloc_nr)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9f71e988eca4..7851467f6878 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -43,7 +43,8 @@ struct section {
 	char *name;
 	int idx;
 	bool _changed, text, rodata, noinstr, init, truncate;
-	struct reloc *relocs;
+	struct list_head reloc_list;
+	int num_relocs;
 };
 
 struct symbol {
@@ -71,13 +72,23 @@ struct symbol {
 	struct reloc *relocs;
 };
 
+struct reloc_block;
+
 struct reloc {
 	struct elf_hash_node hash;
-	struct section *sec;
+	struct reloc_block *block;
 	struct symbol *sym;
 	struct reloc *sym_next_reloc;
 };
 
+struct reloc_block {
+	struct list_head list;
+	struct section *sec;
+	int start_idx;
+	int len;
+	struct reloc relocs[0];
+};
+
 struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
@@ -108,6 +119,11 @@ struct elf *elf_open_read(const char *name, int flags);
 
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   size_t entsize, unsigned int nr);
+
+int elf_extend_rela_section(struct elf *elf,
+			    struct section *rsec,
+			    int add_relocs);
+
 struct section *elf_create_section_pair(struct elf *elf, const char *name,
 					size_t entsize, unsigned int nr,
 					unsigned int reloc_nr);
@@ -197,12 +213,12 @@ static inline unsigned int sec_num_entries(struct section *sec)
 
 static inline unsigned int reloc_idx(struct reloc *reloc)
 {
-	return reloc - reloc->sec->relocs;
+	return reloc->block->start_idx + (reloc - &reloc->block->relocs[0]);
 }
 
 static inline void *reloc_rel(struct reloc *reloc)
 {
-	struct section *rsec = reloc->sec;
+	struct section *rsec = reloc->block->sec;
 
 	return rsec->data->d_buf + (reloc_idx(reloc) * rsec->sh.sh_entsize);
 }
@@ -215,7 +231,7 @@ static inline bool is_32bit_reloc(struct reloc *reloc)
 	 * Elf64_Rel:  16 bytes
 	 * Elf64_Rela: 24 bytes
 	 */
-	return reloc->sec->sh.sh_entsize < 16;
+	return reloc->block->sec->sh.sh_entsize < 16;
 }
 
 #define __get_reloc_field(reloc, field)					\
@@ -241,7 +257,7 @@ static inline u64 reloc_offset(struct reloc *reloc)
 static inline void set_reloc_offset(struct elf *elf, struct reloc *reloc, u64 offset)
 {
 	__set_reloc_field(reloc, r_offset, offset);
-	mark_sec_changed(elf, reloc->sec, true);
+	mark_sec_changed(elf, reloc->block->sec, true);
 }
 
 static inline s64 reloc_addend(struct reloc *reloc)
@@ -252,7 +268,7 @@ static inline s64 reloc_addend(struct reloc *reloc)
 static inline void set_reloc_addend(struct elf *elf, struct reloc *reloc, s64 addend)
 {
 	__set_reloc_field(reloc, r_addend, addend);
-	mark_sec_changed(elf, reloc->sec, true);
+	mark_sec_changed(elf, reloc->block->sec, true);
 }
 
 
@@ -282,7 +298,7 @@ static inline void set_reloc_sym(struct elf *elf, struct reloc *reloc, unsigned
 
 	__set_reloc_field(reloc, r_info, info);
 
-	mark_sec_changed(elf, reloc->sec, true);
+	mark_sec_changed(elf, reloc->block->sec, true);
 }
 static inline void set_reloc_type(struct elf *elf, struct reloc *reloc, unsigned int type)
 {
@@ -292,7 +308,46 @@ static inline void set_reloc_type(struct elf *elf, struct reloc *reloc, unsigned
 
 	__set_reloc_field(reloc, r_info, info);
 
-	mark_sec_changed(elf, reloc->sec, true);
+	mark_sec_changed(elf, reloc->block->sec, true);
+}
+
+static inline struct reloc *get_reloc_by_index(struct section *rsec, int idx)
+{
+	struct reloc_block *block;
+
+	list_for_each_entry(block, &rsec->reloc_list, list) {
+		if (idx < block->len)
+			return &block->relocs[idx];
+		idx -= block->len;
+	}
+
+	return NULL;
+}
+
+static inline struct reloc *first_reloc(struct section *sec)
+{
+	struct reloc_block *block;
+
+	if (list_empty(&sec->reloc_list))
+		return NULL;
+
+	block = list_first_entry(&sec->reloc_list, struct reloc_block, list);
+	return &block->relocs[0];
+}
+
+static inline struct reloc *next_reloc(struct reloc *reloc)
+{
+	struct reloc_block *block = reloc->block;
+
+	reloc++;
+	if (reloc < &block->relocs[block->len])
+		return reloc;
+
+	if (list_is_last(&block->list, &block->sec->reloc_list))
+		return NULL;
+
+	block = list_next_entry(block, list);
+	return &block->relocs[0];
 }
 
 #define for_each_sec(file, sec)						\
@@ -308,15 +363,10 @@ static inline void set_reloc_type(struct elf *elf, struct reloc *reloc, unsigned
 			sec_for_each_sym(__sec, sym)
 
 #define for_each_reloc(rsec, reloc)					\
-	for (int __i = 0, __fake = 1; __fake; __fake = 0)		\
-		for (reloc = rsec->relocs;				\
-		     __i < sec_num_entries(rsec);			\
-		     __i++, reloc++)
+	for (reloc = first_reloc(rsec); reloc; reloc = next_reloc(reloc))
 
 #define for_each_reloc_from(rsec, reloc)				\
-	for (int __i = reloc_idx(reloc);				\
-	     __i < sec_num_entries(rsec);				\
-	     __i++, reloc++)
+	for (; reloc; reloc = next_reloc(reloc))
 
 #define OFFSET_STRIDE_BITS	4
 #define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
@@ -344,7 +394,7 @@ static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
 
 static inline u32 reloc_hash(struct reloc *reloc)
 {
-	return sec_offset_hash(reloc->sec, reloc_offset(reloc));
+	return sec_offset_hash(reloc->block->sec, reloc_offset(reloc));
 }
 
 #endif /* _OBJTOOL_ELF_H */
-- 
2.41.0

