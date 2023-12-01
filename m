Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC42801183
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378803AbjLARWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjLARW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:22:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264B3106
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:22:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d33b70fce8so32440057b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451355; x=1702056155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AZjI8klObjc7N6sbmt2D6zbV84xPOc+qihwnfC0tTI=;
        b=zfbOFtmfyvO4ZrOjLgZTGyEY1V6pazwSXt6qa/ruhYmLkqlf+rIl7KQfVp9LrUaWFH
         Njxe2Uw59EOGdw751Es6BbLeGe79Eypggyh8Pc/pd4apjLriE/F44jgHB2l6IH+uiwOc
         NM15ZYYcuzU5UdyGPMRMTUkTZViMrJlNvq0MecIOFXYT3mW6FQWGCl3tKhF+KkGlnJtX
         vLdlU2UnDOA4o3tWSGMpH9hLw6bp7Nmv9vrZ5gBKrbZ+P3btrvZGnk6VaUgQ25dk6HV5
         VQp7YfP/awQD+R3ldma4K3VsM2hozUu13re3h1SfZmhIeudrTg2/JNMf+TIc2KP/VU2J
         pNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451355; x=1702056155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AZjI8klObjc7N6sbmt2D6zbV84xPOc+qihwnfC0tTI=;
        b=TdAEzOFr/6Vertn0XWTZpKicqYiEqYD674tm0FQ5ZzV5k0VLq49l0VwHLpjNw38MoL
         waYaSCpYMWQom3Z1Oqxg7wlQnPeQUnPU3zfu1D8CNVmjOyC6nw3k4hEofjNz8tXkMwiv
         LFnROECUZNO1HMG/GO7uwRnorBtR3DrKlBbJ7fYnThjzDxIJjuxlzjAiU72He0T1Uv4a
         3d3ytu03mqW3UL2/xTmoIqloyalHfSTRNsnTIyp30LSqGZ8pBAseKPphkl4if4zmtXNc
         zyFQehmxwLFMpkq7Q5ied61KOrd2/O0MHvhC1DSa1jphc7zqUueQ2fUZfhCwShmEsM6j
         5zTA==
X-Gm-Message-State: AOJu0YxsV1VO/1a6rTzSIjgLGiUHjn+ZRzugvsAkCORQImxdG9DfM/Se
        +xi8UKuldXDl0TLDJHQ/lVlCOmqEOLPa1w==
X-Google-Smtp-Source: AGHT+IHjlNgO1/5SxxJWm9+fEpAT9H6aa9p5pj+fd3uju5TGuAZuKbSdeq0pNIcDZjKvXmptbIpeCMLeH61UKA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:98a:b0:5d3:e8b8:e1eb with SMTP
 id ce10-20020a05690c098a00b005d3e8b8e1ebmr122038ywb.1.1701451355403; Fri, 01
 Dec 2023 09:22:35 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:30 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-2-cmllamas@google.com>
Subject: [PATCH v2 01/28] binder: use EPOLLERR from eventpoll.h
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Eric Biggers <ebiggers@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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

Use EPOLLERR instead of POLLERR to make sure it is cast to the correct
__poll_t type. This fixes the following sparse issue:

  drivers/android/binder.c:5030:24: warning: incorrect type in return expression (different base types)
  drivers/android/binder.c:5030:24:    expected restricted __poll_t
  drivers/android/binder.c:5030:24:    got int

Fixes: f88982679f54 ("binder: check for binder_thread allocation failure in binder_poll()")
Cc: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 92128aae2d06..71a40a4c546f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5030,7 +5030,7 @@ static __poll_t binder_poll(struct file *filp,
 
 	thread = binder_get_thread(proc);
 	if (!thread)
-		return POLLERR;
+		return EPOLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
-- 
2.43.0.rc2.451.g8631bc7472-goog

