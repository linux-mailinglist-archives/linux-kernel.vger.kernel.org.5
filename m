Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68A280119B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378928AbjLARYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378958AbjLARYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D651BCA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so857644a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451401; x=1702056201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwPGkNR8076Q07N+OgHVsWjnRk7wPl2kgeueBhqxEBg=;
        b=hPr3SynxGCIfdWw9lphBKaRKNpqifrVVvEl3k83CC3Sr5kB60DsPegWKk6Tp7t9n47
         gcVtIOCI5q6H0GzzUH/LovTQkf4jydr99D3IYAE1VJXNMtXR2jLpnaljSuuxw16ueEHE
         PeYTRoraX71FpR99kOJLHJPk2doGqn+9VoMnTiTWGK+aBtNgsRGsei+3zu2+Jwpjna6x
         GNJw/NkVY72CXZES4TkJQdRQN0ZsF/UKco8pI0qxXR/RcFu3ZtLBphdZZlRMeTJiUNkB
         dZEVON+CmngUTY91GSzZXChyjcZ6vCTfInIf//JwPbdn6FEd8czXTK+SlhPhPWrdNbCt
         FFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451401; x=1702056201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwPGkNR8076Q07N+OgHVsWjnRk7wPl2kgeueBhqxEBg=;
        b=dveICv0xRzCKPKQxU4u4nZV5GeiahwpQrz4RFDiucDFCLEnERKiKF7bYoOenCfEgvP
         MIHZpeWPszBYO3spu7A/6pv69m2O4RAUTeGIB3vTtaMy5Op3HU3PNToEWhqjLlfvyC/D
         99vCUJFyzbeeT7whYkpqVDy/0G45hGc8xe+JZcwWyMqQf5OHs6YBKNREWvBtMpR8tdQ5
         rYQDH3cMDiJiPmiq1f4rcUk8gVU4cCYpb63UuIvYbfrjAQtd9rLDQUOxyUv3dfWvRnPh
         8vsTqdJW/NnYRj9LjmjjYx2PPKaJnVOJC1FCgJcOXJxWTCrgFQuNmMVFzwNj7S/G4Y1G
         DSug==
X-Gm-Message-State: AOJu0YwH+C/hD1MYsw/saYQi1FZkgtjBRGOaJ6XLLWKS+/Os8S1NoPJc
        ANtw6/rPa7vkFrPBC8DDuEJRr7voxT1gpQ==
X-Google-Smtp-Source: AGHT+IGT4HmJeynTGcHrHKbHhxApSr77DEEehuQkxHWCat3Abm4pqJPAdq7NKaX4LfEaJ6PH+v9tK5N3GGuh0w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:d304:0:b0:5ae:ce69:e65d with SMTP id
 b4-20020a63d304000000b005aece69e65dmr4041766pgg.12.1701451400912; Fri, 01 Dec
 2023 09:23:20 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:50 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-22-cmllamas@google.com>
Subject: [PATCH v2 21/28] binder: make oversized buffer code more readable
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

The sections in binder_alloc_new_buf_locked() dealing with oversized
buffers are scattered which makes them difficult to read. Instead,
consolidate this code into a single block to improve readability.

No functional change here.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index c9292eee8fee..ad9b73c6ddb7 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -483,32 +483,31 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 		goto out;
 	}
 
-	if (n == NULL) {
+	if (buffer_size != size) {
+		/* Found an oversized buffer and needs to be split */
 		buffer = rb_entry(best_fit, struct binder_buffer, rb_node);
 		buffer_size = binder_alloc_buffer_size(alloc, buffer);
+
+		WARN_ON(n || buffer_size == size);
+		new_buffer->user_data = buffer->user_data + size;
+		list_add(&new_buffer->entry, &buffer->entry);
+		new_buffer->free = 1;
+		binder_insert_free_buffer(alloc, new_buffer);
+		new_buffer = NULL;
 	}
 
 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
 		     "%d: binder_alloc_buf size %zd got buffer %pK size %zd\n",
 		      alloc->pid, size, buffer, buffer_size);
 
-	WARN_ON(n && buffer_size != size);
-
 	has_page_addr = (buffer->user_data + buffer_size) & PAGE_MASK;
 	end_page_addr = PAGE_ALIGN(buffer->user_data + size);
 	if (end_page_addr > has_page_addr)
 		end_page_addr = has_page_addr;
 	binder_allocate_page_range(alloc, PAGE_ALIGN(buffer->user_data),
 				   end_page_addr);
-	if (buffer_size != size) {
-		new_buffer->user_data = buffer->user_data + size;
-		list_add(&new_buffer->entry, &buffer->entry);
-		new_buffer->free = 1;
-		binder_insert_free_buffer(alloc, new_buffer);
-		new_buffer = NULL;
-	}
 
-	rb_erase(best_fit, &alloc->free_buffers);
+	rb_erase(&buffer->rb_node, &alloc->free_buffers);
 	buffer->free = 0;
 	buffer->allow_user_free = 0;
 	binder_insert_allocated_buffer_locked(alloc, buffer);
-- 
2.43.0.rc2.451.g8631bc7472-goog

