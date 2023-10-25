Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1C7D6E18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjJYODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJYODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4734182
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698242533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rktb275++autG2dBh3wJ1wvqmgDO3Aq+V8t/EjWFz4M=;
        b=UAVGZsqAOi8Eq9FxhzkUxWCiIdIbkHQRO4ngTdK1ymVmVyxpHPaVkdPb+v3ldO0jKeaAcF
        hYij+xZIsjLwzLqeQULzFpXyC0vHSadUHoAin+4sf087BQUjWAujJtGJNpY0O0yq1VnYPg
        1QlPRBv47HPb9cZKNf1Eu7iSEDbGZSU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-s9JMx6ywO_2--QHIwX6m7Q-1; Wed, 25 Oct 2023 10:02:10 -0400
X-MC-Unique: s9JMx6ywO_2--QHIwX6m7Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae57d8b502so355647666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242529; x=1698847329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rktb275++autG2dBh3wJ1wvqmgDO3Aq+V8t/EjWFz4M=;
        b=ruCIFpfs4gD8rKQMFwrf9HDeNZ3Lo2vhMAcvnmRW5qiQvQHPWv853Tv6jL4JjJROmN
         WDJvamJkkJNLTy1epU2DZZXU1YX/IygJbqr+sLxkuymulWoSdVglcTinwoE/FuvW1iU8
         +Bi3JaFNeITrHfpY9HwAz4UnCDNcabIXRt7jP3sQ6i1i07zPI1+2Q831gYap9JcTdfi9
         qMoS6G/zmiVgzIKCScNprmmC7Yl7UeKD6xuCMUxmXUKzcbC2irFEh5/t62MgC+Jrkc9I
         uxllrRQwlStyjKbZ7kiV73OSi12ILA5Fc50i8pFdMYlf9rwjKjMKXBkKF6vtmNRulDJq
         z30w==
X-Gm-Message-State: AOJu0YxyijNs3LutGCSx5MG2GYHzcCwbMyFxy/ACIkPIdiomRJDH6YJd
        oih60POQbjrkwJIgEVGdfXiG0LkzKhcyp4U8Quz3cEDDSHycE82BnoLjfcylq7o03AgTI5jHOBW
        TH7mQjrg3L1PuSjcQ75tD04dC
X-Received: by 2002:a17:907:da3:b0:9c6:7ec2:e14e with SMTP id go35-20020a1709070da300b009c67ec2e14emr14335791ejc.50.1698242529019;
        Wed, 25 Oct 2023 07:02:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+8SDOqqdIbWYcTzs6rDMO30AFnhMq2M9Jv3S4dbLlbYvENSTjg76T9Wfx8VJm7Ip4DabhCA==
X-Received: by 2002:a17:907:da3:b0:9c6:7ec2:e14e with SMTP id go35-20020a1709070da300b009c67ec2e14emr14335764ejc.50.1698242528629;
        Wed, 25 Oct 2023 07:02:08 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:08 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 1/6] add unique mount ID
Date:   Wed, 25 Oct 2023 16:01:59 +0200
Message-ID: <20231025140205.3586473-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a mount is released then its mnt_id can immediately be reused.  This is
bad news for user interfaces that want to uniquely identify a mount.

Implementing a unique mount ID is trivial (use a 64bit counter).
Unfortunately userspace assumes 32bit size and would overflow after the
counter reaches 2^32.

Introduce a new 64bit ID alongside the old one.  Initialize the counter to
2^32, this guarantees that the old and new IDs are never mixed up.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/mount.h                | 3 ++-
 fs/namespace.c            | 4 ++++
 fs/stat.c                 | 9 +++++++--
 include/uapi/linux/stat.h | 1 +
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 130c07c2f8d2..a14f762b3f29 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -72,7 +72,8 @@ struct mount {
 	struct fsnotify_mark_connector __rcu *mnt_fsnotify_marks;
 	__u32 mnt_fsnotify_mask;
 #endif
-	int mnt_id;			/* mount identifier */
+	int mnt_id;			/* mount identifier, reused */
+	u64 mnt_id_unique;		/* mount ID unique until reboot */
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	struct hlist_head mnt_pins;
diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..e02bc5f41c7b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -68,6 +68,9 @@ static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
+/* Don't allow confusion with old 32bit mount ID */
+static atomic64_t mnt_id_ctr = ATOMIC64_INIT(1ULL << 32);
+
 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
 static struct kmem_cache *mnt_cache __read_mostly;
@@ -131,6 +134,7 @@ static int mnt_alloc_id(struct mount *mnt)
 	if (res < 0)
 		return res;
 	mnt->mnt_id = res;
+	mnt->mnt_id_unique = atomic64_inc_return(&mnt_id_ctr);
 	return 0;
 }
 
diff --git a/fs/stat.c b/fs/stat.c
index d43a5cc1bfa4..77878ae48a0f 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -243,8 +243,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
 
-	stat->mnt_id = real_mount(path.mnt)->mnt_id;
-	stat->result_mask |= STATX_MNT_ID;
+	if (request_mask & STATX_MNT_ID_UNIQUE) {
+		stat->mnt_id = real_mount(path.mnt)->mnt_id_unique;
+		stat->result_mask |= STATX_MNT_ID_UNIQUE;
+	} else {
+		stat->mnt_id = real_mount(path.mnt)->mnt_id;
+		stat->result_mask |= STATX_MNT_ID;
+	}
 
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..2f2ee82d5517 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -154,6 +154,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.41.0

