Return-Path: <linux-kernel+bounces-65806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DAD85521A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F71E1F298E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C007A12C80C;
	Wed, 14 Feb 2024 18:30:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC1612BF1C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935437; cv=none; b=HmageslhNHufQEYklkOly2FwqQPsoEymNTgyF/A0T0wXolX0WfZBTOncn3NZg4cuHSdfdcSJKZZDzXVM/2TLF6UzNL/fTwhXKkKeBQnnrxoe7MSe4QdWGaEb9lr+Bm3KA30koC4HdfC1SzR3jQFeknsU2cRdf/zFhu9e+s8sfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935437; c=relaxed/simple;
	bh=aLQIYcBnbK+esT1CQfwNNNQB4YwDBeNIL7pYpzFWpYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivQzZYg3ShBEs1x34ivgVP0H+TDV5O43nQDbySxMrYts2ilFGWkAoyA3kZNQ4blHEKDxKEXdmLMgMIGbCC2pp4esMyokH80iJ7DU+nIE/pONMt9f8KAZT7Ye/qH9HmLcP0GXye/1sbBxG9ICXdFrsJspBI94k5OSAUEsEsQFnZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B94A1476;
	Wed, 14 Feb 2024 10:31:15 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC2173F7B4;
	Wed, 14 Feb 2024 10:30:32 -0800 (PST)
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
Subject: [PATCH 2/7] firmware: arm_scmi: Add support for v3.2 NEGOTIATE_PROTOCOL_VERSION
Date: Wed, 14 Feb 2024 18:30:01 +0000
Message-ID: <20240214183006.3403207-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214183006.3403207-1-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Freshly introduced NEGOTIATE_PROTOCOL_VERSION allows the agent to ascertain
upfront if a specific, usually older, protocol version is supported by the
platform.

It is used by the agent in case the platform has advertised the support of
a newer protocol version than the latest version supported by the agent,
since backward compatibility cannot be automatically assumed.

Emit a warning about possible incompatibility when negotiation was not
possible or just print the successfully negotiated protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 65 ++++++++++++++++++++++++---
 drivers/firmware/arm_scmi/protocols.h |  1 +
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 4a64ad5c21ee..34d77802c990 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -86,6 +86,12 @@ struct scmi_xfers_info {
  * @users: A refcount to track effective users of this protocol.
  * @priv: Reference for optional protocol private data.
  * @version: Protocol version supported by the platform as detected at runtime.
+ * @negotiated_version: When the platform supports a newer protocol version,
+ *			the agent will try to negotiate with the platform the
+ *			usage of the newest version known to it, since
+ *			backward compatibility is NOT automatically assured.
+ *			This field is NON-zero when a successful negotiation
+ *			has completed.
  * @ph: An embedded protocol handle that will be passed down to protocol
  *	initialization code to identify this instance.
  *
@@ -99,6 +105,7 @@ struct scmi_protocol_instance {
 	refcount_t			users;
 	void				*priv;
 	unsigned int			version;
+	unsigned int			negotiated_version;
 	struct scmi_protocol_handle	ph;
 };
 
@@ -1815,6 +1822,44 @@ scmi_revision_area_get(const struct scmi_protocol_handle *ph)
 	return pi->handle->version;
 }
 
+/**
+ * scmi_protocol_version_negotiate  - Negotiate protocol version
+ *
+ * @ph: A reference to the protocol handle.
+ *
+ * An helper to negotiate a protocol version different from the latest
+ * advertised as supported from the platform: on Success backward
+ * compatibility is assured by the platform.
+ *
+ * Return: 0 on Success
+ */
+static int scmi_protocol_version_negotiate(struct scmi_protocol_handle *ph)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	/* At first check if NEGOTIATE_PROTOCOL_VERSION is supported ... */
+	ret = scmi_protocol_msg_check(ph, NEGOTIATE_PROTOCOL_VERSION, NULL);
+	if (ret)
+		return ret;
+
+	/* ... then attempt protocol version negotiation */
+	ret = xfer_get_init(ph, NEGOTIATE_PROTOCOL_VERSION,
+			    sizeof(__le32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(pi->proto->supported_version, t->tx.buf);
+	ret = do_xfer(ph, t);
+	if (!ret)
+		pi->negotiated_version = pi->proto->supported_version;
+
+	xfer_put(ph, t);
+
+	return ret;
+}
+
 /**
  * scmi_alloc_init_protocol_instance  - Allocate and initialize a protocol
  * instance descriptor.
@@ -1887,11 +1932,21 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
 	devres_close_group(handle->dev, pi->gid);
 	dev_dbg(handle->dev, "Initialized protocol: 0x%X\n", pi->proto->id);
 
-	if (pi->version > proto->supported_version)
-		dev_warn(handle->dev,
-			 "Detected UNSUPPORTED higher version 0x%X for protocol 0x%X."
-			 "Backward compatibility is NOT assured.\n",
-			 pi->version, pi->proto->id);
+	if (pi->version > proto->supported_version) {
+		ret = scmi_protocol_version_negotiate(&pi->ph);
+		if (!ret) {
+			dev_info(handle->dev,
+				 "Protocol 0x%X successfully negotiated version 0x%X\n",
+				 proto->id, pi->negotiated_version);
+		} else {
+			dev_warn(handle->dev,
+				 "Detected UNSUPPORTED higher version 0x%X for protocol 0x%X.\n",
+				 pi->version, pi->proto->id);
+			dev_warn(handle->dev,
+				 "Trying version 0x%X. Backward compatibility is NOT assured.\n",
+				 pi->proto->supported_version);
+		}
+	}
 
 	return pi;
 
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 26a3edd49fea..693019fff0f6 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -33,6 +33,7 @@ enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
 	PROTOCOL_ATTRIBUTES = 0x1,
 	PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
+	NEGOTIATE_PROTOCOL_VERSION = 0x10,
 };
 
 /**
-- 
2.43.0


