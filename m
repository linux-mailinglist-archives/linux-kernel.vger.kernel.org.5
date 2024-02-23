Return-Path: <linux-kernel+bounces-79170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E704861E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303DE1C2533D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD015149394;
	Fri, 23 Feb 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PygFljCI"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9114F96B;
	Fri, 23 Feb 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722167; cv=none; b=aQiFxH8EYVmfyYUrvsk3+YMzV89mUfIFjT8+YVFqsHBERd3OWqTyIIRdfTYfT456mZb0fQixBBHgMt2wOnBiy9zT83Ybrk7OiX117KxXb4wzyswu0kQIsmWUl+1bCTdGCIav6vwKD/Pd7H+2YWB0OT442eoCWLQTBbvoDlzd1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722167; c=relaxed/simple;
	bh=cg5+yosR/5Tn9ofG8K0XW7tcyBhYZ/r6xGlE4FO9pW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=idVkAplsDEDSkx3xP9XECGJ+C1dSppHIvo1+4ci6MUnV9vNu0iZ0OwYpTuS0hyfC8/RSl1ETSm3J7CPtoGMzkWjtayYbGroxXwUCIcYY1ZbkdaNjyMzvLu1fKyF7jL+DZNcv8mDCtcfsrcBwTEhr3t73fMa4/+mGWeXGMB0IvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PygFljCI; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so128093566b.0;
        Fri, 23 Feb 2024 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708722163; x=1709326963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/esy7XtdM/Uq4jCB2UtvNoZm2r9dK5BL2ynsWoKYNM=;
        b=PygFljCIAIdWBWqEIo5BN83pbMUdhlZ/MrtC9VPicDsoUscmN1qeDI60KUllufCY52
         XxVk20c4YETwwOFXbT69FjOeWSsU2BVHxmwnIU8Oi4j4nL1yl2LV7PZpXM85+P4ZPGTh
         La0kRxlHtLdxym82lGYC9FOz24yWRmk9uhk69W1YikubkyywUjY1ztAqaAMdYFAVJPwg
         IM0QOtG1KxsgDXA/sFPwjD94/ru5MH3SDwQgZZrmStHmsVtX0TA3Yb3PNS1SehKZos1l
         WzzgviUTg2BPg2xZxHJWrLvfAKiK1DeUmzSXiaiojOVPtclrVTLt/ACJQ477YZYcn3ez
         wpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722163; x=1709326963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/esy7XtdM/Uq4jCB2UtvNoZm2r9dK5BL2ynsWoKYNM=;
        b=u2n6M7AfoWad8fD8h1iFgK5yR57TbfEiAMLjDOM6a94FLm5VfP/uGJ6FFA1lasRH39
         UbQ0jwrAEt5t4DuCuEcuZa4zSkpmOBH6ggRIkwbKSpY3nTzzuBYqYkg7ErdjRX6NAapu
         oeDCJP20lzHAbUozAG8mNYxBSqWzqp+inSB5D7kPq5x+v9c7oNgvQuUg2myid1xCxry4
         ApXpMnbiFZB1HeGo+Fm02f/k7/XhG7EAlkhJqU8J1tpBuF6GFyS5w5crs5Kb95WJVeTw
         hv8iI2fei10M1t5ZYfWPHLYoIuVd7w4YR0uF5i+f8tnppbOGfHlvQ6iOLvLAAJH9kPB4
         i7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq5QJM8CtJ1kj9C9hlGusLX7K0jhxHW7Sb6/WhBWR1ahZgTiRNoZH8KRTAo4qfzqIhvOHkDeDJJBhWgXxFxcCBzCxQFRIY7GrJCaPr
X-Gm-Message-State: AOJu0YwX7B9gKObAzHJDuvlXLrP6A3GgARX6zWAGRwYxpEJVsNhJRWcf
	rY14HV+mpx001lWiAeZNX4WjngxqE3WNpEorthwKrK3vhmKAAWZJXImLCPL45EI=
X-Google-Smtp-Source: AGHT+IFBtOxqmrdsOvpFjK/lg5qcySCITo83aNfkf6FHl35CkKdpH88lxioDimb1quBf9cil/U7iaA==
X-Received: by 2002:a17:906:338b:b0:a41:36d2:f342 with SMTP id v11-20020a170906338b00b00a4136d2f342mr789187eja.31.1708722163059;
        Fri, 23 Feb 2024 13:02:43 -0800 (PST)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3e559aaff9sm6185424ejc.29.2024.02.23.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 13:02:42 -0800 (PST)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 11/16] net: dsa: tag_sja1105: refactor skb->dev assignment to dsa_tag_8021q_find_user()
Date: Fri, 23 Feb 2024 22:00:41 +0100
Message-Id: <20240223210049.3197486-12-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223210049.3197486-1-paweldembicki@gmail.com>
References: <20240223210049.3197486-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

A new tagging protocol implementation based on tag_8021q is on the
horizon, and it appears that it also has to open-code the complicated
logic of finding a source port based on a VLAN header.

Create a single dsa_tag_8021q_find_user() and make sja1105 call it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v5:
  - resend only
v4:
  - introduce patch and change from master to conduit and slave to user

 net/dsa/tag_8021q.c   | 19 ++++++++++++++++---
 net/dsa/tag_8021q.h   |  5 +++--
 net/dsa/tag_sja1105.c | 17 +++++------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
index 332b0ae02645..454d36c84671 100644
--- a/net/dsa/tag_8021q.c
+++ b/net/dsa/tag_8021q.c
@@ -468,8 +468,8 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 }
 EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
-						   int vbid)
+static struct net_device *
+dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit, int vbid)
 {
 	struct dsa_port *cpu_dp = conduit->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
@@ -495,7 +495,20 @@ struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_port_by_vbid);
+
+struct net_device *dsa_tag_8021q_find_user(struct net_device *conduit,
+					   int source_port, int switch_id,
+					   int vid, int vbid)
+{
+	/* Always prefer precise source port information, if available */
+	if (source_port != -1 && switch_id != -1)
+		return dsa_conduit_find_user(conduit, switch_id, source_port);
+	else if (vbid >= 1)
+		return dsa_tag_8021q_find_port_by_vbid(conduit, vbid);
+
+	return dsa_find_designated_bridge_port_by_vid(conduit, vid);
+}
+EXPORT_SYMBOL_GPL(dsa_tag_8021q_find_user);
 
 /**
  * dsa_8021q_rcv - Decode source information from tag_8021q header
diff --git a/net/dsa/tag_8021q.h b/net/dsa/tag_8021q.h
index 0c6671d7c1c2..27b8906f99ec 100644
--- a/net/dsa/tag_8021q.h
+++ b/net/dsa/tag_8021q.h
@@ -16,8 +16,9 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
 void dsa_8021q_rcv(struct sk_buff *skb, int *source_port, int *switch_id,
 		   int *vbid, int *vid);
 
-struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
-						   int vbid);
+struct net_device *dsa_tag_8021q_find_user(struct net_device *conduit,
+					   int source_port, int switch_id,
+					   int vid, int vbid);
 
 int dsa_switch_tag_8021q_vlan_add(struct dsa_switch *ds,
 				  struct dsa_notifier_tag_8021q_vlan_info *info);
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index 35a6346549f2..3e902af7eea6 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -509,12 +509,8 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		 */
 		return NULL;
 
-	if (source_port != -1 && switch_id != -1)
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-	else if (vbid >= 1)
-		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	skb->dev = dsa_tag_8021q_find_user(netdev, source_port, switch_id,
+					   vid, vbid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
@@ -652,12 +648,9 @@ static struct sk_buff *sja1110_rcv(struct sk_buff *skb,
 	if (likely(sja1105_skb_has_tag_8021q(skb)))
 		dsa_8021q_rcv(skb, &source_port, &switch_id, &vbid, &vid);
 
-	if (source_port != -1 && switch_id != -1)
-		skb->dev = dsa_conduit_find_user(netdev, switch_id, source_port);
-	else if (vbid >= 1)
-		skb->dev = dsa_tag_8021q_find_port_by_vbid(netdev, vbid);
-	else
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
+	skb->dev = dsa_tag_8021q_find_user(netdev, source_port, switch_id,
+					   vid, vbid);
+
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
-- 
2.34.1


