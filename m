Return-Path: <linux-kernel+bounces-26195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA082DC9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FC01C21DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14B9179AA;
	Mon, 15 Jan 2024 15:49:03 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB7179A5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-w6Of273vPOui2F9i1TlWMA-1; Mon, 15 Jan 2024 10:47:13 -0500
X-MC-Unique: w6Of273vPOui2F9i1TlWMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B82B482DFE7;
	Mon, 15 Jan 2024 15:47:12 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7723C25;
	Mon, 15 Jan 2024 15:47:11 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux Containers <containers@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Joel Granados <joel.granados@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
Subject: [RESEND PATCH v3 1/3] sysctl: Allow change system v ipc sysctls inside ipc namespace
Date: Mon, 15 Jan 2024 15:46:41 +0000
Message-ID: <d2f4603305cbfed58a24755aa61d027314b73a45.1705333426.git.legion@kernel.org>
In-Reply-To: <cover.1705333426.git.legion@kernel.org>
References: <cover.1663756794.git.legion@kernel.org> <cover.1705333426.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Rootless containers are not allowed to modify kernel IPC parameters.

All default limits are set to such high values that in fact there are no
limits at all. All limits are not inherited and are initialized to
default values when a new ipc_namespace is created.

For new ipc_namespace:

size_t       ipc_ns.shm_ctlmax = SHMMAX; // (ULONG_MAX - (1UL << 24))
size_t       ipc_ns.shm_ctlall = SHMALL; // (ULONG_MAX - (1UL << 24))
int          ipc_ns.shm_ctlmni = IPCMNI; // (1 << 15)
int          ipc_ns.shm_rmid_forced = 0;
unsigned int ipc_ns.msg_ctlmax = MSGMAX; // 8192
unsigned int ipc_ns.msg_ctlmni = MSGMNI; // 32000
unsigned int ipc_ns.msg_ctlmnb = MSGMNB; // 16384

The shm_tot (total amount of shared pages) has also ceased to be
global, it is located in ipc_namespace and is not inherited from
anywhere.

In such conditions, it cannot be said that these limits limit anything.
The real limiter for them is cgroups.

If we allow rootless containers to change these parameters, then it can
only be reduced.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
Link: https://lkml.kernel.org/r/e2d84d3ec0172cfff759e6065da84ce0cc2736f8.1663756794.git.legion@kernel.org
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 ipc/ipc_sysctl.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8c62e443f78b..01c4a50d22b2 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -14,6 +14,7 @@
 #include <linux/ipc_namespace.h>
 #include <linux/msg.h>
 #include <linux/slab.h>
+#include <linux/cred.h>
 #include "util.h"
 
 static int proc_ipc_dointvec_minmax_orphans(struct ctl_table *table, int write,
@@ -190,25 +191,57 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->ipc_set == set;
 }
 
+static void ipc_set_ownership(struct ctl_table_header *head,
+			      struct ctl_table *table,
+			      kuid_t *uid, kgid_t *gid)
+{
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, ipc_set);
+
+	kuid_t ns_root_uid = make_kuid(ns->user_ns, 0);
+	kgid_t ns_root_gid = make_kgid(ns->user_ns, 0);
+
+	*uid = uid_valid(ns_root_uid) ? ns_root_uid : GLOBAL_ROOT_UID;
+	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
+}
+
 static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
 {
 	int mode = table->mode;
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+	struct ipc_namespace *ns =
+		container_of(head->set, struct ipc_namespace, ipc_set);
 
 	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
 	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
 	    checkpoint_restore_ns_capable(ns->user_ns))
 		mode = 0666;
+	else
 #endif
-	return mode;
+	{
+		kuid_t ns_root_uid;
+		kgid_t ns_root_gid;
+
+		ipc_set_ownership(head, table, &ns_root_uid, &ns_root_gid);
+
+		if (uid_eq(current_euid(), ns_root_uid))
+			mode >>= 6;
+
+		else if (in_egroup_p(ns_root_gid))
+			mode >>= 3;
+	}
+
+	mode &= 7;
+
+	return (mode << 6) | (mode << 3) | mode;
 }
 
 static struct ctl_table_root set_root = {
 	.lookup = set_lookup,
 	.permissions = ipc_permissions,
+	.set_ownership = ipc_set_ownership,
 };
 
 bool setup_ipc_sysctls(struct ipc_namespace *ns)
-- 
2.43.0


