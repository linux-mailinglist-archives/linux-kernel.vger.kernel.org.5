Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA27D4798
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjJXGis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjJXGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:38:46 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291BCF9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:38:44 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7b91faf40so41280417b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698129523; x=1698734323; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UXi6v2LbKa86tbarZSXs3eTomoCCL5BUs5KfudH0fXM=;
        b=pplaE/v1KzadrnvkymvI/c+Jj3XiCYAkY8KiIDf7y3Ik/Jn/plJ8LE4Ie/BGdpYLXJ
         yHeWyzITGtHIwK9IzfI/sBTzaSoSie5x0Cwk9zc7BeGQwpOeB0TWs+4D7vJ0mWsoWjCS
         DyoucrHLt+Nbz9nsYv+gZkO+ne6c4cKeIsUaLjnUegQhEh2aTLMT7Ti5tSqUDo+d/Ouy
         RYwBKLTD3yKOl9nNwrYMrVSqiGVPI/oiDqaft0hu84rmxCgkXXhZg76Q3BdBYLtUvcPr
         I2AQwB6B++uidbSwlMObz7A1/jV98KQBHFsKfFiJPkQHGBNpmX7U2O3+Nom4mLmO44em
         pGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698129523; x=1698734323;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXi6v2LbKa86tbarZSXs3eTomoCCL5BUs5KfudH0fXM=;
        b=VH5esBdz7fTrqWtwctA/pmkd7Gr5pN+Z/KHrTTBb4dDg472MBCp549e/OXCAuaUQ8G
         Iy79eWe2UfAVysT3g8VOn0bE/D9a+7Y+qxsks+gfAcAjAjW0yU2jn5pFtBR8EZdiaKXN
         YcEbRrGuyBUrrbXiic3Kyzcqk2WsUvp1md0k7bRKLm5kls+m6549MiCvJlty+6MrUbAH
         VCTExDfzw7oafBuSbdmPIlr9l+s8+ZDSgi/5FEqimwEOlwOFkqip2N9IoQK2z8HUkVU9
         2qd0W3px4IE1jvzz/W+dOjkVap7XgAl93nEA3Z6jy+RNeaDmm/MIQsYe/C1a2g5vVyqQ
         mw6Q==
X-Gm-Message-State: AOJu0YwN6mNjBBcjtYkeUoWD74itHI5wZpLcCc1LwKLleQTO7njvQjFM
        aoBAjz8Jo3y+2LwpbDKQKsaddYnYM9RrFIE3v3SEXA==
X-Google-Smtp-Source: AGHT+IG0IW6r6OKt3t8wA3MRK4sQptJZdOLg5QTv5pLEidJzquHDgYh4NXUKWmkVGawKWVlb8hrCfQ==
X-Received: by 2002:a0d:d48a:0:b0:5a7:b682:7929 with SMTP id w132-20020a0dd48a000000b005a7b6827929mr10904861ywd.17.1698129523237;
        Mon, 23 Oct 2023 23:38:43 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w74-20020a81494d000000b005a206896d62sm3792514ywa.111.2023.10.23.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 23:38:42 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:38:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yin Fengwei <fengwei.yin@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Stefan Roesch <shr@devkernel.io>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: mlock: avoid folio_within_range() on KSM pages
Message-ID: <23852f6a-5bfa-1ffd-30db-30c5560ad426@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since mm-hotfixes-stable commit dc68badcede4 ("mm: mlock: update
mlock_pte_range to handle large folio") I've just occasionally seen
VM_WARN_ON_FOLIO(folio_test_ksm) warnings from folio_within_range(),
in a splurge after testing with KSM hyperactive.

folio_referenced_one()'s use of folio_within_vma() is safe because
it checks folio_test_large() first; but allow_mlock_munlock() needs
to do the same to avoid those warnings (or check !folio_test_ksm()
itself? or move either check into folio_within_range()? hard to tell
without more examples of its use).

Fixes: dc68badcede4 ("mm: mlock: update mlock_pte_range to handle large folio")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mlock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index aa44456200e3..086546ac5766 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -346,6 +346,10 @@ static inline bool allow_mlock_munlock(struct folio *folio,
 	if (!(vma->vm_flags & VM_LOCKED))
 		return true;
 
+	/* folio_within_range() cannot take KSM, but any small folio is OK */
+	if (!folio_test_large(folio))
+		return true;
+
 	/* folio not in range [start, end), skip mlock */
 	if (!folio_within_range(folio, vma, start, end))
 		return false;
-- 
2.35.3

