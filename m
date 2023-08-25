Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5F787D80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbjHYCEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbjHYCEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE85E1BD4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:04:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D5B63E91
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0C3C433C8;
        Fri, 25 Aug 2023 02:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692929083;
        bh=DGy3J8tYd2fNRF/XMycogFjHA/nAjC6h5pCTBYpzOiI=;
        h=From:To:Cc:Subject:Date:From;
        b=Hq8Ec9ZVIKKgzSO5bo2qz85hrjMHvmYvKbaBnGJgQNBALU2Yene9Vt3mQ8oOLA+VJ
         gKBtDB2OsWoa8XQHpEbsvLT3HygLVL5ISqhfF3frSEv8HPDJaf7Ik7FX/uEedk7OV+
         wL8Ghc8bSX0WAGnY3ZnCC8EDtjSUTmL2qyeFa2/+hB9TyUah51BY9vgnQXmsO5sdij
         i4We3Y6q14CyEcfuTHdOz3XOPyNNtZJUpGYEH3dsQ1PXQMAqDX0wpIc0/riu6mWxIB
         kR/jf332aRiKl3WtuGTNNA/Hlzq8oRahAR6LTsoqCq4vfdIW/I+CAuEdD7858V3TLm
         XSfFlwbbGiHkA==
From:   SeongJae Park <sj@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/damon/sysfs: add __counted_by() annotation
Date:   Fri, 25 Aug 2023 02:04:41 +0000
Message-Id: <20230825020441.65431-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
added __counted_by() annotation.  The underlying attribute for the
feature is still under development, but adopting it can improve the
readability of the code.  Apply it to four dynamic arrays in DAMON sysfs
code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 808a8efe0523..36a176f38726 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -93,7 +93,7 @@ static const struct kobj_type damon_sysfs_region_ktype = {
 
 struct damon_sysfs_regions {
 	struct kobject kobj;
-	struct damon_sysfs_region **regions_arr;
+	struct damon_sysfs_region **regions_arr __counted_by(nr);
 	int nr;
 };
 
@@ -289,7 +289,7 @@ static const struct kobj_type damon_sysfs_target_ktype = {
 
 struct damon_sysfs_targets {
 	struct kobject kobj;
-	struct damon_sysfs_target **targets_arr;
+	struct damon_sysfs_target **targets_arr __counted_by(nr);
 	int nr;
 };
 
@@ -812,7 +812,7 @@ static const struct kobj_type damon_sysfs_context_ktype = {
 
 struct damon_sysfs_contexts {
 	struct kobject kobj;
-	struct damon_sysfs_context **contexts_arr;
+	struct damon_sysfs_context **contexts_arr __counted_by(nr);
 	int nr;
 };
 
@@ -1590,7 +1590,7 @@ static const struct kobj_type damon_sysfs_kdamond_ktype = {
 
 struct damon_sysfs_kdamonds {
 	struct kobject kobj;
-	struct damon_sysfs_kdamond **kdamonds_arr;
+	struct damon_sysfs_kdamond **kdamonds_arr __counted_by(nr);
 	int nr;
 };
 
-- 
2.25.1

