Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E0C78C5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjH2NeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbjH2Ndi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9C01BE;
        Tue, 29 Aug 2023 06:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 948F26577E;
        Tue, 29 Aug 2023 13:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14D9C433CB;
        Tue, 29 Aug 2023 13:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315977;
        bh=sTZn7J1hYFAmKdoiLo7ASHPxYO7HdzgMSKciAVWEGkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5ZG3e7J1ldRGBWahY80aEehRYvVPD9ffcWJFJ60GeyuP469H7xMSCT1Qtow1htdk
         /K0eqhlnr2l/1b2ST/iMefkHaxZCeI/4VIjtgaNEadoj5zFYmZGmNOzjmK/zScvzCD
         t43miQoLjT6FkLwc9MlaCqY3qmphYEhHAZBvtUN47JAtMgZyywrKDoOBN+VCQx13Q+
         o2n3X0/OOF21Kdti0l8DoYPiGIhAmFxqyLRhT7yNUpET1wFofz7Z7xRGbdeGycGXH0
         t50vGLbAItAO+6cYzRFUPESTLsfJkZmiYeJJbVyjHLog3d01fSKSnlZWRm7a2/0MNu
         U8Hlu/pWgdGOQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 06/15] cifs: fix sockaddr comparison in iface_cmp
Date:   Tue, 29 Aug 2023 09:32:36 -0400
Message-Id: <20230829133245.520176-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133245.520176-1-sashal@kernel.org>
References: <20230829133245.520176-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.49
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 2991b77409891e14a10b96899755c004b0c07edb ]

iface_cmp used to simply do a memcmp of the two
provided struct sockaddrs. The comparison needs to do more
based on the address family. Similar logic was already
present in cifs_match_ipaddr. Doing something similar now.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  | 37 -----------------------------
 fs/smb/client/cifsproto.h |  1 +
 fs/smb/client/connect.c   | 50 +++++++++++++++++++++++++++++++++++++++
 fs/smb/client/smb2ops.c   | 37 +++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+), 37 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a37afbb7e399f..4a092cc5a3936 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -970,43 +970,6 @@ release_iface(struct kref *ref)
 	kfree(iface);
 }
 
-/*
- * compare two interfaces a and b
- * return 0 if everything matches.
- * return 1 if a has higher link speed, or rdma capable, or rss capable
- * return -1 otherwise.
- */
-static inline int
-iface_cmp(struct cifs_server_iface *a, struct cifs_server_iface *b)
-{
-	int cmp_ret = 0;
-
-	WARN_ON(!a || !b);
-	if (a->speed == b->speed) {
-		if (a->rdma_capable == b->rdma_capable) {
-			if (a->rss_capable == b->rss_capable) {
-				cmp_ret = memcmp(&a->sockaddr, &b->sockaddr,
-						 sizeof(a->sockaddr));
-				if (!cmp_ret)
-					return 0;
-				else if (cmp_ret > 0)
-					return 1;
-				else
-					return -1;
-			} else if (a->rss_capable > b->rss_capable)
-				return 1;
-			else
-				return -1;
-		} else if (a->rdma_capable > b->rdma_capable)
-			return 1;
-		else
-			return -1;
-	} else if (a->speed > b->speed)
-		return 1;
-	else
-		return -1;
-}
-
 struct cifs_chan {
 	unsigned int in_reconnect : 1; /* if session setup in progress for this channel */
 	struct TCP_Server_Info *server;
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 98513f5af3f96..a914b88ca51a1 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -85,6 +85,7 @@ extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
 extern int smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx);
 extern int smb3_parse_opt(const char *options, const char *key, char **val);
+extern int cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern bool cifs_match_ipaddr(struct sockaddr *srcaddr, struct sockaddr *rhs);
 extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
 extern int cifs_call_async(struct TCP_Server_Info *server,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 935fe198a4baf..6e2744f0b545b 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1332,6 +1332,56 @@ cifs_demultiplex_thread(void *p)
 	module_put_and_kthread_exit(0);
 }
 
+int
+cifs_ipaddr_cmp(struct sockaddr *srcaddr, struct sockaddr *rhs)
+{
+	struct sockaddr_in *saddr4 = (struct sockaddr_in *)srcaddr;
+	struct sockaddr_in *vaddr4 = (struct sockaddr_in *)rhs;
+	struct sockaddr_in6 *saddr6 = (struct sockaddr_in6 *)srcaddr;
+	struct sockaddr_in6 *vaddr6 = (struct sockaddr_in6 *)rhs;
+
+	switch (srcaddr->sa_family) {
+	case AF_UNSPEC:
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+			return 0;
+		case AF_INET:
+		case AF_INET6:
+			return 1;
+		default:
+			return -1;
+		}
+	case AF_INET: {
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+			return -1;
+		case AF_INET:
+			return memcmp(saddr4, vaddr4,
+				      sizeof(struct sockaddr_in));
+		case AF_INET6:
+			return 1;
+		default:
+			return -1;
+		}
+	}
+	case AF_INET6: {
+		switch (rhs->sa_family) {
+		case AF_UNSPEC:
+		case AF_INET:
+			return -1;
+		case AF_INET6:
+			return memcmp(saddr6,
+				      vaddr6,
+				      sizeof(struct sockaddr_in6));
+		default:
+			return -1;
+		}
+	}
+	default:
+		return -1; /* don't expect to be here */
+	}
+}
+
 /*
  * Returns true if srcaddr isn't specified and rhs isn't specified, or
  * if srcaddr is specified and matches the IP address of the rhs argument
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index d512440d35b6f..759a7d7b3ddfe 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -510,6 +510,43 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	return rsize;
 }
 
+/*
+ * compare two interfaces a and b
+ * return 0 if everything matches.
+ * return 1 if a is rdma capable, or rss capable, or has higher link speed
+ * return -1 otherwise.
+ */
+static int
+iface_cmp(struct cifs_server_iface *a, struct cifs_server_iface *b)
+{
+	int cmp_ret = 0;
+
+	WARN_ON(!a || !b);
+	if (a->rdma_capable == b->rdma_capable) {
+		if (a->rss_capable == b->rss_capable) {
+			if (a->speed == b->speed) {
+				cmp_ret = cifs_ipaddr_cmp((struct sockaddr *) &a->sockaddr,
+							  (struct sockaddr *) &b->sockaddr);
+				if (!cmp_ret)
+					return 0;
+				else if (cmp_ret > 0)
+					return 1;
+				else
+					return -1;
+			} else if (a->speed > b->speed)
+				return 1;
+			else
+				return -1;
+		} else if (a->rss_capable > b->rss_capable)
+			return 1;
+		else
+			return -1;
+	} else if (a->rdma_capable > b->rdma_capable)
+		return 1;
+	else
+		return -1;
+}
+
 static int
 parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 			size_t buf_len, struct cifs_ses *ses, bool in_mount)
-- 
2.40.1

