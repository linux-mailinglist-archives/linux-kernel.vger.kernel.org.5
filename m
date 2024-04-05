Return-Path: <linux-kernel+bounces-133320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DA89A22B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE421F2198E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692C171649;
	Fri,  5 Apr 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="f9ZzFJwT"
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C3171069;
	Fri,  5 Apr 2024 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333457; cv=none; b=VxGqcTG8icD5it2SvwBiW6eo0jr2i0K5gn5qfde5PhbZ2951d0UMmBGeLcTsYz2NBWJx5aChQADS3xdH5IYgDMQTV557E8cnuwzvNfMeuWI/VaDgnBF1TlWzj+cmTvPAAI5W1bVdLpsvvtoOCc6uKtvKJHRNXCPajoBANxGRQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333457; c=relaxed/simple;
	bh=pyeXNP8Dn44U6reUsX+bt+NCnLFVWyxy9/BJxakUAyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gw8j8Bf4IASxMhOKO0d/17n7wBTtZYyEJh9U7RxiMLppB3ptLh2m7S1bufaF1cIVv9IBt37WKOFgyD+MmbHtkmzAVPkHNtpEV/5A4E5884Y13+t42JMSM1zQSBjb//hmFOw01w5wJMxhLo6PD0ZJ521WpwxcgcyEXC8MGBGhevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=f9ZzFJwT; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712333452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQyBLalbtbb1CgaRVE8raq0QegR3MYJoKoLR6++j15Q=;
	b=f9ZzFJwT0xUgPBqQi2GyzIg2f3B9kGESx9z5gnVpChO3EMDeBMQV1K7lq+TpLlYv4kh4Fl
	RzlD6gdT+G7apv1UnDCtYzxC/Wma7XjzUwRQ4m4MHHClfHsmivQLWjpbDv5w6NkfGBrU/X
	1dgluy5kEaxiJFVA1hNp+5mB5ypPjDq3LrqYDIgPMSQ+DUefdrYH1hSQ6rZZZkCCaZkJEt
	mGeXIHqzENsf4jE/a4Qe3mIYjA85k6uo120bpR+eOzzdCNER16F5BFAQ32LIaWcSxnHYwZ
	XfsrPunxmpJk4MwlQ45RR+jJRbkx64xpNvM9LMbQwP7XKwg/yZGSvGfzogVcHg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selinux: constify source policy in cond_policydb_dup()
Date: Fri,  5 Apr 2024 18:10:12 +0200
Message-ID: <20240405161042.260113-2-cgoettsche@seltendoof.de>
In-Reply-To: <20240405161042.260113-1-cgoettsche@seltendoof.de>
References: <20240405161042.260113-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

cond_policydb_dup() duplicates conditional parts of an existing policy.
Declare the source policy const, since it should not be modified.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 12 ++++++------
 security/selinux/ss/conditional.h |  2 +-
 security/selinux/ss/hashtab.c     |  9 +++++----
 security/selinux/ss/hashtab.h     |  4 ++--
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index e868fc403d75..d53c34021dbe 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -603,7 +603,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 	}
 }
 
-static int cond_dup_av_list(struct cond_av_list *new, struct cond_av_list *orig,
+static int cond_dup_av_list(struct cond_av_list *new, const struct cond_av_list *orig,
 			    struct avtab *avtab)
 {
 	u32 i;
@@ -626,7 +626,7 @@ static int cond_dup_av_list(struct cond_av_list *new, struct cond_av_list *orig,
 }
 
 static int duplicate_policydb_cond_list(struct policydb *newp,
-					struct policydb *origp)
+					const struct policydb *origp)
 {
 	int rc;
 	u32 i;
@@ -643,7 +643,7 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 
 	for (i = 0; i < origp->cond_list_len; i++) {
 		struct cond_node *newn = &newp->cond_list[i];
-		struct cond_node *orign = &origp->cond_list[i];
+		const struct cond_node *orign = &origp->cond_list[i];
 
 		newp->cond_list_len++;
 
@@ -683,7 +683,7 @@ static int cond_bools_destroy(void *key, void *datum, void *args)
 	return 0;
 }
 
-static int cond_bools_copy(struct hashtab_node *new, struct hashtab_node *orig,
+static int cond_bools_copy(struct hashtab_node *new, const struct hashtab_node *orig,
 			   void *args)
 {
 	struct cond_bool_datum *datum;
@@ -710,7 +710,7 @@ static int cond_bools_index(void *key, void *datum, void *args)
 }
 
 static int duplicate_policydb_bools(struct policydb *newdb,
-				    struct policydb *orig)
+				    const struct policydb *orig)
 {
 	struct cond_bool_datum **cond_bool_array;
 	int rc;
@@ -743,7 +743,7 @@ void cond_policydb_destroy_dup(struct policydb *p)
 	cond_policydb_destroy(p);
 }
 
-int cond_policydb_dup(struct policydb *new, struct policydb *orig)
+int cond_policydb_dup(struct policydb *new, const struct policydb *orig)
 {
 	cond_policydb_init(new);
 
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index b972ce40db18..8827715bad75 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -79,6 +79,6 @@ void cond_compute_xperms(struct avtab *ctab, struct avtab_key *key,
 			 struct extended_perms_decision *xpermd);
 void evaluate_cond_nodes(struct policydb *p);
 void cond_policydb_destroy_dup(struct policydb *p);
-int cond_policydb_dup(struct policydb *new, struct policydb *orig);
+int cond_policydb_dup(struct policydb *new, const struct policydb *orig);
 
 #endif /* _CONDITIONAL_H_ */
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 754bedbde133..836642f789ab 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -136,11 +136,12 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 }
 #endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
-int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
+int hashtab_duplicate(struct hashtab *new, const struct hashtab *orig,
 		      int (*copy)(struct hashtab_node *new,
-				  struct hashtab_node *orig, void *args),
+				  const struct hashtab_node *orig, void *args),
 		      int (*destroy)(void *k, void *d, void *args), void *args)
 {
+	const struct hashtab_node *orig_cur;
 	struct hashtab_node *cur, *tmp, *tail;
 	u32 i;
 	int rc;
@@ -155,12 +156,12 @@ int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
 
 	for (i = 0; i < orig->size; i++) {
 		tail = NULL;
-		for (cur = orig->htable[i]; cur; cur = cur->next) {
+		for (orig_cur = orig->htable[i]; orig_cur; orig_cur = orig_cur->next) {
 			tmp = kmem_cache_zalloc(hashtab_node_cachep,
 						GFP_KERNEL);
 			if (!tmp)
 				goto error;
-			rc = copy(tmp, cur, args);
+			rc = copy(tmp, orig_cur, args);
 			if (rc) {
 				kmem_cache_free(hashtab_node_cachep, tmp);
 				goto error;
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 5f74dcc1360f..deba82d78c3a 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -136,9 +136,9 @@ void hashtab_destroy(struct hashtab *h);
 int hashtab_map(struct hashtab *h, int (*apply)(void *k, void *d, void *args),
 		void *args);
 
-int hashtab_duplicate(struct hashtab *new, struct hashtab *orig,
+int hashtab_duplicate(struct hashtab *new, const struct hashtab *orig,
 		      int (*copy)(struct hashtab_node *new,
-				  struct hashtab_node *orig, void *args),
+				  const struct hashtab_node *orig, void *args),
 		      int (*destroy)(void *k, void *d, void *args), void *args);
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
-- 
2.43.0


