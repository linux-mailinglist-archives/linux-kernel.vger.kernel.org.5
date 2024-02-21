Return-Path: <linux-kernel+bounces-75586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D985EB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721D12841B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24346128373;
	Wed, 21 Feb 2024 22:04:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66CC3A29E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553089; cv=none; b=Qi+fl48c3Z8WY+G9kNHAYtyajlOkqgb70xk7yQKu09yRavZ/f/7H//LmwUHCzqAKOuyLBCoMk6VFwxMSLmzAPcc+oc4mv3UIXtppj+M9sN3Cu4Ky5wLB9IcNs11vYaoPE4z7l2jLzi01oc5YODNKbZS4YJbYFdnfXIvRAmDLc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553089; c=relaxed/simple;
	bh=QosNy/Sq6euw/CGlf3VUVlRfq5RFG2DnnHxO6BqslvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4spc9+N1IVN1mr4BTe074n90TQenLM7tHdG9rzacV7oGAHHOb4kzwme8IVvVFya6DYc6xI8CufaTPZI8ShVQjiMSxTXMGSNhSCDfdBfWWEE9j0qBFfROstgjxXmpJl/02X7Kxrr/BZeLiKQi0tWzFMywEOkX1tym5V+XRZvbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DBC5DA7;
	Wed, 21 Feb 2024 14:05:22 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00DE13F766;
	Wed, 21 Feb 2024 14:04:41 -0800 (PST)
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
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Add support for multiple vendors custom protocols
Date: Wed, 21 Feb 2024 22:04:26 +0000
Message-ID: <20240221220426.1205146-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
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
Hi all,

this is meant to address the possibility of having multiple vendors
implementing distinct SCMI vendor protocols with possibly the same
overlapping protocol number without the need of crafting the Kconfig
at compile time to include only wanted protos
(and without the need for a lottery :P)

Basic idea is simple:

- vendor protos HAS to be 'tagged' at build time with a vendor_id
- vendor protos COULD also optionally be tagged at build time with
sub_vendor_id and implemetation version

- at init all the build vendor protos are registerd with the SCMI core
  using a key derived from the above tags

- at SCMI probe time the platform is identified via Base protocol as
  usual and all the required vendor protos (i.e. IDs defined in the DT
  as usual) are loaded after a lookup process based on the following rules:

  + protocol DB is searched using the platform/Base runtime provided tags

  	<vendor> / <sub_vendor> / <impl_ver>

    using the the following search logic (keys), first match:

     1. proto_id / <vendor_id> / <sub_vendor_id> / <impl_ver>

     2. proto_id / <vendor_id> / <sub_vendor_id> / 0

     3. proto_id / <vendor_id> / NULL / 0

  IOW, closest match, depending on how much fine grained is your
  protocol tuned (tagged) for the platform.

  I am doubtful about the usage of <impl_ver>, and tempted to drop it
  since we have anyway protocol version and NEGOTIATE_PROTOCOL_VERSION
  to deal with slight difference in fw revision...

Based on sudeep/for-linux-next on top of

	1c2c88cfcb2b ("clk: scmi: Support get/set duty_cycle operations")

Minimally tested ....

  Any feedback welcome

  Thanks,
  Cristian
---
 drivers/firmware/arm_scmi/driver.c    | 166 ++++++++++++++++++++++----
 drivers/firmware/arm_scmi/protocols.h |   5 +
 2 files changed, 149 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 34d77802c990..8fb2903698c9 100644
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
+scmi_vendor_protocol_signature(unsigned protocol_id, char *vendor_id,
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
@@ -206,21 +285,47 @@ static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
 
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
+	if (proto->vendor_id &&
+	    strlen(proto->vendor_id) >= SCMI_SHORT_NAME_MAX_SIZE) {
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
@@ -232,12 +337,23 @@ int scmi_protocol_register(const struct scmi_protocol *proto)
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
@@ -250,9 +366,15 @@ EXPORT_SYMBOL_GPL(scmi_protocol_register);
 
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
@@ -1888,7 +2010,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	/* Protocol specific devres group */
 	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
 	if (!gid) {
-		scmi_protocol_put(proto->id);
+		scmi_protocol_put(pi->proto);
 		goto out;
 	}
 
@@ -1952,7 +2074,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 
 clean:
 	/* Take care to put the protocol module's owner before releasing all */
-	scmi_protocol_put(proto->id);
+	scmi_protocol_put(proto);
 	devres_release_group(handle->dev, gid);
 out:
 	return ERR_PTR(ret);
@@ -1986,7 +2108,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
 		const struct scmi_protocol *proto;
 
 		/* Fails if protocol not registered on bus */
-		proto = scmi_protocol_get(protocol_id);
+		proto = scmi_protocol_get(protocol_id, &info->version);
 		if (proto)
 			pi = scmi_alloc_init_protocol_instance(info, proto);
 		else
@@ -2041,7 +2163,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
 
 		idr_remove(&info->protocols, protocol_id);
 
-		scmi_protocol_put(protocol_id);
+		scmi_protocol_put(pi->proto);
 
 		devres_release_group(handle->dev, gid);
 		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 693019fff0f6..cb8dbc93584b 100644
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
@@ -330,6 +332,9 @@ struct scmi_protocol {
 	const void				*ops;
 	const struct scmi_protocol_events	*events;
 	unsigned int				supported_version;
+	u32					impl_ver;
+	char					*vendor_id;
+	char					*sub_vendor_id;
 };
 
 #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto)	\
-- 
2.43.0


