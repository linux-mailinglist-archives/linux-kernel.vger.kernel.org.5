Return-Path: <linux-kernel+bounces-31219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C9832ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C221F25338
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74D754BD9;
	Fri, 19 Jan 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqsaNhjO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E554736;
	Fri, 19 Jan 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671987; cv=none; b=kSWHej0kaMmZz/N1YaRxvhuD2EvEAJy2VKA2ctPQmeRRjGWgTLDiBIDr9VVMWjFlgCkNgrH+a3fzlMlE14vw7zvlC4niIkiKhMwkLVTueXSMozr8LgSTF+s4C/Lt4USpPIQ3jqQkNZ0LEXehzLlYybcRGo1U4IFAP/iHHmkdmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671987; c=relaxed/simple;
	bh=jgcRyGqAEZF1nokN0iK0ja40pkp+625ihvNb3uR1IJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWXc2pz76q93OX6wuf5yWJ/5Pllla+PIP5JDE4yk8+x8gwPtNUEuUy/kZrf0CSiMODex9+Z4aDJtqacYfzMxXTt8ilsTE+FDCAmZUXTfVz+rwiIKb4XWHJOPM0RiBo7Z306yf9EC1YwsVmFqZHTDsmLtER5cKI0DG7qI6RxWnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqsaNhjO; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705671985; x=1737207985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jgcRyGqAEZF1nokN0iK0ja40pkp+625ihvNb3uR1IJU=;
  b=fqsaNhjOergcccsnS6DdCaLSTlQeic14C+ulQI4vs4bq3AsSzj8E0ili
   AExv6Q7LbR3FNUDn23gltwuPyDTjiJdt6kfZZwuah17d22DINlkLyuMSy
   mixQMKCYANh7L1KC1tMJo0STS8dQNNBW9H1n7JMrwum6q2gKW3qZibLpF
   +gv7dWP7ppPnn1EC7A4CXgkCqZpORXuEa9vvEh03Q3a0UE+nQsbHP8Dq7
   dqjVXY6z2meYj2y7r0OmAcRFLd2x+DnOKdKLeyhSnyZmchlVIdapoxej5
   zfoicbQLGVQerzKdziXScP+YnDC+FX5OkDcjjMJ79aBbUGt2SXP0OTOjl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="465026925"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="465026925"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="788360418"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788360418"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2024 05:46:22 -0800
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
Subject: [PATCH net v6 4/4] dpll: fix register pin with unregistered parent pin
Date: Fri, 19 Jan 2024 14:43:04 +0100
Message-Id: <20240119134304.576956-5-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
References: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
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
v6:
- no changes, bump the series version

 drivers/dpll/dpll_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index cb62696467d1..5152bd1b0daf 100644
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
@@ -616,8 +614,6 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_dpll_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_DPLL_REGISTERED(dpll))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	if (WARN_ON(!(dpll->module == pin->module &&
@@ -695,8 +691,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 	    WARN_ON(!ops->state_on_pin_get) ||
 	    WARN_ON(!ops->direction_get))
 		return -EINVAL;
-	if (ASSERT_PIN_REGISTERED(parent))
-		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
 	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
-- 
2.38.1


