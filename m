Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC376713F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbjG1P4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjG1Pzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:55:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F84217;
        Fri, 28 Jul 2023 08:55:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9891c73e0fbso472497366b.1;
        Fri, 28 Jul 2023 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690559719; x=1691164519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOGEYVtk8nHyb4KSy2DKIRjavcN6aII04qx0UqqEHEg=;
        b=AFKxVvGAacA9Uj0sNWD5uRw7AnuN/Ql60mpTgHsjufEQz85PR9ABFJRd4niLRDMKD2
         nXp2yHls91XYsyFcJGerm5MnsFXyLq5bdlLr87evelkOXMD4L98p8d3l7F/jxByqzkPS
         sr335/2G9RjfWenHx0pr1tpvQKphxZHhrVJSryZOgbcHyTUNkTaSv7WtELfn7OBcpQJu
         rRqUVsdWCLa1LnJ29t0bQ8vk6Ozj7Uz6ukQKIJH2r0wAc6mmoK1isoQnn2Oy9sS58Aa1
         0Ivg1fDEjCA7yJh/qepU+hSo3+KHvLywOcyhXoDf9hBEGjuXzqEA/5FUmEGqPnKDleGG
         5JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559719; x=1691164519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOGEYVtk8nHyb4KSy2DKIRjavcN6aII04qx0UqqEHEg=;
        b=VNOH3hKy2EFclMh4p89+RlJUoOOgm51VaR6iwa+naoJfu08G0JSsSmOGVAp439BfCc
         7LWhmJz/oWZgo7IklHvv6zZZd7xKn6AlPWGzGxstv8r+oEm8HXjOAaLdS278hY2wUlHb
         MLDOr9PfnzUyjavnElB5HWpVLXb4IgTIY+Lf9N/Le0BlT0O0oWdy6muev2tfjoc8O7bC
         KxH4ewt/7gHUv6dso+NetY10MS/9Jwvk+P5eUu4s4kIg6zpuzAGuUy7DmnKRk10uXXug
         ZO5wYKI/AYD+SSu/n2+CqAjZPGTmI/rFvxtTWrWJGGXIWJj0VgK8Gbl9f0x7oALOQ1TF
         H+Qw==
X-Gm-Message-State: ABy/qLZbKeMuV506Gq3aOlTQJIsTKUgUdlkx+KLdq77RsZIELxUt8IqN
        xYUuuG4GIvMQO6iXIwJCtXVZgfLWNx+hqOeC
X-Google-Smtp-Source: APBJJlH0nXMLUHqUYquNmtGpYiTbbQAtqDJDbfBvwM82Ib0MrztcYLRHLUVsrQqAlzZMCkhPB0tSfA==
X-Received: by 2002:a17:907:7f89:b0:993:e85c:4ad6 with SMTP id qk9-20020a1709077f8900b00993e85c4ad6mr7142391ejc.7.1690559718975;
        Fri, 28 Jul 2023 08:55:18 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-157-016.77.0.pool.telefonica.de. [77.0.157.16])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709064dc500b0098669cc16b2sm2198345ejw.83.2023.07.28.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:55:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] selinux: policydb: implicit conversions
Date:   Fri, 28 Jul 2023 17:54:58 +0200
Message-Id: <20230728155501.39632-7-cgzones@googlemail.com>
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

Use the identical type for local variables, e.g. loop counters.

Declare members of struct policydb_compat_info unsigned to consistently
use unsigned iterators.  They hold read-only non-negative numbers in the
global variable policydb_compat.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - avoid declarations in init-clauses of for loops
  - declare members of struct policydb_compat_info unsigned
---
 security/selinux/ss/policydb.c | 93 +++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 35 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index dc66868ff62c..aa2371a422af 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -55,9 +55,9 @@ static const char *const symtab_name[SYM_NUM] = {
 #endif
 
 struct policydb_compat_info {
-	int version;
-	int sym_num;
-	int ocon_num;
+	unsigned int version;
+	unsigned int sym_num;
+	unsigned int ocon_num;
 };
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
@@ -159,9 +159,9 @@ static const struct policydb_compat_info policydb_compat[] = {
 	},
 };
 
-static const struct policydb_compat_info *policydb_lookup_compat(int version)
+static const struct policydb_compat_info *policydb_lookup_compat(unsigned int version)
 {
-	int i;
+	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(policydb_compat); i++) {
 		if (policydb_compat[i].version == version)
@@ -359,7 +359,7 @@ static int role_tr_destroy(void *key, void *datum, void *p)
 	return 0;
 }
 
-static void ocontext_destroy(struct ocontext *c, int i)
+static void ocontext_destroy(struct ocontext *c, u32 i)
 {
 	if (!c)
 		return;
@@ -781,7 +781,7 @@ void policydb_destroy(struct policydb *p)
 {
 	struct ocontext *c, *ctmp;
 	struct genfs *g, *gtmp;
-	int i;
+	u32 i;
 	struct role_allow *ra, *lra = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
@@ -1154,8 +1154,8 @@ static int common_read(struct policydb *p, struct symtab *s, void *fp)
 	char *key = NULL;
 	struct common_datum *comdatum;
 	__le32 buf[4];
-	u32 len, nel;
-	int i, rc;
+	u32 i, len, nel;
+	int rc;
 
 	comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
 	if (!comdatum)
@@ -1220,13 +1220,13 @@ static int type_set_read(struct type_set *t, void *fp)
 
 static int read_cons_helper(struct policydb *p,
 				struct constraint_node **nodep,
-				int ncons, int allowxtarget, void *fp)
+				u32 ncons, int allowxtarget, void *fp)
 {
 	struct constraint_node *c, *lc;
 	struct constraint_expr *e, *le;
 	__le32 buf[3];
-	u32 nexpr;
-	int rc, i, j, depth;
+	u32 i, j, nexpr;
+	int rc, depth;
 
 	lc = NULL;
 	for (i = 0; i < ncons; i++) {
@@ -1318,8 +1318,8 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 len, len2, ncons, nel;
-	int i, rc;
+	u32 i, len, len2, ncons, nel;
+	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
 	if (!cladatum)
@@ -1412,7 +1412,8 @@ static int role_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
-	int rc, to_read = 2;
+	int rc;
+	unsigned int to_read = 2;
 	__le32 buf[3];
 	u32 len;
 
@@ -1468,7 +1469,8 @@ static int type_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
-	int rc, to_read = 3;
+	int rc;
+	unsigned int to_read = 3;
 	__le32 buf[4];
 	u32 len;
 
@@ -1542,7 +1544,8 @@ static int user_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
-	int rc, to_read = 2;
+	int rc;
+	unsigned int to_read = 2;
 	__le32 buf[3];
 	u32 len;
 
@@ -1683,7 +1686,7 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 	upper = user = datum;
 	while (upper->bounds) {
 		struct ebitmap_node *node;
-		unsigned long bit;
+		u32 bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: user %s: "
@@ -1719,7 +1722,7 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 	upper = role = datum;
 	while (upper->bounds) {
 		struct ebitmap_node *node;
-		unsigned long bit;
+		u32 bit;
 
 		if (++depth == POLICYDB_BOUNDS_MAXDEPTH) {
 			pr_err("SELinux: role %s: "
@@ -1834,9 +1837,9 @@ static int range_read(struct policydb *p, void *fp)
 {
 	struct range_trans *rt = NULL;
 	struct mls_range *r = NULL;
-	int i, rc;
+	int rc;
 	__le32 buf[2];
-	u32 nel;
+	u32 i, nel;
 
 	if (p->policyvers < POLICYDB_VERSION_MLS)
 		return 0;
@@ -2082,9 +2085,9 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 
 static int filename_trans_read(struct policydb *p, void *fp)
 {
-	u32 nel;
+	u32 nel, i;
 	__le32 buf[1];
-	int rc, i;
+	int rc;
 
 	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
 		return 0;
@@ -2123,8 +2126,8 @@ static int filename_trans_read(struct policydb *p, void *fp)
 
 static int genfs_read(struct policydb *p, void *fp)
 {
-	int i, j, rc;
-	u32 nel, nel2, len, len2;
+	int rc;
+	u32 i, j, nel, nel2, len, len2;
 	__le32 buf[1];
 	struct ocontext *l, *c;
 	struct ocontext *newc = NULL;
@@ -2237,8 +2240,9 @@ static int genfs_read(struct policydb *p, void *fp)
 static int ocontext_read(struct policydb *p, const struct policydb_compat_info *info,
 			 void *fp)
 {
-	int i, j, rc;
-	u32 nel, len;
+	int rc;
+	unsigned int i;
+	u32 j, nel, len, val;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
@@ -2299,9 +2303,27 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 				rc = next_entry(buf, fp, sizeof(u32)*3);
 				if (rc)
 					goto out;
-				c->u.port.protocol = le32_to_cpu(buf[0]);
-				c->u.port.low_port = le32_to_cpu(buf[1]);
-				c->u.port.high_port = le32_to_cpu(buf[2]);
+
+				rc = -EINVAL;
+
+				val = le32_to_cpu(buf[0]);
+				if (val > U8_MAX)
+					goto out;
+				c->u.port.protocol = val;
+
+				val = le32_to_cpu(buf[1]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.low_port = val;
+
+				val = le32_to_cpu(buf[2]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.high_port = val;
+
+				if (c->u.port.low_port > c->u.port.high_port)
+					goto out;
+
 				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
 					goto out;
@@ -2429,9 +2451,9 @@ int policydb_read(struct policydb *p, void *fp)
 	struct role_allow *ra, *lra;
 	struct role_trans_key *rtk = NULL;
 	struct role_trans_datum *rtd = NULL;
-	int i, j, rc;
+	int rc;
 	__le32 buf[4];
-	u32 len, nprim, nel, perm;
+	u32 i, j, len, nprim, nel, perm;
 
 	char *policydb_str;
 	const struct policydb_compat_info *info;
@@ -3282,7 +3304,8 @@ static int (*const write_f[SYM_NUM]) (void *key, void *datum, void *datap) = {
 static int ocontext_write(struct policydb *p, const struct policydb_compat_info *info,
 			  void *fp)
 {
-	unsigned int i, j, rc;
+	unsigned int i, j;
+	int rc;
 	size_t nel, len;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
@@ -3631,10 +3654,10 @@ static int filename_trans_write(struct policydb *p, void *fp)
  */
 int policydb_write(struct policydb *p, void *fp)
 {
-	unsigned int i, num_syms;
 	int rc;
+	unsigned int num_syms;
 	__le32 buf[4];
-	u32 config;
+	u32 config, i;
 	size_t len;
 	const struct policydb_compat_info *info;
 
-- 
2.40.1

