Return-Path: <linux-kernel+bounces-15650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B88DC822F8D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79131C235AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115751BDF8;
	Wed,  3 Jan 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oX835lge"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D81B26C;
	Wed,  3 Jan 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46AA3FF815;
	Wed,  3 Jan 2024 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704292201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pe3P7wt/OwUcNmZVPqnsg3tJHeu05OH3jwhq110IVpk=;
	b=oX835lgeD2rmnAQrb0XQunLn7zN4iD4oeb11rh8Aze4bAcp6W0QwxMVR28p8MV8peL5WN0
	uIAgsQS0mbqWwc7F2rIUdehxXXwDJQ/8Sfsj2v38h7Au385jLDDtDNW3oZmUzzCP+/G0Hz
	qOHXogDKW+Uv0E6QGL6Il/OWIIyirNl27UtMg5y9vzLakBv587IzolwO+f3jnyTqwOK2by
	iTs+qTzT6zra/W3dJF22S/ubtmDcLlhK3pJL2u8SLkntkmA+RcRbhXpjaGzd4CgK0nUxDE
	M67Rkk+xc+PekDwkXV5LCNhoLpOUk7XVmIf1KiAl23e8zzHebV4AJobPrRIHPg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Michal Kubecek <mkubecek@suse.cz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH ethtool-next 3/3] ethtool: Introduce a command to list PHYs
Date: Wed,  3 Jan 2024 15:29:48 +0100
Message-ID: <20240103142950.235888-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103142950.235888-1-maxime.chevallier@bootlin.com>
References: <20240103142950.235888-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

It is now possible to list all Ethernet PHYs that are present behind a
given interface, since the following linux commit :
63d5eaf35ac3 ("net: ethtool: Introduce a command to list PHYs on an interface")

This command relies on the netlink DUMP command to list them, by allowing to
pass an interface name/id as a parameter in the DUMP request to only
list PHYs on one interface.

Therefore, we introduce a new helper function to prepare a interface-filtered
dump request (the filter can be empty, to perform an unfiltered dump),
and then uses it to implement PHY enumeration through the --show-phys
command.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Makefile.am      |   1 +
 ethtool.c        |   5 ++
 netlink/extapi.h |   1 +
 netlink/nlsock.c |  24 ++++++++
 netlink/nlsock.h |   2 +
 netlink/phy.c    | 139 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 172 insertions(+)
 create mode 100644 netlink/phy.c

diff --git a/Makefile.am b/Makefile.am
index b9e06ad..2434507 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -48,6 +48,7 @@ ethtool_SOURCES += \
 		  netlink/desc-rtnl.c netlink/cable_test.c netlink/tunnels.c \
 		  netlink/plca.c \
 		  netlink/pse-pd.c \
+		  netlink/phy.c \
 		  uapi/linux/ethtool_netlink.h \
 		  uapi/linux/netlink.h uapi/linux/genetlink.h \
 		  uapi/linux/rtnetlink.h uapi/linux/if_link.h \
diff --git a/ethtool.c b/ethtool.c
index 4c7c792..b877f2e 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6141,6 +6141,11 @@ static const struct option args[] = {
 		.help	= "Set Power Sourcing Equipment settings",
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
 	},
+	{
+		.opts	= "--show-phys",
+		.nlfunc	= nl_get_phy,
+		.help	= "List PHYs"
+	},
 	{
 		.opts	= "-h|--help",
 		.no_dev	= true,
diff --git a/netlink/extapi.h b/netlink/extapi.h
index e2d6b71..8f87f26 100644
--- a/netlink/extapi.h
+++ b/netlink/extapi.h
@@ -55,6 +55,7 @@ int nl_get_mm(struct cmd_context *ctx);
 int nl_set_mm(struct cmd_context *ctx);
 int nl_gpse(struct cmd_context *ctx);
 int nl_spse(struct cmd_context *ctx);
+int nl_get_phy(struct cmd_context *ctx);
 
 void nl_monitor_usage(void);
 
diff --git a/netlink/nlsock.c b/netlink/nlsock.c
index 0b873a3..510fc63 100644
--- a/netlink/nlsock.c
+++ b/netlink/nlsock.c
@@ -298,6 +298,30 @@ int nlsock_prep_get_request(struct nl_socket *nlsk, unsigned int nlcmd,
 	return 0;
 }
 
+int nlsock_prep_filtered_dump_request(struct nl_socket *nlsk,
+				      unsigned int nlcmd, uint16_t hdr_attrtype,
+				      u32 flags)
+{
+	unsigned int nlm_flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct nl_context *nlctx = nlsk->nlctx;
+	const char *devname = nlctx->ctx->devname;
+	int ret;
+
+	nlctx->is_dump = true;
+	nlm_flags |= NLM_F_DUMP;
+
+	if (devname && !strcmp(devname, WILDCARD_DEVNAME))
+		devname = NULL;
+
+	ret = msg_init(nlctx, &nlsk->msgbuff, nlcmd, nlm_flags);
+	if (ret < 0)
+		return ret;
+	if (ethnla_fill_header(&nlsk->msgbuff, hdr_attrtype, devname, flags))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 #ifndef TEST_ETHTOOL
 /**
  * nlsock_sendmsg() - send a netlink message to kernel
diff --git a/netlink/nlsock.h b/netlink/nlsock.h
index b015f86..6a72966 100644
--- a/netlink/nlsock.h
+++ b/netlink/nlsock.h
@@ -38,6 +38,8 @@ int nlsock_init(struct nl_context *nlctx, struct nl_socket **__nlsk,
 void nlsock_done(struct nl_socket *nlsk);
 int nlsock_prep_get_request(struct nl_socket *nlsk, unsigned int nlcmd,
 			    uint16_t hdr_attrtype, u32 flags);
+int nlsock_prep_filtered_dump_request(struct nl_socket *nlsk, unsigned int nlcmd,
+				      uint16_t hdr_attrtype, u32 flags);
 ssize_t nlsock_sendmsg(struct nl_socket *nlsk, struct nl_msg_buff *__msgbuff);
 int nlsock_send_get_request(struct nl_socket *nlsk, mnl_cb_t cb);
 int nlsock_process_reply(struct nl_socket *nlsk, mnl_cb_t reply_cb, void *data);
diff --git a/netlink/phy.c b/netlink/phy.c
new file mode 100644
index 0000000..c195cb9
--- /dev/null
+++ b/netlink/phy.c
@@ -0,0 +1,139 @@
+/*
+ * phy.c - List PHYs on an interface and their parameters
+ *
+ * Implementation of "ethtool --show-phys <dev>"
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <string.h>
+#include <stdio.h>
+
+#include "../internal.h"
+#include "../common.h"
+#include "netlink.h"
+
+/* PHY_GET / PHY_DUMP */
+
+static const char * phy_upstream_type_to_str(uint8_t upstream_type)
+{
+	switch (upstream_type) {
+	case PHY_UPSTREAM_PHY: return "PHY";
+	case PHY_UPSTREAM_MAC: return "MAC";
+	default: return "Unknown";
+	}
+}
+
+static int phy_show_upstream(const struct nlattr *nest)
+{
+	const struct nlattr *tb[ETHTOOL_A_PHY_UPSTREAM_MAX + 1] = {};
+	DECLARE_ATTR_TB_INFO(tb);
+	int ret;
+
+	ret = mnl_attr_parse_nested(nest, attr_cb, &tb_info);
+	if (ret < 0)
+		return ret;
+
+	open_json_object("upstream");
+
+	if (tb[ETHTOOL_A_PHY_UPSTREAM_INDEX])
+		show_u32("upstream_index", "Upstream PHY index: ",
+			 tb[ETHTOOL_A_PHY_UPSTREAM_INDEX]);
+
+	if (tb[ETHTOOL_A_PHY_UPSTREAM_SFP_NAME])
+		print_string(PRINT_ANY, "upstream_sfp_name", "Upstream SFP name: %s\n",
+			     mnl_attr_get_str(tb[ETHTOOL_A_PHY_UPSTREAM_SFP_NAME]));
+
+	close_json_object();
+
+	return 0;
+}
+
+int phy_reply_cb(const struct nlmsghdr *nlhdr, void *data)
+{
+	const struct nlattr *tb[ETHTOOL_A_PHY_MAX + 1] = {};
+	struct nl_context *nlctx = data;
+	DECLARE_ATTR_TB_INFO(tb);
+	uint8_t upstream_type;
+	bool silent;
+	int err_ret;
+	int ret;
+
+	silent = nlctx->is_dump || nlctx->is_monitor;
+	err_ret = silent ? MNL_CB_OK : MNL_CB_ERROR;
+	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
+	if (ret < 0)
+		return err_ret;
+	nlctx->devname = get_dev_name(tb[ETHTOOL_A_PHY_HEADER]);
+	if (!dev_ok(nlctx))
+		return err_ret;
+
+	if (silent)
+		print_nl();
+
+	open_json_object(NULL);
+
+	print_string(PRINT_ANY, "ifname", "PHY for %s:\n", nlctx->devname);
+
+	show_u32("phy_index", "PHY index: ", tb[ETHTOOL_A_PHY_INDEX]);
+
+	print_string(PRINT_ANY, "drvname", "Driver name: %s\n",
+		     mnl_attr_get_str(tb[ETHTOOL_A_PHY_DRVNAME]));
+
+	print_string(PRINT_ANY, "name", "PHY device name: %s\n",
+		     mnl_attr_get_str(tb[ETHTOOL_A_PHY_NAME]));
+
+	if (tb[ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME])
+		print_string(PRINT_ANY, "downstream_sfp_name",
+			     "Downstream SFP bus name: %s\n",
+			     mnl_attr_get_str(tb[ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME]));
+
+	show_u32("phy_id", "PHY id: ", tb[ETHTOOL_A_PHY_ID]);
+
+	upstream_type = mnl_attr_get_u8(tb[ETHTOOL_A_PHY_UPSTREAM_TYPE]);
+	print_string(PRINT_ANY, "upstream_type", "Upstream type: %s\n",
+		     phy_upstream_type_to_str(upstream_type));
+
+	if (tb[ETHTOOL_A_PHY_UPSTREAM]) {
+		err_ret = phy_show_upstream(tb[ETHTOOL_A_PHY_UPSTREAM]);
+		if (err_ret)
+			goto err;
+	}
+
+	if (!silent)
+		print_nl();
+
+	close_json_object();
+
+	return MNL_CB_OK;
+
+err:
+	close_json_object();
+	return err_ret;
+}
+
+int nl_get_phy(struct cmd_context *ctx)
+{
+	struct nl_context *nlctx = ctx->nlctx;
+	struct nl_socket *nlsk = nlctx->ethnl_socket;
+	u32 flags;
+	int ret;
+
+	if (netlink_cmd_check(ctx, ETHTOOL_MSG_PHY_GET, true))
+		return -EOPNOTSUPP;
+	if (ctx->argc > 0) {
+		fprintf(stderr, "ethtool: unexpected parameter '%s'\n",
+			*ctx->argp);
+		return 1;
+	}
+
+	ret = nlsock_prep_filtered_dump_request(nlsk, ETHTOOL_MSG_PHY_GET,
+						ETHTOOL_A_PHY_HEADER, flags);
+	if (ret)
+		return ret;
+
+	new_json_obj(ctx->json);
+	ret = nlsock_send_get_request(nlsk, phy_reply_cb);
+	delete_json_obj();
+	return ret;
+}
-- 
2.43.0


