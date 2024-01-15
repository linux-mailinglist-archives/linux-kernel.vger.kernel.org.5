Return-Path: <linux-kernel+bounces-25759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53D82D560
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC61F1C213CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B4F4E4;
	Mon, 15 Jan 2024 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnffg9Ab"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C48D308;
	Mon, 15 Jan 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705308951; x=1736844951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8r9djbX1C5ojR72gaarTkjSBq5M4mpW+NiFhsSiKYE=;
  b=bnffg9AbdU/I+xN5jkzBmZh+ZywC4VRWgHZ0falmx+0FO5OFSHXOuROk
   iDwXi84MOxIajQ0xgUu1JbmLI7Dbo9Ytc5CbyJnM/B7D4tkKKSDrVq7+N
   0wIfkR1tGKyToFG0nxD0Y1sgB+hU3vMVK4Q8yVcRWTS+9nmqtkuhNtvI1
   nh9E8IkDeLdxuD8UnOSTSGVZoqViEeqJ6jvlJbxWtK/FmdZfg+aYexXCN
   qYKgEel715E1CB5sLKKc41yU8pxrS6SFNY1Wt+VaDUhumz+1CVTc2zUtS
   +m4mrVP14yAsPFS+q11By7d3Wr8JmKgsVyjYwhUBR4lHShp8Emq8hDZUu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="485728179"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="485728179"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 00:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="853935188"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="853935188"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jan 2024 00:55:48 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	davem@davemloft.net,
	milena.olech@intel.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	mschmidt@redhat.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>
Subject: [PATCH net v3 2/3] dpll: fix register pin with unregistered parent pin
Date: Mon, 15 Jan 2024 09:52:40 +0100
Message-Id: <20240115085241.312144-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240115085241.312144-1-arkadiusz.kubalewski@intel.com>
References: <20240115085241.312144-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of multiple kernel module instances using the same dpll device:
if only one registers dpll device, then only that one can register
directly connected pins with a dpll device. When unregistered parent is
responsible for determining if the muxed pin can be registered with it
or not, the drivers need to be loaded in serialized order to work
correctly - first the driver instance which registers the direct pins
needs to be loaded, then the other instances could register muxed type
pins.

Allow registration of a pin with a parent even if the parent was not
yet registered, thus allow ability for unserialized driver instance
load order.
Do not WARN_ON notification for unregistered pin, which can be invoked
for described case, instead just return error.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v3:
- allow register with non registered parent dpll device for consistency

 drivers/dpll/dpll_core.c    | 6 ------
 drivers/dpll/dpll_netlink.c | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index fbac32af78b7..69005d8489d3 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
 #define ASSERT_DPLL_NOT_REGISTERED(d)	\
 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
-#define ASSERT_PIN_REGISTERED(p)	\
-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
 
 struct dpll_device_registration {
 	struct list_head list;
@@ -613,8 +611,6 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_dpll_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_DPLL_REGISTERED(dpll))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	if (WARN_ON(!(dpll->module == pin->module &&
@@ -692,8 +688,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_pin_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_PIN_REGISTERED(parent))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 4c64611d32ac..108c002537e6 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -551,7 +551,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 	int ret = -ENOMEM;
 	void *hdr;
 
-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
 		return -ENODEV;
 
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
-- 
2.38.1


