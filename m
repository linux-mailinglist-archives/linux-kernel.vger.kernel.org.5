Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF17758770
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjGRVqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGRVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:46:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BDD1992
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:46:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56fffdea2d0so41613857b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689716765; x=1692308765;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oZyVDwK3otNe1aFKsK5m2BlqgA8vBaRGLZSB3UKDdYk=;
        b=27sKt4FtC5mBSw5HOqwhYxE7xcBLqL/RurhtYGIoVYuuW1U7lCRJ1wgIvn1NlqMGFz
         +JUUgEkNRfYbj540DkK1jFVh5fEmOQ/jDHwgQtzx4CgSQizFaO0RcmwBBws17uhkYhOQ
         FLYCxHw6jFZ1li6J2pDfZoGcM5MKlQHuipDNS84IWaWx6xhmt2nFbnkF2GHcV9rWreYH
         NzpH/uqCkSCrZDq0IHKV8zigb4KT+ZsSGGe/ohjN/hIoL/7evqrgH5THd+MhJvMAURZR
         kwqBHb2U1ASLj71z5H2oCTc6GBf+Pwob4ljeHfuK9dWPk+5whLWQ3vYH7VVGZq+OkEGa
         b9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689716765; x=1692308765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZyVDwK3otNe1aFKsK5m2BlqgA8vBaRGLZSB3UKDdYk=;
        b=jRXX1Yyf3vjHz38o2s5+fTZyh9DndE7srqe9FeAFV04Op/NhNqc4nhKJDkVAVGRN+3
         sy2bjg8Bw2C6g4dwQgI1MJKpMr8AM93v19uZWnhJdg5a2KTCs9etTfF7BCSDeUrXs04G
         IY16Aq8k1vtR+l8N3NxBOqL0mJYfbtf1LHn8q1RxF9Uvv3oLKywkQQgKC6JZYeRrFsKE
         meBm5ViB2LfX2WJAnHv2GmX0rZmboFJUyIyQlu+jrRxrlLYDO1zaOrgmoDPsnSDkCSFo
         tcCGjIgq0t3J00rWxfgRqrsGEapKpO8X2JCi0h2LA9W0KP4gZ1VOn3C0fxvZZkidBZJp
         oidQ==
X-Gm-Message-State: ABy/qLYuCYnWf0/M7lhFK8STc9zuLiT2nKUH3wXxd1y4M4LZ8JSm87qL
        ckEAQ6Y3kEGFAKjw9QxNlTLp42fsREHKEJ8=
X-Google-Smtp-Source: APBJJlHdSd7OCAh4bUiKCrr5Fzb8ctcbPN9KVGaTCOvQpuKSQKH/lagJ588BacwVRKe8a2DfX/MHUTHa7Mxrl8A=
X-Received: from robbarnes3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6451])
 (user=robbarnes job=sendgmr) by 2002:a81:e448:0:b0:573:87b9:7ee9 with SMTP id
 t8-20020a81e448000000b0057387b97ee9mr181676ywl.4.1689716765754; Tue, 18 Jul
 2023 14:46:05 -0700 (PDT)
Date:   Tue, 18 Jul 2023 21:45:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
Subject: [PATCH] fs: export emergency_sync
From:   Rob Barnes <robbarnes@google.com>
To:     bleung@chromium.org, linux-fsdevel@vger.kernel.org
Cc:     Rob Barnes <robbarnes@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
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

emergency_sync forces a filesystem sync in emergency situations.
Export this function so it can be used by modules.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---

 fs/sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sync.c b/fs/sync.c
index dc725914e1edb..b313db0ebb5ee 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -142,6 +142,7 @@ void emergency_sync(void)
 		schedule_work(work);
 	}
 }
+EXPORT_SYMBOL(emergency_sync);
 
 /*
  * sync a single super
-- 
2.41.0.255.g8b1d071c50-goog

