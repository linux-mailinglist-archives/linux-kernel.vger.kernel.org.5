Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E907777A300
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjHLVBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 17:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjHLVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 17:01:49 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008751709
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:01:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68790b952bbso3560357b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691874111; x=1692478911;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ERK5q0s3pNoBkM1cIqzvaJZXjMBumkRX6A7c8Or84Aw=;
        b=t+rpWnfhBRL0I38yT/xUce/8F3MxLZo3IosDRFfNJM+a4EoUcCEF2OscZMzOdO5fkD
         6HCqLycbOofbZRm1DknX5zPAYE1OiZyaRUMd+jwLGTtP2xxKr3RE/n0Fztpm6qAyLmLo
         9vQFHtau3fUtqBe8yNVOnqxyqOpJBFUVlg6Qn72tnpIiEgCVJJ/2s86KO3Watgg+mnQs
         Ow0mnIRbwmQSXUapc9ZhXzw77iLdJaeWwb+6V0pCUdKT+IwxL95WTRZDGXT35vM0nxir
         p7HtV2rBdo3sGogmuI9Qxnccr3lD4h9w3sBAzX5iEsk2I7vIZpF28wldPF8Zr+GhQ4/a
         K5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691874111; x=1692478911;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERK5q0s3pNoBkM1cIqzvaJZXjMBumkRX6A7c8Or84Aw=;
        b=OSV748kTtGOKC1+FA+nRdxOP+W3SEoM1YOn1CGKYssdnrRHFg7XDUKXvic//4NrNcF
         UpfRhI/Z27Qg74kNyB+VC2rzIsxsiJSBZZ56flW7IqS2L7IG8wyD0pVCIAg609Ud7SrG
         5RTfiQPY/augykFaW2PgnRBQCw2FcWDyyjKaZSFQB30YmBW/nelHMkJQkRVKDkDM2ljS
         M8O3h0S/xKqT+gA6yx7H+cAwjCZ9aDhxEemNCIgX3HS25m/Fx2NP3bx4F54VWy1rA43g
         j09BSa7ks8nFvWXmC4MVY/lyXH45QebLSJvM9mSIxNkR5297RTRWZ74vAd7OrJ8qivkf
         zCdQ==
X-Gm-Message-State: AOJu0YyYvbkSU4zYW0TUM7ju/m2HegvoBGYqNZFOVW87YpJB0A1sDGj9
        n63y8ieIYCnLmCGCpPD1tDlHVjMpmDov
X-Google-Smtp-Source: AGHT+IH6JHGx7HCRZG9WmyU+e1nCfqazXgpKZwW0HwtSs54orfATz6XJre+St3dUlChPPn5yrfNmWiK6vNQf
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:2488:b0:67d:41a8:3e19 with SMTP
 id c8-20020a056a00248800b0067d41a83e19mr2442047pfv.3.1691874111529; Sat, 12
 Aug 2023 14:01:51 -0700 (PDT)
Date:   Sat, 12 Aug 2023 14:00:53 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230812210053.2325091-1-zokeefe@google.com>
Subject: [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Zach O'Keefe" <zokeefe@google.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 6.0 commits:

commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")

merged "can we have THPs in this VMA?" logic that was previously done
separately by fault-path, khugepaged, and smaps "THPeligible".

During the process, the check on VM_NO_KHUGEPAGED from the khugepaged
path was accidentally added to fault and smaps paths.  Certainly the
previous behavior for fault should be restored, and since smaps should
report the union of THP eligibility for fault and khugepaged, also opt
smaps out of this constraint.

Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Cc: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..e098c26d5e2e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 		return in_pf;
 
 	/*
-	 * Special VMA and hugetlb VMA.
+	 * khugepaged check for special VMA and hugetlb VMA.
 	 * Must be checked after dax since some dax mappings may have
 	 * VM_MIXEDMAP set.
 	 */
-	if (vm_flags & VM_NO_KHUGEPAGED)
+	if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
 		return false;
 
 	/*
-- 
2.41.0.694.ge786442a9b-goog

