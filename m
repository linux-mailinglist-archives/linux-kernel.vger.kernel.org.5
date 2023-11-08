Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC8E7E504D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjKHGZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:25:38 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E21BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:25:36 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-587abe0ab5cso4201751eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 22:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699424735; x=1700029535;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KBfjQQkp5hkWAsnRy6rSeQyF2diGxczYRTdLIzsKHQ=;
        b=CaOHhdIpUfrzQb36otpT3xlBdYyfu0SEr7gQpXzg1w4DI1G5afcVUWKvyCg5kYL1dX
         pIpqwuJN935v/Vf+Vr35UKNTyqYCk3ee0BEiCTTSHWMgQL/8MSz9mLESmLq6jYi6KFvP
         rDOz6D40qowvnO7qc1nATbh3QffbYrKbPZybttz4A2m+/CezGy1Ck0MNIGF9KL8kSIAQ
         82rsBUggVABz1yYyy88znaJdxPRRicZJIdCSNe7Z0t2gqgRy6AuLnjWiBcdciCg+o32a
         rRDQEFT5UwMcR/lwVm1sKtZ17uQCuQxm4Py1frK0ZpATr64v9AgL9gpaU3IKdA22OTLx
         FPEQ==
X-Gm-Message-State: AOJu0Yx92vXy7om13b2hVSCD/u1S5iJVIaQXufxoHF2m5mn9EQAtiD09
        2v5QYNgN6DkTax69kBjyAM/qOJzLmAg0YD/GRams2SUqypsEsbo=
X-Google-Smtp-Source: AGHT+IEFoBppXMJd3Sw/9i/p/tqTWRo7jXTFhv4BR8ULgTyNkj0ApRjnshdHJPXjhoihCRBxUXb42AYUUu6JIwCPP2XFtBJj8GP7
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c99:b0:589:db95:5070 with SMTP id
 ct25-20020a0568201c9900b00589db955070mr194152oob.1.1699424735432; Tue, 07 Nov
 2023 22:25:35 -0800 (PST)
Date:   Tue, 07 Nov 2023 22:25:35 -0800
In-Reply-To: <0000000000000014460609997fa2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad973506099e27e3@google.com>
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

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..26f2921cbc50 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2575,6 +2575,8 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 * Any other error (busy), just add it to our list as we
 	 * previously would have done.
 	 */
+	if (READ_ONCE(rq->state))
+		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	ret = q->mq_ops->queue_rq(hctx, &bd);
 	switch (ret) {
 	case BLK_STS_OK:

