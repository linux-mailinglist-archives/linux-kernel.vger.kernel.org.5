Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4576772C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjHGRL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHGRLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:11:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEA2E65;
        Mon,  7 Aug 2023 10:11:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so10095658a12.1;
        Mon, 07 Aug 2023 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691428312; x=1692033112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=91Gmk6Fr/6dr1y5e1Un8IQAei2hCeUpFt2/NafYkIYw=;
        b=UmdcuymnCLwJuzHNUbTxI8x2DZH8VI0wbSoC1PnCKw9INMY8mxAUw4OX8SzyM3mo3T
         MWwMkXlTo6SSo2NVp1c2PLMcvyCcnLvpVk8iLQEmS3ImyJVPhACMuch9oQeCDy/KbaRf
         kwL5+2TjRDM9wf5ykEmNuPN8/33S5Jo99doNZ44TtG/2Ajik5RcC2p/kI0lSTnm34oIg
         WQq+GHqhLb55zH/FXBo8RqS7G1Wg5C94p6ln36ywxWVau2lE5PbLUwXbAo/1944pb81o
         Uta4z76K+lfpqWlazHfYVvJtVDcNv7XoN3bseOaX1DgVHZeFSe7pt0i+Z7CzrbV3A+iF
         6Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428312; x=1692033112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91Gmk6Fr/6dr1y5e1Un8IQAei2hCeUpFt2/NafYkIYw=;
        b=JCeZLw4xmFyxfGNG8ee2YMDc0BPc2hKgd7h6XZrGn04leTowNZoUqd2lC7WM6gIm0j
         XoB6IBQ0Q4Mp52EJCuAE+0fgjfdiqGp+EOGPx9jj4RDUXsbEKB3pMoC0LCkTtaa2N8Bm
         +ievwT47cj+n+xv4IBaeSJH9L32fM4tSZ2aBhYjbAjFXgaRFT2gQc152aA5iS64C0RKR
         OMrRN7iAa1anNUE7e/fkOtm7z/YA0pVHOHWa4MSOJ7oOg56uG2b0OouMQizrGscC2liQ
         3LUioYnoE1/JFe2L+GdhcJUzmFhmHYZ1QUDK/202J2k9rtvszyRJ3fRnKwPcH7tlmWxr
         I1KA==
X-Gm-Message-State: AOJu0YwXMAZLqa1JbmFkh62DXd3qzfh/TGLrO+G2BDEk1XVHFBXd+Fo5
        iNGBKwaMfoviaIsSDjTD2MiVkaWIHnPRig==
X-Google-Smtp-Source: AGHT+IEey/7/3upgc/a1sNyADsdcdevuyABfb61vSNeJxRm6srX7ujgtc/uYWeL7zz4Xx2QRlDE8Tw==
X-Received: by 2002:a05:6402:50cf:b0:51d:b184:efd with SMTP id h15-20020a05640250cf00b0051db1840efdmr8480945edb.20.1691428311476;
        Mon, 07 Aug 2023 10:11:51 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-033-028.95.112.pool.telefonica.de. [95.112.33.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b005224d960e66sm5420814edv.96.2023.08.07.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:11:51 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] selinux: use u32 as bit type in ebitmap code
Date:   Mon,  7 Aug 2023 19:11:36 +0200
Message-Id: <20230807171143.208481-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extensible bitmap supports bit positions up to U32_MAX due to the
type of the member highbit being u32.  Use u32 consistently as the type
for bit positions to announce to callers what range of values is
supported.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - revert type change of unrelated iter variable
  - use U32_MAX instead of (u32)-1
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/ss/ebitmap.c | 29 +++++++++++++++--------------
 security/selinux/ss/ebitmap.h | 32 ++++++++++++++++----------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 77875ad355f7..a313e633aa8e 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -24,7 +24,7 @@
 #include "ebitmap.h"
 #include "policydb.h"
 
-#define BITS_PER_U64	(sizeof(u64) * 8)
+#define BITS_PER_U64	((u32)(sizeof(u64) * 8))
 
 static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
 
@@ -82,7 +82,8 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2)
 {
 	struct ebitmap_node *n;
-	int bit, rc;
+	u32 bit;
+	int rc;
 
 	ebitmap_init(dst);
 
@@ -259,7 +260,7 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 las
 	return 1;
 }
 
-int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
+int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
 {
 	const struct ebitmap_node *n;
 
@@ -276,7 +277,7 @@ int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
 	return 0;
 }
 
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
+int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value)
 {
 	struct ebitmap_node *n, *prev, *new;
 
@@ -287,7 +288,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 			if (value) {
 				ebitmap_node_set_bit(n, bit);
 			} else {
-				unsigned int s;
+				u32 s;
 
 				ebitmap_node_clr_bit(n, bit);
 
@@ -365,12 +366,12 @@ void ebitmap_destroy(struct ebitmap *e)
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
 
@@ -384,7 +385,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 	if (mapunit != BITS_PER_U64) {
 		pr_err("SELinux: ebitmap: map size %u does not "
-		       "match my size %zd (high bit was %d)\n",
+		       "match my size %d (high bit was %d)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
 	}
@@ -471,18 +472,18 @@ int ebitmap_read(struct ebitmap *e, void *fp)
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
 	ebitmap_for_each_positive_bit(e, n, bit) {
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == U32_MAX || rounddown(bit, BITS_PER_U64) > last_startbit) {
 			count++;
 			last_startbit = rounddown(bit, BITS_PER_U64);
 		}
@@ -496,9 +497,9 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
 		return rc;
 
 	map = 0;
-	last_startbit = INT_MIN;
+	last_startbit = U32_MAX;
 	ebitmap_for_each_positive_bit(e, n, bit) {
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == U32_MAX || rounddown(bit, BITS_PER_U64) > last_startbit) {
 			__le64 buf64[1];
 
 			/* this is the very first bit */
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index e3c807cfad90..43c32077d483 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -44,10 +44,10 @@ struct ebitmap {
 
 #define ebitmap_length(e) ((e)->highbit)
 
-static inline unsigned int ebitmap_start_positive(const struct ebitmap *e,
+static inline u32 ebitmap_start_positive(const struct ebitmap *e,
 						  struct ebitmap_node **n)
 {
-	unsigned int ofs;
+	u32 ofs;
 
 	for (*n = e->node; *n; *n = (*n)->next) {
 		ofs = find_first_bit((*n)->maps, EBITMAP_SIZE);
@@ -62,11 +62,11 @@ static inline void ebitmap_init(struct ebitmap *e)
 	memset(e, 0, sizeof(*e));
 }
 
-static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
+static inline u32 ebitmap_next_positive(const struct ebitmap *e,
 						 struct ebitmap_node **n,
-						 unsigned int bit)
+						 u32 bit)
 {
-	unsigned int ofs;
+	u32 ofs;
 
 	ofs = find_next_bit((*n)->maps, EBITMAP_SIZE, bit - (*n)->startbit + 1);
 	if (ofs < EBITMAP_SIZE)
@@ -86,10 +86,10 @@ static inline unsigned int ebitmap_next_positive(const struct ebitmap *e,
 	(((bit) - (node)->startbit) % EBITMAP_UNIT_SIZE)
 
 static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
-				       unsigned int bit)
+				       u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	if ((n->maps[index] & (EBITMAP_BIT << ofs)))
@@ -98,20 +98,20 @@ static inline int ebitmap_node_get_bit(const struct ebitmap_node *n,
 }
 
 static inline void ebitmap_node_set_bit(struct ebitmap_node *n,
-					unsigned int bit)
+					u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	n->maps[index] |= (EBITMAP_BIT << ofs);
 }
 
 static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
-					unsigned int bit)
+					u32 bit)
 {
-	unsigned int index = EBITMAP_NODE_INDEX(n, bit);
-	unsigned int ofs = EBITMAP_NODE_OFFSET(n, bit);
+	u32 index = EBITMAP_NODE_INDEX(n, bit);
+	u32 ofs = EBITMAP_NODE_OFFSET(n, bit);
 
 	BUG_ON(index >= EBITMAP_UNIT_NUMS);
 	n->maps[index] &= ~(EBITMAP_BIT << ofs);
@@ -126,8 +126,8 @@ int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src);
 int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2);
 int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 last_e2bit);
-int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit);
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
+int ebitmap_get_bit(const struct ebitmap *e, u32 bit);
+int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
 int ebitmap_read(struct ebitmap *e, void *fp);
 int ebitmap_write(const struct ebitmap *e, void *fp);
-- 
2.40.1

