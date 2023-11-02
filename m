Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377007DFA8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377251AbjKBTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344104AbjKBTAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:00:35 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496ED186
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:32 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5788445ac04so924576a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951632; x=1699556432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FvviSjKh6nG6q/6y7Fz+nbn3fiyK99HefZSTalT2fjc=;
        b=fnbcsyTVrTLI/LkHKniqsYvUQ1UO2BwrDOMJxRwUXMe+9DX1N7E3jk+NEzKhl6i5mo
         1cr852XHxxhXJifeozl+Q4PysjNrWC4JXdscCjvcHN97qq5DS++9aNl8VNpSUBLfn3nx
         6KCEcrJcamaOb6j1bQxsSD00Ndy/woOM4ySQz8fjSNDuhFhs5VB3Gl7akmTh7DENBtMk
         gjQBAAhqWHrkPbEOblcGTpP1lJXybl+1HBLAWkm3QXSTsXCwsDsaJPNBJtkLeXsvIZb6
         QIBcGlITHvZ/8M1dPEThSFp33XNmbcNBFykvF2jzbcNF5B91dSyOjY62vgEjyEA8CDRz
         /JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951632; x=1699556432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvviSjKh6nG6q/6y7Fz+nbn3fiyK99HefZSTalT2fjc=;
        b=wdzbaGjPtxeo8T36Ea9KfrLI/Jlb3TnsZ/R9ank/lwOkhu503QoiiQSOk5uOgDsa5y
         Jjl+ghtJR32PFwdxGO+zG0wBLEicJcScnt1ntXdhj9Co2HcZeA6BlTn3/jEoAyHT2mKc
         4j35d1H6RlrRZ4/mDig6lw7+ThBrx6Qug4ePD14Fl4SD+DT82dVFmgMXjsvyYrd6ke7C
         2ECQhEaXWaOywESYuChKt43+achGRZimnbJB4B7ENzemMMW5VQW6AFv4A1LwTUUxKBVo
         3ekoNiun0xZRIeX00JHvcuNlp2nCpKhXg5w9WyOmfBXB4zAG4YzIeUdLAJ8lhwQo2D4q
         w7pQ==
X-Gm-Message-State: AOJu0Yw352lRfWmUCLDXUN1ES+2mHVjFUtJt1GMUJow+Yj9lHexQqxta
        TyGLfdHWy/NeOqer4pOUKCNhY0l+hpCBtw==
X-Google-Smtp-Source: AGHT+IHUUVVoHrvVmrGxM26PFwINOQONvUg5f1oymgucweL3HiaVmmpXjKnd0+GWhYGrOeJGmE2oXzxLJo5stQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:9553:0:b0:5b2:c2ad:f7ba with SMTP id
 t19-20020a639553000000b005b2c2adf7bamr349358pgn.2.1698951631708; Thu, 02 Nov
 2023 12:00:31 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:02 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-2-cmllamas@google.com>
Subject: [PATCH 01/21] binder: use EPOLLERR from eventpoll.h
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
        stable@vger.kernel.org
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
2.42.0.869.gea05f2083d-goog

