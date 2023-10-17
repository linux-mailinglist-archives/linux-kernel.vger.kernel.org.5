Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37A7CC126
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbjJQKyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjJQKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:54:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE06EB;
        Tue, 17 Oct 2023 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697540062; x=1729076062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMJE6sSyXyFqw/tdBqmjBEbVsmQN82BDCvMDuBts2dw=;
  b=gKjNDOOpP3l7WGRwVRO9d1LJaKj/cHuDqqur3XVGPlWgNYln1NIM/1o5
   a9xlut21UvR/dxDLFYgHr9IbhLaAVUXSmzMgHi7QlLQpqftNY/iIed2re
   yT08kh6N6zXg/eZFpaci3wFsl9Am2u0Fx+H/Yj2eHzzlbBkiXdULXOca9
   w+VR66Vk8Een6PtRln5vjo6JS/1KQqVD2qsxvl4Zdfb+DqrWBMMQFxLOV
   qlY16Zop2a9iPXeDlchtLZbMlFyYk/GmbqzPTLvjxlxIeoYCfG7PuOFq0
   bJk0doLjOu4X96JaezPK2/db7+4ps9hy3lKM7eQMNdHUOV14p76U7WZxf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="366012604"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="366012604"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 03:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785445281"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="785445281"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 03:54:12 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 6E3B9312CF;
        Tue, 17 Oct 2023 11:54:09 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>
Cc:     Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH net-next v2 01/11] devlink: retain error in struct devlink_fmsg
Date:   Tue, 17 Oct 2023 12:53:31 +0200
Message-Id: <20231017105341.415466-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retain error value in struct devlink_fmsg, to relieve drivers from
checking it after each call.
Note that fmsg is an in-memory builder/buffer of formatted message,
so it's not the case that half baked message was sent somewhere.

We could find following scheme in multiple drivers:
  err = devlink_fmsg_obj_nest_start(fmsg);
  if (err)
  	return err;
  err = devlink_fmsg_string_pair_put(fmsg, "src", src);
  if (err)
  	return err;
  err = devlink_fmsg_something(fmsg, foo, bar);
  if (err)
	return err;
  // and so on...
  err = devlink_fmsg_obj_nest_end(fmsg);

With retaining error API that translates to:
  devlink_fmsg_obj_nest_start(fmsg);
  devlink_fmsg_string_pair_put(fmsg, "src", src);
  devlink_fmsg_something(fmsg, foo, bar);
  // and so on...
  devlink_fmsg_obj_nest_end(fmsg);

What means we check error just when is time to send.

Possible error scenarios are developer error (API misuse) and memory
exhaustion, both cases are good candidates to choose readability
over fastest possible exit.

Note that this patch keeps returning errors, to allow per-driver conversion
to the new API, but those are not needed at this point already.

This commit itself is an illustration of benefits for the dev-user,
more of it will be in separate commits of the series.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 2/4 grow/shrink: 17/3 up/down: 462/-466 (-4)
---
 net/devlink/health.c | 247 +++++++++++++------------------------------
 1 file changed, 76 insertions(+), 171 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 51e6e81e31bb..3858a436598e 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -19,6 +19,7 @@ struct devlink_fmsg_item {
 
 struct devlink_fmsg {
 	struct list_head item_list;
+	int err; /* first error encountered on some devlink_fmsg_XXX() call */
 	bool putting_binary; /* This flag forces enclosing of binary data
 			      * in an array brackets. It forces using
 			      * of designated API:
@@ -562,10 +563,8 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
 		return 0;
 
 	reporter->dump_fmsg = devlink_fmsg_alloc();
-	if (!reporter->dump_fmsg) {
-		err = -ENOMEM;
-		return err;
-	}
+	if (!reporter->dump_fmsg)
+		return -ENOMEM;
 
 	err = devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
 	if (err)
@@ -670,43 +669,46 @@ int devlink_nl_cmd_health_reporter_recover_doit(struct sk_buff *skb,
 	return devlink_health_reporter_recover(reporter, NULL, info->extack);
 }
 
-static int devlink_fmsg_nest_common(struct devlink_fmsg *fmsg,
-				    int attrtype)
+static void devlink_fmsg_err_if_binary(struct devlink_fmsg *fmsg)
+{
+	if (!fmsg->err && fmsg->putting_binary)
+		fmsg->err = -EINVAL;
+}
+
+static int devlink_fmsg_nest_common(struct devlink_fmsg *fmsg, int attrtype)
 {
 	struct devlink_fmsg_item *item;
 
+	if (fmsg->err)
+		return fmsg->err;
+
 	item = kzalloc(sizeof(*item), GFP_KERNEL);
-	if (!item)
-		return -ENOMEM;
+	if (!item) {
+		fmsg->err = -ENOMEM;
+		return fmsg->err;
+	}
 
 	item->attrtype = attrtype;
 	list_add_tail(&item->list, &fmsg->item_list);
 
 	return 0;
 }
 
 int devlink_fmsg_obj_nest_start(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
+	devlink_fmsg_err_if_binary(fmsg);
 	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_OBJ_NEST_START);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_obj_nest_start);
 
 static int devlink_fmsg_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
+	devlink_fmsg_err_if_binary(fmsg);
 	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_NEST_END);
 }
 
 int devlink_fmsg_obj_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
 	return devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_obj_nest_end);
@@ -717,15 +719,20 @@ static int devlink_fmsg_put_name(struct devlink_fmsg *fmsg, const char *name)
 {
 	struct devlink_fmsg_item *item;
 
-	if (fmsg->putting_binary)
-		return -EINVAL;
+	devlink_fmsg_err_if_binary(fmsg);
+	if (fmsg->err)
+		return fmsg->err;
 
-	if (strlen(name) + 1 > DEVLINK_FMSG_MAX_SIZE)
-		return -EMSGSIZE;
+	if (strlen(name) + 1 > DEVLINK_FMSG_MAX_SIZE) {
+		fmsg->err = -EMSGSIZE;
+		return fmsg->err;
+	}
 
 	item = kzalloc(sizeof(*item) + strlen(name) + 1, GFP_KERNEL);
-	if (!item)
-		return -ENOMEM;
+	if (!item) {
+		fmsg->err = -ENOMEM;
+		return fmsg->err;
+	}
 
 	item->nla_type = NLA_NUL_STRING;
 	item->len = strlen(name) + 1;
@@ -738,68 +745,30 @@ static int devlink_fmsg_put_name(struct devlink_fmsg *fmsg, const char *name)
 
 int devlink_fmsg_pair_nest_start(struct devlink_fmsg *fmsg, const char *name)
 {
-	int err;
-
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
-	err = devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_PAIR_NEST_START);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_put_name(fmsg, name);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_err_if_binary(fmsg);
+	devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_PAIR_NEST_START);
+	return devlink_fmsg_put_name(fmsg, name);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_pair_nest_start);
 
 int devlink_fmsg_pair_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
 	return devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_pair_nest_end);
 
 int devlink_fmsg_arr_pair_nest_start(struct devlink_fmsg *fmsg,
 				     const char *name)
 {
-	int err;
-
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_ARR_NEST_START);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_ARR_NEST_START);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_arr_pair_nest_start);
 
 int devlink_fmsg_arr_pair_nest_end(struct devlink_fmsg *fmsg)
 {
-	int err;
-
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
-	err = devlink_fmsg_nest_end(fmsg);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_nest_end(fmsg);
+	return devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_arr_pair_nest_end);
 
@@ -813,14 +782,19 @@ int devlink_fmsg_binary_pair_nest_start(struct devlink_fmsg *fmsg,
 		return err;
 
 	fmsg->putting_binary = true;
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_nest_start);
 
 int devlink_fmsg_binary_pair_nest_end(struct devlink_fmsg *fmsg)
 {
-	if (!fmsg->putting_binary)
-		return -EINVAL;
+	if (fmsg->err)
+		return fmsg->err;
+
+	if (!fmsg->putting_binary) {
+		fmsg->err = -EINVAL;
+		return fmsg->err;
+	}
 
 	fmsg->putting_binary = false;
 	return devlink_fmsg_arr_pair_nest_end(fmsg);
@@ -833,12 +807,16 @@ static int devlink_fmsg_put_value(struct devlink_fmsg *fmsg,
 {
 	struct devlink_fmsg_item *item;
 
-	if (value_len > DEVLINK_FMSG_MAX_SIZE)
-		return -EMSGSIZE;
+	if (value_len > DEVLINK_FMSG_MAX_SIZE) {
+		fmsg->err = -EMSGSIZE;
+		return fmsg->err;
+	}
 
 	item = kzalloc(sizeof(*item) + value_len, GFP_KERNEL);
-	if (!item)
-		return -ENOMEM;
+	if (!item) {
+		fmsg->err = -ENOMEM;
+		return fmsg->err;
+	}
 
 	item->nla_type = value_nla_type;
 	item->len = value_len;
@@ -851,42 +829,32 @@ static int devlink_fmsg_put_value(struct devlink_fmsg *fmsg,
 
 static int devlink_fmsg_bool_put(struct devlink_fmsg *fmsg, bool value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
+	devlink_fmsg_err_if_binary(fmsg);
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_FLAG);
 }
 
 static int devlink_fmsg_u8_put(struct devlink_fmsg *fmsg, u8 value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
+	devlink_fmsg_err_if_binary(fmsg);
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U8);
 }
 
 int devlink_fmsg_u32_put(struct devlink_fmsg *fmsg, u32 value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
+	devlink_fmsg_err_if_binary(fmsg);
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U32);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u32_put);
 
 static int devlink_fmsg_u64_put(struct devlink_fmsg *fmsg, u64 value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
+	devlink_fmsg_err_if_binary(fmsg);
 	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U64);
 }
 
 int devlink_fmsg_string_put(struct devlink_fmsg *fmsg, const char *value)
 {
-	if (fmsg->putting_binary)
-		return -EINVAL;
-
+	devlink_fmsg_err_if_binary(fmsg);
 	return devlink_fmsg_put_value(fmsg, value, strlen(value) + 1,
 				      NLA_NUL_STRING);
 }
@@ -905,113 +873,52 @@ EXPORT_SYMBOL_GPL(devlink_fmsg_binary_put);
 int devlink_fmsg_bool_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			       bool value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_bool_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_bool_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_bool_pair_put);
 
 int devlink_fmsg_u8_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			     u8 value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u8_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_u8_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u8_pair_put);
 
 int devlink_fmsg_u32_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			      u32 value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u32_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_u32_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u32_pair_put);
 
 int devlink_fmsg_u64_pair_put(struct devlink_fmsg *fmsg, const char *name,
 			      u64 value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_u64_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_u64_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u64_pair_put);
 
 int devlink_fmsg_string_pair_put(struct devlink_fmsg *fmsg, const char *name,
 				 const char *value)
 {
-	int err;
-
-	err = devlink_fmsg_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_string_put(fmsg, value);
-	if (err)
-		return err;
-
-	err = devlink_fmsg_pair_nest_end(fmsg);
-	if (err)
-		return err;
-
-	return 0;
+	devlink_fmsg_pair_nest_start(fmsg, name);
+	devlink_fmsg_string_put(fmsg, value);
+	return devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_string_pair_put);
 
 int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
 				 const void *value, u32 value_len)
 {
 	u32 data_size;
-	int end_err;
 	u32 offset;
 	int err;
 
@@ -1027,14 +934,12 @@ int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
 		if (err)
 			break;
 		/* Exit from loop with a break (instead of
-		 * return) to make sure putting_binary is turned off in
-		 * devlink_fmsg_binary_pair_nest_end
+		 * return) to make sure putting_binary is turned off
 		 */
 	}
 
-	end_err = devlink_fmsg_binary_pair_nest_end(fmsg);
-	if (end_err)
-		err = end_err;
+	err = devlink_fmsg_binary_pair_nest_end(fmsg);
+	fmsg->putting_binary = false;
 
 	return err;
 }
-- 
2.40.1

