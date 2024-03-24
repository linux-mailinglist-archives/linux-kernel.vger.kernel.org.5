Return-Path: <linux-kernel+bounces-113626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2CF8885C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7A2288DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6201D4C54;
	Sun, 24 Mar 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBg2N3Dr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AD76413;
	Sun, 24 Mar 2024 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320460; cv=none; b=W/rl3mTzlKT7iDstc91rwlqd+8U+ZC6FjDvXTofBekCVmr3BNPrRcjsRk5ZvZGGnXSjkZllAdUFXUMXBC/zQ8eQmptZIQUhlwWa9+DaZ5yKQXusFvVCLsWHncbVnBLLW0/UQzgYeWILbkRYbRU8D7UDS5DszQ3Gk10qlbagMR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320460; c=relaxed/simple;
	bh=VyzNqOFQS62GncXZLcr0NESX0J1naNhNSZOilaqAki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3zPJN9/S8ac35rRp2Am5Bt0V8M2SretlUYo8k/tWoo1I0tdk5bXj/nvktqh+KC/795248Vn2AqeCdkBSVZ68Me+NqzGFQrDoC3xeP8+xPPwv51CqNQ82T8n/fn+j7UVZp64NEU8GAetJWRUyCIe7944TtvCfpww9ynV1TEpTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBg2N3Dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD1C433F1;
	Sun, 24 Mar 2024 22:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320460;
	bh=VyzNqOFQS62GncXZLcr0NESX0J1naNhNSZOilaqAki8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBg2N3DrfODrjTdZRQo3YutF4uBw5X0+kL2EoE9fjKU9sZa/tRAE6tlygsIhzwtDo
	 wOQp4Hq6BVnAbqzNvfpFwY84Oz6TZDctzSScRgIvhez7p4KJd2hwxT2TGJBe8nx39A
	 bF54l02MWNBv2WcXgbFVshrAt96qSxAwo1k1qa4OvaLQdeUJ3UFaaWCthJtBHSoli9
	 kV00Rmb9wWQ6INUxy3P3exBsNs873tk0Wm0w3jJbrRbfI+DmKii6SzmSkwepIG5KPY
	 mKIUKx/MNqlzqVQTFxKJnVvMzdyan+MzXKtrSQtDH9XALcwXHrVuJapoO9peSjJVNa
	 G4a9nOAh2xdSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 019/713] ceph: add ceph_cap_unlink_work to fire check_caps() immediately
Date: Sun, 24 Mar 2024 18:35:45 -0400
Message-ID: <20240324224720.1345309-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit dbc347ef7f0c53aa4a5383238a804d7ebbb0b5ca ]

When unlinking a file the check caps could be delayed for more than
5 seconds, but in MDS side it maybe waiting for the clients to
release caps.

This will use the cap_wq work queue and a dedicated list to help
fire the check_caps() and dirty buffer flushing immediately.

Link: https://tracker.ceph.com/issues/50223
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c       | 17 +++++++++++++++-
 fs/ceph/mds_client.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  5 +++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index bce3a840f15c2..7fb4aae974124 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4772,7 +4772,22 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
 		if (__ceph_caps_dirty(ci)) {
 			struct ceph_mds_client *mdsc =
 				ceph_inode_to_fs_client(inode)->mdsc;
-			__cap_delay_requeue_front(mdsc, ci);
+
+			doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
+			      ceph_vinop(inode));
+			spin_lock(&mdsc->cap_unlink_delay_lock);
+			ci->i_ceph_flags |= CEPH_I_FLUSH;
+			if (!list_empty(&ci->i_cap_delay_list))
+				list_del_init(&ci->i_cap_delay_list);
+			list_add_tail(&ci->i_cap_delay_list,
+				      &mdsc->cap_unlink_delay_list);
+			spin_unlock(&mdsc->cap_unlink_delay_lock);
+
+			/*
+			 * Fire the work immediately, because the MDS maybe
+			 * waiting for caps release.
+			 */
+			ceph_queue_cap_unlink_work(mdsc);
 		}
 	}
 	spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2eb66dd7d01b2..950360b07536b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2470,6 +2470,50 @@ void ceph_reclaim_caps_nr(struct ceph_mds_client *mdsc, int nr)
 	}
 }
 
+void ceph_queue_cap_unlink_work(struct ceph_mds_client *mdsc)
+{
+	struct ceph_client *cl = mdsc->fsc->client;
+	if (mdsc->stopping)
+		return;
+
+        if (queue_work(mdsc->fsc->cap_wq, &mdsc->cap_unlink_work)) {
+                doutc(cl, "caps unlink work queued\n");
+        } else {
+                doutc(cl, "failed to queue caps unlink work\n");
+        }
+}
+
+static void ceph_cap_unlink_work(struct work_struct *work)
+{
+	struct ceph_mds_client *mdsc =
+		container_of(work, struct ceph_mds_client, cap_unlink_work);
+	struct ceph_client *cl = mdsc->fsc->client;
+
+	doutc(cl, "begin\n");
+	spin_lock(&mdsc->cap_unlink_delay_lock);
+	while (!list_empty(&mdsc->cap_unlink_delay_list)) {
+		struct ceph_inode_info *ci;
+		struct inode *inode;
+
+		ci = list_first_entry(&mdsc->cap_unlink_delay_list,
+				      struct ceph_inode_info,
+				      i_cap_delay_list);
+		list_del_init(&ci->i_cap_delay_list);
+
+		inode = igrab(&ci->netfs.inode);
+		if (inode) {
+			spin_unlock(&mdsc->cap_unlink_delay_lock);
+			doutc(cl, "on %p %llx.%llx\n", inode,
+			      ceph_vinop(inode));
+			ceph_check_caps(ci, CHECK_CAPS_FLUSH);
+			iput(inode);
+			spin_lock(&mdsc->cap_unlink_delay_lock);
+		}
+	}
+	spin_unlock(&mdsc->cap_unlink_delay_lock);
+	doutc(cl, "done\n");
+}
+
 /*
  * requests
  */
@@ -5345,6 +5389,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	INIT_LIST_HEAD(&mdsc->cap_delay_list);
 	INIT_LIST_HEAD(&mdsc->cap_wait_list);
 	spin_lock_init(&mdsc->cap_delay_lock);
+	INIT_LIST_HEAD(&mdsc->cap_unlink_delay_list);
+	spin_lock_init(&mdsc->cap_unlink_delay_lock);
 	INIT_LIST_HEAD(&mdsc->snap_flush_list);
 	spin_lock_init(&mdsc->snap_flush_lock);
 	mdsc->last_cap_flush_tid = 1;
@@ -5353,6 +5399,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	spin_lock_init(&mdsc->cap_dirty_lock);
 	init_waitqueue_head(&mdsc->cap_flushing_wq);
 	INIT_WORK(&mdsc->cap_reclaim_work, ceph_cap_reclaim_work);
+	INIT_WORK(&mdsc->cap_unlink_work, ceph_cap_unlink_work);
 	err = ceph_metric_init(&mdsc->metric);
 	if (err)
 		goto err_mdsmap;
@@ -5626,6 +5673,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	ceph_cleanup_global_and_empty_realms(mdsc);
 
 	cancel_work_sync(&mdsc->cap_reclaim_work);
+	cancel_work_sync(&mdsc->cap_unlink_work);
 	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
 
 	doutc(cl, "done\n");
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 40560af388272..03f8ff00874f7 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -462,6 +462,8 @@ struct ceph_mds_client {
 	unsigned long    last_renew_caps;  /* last time we renewed our caps */
 	struct list_head cap_delay_list;   /* caps with delayed release */
 	spinlock_t       cap_delay_lock;   /* protects cap_delay_list */
+	struct list_head cap_unlink_delay_list;  /* caps with delayed release for unlink */
+	spinlock_t       cap_unlink_delay_lock;  /* protects cap_unlink_delay_list */
 	struct list_head snap_flush_list;  /* cap_snaps ready to flush */
 	spinlock_t       snap_flush_lock;
 
@@ -475,6 +477,8 @@ struct ceph_mds_client {
 	struct work_struct cap_reclaim_work;
 	atomic_t	   cap_reclaim_pending;
 
+	struct work_struct cap_unlink_work;
+
 	/*
 	 * Cap reservations
 	 *
@@ -574,6 +578,7 @@ extern void ceph_flush_cap_releases(struct ceph_mds_client *mdsc,
 				    struct ceph_mds_session *session);
 extern void ceph_queue_cap_reclaim_work(struct ceph_mds_client *mdsc);
 extern void ceph_reclaim_caps_nr(struct ceph_mds_client *mdsc, int nr);
+extern void ceph_queue_cap_unlink_work(struct ceph_mds_client *mdsc);
 extern int ceph_iterate_session_caps(struct ceph_mds_session *session,
 				     int (*cb)(struct inode *, int mds, void *),
 				     void *arg);
-- 
2.43.0


