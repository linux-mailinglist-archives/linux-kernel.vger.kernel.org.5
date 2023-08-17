Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420577FEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354810AbjHQUJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354812AbjHQUJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:09:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6D30DF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:09:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc8045e09dso1718505ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692302956; x=1692907756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ7fz35bP0bKdGLtoUaSP9+9dK36OBhq/rH4f03UP9k=;
        b=cNl38Eo0QlTbsWEaBDNl+YO662B2vL5JCtg31M27/k9Y7+1fQVCGQLtGRpumLQx30C
         x+qPdjs1ZPbk6O2iDok4s6s1iEpyWneP6hCO/wqwTurg+6xqz9DGryGZFrVR8YabBDk3
         ubTVp9aSj1J0s9e7Oy87EqPIVKIHAyvZRRvLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692302956; x=1692907756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQ7fz35bP0bKdGLtoUaSP9+9dK36OBhq/rH4f03UP9k=;
        b=eHJgj8EevRU4AUs1+hsnzcreVC3TC/lWemzufauY/H2c00fAr0Nbeal/M7S1vzZbVF
         SGMRlTCnjwBB6B0RJ3ZJmaxHSagWdswmiQdZeoV5P90cOLGwyaCURkksNkPHSVJq8SA8
         XF0xO7dCRfh1a6Lc20ad38Q4uzg9gKxSaY6/N6agBRYnPnWfqe5NebXy+GhLvt+XdoKd
         Qqo7Ds3dXr3YlqJF/BPmmvRE0jdXCGYlOfHg/ba2WRPLPLvz/IekZGmWExdwdifWJofe
         i9FhFymxr8iCtaROY7329lnC2SVlikp1nlmzBEzZKICPrkLZRXLzuK0e6P63M4wxQS9H
         woYg==
X-Gm-Message-State: AOJu0YwnDJXTvnk5zp4OqcDXHULhp6XoMLb7RM+9pcbiu6YL/kZygVXu
        i1c6goneg93CSTxzIt20mEXSNA==
X-Google-Smtp-Source: AGHT+IGvcl/oWaVhRtg1Zt0rVBnsswfkr+eiYgrE3ab/b+EBFf6heURqjV2YUnLmSH/48TwEoQ7wZQ==
X-Received: by 2002:a17:903:245:b0:1b8:c6:ec8f with SMTP id j5-20020a170903024500b001b800c6ec8fmr516863plh.46.1692302955876;
        Thu, 17 Aug 2023 13:09:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001b8a7e1b116sm157063plh.191.2023.08.17.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:09:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] lkdtm: Add FAM_BOUNDS test for __counted_by
Date:   Thu, 17 Aug 2023 13:09:14 -0700
Message-Id: <20230817200913.never.960-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608; i=keescook@chromium.org;
 h=from:subject:message-id; bh=KWub+Di29o9wWS3fcHCleWCIrt6ZSxxg+QBwZqpUNF0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3n5pZTlnNJ2Ef/Gpi82nxGnK6J0Dl5WI/ExCa
 yVTvL2U8dCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN5+aQAKCRCJcvTf3G3A
 Jjj5EACWSCRQf2QfQYhbzWxNUEhLp8OOGipT+mUMqE88CiGd3lckm6d+dwHQvXF0opzJcWKKkqd
 /MR4PDU03vmPc/04+m18YZtCeiZp07iNRExg2pQOP1T/g/xtlFZzAY931hAVyCnxZEH7UsSeqpL
 wNET0K7BDC6Qq2x1Ga38vvc5yabt8IR1TiVVAVQELRGTO0cC795yVzkaQoZHVe9/UrPVHw8pfLL
 bjZwcDDOBT3zdOw3smmUul3H7/PAH0Bh3aZPrao+o5L94nF8TznyztpvpSFuMuxgl1QHD+Y0dEx
 s2phTCfBlr5YLx5BR3bmq4+ghx3eW+9ZwDdubiAB3qWWGpxOuFbq6MRhZWqU3/Wo3toLYC/DxAZ
 1SaLLgdzHEEPo5rbOgwCU0FJm4UqP8RNYJBXw3sO9gPwcsBwKZIxB9Bi0DeLNvux6KHNDOJm3KF
 E1d5g0c4fqlSVwOi4397hgW0s2ZVjoTtcMSN3d6Zo9XpXPZ7xPiqZrDSzhl8QTpsgHovliBUCuS
 wFEV/OFBjLbsEqQNNkciUcS7jti25UQcb9dtW8J1bwDHhfwZWkZjI7ZbGA/Vqihisk8KHaAffUH
 pKGjMXtLJtDbtv/Cs3EuuhtBRrNras1q9IQzq2x4cDvl80OJrgegIanqWt7QVLKX0JhRi8FU0yS
 fhhJY0C UTQT/zyQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new CONFIG_UBSAN_BOUNDS test for __counted_by attribute.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c | 47 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 963b4dee6a7d..c66cc05a68c4 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -273,8 +273,8 @@ static void lkdtm_HUNG_TASK(void)
 	schedule();
 }
 
-volatile unsigned int huge = INT_MAX - 2;
-volatile unsigned int ignored;
+static volatile unsigned int huge = INT_MAX - 2;
+static volatile unsigned int ignored;
 
 static void lkdtm_OVERFLOW_SIGNED(void)
 {
@@ -305,7 +305,7 @@ static void lkdtm_OVERFLOW_UNSIGNED(void)
 	ignored = value;
 }
 
-/* Intentionally using old-style flex array definition of 1 byte. */
+/* Intentionally using unannotated flex array definition. */
 struct array_bounds_flex_array {
 	int one;
 	int two;
@@ -357,6 +357,46 @@ static void lkdtm_ARRAY_BOUNDS(void)
 		pr_expected_config(CONFIG_UBSAN_BOUNDS);
 }
 
+struct lkdtm_annotated {
+	unsigned long flags;
+	int count;
+	int array[] __counted_by(count);
+};
+
+static volatile int fam_count = 4;
+
+static void lkdtm_FAM_BOUNDS(void)
+{
+	struct lkdtm_annotated *inst;
+
+	inst = kzalloc(struct_size(inst, array, fam_count + 1), GFP_KERNEL);
+	if (!inst) {
+		pr_err("FAIL: could not allocate test struct!\n");
+		return;
+	}
+
+	inst->count = fam_count;
+	pr_info("Array access within bounds ...\n");
+	inst->array[1] = fam_count;
+	ignored = inst->array[1];
+
+	pr_info("Array access beyond bounds ...\n");
+	inst->array[fam_count] = fam_count;
+	ignored = inst->array[fam_count];
+
+	kfree(inst);
+
+	pr_err("FAIL: survived access of invalid flexible array member index!\n");
+
+	if (!__has_attribute(__counted_by__))
+		pr_warn("This is expected since this %s was built a compiler supporting __counted_by\n",
+			lkdtm_kernel_info);
+	else if (IS_ENABLED(CONFIG_UBSAN_BOUNDS))
+		pr_expected_config(CONFIG_UBSAN_TRAP);
+	else
+		pr_expected_config(CONFIG_UBSAN_BOUNDS);
+}
+
 static void lkdtm_CORRUPT_LIST_ADD(void)
 {
 	/*
@@ -616,6 +656,7 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(OVERFLOW_SIGNED),
 	CRASHTYPE(OVERFLOW_UNSIGNED),
 	CRASHTYPE(ARRAY_BOUNDS),
+	CRASHTYPE(FAM_BOUNDS),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
-- 
2.34.1

