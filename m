Return-Path: <linux-kernel+bounces-97785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88275876F63
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A491BB210F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7282772A;
	Sat,  9 Mar 2024 06:33:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67116FF30
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709965983; cv=none; b=ZEo9jcerPSFHMAyqLWrOTfNFS13Dah1qENdsTUzXmbtiESyUstLAHbyyKPkv+WIaZgcDUrSGAzZBZUm4v83rDypQDdO6DKduEiPqDHA5ZPggiUP8PdBEdUcSB20qA2E76fPP6YVGW0xWNOMP2ajoWD1XkDSfKoP4K9ZUXH3cgFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709965983; c=relaxed/simple;
	bh=FpcLSjcTErLbde7+UZnGYmtaYcUGHirL4BhI2VlIiY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGqhSHW1v99cQ3pidSfd0lBhCkm4G9J1UMYtgegh2an0LvEGDQKEKcWSHspvFzZqd2zJ3fK1+LxzA6JQuvP0xTwCI1WMobUe1AzELwcUGM22U2yB7bRrYtLH0oNdjRr9ylj49PYIVAwpNyYvGoJ8uHC3svYiVrVnD5Td2cfhP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1riqG9-0007rY-3T; Sat, 09 Mar 2024 07:32:41 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1riqG7-005HSQ-4S; Sat, 09 Mar 2024 07:32:39 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1riqG7-003hzo-0F;
	Sat, 09 Mar 2024 07:32:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/1] net: bridge: switchdev: Improve error message clarity for switchdev_port_obj_add/del_deffered operations
Date: Sat,  9 Mar 2024 07:32:38 +0100
Message-Id: <20240309063238.884067-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Enhance the error reporting mechanism in the switchdev framework to
provide more informative and user-friendly error messages.

Following feedback from users struggling to understand the implications
of error messages like "failed (err=-28) to add object (id=2)", this
update aims to clarify what operation failed and how this might impact
the system or network.

With this change, error messages now include a description of the failed
operation, the specific object involved, and a brief explanation of the
potential impact on the system. This approach helps administrators and
developers better understand the context and severity of errors,
facilitating quicker and more effective troubleshooting.

Example of the improved logging:

[   70.516446] ksz-switch spi0.0 uplink: Failed to add Port Multicast
               Database entry (object id=2) with error: -ENOSPC (-28).
[   70.516446] Failure in updating the port's Multicast Database could
               lead to multicast forwarding issues.
[   70.516446] Current HW/SW setup lacks sufficient resources.

This comprehensive update includes handling for a range of switchdev
object IDs, ensuring that most operations within the switchdev framework
benefit from clearer error reporting.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Simon Horman <horms@kernel.org>
---
changes v3:
- fix check patch warnings
changes v2:
- make all variables const
- add Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/switchdev/switchdev.c | 99 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index c9189a970eec3..6488ead9e4645 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -244,6 +244,99 @@ static int switchdev_port_obj_notify(enum switchdev_notifier_type nt,
 	return 0;
 }
 
+static void switchdev_obj_id_to_helpful_msg(struct net_device *dev,
+					    enum switchdev_obj_id obj_id,
+					    int err, bool add)
+{
+	const char *action = add ? "add" : "del";
+	const char *reason = "";
+	const char *problem;
+	const char *obj_str;
+
+	switch (obj_id) {
+	case SWITCHDEV_OBJ_ID_UNDEFINED:
+		obj_str = "Undefined object";
+		problem = "Attempted operation is undefined, indicating a possible programming\n"
+			  "error.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		obj_str = "VLAN entry";
+		problem = "Failure in VLAN settings on this port might disrupt network\n"
+			  "segmentation or traffic isolation, affecting network partitioning.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		obj_str = "Port Multicast Database entry";
+		problem = "Failure in updating the port's Multicast Database could lead to\n"
+			  "multicast forwarding issues.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		obj_str = "Host Multicast Database entry";
+		problem = "Failure in updating the host's Multicast Database may impact multicast\n"
+			  "group memberships or traffic delivery, affecting multicast\n"
+			  "communication.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_MRP:
+		obj_str = "Media Redundancy Protocol configuration for port";
+		problem = "Failure to set MRP ring ID on this port prevents communication with\n"
+			  "the specified redundancy ring, resulting in an inability to engage\n"
+			  "in MRP-based network operations.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_RING_TEST_MRP:
+		obj_str = "MRP Test Frame Operations for port";
+		problem = "Failure to generate/monitor MRP test frames may lead to inability to\n"
+			  "assess the ring's operational integrity and fault response, hindering\n"
+			  "proactive network management.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+		obj_str = "MRP Ring Role Configuration";
+		problem = "Improper MRP ring role configuration may create conflicts in the ring,\n"
+			  "disrupting communication for all participants, or isolate the local\n"
+			  "system from the ring, hindering its ability to communicate with other\n"
+			  "participants.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_RING_STATE_MRP:
+		obj_str = "MRP Ring State Configuration";
+		problem = "Failure to correctly set the MRP ring state can result in network\n"
+			  "loops or leave segments without communication. In a Closed state,\n"
+			  "it maintains loop prevention by blocking one MRM port, while an Open\n"
+			  "state activates in response to failures, changing port states to\n"
+			  "preserve network connectivity.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_IN_TEST_MRP:
+		obj_str = "MRP_InTest Frame Generation Configuration";
+		problem = "Failure in managing MRP_InTest frame generation can misjudge the\n"
+			  "interconnection ring's state, leading to incorrect blocking or\n"
+			  "unblocking of the I/C port. This misconfiguration might result\n"
+			  "in unintended network loops or isolate critical network segments,\n"
+			  "compromising network integrity and reliability.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_IN_ROLE_MRP:
+		obj_str = "Interconnection Ring Role Configuration";
+		problem = "Failure in incorrect assignment of interconnection ring roles\n"
+			  "(MIM/MIC) can impair the formation of the interconnection rings.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_IN_STATE_MRP:
+		obj_str = "Interconnection Ring State Configuration";
+		problem = "Failure in updating the interconnection ring state can lead in\n"
+			  "case of Open state to incorrect blocking or unblocking of the\n"
+			  "I/C port, resulting in unintended network loops or isolation\n"
+			  "of critical network\n";
+		break;
+	default:
+		obj_str = "Unknown object";
+		problem	= "Indicating a possible programming error.\n";
+	}
+
+	switch (err) {
+	case -ENOSPC:
+		reason = "Current HW/SW setup lacks sufficient resources.\n";
+		break;
+	}
+
+	netdev_err(dev, "Failed to %s %s (object id=%d) with error: %pe (%d).\n%s%s\n",
+		   action, obj_str, obj_id, ERR_PTR(err), err, problem, reason);
+}
+
 static void switchdev_port_obj_add_deferred(struct net_device *dev,
 					    const void *data)
 {
@@ -254,8 +347,7 @@ static void switchdev_port_obj_add_deferred(struct net_device *dev,
 	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
 					dev, obj, NULL);
 	if (err && err != -EOPNOTSUPP)
-		netdev_err(dev, "failed (err=%d) to add object (id=%d)\n",
-			   err, obj->id);
+		switchdev_obj_id_to_helpful_msg(dev, obj->id, err, true);
 	if (obj->complete)
 		obj->complete(dev, err, obj->complete_priv);
 }
@@ -304,8 +396,7 @@ static void switchdev_port_obj_del_deferred(struct net_device *dev,
 
 	err = switchdev_port_obj_del_now(dev, obj);
 	if (err && err != -EOPNOTSUPP)
-		netdev_err(dev, "failed (err=%d) to del object (id=%d)\n",
-			   err, obj->id);
+		switchdev_obj_id_to_helpful_msg(dev, obj->id, err, false);
 	if (obj->complete)
 		obj->complete(dev, err, obj->complete_priv);
 }
-- 
2.39.2


