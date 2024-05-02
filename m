Return-Path: <linux-kernel+bounces-166934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F80B8BA23D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB091F2196C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2DA19DF72;
	Thu,  2 May 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DAANplb8"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656F181312
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685198; cv=none; b=b77BHQn4S2pHzwaaypa0t9WUbJ98CH1Bv8afMVVLHY+h/xO8e/IlIK1RrC8h8n/UOjxH0ZCQahKxHfxmwbNW1IRgaFfp3X6matyxBKfCaOhdDNPclQAAIRXmHOp6tE2nO0WFVBtrm9mE0M3mjxwqzUqoZJ3Tdw0tiz4hfAF24BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685198; c=relaxed/simple;
	bh=FXv+vJcBCmEgOu5jScWUmm7QGv45QW6i+T+dLFjv6OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NY2Bw3VWhrC49Y6GuS0CAiFaNrMSCK/F0Q6pW7rH6HcEjPNnDqsN4GiDtC//eDFTJjWhnfqjuftNo1XSmL49CIvPrghhUYWp57QTkDBMkcsUjB7AhGQFYJmjEs4QuHreoEhhuwRAt9B11CCEJLmgJ51G1tuOQvOtUR6V+VTlNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DAANplb8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f42e9221bbso1688946b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714685196; x=1715289996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jgR8JD3oQd88EH8HKGjA3Az+hSDzBJU5y5/SDxJYdM=;
        b=DAANplb8T8epsb7QiagB9494a98DfQ2G1zai+CmFE/BJ8x/eMqVrLKjRHIqjQX2O+v
         NrUQk4UPZkwKJUDoSfhOZx4KzHdh8Vt0kePRQiBoISWV7SmCvfHdL2WfuAzB68TCWciq
         xKDILOO6d1/zqZQ0fBpHQ9AXWw3e/xew+qfMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685196; x=1715289996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jgR8JD3oQd88EH8HKGjA3Az+hSDzBJU5y5/SDxJYdM=;
        b=FJ8YZ2cdxDdWYgqnbsXrKLX6IQU9cLd2RvJNOJeI3uc/P16YLFrGMdLyWLNSLApc3k
         IxSiuXygMecUJEJQsVn0PqITMj6+HBuz1hKzqpAeSzqDaEbMIwtPbXMFBEwg2zu6cycD
         9j8CJ6OP0+krNf18R8yHHEVfjxgaWjv//i9WzhfpOxMFck+M21++Q/6mwtxIsNXu0PdH
         1e97LSNXwliQwPGXJsQsXFU7NBOkaO3gpYMIwpQqJjSOQk9fmUqP/hMSinzOJf4vAsny
         eD8WD65aqRr7kcvYBRYe5RETPqRVK2SlBOrzns1t/QbQRcNyGeRMyDknNdZGWybxOs3P
         q93g==
X-Gm-Message-State: AOJu0YzlTDOaLlqCs/1Jhru2Iq9JlFdvxdZg+ftOvNkxx6uyM/zU1aD/
	45tFi4NFw8XaaR2eP37/e99VEEYhKMH526J6nC/tftVFqdJX87Y2KxL12EjaqVy13kwO2+VdUbd
	TCHkMterLuOsYEBzadbPK/dqf7Q0iwDC0Y7MPCRmlozIbaR/R7Onc48B1phBduDcvdKNLOFdJNP
	X9TVvCX3H1FiDUAwuZ6j5Wgde9HGIxKxcRhFhUlLK5ED0=
X-Google-Smtp-Source: AGHT+IHJviS1wozqDADgp5NssiZSlqz3RTUpOU3MNs7wdW2gVo+a7TIkffxM2G6uXIzsaRMwMWuSKg==
X-Received: by 2002:a05:6a00:1305:b0:6ed:416d:e9a with SMTP id j5-20020a056a00130500b006ed416d0e9amr1014030pfu.7.1714685195864;
        Thu, 02 May 2024 14:26:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006f4401df6c9sm1371345pfb.113.2024.05.02.14.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:35 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/3] net/mlx4: Track RX allocation failures in a stat
Date: Thu,  2 May 2024 21:26:25 +0000
Message-Id: <20240502212628.381069-2-jdamato@fastly.com>
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

mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
fails but does not increment a stat field when this occurs.

struct mlx4_en_rx_ring has a dropped field which is tabulated in
mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.

This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
dropped field for the -ENOMEM case.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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


