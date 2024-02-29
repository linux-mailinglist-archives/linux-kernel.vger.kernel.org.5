Return-Path: <linux-kernel+bounces-86969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA986CDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C783C1C22126
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8881649A8;
	Thu, 29 Feb 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+KWhkld"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BC16089A;
	Thu, 29 Feb 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221770; cv=none; b=nQGr891dvB7TNAvtCFoW0Wi07RI1fPPhAcIScCYE4SHPin6KGuaJbXzHoYY9woRqjIad6CxCUAUrNcuzkz/NsgtWfeHCix11mfVIFEWdJlQyb7z7UqXogixBmuvFhMWa/H8MzWMenPof486nvvFiKzkU0NFkbg+TiTm74HqQr8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221770; c=relaxed/simple;
	bh=b8cQIG7tbKy9aImMC3j5Q1k05g0Cb/ZvOj3NCbZlJw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lmuhz5WiJzjU4/Tc3Z7INJrLHC2Qwo6JP6SO7pSMldiMMHZpIFV5XGYLXI+6RjjaXcuhfUc++knyfYoFkhi7fP3T0ZzGo0zpGb9YnjjekhPuc75TUwZfjXWGSnH+4+PLsDKk/FqlZ9n0dDjhf4J1H6cVLLDSh33sz/+RZF+qmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+KWhkld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294B3C433F1;
	Thu, 29 Feb 2024 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221770;
	bh=b8cQIG7tbKy9aImMC3j5Q1k05g0Cb/ZvOj3NCbZlJw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+KWhkldaw0C0YLFmcaGBWoCWlxW9eWaAX3178pi9kRyVP2Vry1xq7CpjVwfEGe7s
	 tVo0KA1wy+oqP/OW1WeTTKS8hjzJJx4MgjGeLxgXp7SmHkz6VkUyEU3CMjPYYZO/j6
	 2UkIagfw8Cfj+WDb3kspEVlSSElRnKHu2UI0MuxFsZP0SahQRPk/SudZOiY4HGr8QA
	 0/dympiGgpsP5Ul+nNi/0ZszQoVyXdKztFEVUuQJv8HoyOzWxgwV0rOQ4ZgO/8nal6
	 blkfRZEZdbIeffL6CJVbOhQBa7iJZ7ERUgVHmYIjfriV1HE90Y2naxfa3Y3wHGupBg
	 lL2Q21syPtlyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 21/26] ceph: add ceph_cap_unlink_work to fire check_caps() immediately
Date: Thu, 29 Feb 2024 10:48:40 -0500
Message-ID: <20240229154851.2849367-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154851.2849367-1-sashal@kernel.org>
References: <20240229154851.2849367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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
index ad4d5387aa1c8..b19cb515683dd 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4777,7 +4777,22 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
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
index 558c3af44449c..4d29fe4f42869 100644
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
@@ -5346,6 +5390,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	INIT_LIST_HEAD(&mdsc->cap_delay_list);
 	INIT_LIST_HEAD(&mdsc->cap_wait_list);
 	spin_lock_init(&mdsc->cap_delay_lock);
+	INIT_LIST_HEAD(&mdsc->cap_unlink_delay_list);
+	spin_lock_init(&mdsc->cap_unlink_delay_lock);
 	INIT_LIST_HEAD(&mdsc->snap_flush_list);
 	spin_lock_init(&mdsc->snap_flush_lock);
 	mdsc->last_cap_flush_tid = 1;
@@ -5354,6 +5400,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	spin_lock_init(&mdsc->cap_dirty_lock);
 	init_waitqueue_head(&mdsc->cap_flushing_wq);
 	INIT_WORK(&mdsc->cap_reclaim_work, ceph_cap_reclaim_work);
+	INIT_WORK(&mdsc->cap_unlink_work, ceph_cap_unlink_work);
 	err = ceph_metric_init(&mdsc->metric);
 	if (err)
 		goto err_mdsmap;
@@ -5627,6 +5674,7 @@ void ceph_mdsc_close_sessions(struct ceph_mds_client *mdsc)
 	ceph_cleanup_global_and_empty_realms(mdsc);
 
 	cancel_work_sync(&mdsc->cap_reclaim_work);
+	cancel_work_sync(&mdsc->cap_unlink_work);
 	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
 
 	doutc(cl, "done\n");
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2e6ddaa13d725..714360536ad4a 100644
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


