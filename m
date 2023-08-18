Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA20780ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378060AbjHRPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378106AbjHRPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:12:50 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197864691;
        Fri, 18 Aug 2023 08:12:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so17195911fa.1;
        Fri, 18 Aug 2023 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692371556; x=1692976356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nrjf0t8/+tWorDt5ATsu0uwkTQCJ3AKC0mV+zReeAks=;
        b=C6aXLHqXPydc67rzEejZehoy1UgVUKujAoxb7mHuAy8TuIaaqkLYGDAl6/SlUrlZVv
         F+6Ki8z5pVgTaj0GdcVBVcbpY87iVFlePwbYTyLRpYo160fag1pAYHbfaLzPwQVOMJBO
         QUMzXK8GFLBlFIzmAeTGz6lEB6jaTI3cAriCxIHy0L9eBjkEmohn2DfsDu0R/FBTSSOa
         8B8TllObHGwdhg7+XYA3nIieg1sp1aUqxz9Q5YW97WmDs3AlDhxzqnZgJ4+aQU57OOow
         /awE7TPAUhMEOSsoAjhhKssoyFX+N9fLEZ6j0NaIR6PCPhAsNfAIew19EVomv0oGuLPn
         m6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371556; x=1692976356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nrjf0t8/+tWorDt5ATsu0uwkTQCJ3AKC0mV+zReeAks=;
        b=XbjcK64PmaTW+TCxTMmOBGVwdKIg+RRoDdqxagWmIfuRCQitLIjRdUlYDwFotK/MuX
         xdnX666dAexY37/PDcx/RQMaLk2Jd48NZWujotjEovMZzFYXLsN1H0DqYQbonUkgDvNA
         V/Je1MobAZDmThzkZse9cPz5RS+hr/oqicSBh8qdy3spaRHI+Oh8fzgqsLJuXQMiN2oB
         K2SzV66InoDrnhgGQTlzMVj9GuweYyxXadsMcgeK36ct7lBlwv0XpWZnEsB0jg+untqz
         2hIHp04GnK+BL+TXWkMBZZw0juRqNegwp9M0EfpKabUAEeD2qom0N8ByX+cVYTGd1TLX
         Es9Q==
X-Gm-Message-State: AOJu0Yy7L3/aAZiPjdHxsu7+v0emM6v0+wLZTOjh+WCPGVhFksU80cG3
        AJiaYg6e2ic2+YdpdwjNL674akD8051txQ==
X-Google-Smtp-Source: AGHT+IF5HJOYkcnwtOi2QbJfJiI7iE60S+GXRtNvGBLqt7zvaC2ojE2nlEQhzztp7oyjFgI5oWaYIw==
X-Received: by 2002:a2e:9283:0:b0:2b6:d603:7667 with SMTP id d3-20020a2e9283000000b002b6d6037667mr1793342ljh.8.1692371555528;
        Fri, 18 Aug 2023 08:12:35 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-116-071-217.95.116.pool.telefonica.de. [95.116.71.217])
        by smtp.gmail.com with ESMTPSA id sa19-20020a170906edb300b0099ca4f61a8bsm1285913ejb.92.2023.08.18.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:12:35 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] selinux: print sum of chain lengths^2 for hash tables
Date:   Fri, 18 Aug 2023 17:12:18 +0200
Message-Id: <20230818151220.166215-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818151220.166215-1-cgzones@googlemail.com>
References: <20230818151220.166215-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the sum of chain lengths squared as a metric for hash tables to
provide more insights, similar to avtabs.

While on it add a comma in the avtab message to improve readability of
the output.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c    | 2 +-
 security/selinux/ss/hashtab.c  | 5 +++++
 security/selinux/ss/hashtab.h  | 1 +
 security/selinux/ss/policydb.c | 4 ++--
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 86d98a8e291b..955cfe495606 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -349,7 +349,7 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
 	}
 
 	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d sum of chain length^2 %llu\n",
+	       "longest chain length %d, sum of chain length^2 %llu\n",
 	       tag, h->nel, slots_used, h->nslot, max_chain_len,
 	       chain2_len_sum);
 }
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index ac5cdddfbf78..c05d8346a94a 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -107,10 +107,12 @@ int hashtab_map(struct hashtab *h,
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
 	u32 i, chain_len, slots_used, max_chain_len;
+	u64 chain2_len_sum;
 	struct hashtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
+	chain2_len_sum = 0;
 	for (i = 0; i < h->size; i++) {
 		cur = h->htable[i];
 		if (cur) {
@@ -123,11 +125,14 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
+
+			chain2_len_sum += (u64)chain_len * chain_len;
 		}
 	}
 
 	info->slots_used = slots_used;
 	info->max_chain_len = max_chain_len;
+	info->chain2_len_sum = chain2_len_sum;
 }
 #endif /* CONFIG_SECURITY_SELINUX_DEBUG */
 
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index f9713b56d3d0..09b0a3744937 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -38,6 +38,7 @@ struct hashtab {
 struct hashtab_info {
 	u32 slots_used;
 	u32 max_chain_len;
+	u64 chain2_len_sum;
 };
 
 /*
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 28bd75dc6f71..84f02d4f8093 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -684,9 +684,9 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
 	struct hashtab_info info;
 
 	hashtab_stat(h, &info);
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d\n",
+	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d, sum of chain length^2 %llu\n",
 		 hash_name, h->nel, info.slots_used, h->size,
-		 info.max_chain_len);
+		 info.max_chain_len, info.chain2_len_sum);
 }
 
 static void symtab_hash_eval(struct symtab *s)
-- 
2.40.1

