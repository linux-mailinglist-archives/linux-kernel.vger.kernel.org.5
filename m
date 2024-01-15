Return-Path: <linux-kernel+bounces-26192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C482DC97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395F828290E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125FA17996;
	Mon, 15 Jan 2024 15:48:30 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537A91774C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-QAkLZRVbNMynMU_EIsS2Bw-1; Mon,
 15 Jan 2024 10:47:15 -0500
X-MC-Unique: QAkLZRVbNMynMU_EIsS2Bw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6458C3830084;
	Mon, 15 Jan 2024 15:47:14 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.45.226.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFF293C25;
	Mon, 15 Jan 2024 15:47:12 +0000 (UTC)
From: Alexey Gladkov <legion@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>,
	Linux Containers <containers@lists.linux.dev>,
	linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Joel Granados <joel.granados@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Manfred Spraul <manfred@colorfullife.com>
Subject: [RESEND PATCH v3 2/3] docs: Add information about ipc sysctls limitations
Date: Mon, 15 Jan 2024 15:46:42 +0000
Message-ID: <09e99911071766958af488beb4e8a728a4f12135.1705333426.git.legion@kernel.org>
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

After 25b21cb2f6d6 ("[PATCH] IPC namespace core") and 4e9823111bdc
("[PATCH] IPC namespace - shm") the shared memory page count stopped
being global and started counting per ipc namespace. The documentation
and shmget(2) still says that shmall is a global option.

shmget(2):

SHMALL System-wide limit on the total amount of shared memory, measured
in units of the system page size. On Linux, this limit can be read and
modified via /proc/sys/kernel/shmall.

I think the changes made in 2006 should be documented.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lkml.kernel.org/r/ede20ddf7be48b93e8084c3be2e920841ee1a641.1663756794.git.legion@kernel.org
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 6584a1f9bfe3..bc578663619d 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -594,6 +594,9 @@ default (``MSGMNB``).
 ``msgmni`` is the maximum number of IPC queues. 32000 by default
 (``MSGMNI``).
 
+All of these parameters are set per ipc namespace. The maximum number of bytes
+in POSIX message queues is limited by ``RLIMIT_MSGQUEUE``. This limit is
+respected hierarchically in the each user namespace.
 
 msg_next_id, sem_next_id, and shm_next_id (System V IPC)
 ========================================================
@@ -1274,15 +1277,20 @@ are doing anyway :)
 shmall
 ======
 
-This parameter sets the total amount of shared memory pages that
-can be used system wide. Hence, ``shmall`` should always be at least
-``ceil(shmmax/PAGE_SIZE)``.
+This parameter sets the total amount of shared memory pages that can be used
+inside ipc namespace. The shared memory pages counting occurs for each ipc
+namespace separately and is not inherited. Hence, ``shmall`` should always be at
+least ``ceil(shmmax/PAGE_SIZE)``.
 
 If you are not sure what the default ``PAGE_SIZE`` is on your Linux
 system, you can run the following command::
 
 	# getconf PAGE_SIZE
 
+To reduce or disable the ability to allocate shared memory, you must create a
+new ipc namespace, set this parameter to the required value and prohibit the
+creation of a new ipc namespace in the current user namespace or cgroups can
+be used.
 
 shmmax
 ======
-- 
2.43.0


