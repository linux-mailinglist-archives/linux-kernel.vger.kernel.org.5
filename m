Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA307F089C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKSTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjKSTtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:47 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3EDD7A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b6d88dbaa3so2548183b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423346; x=1701028146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ze1Psd2Ie5OovBPk7SmUTsWgEFqDeyPvhXbgqpZhXY8=;
        b=N1NnsxV11ewog1K925/BlU5b9EhM0d5Pcde3SG+GzZSzkIjxMU7Mw8+uWuK+BkbY84
         TyBrUGD4XlOXC2ZI6u14MuK/fTa33hbbdjdSLr9Ua+hsipTZgnm0Pb4JHrlW1dhrFv1t
         cp5cLbIvJto4kuOJ0CDqftFzZfT6vJEOxRq+YMd6So8r8qnK9RSf31fk6LV5USdIp7OY
         ohyenVI7/+mufGpLAUORUEQF8/sWaX6CZIqrRTTLPXdccE+l8KtO45RuoOPlGvq7fX7D
         wD7CB628QZWTED2q2ryqxvbVKdm0Qto+MEthPwassMAedVrSec3IOYMF9Do+KcJfzWfu
         VJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423346; x=1701028146;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ze1Psd2Ie5OovBPk7SmUTsWgEFqDeyPvhXbgqpZhXY8=;
        b=AQ5aDUtZXCbzp+RRnLZdJxiS6PDBSFXcBlFTcwZPqAW5Tk7s/NFkxswD8f9YcQHEvw
         lONTDkHayQLYyF1IW4cFeCSiPWZ8CQusK4hTRLcgVFVZtnikE3BC+t1FKrzsxZUrBk0K
         PqerYId5RR/j83evVbmSJYnLSftA/PPYjEZ/VuQ8jK6LFXk/QytbFjmVQBI9Q8yM7tN/
         1yswGNfjADjUdPtj+WX9Mjfj3/x+urZJnZa3N3hheipMfCKvkNQkVFMbXAYpzduzUvPo
         VGEMUM641U+cE5I0fZ85NxYvBX9Mt1nbDjLZl0Dm0qfXbmBuH5nZGFFP8ZyIPFRHvPa+
         jSbg==
X-Gm-Message-State: AOJu0YzfX7EIrjn4sG/aqytEO53YzLyGm0rp9Js73RdLRUH/mRyF/zhV
        sVMYRoCfStjyysmADIkKWN8=
X-Google-Smtp-Source: AGHT+IGTlsOhMDU+nbF9BiKSPMYiu1dnBRu6RvVsGq1/cPrbFHBN7F+llm4LzYDPkkR6tdAEcGAOgQ==
X-Received: by 2002:a05:6808:1451:b0:3b2:dcff:9e54 with SMTP id x17-20020a056808145100b003b2dcff9e54mr8319167oiv.24.1700423346359;
        Sun, 19 Nov 2023 11:49:06 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.49.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:49:05 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 20/24] swap: simplify and make swap_find_cache static
Date:   Mon, 20 Nov 2023 03:47:36 +0800
Message-ID: <20231119194740.94101-21-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
References: <20231119194740.94101-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

There are only two callers within the same file now, make it static and
drop the redundant if check on the shadow variable.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       | 2 --
 mm/swap_state.c | 5 ++---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index b073c29c9790..4402970547e7 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -46,8 +46,6 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
-struct folio *swap_cache_get_folio(swp_entry_t entry,
-				   struct vm_fault *vmf, void **shadowp);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index eef66757c615..6f39aa8394f1 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -334,15 +334,14 @@ static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
  *
  * Caller must lock the swap device or hold a reference to keep it valid.
  */
-struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *vmf, void **shadowp)
+static struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *vmf, void **shadowp)
 {
 	bool vma_ra, readahead;
 	struct folio *folio;
 
 	folio = filemap_get_entry(swap_address_space(entry), swp_offset(entry));
 	if (xa_is_value(folio)) {
-		if (shadowp)
-			*shadowp = folio;
+		*shadowp = folio;
 		return NULL;
 	}
 
-- 
2.42.0

