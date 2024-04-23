Return-Path: <linux-kernel+bounces-154755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B018AE092
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C971F21782
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340659161;
	Tue, 23 Apr 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lw3ZPOpI"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE056768;
	Tue, 23 Apr 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863177; cv=none; b=ttgA89+xrVc4MEKvQhSC8Fx5xsI7Tu6s06QrRflujCwXQO7Py0+tt/dEzrrc6X+2Ojqp880/OFNifp2opPMy7SV15obdqdsx8PUIaQ0DDBmzwRjq2oeyw5QCZOOdR4mU/7hPFbmCLSuFdx5S+KlvZb64kVd5LqlXa9Ynpw9o2m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863177; c=relaxed/simple;
	bh=30B4AtuolDboQHql5UUskhU5+dDy3nL0iec2d0X9dt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQYQIfeLsqthI2MHRHq2Uno4mplE1GdgjnAENcsS5St3Aw143VBpu8E1Tasc/OZJWie4P3kzPwPkXDuaOXEsukqV+27fGrxzIHD/62rc9cWrn/WWFtHGZ2D73Ug0Zxyvh23GCEdKh7fOvyH/pQSeXKfbye26uoV8z8XFIRH6clA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lw3ZPOpI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC8E1E000C;
	Tue, 23 Apr 2024 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713863173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv8IAJl5ZT2KI5eGTFuxjLT4/JyU5BmA9vKpIsy+9T4=;
	b=lw3ZPOpIlG9Fdutzqsus7l0rnv1YaZPTZG6ilDrD10+Y+ehMjx1ZfFsUz9HorVTwjrs1FS
	ySKZnf/lzXcoZFhBY4PEkQ4ShTs46TZ+i/NpG7XhoSOxfvkHsCrO2HcB5G6IHGOf9SbybB
	cgLM6Y5pMP2kxphxQp9kwGYBcVqZFwawNgwUuJzBspjnD8uBzW5hhf/RmRSMgsordwMaz8
	kEEnqgsf12ep5U+DkiYEU8GFMJmys/Y9fKpYBvRkrKQPxDEd58q5T+ikCwjtOrGZzKmXZd
	O/K+ykd67xIBRpMZd4TE57pmgey46rW7GJGRQ1oIphD6iHLjSkhNpHIXQuTM4Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 23 Apr 2024 11:05:42 +0200
Subject: [PATCH ethtool-next 2/2] ethtool: pse-pd: Add support for Power
 over Ethernet (clause 33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-feature_poe-v1-2-9e12136a8674@bootlin.com>
References: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
In-Reply-To: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This update extends PSE support to include Power over Ethernet (clause 33),
encompassing standards 802.3af, 802.3at, and 802.3bt infrastructure.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 ethtool.c        |  1 +
 netlink/pse-pd.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index e587597..d85a57a 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6216,6 +6216,7 @@ static const struct option args[] = {
 		.nlfunc	= nl_spse,
 		.help	= "Set Power Sourcing Equipment settings",
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
+			  "		[ c33-pse-admin-control enable|disable ]\n"
 	},
 	{
 		.opts	= "-h|--help",
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index d6faff8..2c8dd89 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -54,6 +54,41 @@ static const char *podl_pse_pw_d_status_name(u32 val)
 	}
 }
 
+static const char *c33_pse_admin_state_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN:
+		return "unknown";
+	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
+		return "disabled";
+	case ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED:
+		return "enabled";
+	default:
+		return "unsupported";
+	}
+}
+
+static const char *c33_pse_pw_d_status_name(u32 val)
+{
+	switch (val) {
+	case ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN:
+		return "unknown";
+	case ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED:
+		return "disabled";
+	case ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING:
+		return "searching";
+	case ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING:
+		return "delivering power";
+	case ETHTOOL_C33_PSE_PW_D_STATUS_TEST:
+		return "test";
+	case ETHTOOL_C33_PSE_PW_D_STATUS_FAULT:
+		return "fault";
+	case ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT:
+		return "otherfault";
+	default:
+		return "unsupported";
+	}
+}
 int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 {
 	const struct nlattr *tb[ETHTOOL_A_PSE_MAX + 1] = {};
@@ -98,6 +133,24 @@ int pse_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			     podl_pse_pw_d_status_name(val));
 	}
 
+	if (tb[ETHTOOL_A_C33_PSE_ADMIN_STATE]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_STATE]);
+		print_string(PRINT_ANY, "c33-pse-admin-state",
+			     "Clause 33 PSE Admin State: %s\n",
+			     c33_pse_admin_state_name(val));
+	}
+
+	if (tb[ETHTOOL_A_C33_PSE_PW_D_STATUS]) {
+		u32 val;
+
+		val = mnl_attr_get_u32(tb[ETHTOOL_A_C33_PSE_PW_D_STATUS]);
+		print_string(PRINT_ANY, "c33-pse-power-detection-status",
+			     "Clause 33 PSE Power Detection Status: %s\n",
+			     c33_pse_pw_d_status_name(val));
+	}
+
 	close_json_object();
 
 	return MNL_CB_OK;
@@ -138,6 +191,12 @@ static const struct lookup_entry_u32 podl_pse_admin_control_values[] = {
 	{}
 };
 
+static const struct lookup_entry_u32 c33_pse_admin_control_values[] = {
+	{ .arg = "enable",	.val = ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED },
+	{ .arg = "disable",	.val = ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED },
+	{}
+};
+
 static const struct param_parser spse_params[] = {
 	{
 		.arg		= "podl-pse-admin-control",
@@ -146,6 +205,13 @@ static const struct param_parser spse_params[] = {
 		.handler_data	= podl_pse_admin_control_values,
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "c33-pse-admin-control",
+		.type		= ETHTOOL_A_C33_PSE_ADMIN_CONTROL,
+		.handler	= nl_parse_lookup_u32,
+		.handler_data	= c33_pse_admin_control_values,
+		.min_argc	= 1,
+	},
 	{}
 };
 

-- 
2.34.1


