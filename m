Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663757FEA12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjK3H7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjK3H7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:59:34 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5711BE4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:59:05 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc9b626a96so6548425ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701331145; x=1701935945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KlByuks1Jx+Wl9b3Tee/pDpTmzdOczE9maWDQUbD5Y8=;
        b=CWpSaIQtdtNrtBT0ysc+EU4CFV1Wb/GSqwbrS8Yo2TfyRvdfd63jJ+nXiFVYmS6+kI
         aUI+qo+yhqCaD30bbOInqca+bN182y4gjVgRJwDZcizntGor1SkEhINpRIdUX8APmi8F
         0GyzPHT6+fZ09bGMnql19xEdanHUohFPoWXLPPMbAgvedImzBQEv9r+OMng9TK1pOuCA
         XuV+YLqbjG/6+TX0rGgN6nsS2+kVOGRxaE5Sq7AyY0BGEsc5LhxfY0Bhv08wAcL5NUqx
         ppAc70pM+topRDsQGeeO5IhQ51UsLetN/T4i7TdIbMHU4zLpdbxD0dpoez9e4QkUfMJc
         3b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331145; x=1701935945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlByuks1Jx+Wl9b3Tee/pDpTmzdOczE9maWDQUbD5Y8=;
        b=jd83CwSYJZHo0HmXyAwWrLpKdcK9m/rxlJn4Ct+eoquXFg2wYA7GMzxXPFIUtXSkT0
         OHFeJmMVvhzT1ypoQd7KcLhWSfzIUUZwzhsSpHBXYHg6M4JsG8dcCFkVXzKchK1hqxhJ
         CWbB7cwPquluAoLy5DpZzO/qbVVyq5xz9OVe1JkWt+5odwNFC7ze5jQNZzHKl/WLB69S
         NKQcRTLh7svJB7f6Ol26F7SpNZm1AuK255wOSlEW023NuDOMIP5ttX8J2SfpmAkRlLGD
         I1gltEhF/LxJm3U8yqS3T/3cXisQPxZWPtEfd9OreWYyg4qPF1catpq3lRlwgTP2bVYv
         QJIA==
X-Gm-Message-State: AOJu0Yz1NV/2Vn6vUxIYDObCRF3G9e8SON2UUE3i/BqF70kjqVx8dJFh
        B3a4jK1F1K5rtYKTkzbqIt1/xg==
X-Google-Smtp-Source: AGHT+IFExjE3BDEku4ZHInfO3rmuTiYxdr2UmNotXjtt51WP3MH/kZc7YhCAB/c3UDm5ZFP16/KJKQ==
X-Received: by 2002:a17:903:2311:b0:1cf:8e0e:43d5 with SMTP id d17-20020a170903231100b001cf8e0e43d5mr24705887plh.6.1701331144990;
        Wed, 29 Nov 2023 23:59:04 -0800 (PST)
Received: from C02F52LSML85.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001cffb969683sm671756plg.174.2023.11.29.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:59:04 -0800 (PST)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     daniel@iogearbox.net, razor@blackwall.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
        wangdongdong.6@bytedance.com, tangchen.1@bytedance.com,
        zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next] netkit: Add some ethtool ops to provide information to user
Date:   Thu, 30 Nov 2023 15:58:44 +0800
Message-Id: <20231130075844.52932-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add get_strings, get_sset_count, get_ethtool_stats to get peer
ifindex.
ethtool -S nk1
NIC statistics:
     peer_ifindex: 36

Add get_link, get_link_ksettings to get link stat.
ethtool nk1
Settings for nk1:
	...
	Link detected: yes

Add get_ts_info.
ethtool -T nk1
Time stamping parameters for nk1:
...

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 drivers/net/netkit.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 97bd6705c241..1a5199568a07 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -34,6 +34,12 @@ struct netkit_link {
 	u32 location;
 };
 
+static struct {
+	const char string[ETH_GSTRING_LEN];
+} ethtool_stats_keys[] = {
+	{ "peer_ifindex" },
+};
+
 static __always_inline int
 netkit_run(const struct bpf_mprog_entry *entry, struct sk_buff *skb,
 	   enum netkit_action ret)
@@ -211,8 +217,55 @@ static void netkit_get_drvinfo(struct net_device *dev,
 	strscpy(info->driver, DRV_NAME, sizeof(info->driver));
 }
 
+static void netkit_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	u8 *p = buf;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		memcpy(p, &ethtool_stats_keys, sizeof(ethtool_stats_keys));
+		p += sizeof(ethtool_stats_keys);
+		break;
+	}
+}
+
+static int netkit_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ARRAY_SIZE(ethtool_stats_keys);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void netkit_get_ethtool_stats(struct net_device *dev,
+				     struct ethtool_stats *stats, u64 *data)
+{
+	struct netkit *nk = netkit_priv(dev);
+	struct net_device *peer = rtnl_dereference(nk->peer);
+
+	data[0] = peer ? peer->ifindex : 0;
+}
+
+static int netkit_get_link_ksettings(struct net_device *dev,
+				     struct ethtool_link_ksettings *cmd)
+{
+	cmd->base.speed		= SPEED_10000;
+	cmd->base.duplex	= DUPLEX_FULL;
+	cmd->base.port		= PORT_TP;
+	cmd->base.autoneg	= AUTONEG_DISABLE;
+	return 0;
+}
+
 static const struct ethtool_ops netkit_ethtool_ops = {
 	.get_drvinfo		= netkit_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_strings		= netkit_get_strings,
+	.get_sset_count		= netkit_get_sset_count,
+	.get_ethtool_stats	= netkit_get_ethtool_stats,
+	.get_link_ksettings	= netkit_get_link_ksettings,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
 static void netkit_setup(struct net_device *dev)
-- 
2.30.2

