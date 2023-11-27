Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882BC7FA456
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjK0PXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbjK0PXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:23:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CD7138
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:23:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51419C433C9;
        Mon, 27 Nov 2023 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701098632;
        bh=6ATLUxaollQl4fccfb6co0VtiFlgHSHwLINQTjyriCA=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=m6S7kz+ulFx0LTJMiDrKn+k15PYquhTDHR12qE9o5kiTflA1UwVxuG2E7LEOkEZ7i
         ogZCIbTSKGD6cYLANz3cQScq81yaLZArgtbmFAwbOQf5/pihj4dCpLwT9on2gvrFnr
         UDdo4/l8GgI9ZJDMOpOfcZF6F+PhM4pNwIe4y5LfKAR+F2tj4klQGxqeVj2qjrwVCF
         4TMvLU6dgfSQZ3iDUf9Paa9TXGkojxsieyxEQDE8mgaxaEyGIXq/S/NV6U9Gmu08R6
         MRtiFpvoMKZrmkNf0kxuV+f4iV0IjoyTyqSwHfgoLh2XOcZxfT+DO33pMuW0Uzx1jU
         eBZJqWVUVCAvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 3506BC4167B;
        Mon, 27 Nov 2023 15:23:52 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date:   Mon, 27 Nov 2023 16:23:13 +0100
Subject: [PATCH RFC] driver: core: don't queue device links removal for dt
 overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231127-fix-device-links-overlays-v1-1-d7438f56d025@analog.com>
X-B4-Tracking: v=1; b=H4sIAGC0ZGUC/x2MQQqEMAwAvyI5GzBVWPQq+ACvsgexqQalSgOii
 H/fsMeBmXlAOQkrNNkDiU9R2aMB5RlMyxhnRvHG4ApXErkKg1zoTZwYN4mr4n5y2sZbkUpff0K
 oqSIG64/EJv/fA/RdC9/3/QEQK5wPcAAAAA==
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098630; l=4200;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Pzoxm9OeWHGeOx7peo/dXhcFmG4O670B4qDQ7q+neiA=;
 b=DoU/c6DAqx5bd/EEM6UExe04NiJYrQmqQ7EhCBVUwQwNiNeg0GuQrBVdvMP483E2n5eo2FrAf
 kT3Yb4fSPDEAogwq7OiOzJ+F8NWXW2Ni4v7lTS6G55Z7T4/VrA1w0OY
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sa <nuno.sa@analog.com>

For device links, releasing the supplier/consumer devices references
happens asynchronously in device_link_release_fn(). Hence, the possible
release of an of_node is also asynchronous. If these nodes were added
through overlays we have a problem because this does not respect the
devicetree overlays assumptions that when a changeset is
being removed in __of_changeset_entry_destroy(), it must hold the last
reference to that node. Due to the async nature of device links that
cannot be guaranteed.

Given the above, in case one of the link consumer/supplier is part of
an overlay node we call directly device_link_release_fn() instead of
queueing it. Yes, it might take some significant time for
device_link_release_fn() to complete because of synchronize_srcu() but
we would need to, anyways, wait for all OF references to be released if
we want to respect overlays assumptions.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
This RFC is a follow up of a previous one that I sent to the devicetree
folks [1]. It got rejected because it was not really fixing the root
cause of the issue (which I do agree). Please see the link where I
fully explain what the issue is.

I did also some git blaming and did saw that commit
80dd33cf72d1 ("drivers: base: Fix device link removal") introduced
queue_work() as we could be releasing the last device reference and hence
sleeping which is against SRCU callback requirements. However, that same
commit is now making use of synchronize_srcu() which may take
significant time (and I think that's the reason for the work item?).

However, given the dt overlays requirements, I'm not seeing any
reason to not be able to run device_link_release_fn() synchronously if we
detect an OVERLAY node is being released. I mean, even if we come up
(and I did some experiments in this regard) with some async mechanism to
release the OF nodes refcounts, we still need a synchronization point
somewhere.

Anyways, I would like to have some feedback on how acceptable would this
be or what else could I do so we can have a "clean" dt overlay removal.

I'm also cc'ing dts folks so they can give some comments on the new
device_node_overlay_removal() function. My goal is to try to detect when an
overlay is being removed (maybe we could even have an explicit flag for
it?) and only directly call device_link_release_fn() in that case.

[1]: https://lore.kernel.org/linux-devicetree/20230511151047.1779841-1-nuno.sa@analog.com/

Thanks!
- Nuno Sá
---
 drivers/base/core.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67ba592afc77..8466b63b89c3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -497,6 +497,18 @@ static struct attribute *devlink_attrs[] = {
 };
 ATTRIBUTE_GROUPS(devlink);
 
+static bool device_node_overlay_removal(struct device *dev)
+{
+	if (!dev_of_node(dev))
+		return false;
+	if (!of_node_check_flag(dev->of_node, OF_DETACHED))
+		return false;
+	if (!of_node_check_flag(dev->of_node, OF_OVERLAY))
+		return false;
+
+	return true;
+}
+
 static void device_link_release_fn(struct work_struct *work)
 {
 	struct device_link *link = container_of(work, struct device_link, rm_work);
@@ -532,8 +544,19 @@ static void devlink_dev_release(struct device *dev)
 	 * synchronization in device_link_release_fn() and if the consumer or
 	 * supplier devices get deleted when it runs, so put it into the "long"
 	 * workqueue.
+	 *
+	 * However, if any of the supplier, consumer nodes is being removed
+	 * through overlay removal, the expectation in
+	 * __of_changeset_entry_destroy() is for the node 'kref' to be 1 which
+	 * cannot be guaranteed with the async nature of
+	 * device_link_release_fn(). Hence, do it synchronously for the overlay
+	 * case.
 	 */
-	queue_work(system_long_wq, &link->rm_work);
+	if (device_node_overlay_removal(link->consumer) ||
+	    device_node_overlay_removal(link->supplier))
+		device_link_release_fn(&link->rm_work);
+	else
+		queue_work(system_long_wq, &link->rm_work);
 }
 
 static struct class devlink_class = {

