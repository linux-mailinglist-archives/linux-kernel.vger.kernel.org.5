Return-Path: <linux-kernel+bounces-114413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40963888A57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F295D1F23137
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA592789AB;
	Sun, 24 Mar 2024 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3CxrLUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937D21AFD4;
	Sun, 24 Mar 2024 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321827; cv=none; b=eplgnYKrBj4bhOz38YyP06tCUE/KqHKV1Deikz2h9VnRHusMc0Tc+jNSb7iQjtQibQqFfyKhuB879X3cAOesJ8uWT9I7CgDSEhT02FFZBRpkAYojwofSYIjduEnXoUmDOumUagPsovn1lnCB71Q6DKnyCJyyCc4DGv/lg7KfJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321827; c=relaxed/simple;
	bh=U7g9Y0xZPvSe/JiBFaypvdFGXsPf97kTS1mDNLbllxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnAR+qKdPv8MzM3QfWb1Kjwo/TOAcQme7Fg/MP1qAh+M/QNA19MTeUSwhXBxiJXhIS/qdLIvScT02EaVOJxpq0KUcw2wSfDPxKMkIcRrOBP4um5mEe/iYuOUCtmmfhLfuoAqE/lUh5goAxzqLHqjtWlngyKZY3aU6AW08i/8tZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3CxrLUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52166C433C7;
	Sun, 24 Mar 2024 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321825;
	bh=U7g9Y0xZPvSe/JiBFaypvdFGXsPf97kTS1mDNLbllxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3CxrLUO4qWoh2irUeiHLIp36ZxRWXhgF/n3qhiA2MW7gf+aR6P270g641STUYgZj
	 mpyv/h9kM/HWNy1V82u0uOn8j6GGN5GFYD53j+tkhvF2sC/wNHcfU8teTnD24ni3Gf
	 luR6wNwjQI7Kfq7pEBQgFwoOVdk6/GceZrn6gFt4VOG7um+DDr0bamjisHpmDGq8U4
	 yy9Yrww0beaaqIZCjXxXNYys39fUasBe+2HrHJZM2I6tMhnUxxM/IR4vfqoSBSo7zH
	 IHSiEYNkq/nED0R8o3ZvJMgUZcbljfx/z+2g4RIONZi75SlG0TtD5yam35s9QG3qxq
	 o73XiFPwX//Ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6 554/638] mei: gsc_proxy: match component when GSC is on different bus
Date: Sun, 24 Mar 2024 18:59:51 -0400
Message-ID: <20240324230116.1348576-555-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit a0776c214d47ea4f7aaef138095beaa41cff03ef upstream.

On Arrow Lake S systems, MEI is no longer strictly connected to bus 0,
while graphics remain exclusively on bus 0. Adapt the component
matching logic to accommodate this change:

Original behavior: Required both MEI and graphics to be on the same
bus 0.

New behavior: Only enforces graphics to be on bus 0 (integrated),
allowing MEI to reside on any bus.
This ensures compatibility with Arrow Lake S and maintains functionality
for the legacy systems.

Fixes: 1dd924f6885b ("mei: gsc_proxy: add gsc proxy driver")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240220200020.231192-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
index be52b113aea93..89364bdbb1290 100644
--- a/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
+++ b/drivers/misc/mei/gsc_proxy/mei_gsc_proxy.c
@@ -96,7 +96,8 @@ static const struct component_master_ops mei_component_master_ops = {
  *
  *    The function checks if the device is pci device and
  *    Intel VGA adapter, the subcomponent is SW Proxy
- *    and the parent of MEI PCI and the parent of VGA are the same PCH device.
+ *    and the VGA is on the bus 0 reserved for built-in devices
+ *    to reject discrete GFX.
  *
  * @dev: master device
  * @subcomponent: subcomponent to match (I915_COMPONENT_SWPROXY)
@@ -123,7 +124,8 @@ static int mei_gsc_proxy_component_match(struct device *dev, int subcomponent,
 	if (subcomponent != I915_COMPONENT_GSC_PROXY)
 		return 0;
 
-	return component_compare_dev(dev->parent, ((struct device *)data)->parent);
+	/* Only built-in GFX */
+	return (pdev->bus->number == 0);
 }
 
 static int mei_gsc_proxy_probe(struct mei_cl_device *cldev,
@@ -146,7 +148,7 @@ static int mei_gsc_proxy_probe(struct mei_cl_device *cldev,
 	}
 
 	component_match_add_typed(&cldev->dev, &master_match,
-				  mei_gsc_proxy_component_match, cldev->dev.parent);
+				  mei_gsc_proxy_component_match, NULL);
 	if (IS_ERR_OR_NULL(master_match)) {
 		ret = -ENOMEM;
 		goto err_exit;
-- 
2.43.0


