Return-Path: <linux-kernel+bounces-15649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A88822F8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384FD2844F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4C1BDCC;
	Wed,  3 Jan 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="buCe7svu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45F1A726;
	Wed,  3 Jan 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C96CEFF806;
	Wed,  3 Jan 2024 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704292200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11pFkuDDUTbLupTgUFR2BnipK5D6jj0VQU5ibyq/SFk=;
	b=buCe7svu6Rh6Zxb5xgxjNhZbGWWhdqX1jk/FUlXleCr8BMnYSkoFOCY4PsHaP6NgZb93SK
	3KS9jPAv8WyUDeh6LrYpWCTKEQa+snp/X0jJiiDeIvfUWt/VqKzkuEYAyr747YCFVexkTz
	OQSrKb+SZIrlY3frl8cnTQzzWxtncRi/PRzpzJBfUmPcjwIag4gOdNMeeNN5sSfPiJKf1T
	ysWzCU32KGX97GitdJPCnx0oV8du/m0q8QLAkjGKKKssAyTQyJr7E4I0zvMmfezREzFkD3
	T/zZydmeazwqifEJsDvPuTH9E8sdyb+2vHNCe1CMb2dxf1X5uqNpomrUl7s9pw==
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
Subject: [PATCH ethtool-next 2/3] ethtool: Allow passing a PHY index for phy-targetting commands
Date: Wed,  3 Jan 2024 15:29:47 +0100
Message-ID: <20240103142950.235888-3-maxime.chevallier@bootlin.com>
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

With the introduction of PHY topology and the ability to list PHYs, we
can now target some netlink commands to specific PHYs. This is done by
passing a PHY index as a request parameter in the netlink GET command.

This is useful for PSE-PD, PLCA and Cable-testing operations when
multiple PHYs are on the link (e.g. when a PHY is used as an SFP
upstream controller, and when there's another PHY within the SFP
module).

Introduce a new, generic, option "--phy N" that can be used in
conjunction with PHY-targetting commands to pass the PHY index for the
targetted PHY.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 ethtool.c            | 25 ++++++++++++++++++++-
 internal.h           |  1 +
 netlink/cable_test.c |  4 ++--
 netlink/msgbuff.c    | 52 ++++++++++++++++++++++++++++++++++----------
 netlink/msgbuff.h    |  3 +++
 netlink/nlsock.c     |  3 ++-
 netlink/plca.c       |  4 ++--
 netlink/pse-pd.c     |  4 ++--
 8 files changed, 76 insertions(+), 20 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index af51220..4c7c792 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5640,6 +5640,7 @@ struct option {
 	const char	*opts;
 	bool		no_dev;
 	bool		json;
+	bool		targets_phy;
 	int		(*func)(struct cmd_context *);
 	nl_chk_t	nlchk;
 	nl_func_t	nlfunc;
@@ -6053,12 +6054,14 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--cable-test",
+		.targets_phy	= true,
 		.json	= true,
 		.nlfunc	= nl_cable_test,
 		.help	= "Perform a cable test",
 	},
 	{
 		.opts	= "--cable-test-tdr",
+		.targets_phy	= true,
 		.json	= true,
 		.nlfunc	= nl_cable_test_tdr,
 		.help	= "Print cable test time domain reflectrometery data",
@@ -6086,11 +6089,13 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--get-plca-cfg",
+		.targets_phy	= true,
 		.nlfunc	= nl_plca_get_cfg,
 		.help	= "Get PLCA configuration",
 	},
 	{
 		.opts	= "--set-plca-cfg",
+		.targets_phy	= true,
 		.nlfunc	= nl_plca_set_cfg,
 		.help	= "Set PLCA configuration",
 		.xhelp  = "		[ enable on|off ]\n"
@@ -6102,6 +6107,7 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--get-plca-status",
+		.targets_phy	= true,
 		.nlfunc	= nl_plca_get_status,
 		.help	= "Get PLCA status information",
 	},
@@ -6123,12 +6129,14 @@ static const struct option args[] = {
 	},
 	{
 		.opts	= "--show-pse",
+		.targets_phy	= true,
 		.json	= true,
 		.nlfunc	= nl_gpse,
 		.help	= "Show settings for Power Sourcing Equipment",
 	},
 	{
 		.opts	= "--set-pse",
+		.targets_phy	= true,
 		.nlfunc	= nl_spse,
 		.help	= "Set Power Sourcing Equipment settings",
 		.xhelp	= "		[ podl-pse-admin-control enable|disable ]\n"
@@ -6157,7 +6165,8 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout,	"Usage:\n");
 	for (i = 0; args[i].opts; i++) {
 		fputs("        ethtool [ FLAGS ] ", stdout);
-		fprintf(stdout, "%s %s\t%s\n",
+		fprintf(stdout, "%s%s %s\t%s\n",
+			args[i].targets_phy ? "[ --phy PHY ] " : "",
 			args[i].opts,
 			args[i].no_dev ? "\t" : "DEVNAME",
 			args[i].help);
@@ -6437,6 +6446,16 @@ int main(int argc, char **argp)
 			argc -= 1;
 			continue;
 		}
+		if (*argp && !strcmp(*argp, "--phy")) {
+			char *eptr;
+
+			ctx.phy_index = strtoul(argp[1], &eptr, 0);
+			if (!argp[1][0] || *eptr)
+				exit_bad_args();
+			argp += 2;
+			argc -= 2;
+			continue;
+		}
 		break;
 	}
 	if (*argp && !strcmp(*argp, "--monitor")) {
@@ -6472,6 +6491,10 @@ int main(int argc, char **argp)
 	}
 	if (ctx.json && !args[k].json)
 		exit_bad_args();
+
+	if (!args[k].targets_phy && ctx.phy_index)
+		exit_bad_args();
+
 	ctx.argc = argc;
 	ctx.argp = argp;
 	netlink_run_handler(&ctx, args[k].nlchk, args[k].nlfunc, !args[k].func);
diff --git a/internal.h b/internal.h
index 4b994f5..afb8121 100644
--- a/internal.h
+++ b/internal.h
@@ -222,6 +222,7 @@ struct cmd_context {
 	unsigned long debug;	/* debugging mask */
 	bool json;		/* Output JSON, if supported */
 	bool show_stats;	/* include command-specific stats */
+	uint32_t phy_index;	/* the phy index this command targets */
 #ifdef ETHTOOL_ENABLE_NETLINK
 	struct nl_context *nlctx;	/* netlink context (opaque) */
 #endif
diff --git a/netlink/cable_test.c b/netlink/cable_test.c
index 9305a47..ba21c6c 100644
--- a/netlink/cable_test.c
+++ b/netlink/cable_test.c
@@ -572,8 +572,8 @@ int nl_cable_test_tdr(struct cmd_context *ctx)
 	if (ret < 0)
 		return 2;
 
-	if (ethnla_fill_header(msgbuff, ETHTOOL_A_CABLE_TEST_TDR_HEADER,
-			       ctx->devname, 0))
+	if (ethnla_fill_header_phy(msgbuff, ETHTOOL_A_CABLE_TEST_TDR_HEADER,
+				   ctx->devname, ctx->phy_index, 0))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, tdr_params, NULL, PARSER_GROUP_NEST, NULL);
diff --git a/netlink/msgbuff.c b/netlink/msgbuff.c
index 216f5b9..9b307eb 100644
--- a/netlink/msgbuff.c
+++ b/netlink/msgbuff.c
@@ -138,17 +138,9 @@ struct nlattr *ethnla_nest_start(struct nl_msg_buff *msgbuff, uint16_t type)
 	return NULL;
 }
 
-/**
- * ethnla_fill_header() - write standard ethtool request header to message
- * @msgbuff: message buffer
- * @type:    attribute type for header nest
- * @devname: device name (NULL to omit)
- * @flags:   request flags (omitted if 0)
- *
- * Return: pointer to the nest attribute or null of error
- */
-bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
-			const char *devname, uint32_t flags)
+static bool __ethnla_fill_header_phy(struct nl_msg_buff *msgbuff, uint16_t type,
+				     const char *devname, uint32_t phy_index,
+				     uint32_t flags)
 {
 	struct nlattr *nest;
 
@@ -159,7 +151,9 @@ bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
 	if ((devname &&
 	     ethnla_put_strz(msgbuff, ETHTOOL_A_HEADER_DEV_NAME, devname)) ||
 	    (flags &&
-	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)))
+	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_FLAGS, flags)) ||
+	    (phy_index &&
+	     ethnla_put_u32(msgbuff, ETHTOOL_A_HEADER_PHY_INDEX, phy_index)))
 		goto err;
 
 	ethnla_nest_end(msgbuff, nest);
@@ -170,6 +164,40 @@ err:
 	return true;
 }
 
+/**
+ * ethnla_fill_header() - write standard ethtool request header to message
+ * @msgbuff: message buffer
+ * @type:    attribute type for header nest
+ * @devname: device name (NULL to omit)
+ * @flags:   request flags (omitted if 0)
+ *
+ * Return: pointer to the nest attribute or null of error
+ */
+bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
+			const char *devname, uint32_t flags)
+{
+	return __ethnla_fill_header_phy(msgbuff, type, devname, 0, flags);
+}
+
+/**
+ * ethnla_fill_header_phy() - write standard ethtool request header to message,
+ *			      targetting a device's phy
+ * @msgbuff: message buffer
+ * @type:    attribute type for header nest
+ * @devname: device name (NULL to omit)
+ * @phy_index: phy index to target
+ * @flags:   request flags (omitted if 0)
+ *
+ * Return: pointer to the nest attribute or null of error
+ */
+bool ethnla_fill_header_phy(struct nl_msg_buff *msgbuff, uint16_t type,
+			    const char *devname, uint32_t phy_index,
+			    uint32_t flags)
+{
+	return __ethnla_fill_header_phy(msgbuff, type, devname, phy_index,
+					flags);
+}
+
 /**
  * __msg_init() - init a genetlink message, fill netlink and genetlink header
  * @msgbuff: message buffer
diff --git a/netlink/msgbuff.h b/netlink/msgbuff.h
index 7d6731f..7df19fc 100644
--- a/netlink/msgbuff.h
+++ b/netlink/msgbuff.h
@@ -47,6 +47,9 @@ bool ethnla_put(struct nl_msg_buff *msgbuff, uint16_t type, size_t len,
 struct nlattr *ethnla_nest_start(struct nl_msg_buff *msgbuff, uint16_t type);
 bool ethnla_fill_header(struct nl_msg_buff *msgbuff, uint16_t type,
 			const char *devname, uint32_t flags);
+bool ethnla_fill_header_phy(struct nl_msg_buff *msgbuff, uint16_t type,
+			    const char *devname, uint32_t phy_index,
+			    uint32_t flags);
 
 /* length of current message */
 static inline unsigned int msgbuff_len(const struct nl_msg_buff *msgbuff)
diff --git a/netlink/nlsock.c b/netlink/nlsock.c
index 0ec2738..0b873a3 100644
--- a/netlink/nlsock.c
+++ b/netlink/nlsock.c
@@ -291,7 +291,8 @@ int nlsock_prep_get_request(struct nl_socket *nlsk, unsigned int nlcmd,
 	ret = msg_init(nlctx, &nlsk->msgbuff, nlcmd, nlm_flags);
 	if (ret < 0)
 		return ret;
-	if (ethnla_fill_header(&nlsk->msgbuff, hdr_attrtype, devname, flags))
+	if (ethnla_fill_header_phy(&nlsk->msgbuff, hdr_attrtype, devname,
+				   nlctx->ctx->phy_index, flags))
 		return -EMSGSIZE;
 
 	return 0;
diff --git a/netlink/plca.c b/netlink/plca.c
index 7d61e3b..7dc30a3 100644
--- a/netlink/plca.c
+++ b/netlink/plca.c
@@ -211,8 +211,8 @@ int nl_plca_set_cfg(struct cmd_context *ctx)
 		       NLM_F_REQUEST | NLM_F_ACK);
 	if (ret < 0)
 		return 2;
-	if (ethnla_fill_header(msgbuff, ETHTOOL_A_PLCA_HEADER,
-			       ctx->devname, 0))
+	if (ethnla_fill_header_phy(msgbuff, ETHTOOL_A_PLCA_HEADER,
+				   ctx->devname, ctx->phy_index, 0))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, set_plca_params, NULL, PARSER_GROUP_NONE, NULL);
diff --git a/netlink/pse-pd.c b/netlink/pse-pd.c
index d6faff8..5ee3a28 100644
--- a/netlink/pse-pd.c
+++ b/netlink/pse-pd.c
@@ -174,8 +174,8 @@ int nl_spse(struct cmd_context *ctx)
 		       NLM_F_REQUEST | NLM_F_ACK);
 	if (ret < 0)
 		return 2;
-	if (ethnla_fill_header(msgbuff, ETHTOOL_A_PSE_HEADER,
-			       ctx->devname, 0))
+	if (ethnla_fill_header_phy(msgbuff, ETHTOOL_A_PSE_HEADER,
+				   ctx->devname, ctx->phy_index, 0))
 		return -EMSGSIZE;
 
 	ret = nl_parser(nlctx, spse_params, NULL, PARSER_GROUP_NONE, NULL);
-- 
2.43.0


