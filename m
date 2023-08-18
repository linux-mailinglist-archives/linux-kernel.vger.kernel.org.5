Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857178050D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357835AbjHREPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357877AbjHREPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:15:01 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59F03A80
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:14:59 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a44cccbd96so328811b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692332099; x=1692936899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sa0CJzut32GSCNcJ2v2UxYj/DVDXPVQpqU7jIS5wbQ=;
        b=nd3HSr8OuEvzV5DBrs3TdWzSZ2kjlApZGFczJAMgqnMCpg+J8heJ8vlxdN3gkUo6Qy
         dLhYjltMQNGDtRMRF8ypGM9NfPYq22mgjn8yRwS2EL4uo0iVGYtzoQv7OQybDVuaMLgl
         Q1pKbHEucPTozYh7a3MZKlZ5hzb06B4gDfWbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692332099; x=1692936899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sa0CJzut32GSCNcJ2v2UxYj/DVDXPVQpqU7jIS5wbQ=;
        b=lDw8Qjma9ZMOdXl2CZ0/coBnUSMxraDeyfsNACXYj29FQ7feAeeCMTQ6b3+0szFu/y
         KZoffSZHrDV1WbBTMqQU0UKhPRL0e9y8sSB7cR3EpL/b41nLv4X9lnncTSJ/vCuyftuA
         4rzfoP77gtohUHl5Vh+/FV4KIX1R3va/lg8FMDXINbqMRJ6FNMzkev22NqpHgTrZ9rc1
         Hn2xoInNPyNVAnx3cck5dBCZH4bEqPinC3JW9SeMVSjENMyFddm31euiTIQavgLzVyIs
         SXA6pE87h+pVQ/pIF/vPbDDgDIn1mzAP3zaCznqazgPRjCUdgJzoRlUM0uuNfm3AoBU0
         6kIQ==
X-Gm-Message-State: AOJu0Yz3wTgIPw2xVrN8dH+Bo+d5yYnQPUxN6GJdTazNocMTYv1Oioi+
        W1bfhEluYFIkzKQ0mp72MQrBsg==
X-Google-Smtp-Source: AGHT+IFAtv2z95IKTq9baXG2PDliiKyd/6c8+z7LFkeM+DY6AjGwNYAuEFTes7Gm8J+3o0g5L4T4Yg==
X-Received: by 2002:a05:6808:1526:b0:3a7:215c:e34 with SMTP id u38-20020a056808152600b003a7215c0e34mr1877730oiw.15.1692332099160;
        Thu, 17 Aug 2023 21:14:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020a63af03000000b00528513c6bbcsm482559pge.28.2023.08.17.21.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 21:14:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Russ Weight <russell.h.weight@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Micah Morton <mortonm@chromium.org>,
        Hubert Jasudowicz <hubert.jasudowicz@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] groups: Convert group_info.usage to refcount_t
Date:   Thu, 17 Aug 2023 21:14:57 -0700
Message-Id: <20230818041456.gonna.009-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3937; i=keescook@chromium.org;
 h=from:subject:message-id; bh=5M+3OWEvomnEKOKxGTJdJng3UG/qsjk7PywS3bh+KUc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3vBBm9j8z2CCa9Yr6MIi4NBsmekSx+KU0gfTz
 JpuD53+4O2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN7wQQAKCRCJcvTf3G3A
 JmNQD/0ZETF07/DVdo2/WNS2Gb9uUSUpBZ767KMdyuJCVP2RJAc29UMFHARtfQ0QxLq0MoHiE4Z
 rlwbbUiyoiqtgA/i02vJVH8+UmA6EhuIuvPdl+iBC+1S7xdJM8mvTgc25zIeCgfLkRIPQG+C0hR
 5Xr5g31AaFGBi6ye1UgW2Pu+9xjFGqo8ECXnvFtFQlb9SFM/A5yICtAE4ih7wtAm6Neof2O77QZ
 8q1iUo+BdvotIHuxxZnSvOjwg9MnpiSu0xd+/D3uTfsTTs3tlZPhXPeYUqsX1PAtQQMbqhTD/Vh
 PTHoEIpmvpd+fdrXjjFm2/B24lBCOVWlAVn7+PnzDp5WlfnZAs8gLnMmEhIIbNFtbsuwPatUIhW
 ZN2AZHemwnCR59klJub+ci0wk8vxINLJxrWEe5cDvWU4hnVbnTzrT1PMWXqeB6MjaGA3WpyELvC
 QRql1rnqqhxVaorv6a/aNeVx3zzvJfzQC8ewPWn0Zu7A0cMjlyWUEeufayMk/lSJ33MDzTMrasd
 wmTsA4lv6eyzOZVjghYMHY3STFRqL5IbR1IHRgZ9Z9VBfeoHT2QkKkLponOF626dO78XtLXan9C
 L68x50Lw4q8E9Wuxdt70PGl5o7AtVW5PZ5O0l+oztqHjncBm9AYUX3RiLaXY97mig1ortE7NrE3
 w7wTnPl aHw3lqpQ==
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

The variable group_info.usage is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

**Important note for maintainers:

Some functions from refcount_t API defined in refcount.h have different
memory ordering guarantees than their atomic counterparts. Please check
Documentation/core-api/refcount-vs-atomic.rst for more information.

Normally the differences should not matter since refcount_t provides
enough guarantees to satisfy the refcounting use cases, but in some
rare cases it might matter. Please double check that you don't have
some undocumented memory guarantees for this variable usage.

For the group_info.usage it might make a difference in following places:
 - put_group_info(): decrement in refcount_dec_and_test() only
   provides RELEASE ordering and ACQUIRE ordering on success vs. fully
   ordered atomic counterpart

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: rebase
v1: https://lore.kernel.org/lkml/20200612183450.4189588-3-keescook@chromium.org/
---
 include/linux/cred.h | 7 ++++---
 kernel/cred.c        | 2 +-
 kernel/groups.c      | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 9ed9232af934..8661f6294ad4 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/key.h>
 #include <linux/atomic.h>
+#include <linux/refcount.h>
 #include <linux/uidgid.h>
 #include <linux/sched.h>
 #include <linux/sched/user.h>
@@ -23,7 +24,7 @@ struct inode;
  * COW Supplementary groups list
  */
 struct group_info {
-	atomic_t	usage;
+	refcount_t	usage;
 	int		ngroups;
 	kgid_t		gid[];
 } __randomize_layout;
@@ -39,7 +40,7 @@ struct group_info {
  */
 static inline struct group_info *get_group_info(struct group_info *gi)
 {
-	atomic_inc(&gi->usage);
+	refcount_inc(&gi->usage);
 	return gi;
 }
 
@@ -49,7 +50,7 @@ static inline struct group_info *get_group_info(struct group_info *gi)
  */
 #define put_group_info(group_info)			\
 do {							\
-	if (atomic_dec_and_test(&(group_info)->usage))	\
+	if (refcount_dec_and_test(&(group_info)->usage))	\
 		groups_free(group_info);		\
 } while (0)
 
diff --git a/kernel/cred.c b/kernel/cred.c
index 811ad654abd1..bed458cfb812 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -33,7 +33,7 @@ do {									\
 static struct kmem_cache *cred_jar;
 
 /* init to 2 - one for init_task, one to ensure it is never freed */
-static struct group_info init_groups = { .usage = ATOMIC_INIT(2) };
+static struct group_info init_groups = { .usage = REFCOUNT_INIT(2) };
 
 /*
  * The initial credentials for the initial task
diff --git a/kernel/groups.c b/kernel/groups.c
index 9aaed2a31073..9b43da22647d 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -19,7 +19,7 @@ struct group_info *groups_alloc(int gidsetsize)
 	if (!gi)
 		return NULL;
 
-	atomic_set(&gi->usage, 1);
+	refcount_set(&gi->usage, 1);
 	gi->ngroups = gidsetsize;
 	return gi;
 }
-- 
2.34.1

