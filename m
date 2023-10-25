Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB97D68D7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbjJYKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjJYKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:35:24 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB7185
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:35:07 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 4A117C025; Wed, 25 Oct 2023 12:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698230106; bh=alDC8/pUNCLU3G+aaZxX11BvuNObZgKMGq1KaeSAe4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4ob44EnsAlv0DLYwv9MwUWumioP+1pIvVZpDstuu8eObyIa4eA3vphY/AUy6WNaH
         56lu/BH36rs54EWmAVP0tZisDWrTMrJvYbiZBTX+o7XXrgGXDs0zTgC+PMHujZfBuL
         M7aCnF7gakPNQ8+5IxQWF+1RhuKQn84lwIrm3izRxcvpZjOV/+AuQ6/c4oKxc6yx95
         ICCQR5m0kVo8c9o4E9VGF4rjzFEpu00+AD+bzpnFeorprOYfN7qu5HEW7YX2ZLiSKV
         LwV1Lbp/b111+VPEJdEDLO0WDB3ICbFcOnNes4GfC0gPecqFMUhZ5Dimdbm1Jv3Izn
         24ozAh7TAi0wQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id CECA9C01F;
        Wed, 25 Oct 2023 12:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698230104; bh=alDC8/pUNCLU3G+aaZxX11BvuNObZgKMGq1KaeSAe4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZurXGHQvdNpON1tO8sq6IhplF33P2ECIOGjNuOPLKzS3T3SiYIhcGnsoVAUANBEN6
         o2JyvYYypXjt9XM1yLBG4txzkVOtzYBrVGbCtB0h+BdZv5ATm70fEPRiYIy7BXjqCC
         mtFxmd2jvWnD3hrfq62FSomadTMiFdZm7e//dwSUGeWPuC17aVbdWWElUKFTvmfKMC
         AsjuaCkZX5WoZ9sVvBjWF0wePWH8ItH+HDI6nYzOQ4oWxQNmBcBP4ZGuW7Sr4QPx+y
         XFrd+cr0roJ9+NdbuWYhxiFMIuCoMwbKokAm9RgeFdGUO+L0saDYpoW7I9tz/5P8BL
         yYdyaUtmLp6UQ==
Received: from gaia.codewreck.org (localhost.lan [::1])
        by gaia (OpenSMTPD) with ESMTP id c2b62181;
        Wed, 25 Oct 2023 10:34:53 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs@lists.linux.dev
Cc:     ericvh@kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
        linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 3/3] 9p/net: xen: fix false positive printf format overflow warning
Date:   Wed, 25 Oct 2023 19:34:45 +0900
Message-ID: <20231025103445.1248103-3-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025103445.1248103-1-asmadeus@codewreck.org>
References: <20231025103445.1248103-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the constant to make the compiler happy about this warning:
net/9p/trans_xen.c: In function ‘xen_9pfs_front_changed’:
net/9p/trans_xen.c:444:39: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 8 [-Wformat-overflow=]
  444 |                 sprintf(str, "ring-ref%d", i);
      |                                       ^~
In function ‘xen_9pfs_front_init’,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:516:8,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:504:13:
net/9p/trans_xen.c:444:30: note: directive argument in the range [-2147483644, 2147483646]
  444 |                 sprintf(str, "ring-ref%d", i);
      |                              ^~~~~~~~~~~~
net/9p/trans_xen.c:444:17: note: ‘sprintf’ output between 10 and 20 bytes into a destination of size 16
  444 |                 sprintf(str, "ring-ref%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/9p/trans_xen.c: In function ‘xen_9pfs_front_changed’:
net/9p/trans_xen.c:450:45: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 2 [-Wformat-overflow=]
  450 |                 sprintf(str, "event-channel-%d", i);
      |                                             ^~
In function ‘xen_9pfs_front_init’,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:516:8,
    inlined from ‘xen_9pfs_front_changed’ at net/9p/trans_xen.c:504:13:
net/9p/trans_xen.c:450:30: note: directive argument in the range [-2147483644, 2147483646]
  450 |                 sprintf(str, "event-channel-%d", i);
      |                              ^~~~~~~~~~~~~~~~~~
net/9p/trans_xen.c:450:17: note: ‘sprintf’ output between 16 and 26 bytes into a destination of size 16
  450 |                 sprintf(str, "event-channel-%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is no change in logic: there only are a constant number of rings,
and there also already is a BUILD_BUG_ON that checks if that constant
goes over 9 as anything bigger would no longer fit the event-channel-%d
destination size.

In theory having that size as part of the struct means it could be
modified by another thread and makes the compiler lose track of possible
values for 'i' here, using the constant directly here makes it work.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Message-ID: <20231023233704.1185154-4-asmadeus@codewreck.org>
---
v1->v2:
- use constant directly instead of going through a local variable

 net/9p/trans_xen.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 1fffe2bed5b0..dfdbe1ca5338 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -54,7 +54,6 @@ struct xen_9pfs_front_priv {
 	char *tag;
 	struct p9_client *client;
 
-	int num_rings;
 	struct xen_9pfs_dataring *rings;
 };
 
@@ -131,7 +130,7 @@ static int p9_xen_request(struct p9_client *client, struct p9_req_t *p9_req)
 	if (list_entry_is_head(priv, &xen_9pfs_devs, list))
 		return -EINVAL;
 
-	num = p9_req->tc.tag % priv->num_rings;
+	num = p9_req->tc.tag % XEN_9PFS_NUM_RINGS;
 	ring = &priv->rings[num];
 
 again:
@@ -279,7 +278,7 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 	list_del(&priv->list);
 	write_unlock(&xen_9pfs_lock);
 
-	for (i = 0; i < priv->num_rings; i++) {
+	for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
 		struct xen_9pfs_dataring *ring = &priv->rings[i];
 
 		cancel_work_sync(&ring->work);
@@ -408,15 +407,14 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	if (p9_xen_trans.maxsize > XEN_FLEX_RING_SIZE(max_ring_order))
 		p9_xen_trans.maxsize = XEN_FLEX_RING_SIZE(max_ring_order) / 2;
 
-	priv->num_rings = XEN_9PFS_NUM_RINGS;
-	priv->rings = kcalloc(priv->num_rings, sizeof(*priv->rings),
+	priv->rings = kcalloc(XEN_9PFS_NUM_RINGS, sizeof(*priv->rings),
 			      GFP_KERNEL);
 	if (!priv->rings) {
 		kfree(priv);
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < priv->num_rings; i++) {
+	for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
 		priv->rings[i].priv = priv;
 		ret = xen_9pfs_front_alloc_dataring(dev, &priv->rings[i],
 						    max_ring_order);
@@ -434,10 +432,11 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 	if (ret)
 		goto error_xenbus;
 	ret = xenbus_printf(xbt, dev->nodename, "num-rings", "%u",
-			    priv->num_rings);
+			    XEN_9PFS_NUM_RINGS);
 	if (ret)
 		goto error_xenbus;
-	for (i = 0; i < priv->num_rings; i++) {
+
+	for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
 		char str[16];
 
 		BUILD_BUG_ON(XEN_9PFS_NUM_RINGS > 9);
-- 
2.41.0

