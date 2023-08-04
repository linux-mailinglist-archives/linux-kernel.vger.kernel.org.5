Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D9D770496
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjHDP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjHDP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:27:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8CF527F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:27:33 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d390abf3319so2425810276.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691162852; x=1691767652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHpUmzrQnDN6BdHRPVO0KcfDXP0OZ5FbBAepEsSX9Ig=;
        b=hVA3/ZpFJEmsauiGAaXBbjIpfsmpWfR3fbsRgVp5rAEKSt/9A6Xd3kd/eO3AJKJZGn
         3AC2ZtIRwv64xHd6WForq8/KFn/Rx8J0hO2y9EPElGCTjTZlFAkT/InmtwUwzE1eqnYK
         kJASoqtH6CN0ybpUSytgjtDaJ9liKxmHr1g1t4U6N9jwmAFqgwbXaE7cZYKwslngmO8u
         IcikEpTE0wWzJ4jIGpYVyW//mlltwrZAHvNVNKEreIx7RlfWw5qL77YBxevZNGlJfhg9
         fpzNtyDU3iTuo29Qe3cFV5Vv2NkySasem1meuIOuN49ZkF8grQs850+nFjQFoo4gac+A
         WX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162852; x=1691767652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHpUmzrQnDN6BdHRPVO0KcfDXP0OZ5FbBAepEsSX9Ig=;
        b=jqgmKhhceBfm4o84/JqILlILI1lM3AJuhz4/sGVLAKUlD/Gizxwp1qmdY986AOvjfp
         1YrQKKKMsvtr/8IqmipS9wAxXtelPhElSR7tQV5hXcY+nys8ExD3VYUOBvUdf76iN7G8
         R0poIVnCfSpgnTwEoVXDHKFkjxs4LR8MX0vTqinS/0PN98P8MfXVbgnhys4O4YimIM1k
         6hSxK0obuFi5tr8C5x8XwaJdQAbhpieLjGA7H7ZKXG8v351LVfQaUpcaFOb3BWxjak80
         yeWFErXqaerA+CZMsL/zSX6HBYGTzBmgflsPHMDuFEbAIqQfz8dqa5i4rmTc0LA22m6u
         gYgQ==
X-Gm-Message-State: AOJu0YwS3Pr/CuQ5dbFMyUJLV0tDUbhURZmf5dNMe4Xv7qG3rmWl3vE4
        9Ur/7krvbSiimWtamNA1fy4oDCbwL7I=
X-Google-Smtp-Source: AGHT+IFqHpzaEQ49U8hAJkm1uL5RaOqEsE7NFQT8Ocv+VjqN2lk1j8DiU0ekVvKXC1nMsrd6uQfY/SIVGJo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:43a7:a50f:b0fd:a068])
 (user=surenb job=sendgmr) by 2002:a25:aa4e:0:b0:d45:1b81:1154 with SMTP id
 s72-20020a25aa4e000000b00d451b811154mr7593ybi.2.1691162852582; Fri, 04 Aug
 2023 08:27:32 -0700 (PDT)
Date:   Fri,  4 Aug 2023 08:27:20 -0700
In-Reply-To: <20230804152724.3090321-1-surenb@google.com>
Mime-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804152724.3090321-3-surenb@google.com>
Subject: [PATCH v4 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
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

When CONFIG_PER_VMA_LOCK=n, vma_assert_write_locked() should be equivalent
to mmap_assert_write_locked().

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

