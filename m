Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6595E78050C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357830AbjHREN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357827AbjHRENl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:13:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45213A88
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:13:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bdf98a6086so4305405ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692332019; x=1692936819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tB1YHaTy1So/cjzg3UiXKIfWPl/PBY+zwZUNHuqRe4=;
        b=JYdaqPMi1eUdBHQt9bwCG0AIKktXNS14f7D/+r1U7CuS7VLwR9a3hSqy6/veq/1V4a
         vXp/C9HuwUJ3oluxsYQQ84B1ASGjP4xOAJitOHH3KcK3crfPB0Vx2plrgmHY0RDlTGeM
         Bd2rj3xCobLtEn+zoTAYOmwds75cSKsSYcQpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692332019; x=1692936819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tB1YHaTy1So/cjzg3UiXKIfWPl/PBY+zwZUNHuqRe4=;
        b=ALczBPdmCqFHcexk3N9A/putjI/gIs/1XcSacQtkxvoGRk0u0NCGCRGOS4Mc9l9dT9
         KJuTBoCeweQUPkMAyl0YA73/Ti23MDhETFv/hMazFc35kFK2f7IcKKJfPzDdkVLUyGUd
         RH1xa4hCsVDXZt/ipfzxJZkMbBS9tlo9auc+73+S+PKtB4Hw3O1SkxabHMbz/UKqcAoY
         Rbr8YBFVvJrxuo/4lbkLH+0cOSq+0Q1ArUEqii2D5Dn1X3xbl+eVakI5Cvyw/qni7NC8
         oc/HH0LW2tUgqrEUSMqeAQKVzvhJywmHr1mOl1p7O4/V7AC9P4dIkLHsg1CYHMcXps4k
         h8CA==
X-Gm-Message-State: AOJu0YyKh9PkcdWe/auaj1ETSOtIB84U7XUZG//CInC9DXrptL51Rxko
        ltS3VqJE6pkhzRdFp3AtLIKVCw==
X-Google-Smtp-Source: AGHT+IFxH82CkFvT+1hXgK+2cf7RYUKvmPhKaqZWM6WLpgmTG+eMeF3gjj96O+pbWBk0AvbGHhw9Vg==
X-Received: by 2002:a17:902:d507:b0:1bf:1367:b7fb with SMTP id b7-20020a170902d50700b001bf1367b7fbmr1675438plg.46.1692332018907;
        Thu, 17 Aug 2023 21:13:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b001bb28b9a40dsm590278ple.11.2023.08.17.21.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 21:13:38 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Hui Su <sh_def@163.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nsproxy: Convert nsproxy.count to refcount_t
Date:   Thu, 17 Aug 2023 21:13:32 -0700
Message-Id: <20230818041327.gonna.210-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3476; i=keescook@chromium.org;
 h=from:subject:message-id; bh=f0QChk47Rtin8gsMQWXf4qSTKj6ORa8mH58ivbPyA30=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3u/rEmylTRGXRkcsk/K/1slbIwmO+nifJji8H
 AvFA2khNDuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN7v6wAKCRCJcvTf3G3A
 JoIjD/0XYS/u3kjCYvfQFCGBi/vT/ynh7VhzZHnTK+hbjib7+FnO5ZB0fstlaX2YftwE5sZToX+
 J2fzuZt6zx4N0sZduBUlz0O5hVUI7x3Kx+gnn1uucHsYIl4DNN0xSKUj4GsBtG7f0ZAerE+usCi
 RG1BiNDGhk8InAefL7zdREdja/uucI5zs3o9DMYwLBniDUqpsIumePyCDARtJ0xNZ053dbCe/i5
 7mapm1TPsbJjyZlld88TaRld68f1M1KFqAyQ9zdk6iznMNohSvIxlemxZSrOPW2PUKKKFumo+bA
 LXSNRL8fkw4pBgFRb8x81WE7XOYUsOn8FzMlqZD+UP+3fl41doZL/TROLWbSeaxPke7Bi6mB9WZ
 K+JFvByeUMrQID/FlqtS0PXAxtvwIdKfm4NaTaxrNXh1Cedk4Wa54d9u5I8hcVUSszESAvG9kWA
 XsDQUsEp6kIKNxMcYi/WvJ2AKtwRNrQhSpRg7OebhYxDbeltdCG5hgpG2FQMgXFnfrQzrBCxbQN
 ey7IfVr2d1jGKe4cDBwhmsV6hjF3yc10mBC9l91VKeWOsTpqR8NZl6fVylneeNERHo1G8GxrTZW
 J2UwgKOgmQPZ76sIrxvIg9ZKYjGH/CK8Qw0LAHwXdvFEw0KyKNf+CFusU5NFHgy+V50lH3cmgF3
 Hw3sGVC evuO2h6g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elena Reshetova <elena.reshetova@intel.com>

atomic_t variables are currently used to implement reference counters
with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows and
underflows. This is important since overflows and underflows can lead
to use-after-free situation and be exploitable.

The variable nsproxy.count is used as pure reference counter. Convert it
to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in refcount.h have different
memory ordering guarantees than their atomic counterparts. Please check
Documentation/core-api/refcount-vs-atomic.rst for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in some
rare cases it might matter. Please double check that you don't have
some undocumented memory guarantees for this variable usage.

For the nsproxy.count it might make a difference in following places:
 - put_nsproxy() and switch_task_namespaces(): decrement in
   refcount_dec_and_test() only provides RELEASE ordering and ACQUIRE
   ordering on success vs. fully ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: rebase
v1: https://lore.kernel.org/lkml/20200612183450.4189588-2-keescook@chromium.org/
---
 include/linux/nsproxy.h | 7 +++----
 kernel/nsproxy.c        | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index fee881cded01..771cb0285872 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -29,7 +29,7 @@ struct fs_struct;
  * nsproxy is copied.
  */
 struct nsproxy {
-	atomic_t count;
+	refcount_t count;
 	struct uts_namespace *uts_ns;
 	struct ipc_namespace *ipc_ns;
 	struct mnt_namespace *mnt_ns;
@@ -102,14 +102,13 @@ int __init nsproxy_cache_init(void);
 
 static inline void put_nsproxy(struct nsproxy *ns)
 {
-	if (atomic_dec_and_test(&ns->count)) {
+	if (refcount_dec_and_test(&ns->count))
 		free_nsproxy(ns);
-	}
 }
 
 static inline void get_nsproxy(struct nsproxy *ns)
 {
-	atomic_inc(&ns->count);
+	refcount_inc(&ns->count);
 }
 
 #endif
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 80d9c6d77a45..15781acaac1c 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -30,7 +30,7 @@
 static struct kmem_cache *nsproxy_cachep;
 
 struct nsproxy init_nsproxy = {
-	.count			= ATOMIC_INIT(1),
+	.count			= REFCOUNT_INIT(1),
 	.uts_ns			= &init_uts_ns,
 #if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
 	.ipc_ns			= &init_ipc_ns,
@@ -55,7 +55,7 @@ static inline struct nsproxy *create_nsproxy(void)
 
 	nsproxy = kmem_cache_alloc(nsproxy_cachep, GFP_KERNEL);
 	if (nsproxy)
-		atomic_set(&nsproxy->count, 1);
+		refcount_set(&nsproxy->count, 1);
 	return nsproxy;
 }
 
-- 
2.34.1

