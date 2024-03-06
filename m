Return-Path: <linux-kernel+bounces-93969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6738737A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD1286D74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AF7130E3A;
	Wed,  6 Mar 2024 13:21:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3D912C52C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731313; cv=none; b=JSGCV9EBhUa0uL9ckpO3OMvtD2+U9nB1VsczaqATvzTcI5Hwwei87iPTA0faeDtBvewS+RNB1O2Z/dQ29TdKR05NR5eBlULnkYad1EhvLt5hJjQT++RG13mpQfzkTeXzVX1Mi/gKs3IvawGtw7V+bytJYl1lT9UepbBJ/jR4/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731313; c=relaxed/simple;
	bh=rNCo6YTRtJ0N3dTHRg1KBXCJ/MqCSeZD2RbLa6pVvK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JaX3Ci1JreAKus5vprD3O+yGHRFOLcE3S9SdyCruT1dnss3FCZr+81uwL0yH3Ibcn1nPJsq6LGvCdCDWuE2usl8hzCEgoGeslTSA5QuCyQTgtRNyzgXAKrLrevuG0kOy6UJ6ZbC8QrUB8lcZ6kqAUhJk/MoY/sd59RxB2ccHKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rhrDC-0006zN-4f; Wed, 06 Mar 2024 14:21:34 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rhrD9-004l1t-JV; Wed, 06 Mar 2024 14:21:31 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rhrD9-00BPmz-1k;
	Wed, 06 Mar 2024 14:21:31 +0100
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
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 1/1]  net: bridge: switchdev: Improve error message clarity for switchdev_port_obj_add/del_deffered operations
Date: Wed,  6 Mar 2024 14:21:30 +0100
Message-Id: <20240306132130.2720721-1-o.rempel@pengutronix.de>
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
---
 net/switchdev/switchdev.c | 106 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 4 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index c9189a970eec3..d5a30b626fd9c 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -244,6 +244,106 @@ static int switchdev_port_obj_notify(enum switchdev_notifier_type nt,
 	return 0;
 }
 
+static void switchdev_obj_id_to_helpful_msg(struct net_device *dev,
+					    enum switchdev_obj_id obj_id,
+					    int err, bool add)
+{
+	char *action = add ? "add" : "del";
+	char *reason = "";
+	char *problem;
+	char *obj_str;
+
+	switch (obj_id) {
+	case SWITCHDEV_OBJ_ID_UNDEFINED:
+		obj_str = "Undefined object";
+		problem = "Attempted operation is undefined, indicating a "
+			  "possible programming error.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		obj_str = "VLAN entry";
+		problem = "Failure in VLAN settings on this port might disrupt "
+		          "network segmentation or traffic isolation, affecting\n"
+		          "network partitioning.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		obj_str = "Port Multicast Database entry";
+		problem = "Failure in updating the port's Multicast Database "
+			  "could lead to multicast forwarding issues.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		obj_str = "Host Multicast Database entry";
+		problem = "Failure in updating the host's Multicast Database"
+		          "may impact multicast group memberships or\n"
+			  "traffic delivery, affecting multicast communication.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_MRP:
+		obj_str = "Media Redundancy Protocol configuration for port";
+		problem = "Failure to set MRP ring ID on this port prevents"
+			  "communication with the specified redundancy ring,\n"
+			  "resulting in an inability to engage in MRP-based "
+			  "network operations.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_RING_TEST_MRP:
+		obj_str = "MRP Test Frame Operations for port";
+		problem = "Failure to generate/monitor MRP test frames may lead"
+			  "to inability to assess the ring's operational\n"
+			  "integrity and fault response, hindering proactive "
+			  "network management.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_RING_ROLE_MRP:
+		obj_str = "MRP Ring Role Configuration";
+		problem = "Improper MRP ring role configuration may create "
+		          "conflicts in the ring, disrupting communication\n"
+			  "for all participants, or isolate the local system "
+			  "from the ring, hindering its ability to communicate "
+			  "with other participants.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_RING_STATE_MRP:
+		obj_str = "MRP Ring State Configuration";
+		problem = "Failure to correctly set the MRP ring state can "
+		          "result in network loops or leave segments without\n"
+			  "communication. In a Closed state, it maintains loop "
+			  "prevention by blocking one MRM port, while an Open\n"
+			  "state activates in response to failures, changing "
+			  "port states to preserve network connectivity.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_IN_TEST_MRP:
+		obj_str = "MRP_InTest Frame Generation Configuration";
+		problem = "Failure in managing MRP_InTest frame generation can "
+			  "misjudge the interconnection ring's state, leading\n"
+			  "to incorrect blocking or unblocking of the I/C port."
+			  "This misconfiguration might result in unintended\n"
+			  "network loops or isolate critical network segments, "
+			  "compromising network integrity and reliability.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_IN_ROLE_MRP:
+		obj_str = "Interconnection Ring Role Configuration";
+		problem = "Failure in incorrect assignment of interconnection "
+			  "ring roles (MIM/MIC) can impair the formation of the\n"
+			  "interconnection rings.\n";
+		break;
+	case SWITCHDEV_OBJ_ID_IN_STATE_MRP:
+		obj_str = "Interconnection Ring State Configuration";
+		problem = "Failure in updating the interconnection ring state "
+			  "can lead in case of Open state to incorrect blocking\n"
+			  "or unblocking of the I/C port, resulting in unintended"
+			  "network loops or isolation of critical network\n";
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
@@ -254,8 +354,7 @@ static void switchdev_port_obj_add_deferred(struct net_device *dev,
 	err = switchdev_port_obj_notify(SWITCHDEV_PORT_OBJ_ADD,
 					dev, obj, NULL);
 	if (err && err != -EOPNOTSUPP)
-		netdev_err(dev, "failed (err=%d) to add object (id=%d)\n",
-			   err, obj->id);
+		switchdev_obj_id_to_helpful_msg(dev, obj->id, err, true);
 	if (obj->complete)
 		obj->complete(dev, err, obj->complete_priv);
 }
@@ -304,8 +403,7 @@ static void switchdev_port_obj_del_deferred(struct net_device *dev,
 
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


