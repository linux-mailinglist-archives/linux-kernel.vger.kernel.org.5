Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10A802C6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjLDHwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbjLDHwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:52:45 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A5102;
        Sun,  3 Dec 2023 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1701676352;
        bh=S9V/IJQi2EMf1kRNVARgwVZ9ApUdndNydZjX5OKBihc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KDc8hCKfDhh524oHnRJPJz0iNBKtq1KksoAS8/EBsl7Ak4JWrGsbbXOdVe6MMDUM4
         XfikUAI0N5MybtF9Lh//LM50eJilELIxaInUuWDBKyMvDd6gqAKsGpibPTN8X+imTO
         HMTwJbVN8BiCRjVmszIFT37OeQ88hi/Ykllu/AzY=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Mon, 04 Dec 2023 08:52:23 +0100
Subject: [PATCH v2 10/18] sysctl: treewide: constify
 ctl_table_root::permissions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-10-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=2382;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=S9V/IJQi2EMf1kRNVARgwVZ9ApUdndNydZjX5OKBihc=;
 b=HnfoCDmJBovIxiovoyRKYbwFwzbbCaj+R/sL4531aUB8MM1AzeDUZRnRsHT+2K69vhtsTyNUm
 2Sv5i/tkSuQCcDN+8GyyuUL1c56UbP9k3xL8fjP8ojnT386O28+fLCs
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a future commit the sysctl core will only use
"const struct ctl_table". As a preparation for that adapt the
permission callbacks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysctl.h | 2 +-
 ipc/ipc_sysctl.c       | 2 +-
 kernel/ucount.c        | 2 +-
 net/sysctl_net.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 800154e1ff88..92c1d0114cdc 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -207,7 +207,7 @@ struct ctl_table_root {
 	void (*set_ownership)(struct ctl_table_header *head,
 			      const struct ctl_table *table,
 			      kuid_t *uid, kgid_t *gid);
-	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
+	int (*permissions)(struct ctl_table_header *head, const struct ctl_table *table);
 };
 
 /* struct ctl_path describes where in the hierarchy a table is added */
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8c62e443f78b..b087787f608f 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -190,7 +190,7 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->ipc_set == set;
 }
 
-static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
+static int ipc_permissions(struct ctl_table_header *head, const struct ctl_table *table)
 {
 	int mode = table->mode;
 
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa6166cb856..90300840256b 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -38,7 +38,7 @@ static int set_is_seen(struct ctl_table_set *set)
 }
 
 static int set_permissions(struct ctl_table_header *head,
-				  struct ctl_table *table)
+			   const struct ctl_table *table)
 {
 	struct user_namespace *user_ns =
 		container_of(head->set, struct user_namespace, set);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 1310ef8f0958..2873a4fed47d 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -40,7 +40,7 @@ static int is_seen(struct ctl_table_set *set)
 
 /* Return standard mode bits for table entry. */
 static int net_ctl_permissions(struct ctl_table_header *head,
-			       struct ctl_table *table)
+			       const struct ctl_table *table)
 {
 	struct net *net = container_of(head->set, struct net, sysctls);
 

-- 
2.43.0

