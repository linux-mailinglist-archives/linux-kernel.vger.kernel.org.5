Return-Path: <linux-kernel+bounces-166935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085838BA240
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDDAB21656
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5501BF6F2;
	Thu,  2 May 2024 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L3pSwvEk"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B89199E90
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685199; cv=none; b=avg1x0/A7SaH3N48ByJuDp5S8dcoHp2A+xIuGmn0qnp9k/f0vqjQu5R2xTgAh1j4D0+5kYSr7NbbkJZvV0ftfNDxwbxKaYZcNd1rp/4G4dU4GSn++nNRLLEkC2hDciV7oGmSTt3mPk3rcW9xmcsr2mHO+dQFM12ec/30yz4ze3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685199; c=relaxed/simple;
	bh=dJS8q1yCszBZ+lLPCiQajxvq+UjKIhzIwbPdmSX7BF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U+APohftu6zt4qD0Li1TnYVhLrJRLljg08qlry/oxlLH5YfAYYOoEaQs7IjjLzQmGAJCEHVdFPnGHSHZuTHMx2PId5eYDR25CaeeiymMspR4l6p/x6CWbWUcO/1qOkE2rkNsPoSs7NzuFw7+lZ1ByihisbQMpnb1aN/9OQkmREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L3pSwvEk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed5109d924so7257793b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714685197; x=1715289997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/C+cLYdosM3H4Yw3Y6aWJybg0yb2tSDMEje896YPBQ=;
        b=L3pSwvEks/wXn9+4l6jb37/RVGMraaMhpG/24C5YjkLbkNJ3x7VIh020iE3uQjkFRp
         MOI0eJu9/UGFMwtjpRi1y+DfDOjux2/TDDvN1R5kA9ZApV54N4VGaOMVvZTJ2LTLvnpb
         TUazWCsqiIGQtz3kENyff8vx5eHyH3HoRWwdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685197; x=1715289997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/C+cLYdosM3H4Yw3Y6aWJybg0yb2tSDMEje896YPBQ=;
        b=V+0UYbFfg5hnKPAp7D5yxXtNr8VWwhOPQAi7pxc6nEX5r4sLAJKXHxVs/jDfQYTBLo
         OLepqkZXcIEvz/QDEx2dJrRTwphptuOactNJqm9F5u3oRn+anvRsWkt1eVnhoVlrtWB5
         b2dkoem6mx4ikrd9mfcu5HB3P1uoC2JcvVx+dScW08t3tyJwRZpxT1o9pbxgNM1hlMKD
         fmuZEhokkXJl7Cn3v42NnsLCG6DMLHax2ochdPso/3Dqv8fkYvn0j3mMR5F4iRzs2UmK
         pvz+McC23lVZw4+FinhNK596TjKHl4jhpMEv2jtFUh68U8KFfc/0+KKnGhejI6Ry/ww+
         IGHg==
X-Gm-Message-State: AOJu0YwSA2+zleZpVw3N2J+VxoYaB3G+YhE/KiW93WPEAhkQvlsNz4DI
	0DXp3TFVVOgDBJdIG1GbI3DpreOLh1BBEgqvzuTp4S1Ld0dS5rxIS+rIHbu4Rf6IUtKC2H0AIft
	m3LhT4LOPG8I/whuIGHglm/jCXqtCIsbUzwxKkxM53ozvtR3X1deM4z6QA5m800eojddJB3c8Fs
	LH138njUaOfsKFZQaV9UH86QD2MIgrnCk+8NO/iQp0jCI=
X-Google-Smtp-Source: AGHT+IGnlpaC8zumkTxRpITcudE8g/yTTc8ly55djHSXPMF/0o0TmlF6310u5p0ntLwX43jWKgQQ2Q==
X-Received: by 2002:a05:6a21:9990:b0:1af:66aa:f968 with SMTP id ve16-20020a056a21999000b001af66aaf968mr1170798pzb.20.1714685197492;
        Thu, 02 May 2024 14:26:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006f4401df6c9sm1371345pfb.113.2024.05.02.14.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:37 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: [PATCH net-next v3 2/3] net/mlx4: link NAPI instances to queues and IRQs
Date: Thu,  2 May 2024 21:26:26 +0000
Message-Id: <20240502212628.381069-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502212628.381069-1-jdamato@fastly.com>
References: <20240502212628.381069-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make mlx4 compatible with the newly added netlink queue GET APIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_cq.c   | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_cq.c b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
index 1184ac5751e1..461cc2c79c71 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_cq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_cq.c
@@ -126,6 +126,7 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 		cq_idx = cq_idx % priv->rx_ring_num;
 		rx_cq = priv->rx_cq[cq_idx];
 		cq->vector = rx_cq->vector;
+		irq = mlx4_eq_get_irq(mdev->dev, cq->vector);
 	}
 
 	if (cq->type == RX)
@@ -142,18 +143,23 @@ int mlx4_en_activate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq,
 	if (err)
 		goto free_eq;
 
+	cq->cq_idx = cq_idx;
 	cq->mcq.event = mlx4_en_cq_event;
 
 	switch (cq->type) {
 	case TX:
 		cq->mcq.comp = mlx4_en_tx_irq;
 		netif_napi_add_tx(cq->dev, &cq->napi, mlx4_en_poll_tx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_TX, &cq->napi);
 		break;
 	case RX:
 		cq->mcq.comp = mlx4_en_rx_irq;
 		netif_napi_add(cq->dev, &cq->napi, mlx4_en_poll_rx_cq);
+		netif_napi_set_irq(&cq->napi, irq);
 		napi_enable(&cq->napi);
+		netif_queue_set_napi(cq->dev, cq_idx, NETDEV_QUEUE_TYPE_RX, &cq->napi);
 		break;
 	case TX_XDP:
 		/* nothing regarding napi, it's shared with rx ring */
@@ -189,6 +195,14 @@ void mlx4_en_destroy_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq **pcq)
 void mlx4_en_deactivate_cq(struct mlx4_en_priv *priv, struct mlx4_en_cq *cq)
 {
 	if (cq->type != TX_XDP) {
+		enum netdev_queue_type qtype;
+
+		if (cq->type == RX)
+			qtype = NETDEV_QUEUE_TYPE_RX;
+		else
+			qtype = NETDEV_QUEUE_TYPE_TX;
+
+		netif_queue_set_napi(cq->dev, cq->cq_idx, qtype, NULL);
 		napi_disable(&cq->napi);
 		netif_napi_del(&cq->napi);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index efe3f97b874f..896f985549a4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -379,6 +379,7 @@ struct mlx4_en_cq {
 #define MLX4_EN_OPCODE_ERROR	0x1e
 
 	const struct cpumask *aff_mask;
+	int cq_idx;
 };
 
 struct mlx4_en_port_profile {
-- 
2.25.1


