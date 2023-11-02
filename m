Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987C77DFA9E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377396AbjKBTCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377404AbjKBTBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:01:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE98D4F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:01:11 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so1135899a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951671; x=1699556471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QHIOo3gOkAYOw4RGs9b01yoCrC6Uyqd0reVAR+tEFcA=;
        b=xRfGfhQHGBAC/46JjNQm2SjxXf737mvXI7vZsYGswrpQ5DSYHv2AVPpme/7qszzH2I
         rL4QSyT1/Imaux3eEpVlUiLj8sA1OpltUh6J0/pqsNDOoKDQPJbiGiPaDMPuZ0Es90N2
         6M/ZwRZk7utp9F5FwRToSk11od1Ip0Op5ub5giI8lymLS212dXfauhIscgEsOU3kt1ki
         U+1Y0eS7gk6+X4zhL3MMvJibptpUCSPa/JySOKyQrK+2Q3+jM1Vcr/+X5XwylkPXPLg+
         jzq8negxgRTJVf7/815h/J81v5m3yZez5VRX4EBZtVDzOEFACtyoo6XZ8zB/LP9sv5KV
         OMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951671; x=1699556471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHIOo3gOkAYOw4RGs9b01yoCrC6Uyqd0reVAR+tEFcA=;
        b=AN27eQzxMu+3bs80tHz4TqLyvp0atEy4T1GC4W0q8T7WpoNiXBr5k/ZdwZaD1g+ZSy
         8kaLGwCVePJHVz+G1eBuHhwUGayIlb5ENRku1Td8qhuujpxYgNnKjLjWazeKnMDpiMuR
         zEUTeYHwgNJP31N4c9jFzJnVyPYxtVqF1rSG3Hpmjh7GxGfNmwFj8LsKYw20FW++TT32
         NN1W4t0Vc2HsTe9EB4Gf53RJpF8rzyzYozlNobREFdSeLsZSfOypiCzNTsg+6zk1JdMu
         n7eTBja3w707tmDIF5QSLE7Ix3GUTUGUuQzuHKWMP4foQxb7KEUTW3tl/PfhFXV+833Q
         T9lw==
X-Gm-Message-State: AOJu0YxvN4JW0yWKvHFa0aYgTxRGALzGso+xiWD0DCrqKUJ6UcDuR3Vp
        Sv40YxwPVnvEwuZtAgOs+4M6KqAuEJL9jA==
X-Google-Smtp-Source: AGHT+IGRFB/qfGE9e4ItpxaEeaEvF6t1aN3GwKjY6nSdiEFdr/c+H4BHpZUgWUTY/r/lcJ/oYd3Zna4KkLMnQA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:36c2:0:b0:5b9:803b:1fbc with SMTP id
 d185-20020a6336c2000000b005b9803b1fbcmr235490pga.12.1698951671343; Thu, 02
 Nov 2023 12:01:11 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:19 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-19-cmllamas@google.com>
Subject: [PATCH 18/21] binder: initialize lru pages in mmap callback
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
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

Rather than repeatedly initializing some of the binder_lru_page members
during binder_alloc_new_buf(), perform this initialization just once in
binder_alloc_mmap_handler(), after the pages have been created.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index da6c62567ffb..7e0af1786b20 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -278,9 +278,6 @@ static int binder_allocate_page_range(struct binder_alloc *alloc,
 
 		trace_binder_alloc_page_start(alloc, index);
 
-		page->alloc = alloc;
-		INIT_LIST_HEAD(&page->lru);
-
 		ret = binder_get_user_page_remote(alloc, page, page_addr);
 		if (ret) {
 			binder_free_page_range(alloc, start, page_addr);
@@ -791,9 +788,9 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 			      struct vm_area_struct *vma)
 {
-	int ret;
-	const char *failure_string;
 	struct binder_buffer *buffer;
+	const char *failure_string;
+	int ret, i;
 
 	if (unlikely(vma->vm_mm != alloc->mm)) {
 		ret = -EINVAL;
@@ -822,6 +819,11 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 		goto err_alloc_pages_failed;
 	}
 
+	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+		alloc->pages[i].alloc = alloc;
+		INIT_LIST_HEAD(&alloc->pages[i].lru);
+	}
+
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer) {
 		ret = -ENOMEM;
-- 
2.42.0.869.gea05f2083d-goog

