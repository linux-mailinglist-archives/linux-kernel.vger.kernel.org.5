Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280757CE8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjJRU30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjJRU3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:29:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A181708;
        Wed, 18 Oct 2023 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697660924; x=1729196924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uyEoHGQiKnkWMZ6yCX0zP2KiXAwoBH/WB9KMO3r68l0=;
  b=eBnGk4l176T/6pSUaaM/EpxdzEjwIgDd0ZXjGP0B7SjMRRDL4Ujd0cX8
   cwVsmR2YLI33VQxu20cNo1x9ZsN2aBi1XSN2eJja0E4ObnkjGGdub/KZG
   FOGNpu+Z0e7H9nFu7L8y675uvV+mOdnY7MSbB0i4wuzr6HOxXudj8l8MO
   NbH0n0MSzcdUHytE3s+dSl5ajgsDZRBbPJ85Gm4Mwtccxo+G5P2erIDFJ
   y0Gn7rqHbBoXQIIGjeDK7/t7HQrVAzcMbqJ3IGJywQCV8Q6UhwGpVWenR
   06ctjQ2t+7ZV3DFHFmppLDxYcfrX826Yoahvyf2vMzigOe3BuFOH/z76n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="371168167"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="371168167"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756722424"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756722424"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 13:28:30 -0700
Received: from pkitszel-desk.intel.com (unknown [10.255.194.180])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 65AA533E92;
        Wed, 18 Oct 2023 21:28:23 +0100 (IST)
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
        Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>
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
        linux-kernel@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 11/11] devlink: convert most of devlink_fmsg_*() to return void
Date:   Wed, 18 Oct 2023 22:26:47 +0200
Message-Id: <20231018202647.44769-12-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
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

Since struct devlink_fmsg retains error by now (see 1st patch of this
series), there is no longer need to keep returning it in each call.

This is a separate commit to allow per-driver conversion to stop using
those return values.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 0/0 grow/shrink: 7/12 up/down: 113/-86 (27)
---
 include/net/devlink.h |  60 +++++++-------
 net/devlink/health.c  | 188 +++++++++++++++++++-----------------------
 2 files changed, 114 insertions(+), 134 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index fad8e36e3d98..9ac394bdfbe4 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1854,36 +1854,36 @@ int devlink_info_version_running_put_ext(struct devlink_info_req *req,
 					 const char *version_value,
 					 enum devlink_info_version_type version_type);
 
-int devlink_fmsg_obj_nest_start(struct devlink_fmsg *fmsg);
-int devlink_fmsg_obj_nest_end(struct devlink_fmsg *fmsg);
-
-int devlink_fmsg_pair_nest_start(struct devlink_fmsg *fmsg, const char *name);
-int devlink_fmsg_pair_nest_end(struct devlink_fmsg *fmsg);
-
-int devlink_fmsg_arr_pair_nest_start(struct devlink_fmsg *fmsg,
-				     const char *name);
-int devlink_fmsg_arr_pair_nest_end(struct devlink_fmsg *fmsg);
-int devlink_fmsg_binary_pair_nest_start(struct devlink_fmsg *fmsg,
-					const char *name);
-int devlink_fmsg_binary_pair_nest_end(struct devlink_fmsg *fmsg);
-
-int devlink_fmsg_u32_put(struct devlink_fmsg *fmsg, u32 value);
-int devlink_fmsg_string_put(struct devlink_fmsg *fmsg, const char *value);
-int devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
-			    u16 value_len);
-
-int devlink_fmsg_bool_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			       bool value);
-int devlink_fmsg_u8_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			     u8 value);
-int devlink_fmsg_u32_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			      u32 value);
-int devlink_fmsg_u64_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			      u64 value);
-int devlink_fmsg_string_pair_put(struct devlink_fmsg *fmsg, const char *name,
-				 const char *value);
-int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
-				 const void *value, u32 value_len);
+void devlink_fmsg_obj_nest_start(struct devlink_fmsg *fmsg);
+void devlink_fmsg_obj_nest_end(struct devlink_fmsg *fmsg);
+
+void devlink_fmsg_pair_nest_start(struct devlink_fmsg *fmsg, const char *name);
+void devlink_fmsg_pair_nest_end(struct devlink_fmsg *fmsg);
+
+void devlink_fmsg_arr_pair_nest_start(struct devlink_fmsg *fmsg,
+				      const char *name);
+void devlink_fmsg_arr_pair_nest_end(struct devlink_fmsg *fmsg);
+void devlink_fmsg_binary_pair_nest_start(struct devlink_fmsg *fmsg,
+					 const char *name);
+void devlink_fmsg_binary_pair_nest_end(struct devlink_fmsg *fmsg);
+
+void devlink_fmsg_u32_put(struct devlink_fmsg *fmsg, u32 value);
+void devlink_fmsg_string_put(struct devlink_fmsg *fmsg, const char *value);
+void devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
+			     u16 value_len);
+
+void devlink_fmsg_bool_pair_put(struct devlink_fmsg *fmsg, const char *name,
+				bool value);
+void devlink_fmsg_u8_pair_put(struct devlink_fmsg *fmsg, const char *name,
+			      u8 value);
+void devlink_fmsg_u32_pair_put(struct devlink_fmsg *fmsg, const char *name,
+			       u32 value);
+void devlink_fmsg_u64_pair_put(struct devlink_fmsg *fmsg, const char *name,
+			       u64 value);
+void devlink_fmsg_string_pair_put(struct devlink_fmsg *fmsg, const char *name,
+				  const char *value);
+void devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
+				  const void *value, u32 value_len);
 
 struct devlink_health_reporter *
 devl_port_health_reporter_create(struct devlink_port *port,
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 3858a436598e..89405e59f45c 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -566,16 +566,15 @@ static int devlink_health_do_dump(struct devlink_health_reporter *reporter,
 	if (!reporter->dump_fmsg)
 		return -ENOMEM;
 
-	err = devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
-	if (err)
-		goto dump_err;
+	devlink_fmsg_obj_nest_start(reporter->dump_fmsg);
 
 	err = reporter->ops->dump(reporter, reporter->dump_fmsg,
 				  priv_ctx, extack);
 	if (err)
 		goto dump_err;
 
-	err = devlink_fmsg_obj_nest_end(reporter->dump_fmsg);
+	devlink_fmsg_obj_nest_end(reporter->dump_fmsg);
+	err = reporter->dump_fmsg->err;
 	if (err)
 		goto dump_err;
 
@@ -675,273 +674,252 @@ static void devlink_fmsg_err_if_binary(struct devlink_fmsg *fmsg)
 		fmsg->err = -EINVAL;
 }
 
-static int devlink_fmsg_nest_common(struct devlink_fmsg *fmsg, int attrtype)
+static void devlink_fmsg_nest_common(struct devlink_fmsg *fmsg, int attrtype)
 {
 	struct devlink_fmsg_item *item;
 
 	if (fmsg->err)
-		return fmsg->err;
+		return;
 
 	item = kzalloc(sizeof(*item), GFP_KERNEL);
 	if (!item) {
 		fmsg->err = -ENOMEM;
-		return fmsg->err;
+		return;
 	}
 
 	item->attrtype = attrtype;
 	list_add_tail(&item->list, &fmsg->item_list);
-
-	return 0;
 }
 
-int devlink_fmsg_obj_nest_start(struct devlink_fmsg *fmsg)
+void devlink_fmsg_obj_nest_start(struct devlink_fmsg *fmsg)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_OBJ_NEST_START);
+	devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_OBJ_NEST_START);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_obj_nest_start);
 
-static int devlink_fmsg_nest_end(struct devlink_fmsg *fmsg)
+static void devlink_fmsg_nest_end(struct devlink_fmsg *fmsg)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_NEST_END);
+	devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_NEST_END);
 }
 
-int devlink_fmsg_obj_nest_end(struct devlink_fmsg *fmsg)
+void devlink_fmsg_obj_nest_end(struct devlink_fmsg *fmsg)
 {
-	return devlink_fmsg_nest_end(fmsg);
+	devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_obj_nest_end);
 
 #define DEVLINK_FMSG_MAX_SIZE (GENLMSG_DEFAULT_SIZE - GENL_HDRLEN - NLA_HDRLEN)
 
-static int devlink_fmsg_put_name(struct devlink_fmsg *fmsg, const char *name)
+static void devlink_fmsg_put_name(struct devlink_fmsg *fmsg, const char *name)
 {
 	struct devlink_fmsg_item *item;
 
 	devlink_fmsg_err_if_binary(fmsg);
 	if (fmsg->err)
-		return fmsg->err;
+		return;
 
 	if (strlen(name) + 1 > DEVLINK_FMSG_MAX_SIZE) {
 		fmsg->err = -EMSGSIZE;
-		return fmsg->err;
+		return;
 	}
 
 	item = kzalloc(sizeof(*item) + strlen(name) + 1, GFP_KERNEL);
 	if (!item) {
 		fmsg->err = -ENOMEM;
-		return fmsg->err;
+		return;
 	}
 
 	item->nla_type = NLA_NUL_STRING;
 	item->len = strlen(name) + 1;
 	item->attrtype = DEVLINK_ATTR_FMSG_OBJ_NAME;
 	memcpy(&item->value, name, item->len);
 	list_add_tail(&item->list, &fmsg->item_list);
-
-	return 0;
 }
 
-int devlink_fmsg_pair_nest_start(struct devlink_fmsg *fmsg, const char *name)
+void devlink_fmsg_pair_nest_start(struct devlink_fmsg *fmsg, const char *name)
 {
 	devlink_fmsg_err_if_binary(fmsg);
 	devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_PAIR_NEST_START);
-	return devlink_fmsg_put_name(fmsg, name);
+	devlink_fmsg_put_name(fmsg, name);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_pair_nest_start);
 
-int devlink_fmsg_pair_nest_end(struct devlink_fmsg *fmsg)
+void devlink_fmsg_pair_nest_end(struct devlink_fmsg *fmsg)
 {
-	return devlink_fmsg_nest_end(fmsg);
+	devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_pair_nest_end);
 
-int devlink_fmsg_arr_pair_nest_start(struct devlink_fmsg *fmsg,
-				     const char *name)
+void devlink_fmsg_arr_pair_nest_start(struct devlink_fmsg *fmsg,
+				      const char *name)
 {
 	devlink_fmsg_pair_nest_start(fmsg, name);
-	return devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_ARR_NEST_START);
+	devlink_fmsg_nest_common(fmsg, DEVLINK_ATTR_FMSG_ARR_NEST_START);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_arr_pair_nest_start);
 
-int devlink_fmsg_arr_pair_nest_end(struct devlink_fmsg *fmsg)
+void devlink_fmsg_arr_pair_nest_end(struct devlink_fmsg *fmsg)
 {
 	devlink_fmsg_nest_end(fmsg);
-	return devlink_fmsg_nest_end(fmsg);
+	devlink_fmsg_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_arr_pair_nest_end);
 
-int devlink_fmsg_binary_pair_nest_start(struct devlink_fmsg *fmsg,
-					const char *name)
+void devlink_fmsg_binary_pair_nest_start(struct devlink_fmsg *fmsg,
+					 const char *name)
 {
-	int err;
-
-	err = devlink_fmsg_arr_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
-
+	devlink_fmsg_arr_pair_nest_start(fmsg, name);
 	fmsg->putting_binary = true;
-	return 0;
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_nest_start);
 
-int devlink_fmsg_binary_pair_nest_end(struct devlink_fmsg *fmsg)
+void devlink_fmsg_binary_pair_nest_end(struct devlink_fmsg *fmsg)
 {
 	if (fmsg->err)
-		return fmsg->err;
+		return;
 
-	if (!fmsg->putting_binary) {
+	if (!fmsg->putting_binary)
 		fmsg->err = -EINVAL;
-		return fmsg->err;
-	}
 
 	fmsg->putting_binary = false;
-	return devlink_fmsg_arr_pair_nest_end(fmsg);
+	devlink_fmsg_arr_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_nest_end);
 
-static int devlink_fmsg_put_value(struct devlink_fmsg *fmsg,
-				  const void *value, u16 value_len,
-				  u8 value_nla_type)
+static void devlink_fmsg_put_value(struct devlink_fmsg *fmsg,
+				   const void *value, u16 value_len,
+				   u8 value_nla_type)
 {
 	struct devlink_fmsg_item *item;
 
+	if (fmsg->err)
+		return;
+
 	if (value_len > DEVLINK_FMSG_MAX_SIZE) {
 		fmsg->err = -EMSGSIZE;
-		return fmsg->err;
+		return;
 	}
 
 	item = kzalloc(sizeof(*item) + value_len, GFP_KERNEL);
 	if (!item) {
 		fmsg->err = -ENOMEM;
-		return fmsg->err;
+		return;
 	}
 
 	item->nla_type = value_nla_type;
 	item->len = value_len;
 	item->attrtype = DEVLINK_ATTR_FMSG_OBJ_VALUE_DATA;
 	memcpy(&item->value, value, item->len);
 	list_add_tail(&item->list, &fmsg->item_list);
-
-	return 0;
 }
 
-static int devlink_fmsg_bool_put(struct devlink_fmsg *fmsg, bool value)
+static void devlink_fmsg_bool_put(struct devlink_fmsg *fmsg, bool value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_FLAG);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_FLAG);
 }
 
-static int devlink_fmsg_u8_put(struct devlink_fmsg *fmsg, u8 value)
+static void devlink_fmsg_u8_put(struct devlink_fmsg *fmsg, u8 value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U8);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U8);
 }
 
-int devlink_fmsg_u32_put(struct devlink_fmsg *fmsg, u32 value)
+void devlink_fmsg_u32_put(struct devlink_fmsg *fmsg, u32 value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U32);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U32);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u32_put);
 
-static int devlink_fmsg_u64_put(struct devlink_fmsg *fmsg, u64 value)
+static void devlink_fmsg_u64_put(struct devlink_fmsg *fmsg, u64 value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	return devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U64);
+	devlink_fmsg_put_value(fmsg, &value, sizeof(value), NLA_U64);
 }
 
-int devlink_fmsg_string_put(struct devlink_fmsg *fmsg, const char *value)
+void devlink_fmsg_string_put(struct devlink_fmsg *fmsg, const char *value)
 {
 	devlink_fmsg_err_if_binary(fmsg);
-	return devlink_fmsg_put_value(fmsg, value, strlen(value) + 1,
-				      NLA_NUL_STRING);
+	devlink_fmsg_put_value(fmsg, value, strlen(value) + 1, NLA_NUL_STRING);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_string_put);
 
-int devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
-			    u16 value_len)
+void devlink_fmsg_binary_put(struct devlink_fmsg *fmsg, const void *value,
+			     u16 value_len)
 {
-	if (!fmsg->putting_binary)
-		return -EINVAL;
+	if (!fmsg->err && !fmsg->putting_binary)
+		fmsg->err = -EINVAL;
 
-	return devlink_fmsg_put_value(fmsg, value, value_len, NLA_BINARY);
+	devlink_fmsg_put_value(fmsg, value, value_len, NLA_BINARY);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_put);
 
-int devlink_fmsg_bool_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			       bool value)
+void devlink_fmsg_bool_pair_put(struct devlink_fmsg *fmsg, const char *name,
+				bool value)
 {
 	devlink_fmsg_pair_nest_start(fmsg, name);
 	devlink_fmsg_bool_put(fmsg, value);
-	return devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_bool_pair_put);
 
-int devlink_fmsg_u8_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			     u8 value)
+void devlink_fmsg_u8_pair_put(struct devlink_fmsg *fmsg, const char *name,
+			      u8 value)
 {
 	devlink_fmsg_pair_nest_start(fmsg, name);
 	devlink_fmsg_u8_put(fmsg, value);
-	return devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u8_pair_put);
 
-int devlink_fmsg_u32_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			      u32 value)
+void devlink_fmsg_u32_pair_put(struct devlink_fmsg *fmsg, const char *name,
+			       u32 value)
 {
 	devlink_fmsg_pair_nest_start(fmsg, name);
 	devlink_fmsg_u32_put(fmsg, value);
-	return devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u32_pair_put);
 
-int devlink_fmsg_u64_pair_put(struct devlink_fmsg *fmsg, const char *name,
-			      u64 value)
+void devlink_fmsg_u64_pair_put(struct devlink_fmsg *fmsg, const char *name,
+			       u64 value)
 {
 	devlink_fmsg_pair_nest_start(fmsg, name);
 	devlink_fmsg_u64_put(fmsg, value);
-	return devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_u64_pair_put);
 
-int devlink_fmsg_string_pair_put(struct devlink_fmsg *fmsg, const char *name,
-				 const char *value)
+void devlink_fmsg_string_pair_put(struct devlink_fmsg *fmsg, const char *name,
+				  const char *value)
 {
 	devlink_fmsg_pair_nest_start(fmsg, name);
 	devlink_fmsg_string_put(fmsg, value);
-	return devlink_fmsg_pair_nest_end(fmsg);
+	devlink_fmsg_pair_nest_end(fmsg);
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_string_pair_put);
 
-int devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
-				 const void *value, u32 value_len)
+void devlink_fmsg_binary_pair_put(struct devlink_fmsg *fmsg, const char *name,
+				  const void *value, u32 value_len)
 {
 	u32 data_size;
 	u32 offset;
-	int err;
 
-	err = devlink_fmsg_binary_pair_nest_start(fmsg, name);
-	if (err)
-		return err;
+	devlink_fmsg_binary_pair_nest_start(fmsg, name);
 
 	for (offset = 0; offset < value_len; offset += data_size) {
 		data_size = value_len - offset;
 		if (data_size > DEVLINK_FMSG_MAX_SIZE)
 			data_size = DEVLINK_FMSG_MAX_SIZE;
-		err = devlink_fmsg_binary_put(fmsg, value + offset, data_size);
-		if (err)
-			break;
-		/* Exit from loop with a break (instead of
-		 * return) to make sure putting_binary is turned off
-		 */
+
+		devlink_fmsg_binary_put(fmsg, value + offset, data_size);
 	}
 
-	err = devlink_fmsg_binary_pair_nest_end(fmsg);
+	devlink_fmsg_binary_pair_nest_end(fmsg);
 	fmsg->putting_binary = false;
-
-	return err;
 }
 EXPORT_SYMBOL_GPL(devlink_fmsg_binary_pair_put);
 
@@ -1051,6 +1029,9 @@ static int devlink_fmsg_snd(struct devlink_fmsg *fmsg,
 	void *hdr;
 	int err;
 
+	if (fmsg->err)
+		return fmsg->err;
+
 	while (!last) {
 		int tmp_index = index;
 
@@ -1104,6 +1085,9 @@ static int devlink_fmsg_dumpit(struct devlink_fmsg *fmsg, struct sk_buff *skb,
 	void *hdr;
 	int err;
 
+	if (fmsg->err)
+		return fmsg->err;
+
 	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
 			  &devlink_nl_family, NLM_F_ACK | NLM_F_MULTI, cmd);
 	if (!hdr) {
@@ -1143,17 +1127,13 @@ int devlink_nl_cmd_health_reporter_diagnose_doit(struct sk_buff *skb,
 	if (!fmsg)
 		return -ENOMEM;
 
-	err = devlink_fmsg_obj_nest_start(fmsg);
-	if (err)
-		goto out;
+	devlink_fmsg_obj_nest_start(fmsg);
 
 	err = reporter->ops->diagnose(reporter, fmsg, info->extack);
 	if (err)
 		goto out;
 
-	err = devlink_fmsg_obj_nest_end(fmsg);
-	if (err)
-		goto out;
+	devlink_fmsg_obj_nest_end(fmsg);
 
 	err = devlink_fmsg_snd(fmsg, info,
 			       DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE, 0);
-- 
2.38.1

