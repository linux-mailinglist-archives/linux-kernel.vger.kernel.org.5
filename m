Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC34767130
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbjG1Pzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjG1Pz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBB448E;
        Fri, 28 Jul 2023 08:55:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99b9161b94aso323144966b.1;
        Fri, 28 Jul 2023 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559710; x=1691164510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU6NqYmf75Sa1ZICmlv0pPjToOhjN4w32UwWXbMha+w=;
        b=XyIzLnHZZ0z0nFrbb208piVfGJhxlXNzbRzbdgVXvwjoHky49mFZVlWqz5kCH9WDI2
         IAHeRtVgTir7nHClp+sKIxIbX3UwAThMXYXFjDOvkWxywXa/m/qtndcr04MtKx/VHlT7
         9RaPl0cDb8p5VOJeW/lVFy2utSXX7ufGNH/i3Yt9jxsJxwR33Wwao3t0CAVBaAVS/o+9
         n8ikmOYn9ba/XrXsj3ULaHhwT0V7iVTecUkuYVqUozO6YlysPAqCu1DUSFFcwRg8wqHy
         /9ZGrJ6gc8n1iz4IKf6Ug/Vwjw0amaRV3+0iZvhhPquETT+escBD72TM7OubwCKQcOWf
         Jojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559710; x=1691164510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZU6NqYmf75Sa1ZICmlv0pPjToOhjN4w32UwWXbMha+w=;
        b=ICNKz96/gOwoybfCN/079S8MOjRCIEOfypN1QXQDCefLAl0iObRAjBSU7vWC7NqQel
         D3eO0bQkiFdUbTwKUmEx57VZnnWc9PhUS9HtkDmfWsG93vGEP293l+h4BGcOWha1MQCx
         Ea6CRLDgua9+WMi9Ref8JzvGFflQ5AU3xQRt3w+H2G1BnisMdZYEYrwu8CvQmmW0u8xh
         989CdX0282vpik+cXeJW/USwCjdciuRrSnFSUxgrp+iA08e1Nh1cnSDa08mDziiWfVSn
         1kHp/a+Oda2DiELa80zbaGmODbByaL0Z8QVFQW/KrGcIbZJauwdzSvsbM3ej9zzcIs6g
         ilEg==
X-Gm-Message-State: ABy/qLbgI5k2h/AdI4PLkDlwJlIzUDK7GKqqeXtASjOLvMh75R4e5i+G
        mMyyo5aX+t6fgpcn/WlJbV62mrJeH8247eYj
X-Google-Smtp-Source: APBJJlGSwSAqGlB8bH+TmSJ8To6LJJuqZtKol4H7/VLn19ZerBB4AuS4D2FjJmjCowitON/ZUqzE9g==
X-Received: by 2002:a17:907:2cc8:b0:989:450:e56a with SMTP id hg8-20020a1709072cc800b009890450e56amr2869347ejc.76.1690559709787;
        Fri, 28 Jul 2023 08:55:09 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:09 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] selinux: use u32 as bit type in ebitmap code
Date:   Fri, 28 Jul 2023 17:54:52 +0200
Message-Id: <20230728155501.39632-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/ss/ebitmap.c | 32 ++++++++++++++++----------------
 security/selinux/ss/ebitmap.h | 32 ++++++++++++++++----------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 77875ad355f7..6ab2baf4cfb5 100644
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
 
@@ -113,8 +114,7 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
 {
 	struct ebitmap_node *e_iter = ebmap->node;
 	unsigned long e_map;
-	u32 offset;
-	unsigned int iter;
+	u32 offset, iter;
 	int rc;
 
 	if (e_iter == NULL) {
@@ -259,7 +259,7 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 las
 	return 1;
 }
 
-int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
+int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
 {
 	const struct ebitmap_node *n;
 
@@ -276,7 +276,7 @@ int ebitmap_get_bit(const struct ebitmap *e, unsigned long bit)
 	return 0;
 }
 
-int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
+int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value)
 {
 	struct ebitmap_node *n, *prev, *new;
 
@@ -287,7 +287,7 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 			if (value) {
 				ebitmap_node_set_bit(n, bit);
 			} else {
-				unsigned int s;
+				u32 s;
 
 				ebitmap_node_clr_bit(n, bit);
 
@@ -365,12 +365,12 @@ void ebitmap_destroy(struct ebitmap *e)
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
 
@@ -384,7 +384,7 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 	if (mapunit != BITS_PER_U64) {
 		pr_err("SELinux: ebitmap: map size %u does not "
-		       "match my size %zd (high bit was %d)\n",
+		       "match my size %d (high bit was %d)\n",
 		       mapunit, BITS_PER_U64, e->highbit);
 		goto bad;
 	}
@@ -471,18 +471,18 @@ int ebitmap_read(struct ebitmap *e, void *fp)
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
+	last_startbit = (u32)-1;
 	ebitmap_for_each_positive_bit(e, n, bit) {
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == (u32)-1 || rounddown(bit, BITS_PER_U64) > last_startbit) {
 			count++;
 			last_startbit = rounddown(bit, BITS_PER_U64);
 		}
@@ -496,9 +496,9 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
 		return rc;
 
 	map = 0;
-	last_startbit = INT_MIN;
+	last_startbit = (u32)-1;
 	ebitmap_for_each_positive_bit(e, n, bit) {
-		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
+		if (last_startbit == (u32)-1 || rounddown(bit, BITS_PER_U64) > last_startbit) {
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

