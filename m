Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42667E4E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjKHBgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjKHBf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:35:59 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0610EC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:35:53 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2f2b9a028so8691900b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 17:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699407352; x=1700012152;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Mjl5MPq5xqf4A9zcNVmoWwn/es7q6jVYi8sEJQqCdQ=;
        b=MqY9rvK3IjvUs+XqLwiyvUYreVqX0S/ga+LKo6h1LqF0m8P2S3LlhHfTC8MS//V1EF
         E2+C0a1/9n/VxazWNxEPFbBrZrtyGTnopUtN6T47NM3d1sJoywOE1anhMdxpPxKD3kfd
         UFiiJjHebDuAVW8J3cIgeQIdlVqgvfi3PvLyTO5GXuFwQz+LupXAbdLUVWlwgq20CVZI
         Z37XtBbwggv9+eqaTK0zvOA7DwwjCaUVQWYsS8WUliZJ/KVgUJCmJLeO48XsH7qvh+0z
         cWvDzIldLy/aPUDJWwCCkakvZswEuwkUP5wv5IA4Yo/tlY/jkGuuQaqsrFwl3r9EfvZ+
         kwQQ==
X-Gm-Message-State: AOJu0YykuTmJR7oF3fphW2tfqzg/DEs8qRmt1H3WfoC2Wxg7xo3KUxZZ
        uYqFPjLWZtWysfjPM1eJu3URIVnuOuP17V3bkjrftMNCdF1IuQk=
X-Google-Smtp-Source: AGHT+IGmxULDlb7akLBhi7JF2IehLA6tbcQ9IshHdKpjHePRJLnsEHYpJoUsnZVFkXlfCXgW6+Kd+/xHzBIsQ8ZP+hhqEvLa16qP
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1899:b0:3a7:27a:86e3 with SMTP id
 bi25-20020a056808189900b003a7027a86e3mr306374oib.3.1699407352475; Tue, 07 Nov
 2023 17:35:52 -0800 (PST)
Date:   Tue, 07 Nov 2023 17:35:52 -0800
In-Reply-To: <0000000000000014460609997fa2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092b9a206099a1b69@google.com>
Subject: Re: [syzbot] [PATCH] Test for 4652b8e4f3ff
From:   syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test for 4652b8e4f3ff
Author: eadavis@qq.com

please test warning in blk_mq_start_request

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4652b8e4f3ff

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 22a3cf7f32e2..0726534a5a24 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1724,6 +1724,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	cmd->fake_timeout = should_timeout_request(rq) ||
 		blk_should_fake_timeout(rq->q);
 
+	if (READ_ONCE(rq->state))
+		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	blk_mq_start_request(rq);
 
 	if (should_requeue_request(rq)) {

