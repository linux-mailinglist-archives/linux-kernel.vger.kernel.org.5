Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1B769F23
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjGaRPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjGaRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4A411C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d061f324d64so4950095276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823562; x=1691428362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nr+kbatQ6YMh4Ju6KIXOvG29nOfDMrirC5hgMlL3cU=;
        b=GXelEXrbYIY2IAX+kiYu0x1tkCdi2SyGtSF/9w53Zm3gPRECLbctG/dBvEhZfym31B
         ZpNGuvTs3RdmkliU7juePlylZr5pnrjsO4FCwqrfsr6YZw+CfZKmgNsroN9WWEkA9+ck
         VJdhxNNh/Cu46QjjSL9nAJzM84Yb17nR6+dWlfcQS/FVxSuAY184c48pG3oyTsWv//zV
         pwBrsYEyhVF3UcXFqaT0GQRjqCuBIJhqhqjimJS9XP+GadbKmGH7LM8IjHhW/7STICdG
         EJDRSQ3ltPFB9ycjQw7aPjUMjYM8r7OK4dOG6LXF0kGtaXGnCriJR99uz1fZ6+M5MjcR
         M39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823562; x=1691428362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nr+kbatQ6YMh4Ju6KIXOvG29nOfDMrirC5hgMlL3cU=;
        b=fsq/fHOnG4+uTMOe5F6Eqbj5J62gEdIXQtAjemYMF7g8twSlkXP+wxFOzdlwCBl46E
         O7Lb1oo9scOqxzW+5+Q1m04qFqLjrXOJOCIUa6KOai4wwttGEVNFW+ySo+YCZNnbEem+
         6OyqBbeOL0mvskOPfd3Ws+VOWFdU4PB+a9DXA36AdT3rKoWBG5YNQfVeptER5WxZJt1G
         chhaVQ2q7RAKSvZk7DjUH6Yw2WnoNa6cws1JFJcWO6m2zT53HJxkPWTEXKOQeq6yXroL
         1JBncjLUS2zKzF8WXl4tf4sgHdE4w4LJiwzyW/+reU0d4/pqE4YCVDy3n+LZD4FWj4RC
         Ivfw==
X-Gm-Message-State: ABy/qLbqrVZ359/Ch0FcoGKED5Je9Bwm2HXU1KMs37zTXV+HY37PpQMY
        goqqcpUd9CmzniZ/dc6bH3cU6o3hABw=
X-Google-Smtp-Source: APBJJlHglqY7H7DXFApYFeh47wS6CJVxYTVOVhaQK3HM9XVkVTrRgX4b1iDjG9+19cN8CdS+pNJRAvwhhLw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:d4d3:7e41:cb80:21ea])
 (user=surenb job=sendgmr) by 2002:a25:d808:0:b0:d04:faa6:e62b with SMTP id
 p8-20020a25d808000000b00d04faa6e62bmr57379ybg.6.1690823561762; Mon, 31 Jul
 2023 10:12:41 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:12:28 -0700
In-Reply-To: <20230731171233.1098105-1-surenb@google.com>
Mime-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230731171233.1098105-3-surenb@google.com>
Subject: [PATCH 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion
 for vma and mmap
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.41.0.487.g6d72f3e995-goog

