Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2617917AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbjIDM7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjIDM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:59:30 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FD8133;
        Mon,  4 Sep 2023 05:59:27 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso1227248f8f.1;
        Mon, 04 Sep 2023 05:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832366; x=1694437166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP6axYWQh7IIQgU34+jYVnXWJpapDY8Z6JPbK/ak5xE=;
        b=LVV1Xb86FNQArwziq2HK7bpftnG0biqQSp1qSsZR3eGy4L14UUWEU0SmPUduTcZ0qT
         xa66FQ8mLin/pZaCreZuiKErmqMYh3oL7qLxokzRVE6VnOx4tdns7mPXtdkKtNaBHQpu
         OgNTtv0ESQoeX64Uq/Kyg+UPvl0Xx5Cl3a7t2li0JITNfRgypYw8EzB93e55PDsQRg2X
         GxL8XqRSfDzxHZSwvqM7JjnMAhJHq+FSuL7b+ByX7uJF8ZrKurIDm5xzOvdqIi65cCVM
         83CXaAyPi5fdlEJaKgQYslZ7F7kA9OvHEWsAcK6rpaiMcfvMFHeAAFu0FgceWUSrJMsg
         HB5Q==
X-Gm-Message-State: AOJu0YzM+tTXhy2v4DskKPj55EJIpb/HkM+WQiTneXGv+oKiz9A+mjUK
        45AR26h8UQRY4XP2x7c+35hwI7oP4bE=
X-Google-Smtp-Source: AGHT+IF0qRQK14yR/43i9K3BH4U5x+825w7/9gAwjY5qDnyahlv46xZNiwFCZgE4ucDeguS3FGobdg==
X-Received: by 2002:adf:e647:0:b0:31a:ea9f:1aa6 with SMTP id b7-20020adfe647000000b0031aea9f1aa6mr7227973wrn.47.1693832365727;
        Mon, 04 Sep 2023 05:59:25 -0700 (PDT)
Received: from salami.fritz.box ([80.111.96.134])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm14388746wrn.48.2023.09.04.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:59:25 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
Date:   Mon,  4 Sep 2023 13:59:12 +0100
Message-Id: <20230904125912.102225-1-git@andred.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: André Draszik <andre.draszik@linaro.org>

This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.

This patch breaks all existing userspace by requiring updates as
mentioned in the commit message, which is not allowed.

Revert to restore compatibility with existing userspace
implementations.

Cc: <stable@vger.kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 fs/fuse/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 549358ffea8b..0b966b0e0962 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1132,10 +1132,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		process_init_limits(fc, arg);
 
 		if (arg->minor >= 6) {
-			u64 flags = arg->flags;
-
-			if (flags & FUSE_INIT_EXT)
-				flags |= (u64) arg->flags2 << 32;
+			u64 flags = arg->flags | (u64) arg->flags2 << 32;
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)
-- 
2.40.1

