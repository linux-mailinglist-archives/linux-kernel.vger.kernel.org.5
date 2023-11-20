Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BCD7F10F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjKTK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjKTK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:56:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBBA129
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700477764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=58d2U9xwG/dFDTm6m8iS0jLQCEukimChxPfpR9Nt88k=;
        b=US7XIkJLTkayhuASJab74R9VZ5ik6LxEJszbgSnEbjn7UYFbg7MGh1b9f1TEU1ZCf2DHAt
        3+Nubkvhq6AUQ8Nk/kVBge4tJ/MSzPWyVjmkP/j4g49cX4BUI6DSBGDjxoSckRJqTZyrtk
        lXY/GBVBjCzxKay/GEF+7rcTd8GD53Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-1JNkX8rcO2iydwKGkdNdiQ-1; Mon, 20 Nov 2023 05:55:58 -0500
X-MC-Unique: 1JNkX8rcO2iydwKGkdNdiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78EC38007B3;
        Mon, 20 Nov 2023 10:55:58 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.8.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E4F65036;
        Mon, 20 Nov 2023 10:55:58 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, asml.silence@gmail.com, io-uring@vger.kernel.org,
        Charles Mirabile <cmirabil@redhat.com>, stable@vger.kernel.org
Subject: [PATCH] io_uring/fs: consider link->flags when getting path for LINKAT
Date:   Mon, 20 Nov 2023 05:55:45 -0500
Message-ID: <20231120105545.1209530-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for `AT_EMPTY_PATH` to work as expected, the fact
that the user wants that behavior needs to make it to `getname_flags`
or it will return ENOENT.

Fixes: cf30da90bc3a ("io_uring: add support for IORING_OP_LINKAT")
Cc: stable@vger.kernel.org
Link: https://github.com/axboe/liburing/issues/995
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 io_uring/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/fs.c b/io_uring/fs.c
index 08e3b175469c..eccea851dd5a 100644
--- a/io_uring/fs.c
+++ b/io_uring/fs.c
@@ -254,7 +254,7 @@ int io_linkat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	newf = u64_to_user_ptr(READ_ONCE(sqe->addr2));
 	lnk->flags = READ_ONCE(sqe->hardlink_flags);
 
-	lnk->oldpath = getname(oldf);
+	lnk->oldpath = getname_uflags(oldf, lnk->flags);
 	if (IS_ERR(lnk->oldpath))
 		return PTR_ERR(lnk->oldpath);
 
-- 
2.41.0

