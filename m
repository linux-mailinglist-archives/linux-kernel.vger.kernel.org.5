Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636857AE9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjIZKER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbjIZKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:04:12 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B127196;
        Tue, 26 Sep 2023 03:04:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 944CA1C0007;
        Tue, 26 Sep 2023 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695722640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jRVKs6180ifIX9yx3k8bI6+Vilp7tEKq0AX18VzwduA=;
        b=FFAWjOYe+pVWpCDMEGbgw/Z2TxQy4MycS2ZMziVKj1uoipI2meXU5CnOxGOijwJyWds4NH
        vdUXPD9QnpkLgjOYZfLTI1p9vA3mgO8xXDnxf1L5cvCi9WOepCjXM5z9z7rrwQvOUripYz
        9MAROhuEcW3o/sjOyrPp0SEO5aZWNEYimaf+CmS00QAt76G0DCgeF0a2nE4gAdaUZlmPvs
        Rf53gcjLsYEc/V3pLwS68Yz6WeUiCmbXew5xGyLg5Zhju7jlKXnvOSb7EjaZfE27nt1xnm
        sqkE2HiwwprgEz1b2hwxXyIhiCOqNpRRyjShpkEOaE4sgHeyAUHp8ORBUy3Iog==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-media@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] staging: media: tegra-video: fix infinite recursion regression
Date:   Tue, 26 Sep 2023 12:03:53 +0200
Message-Id: <20230926100353.328001-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9bf19fbf0c8b ("media: v4l: async: Rework internal lists"), aka
v6.6-rc1~97^2~198, probing the tegra-video VI driver causes infinite
recursion due tegra_vi_graph_parse_one() calling itself until:

[    1.571168] Insufficient stack space to handle exception!
...
[    1.591416] Internal error: kernel stack overflow: 0 [#1] PREEMPT SMP ARM
...
[    3.861013]  of_phandle_iterator_init from __of_parse_phandle_with_args+0x40/0xf0
[    3.868497]  __of_parse_phandle_with_args from of_fwnode_graph_get_remote_endpoint+0x68/0xa8
[    3.876938]  of_fwnode_graph_get_remote_endpoint from fwnode_graph_get_remote_port_parent+0x30/0x7c
[    3.885984]  fwnode_graph_get_remote_port_parent from tegra_vi_graph_parse_one+0x7c/0x224
[    3.894158]  tegra_vi_graph_parse_one from tegra_vi_graph_parse_one+0x144/0x224
[    3.901459]  tegra_vi_graph_parse_one from tegra_vi_graph_parse_one+0x144/0x224
[    3.908760]  tegra_vi_graph_parse_one from tegra_vi_graph_parse_one+0x144/0x224
[    3.916061]  tegra_vi_graph_parse_one from tegra_vi_graph_parse_one+0x144/0x224
...
[    4.857892]  tegra_vi_graph_parse_one from tegra_vi_graph_parse_one+0x144/0x224
[    4.865193]  tegra_vi_graph_parse_one from tegra_vi_graph_parse_one+0x144/0x224
[    4.872494]  tegra_vi_graph_parse_one from tegra_vi_init+0x574/0x6d4
[    4.878842]  tegra_vi_init from host1x_device_init+0x84/0x15c
[    4.884594]  host1x_device_init from host1x_video_probe+0xa0/0x114
[    4.890770]  host1x_video_probe from really_probe+0xe0/0x400

The reason is the mentioned commit changed tegra_vi_graph_find_entity() to
search for an entity in the done notifier list:

> @@ -1464,7 +1464,7 @@ tegra_vi_graph_find_entity(struct tegra_vi_channel *chan,
>  	struct tegra_vi_graph_entity *entity;
>  	struct v4l2_async_connection *asd;
>
> -	list_for_each_entry(asd, &chan->notifier.asc_list, asc_entry) {
> +	list_for_each_entry(asd, &chan->notifier.done_list, asc_entry) {
>  		entity = to_tegra_vi_graph_entity(asd);
>  		if (entity->asd.match.fwnode == fwnode)
>  			return entity;

This is not always correct, being tegra_vi_graph_find_entity() called in
three locations, in this order:

 1. tegra_vi_graph_parse_one()    -- called while probing
 2. tegra_vi_graph_notify_bound() -- the .bound notifier op
 3. tegra_vi_graph_build()        -- called in the .complete notifier op

Locations 1 and 2 are called before moving the entity from waiting_list to
done_list, thus they won't find what they are looking for in
done_list. Location 3 happens afterwards and thus it is not broken, however
it means tegra_vi_graph_find_entity() should not search in the same list
every time.

The error appears at step 1: tegra_vi_graph_parse_one() iterates
recursively until it finds the entity already notified, which now never
happens.

Fix by passing the specific notifier list pointer to
tegra_vi_graph_find_entity() instead of the channel, so each caller can
search in whatever list is correct.

Also improve the tegra_vi_graph_find_entity() comment.

Fixes: 9bf19fbf0c8b ("media: v4l: async: Rework internal lists")
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/staging/media/tegra-video/vi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index e98b3010520e..d9a6d5b2aa84 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1455,17 +1455,18 @@ static int __maybe_unused vi_runtime_suspend(struct device *dev)
 }
 
 /*
- * Graph Management
+ * Find the entity matching a given fwnode in an v4l2_async_notifier list
  */
 static struct tegra_vi_graph_entity *
-tegra_vi_graph_find_entity(struct tegra_vi_channel *chan,
+tegra_vi_graph_find_entity(struct list_head *list,
 			   const struct fwnode_handle *fwnode)
 {
 	struct tegra_vi_graph_entity *entity;
 	struct v4l2_async_connection *asd;
 
-	list_for_each_entry(asd, &chan->notifier.done_list, asc_entry) {
+	list_for_each_entry(asd, list, asc_entry) {
 		entity = to_tegra_vi_graph_entity(asd);
+
 		if (entity->asd.match.fwnode == fwnode)
 			return entity;
 	}
@@ -1532,7 +1533,7 @@ static int tegra_vi_graph_build(struct tegra_vi_channel *chan,
 		}
 
 		/* find the remote entity from notifier list */
-		ent = tegra_vi_graph_find_entity(chan, link.remote_node);
+		ent = tegra_vi_graph_find_entity(&chan->notifier.done_list, link.remote_node);
 		if (!ent) {
 			dev_err(vi->dev, "no entity found for %pOF\n",
 				to_of_node(link.remote_node));
@@ -1664,7 +1665,7 @@ static int tegra_vi_graph_notify_bound(struct v4l2_async_notifier *notifier,
 	 * Locate the entity corresponding to the bound subdev and store the
 	 * subdev pointer.
 	 */
-	entity = tegra_vi_graph_find_entity(chan, subdev->fwnode);
+	entity = tegra_vi_graph_find_entity(&chan->notifier.waiting_list, subdev->fwnode);
 	if (!entity) {
 		dev_err(vi->dev, "no entity for subdev %s\n", subdev->name);
 		return -EINVAL;
@@ -1713,7 +1714,7 @@ static int tegra_vi_graph_parse_one(struct tegra_vi_channel *chan,
 
 		/* skip entities that are already processed */
 		if (device_match_fwnode(vi->dev, remote) ||
-		    tegra_vi_graph_find_entity(chan, remote)) {
+		    tegra_vi_graph_find_entity(&chan->notifier.waiting_list, remote)) {
 			fwnode_handle_put(remote);
 			continue;
 		}
-- 
2.34.1

