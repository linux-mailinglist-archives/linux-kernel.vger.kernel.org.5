Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949076C018
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjHAWHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjHAWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:07:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F481BCF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:07:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-585f04ffa3eso55637997b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690927661; x=1691532461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i6HEpkZDiMCJl1HNBxUq/pPnwhYuhlhYWrvFQybpJWY=;
        b=V9cpwSELJrkQrszXU5HyumPij806LjFOgAKqGQckrRIsTl9WyJGm7y2tP2Z2qpZNBZ
         8OnG+G2+pRoWY7Gyh/uRKHckpG/wW2klLNffgsUon5TtBq05uulzu7VlS14UeHcVePc5
         6rcXGltEDaVNS9+SeI1i+AP3HDVebAv3PFT1lfSUDf6ep/jTCQ/IUFd9ttrSEA9t9DPO
         iGN48DWEsdFNb4WBgDh2gwPyzp4LH+hHwffYSWHoJfq3HFOTa5CTWqxb2Bx96ZnBccWK
         7hzPD483pGlx4dh0dSN4wMfxSLMa6kthAGUj3r6PC/2LNnNJKhb7gl7lRbdc8DmYXSji
         2fsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927661; x=1691532461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6HEpkZDiMCJl1HNBxUq/pPnwhYuhlhYWrvFQybpJWY=;
        b=XXSWSvP5ziJfaSlz90qFce5wgBdqINvM9xD5K3oHHKJYkJQX93hJbaeDbTAF+LMffv
         p/UdlFwZe06D80EZtAK8/A7HRPF67M+IdGzmEaVOH6/orMm6SGXCVbcbSKBTQVAgzeIy
         zONhjn7ZRqUWRhGF2dUh3VMOUi9SLGUSym959KO/BDP9xXNVDi7uWWpNCoyr50Gk4val
         tnP1/VAPgyTpzhV7abSlWbblzPaJN8gbUE4Ex8m1rjheygDpEIhlFNcEFfFznG8/lqbc
         8R1giQkVR5K+XnhHQaO75Rx2u9I7WwVRKCS6DWIxpZqyagQ/A0ZAmLY5lKhzp9MSthhf
         wDiw==
X-Gm-Message-State: ABy/qLa4eGuTdqZhV49AgX+MVB6vvJ0gyXDHHEj6Yy+aAr662ZiNWxW+
        notOCRIG3+KUQlYVgYIaYXpWLjBjiDA=
X-Google-Smtp-Source: APBJJlFo/x04tiw33tHz2z8eqoNqUG46TlCYKQtLqzp9NxrzX4ldQZG6AFgAiSwulUiFVWDLbQZPP6VjmRI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:211c:a2ff:f17b:c5e9])
 (user=surenb job=sendgmr) by 2002:a81:b703:0:b0:584:41a6:6cd8 with SMTP id
 v3-20020a81b703000000b0058441a66cd8mr114995ywh.8.1690927661105; Tue, 01 Aug
 2023 15:07:41 -0700 (PDT)
Date:   Tue,  1 Aug 2023 15:07:28 -0700
In-Reply-To: <20230801220733.1987762-1-surenb@google.com>
Mime-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801220733.1987762-3-surenb@google.com>
Subject: [PATCH v2 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
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

When CONFIG_PER_VMA_LOCK=n, vma_assert_write_locked() should be equivalent
to mmap_assert_write_locked().

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..262b5f44101d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -750,7 +750,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline bool vma_try_start_write(struct vm_area_struct *vma)
 		{ return true; }
-static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
+		{ mmap_assert_write_locked(vma->vm_mm); }
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
 
-- 
2.41.0.585.gd2178a4bd4-goog

