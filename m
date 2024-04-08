Return-Path: <linux-kernel+bounces-135151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF589BBBE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E5C282A67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1F4AED6;
	Mon,  8 Apr 2024 09:31:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007B45C18
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568715; cv=none; b=habC0t+quAlarehBdwp/K0wm+y6hJqiEop2+IgZRfO6FXiUfXkSNV8vEn862FI5uiXONrl5E8RF9tl8FhVCT98UCzCU9wcDB9TbrFdu89MfWiinoP74Sw+/VTfynbtd2nV4/1qeotluTNIcbtr/ZFfv8Twn1TjOzmoX6Pg/Tb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568715; c=relaxed/simple;
	bh=cAB7lVdaxmigcFflcRhVLrOiqujuHKwn0xXyeZZ+WAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWgwRaqnBEgDM8yRoob8DNMtoT75W3NjIpyj2vBsPbQPo/taH9+KDvNdfHD401Vu0YwRGq+m7EmwIwlE/RXVwQQ+oZnaA+nC9X+c54w674COdsz1VV1tK98HFU8wN1gVikUcxPDzhr1sVJGekVzC5+Y3u3pZONDrNlyruabgqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5327A12FC;
	Mon,  8 Apr 2024 02:32:23 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A783F766;
	Mon,  8 Apr 2024 02:31:51 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	konrad.dybcio@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 1/2] firmware: arm_scmi: Add support for multiple vendors custom protocols
Date: Mon,  8 Apr 2024 10:30:51 +0100
Message-ID: <20240408093052.3801576-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408093052.3801576-1-cristian.marussi@arm.com>
References: <20240408093052.3801576-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a mechanism to be able to tag vendor protocol modules at compile-time
with a vendor/sub_vendor string and an implementation version and then to
choose to load, at run-time, only those vendor protocol modules matching
as close as possible the vendor/subvendor identification advertised by
the SCMI platform server.

In this way, any in-tree existent vendor protocol module can be build and
shipped by default in a single kernel image, even when using the same
clashing protocol identification numbers, since the SCMI core will take
care at run-time to load only the ones pertinent to the running system.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 165 ++++++++++++++++++++++----
 drivers/firmware/arm_scmi/protocols.h |  15 +++
 2 files changed, 158 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d0091459a276..aa18202054a5 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -33,6 +33,7 @@
 #include <linux/processor.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/xarray.h>
 
 #include "common.h"
 #include "notify.h"
@@ -44,8 +45,7 @@
 
 static DEFINE_IDA(scmi_id);
 
-static DEFINE_IDR(scmi_protocols);
-static DEFINE_SPINLOCK(protocol_lock);
+static DEFINE_XARRAY(scmi_protocols);
 
 /* List of all SCMI devices active in system */
 static LIST_HEAD(scmi_list);
@@ -194,11 +194,90 @@ struct scmi_info {
 #define bus_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, bus_nb)
 #define req_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, dev_req_nb)
 
-static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
+static unsigned long
+scmi_vendor_protocol_signature(unsigned int protocol_id, char *vendor_id,
+			       char *sub_vendor_id, u32 impl_ver)
 {
-	const struct scmi_protocol *proto;
+	char *signature, *p;
+	unsigned long hash = 0;
 
-	proto = idr_find(&scmi_protocols, protocol_id);
+	/* vendor_id/sub_vendor_id guaranteed <= SCMI_SHORT_NAME_MAX_SIZE */
+	signature = kasprintf(GFP_KERNEL, "%02X|%s|%s|0x%08X", protocol_id,
+			      vendor_id ?: "", sub_vendor_id ?: "", impl_ver);
+	if (!signature)
+		return 0;
+
+	p = signature;
+	while (*p)
+		hash = partial_name_hash(tolower(*p++), hash);
+	hash = end_name_hash(hash);
+
+	kfree(signature);
+
+	return hash;
+}
+
+static unsigned long
+scmi_protocol_key_calculate(int protocol_id, char *vendor_id,
+			    char *sub_vendor_id, u32 impl_ver)
+{
+	if (protocol_id < SCMI_PROTOCOL_VENDOR)
+		return protocol_id;
+	else
+		return scmi_vendor_protocol_signature(protocol_id, vendor_id,
+						      sub_vendor_id, impl_ver);
+}
+
+static const struct scmi_protocol *
+scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
+			    char *sub_vendor_id, u32 impl_ver)
+{
+	unsigned long key;
+	struct scmi_protocol *proto = NULL;
+
+	/* Searching for closest match ...*/
+	key = scmi_protocol_key_calculate(protocol_id, vendor_id,
+					  sub_vendor_id, impl_ver);
+	if (key)
+		proto = xa_load(&scmi_protocols, key);
+
+	if (proto)
+		return proto;
+
+	/* Any match on vendor/sub_vendor ? */
+	if (impl_ver) {
+		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
+						  sub_vendor_id, 0);
+		if (key)
+			proto = xa_load(&scmi_protocols, key);
+
+		if (proto)
+			return proto;
+	}
+
+	/* Any match on just the vendor ? */
+	if (sub_vendor_id) {
+		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
+						  NULL, 0);
+		if (key)
+			proto = xa_load(&scmi_protocols, key);
+	}
+
+	return proto;
+}
+
+static const struct scmi_protocol *
+scmi_protocol_get(int protocol_id, struct scmi_revision_info *version)
+{
+	const struct scmi_protocol *proto = NULL;
+
+	if (protocol_id < SCMI_PROTOCOL_VENDOR)
+		proto = xa_load(&scmi_protocols, protocol_id);
+	else
+		proto = scmi_vendor_protocol_lookup(protocol_id,
+						    version->vendor_id,
+						    version->sub_vendor_id,
+						    version->impl_ver);
 	if (!proto || !try_module_get(proto->owner)) {
 		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
 		return NULL;
@@ -206,21 +285,46 @@ static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
 
 	pr_debug("Found SCMI Protocol 0x%x\n", protocol_id);
 
+	if (protocol_id >= SCMI_PROTOCOL_VENDOR)
+		pr_info("Loaded SCMI Vendor Protocol 0x%x - %s %s %X\n",
+			protocol_id, proto->vendor_id ?: "",
+			proto->sub_vendor_id ?: "", proto->impl_ver);
+
 	return proto;
 }
 
-static void scmi_protocol_put(int protocol_id)
+static void scmi_protocol_put(const struct scmi_protocol *proto)
 {
-	const struct scmi_protocol *proto;
-
-	proto = idr_find(&scmi_protocols, protocol_id);
 	if (proto)
 		module_put(proto->owner);
 }
 
+static int scmi_vendor_protocol_check(const struct scmi_protocol *proto)
+{
+	if (!proto->vendor_id) {
+		pr_err("missing vendor_id for protocol 0x%x\n", proto->id);
+		return -EINVAL;
+	}
+
+	if (strlen(proto->vendor_id) >= SCMI_SHORT_NAME_MAX_SIZE) {
+		pr_err("malformed vendor_id for protocol 0x%x\n", proto->id);
+		return -EINVAL;
+	}
+
+	if (proto->sub_vendor_id &&
+	    strlen(proto->sub_vendor_id) >= SCMI_SHORT_NAME_MAX_SIZE) {
+		pr_err("malformed sub_vendor_id for protocol 0x%x\n",
+		       proto->id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int scmi_protocol_register(const struct scmi_protocol *proto)
 {
 	int ret;
+	unsigned long key;
 
 	if (!proto) {
 		pr_err("invalid protocol\n");
@@ -232,12 +336,23 @@ int scmi_protocol_register(const struct scmi_protocol *proto)
 		return -EINVAL;
 	}
 
-	spin_lock(&protocol_lock);
-	ret = idr_alloc(&scmi_protocols, (void *)proto,
-			proto->id, proto->id + 1, GFP_ATOMIC);
-	spin_unlock(&protocol_lock);
-	if (ret != proto->id) {
-		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
+	if (proto->id >= SCMI_PROTOCOL_VENDOR &&
+	    scmi_vendor_protocol_check(proto))
+		return -EINVAL;
+
+	/*
+	 * Calculate a protocol key to register this protocol with the core;
+	 * key value 0 is considered invalid.
+	 */
+	key = scmi_protocol_key_calculate(proto->id, proto->vendor_id,
+					  proto->sub_vendor_id,
+					  proto->impl_ver);
+	if (!key)
+		return -EINVAL;
+
+	ret = xa_insert(&scmi_protocols, key, (void *)proto, GFP_KERNEL);
+	if (ret) {
+		pr_err("unable to allocate SCMI protocol slot for 0x%x - err %d\n",
 		       proto->id, ret);
 		return ret;
 	}
@@ -250,9 +365,15 @@ EXPORT_SYMBOL_GPL(scmi_protocol_register);
 
 void scmi_protocol_unregister(const struct scmi_protocol *proto)
 {
-	spin_lock(&protocol_lock);
-	idr_remove(&scmi_protocols, proto->id);
-	spin_unlock(&protocol_lock);
+	unsigned long key;
+
+	key = scmi_protocol_key_calculate(proto->id, proto->vendor_id,
+					  proto->sub_vendor_id,
+					  proto->impl_ver);
+	if (!key)
+		return;
+
+	xa_erase(&scmi_protocols, key);
 
 	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);
 }
@@ -1940,7 +2061,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	/* Protocol specific devres group */
 	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
 	if (!gid) {
-		scmi_protocol_put(proto->id);
+		scmi_protocol_put(proto);
 		goto out;
 	}
 
@@ -2004,7 +2125,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 
 clean:
 	/* Take care to put the protocol module's owner before releasing all */
-	scmi_protocol_put(proto->id);
+	scmi_protocol_put(proto);
 	devres_release_group(handle->dev, gid);
 out:
 	return ERR_PTR(ret);
@@ -2038,7 +2159,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 		const struct scmi_protocol *proto;
 
 		/* Fails if protocol not registered on bus */
-		proto = scmi_protocol_get(protocol_id);
+		proto = scmi_protocol_get(protocol_id, &info->version);
 		if (proto)
 			pi = scmi_alloc_init_protocol_instance(info, proto);
 		else
@@ -2093,7 +2214,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 
 		idr_remove(&info->protocols, protocol_id);
 
-		scmi_protocol_put(protocol_id);
+		scmi_protocol_put(pi->proto);
 
 		devres_release_group(handle->dev, gid);
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 317d3fb32676..45ee8b35f56d 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -29,6 +29,8 @@
 #define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
 #define PROTOCOL_REV_MINOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x))))
 
+#define SCMI_PROTOCOL_VENDOR	0x80
+
 enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
 	PROTOCOL_ATTRIBUTES = 0x1,
@@ -323,6 +325,16 @@ typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
  *		       protocol by the agent. Each protocol implementation
  *		       in the agent is supposed to downgrade to match the
  *		       protocol version supported by the platform.
+ * @vendor_id: A firmware vendor string for vendor protocols matching.
+ *	       Ignored when @id identifies a standard protocol, cannot be NULL
+ *	       otherwise.
+ * @sub_vendor_id: A firmware sub_vendor string for vendor protocols matching.
+ *		   Ignored if NULL or when @id identifies a standard protocol.
+ * @impl_ver: A firmware implementation version for vendor protocols matching.
+ *	      Ignored if zero or if @id identifies a standard protocol.
+ *
+ * Note that vendor protocols matching at load time is performed by attempting
+ * the closest match first against the tuple (vendor, sub_vendor, impl_ver)
  */
 struct scmi_protocol {
 	const u8				id;
@@ -332,6 +344,9 @@ struct scmi_protocol {
 	const void				*ops;
 	const struct scmi_protocol_events	*events;
 	unsigned int				supported_version;
+	char					*vendor_id;
+	char					*sub_vendor_id;
+	u32					impl_ver;
 };
 
 #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto)	\
-- 
2.44.0


