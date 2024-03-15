Return-Path: <linux-kernel+bounces-104729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE20087D2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766A9282224
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201154AECB;
	Fri, 15 Mar 2024 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VxHgk7ne"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA60487B3;
	Fri, 15 Mar 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523961; cv=none; b=kEaHS0A5FRDsN4SgLwum98VlqW1UQRKNantNNNt5wMo4ZymIKJfDIxZ/m9woOZ+TbykaiTtpRCID6icBhcoJF/HL2KUBRj+tziA6S9tSxsXmlxSAL4lwTAbkvq7iU+n9nHBgyfUojZ9Y8XKvQKIX5ZVm+55tNNQfloqLq3ZvvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523961; c=relaxed/simple;
	bh=Q8t3AEPKp6fQi3w/pbYOmlKsBZ/FJIzlbR19sfwaXU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvklC45B1fthwaxlbgYX7pMDamw8wkz20EAeh5UTVDAhaQb2d//jyquAa0apjRN3we/kh2d0jn58++8w52DKBQEWj1r/6mKdo/lsMbsz/+voEtJ7WD+U3P9I+bibkJTRo3FsL6NUgLFdvEb2L0TMzXEaoC8C8exu9JTb+lRZ4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=VxHgk7ne; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so319697466b.0;
        Fri, 15 Mar 2024 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710523957; x=1711128757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aB1DZO1/YVC0bjj1nE+ssniKkXOWA9sPBcm6ECq5hfE=;
        b=VxHgk7ne2THitQtWrB3BMpzqq8AunQjdZMfzAGK0cZZooTSt0SR/4cK3MfbK5AQePi
         +w6/xfqW/pPPzdBs+XsATME72S0nj8oO9qTQwnGq0Xbcv+cR/KJi+W17gFQphY35kIXh
         6ayvtoA/IRBCbF3CbJb34xtw20d/7FmoNdPrR+KCsNqE1brRDIvcIthQUt3Rtoci7DCA
         k9gHz1e74K7KNRM7pYwxsI0WzenMhMwN40wU0ji7jZP015SUverErZlZgfRhG7je4Cmo
         hbc5CRdHfEftb0EH3W8zu4u+GR6Pe2uykRAi1fcFrT/rRqvVIr9gbH8xe800CKstY0Zq
         y78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523957; x=1711128757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aB1DZO1/YVC0bjj1nE+ssniKkXOWA9sPBcm6ECq5hfE=;
        b=Bno0XFiCQjG+D8PR448QcN26VJVecBhj/GNZxHuQeiM1RlS63rXNfDWS26ECSQeG3y
         nuyHEI4a0QER+V0ACuZBQdl7vauuunz4RW2fQ7q6RHR4fVkAL+KfjN/cSASLikZ6/DY9
         kekLUetkCBU9dVnhdqouvA2wyidDOXDSVtCjnqAkG1czxpe7vjijEu1BMBPdcasDzKCz
         B4mhb7KMPGWZAkM/bCqeTxV8c8NSB2zZDfCN1b6/ZKzum78FEKwHJ6zWWUN6Kkv+BhN6
         sEVl8hgw85ytJ5lOnIJTkpbaZYTTYmctjXIaRttzheNSsKf1e1vZ//5DYgVAK+esI5lg
         pTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU5cSgEmP0xpMCUfApX6nhehQ7zyXst06YRNnbjsfXxs6xCXIZA9OrM/DulnnHMgvuHpKu2DWILBEIBWm3HneaTj2UJNxOeOl8HCfL
X-Gm-Message-State: AOJu0YyaWiGPUV8Lemg35+iHaL4sNA5rLoOYGAic4ada5DRgv4oQvEje
	mYMZuKGJEEBXkeLN982DbTTzGOjFY8UqVruJyi/Qz7K4TgQFQSO36lnJe52is7jSMA==
X-Google-Smtp-Source: AGHT+IEofF8plLQoAghdethOGLl782/5CRj5pviO8139HW5mm9bwCbpouUArkHSO25P9UFatCUwhzA==
X-Received: by 2002:a17:906:a291:b0:a46:7e08:37e8 with SMTP id i17-20020a170906a29100b00a467e0837e8mr2329929ejz.53.1710523957450;
        Fri, 15 Mar 2024 10:32:37 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id d10-20020a170906370a00b00a469b71b818sm246687ejc.113.2024.03.15.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:32:37 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: use u32 as bit type in ebitmap code
Date: Fri, 15 Mar 2024 18:32:28 +0100
Message-ID: <20240315173234.637629-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The extensible bitmap supports bit positions up to U32_MAX due to the
type of the member highbit being u32.  Use u32 consistently as the type
for bit positions to announce to callers what range of values is
supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v4:
  - apply format style
  I hope i addressed all comment from [1] in [2].
v3:
  - revert type change of unrelated iter variable
  - use U32_MAX instead of (u32)-1
v2: avoid declarations in init-clauses of for loops

[1]: https://lore.kernel.org/selinux/67cee6245e2895e81a0177c4c1ed01ba.paul@paul-moore.com/
[2]: https://lore.kernel.org/selinux/CAJ2a_DdLR40CB6Ua5cNjYhtexNmGkzQRsVrJn+dhVaZO-aVKsA@mail.gmail.com/

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c | 31 +++++++++++++++-------------
 security/selinux/ss/ebitmap.h | 38 ++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 67c1a73cd5ee..8177f1c3c774 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -21,7 +21,7 @@
 #include "ebitmap.h"
 #include "policydb.h"
 
-#define BITS_PER_U64 (sizeof(u64) * 8)
+#define BITS_PER_U64 ((u32)(sizeof(u64) * 8))
 
 static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
 
@@ -79,7 +79,8 @@ int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
 		const struct ebitmap *e2)
 {
 	struct ebitmap_node *n;
-	int bit, rc;
+	u32 bit;
+	int rc;
 
 	ebitmap_init(dst);
 
@@ -256,7 +257,7 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
 	return 1;
 }
 
-int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
+int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
 {
 	const struct ebitmap_node *n;
 
@@ -273,7 +274,7 @@ int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
 	return 0;
 }
 
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
+int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value)
 {
 	struct ebitmap_node *n, *prev, *new;
 
@@ -284,7 +285,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 			if (value) {
 				ebitmap_node_set_bit(n, bit);
 			} else {
-				unsigned int s;
+				u32 s;
 
 				ebitmap_node_clr_bit(n, bit);
 
@@ -362,12 +363,12 @@ void ebitmap_destroy(struct ebitmap *e)
 int ebitmap_read(struct ebitmap *e, void *fp)
 {
 	struct ebitmap_node *n = NULL;
-	u32 mapunit, count, startbit, index;
+	u32 mapunit, count, startbit, index, i;
 	__le32 ebitmap_start;
 	u64 map;
 	__le64 mapbits;
 	__le32 buf[3];
-	int rc, i;
+	int rc;
 
 	ebitmap_init(e);
 
@@ -381,7 +382,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 	if (mapunit != BITS_PER_U64) {
 		pr_err("SELinux: ebitmap: map size %u does not "
-		       "match my size %zd (high bit was %d)\n",
+		       "match my size %d (high bit was %d)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
 	}
@@ -469,19 +470,20 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 int ebitmap_write(const struct ebitmap *e, void *fp)
 {
 	struct ebitmap_node *n;
-	u32 count;
+	u32 bit, count, last_bit, last_startbit;
 	__le32 buf[3];
 	u64 map;
-	int bit, last_bit, last_startbit, rc;
+	int rc;
 
 	buf[0] = cpu_to_le32(BITS_PER_U64);
 
 	count = 0;
 	last_bit = 0;
-	last_startbit = -1;
+	last_startbit = U32_MAX;
 	ebitmap_for_each_positive_bit(e, n, bit)
 	{
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == U32_MAX ||
+		    rounddown(bit, BITS_PER_U64) > last_startbit) {
 			count++;
 			last_startbit = rounddown(bit, BITS_PER_U64);
 		}
@@ -495,10 +497,11 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
 		return rc;
 
 	map = 0;
-	last_startbit = INT_MIN;
+	last_startbit = U32_MAX;
 	ebitmap_for_each_positive_bit(e, n, bit)
 	{
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == U32_MAX ||
+		    rounddown(bit, BITS_PER_U64) > last_startbit) {
 			__le64 buf64[1];
 
 			/* this is the very first bit */
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 02798b35eecc..24d7d8b3cda3 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -46,10 +46,10 @@ struct ebitmap {
 
 #define ebitmap_length(e) ((e)->highbit)
 
-static inline unsigned int ebitmap_start_positive(const struct ebitmap *e,
-						  struct ebitmap_node **n)
+static inline u32 ebitmap_start_positive(const struct ebitmap *e,
+					 struct ebitmap_node **n)
 {
-	unsigned int ofs;
+	u32 ofs;
 
 	for (*n = e->node; *n; *n = (*n)->next) {
 		ofs = find_first_bit((*n)->maps, EBITMAP_SIZE);
@@ -64,11 +64,10 @@ static inline void ebitmap_init(struct ebitmap *e)
 	memset(e, 0, sizeof(*e));
 }
 
-static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
-						 struct ebitmap_node **n,
-						 unsigned int bit)
+static inline u32 ebitmap_next_positive(const struct ebitmap *e,
+					struct ebitmap_node **n, u32 bit)
 {
-	unsigned int ofs;
+	u32 ofs;
 
 	ofs = find_next_bit((*n)->maps, EBITMAP_SIZE, bit - (*n)->startbit + 1);
 	if (ofs < EBITMAP_SIZE)
@@ -87,11 +86,10 @@ static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
 #define EBITMAP_NODE_OFFSET(node, bit) \
 	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
 
-static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
-				       unsigned int bit)
+static inline int ebitmap_node_get_bit(const struct ebitmap_node *n, u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	if ((n->maps[index] & (EBITMAP_BIT << ofs)))
@@ -99,21 +97,19 @@ static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
 	return 0;
 }
 
-static inline void ebitmap_node_set_bit(struct ebitmap_node *n,
-					unsigned int bit)
+static inline void ebitmap_node_set_bit(struct ebitmap_node *n, u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	n->maps[index] |= (EBITMAP_BIT << ofs);
 }
 
-static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
-					unsigned int bit)
+static inline void ebitmap_node_clr_bit(struct ebitmap_node *n, u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	n->maps[index] &= ~(EBITMAP_BIT << ofs);
@@ -130,8 +126,8 @@ int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
 		const struct ebitmap *e2);
 int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
 		     u32 last_e2bit);
-int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit);
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
+int ebitmap_get_bit(const struct ebitmap *e, u32 bit);
+int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
 int ebitmap_read(struct ebitmap *e, void *fp);
 int ebitmap_write(const struct ebitmap *e, void *fp);
-- 
2.43.0


