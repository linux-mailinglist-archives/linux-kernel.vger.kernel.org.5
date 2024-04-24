Return-Path: <linux-kernel+bounces-156708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A648B0724
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C24B223F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8D159575;
	Wed, 24 Apr 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2tx6/JC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970DC158D9A;
	Wed, 24 Apr 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954039; cv=none; b=CES1IKWQW4Zk6OiWQwCywC2I2DoMeZEkDmhR+lyzsGZAQ5WxUu3c/Y4NrCYcww3ZMhYfPKMEBbR855tWaliRIs+QmpqVj/ZwZZ69VXN+IVfVfePFXd9tTOUqL2IpbYy+39xBX+kcCFALq+zDg252vgDtopU4evnLrUfI0aOqTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954039; c=relaxed/simple;
	bh=+gjaI2nhObJ3ycyL3NwAVTxlbdJeHWtPqfvu+nCi9W4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tmv+X1ohJzRqm6muIde9/fyo+TMWfh6SJkmRLwUBI8ogFePCElxlhkNy0GehwsSXCdFPb5pEZJjF8TdLkfIjoW/dlbzsVwlsGU5+4oUun/ZYbmz1esQZbyVRX1vjhcF5Gn00C54NZWUzEYWA76fXAmEN2XwW2ovRxwuROJe+O+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2tx6/JC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713954038; x=1745490038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+gjaI2nhObJ3ycyL3NwAVTxlbdJeHWtPqfvu+nCi9W4=;
  b=I2tx6/JCd7fy2nNFiBDSzpV7fzc7HETauUW8zL8DIvDAuRmhZ7Ce0eRi
   wYctNZccDhim00xsmDmbGDw/6MLc5NIJMXKpEuF1MPXQWrDK86XmLTa5o
   ZMQ7QI0vpINkipdNyDB5pY7zLpxPshwK/KXUTTnphVUTh0XsW/29gJLsq
   LDJINwnWsM5mFyRsNd3Wsz28+FTTKV3wnEvEW63QIbF34DgaQdg2UxFCF
   5T3Zhu0pIYZAEgcV+XvhpQ4JtX7V61adty07JJi7YHFQiNyxdrbX6BBMh
   qBA+5pKMkm+J+JgFrIIXfA/ftzyOHR7WCRlCodg9xeVwUxFo66y/uJxsN
   w==;
X-CSE-ConnectionGUID: nR2Vt7fJRiuDiSwuCX8NPw==
X-CSE-MsgGUID: Rk8giScxRxSkgsz6jS2Dyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20126491"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="20126491"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 03:20:37 -0700
X-CSE-ConnectionGUID: N8xhZuA3RvaEgwISMLNBEw==
X-CSE-MsgGUID: +yrkNKYIT6y34aYJnQ5q+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24633306"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa009.jf.intel.com with ESMTP; 24 Apr 2024 03:20:35 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	mschmidt@redhat.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net v2] dpll: fix dpll_pin_on_pin_register() for multiple parent pins
Date: Wed, 24 Apr 2024 12:16:36 +0200
Message-Id: <20240424101636.1491424-1-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In scenario where pin is registered with multiple parent pins via
dpll_pin_on_pin_register(..), all belonging to the same dpll device.
A second call to dpll_pin_on_pin_unregister(..) would cause a call trace,
as it tries to use already released registration resources (due to fix
introduced in b446631f355e). In this scenario pin was registered twice,
so resources are not yet expected to be release until each registered
pin/pin pair is unregistered.

Currently, the following crash/call trace is produced when ice driver is
removed on the system with installed E810T NIC which includes dpll device:

WARNING: CPU: 51 PID: 9155 at drivers/dpll/dpll_core.c:809 dpll_pin_ops+0x20/0x30
RIP: 0010:dpll_pin_ops+0x20/0x30
Call Trace:
 ? __warn+0x7f/0x130
 ? dpll_pin_ops+0x20/0x30
 dpll_msg_add_pin_freq+0x37/0x1d0
 dpll_cmd_pin_get_one+0x1c0/0x400
 ? __nlmsg_put+0x63/0x80
 dpll_pin_event_send+0x93/0x140
 dpll_pin_on_pin_unregister+0x3f/0x100
 ice_dpll_deinit_pins+0xa1/0x230 [ice]
 ice_remove+0xf1/0x210 [ice]

Fix by adding a parent pointer as a cookie when creating a registration,
also when searching for it. For the regular pins pass NULL, this allows to
create separated registration for each parent the pin is registered with.

Fixes: b446631f355e ("dpll: fix dpll_xa_ref_*_del() for multiple registrations")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v2:
- change the v1 approach, instead of refcounting create new registration
  for each parent pointer cookie
- change commit title: "fix dpll_pin_registration missing refcount" ->
  "fix dpll_pin_on_pin_register() for multiple parent pins"
- update commit description, simplify and align with new approach
---
drivers/dpll/dpll_core.c | 58 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 64eaca80d736..d0f6693ca142 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -42,6 +42,7 @@ struct dpll_pin_registration {
 	struct list_head list;
 	const struct dpll_pin_ops *ops;
 	void *priv;
+	void *cookie;
 };
 
 struct dpll_device *dpll_device_get_by_id(int id)
@@ -54,12 +55,14 @@ struct dpll_device *dpll_device_get_by_id(int id)
 
 static struct dpll_pin_registration *
 dpll_pin_registration_find(struct dpll_pin_ref *ref,
-			   const struct dpll_pin_ops *ops, void *priv)
+			   const struct dpll_pin_ops *ops, void *priv,
+			   void *cookie)
 {
 	struct dpll_pin_registration *reg;
 
 	list_for_each_entry(reg, &ref->registration_list, list) {
-		if (reg->ops == ops && reg->priv == priv)
+		if (reg->ops == ops && reg->priv == priv &&
+		    reg->cookie == cookie)
 			return reg;
 	}
 	return NULL;
@@ -67,7 +70,8 @@ dpll_pin_registration_find(struct dpll_pin_ref *ref,
 
 static int
 dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
-		    const struct dpll_pin_ops *ops, void *priv)
+		    const struct dpll_pin_ops *ops, void *priv,
+		    void *cookie)
 {
 	struct dpll_pin_registration *reg;
 	struct dpll_pin_ref *ref;
@@ -78,7 +82,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 	xa_for_each(xa_pins, i, ref) {
 		if (ref->pin != pin)
 			continue;
-		reg = dpll_pin_registration_find(ref, ops, priv);
+		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
 		if (reg) {
 			refcount_inc(&ref->refcount);
 			return 0;
@@ -111,6 +115,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 	}
 	reg->ops = ops;
 	reg->priv = priv;
+	reg->cookie = cookie;
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -119,7 +124,8 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
 }
 
 static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
-			       const struct dpll_pin_ops *ops, void *priv)
+			       const struct dpll_pin_ops *ops, void *priv,
+			       void *cookie)
 {
 	struct dpll_pin_registration *reg;
 	struct dpll_pin_ref *ref;
@@ -128,7 +134,7 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 	xa_for_each(xa_pins, i, ref) {
 		if (ref->pin != pin)
 			continue;
-		reg = dpll_pin_registration_find(ref, ops, priv);
+		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
 		if (WARN_ON(!reg))
 			return -EINVAL;
 		list_del(&reg->list);
@@ -146,7 +152,7 @@ static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin *pin,
 
 static int
 dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
-		     const struct dpll_pin_ops *ops, void *priv)
+		     const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	struct dpll_pin_registration *reg;
 	struct dpll_pin_ref *ref;
@@ -157,7 +163,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 	xa_for_each(xa_dplls, i, ref) {
 		if (ref->dpll != dpll)
 			continue;
-		reg = dpll_pin_registration_find(ref, ops, priv);
+		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
 		if (reg) {
 			refcount_inc(&ref->refcount);
 			return 0;
@@ -190,6 +196,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 	}
 	reg->ops = ops;
 	reg->priv = priv;
+	reg->cookie = cookie;
 	if (ref_exists)
 		refcount_inc(&ref->refcount);
 	list_add_tail(&reg->list, &ref->registration_list);
@@ -199,7 +206,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
 
 static void
 dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
-		     const struct dpll_pin_ops *ops, void *priv)
+		     const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	struct dpll_pin_registration *reg;
 	struct dpll_pin_ref *ref;
@@ -208,7 +215,7 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
 	xa_for_each(xa_dplls, i, ref) {
 		if (ref->dpll != dpll)
 			continue;
-		reg = dpll_pin_registration_find(ref, ops, priv);
+		reg = dpll_pin_registration_find(ref, ops, priv, cookie);
 		if (WARN_ON(!reg))
 			return;
 		list_del(&reg->list);
@@ -594,14 +601,14 @@ EXPORT_SYMBOL_GPL(dpll_pin_put);
 
 static int
 __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
-		    const struct dpll_pin_ops *ops, void *priv)
+		    const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	int ret;
 
-	ret = dpll_xa_ref_pin_add(&dpll->pin_refs, pin, ops, priv);
+	ret = dpll_xa_ref_pin_add(&dpll->pin_refs, pin, ops, priv, cookie);
 	if (ret)
 		return ret;
-	ret = dpll_xa_ref_dpll_add(&pin->dpll_refs, dpll, ops, priv);
+	ret = dpll_xa_ref_dpll_add(&pin->dpll_refs, dpll, ops, priv, cookie);
 	if (ret)
 		goto ref_pin_del;
 	xa_set_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
@@ -610,7 +617,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	return ret;
 
 ref_pin_del:
-	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv);
+	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
 	return ret;
 }
 
@@ -642,7 +649,7 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		      dpll->clock_id == pin->clock_id)))
 		ret = -EINVAL;
 	else
-		ret = __dpll_pin_register(dpll, pin, ops, priv);
+		ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
 	mutex_unlock(&dpll_lock);
 
 	return ret;
@@ -651,11 +658,11 @@ EXPORT_SYMBOL_GPL(dpll_pin_register);
 
 static void
 __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
-		      const struct dpll_pin_ops *ops, void *priv)
+		      const struct dpll_pin_ops *ops, void *priv, void *cookie)
 {
 	ASSERT_DPLL_PIN_REGISTERED(pin);
-	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv);
-	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv);
+	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv, cookie);
+	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv, cookie);
 	if (xa_empty(&pin->dpll_refs))
 		xa_clear_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
 }
@@ -680,7 +687,7 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 
 	mutex_lock(&dpll_lock);
 	dpll_pin_delete_ntf(pin);
-	__dpll_pin_unregister(dpll, pin, ops, priv);
+	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_unregister);
@@ -716,12 +723,12 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
-	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
+	ret = dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv, pin);
 	if (ret)
 		goto unlock;
 	refcount_inc(&pin->refcount);
 	xa_for_each(&parent->dpll_refs, i, ref) {
-		ret = __dpll_pin_register(ref->dpll, pin, ops, priv);
+		ret = __dpll_pin_register(ref->dpll, pin, ops, priv, parent);
 		if (ret) {
 			stop = i;
 			goto dpll_unregister;
@@ -735,11 +742,12 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 dpll_unregister:
 	xa_for_each(&parent->dpll_refs, i, ref)
 		if (i < stop) {
-			__dpll_pin_unregister(ref->dpll, pin, ops, priv);
+			__dpll_pin_unregister(ref->dpll, pin, ops, priv,
+					      parent);
 			dpll_pin_delete_ntf(pin);
 		}
 	refcount_dec(&pin->refcount);
-	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv);
+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
 	mutex_unlock(&dpll_lock);
 	return ret;
@@ -764,10 +772,10 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 
 	mutex_lock(&dpll_lock);
 	dpll_pin_delete_ntf(pin);
-	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv);
+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	refcount_dec(&pin->refcount);
 	xa_for_each(&pin->dpll_refs, i, ref)
-		__dpll_pin_unregister(ref->dpll, pin, ops, priv);
+		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
 	mutex_unlock(&dpll_lock);
 }
 EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);

base-commit: 80e679b352c3ce5158f3f778cfb77eb767e586fb
-- 
2.38.1


