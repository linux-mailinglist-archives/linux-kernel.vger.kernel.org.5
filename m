Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C31079312C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbjIEVpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbjIEVom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735ACE60
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693950169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4qwgXUgzQeLfKMT3tv3YVc7S/hLt8ARXOPSgsfGIQ4=;
        b=XtHLdi6r6DtJCVMPx5dQlW7HHYJ2QAKdDhxH/E0LH9lzibvJmy3vhjd1qVHgaxrM1LOiS5
        MdrxoJXI4rRDSmu9UwxHqKgPYxZFonBpKYeXUPHQF/30JZOHjR/pfrBvs1RiFhPqe1ZqtY
        aYoB/oO1uutN/ZSSbrMB6P0dkPMmSHc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-lLsrIXcTMGCDJCI5DUz_jQ-1; Tue, 05 Sep 2023 17:42:48 -0400
X-MC-Unique: lLsrIXcTMGCDJCI5DUz_jQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63c9463c116so6468536d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950163; x=1694554963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4qwgXUgzQeLfKMT3tv3YVc7S/hLt8ARXOPSgsfGIQ4=;
        b=WyRky7bljvuqu++itzdowO5P4hCHShL6eqDZ4sS2KqBnQvBETWuN7wmJD6fxmLeh/p
         ZXzd4Mx+E+gu2aE0svLJ6BMwPq9CuHCmqpZqK3lUtZ/3FOl67SuiUEL0lWZgtWAjDs2D
         sWjKE/k7lxs7ioTqwuHUJRr/QjggxajxD+7W10IbMHfY6DQSBZL0MV08m/sRjF2ERiVA
         bTI26H5KFf/y7gvahRuX8cH58sEWmyIDguO4cbCGw8SZMByTFFq7j0osstXPf0T0WYSx
         58W73F10fap/SmmaEqMV/QUIkIMhpwUDHUOmakcIicDOJ7gpdYUQBuTkHrgSh7mR/jDE
         H72A==
X-Gm-Message-State: AOJu0Yy73QFDc0kRC0UFBBv/AE3M89YY8pzDMUP8601apRHKAg7/wNKT
        0Hpna7r43+RcXvbxZojssqrYBWeAUnCKzJ0QGHW/zrO4qfbXjpvEhx8tzNbVzLJKG/QlgtoJxET
        XfnOilQK+I097hz56OI5P+mvLWaSHSnNC8zh6S/LgsRRtgkp6IU0hRBpJcUyWpUrQ0cvl3z+vHQ
        ui3+0r8g==
X-Received: by 2002:a05:6214:21e4:b0:64a:8d39:3378 with SMTP id p4-20020a05621421e400b0064a8d393378mr17304056qvj.4.1693950163094;
        Tue, 05 Sep 2023 14:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlS4tLxX3RT0SNIZn/SUsnHB3xGIbADDb9sPouLrcBV//Rq31qTbeRmNhRZtJnSN5gXEiBhA==
X-Received: by 2002:a05:6214:21e4:b0:64a:8d39:3378 with SMTP id p4-20020a05621421e400b0064a8d393378mr17304030qvj.4.1693950162797;
        Tue, 05 Sep 2023 14:42:42 -0700 (PDT)
Received: from x1n.redhat.com (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id i2-20020a37c202000000b007682af2c8aasm4396938qkm.126.2023.09.05.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 14:42:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Anish Moorthy <amoorthy@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Christian Brauner <brauner@kernel.org>, peterx@redhat.com,
        linux-fsdevel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH 4/7] fs/userfaultfd: Use exclusive waitqueue for poll()
Date:   Tue,  5 Sep 2023 17:42:32 -0400
Message-ID: <20230905214235.320571-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214235.320571-1-peterx@redhat.com>
References: <20230905214235.320571-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userfaultfd is the kind of fd that does not need a wake all semantics when
wake up.  Enqueue using the new POLL_ENQUEUE_EXCLUSIVE flag.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f7fda7d0c994..9c39adc398fc 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -994,7 +994,7 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 	struct userfaultfd_ctx *ctx = file->private_data;
 	__poll_t ret;
 
-	poll_wait(file, &ctx->fd_wqh, wait);
+	poll_wait_exclusive(file, &ctx->fd_wqh, wait);
 
 	if (!userfaultfd_is_initialized(ctx))
 		return EPOLLERR;
-- 
2.41.0

