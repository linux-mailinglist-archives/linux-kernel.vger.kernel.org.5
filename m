Return-Path: <linux-kernel+bounces-31218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECB832AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BB4283A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714354675;
	Fri, 19 Jan 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZsPZVl+"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185FD54657;
	Fri, 19 Jan 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671984; cv=none; b=fMUporev2fPevT1GN9WbqYatdqienBLAR38l6wpxDi6g/TiYDN4+4AOqi/pCEXx0C1272c6up/iBX7xwKqO2Vpfu72BO+R2TUD2nMUMBkxeRYUzsN7QH1wxXt98nNy+AGokMeE7vurVpSHjPm6zY4cKXVWT3NwvBlkCuYfRMJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671984; c=relaxed/simple;
	bh=19xHuiJ0apKtjhO3AmhX1GSEgqLI0utgLP61vPaTEMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2oP+Ezbbo6uJ0AY8yx+P4BqyhQuOwwPJWkRansZPCH0A3yCKB2GaBtdbr120oaZTsG7ubX1qoAP+e1onht9NJXNb89Zd4+2qzkTYhYMe7PZvRgI97p0GwGDoy4lrmmx9ouxDQXG39LW8G+S9C/6zcV1COoZQgoUQ3u1ovlRIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZsPZVl+; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705671983; x=1737207983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=19xHuiJ0apKtjhO3AmhX1GSEgqLI0utgLP61vPaTEMQ=;
  b=hZsPZVl+rWbi8XwW3CEAFSfIxjyxzVOZo0pENoEr7+Mc4KavThTjdURZ
   CcWyl6RlR62BVzmEGaIfXl5AWJwzGGINENfk6evBSXO9NJvrJAdp/+kcB
   wXF+ETGWJwIWEnqBhcD9QOWk68rLDRK+IQwFM8qqiaRfYk6/OpUp1rNo9
   vPyNoWdrcrKK9X1Fh0LFiLCuqAMpy30SLBBSXnH/Bijhjb6C4ter7uqAw
   YrW1kMV37FiYtC+u+ak3rw0kSrGQOarGvkMpodxVqvvIOZRHbZ6UC2csa
   LamYYWQc9MDrS1t/Jey9ZKJ4hSh5eQ4joas5/nPqMcwRcEK0/JgNYNCX6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="465026916"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="465026916"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="788360409"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788360409"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2024 05:46:19 -0800
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
Subject: [PATCH net v6 3/4] dpll: fix userspace availability of pins
Date: Fri, 19 Jan 2024 14:43:03 +0100
Message-Id: <20240119134304.576956-4-arkadiusz.kubalewski@intel.com>
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

If parent pin was unregistered but child pin was not, the userspace
would see the "zombie" pins - the ones that were registered with
a parent pin (dpll_pin_on_pin_register(..)).
Technically those are not available - as there is no dpll device in the
system. Do not dump those pins and prevent userspace from any
interaction with them. Provide a unified function to determine if the
pin is available and use it before acting/responding for user requests.

Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
Reviewed-by: Jan Glaza <jan.glaza@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v6:
- no changes, bump the series version

 drivers/dpll/dpll_netlink.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 30f5be020862..314bb3775465 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -553,6 +553,24 @@ __dpll_device_change_ntf(struct dpll_device *dpll)
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
 }
 
+static bool dpll_pin_available(struct dpll_pin *pin)
+{
+	struct dpll_pin_ref *par_ref;
+	unsigned long i;
+
+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
+		return false;
+	xa_for_each(&pin->parent_refs, i, par_ref)
+		if (xa_get_mark(&dpll_pin_xa, par_ref->pin->id,
+				DPLL_REGISTERED))
+			return true;
+	xa_for_each(&pin->dpll_refs, i, par_ref)
+		if (xa_get_mark(&dpll_device_xa, par_ref->dpll->id,
+				DPLL_REGISTERED))
+			return true;
+	return false;
+}
+
 /**
  * dpll_device_change_ntf - notify that the dpll device has been changed
  * @dpll: registered dpll pointer
@@ -579,7 +597,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 	int ret = -ENOMEM;
 	void *hdr;
 
-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
+	if (!dpll_pin_available(pin))
 		return -ENODEV;
 
 	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
@@ -1130,6 +1148,10 @@ int dpll_nl_pin_id_get_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	pin = dpll_pin_find_from_nlattr(info);
 	if (!IS_ERR(pin)) {
+		if (!dpll_pin_available(pin)) {
+			nlmsg_free(msg);
+			return -ENODEV;
+		}
 		ret = dpll_msg_add_pin_handle(msg, pin);
 		if (ret) {
 			nlmsg_free(msg);
@@ -1179,6 +1201,8 @@ int dpll_nl_pin_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 	xa_for_each_marked_start(&dpll_pin_xa, i, pin, DPLL_REGISTERED,
 				 ctx->idx) {
+		if (!dpll_pin_available(pin))
+			continue;
 		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
 				  cb->nlh->nlmsg_seq,
 				  &dpll_nl_family, NLM_F_MULTI,
@@ -1441,7 +1465,8 @@ int dpll_pin_pre_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 	}
 	info->user_ptr[0] = xa_load(&dpll_pin_xa,
 				    nla_get_u32(info->attrs[DPLL_A_PIN_ID]));
-	if (!info->user_ptr[0]) {
+	if (!info->user_ptr[0] ||
+	    !dpll_pin_available(info->user_ptr[0])) {
 		NL_SET_ERR_MSG(info->extack, "pin not found");
 		ret = -ENODEV;
 		goto unlock_dev;
-- 
2.38.1


