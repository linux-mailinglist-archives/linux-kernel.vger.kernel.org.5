Return-Path: <linux-kernel+bounces-75055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C218A85E23C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65571C24127
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E319280BED;
	Wed, 21 Feb 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lSb3bVQd"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E83823C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531120; cv=none; b=kyslax3Ep1XA393++xgy4zwojQ0uVA896HmSVcVruEwvFMTxQTy5b5FphuG/RmOrUI2fMV+tdl5nYrTypZws396BZraFG3g0Qu/8AiMJTtLB8+pk2yFFggtvw74sQgLWXhxaq9AiCOvdMe5xEObmGOKdZebvNFrq9vkb18XtIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531120; c=relaxed/simple;
	bh=b3I8DtEPynqthfDKMzjPijqG7ifvwN2QGor5pJwwtFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lbg0JV39mh3uA4jy+ieckrrlSVBNDZcxfJnoYP5g7AhHwoNTzuqCq6Z6pUAH4F82WRen4gUdwFFZTQmgi223RV+gCmGvsDSg91SYxlkxZ3csO/Ks5ZNDO91wl6XTbR3UcnPQqiGQnmX7e5EERHX9bTJ5qxcPRLqisdJrTWGuf+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lSb3bVQd; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e484011e28so1187087b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708531118; x=1709135918; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4XNkLiaptlpOdgR8Lz2aXc5/cIA8mvoaalETxdH3pHc=;
        b=lSb3bVQdFNV5mWZVm6FPosSkw0o53PNt+pIe6I2s4h/XNnJNWxE5OSsKxRgAi6LeeB
         dwmRNn2puLPQny3HkXD/VKXfzEh25EckQSEpIh0v56K/l+0ZEK7cfZsY16/G1Qt1Y1Ef
         gTDoy3ntxlMm1/p/qNuYUsXRMXAuumFlczIiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531118; x=1709135918;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XNkLiaptlpOdgR8Lz2aXc5/cIA8mvoaalETxdH3pHc=;
        b=WdKOy3zCP1dm5iLFflxrHSgl/EAhUmqmKkd6EzgOGshcJ3eIhINfgJoqKYDQlj6x6E
         /RWjV9rHJat2KxExgxe1lwNyL/EX08V3CNQa/GTN3IWftKIMHSwiTL5FRxjd7eDi8qUy
         Tx5MeJ5J3QQtvc4WGhTrNDRd8tKwsIHvmwIOntPnOxe27Iu0sQQwUWKgTfGWY/Ev8w+S
         i1EGNKjQOcSofBW0DupNMGVuYMcNhCbV2XXJHtk5X7zxOCVshm4d/49ORVeRh+5rLOcW
         gMYcMRBZK/wH4/HxOga3TC/r1zZzK0XK/CmWZcao/eqJ6txNopJRErp+Rw8v4zfXVa4z
         w5rg==
X-Forwarded-Encrypted: i=1; AJvYcCXGa+956i+CkAtesuEK4jSaoyIXVPp90AJHVrXjJa5PCL2VGcYWIg5uWmQCsPZFsOQuebZfiqZd/dJ/h4p6Y9jYCR/cEPgOMnfNo59j
X-Gm-Message-State: AOJu0YwayrsXX2ksUebsPiZWBPWcPssrsGi8K/uenHoEoBA7rXbm44q/
	9jF++drfhtRME6l0Q3dMPa8V1BazgccLAd8aDMg/GuQm/8eCb4LE6jJ92pwyYLo=
X-Google-Smtp-Source: AGHT+IF+vDfxJ3DnJY6wSQD6PeQS1l8LjdA4qL1jcqD6EP3+78/zLpI/XgbO73FX3fYDmYBzDED78A==
X-Received: by 2002:a05:6a00:2f81:b0:6e4:688e:2072 with SMTP id fm1-20020a056a002f8100b006e4688e2072mr6922023pfb.34.1708531118043;
        Wed, 21 Feb 2024 07:58:38 -0800 (PST)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e46672df97sm5751327pfb.75.2024.02.21.07.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:58:37 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI APIs
Date: Wed, 21 Feb 2024 07:57:29 -0800
Message-Id: <1708531057-67392-2-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Expose the netdevice name when queue and NAPI netdev-genl APIs are used

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/uapi/linux/netdev.h |  2 ++
 net/core/netdev-genl.c      | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 93cb411..80762bc 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -117,6 +117,7 @@ enum {
 	NETDEV_A_NAPI_ID,
 	NETDEV_A_NAPI_IRQ,
 	NETDEV_A_NAPI_PID,
+	NETDEV_A_NAPI_IFNAME,
 
 	__NETDEV_A_NAPI_MAX,
 	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
@@ -127,6 +128,7 @@ enum {
 	NETDEV_A_QUEUE_IFINDEX,
 	NETDEV_A_QUEUE_TYPE,
 	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_IFNAME,
 
 	__NETDEV_A_QUEUE_MAX,
 	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd98936..a886e6a 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -181,6 +181,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
 		goto nla_put_failure;
 
+	if (nla_put_string(rsp, NETDEV_A_NAPI_IFNAME, napi->dev->name))
+		goto nla_put_failure;
+
 	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
 		goto nla_put_failure;
 
@@ -307,7 +310,8 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 
 	if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
 	    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
-	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
+	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex) ||
+	    nla_put_string(rsp, NETDEV_A_QUEUE_IFNAME, netdev->name))
 		goto nla_put_failure;
 
 	switch (q_type) {
@@ -369,16 +373,19 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 	u32 q_id, q_type, ifindex;
 	struct net_device *netdev;
 	struct sk_buff *rsp;
+	char *ifname;
 	int err;
 
 	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
 	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
-	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))
 		return -EINVAL;
 
 	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
 	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
 	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
+	nla_strscpy(ifname, info->attrs[NETDEV_A_QUEUE_IFNAME], IFNAMSIZ);
 
 	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!rsp)
@@ -387,10 +394,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 
 	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
-	if (netdev)
-		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
-	else
+
+	if (strcmp(netdev->name, ifname)) {
 		err = -ENODEV;
+	} else {
+		if (netdev)
+			err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
+		else
+			err = -ENODEV;
+	}
 
 	rtnl_unlock();
 
-- 
2.7.4


