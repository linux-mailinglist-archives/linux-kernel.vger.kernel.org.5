Return-Path: <linux-kernel+bounces-159310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE68B2CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17EC1F2189E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50322181CF0;
	Thu, 25 Apr 2024 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K288Yhof"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83A181CEF;
	Thu, 25 Apr 2024 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714082853; cv=none; b=j+684D0IoAWlzljx3Jpjm8z86D5L9ETthto40gD6obxfi8od2yJVUQKMgQ4ec38545Ewt+PPS/amJ6Lvsb0Qf8uI5UUuoKDXSH2SQS54RwGSf41raeP40YucpPVNeVnAtbi2JK5FUSX2RRdMbSoChVVQU/W6zot4UyzY3IfmeSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714082853; c=relaxed/simple;
	bh=gK3IDBMN0QPgUq6nFSZArygjbcNekpXpG97aut6lPG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfk55rMqZLGYYtVcRyBRo0hU5Ko83agjYFFWuMCYeT7e0muSyWb1zlKtcs52Bv1bX2++PzzPTjvKhkbFZWGu0+6qzkhAvyNrpBT+Fn5rvIOMbdTzRgPmfSCEN7rO4Cjv/Y9ttiAYAKGpAkk0bvCCHtTZ/b8aKrATSVE9LBIMZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K288Yhof; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f05afc8d6so101251985a.3;
        Thu, 25 Apr 2024 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714082851; x=1714687651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoVri07CqNZY64mEc3hs+qcgGhmd3HVXaDxx+6B0MGI=;
        b=K288YhofXM2+t6+np8Ryq9pKM8dldaRuc1qeBE/F54d/8wpKTdUphXgLU6eWlH+yjm
         l4EOR3bNQo7LQSR3RyK0hNTb9ZFtnsjP7k4f4w2MoyU797NOiAb38qeF/NED7Ukj+ubZ
         keyHf3jOGCrK408XEZfWlVhDnKpjzhOFu3Fp7UHIr2u+zGGZwjq6GSUcalNOJGfrkGBt
         gq7Vl1n+S4Qyfe7U3uhXiZG677sOkxsYrvjXxCD6NsCdg/a3UAl7Uq5EQcrFv3tFqDgH
         vm2iD3Au+BbB+fhymT0iMhovobx5B0d48PK0is88Uq5LQdtFY94+YHrD9U6df1dI1yof
         ri8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082851; x=1714687651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoVri07CqNZY64mEc3hs+qcgGhmd3HVXaDxx+6B0MGI=;
        b=hQSc5XiRe7f++Ywlq3O8n7PAqo/1IrBnkj3AmzYLyGLu7qwUCwvvj3VNbdPRG94Sxz
         xmJRJYwttTr6HUV/tw3zHirQ7HO1p70e5YshXmU/J/7zrTfkbOduqvG/Hc1o87ZVgAlY
         0D6Mxf+y1WkOmp02YLk5cgkHfM7EBOBqPw6v7RdE64aIcRbNqY9Ouz4Qx47W+Jwm5iOE
         othmShDlxjk37v7S+/FYjMJMc8FN7UxtwiTcbFraWQsI3EcmD+pUyj5BpKZm5id8hLiA
         zNNQdieiegXn+qzOARDj5KcXcQLZqRfxV+W+MjJTGA00k2/Ww6fm7+2vET2C0HWTAmD5
         fPRA==
X-Forwarded-Encrypted: i=1; AJvYcCWsqxCWvt7ECT34LlNr6uQ3qt3VosNOrXb2zKhkK5+xpCegmPDg4J4TnC/oW5cYvuk8kq3bEFEKwGYOtLGtETqCC9Y3oeDUt4zu60GEOpnUunPpcfTMWF7wwGkiiJ4CYxQ4X9nA
X-Gm-Message-State: AOJu0Yx+2CnYcmr8TATEQ+S8dk3m+mAUNXC1/J6KvfFfaR5zp/yKOdBQ
	UQv0/8mCjhxjPwjLbj7D/2J1exBH1OQasznLNKEtLOog5AUfqAoq
X-Google-Smtp-Source: AGHT+IEyjjnqgyez6sKBJ9k4l510KomxGmY/S4BuiPkm7YOmBOxW9iHlQN5he0WuFI8I0hLZzmetBw==
X-Received: by 2002:ad4:5c6f:0:b0:6a0:932d:ce66 with SMTP id i15-20020ad45c6f000000b006a0932dce66mr1420070qvh.15.1714082851102;
        Thu, 25 Apr 2024 15:07:31 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q2-20020a0c9a42000000b006a044503615sm4692891qvd.72.2024.04.25.15.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:07:30 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
Date: Thu, 25 Apr 2024 15:06:49 -0700
Message-Id: <20240425220650.2138801-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425220650.2138801-1-opendmb@gmail.com>
References: <20240425220650.2138801-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ndo_set_rx_mode function is synchronized with the
netif_addr_lock spinlock and BHs disabled. Since this
function is also invoked directly from the driver the
same synchronization should be applied.

Fixes: 72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b1f84b37032a..5452b7dc6e6a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) controller driver
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet: " fmt
@@ -3334,7 +3334,9 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
-- 
2.34.1


