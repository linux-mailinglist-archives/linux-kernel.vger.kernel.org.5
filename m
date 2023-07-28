Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3FA76713E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjG1P4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjG1Pzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6E4234;
        Fri, 28 Jul 2023 08:55:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99b9161b94aso323167466b.1;
        Fri, 28 Jul 2023 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559721; x=1691164521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM73crZF1OwWubA/9TVH96k0bOHmyZqLxxUUVrKWtrg=;
        b=Kxm0yG8GrQIAOwdCghPWFu9NE7HCyOp2/7S3KYraAgWsVamTJTs8yrb6UmSC4Y+3eL
         QciifPH+BKENmagZUkl8AJSqhlGp9C+Ub2xjyP+0BywPWPFD8c3rJFvzsdQK82DeIvVf
         lyZjgZqTEYlrhtdXdEIV7HiXZBFnH6cId6EBCmgxqPupNt7SJ4ADRX13UAKyrwijDtc6
         8p8ecUECJOlnbnLTog1hXCH2gAN4wGNx554OsvbmOyaFRZAi6pR+mtUeT4TqK7nYctFS
         dBQDaWQ6IqpLMExlWDZqsaQ1VeSHhZSB3o2VmnIyA/DFPaaDQUPQBjSiGUWnHN4LV1l5
         M3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559721; x=1691164521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM73crZF1OwWubA/9TVH96k0bOHmyZqLxxUUVrKWtrg=;
        b=PDnAaynW8c/PStL4trfXb3DFizvEgGSKkLyUHuojAtTePuQ1ysfph4qe2mRYPgzFlI
         ase6Cd4BZ2X7KU80fYGk3S2aTNTGC2u7dHqwWpfO7iqrzf/iTIYrj90ML8+4CN8hIXOE
         /TlOHBk97gQZEBHgeXBDWOCj3RB4ibtlfJ95b7W3CqU9x9R3sSIKF0hhYPoV/gy2jp1E
         As40Oql53RO+I3LPj0dM0+0q7AfNsifojbsCdUeFJnw17Cyc1+cnMd+ll77+2Btw7nYr
         YwhkMqWKLGayKX1DmbV41xDoJv0l/vr/Q73/WKkhaOISf9P/Xn8/hLLTZAwPLb6dDFh7
         q07Q==
X-Gm-Message-State: ABy/qLY28UdnqOdA8HPOblkS4bPOO94ER+G0IMbF32n3Zza/ibPsmG/u
        0EGJUnkwAHmWxh/+UHKMvitgcq0xKHsBh+Cg
X-Google-Smtp-Source: APBJJlESa5evvEJRFFeV2ks7O4w0ExpJTYfJxKKyTDsNwdPrFIOUeCQ4bhmSB8WPLtir7HHwcWmecA==
X-Received: by 2002:a17:906:30c2:b0:982:ab8d:1e08 with SMTP id b2-20020a17090630c200b00982ab8d1e08mr2809259ejb.59.1690559721187;
        Fri, 28 Jul 2023 08:55:21 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:20 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] selinux: avoid implicit conversions in avtab code
Date:   Fri, 28 Jul 2023 17:55:00 +0200
Message-Id: <20230728155501.39632-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728155501.39632-1-cgzones@googlemail.com>
References: <20230728155501.39632-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return u32 from avtab_hash() instead of int, since the hashing is done
on u32 and the result is used as an index on the hash array.

Use the type of the limit in for loops.

Avoid signed to unsigned conversion of multiplication result in
avtab_hash_eval().

Use unsigned loop iterator for index operations, to avoid sign
extension.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: avoid declarations in init-clauses of for loops
---
 security/selinux/ss/avtab.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 32f92da00b0e..8a508018e696 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -29,7 +29,7 @@ static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
-static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
+static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 {
 	static const u32 c1 = 0xcc9e2d51;
 	static const u32 c2 = 0x1b873593;
@@ -66,7 +66,7 @@ static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
 }
 
 static struct avtab_node*
-avtab_insert_node(struct avtab *h, int hvalue,
+avtab_insert_node(struct avtab *h, u32 hvalue,
 		  struct avtab_node *prev,
 		  const struct avtab_key *key, const struct avtab_datum *datum)
 {
@@ -106,7 +106,7 @@ avtab_insert_node(struct avtab *h, int hvalue,
 static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			const struct avtab_datum *datum)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -152,7 +152,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 					  const struct avtab_key *key,
 					  const struct avtab_datum *datum)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -186,7 +186,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -246,7 +246,7 @@ avtab_search_node_next(struct avtab_node *node, u16 specified)
 
 void avtab_destroy(struct avtab *h)
 {
-	int i;
+	u32 i;
 	struct avtab_node *cur, *temp;
 
 	if (!h)
@@ -324,7 +324,8 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 
 void avtab_hash_eval(struct avtab *h, const char *tag)
 {
-	int i, chain_len, slots_used, max_chain_len;
+	u32 i;
+	unsigned int chain_len, slots_used, max_chain_len;
 	unsigned long long chain2_len_sum;
 	struct avtab_node *cur;
 
@@ -372,13 +373,13 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 {
 	__le16 buf16[4];
 	u16 enabled;
-	u32 items, items2, val, vers = pol->policyvers;
+	u32 items, items2, val, i;
 	struct avtab_key key;
 	struct avtab_datum datum;
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
-	int i, rc;
-	unsigned set;
+	int rc;
+	unsigned int set, vers = pol->policyvers;
 
 	memset(&key, 0, sizeof(struct avtab_key));
 	memset(&datum, 0, sizeof(struct avtab_datum));
@@ -614,7 +615,7 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 
 int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 {
-	unsigned int i;
+	u32 i;
 	int rc = 0;
 	struct avtab_node *cur;
 	__le32 buf[1];
-- 
2.40.1

