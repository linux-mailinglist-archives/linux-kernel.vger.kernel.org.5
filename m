Return-Path: <linux-kernel+bounces-30034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9909C831831
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C136289631
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3161288B0;
	Thu, 18 Jan 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G89yLxGE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E32562D;
	Thu, 18 Jan 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576240; cv=none; b=jcSzTMgM3Upg3bNDBLkbjXUM/CPui0YLrVPbQ1PdzruObCG0Rn+yo0HWy8o6TNLIWnFmptnflnmoAk7b5rdNwkRmHvxQWWRYX36R+gU1Fcbod63EqerNoKtulejyMMO7xeEApztC1QS8QDedKFoMb9KtHh939Dbwpi6QizHXnEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576240; c=relaxed/simple;
	bh=veu7RX2solS5hYJqaxZL8z4co9rNydzvgvSTRDFC1Sg=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=eenoM1SK0DjIWMQmqej+k1XGG7ElqIEbTh/UGpwdNLcfWo89APj48RjlsjgsCSYctUTZtCWLQBMQXsDjj2oyf+cfO20JCJUJWJHDio/7dJJdevmGSb1s/kNbZH0soyQKKt9uZSEliVTuhZErHeJFLyJmFRBTljIYbmMewZeimss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G89yLxGE; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705576238; x=1737112238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=veu7RX2solS5hYJqaxZL8z4co9rNydzvgvSTRDFC1Sg=;
  b=G89yLxGEaX1FEJ1e7bxJfuwqe6eJIHnu5A9ptVBqCeBpUvLkjcX4x9Jt
   6wJAWGoswK7Ri/3fuDVrG49/O3deYBsBOg9aQvXZhBGk1xAVgkkGUuzkJ
   SJ2nY9c++WQeQl9SjuIdU1uKkLpcAUefp+sNfZqJAo/gqsUYdqI36xXFi
   oVVW9WQAuPzmEXK/fIoAP98IDleD/D3X4ywPuWTcJITbv/OHFBOSTZYNq
   j+gwQ0TJ4EQzwGWN/LHmOKHLKdICLEMOKp8E1EvUbTH8corb9YLwzUW29
   M0qVf7doXrnpGTSlGgsa99TCRadJZdQQCueqZeY0pJY9rT1idstbVAo0j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="486571257"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="486571257"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 03:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="262471"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jan 2024 03:10:35 -0800
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
	Jan Glaza <jan.glaza@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v5 4/4] dpll: fix register pin with unregistered parent pin
Date: Thu, 18 Jan 2024 12:07:19 +0100
Message-Id: <20240118110719.567117-5-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v5:
- make this patch fourth in the series, previously was third

 drivers/dpll/dpll_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 55f6eda5d2d4..ac426a9be072 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -29,8 +29,6 @@ static u32 dpll_pin_xa_id;
 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
 #define ASSERT_DPLL_NOT_REGISTERED(d)	\
 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
-#define ASSERT_PIN_REGISTERED(p)	\
-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
 
 struct dpll_device_registration {
 	struct list_head list;
@@ -615,8 +613,6 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_dpll_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_DPLL_REGISTERED(dpll))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	if (WARN_ON(!(dpll->module == pin->module &&
@@ -694,8 +690,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_pin_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_PIN_REGISTERED(parent))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
-- 
2.38.1


