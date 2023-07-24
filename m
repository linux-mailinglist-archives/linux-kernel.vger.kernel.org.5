Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3624475FA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGXOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGXOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:50:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8025210C3;
        Mon, 24 Jul 2023 07:50:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6862842a028so2409354b3a.0;
        Mon, 24 Jul 2023 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690210228; x=1690815028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9FgIAEGGUhV8Bu4h5u2096wjTv+qpp9D0lv6o0X1Os=;
        b=ptc2BUxx3eJRL2ESeln4TMtMZ5o5saooTWv+0/B6wgK4hw10z0yrHD9Nw2fsBXrQ1H
         oX0MT/nKxyWaS3YlZTNku5c4nK9gfkZa4BgbfvItSgMG+J+F1tPBd8zbDb74QdfEzhIb
         jZ5sybePeyeHF8Rijwb1EGTw8cQJLsbRROaxQgcXn3sdBuwTgVB8PV5aqiAVKqrebhrb
         tpIz0rA0PtyAY9yoRA/kdSw98AoDU+wd3qJyArnDu5zCbxhid29NK9Xwz4BbzSBrO1f0
         1YUeMTqXTR0XY8zTDeeG1p4QlDHHRCrgc3XW0s3eMuJyakFvOGHei7QXVF4Y2lKUSqLb
         UdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690210228; x=1690815028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9FgIAEGGUhV8Bu4h5u2096wjTv+qpp9D0lv6o0X1Os=;
        b=hEjIeMBIuWU3a+oAYQs/TO512K0h35M/N2Kf8gIuxnPCCSxi5M8fF6+1m0/h46I7cQ
         lfDZlPY9LDn9Ch3faOGs9zAz1B/qdghF6rBAQkPtRouRQTy3g0JuGUNn+BUC4oSrYfsC
         34/gExV29l1+DiQNh1aO4v8liUUqnf/ajVzUlxKvgWgmwOAkbAA/g+jjhUp4aCi1j3YF
         gjDmkr2X8hvQnI+AJl7pttg6ByK3wDVG6Pygls1J9kHA29V21Z/XqcfahnX+qMTAuPna
         SMY9ucUeZH2ug7JI9kITXbnRyd0a+2QDig7FbdQYxzASC5Q8wc68dqyIybc06HZU3r3+
         EbBA==
X-Gm-Message-State: ABy/qLaWNh5RhIlZFDLJ0SbkhhpzOuwpUDC7x1ppR7l46wjbC2laCZ9x
        QjP4q+BzlzNlDGOm+hUyamNe2ypy4KY=
X-Google-Smtp-Source: APBJJlFMZ8RANdQoPHnukFjFwlUwTdQ6RXBdcsp7hN2KNRuVwIr+EPpPeq8lz2UMrzl55cgy1/5Emw==
X-Received: by 2002:a05:6a00:a8a:b0:643:aa8d:8cd7 with SMTP id b10-20020a056a000a8a00b00643aa8d8cd7mr8363957pfl.32.1690210227606;
        Mon, 24 Jul 2023 07:50:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id 7-20020aa79147000000b0065980654baasm7805653pfi.130.2023.07.24.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:50:26 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Hackmann <ghackmann@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK)
Subject: [PATCH] dma-buf/sync_file: Fix docs syntax
Date:   Mon, 24 Jul 2023 07:49:41 -0700
Message-ID: <20230724145000.125880-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Fixes the warning:

  include/uapi/linux/sync_file.h:77: warning: Function parameter or member 'num_fences' not described in 'sync_file_info'

Fixes: 2d75c88fefb2 ("staging/android: refactor SYNC IOCTLs")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/uapi/linux/sync_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index 7e42a5b7558b..ff0a931833e2 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -56,7 +56,7 @@ struct sync_fence_info {
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
- * @num_fences	number of fences in the sync_file
+ * @num_fences:	number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
  * @sync_fence_info: pointer to array of struct &sync_fence_info with all
  *		 fences in the sync_file
-- 
2.41.0

