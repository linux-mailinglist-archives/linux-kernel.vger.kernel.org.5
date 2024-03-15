Return-Path: <linux-kernel+bounces-104775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A09387D373
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C81B1C206A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA34F8B2;
	Fri, 15 Mar 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FwNUO8kx"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC474CE1B;
	Fri, 15 Mar 2024 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526465; cv=none; b=P6K0+YUxo6q5xLBebD7MG4RRBUH7W/xGL0ZSwQcLuVjIa/YhkAUFtECaTl03NeRh/Rxqd9JDvn89fzjLjemE1wa3FQtzdq6KLmeOyX88bZLkWFBNBMO5LzjvO5yE+nD9emwbDrGY6dpRyi+aWDRiCHwVK4AXZSUxjBqHhLDvccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526465; c=relaxed/simple;
	bh=9MvyuDrhaotfv+B09py4H758keObr5ydb2VtJa2MuPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOwd0DIYAfv3F3PysUY5eGpd6pFnw4/g+fPWvsq+7wdlIvaWiRgWlDuIzTPmDm+Y8kejiUUXSYhKKqjeYRJzM1/WcoAlvHpTBelV4K85Mnp8i9TU9T7nM3mB0Cc87Qf3X5H7PEpDD4h4vcjLT+H651nFIDYArDlUSnXov2n4Q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FwNUO8kx; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso2838740e87.0;
        Fri, 15 Mar 2024 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710526459; x=1711131259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkDC2yEMoA8aKIWbb14yRjg2ggB/5aRYuGOEZHBpmZY=;
        b=FwNUO8kxELT0PVYOpStNAXEMmPU/k8dbMcyXoQgC91w2KQjmpXLwr6UdWnTN193HkJ
         UvhiswazO/1tcYzFnRty8AAyBBV8+XBHGjMB6Y1bCGO5gdbTJPkPyKkieCVmd4T6ms9K
         taE3fi/5q1jBmQJm2qqmutJ/mh9zDkFwZTuCx/WFyN4FT5tjJUZHA9u8vQr6xyPpk6RC
         vbPPncCAhDKFxswudmWkw9R2ZZbkxXZOlLXSoqRUHb8W2Ib8MuYwVvl6vOKPsJpeNbmd
         pkCYX2/p1Wi/cEJ3WJOGul8JOmVuhSBNdGsVB0CIUhvFHfS4iXg6wGCYL/6CPtNijXG9
         d5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710526459; x=1711131259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkDC2yEMoA8aKIWbb14yRjg2ggB/5aRYuGOEZHBpmZY=;
        b=AqRFMSK5HGLqK/xR5HJtuHSUVlm6vYSJV6PfhGLaUr2eLa9Km8DGYkKof8WCS0Y/uB
         PhgLgc6BD5mNsRrgUppcUXvvoW5/EB99RrAd6rBByJr7rS2ydR9tBeKQDadZrdmWt2e7
         Llrjkplt2Qq5lPVFX8gIRf1D0kpJwO/uem7UlHMymnI1anJ/7h8ygtfKZEDPc874JknS
         H4c68v2y4YV2AH07mjBK+nT0taL+Kjk0XLC13soqUfF9PrZOcZ7xbdZnMcAqpuNIjCI9
         KykZcYZUdgpJc4/EtgZ8yUMggObRjC6zZy8Qct1/5iAvvv+gcf3ZbNBVyrULV/ie2l5J
         SlCg==
X-Forwarded-Encrypted: i=1; AJvYcCXPYVP7WxLyJgsQb76L2QsgLonqLFFGP7fi5HeK2yrPXb0hpFW2PRctBKC/OAdI/zadKaGQDjUFQEkIHFUq0UynvYyQtfd+Gji0ysMq
X-Gm-Message-State: AOJu0Yz9QiyHVxt5RJYOxkCWV2xziXK0FEqJP/rufuuV6hc17/vuHvVt
	5PnWG9Zak5O/gxTVCO6Q65vcrRbV9BD8lapx+Ee3TQkdR+S3X47uLcPVoDWJ4iFVyA==
X-Google-Smtp-Source: AGHT+IGIuF8DT4BuRTsNF75XWJY7LrK3fZ/F9lk3g/712vFhApFrvdmY7Sv/cGViWzJMkNiVQb4f8Q==
X-Received: by 2002:ac2:5b03:0:b0:513:bd72:a677 with SMTP id v3-20020ac25b03000000b00513bd72a677mr3893522lfn.19.1710526459502;
        Fri, 15 Mar 2024 11:14:19 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id u20-20020a1709060b1400b00a449076d0dbsm1915682ejg.53.2024.03.15.11.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:14:19 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] selinux: dump statistics for more hash tables
Date: Fri, 15 Mar 2024 19:14:05 +0100
Message-ID: <20240315181414.649045-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315181414.649045-1-cgzones@googlemail.com>
References: <20240315181414.649045-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dump in the SELinux debug configuration the statistics for the
conditional rules avtab, the role transition, and class and common
permission hash tables.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   print key in hash_eval() for class and common tables
---
 security/selinux/ss/conditional.c |  3 +++
 security/selinux/ss/policydb.c    | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index f12476855b27..e868fc403d75 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -169,6 +169,9 @@ int cond_init_bool_indexes(struct policydb *p)
 		p->p_bools.nprim, sizeof(*p->bool_val_to_struct), GFP_KERNEL);
 	if (!p->bool_val_to_struct)
 		return -ENOMEM;
+
+	avtab_hash_eval(&p->te_cond_avtab, "conditional_rules");
+
 	return 0;
 }
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3d22d5baa829..b0f688fe0737 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -672,14 +672,17 @@ static int (*const index_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 /* clang-format on */
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
-static void hash_eval(struct hashtab *h, const char *hash_name)
+static void hash_eval(struct hashtab *h, const char *hash_name, const char *hash_details)
 {
 	struct hashtab_info info;
 
 	hashtab_stat(h, &info);
 	pr_debug(
-		"SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d, sum of chain length^2 %llu\n",
-		hash_name, h->nel, info.slots_used, h->size, info.max_chain_len,
+		"SELinux: %s%s%s:  %d entries and %d/%d buckets used, longest chain length %d, sum of chain length^2 %llu\n",
+		hash_name,
+		hash_details ? "@" : "",
+		hash_details ?: "",
+		h->nel, info.slots_used, h->size, info.max_chain_len,
 		info.chain2_len_sum);
 }
 
@@ -688,11 +691,11 @@ static void symtab_hash_eval(struct symtab *s)
 	int i;
 
 	for (i = 0; i < SYM_NUM; i++)
-		hash_eval(&s[i].table, symtab_name[i]);
+		hash_eval(&s[i].table, symtab_name[i], NULL);
 }
 
 #else
-static inline void hash_eval(struct hashtab *h, const char *hash_name)
+static inline void hash_eval(struct hashtab *h, const char *hash_name, const char *hash_details)
 {
 }
 static inline void symtab_hash_eval(struct symtab *s)
@@ -1178,6 +1181,8 @@ static int common_read(struct policydb *p, struct symtab *s, void *fp)
 			goto bad;
 	}
 
+	hash_eval(&comdatum->permissions.table, "common_permissions", key);
+
 	rc = symtab_insert(s, key, comdatum);
 	if (rc)
 		goto bad;
@@ -1358,6 +1363,8 @@ static int class_read(struct policydb *p, struct symtab *s, void *fp)
 			goto bad;
 	}
 
+	hash_eval(&cladatum->permissions.table, "class_permissions", key);
+
 	rc = read_cons_helper(p, &cladatum->constraints, ncons, 0, fp);
 	if (rc)
 		goto bad;
@@ -1898,7 +1905,7 @@ static int range_read(struct policydb *p, void *fp)
 		rt = NULL;
 		r = NULL;
 	}
-	hash_eval(&p->range_tr, "rangetr");
+	hash_eval(&p->range_tr, "rangetr", NULL);
 	rc = 0;
 out:
 	kfree(rt);
@@ -2116,7 +2123,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 				return rc;
 		}
 	}
-	hash_eval(&p->filename_trans, "filenametr");
+	hash_eval(&p->filename_trans, "filenametr", NULL);
 	return 0;
 }
 
@@ -2649,6 +2656,8 @@ int policydb_read(struct policydb *p, void *fp)
 		rtd = NULL;
 	}
 
+	hash_eval(&p->role_tr, "roletr", NULL);
+
 	rc = next_entry(buf, fp, sizeof(u32));
 	if (rc)
 		goto bad;
-- 
2.43.0


