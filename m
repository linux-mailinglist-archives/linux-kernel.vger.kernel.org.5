Return-Path: <linux-kernel+bounces-160574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98E8B3F60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1831C23AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3CA208CA;
	Fri, 26 Apr 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SiRoxZi6"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C0125AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156451; cv=none; b=tmcQTOw9Y9x3yBnyqmyatDLo/13UIr+fmnklk4P66pXmdJLrWpgT2Wc7apxxoMs2q0P8Qlql5gYzv3xPjqaK3JXrpeE+duC+13ZhvODWom+pn+16FzegLEMWbqRnvIKWdyf1mUrebLUMPPaCd25rOz73I0gFF3IXOXcf1GBmwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156451; c=relaxed/simple;
	bh=vHW1DL0lxBdtpusUhIuDr8YiecZhEDqf3QUX1YWqzBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CySsZb/DXVVbvL5c/cpxSq1JXTsSPEpLbDKwsGkaEQbs/gxqEX0gwFtDUqpc3jQhdDeoCEfvoWbnGQJZUfs1QcSYiO1gYtIcMCh3gwPTJUhXyWiDm8LUmAWQ1Zm6EKXY410lBPBYJeURLfUr8E7CHNnaDoFkjvIb3D4g4cBbZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SiRoxZi6; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso17102655ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714156448; x=1714761248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqaAQgdA856jvIs7dAW5ZIMPYVryl65URaMxVc//Sq0=;
        b=SiRoxZi6yDcS7xehwrjfxyCY3jGc6AAAdpeCGyiTmJmoT7ywIEGPo7WZ+YiSXnO1Nf
         SOHhjebIOgI4KiAdoB6ZlxyTP6SQKI4aBarpXaiOy7G986qTar+Hi0TpPtdFzLTZZyJ+
         sGj5NWmI1QoHbMyyVsh2/RrSDh5dU0IsQn7Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156448; x=1714761248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqaAQgdA856jvIs7dAW5ZIMPYVryl65URaMxVc//Sq0=;
        b=ZFtx5Qo9qC/YBlXr+UFUIfQgFeB6u9cpQMDl7/NbFRWWds8U17wjZ7R9jrEL6DLrUO
         8beObqC/EkHH9QEcxBJWzpmjV8Ld/r9aHAZCP2K6i5p604UrpbnJ1v1ZeTny1sATFmHP
         UI9/OvMjWaTu19TyPI1BlSkbveAVZjbw7DxHMxKE0b4cAshTm722WQhsAA51IsexNy3v
         s4T8gmtjf7LCaTSWZUXgMkAc5/wjNm1ccvNXJLbXla94KTtQ8NCNpdY1KvJ/o2xLXt1+
         i8+86kiOqFwPJEDJ5bUtf6BiT5ENam1+66olwpO/6r0rA5hEkktDAcP4+0qCbYbalt7D
         w95A==
X-Gm-Message-State: AOJu0YzjTEDcT7wCXt3Y0wd2aUgE2vdbnkf4skuvud20h2ogEvBZHnYC
	czCSvVV8TRsy3dT9gna77j0DKQEXguqva1uV02zHMsOrCeZaEIqzOg6MlpLmKx5A0vpqqwqbY/b
	iayYtqT30PpZgrpVRR3s/oOK1cI+7m+UamIUa5Kr6ePpBdlwwIXTobexrQWt74v10pNvg7Pf18f
	UDMeVEttBavDpuum9JDEEDr3jQPUOH8XehH6uopNGFoD4=
X-Google-Smtp-Source: AGHT+IGmOBABSwmeCyrHpqNf6ZoNtezrLaurXRxgwMJaiE7lf1v3+4wY7GFcM3RlNtf1RT1PE1g6qw==
X-Received: by 2002:a17:903:1205:b0:1e4:ccf6:209f with SMTP id l5-20020a170903120500b001e4ccf6209fmr4140136plh.28.1714156447894;
        Fri, 26 Apr 2024 11:34:07 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id j23-20020a170902759700b001deecb4f897sm15713152pll.100.2024.04.26.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:34:07 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Fri, 26 Apr 2024 18:33:53 +0000
Message-Id: <20240426183355.500364-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426183355.500364-1-jdamato@fastly.com>
References: <20240426183355.500364-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

struct mlx4_en_rx_ring has a dropped field which is tabulated in
mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.

This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
dropped field for the -ENOMEM case.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_port.c | 5 ++++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c   | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_port.c b/drivers/net/ethernet/mellanox/mlx4/en_port.c
index 532997eba698..47541f7666f2 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_port.c
@@ -151,7 +151,7 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
-	unsigned long packets, bytes;
+	unsigned long packets, bytes, dropped;
 	int i;
 
 	if (!priv->port_up || mlx4_is_master(mdev->dev))
@@ -159,14 +159,17 @@ void mlx4_en_fold_software_stats(struct net_device *dev)
 
 	packets = 0;
 	bytes = 0;
+	dropped = 0;
 	for (i = 0; i < priv->rx_ring_num; i++) {
 		const struct mlx4_en_rx_ring *ring = priv->rx_ring[i];
 
 		packets += READ_ONCE(ring->packets);
 		bytes   += READ_ONCE(ring->bytes);
+		dropped += READ_ONCE(ring->dropped);
 	}
 	dev->stats.rx_packets = packets;
 	dev->stats.rx_bytes = bytes;
+	dev->stats.rx_missed_errors = dropped;
 
 	packets = 0;
 	bytes = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index 8328df8645d5..573ae10300c7 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
 
 	for (i = 0; i < priv->num_frags; i++, frags++) {
 		if (!frags->page) {
-			if (mlx4_alloc_page(priv, frags, gfp))
+			if (mlx4_alloc_page(priv, frags, gfp)) {
+				ring->dropped++;
 				return -ENOMEM;
+			}
 			ring->rx_alloc_pages++;
 		}
 		rx_desc->data[i].addr = cpu_to_be64(frags->dma +
-- 
2.25.1


