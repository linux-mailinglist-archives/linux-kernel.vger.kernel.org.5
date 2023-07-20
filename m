Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6771375A750
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGTHJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjGTHIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:08:46 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CF92694
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:08:38 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id 006d021491bc7-5634c4df8c4so838478eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836917; x=1692428917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OzwAcynUjm4TDDZtYUdTlt8GRef6hCkFmXsjGPYLvQA=;
        b=QdsbdWEvmo4m7dFreE18whaI10HNxA5U6Eq4dlh5z46nHRuNKvgnmtyQrlecaO4sV8
         pWMQ+xztiQx/wc1YGWhMYzOCtuiM6PjW82kZXGkYJ68Xwsx5KrsGhi4OgbRK80gIgcB7
         clLYTavc+M9b93VW/QkD9WL4K9KunD/+0BOFjNktnoseyObLt2ro/bWXeUjfsH//HPvv
         iKo/LdVH7XZs+1rJF1M/AwxhXSl+9z13Axu/a0fHLc9te/mN1I0tCp0Us23Ispa/XUDp
         ufe5XWIgsZtbi6tiF99R36YBIvSUA+Db8luFMXb3WtMXUvnpGh0pFJrrPbseVvr7ZJUC
         YeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836917; x=1692428917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzwAcynUjm4TDDZtYUdTlt8GRef6hCkFmXsjGPYLvQA=;
        b=lm6Q2GPAFex8aVBp72Rh4uCBJ7lZoY7F5Yh27gC40a1SNt6LK43Z1qv/tqhuBukToR
         m1nh5FEWdidPezq9BTt62WpGPyFmpr+u+9r9UsJnNbbRoQVHULDjYE/woOkUpZM+wzb+
         leAKTRCf0M+GNSIj8njyy9s6IB6YKbwELyS8GgjPGJt//ISJj/vsH+EdmYVplEesoqGq
         OIN5NgNVSNyQmCZHtlNowQnUPkqZXlE3TIT80lo9okitRwMWNpKZyZFFcFzbD6pLkvaV
         rMgUnJJ2xbi8/AEApelBNDlHT7bNb8VFsz5clCt5x4n3CTOi1XcDnaMXi9hEOPeLfeqj
         7+/A==
X-Gm-Message-State: ABy/qLbTGoM3msKws6VhhzlnUvUsHx5Yj+PrWd76/6iza2+3718XsHbA
        GP6/apsK5hMYyUckDH1RkYRl6OFFv2XPMfYo
X-Google-Smtp-Source: APBJJlHxP5P9yoiXFXdFsa+fxsrJ91qoDIJe3rq084GoRyXYn6ED56dX4GksMdKRSpbhY7hotG9fq78xxc+urVcp
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6820:34a:b0:563:4841:891f with SMTP
 id m10-20020a056820034a00b005634841891fmr2470502ooe.0.1689836917359; Thu, 20
 Jul 2023 00:08:37 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:22 +0000
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-6-yosryahmed@google.com>
Subject: [RFC PATCH 5/8] memcg: recharge folios when accessed or dirtied
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch provided support for deferred recharging of folios
when their memcgs go offline. This patch adds recharging hooks to
folio_mark_accessed() and folio_mark_dirty().
This should cover a variety of code paths where folios are accessed by
userspace.

The hook, folio_memcg_deferred_recharge() only checks if the folio is
charged to an offline memcg in the common fast path (i.e checks
folio->memcg_data). If yes, an asynchronous worker is queued to do the
actual work.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/page-writeback.c | 2 ++
 mm/swap.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index d3f42009bb70..a644530d98c7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2785,6 +2785,8 @@ bool folio_mark_dirty(struct folio *folio)
 {
 	struct address_space *mapping = folio_mapping(folio);
 
+	folio_memcg_deferred_recharge(folio);
+
 	if (likely(mapping)) {
 		/*
 		 * readahead/folio_deactivate could remain
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..296c0b87c967 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -457,6 +457,8 @@ static void folio_inc_refs(struct folio *folio)
  */
 void folio_mark_accessed(struct folio *folio)
 {
+	folio_memcg_deferred_recharge(folio);
+
 	if (lru_gen_enabled()) {
 		folio_inc_refs(folio);
 		return;
-- 
2.41.0.255.g8b1d071c50-goog

