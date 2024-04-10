Return-Path: <linux-kernel+bounces-137895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7FC89E914
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9EC1F219A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192420326;
	Wed, 10 Apr 2024 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Z9ymBpcj"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E931118A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723989; cv=none; b=olut6m4qW8B9bM7H5gbn5n2vS7eqbZYHueWpEO9ZzrVzd5dBPaN1bjipv3Jqhf7C7+HeMFz6oEHP2os2iNHqGSvWaQpX/NWK5PSenMMlgClrDPvpNFFt/8JAKOEE/EtUG8SHvFvitHBmfe3SW4oROqfBWS5NU+88NNQ7LZ1nJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723989; c=relaxed/simple;
	bh=qADNludrHn0nc/n3sXykDX8DmQnp4rVQ8oPh8FnxDb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FGCD2f74vpuS4JM03bUYRxsJlndjXpMlL3MzWUyYTUzLK52mkimmBuX/eaIr3FUclQoqdAACziOqd+SWFfNz4q3GbTTcLZhJIiLyM8f1Upt8nrEcMpCIdfRbsEvd+Igirx37oSBnrKxh87opWFGqxuEkz8mEr9dPdTNhw3eQ5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Z9ymBpcj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4543755a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1712723986; x=1713328786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0AdTuh0LPKFRBexJVBgnFt0ViqxZ8bYbsSVukVY5u0=;
        b=Z9ymBpcjJb5ixTl2KWhRChOFhFvIeAjf1FNJb/fllmPbhalanmUUdBkC1eIcecJtkb
         jU27Dj7ZoSIOnPy37p/TH8V6+Iwhiwz3qg/OxdYDvEnW+6HaIP0w07TXQ1sEr7jgw3Tu
         GH+Nm7qUtduX6rIeaJK1Dcxt6b5G6H9apHTC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723986; x=1713328786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0AdTuh0LPKFRBexJVBgnFt0ViqxZ8bYbsSVukVY5u0=;
        b=iD4Tlkvk2ObNzWgKiCVGU88G9e0+HSgRCL8FULx0KhkIKPJ1jiSWZ0J1HN0IQI0+Qc
         MlV98ncUeIeBZ7c4KNDq3BDdRAPsDPJwV1NYOrxzAdiBwaVweoIjY++fdhxjZsAx6zLX
         2SjVxU9vc0UeoKwMYMOeszimBVP9VdMoBHmsiB6lUdSF3kWjgWkB6iIJe5t2AMwHTny+
         1gE0MPrzqOtlDtK2C/n3liXcd7FDf9IodPR0FL5caGKZvpmkgyl5BdwNEni8kh3uPvda
         keS/GZBDslPRL200dCG39IOjGWDjkjNQzkkViCcyi3b48tRkd8Eq1f4olP+XwaRVpX8B
         myRQ==
X-Gm-Message-State: AOJu0YwfoYaPKNeAeVQ78SPgsqWVdkuUuZpU15+5+qQ4bJAs9T5rTeIJ
	KslMMl5Jq+28JHfAvDMOsqSt9hVOG+aNYZERFARIE/RnKTIatEeHJPKHr2mRoV1qcPS05q5qh9S
	FYx6XfUh0zzJll4/NeILoyfYjiRzv8QX0QAGg1CzEFOkpqyvDzH95M/o5qvtEVnO++SCgbOrl5o
	StcIv312Sq6XMd46PJvJ3QGgZ+clgV04fiVHMuEMs2HYM=
X-Google-Smtp-Source: AGHT+IHCyg7IsSIZZPCE6CWyUBvBJNPmvz99+2Xq8imlDAOCx7E9BrLRdX6eCg6d+6LVmmu7blclnw==
X-Received: by 2002:a17:90a:f690:b0:2a5:74ab:7f52 with SMTP id cl16-20020a17090af69000b002a574ab7f52mr1570409pjb.16.1712723985964;
        Tue, 09 Apr 2024 21:39:45 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id gn4-20020a17090ac78400b002a5d71d48e8sm260773pjb.39.2024.04.09.21.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 21:39:45 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: sridhar.samudrala@intel.com,
	amritha.nambiar@intel.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [intel-next 2/2] net/i40e: add support for per queue netlink stats
Date: Wed, 10 Apr 2024 04:39:35 +0000
Message-Id: <20240410043936.206169-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410043936.206169-1-jdamato@fastly.com>
References: <20240410043936.206169-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make i40e compatible with the newly added netlink per queue stats.

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"scope": "queue"}'

[{'ifindex': 3,
  'queue-id': 0,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 45540208,
  'rx-packets': 57112},
 {'ifindex': 3,
  'queue-id': 1,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 8717844,
  'rx-packets': 31256},
..

Comparing to ethtool to verify:

$ ethtool -S eth3 | egrep 'rx-[01]\.'
     rx-0.packets: 57112
     rx-0.bytes: 45540208
     rx-1.packets: 31256
     rx-1.bytes: 8717844

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 102 ++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6384a0c73a05..40574f54a380 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6,6 +6,7 @@
 #include <linux/if_bridge.h>
 #include <linux/if_macvlan.h>
 #include <linux/module.h>
+#include <net/netdev_queues.h>
 #include <net/pkt_cls.h>
 #include <net/xdp_sock_drv.h>
 
@@ -515,6 +516,100 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
 	stats->rx_length_errors	= vsi_stats->rx_length_errors;
 }
 
+static void i40e_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_ring *ring;
+	unsigned int start;
+
+	stats->bytes = 0xff;
+	stats->packets = 0xff;
+	stats->alloc_fail = 0xff;
+
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return;
+
+	if (!vsi->rx_rings)
+		return;
+
+	rcu_read_lock();
+	ring = READ_ONCE(vsi->rx_rings[i]);
+	if (ring) {
+		do {
+			start = u64_stats_fetch_begin(&ring->syncp);
+			stats->packets = ring->stats.packets;
+			stats->bytes = ring->stats.bytes;
+			stats->alloc_fail = ring->rx_stats.alloc_page_failed;
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
+	}
+	rcu_read_unlock();
+}
+
+static void i40e_get_queue_stats_tx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_ring *ring;
+	unsigned int start;
+
+	stats->bytes = 0xff;
+	stats->packets = 0xff;
+
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return;
+
+	if (!vsi->tx_rings)
+		return;
+
+	rcu_read_lock();
+	ring = READ_ONCE(vsi->tx_rings[i]);
+	if (ring) {
+		do {
+			start = u64_stats_fetch_begin(&ring->syncp);
+			stats->packets = ring->stats.packets;
+			stats->bytes = ring->stats.bytes;
+		} while (u64_stats_fetch_retry(&ring->syncp, start));
+	}
+	rcu_read_unlock();
+}
+
+static void i40e_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct i40e_netdev_priv *np = netdev_priv(dev);
+	struct rtnl_link_stats64 stats = {0};
+	struct i40e_vsi *vsi = np->vsi;
+
+	rx->bytes = 0xff;
+	rx->packets = 0xff;
+	rx->alloc_fail = 0xff;
+
+	tx->bytes = 0xff;
+	tx->packets = 0xff;
+
+	if (test_bit(__I40E_VSI_DOWN, vsi->state))
+		return;
+
+	if (!vsi->tx_rings)
+		return;
+
+	if (!vsi->num_queue_pairs)
+		return;
+
+	i40e_get_netdev_stats_struct(dev, &stats);
+
+	rx->bytes = stats.rx_bytes;
+	rx->packets = stats.rx_packets;
+	rx->alloc_fail = vsi->rx_buf_failed;
+
+	tx->bytes = stats.tx_bytes;
+	tx->packets = stats.tx_packets;
+}
+
 /**
  * i40e_vsi_reset_stats - Resets all stats of the given vsi
  * @vsi: the VSI to have its stats reset
@@ -13693,6 +13788,12 @@ static const struct net_device_ops i40e_netdev_ops = {
 	.ndo_dfwd_del_station	= i40e_fwd_del,
 };
 
+static const struct netdev_stat_ops i40e_stat_ops = {
+	.get_queue_stats_rx     = i40e_get_queue_stats_rx,
+	.get_queue_stats_tx     = i40e_get_queue_stats_tx,
+	.get_base_stats         = i40e_get_base_stats,
+};
+
 /**
  * i40e_config_netdev - Setup the netdev flags
  * @vsi: the VSI being configured
@@ -13854,6 +13955,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 	/* Setup netdev TC information */
 	i40e_vsi_config_netdev_tc(vsi, vsi->tc_config.enabled_tc);
 
+	netdev->stat_ops = &i40e_stat_ops;
 	netdev->netdev_ops = &i40e_netdev_ops;
 	netdev->watchdog_timeo = 5 * HZ;
 	i40e_set_ethtool_ops(netdev);
-- 
2.25.1


