Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB37F46C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbjKVMt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343874AbjKVMt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:49:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339CF1BC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:49:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917EAC433D9;
        Wed, 22 Nov 2023 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700657391;
        bh=hkU4HuuqkNDsQyioSQIrRKs3Tgv1T8STkBb7WyDQZe8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sH8Tm1wP4EJijR7jWPvNmVl3mBtGkN3wNNGbSdSvEFuMdvkY1E+QcVQvJITT2RIsW
         PEZ3zcrNhYwSEpVPHfg4a4zhavH8mDv02NXVgiIbz8f69fdg4BB2d9Zli1lRzYSb6z
         EhsClQyaa8F9yvudTBUtM4my+Rx0dMR0LAc+gsTxCigYWjUsjR3qlZZqilJVkyWppo
         yGn3YPu1G4hIzrWGGgQSL4WErzUbY4QLyvvdHlzbxEk04+A1PVD2meTrRkiqNGZrYf
         zKCJTM3AbkjVz3eM9Q0Xi3c64W42/3N1VaWB+hvIpTkCgb37ZYi4HaREDHPLbxjZgc
         W9uhC2VfgcM3w==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 22 Nov 2023 13:48:24 +0100
Subject: [PATCH v2 3/4] eventfd: simplify eventfd_signal_mask()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-vfs-eventfd-signal-v2-3-bd549b14ce0c@kernel.org>
References: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
In-Reply-To: <20231122-vfs-eventfd-signal-v2-0-bd549b14ce0c@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, Oded Gabbay <ogabbay@kernel.org>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>, Fei Li <fei1.li@intel.com>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fpga@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-aio@kvack.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=3315; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hkU4HuuqkNDsQyioSQIrRKs3Tgv1T8STkBb7WyDQZe8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTG/liTnx+1a0vsCaGMN23r18xIsnV/pBwn1ZPp37Mqs
 7FRsi+uo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLd4YwMmxu+PXlzuflnQNcx
 jdSWzQFP5u+/ce54mkHTWs4J/1MYfRgZVub+qv3K3/m32t58z12JNyZxGoI5uyT1mLNNT0rt0T7
 KCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eventfd_signal_mask() helper was introduced for io_uring and similar
to eventfd_signal() it always passed 1 for @n. So don't bother with that
argument at all.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventfd.c            | 7 ++++---
 include/linux/eventfd.h | 5 ++---
 io_uring/io_uring.c     | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index dc9e01053235..a9a6de920fb4 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -43,9 +43,10 @@ struct eventfd_ctx {
 	int id;
 };
 
-__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
+__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __poll_t mask)
 {
 	unsigned long flags;
+	__u64 n = 1;
 
 	/*
 	 * Deadlock or stack overflow issues can happen if we recurse here
@@ -68,7 +69,7 @@ __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
 	current->in_eventfd = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
-	return n;
+	return n == 1;
 }
 
 /**
@@ -84,7 +85,7 @@ __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
  */
 __u64 eventfd_signal(struct eventfd_ctx *ctx)
 {
-	return eventfd_signal_mask(ctx, 1, 0);
+	return eventfd_signal_mask(ctx, 0);
 }
 EXPORT_SYMBOL_GPL(eventfd_signal);
 
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index 562089431551..4f8aac7eb62a 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -36,7 +36,7 @@ struct file *eventfd_fget(int fd);
 struct eventfd_ctx *eventfd_ctx_fdget(int fd);
 struct eventfd_ctx *eventfd_ctx_fileget(struct file *file);
 __u64 eventfd_signal(struct eventfd_ctx *ctx);
-__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask);
+__u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __poll_t mask);
 int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *wait,
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
@@ -63,8 +63,7 @@ static inline int eventfd_signal(struct eventfd_ctx *ctx)
 	return -ENOSYS;
 }
 
-static inline int eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n,
-				      unsigned mask)
+static inline int eventfd_signal_mask(struct eventfd_ctx *ctx, unsigned mask)
 {
 	return -ENOSYS;
 }
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ed254076c723..70170a41eac4 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -558,7 +558,7 @@ static void io_eventfd_ops(struct rcu_head *rcu)
 	int ops = atomic_xchg(&ev_fd->ops, 0);
 
 	if (ops & BIT(IO_EVENTFD_OP_SIGNAL_BIT))
-		eventfd_signal_mask(ev_fd->cq_ev_fd, 1, EPOLL_URING_WAKE);
+		eventfd_signal_mask(ev_fd->cq_ev_fd, EPOLL_URING_WAKE);
 
 	/* IO_EVENTFD_OP_FREE_BIT may not be set here depending on callback
 	 * ordering in a race but if references are 0 we know we have to free
@@ -594,7 +594,7 @@ static void io_eventfd_signal(struct io_ring_ctx *ctx)
 		goto out;
 
 	if (likely(eventfd_signal_allowed())) {
-		eventfd_signal_mask(ev_fd->cq_ev_fd, 1, EPOLL_URING_WAKE);
+		eventfd_signal_mask(ev_fd->cq_ev_fd, EPOLL_URING_WAKE);
 	} else {
 		atomic_inc(&ev_fd->refs);
 		if (!atomic_fetch_or(BIT(IO_EVENTFD_OP_SIGNAL_BIT), &ev_fd->ops))

-- 
2.42.0

