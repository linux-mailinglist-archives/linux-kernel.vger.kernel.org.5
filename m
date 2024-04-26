Return-Path: <linux-kernel+bounces-160646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466168B408B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B151C217EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4B28382;
	Fri, 26 Apr 2024 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBwp3rlY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E627473
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161355; cv=none; b=LExUYfhsHPOoztT4ue1cFjUQlrvrG65UCCjvkAR08imgAodf+sVKFGcSw1rn45/Np9UmeLcn5PlDaoCWJSDQC2NhppJPIzdqL+d6Mj1dn+Oj0F+g+vZHEs6w8Esc9K/N8w/mIFkIapzz9GnGelZlPxLpGiAteicbK7DZTCS06Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161355; c=relaxed/simple;
	bh=6AK1a+YGlSdrMLec/1Sholu7r5pO4ZP20qs3Z/D68a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dP9IsK7wk7+n+akLW9HvgjkLe4HeCZ5eCrZVO9QA3SM3rgt5YX9krv9pgIrzQoMu+QmO7Q1MLlHlrJfZThayRs2pUCBJObB4PbuYsBdmcfWiSgRXPtjDhrImvjnvANd/S8BpQ7g36+jwGYYYADmnY+N6CynElj7GUtRHk7VwlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBwp3rlY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714161352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYTN7Rkmmp1WWVEQ1FtYo1Y7cK63p7rGfuFTRkrq4H4=;
	b=EBwp3rlYvT9qB1hlhZf9F719x4j4E1x5bNHCHSsqEYNbPsx9TKnf5vGiXrycglm+7tqmy1
	QrD4v1S0Whha4RdrnU9fDG/vWiSUKoya500GxjLtEs21ZFYzKbhHU/eD5lvDinsxR0OL1O
	fGqBuPVahOel/Dca5ZBogk0IFmxdK/A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-YWlZr5STM6yyMvzcviNNOQ-1; Fri, 26 Apr 2024 15:55:51 -0400
X-MC-Unique: YWlZr5STM6yyMvzcviNNOQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6a087bba1c9so29189886d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161351; x=1714766151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYTN7Rkmmp1WWVEQ1FtYo1Y7cK63p7rGfuFTRkrq4H4=;
        b=FHVWotpJZiAbS43Gr8vHinA9Kgh0+G1nmYjKvNtzISV75D6DJxAl7NCLZgfFwkpk8c
         oq+vbNqtAzywHV0vIu6GYuzLdsNMpTWX3VbF2Y+ENxGRFilBaTmkKs+eYD/BMbUfnVMy
         aeT88R3d4yXHaeRMZJJVTc3JrEQ2ec1vKjFITTbjAlWdWj9WtNIYVQyA1F5I8VKx0sgb
         7yQg1OmreR8fSDFniNmsxE+n8ZTfgYNpf3kHh+npgcV6FUHSI+wPD1JwU+DZYDyKRmOw
         fTIuZRy2yqHe3LRJG2UX3aFC4ayuVQZgEA3r2iojmxi5hIDexJjqre7c6aRXBa2Fw1R9
         4Xag==
X-Forwarded-Encrypted: i=1; AJvYcCX0z3OqB9M27FaUTKIucHheY6M2Rknp9O0tPiTaeFK7LjAG1j9y1s4pfXpqkAUVf9fMJuF+JBlIB1zik6kNnt8vBoXHABA6DJkytiIj
X-Gm-Message-State: AOJu0YwFDqrmbNwHQPscjOXyoqu0aTbz7pnC2Kuc3FiID4oH/WmNHfdX
	i3emkEQcojgJUz7r0bYNN8DRB7ZB+2EWISJGo3IQeD9u44ls/mQgh1PMaBweoJSjIKstQxaGE6F
	KcQ7KDwyBSEFbaTopv4NH05+6E7vT8LBo0PDr5j2BMppZTIQbof9u5Adw9dmKQg==
X-Received: by 2002:ad4:5ca3:0:b0:6a0:7e34:b70d with SMTP id q3-20020ad45ca3000000b006a07e34b70dmr794254qvh.39.1714161351051;
        Fri, 26 Apr 2024 12:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmzcCv0w9vmIOTyVKZqwKRolLaIQkIYXO1xIFSQqQQoX9JIOBYX5RY7O8hZ+Fcf1u0NlO4Ng==
X-Received: by 2002:ad4:5ca3:0:b0:6a0:7e34:b70d with SMTP id q3-20020ad45ca3000000b006a07e34b70dmr794243qvh.39.1714161350746;
        Fri, 26 Apr 2024 12:55:50 -0700 (PDT)
Received: from fedora.redhat.com ([142.189.203.61])
        by smtp.gmail.com with ESMTPSA id v3-20020ad45343000000b006a0404ce6afsm1882268qvs.140.2024.04.26.12.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:55:50 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexl@redhat.com,
	echanude@redhat.com,
	ikent@redhat.com,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: [RFC v2 1/1] fs/namespace: defer RCU sync for MNT_DETACH umount
Date: Fri, 26 Apr 2024 15:53:48 -0400
Message-ID: <20240426195429.28547-2-lkarpins@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426195429.28547-1-lkarpins@redhat.com>
References: <20240426195429.28547-1-lkarpins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use call_rcu to defer releasing the detached filesystem when calling
namespace_unlock() during a lazy umount.

When detaching (MNT_DETACH) a filesystem, it should not be necessary to
wait for the grace period before completing the syscall. The
expectation that the filesystem is shut down by the time the syscall
returns does not apply in this case.

Calling synchronize_rcu_expedited() has a significant cost on RT kernel
that default to rcupdate.rcu_normal_after_boot=1. The struct mount
umount'ed are queued up for release in a separate list
once the grace period completes while no longer accessible to following
syscalls.

Without patch, on 6.9.0-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.02756 +- 0.00299 seconds time elapsed  ( +- 10.84% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.04422 +- 0.00521 seconds time elapsed  ( +- 11.79% )

With patch, on 6.9.0-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
	0.02852 +- 0.00377 seconds time elapsed  ( +- 13.20% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.0030812 +- 0.0000524 seconds time elapsed  ( +-  1.70% )

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 fs/namespace.c | 51 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..df03fc0d1990 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -45,6 +45,11 @@ static unsigned int m_hash_shift __ro_after_init;
 static unsigned int mp_hash_mask __ro_after_init;
 static unsigned int mp_hash_shift __ro_after_init;
 
+struct mount_delayed_release {
+	struct rcu_head rcu;
+	struct hlist_head release_list;
+};
+
 static __initdata unsigned long mhash_entries;
 static int __init set_mhash_entries(char *str)
 {
@@ -78,6 +83,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static bool lazy_unlock = false; /* protected by namespace_sem */
 
 struct mount_kattr {
 	unsigned int attr_set;
@@ -1553,16 +1559,39 @@ int may_umount(struct vfsmount *mnt)
 
 EXPORT_SYMBOL(may_umount);
 
-static void namespace_unlock(void)
+static void free_mounts(struct hlist_head *mount_list)
 {
-	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
+
+	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
+		hlist_del(&m->mnt_umount);
+		mntput(&m->mnt);
+	}
+}
+
+static void delayed_mount_release(struct rcu_head *head)
+{
+	struct mount_delayed_release *drelease =
+		container_of(head, struct mount_delayed_release, rcu);
+
+	free_mounts(&drelease->release_list);
+	kfree(drelease);
+}
+
+static void namespace_unlock(void)
+{
+	HLIST_HEAD(head);
 	LIST_HEAD(list);
+	bool lazy;
+
 
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 
+	lazy = lazy_unlock;
+	lazy_unlock = false;
+
 	up_write(&namespace_sem);
 
 	shrink_dentry_list(&list);
@@ -1570,12 +1599,21 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
+	if (lazy) {
+		struct mount_delayed_release *drelease =
+			kmalloc(sizeof(*drelease), GFP_KERNEL);
 
-	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
-		hlist_del(&m->mnt_umount);
-		mntput(&m->mnt);
+		if (unlikely(!drelease))
+			goto out;
+
+		hlist_move_list(&head, &drelease->release_list);
+		call_rcu(&drelease->rcu, delayed_mount_release);
+		return;
 	}
+
+out:
+	synchronize_rcu_expedited();
+	free_mounts(&head);
 }
 
 static inline void namespace_lock(void)
@@ -1798,6 +1836,7 @@ static int do_umount(struct mount *mnt, int flags)
 	}
 out:
 	unlock_mount_hash();
+	lazy_unlock = flags & MNT_DETACH ? true : false;
 	namespace_unlock();
 	return retval;
 }
-- 
2.44.0


