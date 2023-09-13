Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610579ECAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbjIMPXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbjIMPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5911BFD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694618565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTfXorS8NWDW0bcx6yY89gzPkWn52B0igCnyNn6sVfo=;
        b=bKaRgB7I5OYQPveuDKRkkA+4IVtvOhzIH3mjG1DrrrsIAPludRxF1hmaTkRR30chI4LNYp
        KuIspELHajlApASpLfVUpff2lDdGwdgzWCBhVNkOFRgz2NiJyggV27Jkx7sOpNOAtKXvAA
        M4wVsPS/dah1QVF7GlIU/Yf6oUMCEwY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-iwydRRdPOE6fHB1afG7X5Q-1; Wed, 13 Sep 2023 11:22:44 -0400
X-MC-Unique: iwydRRdPOE6fHB1afG7X5Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9aa20a75780so266351366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618563; x=1695223363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTfXorS8NWDW0bcx6yY89gzPkWn52B0igCnyNn6sVfo=;
        b=PWf3jxETYpQh98B6zQouGoYLiaGP1I1ln3Gx9fcHGTH6HrRydrS1G7AYDbUR0oQU+Z
         GhLwZWnwwU2Sqt7XDthnFlnEX6koV9stqizjFhwMs7yMNb6c+UFxfdHBZdtniTlp99H+
         kyFyCaaky3nv/cq3VoVAtnsqv/XcuJqlMs9fkhndKsMkV38WKpcQ1q9l35/Bab/Isb12
         +frby35ZzJZJWiEqMFlhpNDpjVk4nW/s37a8X/4Muc4nv4Njb/KoOvzrK+CiSO7ctdN+
         52pP5lSi1u66/QaXqs5Afg8r9xbzn8jhLhfHjtqk0yelhxetOBO02KzsQXly/xJCf9X1
         pBZw==
X-Gm-Message-State: AOJu0Yw7364Bj79m0wH0O4jg8/bk5TXrRvnPNz/DC1cMB+yeQWgSE/6X
        UAtEOXcQy3IQM+Tnm2lxPRneUv0v4jpFneYh0MX+G5+HZdudhQHVazP5Ml8o9fSRlyqcyrBLViG
        xiwqdFEHa1vnbhhZCK5DraXT8
X-Received: by 2002:a17:906:8a4a:b0:9a2:1e03:1573 with SMTP id gx10-20020a1709068a4a00b009a21e031573mr2203457ejc.65.1694618563221;
        Wed, 13 Sep 2023 08:22:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPav7CS9OAXNz5wCBb3Ckycl9EWcatp0ojEQPYZQSdhbugHLMMEeHnm8tMl75k1c+1hzp+Ig==
X-Received: by 2002:a17:906:8a4a:b0:9a2:1e03:1573 with SMTP id gx10-20020a1709068a4a00b009a21e031573mr2203439ejc.65.1694618562971;
        Wed, 13 Sep 2023 08:22:42 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (79-120-253-96.pool.digikabel.hu. [79.120.253.96])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906a09200b0099b8234a9fesm8640663ejy.1.2023.09.13.08.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:22:41 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: [RFC PATCH 1/3] add unique mount ID
Date:   Wed, 13 Sep 2023 17:22:34 +0200
Message-ID: <20230913152238.905247-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913152238.905247-1-mszeredi@redhat.com>
References: <20230913152238.905247-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a mount is released then it's mnt_id can immediately be reused.  This is
bad news for user interfaces that want to uniquely identify a mount.

Implementing a unique mount ID is trivial (use a 64bit counter).
Unfortunately userspace assumes 32bit size and would overflow after the
counter reaches 2^32.

Introduce a new 64bit ID alongside the old one.  Allow new interfaces to
work on both the old and new IDs by starting the counter from 2^32.

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
index e157efc54023..de47c5f66e17 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -68,6 +68,9 @@ static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
+/* Don't allow confusion with mount ID allocated wit IDA */
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
index 6822ac77aec2..46d901b6b2de 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -280,8 +280,13 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 
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

