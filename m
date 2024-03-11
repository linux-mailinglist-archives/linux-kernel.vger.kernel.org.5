Return-Path: <linux-kernel+bounces-99613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAAD878AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45D9B211F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C275822A;
	Mon, 11 Mar 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EQRJ3ksG"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649F2E40E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196241; cv=none; b=pOBpIVkkcye50kbm7un5U8jk3rMg9DChLtaAyS391kVYMUXgTTHLJ7KnJH8Ikd4PhHLoGUehSQ6egcA789+aUQv96S82dOfGPMZv83uS0D+9DDiOUZhxklj9QCDlSiRGD7rJh7inMuLbpfpUver8AT0MkOAjyzImG/dhcSNGDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196241; c=relaxed/simple;
	bh=OdMd+J50CNM+50f8uOMI7+ZekRCkUMCn9VJu8tzX+/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1l4Cjd6cb3NPOOThuGqY73jD2+5lqfg+liREEXcJWu29+lHz6r/xbNTNOJT+cywGqOryEsxCY3jGQqI7cdDzuCpoMCMkr7MYyv7pe0YJGXgy4DJiPeP/5Zj6l04PlGGGUkGDH1N4dWxYbukcgx2jgNhjVwADO71pMxVxhONX6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EQRJ3ksG; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c1ec2d05feso2335619b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1710196239; x=1710801039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUgfNiSuiTtBVNEOakTU6DEDXoHV6YA4dJcvkvf2wRA=;
        b=EQRJ3ksGEJfiPWiyb1C5o4HUUIJKuzKy6HMRmEOyrSHTD0EyPpdDPccXtGjGKp1+km
         a7vVvzvOwwuK9pUccmOW+/3HmzcwVix/w7tALNxjPwOYhTLnhgTng5RyorPrDwFU5coy
         WsQo8sYfNl9uKUbNq/n4W4jAUZEy7zKxd5Tgzkb3gxyTvL9hS03IefzTCCILUyGTvl9b
         Gj23R1UoKMylhSTz047MyM1y5Ad4WlQo78pvc2l9o1iXxpfyBKabvLfcFTxfUx4PewGW
         HG9xTkoUiZuY0VaTCRxMQcPlmu6594a8VOOrSqQchN8xGp4TAYqp5DVAl5qnBthUdXYr
         BCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196239; x=1710801039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUgfNiSuiTtBVNEOakTU6DEDXoHV6YA4dJcvkvf2wRA=;
        b=q7XJhutK0JrY86jYaT4J7zI0iEu98Oz/wcOV+4y6GdMVd2s3+Z/+/B+z59910TYz6P
         rxsIqhtlsKsrM0fCd3QuOXmZiXs9EIjVrv7qaPq/S4KUCrtfPs0HpMuabNiWhPNnG8kS
         wbh2uYpcuu/tQJ362FxqrO4HajbstRkEweEZW52gqmCYUbYkxs5XNklnNtIuCYyH9VcN
         NsYA0VJglC15URBkniUymAJ0G9aPpkByzj+1Dg0iPltrJcvKcdeMcsmRnxGErhgXQaMF
         ppI44TMi1TyGeAdbR0VvawgycquSxji9NwQkcTrD2ecvoGa57PtpA7oftEI4hMQTPTca
         dVEA==
X-Forwarded-Encrypted: i=1; AJvYcCWhpsHNIL8cEdLlewUYEfoPuwhDP9FPOvybdrMKG1d5JBSQRocIbIcsVfn8oXzybiQcwJ2uAH4Emq/slyuLxdOoCsa0OBvC/Xk4MjVa
X-Gm-Message-State: AOJu0YwYqOWFSE16ntwJMlo2eVDUzPdW7OBakrgbK+OB4nFhzHkgA6xF
	gOYjovH6+M1NjxmMsdt6CBbnR/LkiL3UumY1LpVG81p1b17QPijX/yjsJx9Rb5Q=
X-Google-Smtp-Source: AGHT+IHzsBVmxmvEd9yydjX8lSJ0aEa8zA7lYZdmXFKIknpvvZOV4bw6iQkCUwQW11vi3oEDLGEQsg==
X-Received: by 2002:a05:6808:1403:b0:3c2:3a65:eaf9 with SMTP id w3-20020a056808140300b003c23a65eaf9mr2279381oiv.9.1710196238894;
        Mon, 11 Mar 2024 15:30:38 -0700 (PDT)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id gu17-20020a056a004e5100b006e572d86152sm4964638pfb.91.2024.03.11.15.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 15:30:38 -0700 (PDT)
From: Michael Liang <mliang@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Liang <mliang@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>
Subject: [PATCH] net/mlx5: offset comp irq index in name by one
Date: Mon, 11 Mar 2024 16:30:18 -0600
Message-Id: <20240311223018.580975-1-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mlx5 comp irq name scheme is changed a little bit between
commit 3663ad34bc70 ("net/mlx5: Shift control IRQ to the last index")
and commit 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation").
The index in the comp irq name used to start from 0 but now it starts
from 1. There is nothing critical here, but it's harmless to change
back to the old behavior, a.k.a starting from 0.

Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 4dcf995cb1a2..6bac8ad70ba6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -19,6 +19,7 @@
 #define MLX5_IRQ_CTRL_SF_MAX 8
 /* min num of vectors for SFs to be enabled */
 #define MLX5_IRQ_VEC_COMP_BASE_SF 2
+#define MLX5_IRQ_VEC_COMP_BASE 1
 
 #define MLX5_EQ_SHARE_IRQ_MAX_COMP (8)
 #define MLX5_EQ_SHARE_IRQ_MAX_CTRL (UINT_MAX)
@@ -246,6 +247,7 @@ static void irq_set_name(struct mlx5_irq_pool *pool, char *name, int vecidx)
 		return;
 	}
 
+	vecidx -= MLX5_IRQ_VEC_COMP_BASE;
 	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d", vecidx);
 }
 
@@ -585,7 +587,7 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
 	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = table->pcif_pool;
 	struct irq_affinity_desc af_desc;
-	int offset = 1;
+	int offset = MLX5_IRQ_VEC_COMP_BASE;
 
 	if (!pool->xa_num_irqs.max)
 		offset = 0;
-- 
2.34.1


