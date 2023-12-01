Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5028D801188
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378879AbjLARWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378762AbjLARWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:22:37 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BF12A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:43 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5be39dea00dso908281a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451362; x=1702056162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gno0tJcPl/fxbJfUoJTaE2HUZmu0JZ2Ukn3OL4rbq84=;
        b=mLAagX6tquBjsCZ8HyMDIDEzKh0D6snKtK5YGYWVdzQqNfeGIhZeFzAz5WwP7ieY+A
         ILvSylZXg5DbYbwtaClbgErK3NxJ8LARRwPXJbibhus2FWj7izwev6XXMfChYcfqf+GU
         upK+IgIzhFxcR13G3Nwi4x0OnEUAqU9/BeauX+7sfifRLeuilf8J4jNwFEHUjGBA1NcE
         PNEajgl41ZVA0+dmYQkPImAWbizb6T0KsAMcN3EnzUs7Pxt24+OB9XSq27qNoqxy5uzu
         g/LbuoquDmtukOavvqdC2Vs1WHYl1dD/qIXKY1GnB4Q71y8jARFkUC5RO7pvy1iL79yr
         xYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451362; x=1702056162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gno0tJcPl/fxbJfUoJTaE2HUZmu0JZ2Ukn3OL4rbq84=;
        b=Apy6L0aqGJ7sO8CzrDIrlRPFz93CC7R7MzmOZobTcoIYEIwKRSghggZ4jMNoOA8lhE
         /KjG+S6zdsZE7iCReaKvi7KUta7yh62AiUqe1j7dzYdOvP42YUXlp6npXE4RCaNkwrQl
         OrvYnbjGv8E7OC7oIJT4//tRD43Q7cV9k7rPWw3TdR/jgATH+3Qbd00SxkOwxhxyYcAC
         r/I1cDGXPZeeRJhY9FpDfW9AxlD7iqkd1MO7azsYyaX+ghjzrZ4eyS9bv3Yb965t9mkB
         k/UJLnn6UI8p/eU17BXcPkbd8DpIhwPIpFFDsM6ApyiDBdP3HPcbHttExcPhArUOjX3x
         z9iQ==
X-Gm-Message-State: AOJu0YzNexSXPok/2GP07C7XHZu74NOgNO+uxgssUnW2CbpNPA55/cMI
        +h4ZJ1CkJ/hyevc2C3wqVp4RAnTo71Dw0A==
X-Google-Smtp-Source: AGHT+IEqmqu8zStUVCZ3TXr8HVDis4oQebpDkzV05LPufK7qrQxVXMyuAqE/gQDAf/EKy4yCBMl1nFlq5FsdYA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:dc0d:0:b0:5bd:d60d:f60e with SMTP id
 s13-20020a63dc0d000000b005bdd60df60emr3821128pgg.8.1701451362476; Fri, 01 Dec
 2023 09:22:42 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:33 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-5-cmllamas@google.com>
Subject: [PATCH v2 04/28] binder: fix async space check for 0-sized buffers
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sherry Yang <sherryy@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Alice Ryhl <aliceryhl@google.com>
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

Move the padding of 0-sized buffers to an earlier stage to account for
this round up during the alloc->free_async_space check.

Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index adcec5ec0959..abff1bafcc43 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -407,6 +407,10 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 				alloc->pid, extra_buffers_size);
 		return ERR_PTR(-EINVAL);
 	}
+
+	/* Pad 0-size buffers so they get assigned unique addresses */
+	size = max(size, sizeof(void *));
+
 	if (is_async &&
 	    alloc->free_async_space < size + sizeof(struct binder_buffer)) {
 		binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
@@ -415,9 +419,6 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		return ERR_PTR(-ENOSPC);
 	}
 
-	/* Pad 0-size buffers so they get assigned unique addresses */
-	size = max(size, sizeof(void *));
-
 	while (n) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
 		BUG_ON(!buffer->free);
-- 
2.43.0.rc2.451.g8631bc7472-goog

