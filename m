Return-Path: <linux-kernel+bounces-115562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD52F889C68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC19B1C21DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DAD24E3C2;
	Mon, 25 Mar 2024 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIQXDyM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC71F1AF4;
	Sun, 24 Mar 2024 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321089; cv=none; b=Q/71a8FP5bXI0ZTbV9cLGRbimoYJi6Lt6CdkreeiikYTRz3TjNAa+qRMdyp1uzvmYD+XMBLHbUIHWS+3MVaCGX2RGgdXOClr9xGi94c8M452jqBka5I2M3q6Ev0bo2G16u7bCBj1OFQcTlOgd3kEB7BYxdGrURGbDPRtstniUVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321089; c=relaxed/simple;
	bh=KCdEeAzHYRbBp8014JNKSfgbZL0yss104STtYKpL/DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFa62RhtMWycAimFbBFYe6dFtfRbZPFtgivqUqzWz4Sx9XFj7jKhx9dZVUJxVBm9/oqUE0RHynHd30NvOkn7cp/qjWKkes/dSbPF+EOu57M7xNflARJ3u/imiM60iXDslW5KXcRjlzmESV2WRS7n8x8yYksXZxE9EpAhVgTjfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIQXDyM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17166C43399;
	Sun, 24 Mar 2024 22:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321089;
	bh=KCdEeAzHYRbBp8014JNKSfgbZL0yss104STtYKpL/DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIQXDyM1bRqHu28/b5XjafnW/0RYSKgIzbHMXGLxWNBWVTD+GFSrkrXzLXju9J5YB
	 ez4bUvGz9r+ttMBWp8+NrkjoSM5mbcUEv4+EkQ/Bt6riHjehfT/W0sXRoaK2z/ZyM4
	 z6++OHSpxQPgZUu1ZpB845k98Se1HpqbeWzhxXv9Kk6PmSCMc5I+hEwcR5uhFyWqbX
	 q92gSpqqmAhBuR5kvP9LHexokbFLBTxkwd/t4KGTwR+y9MoT3bdfIS1+qIT6/S7NuK
	 y0kS213sgsn7q/1lGd5Kdd+9QyipBWas7HMxMJx906Qzs+zSLt4QaCkX61adZoldG1
	 mqxWqaq9GuPSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 652/713] devlink: Acquire device lock during netns dismantle
Date: Sun, 24 Mar 2024 18:46:18 -0400
Message-ID: <20240324224720.1345309-653-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit e21c52d7814f5768f05224e773644629fe124af2 ]

Device drivers register with devlink from their probe routines (under
the device lock) by acquiring the devlink instance lock and calling
devl_register().

Drivers that support a devlink reload usually implement the
reload_{down, up}() operations in a similar fashion to their remove and
probe routines, respectively.

However, while the remove and probe routines are invoked with the device
lock held, the reload operations are only invoked with the devlink
instance lock held. It is therefore impossible for drivers to acquire
the device lock from their reload operations, as this would result in
lock inversion.

The motivating use case for invoking the reload operations with the
device lock held is in mlxsw which needs to trigger a PCI reset as part
of the reload. The driver cannot call pci_reset_function() as this
function acquires the device lock. Instead, it needs to call
__pci_reset_function_locked which expects the device lock to be held.

To that end, adjust devlink to always acquire the device lock before the
devlink instance lock when performing a reload.

For now, only do that when reload is triggered as part of netns
dismantle. Subsequent patches will handle the case where reload is
explicitly triggered by user space.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: d7d75124965a ("devlink: Fix devlink parallel commands processing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/core.c          |  4 ++--
 net/devlink/devl_internal.h | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index bc3d265fe2d6e..7f0b093208d75 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -503,14 +503,14 @@ static void __net_exit devlink_pernet_pre_exit(struct net *net)
 	 * all devlink instances from this namespace into init_net.
 	 */
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		devl_lock(devlink);
+		devl_dev_lock(devlink, true);
 		err = 0;
 		if (devl_is_registered(devlink))
 			err = devlink_reload(devlink, &init_net,
 					     DEVLINK_RELOAD_ACTION_DRIVER_REINIT,
 					     DEVLINK_RELOAD_LIMIT_UNSPEC,
 					     &actions_performed, NULL);
-		devl_unlock(devlink);
+		devl_dev_unlock(devlink, true);
 		devlink_put(devlink);
 		if (err && err != -EOPNOTSUPP)
 			pr_warn("Failed to reload devlink instance into init_net\n");
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 2a9b263300a4b..178abaf74a107 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -3,6 +3,7 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/device.h>
 #include <linux/etherdevice.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
@@ -96,6 +97,20 @@ static inline bool devl_is_registered(struct devlink *devlink)
 	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 }
 
+static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
+{
+	if (dev_lock)
+		device_lock(devlink->dev);
+	devl_lock(devlink);
+}
+
+static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
+{
+	devl_unlock(devlink);
+	if (dev_lock)
+		device_unlock(devlink->dev);
+}
+
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
-- 
2.43.0


