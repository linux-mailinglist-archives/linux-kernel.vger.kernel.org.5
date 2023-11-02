Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D937DFA87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377384AbjKBTAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377315AbjKBTAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:00:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD231186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:38 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b9a1494e65so954548a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951638; x=1699556438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+nc9zCe0F3smKTRXfJvQjpnEMs/1g7BVYJ89L/nFoU=;
        b=0kbwSHA0om1a8qCaJjkGhTMng+QGCErUehmbNaeutCwchAWBW9/dl1WToHmmopUX3o
         PnDa1plyLwS5/qZSQoce3lbkVITkMNMacJ6AQLVmG9nJzyhhwqhO+yiHnh0MJiyo3Bi6
         X4lmA753VcAaYVv/3Uq7NwT9xqL6MaOKtuvLIZbUveg7nn2WxNvWxhvQAQoP6ZAya2A4
         hM71dJPUW0O3JzT0zZ/7lw1JB5gwYKdAkV+kEJFD2H4KrD+YI11NC3ZAKmVCa6n7193V
         y/tH/Yvd4Ncz5A1pEMLXZPHvSsAtz12V/RznmU1cciPLo0ZYibjUunH+sqoLWZzjM5iL
         QdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951638; x=1699556438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+nc9zCe0F3smKTRXfJvQjpnEMs/1g7BVYJ89L/nFoU=;
        b=jI2W0+kcD73GU21f3Q++UEMPpX7IOe1vmdi89whjMl7ViY7HMw2KJqTPdJ0lho/vd+
         XntyhHU6rCO8Am3FdqrPGjNCPspf1zmR1vFRTuzO2zEulhRbXEtF0GpDQKIXAel/SsF7
         EROaV6we9dMps0PqMCJIn1gVvEENqCeXQldKnVcQGdW0iy1+nZ0sI7yRp1fLkjVJ6jiJ
         djiF4ppGbgc5kBKJeM4JWyrGAYAyZWhIeBzjYX1cIaz76SGe/btKSUlOI1GBMhvD2RH5
         WbBia1r233Y4PIwH4WMkJ7uXpMQz8ASGNqBTophzlz/+hCnUncxfCBH0xVCLYgx42Aat
         qZDg==
X-Gm-Message-State: AOJu0Yy/8Q+OMAtTu4XLRtE+Tr10F6q55eZASilXhDzI8B+WXWI9JLU+
        MrXuK2cocpfITjhThO0w4TMp5CO5geMt/A==
X-Google-Smtp-Source: AGHT+IGKhp7oZbA/K6kRVkT9UGZ+3HpEOT7nbfXzG1jWOehmI6jqKE8O+aacPTNJtBAReOQu3LivUFzrYpuRrA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:efc9:b0:1cc:20dd:8811 with SMTP
 id ja9-20020a170902efc900b001cc20dd8811mr317499plb.5.1698951638156; Thu, 02
 Nov 2023 12:00:38 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:05 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-5-cmllamas@google.com>
Subject: [PATCH 04/21] binder: fix async space check for 0-sized buffers
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

Move the padding of 0-sized buffers to an earlier stage to account for
this round up during the alloc->free_async_space check.

Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 046c3ae9eb8f..9b28d0f9666d 100644
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
2.42.0.869.gea05f2083d-goog

