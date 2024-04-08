Return-Path: <linux-kernel+bounces-135162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD3289BBE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD992827B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348928370;
	Mon,  8 Apr 2024 09:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A0or/Sjb"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB4947F65
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712569095; cv=none; b=X/YhXrfd2GlOp1NuGDN6biMnk2VbAmy4EpJHxZCKmYnHUGTEW8Qv7dlpAKE3BN+ACjeGIHd4GmXfVY3gwbL9CxIHDqso9CTiG3Bh4CnwXm7b0dzDzYfGisQZT7roRg98U1+m4P1IyiNmf4xftJivB7BV8lyZnw7njbaJFIsALzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712569095; c=relaxed/simple;
	bh=3Oe0Hs1hEKEvDoktbHfU95I86ttlMXOY6/+XRDoZZiw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jSQ+v7oysIlVKeyQzO0OAvAOIsS34PHlsMYRaAJ5Fg5YQimMzZWJT8CJ/T0rU1/kopZ81hif0gesiveB0Hl5v4Xkvi/P4K+zlw2nHS8YxkHeFgEpJTKXUaOTOrmGW1xDWCEHee8av0fc+nJbeJ746IABy9RzClrn9WKaAuJPHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A0or/Sjb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51ddc783e3so54047066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712569090; x=1713173890; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m1PLjRGl2MYyX+2zKdFV7iSC02Qe1cYgW7veKZ91RLg=;
        b=A0or/SjbkWd5It09Mh3ICGVuA706XleP4u/vJJj+8mMxop5wgsAxAGLpkqL4NnE96A
         ld22swAqOi+hV5X3Gh/HRY0Xrs1Gsqi0NAXMoNk5d3Xy80Z07M+FvnLKRSIhm5Um3Sej
         R2r9hNvjrWSYklqmcDbC3uyyvF1xeux133RiLFjrgAGbrlLHhnqACSDoqBfq3IzjTFvk
         DeRgp516s/NKJnFJ3H+Bw93pcUBTxHxwc6sEs+lo5uyJj9uLJRgVEKLYzuw2XDfc2bI9
         N1RbMvE8cVhPHVTr3a3auPTTrIsSNgalSfW9q+fOwxgTvvaOwiIktaArupXbp6xlfYWN
         dj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712569090; x=1713173890;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1PLjRGl2MYyX+2zKdFV7iSC02Qe1cYgW7veKZ91RLg=;
        b=VRuq5kJJQkNZh70pQl6ceoLxhRdObtONWe3mB+OxW7NIk6unhcdlo70Ayk2xBcn/RU
         HtfwxbldJFVdXEU+8CRmn0+jBn1EJflNYL7uiY9duIVCFSJ1yFZU2uiU8Z7co+MCACWy
         FwEpgiL4QqOcDNnEz7ge5BuNzIsJ6gGonw8aRzHVmOIx61RByJRawMbXuDuxTf5L/Mft
         A5yLJ3HhoqBbMD8Pk1zJQXYhW7qb6rheZhpsI+Lu19OxJjWTqvWCy29TR42jU27AiosF
         fqxBg4yxZr8j4WcISvK3cAuDTn0VTGSWXJkff7JJP+K9p1mZNNLQX5rsS4kBz3QI9utP
         7nhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxsy3Chi4JiT/zS2kIFurIbUvFMyoAh09t60snkFIyR/4wolGEhn2TKz5khLqzTaSTYywG+KiGdp3OMR7xnotoAtnSmYMcWsr1w4Ph
X-Gm-Message-State: AOJu0Yz/y13RjtkJOy6ifQWmItN8oo3vDCJXUSM0MSKjxRKf3pHwQHwG
	3pYguyHaS1W0N904d/frZVoD66UB0/Tfp8MaF24sbOznrB3KHMgEgLa0MyRby/g=
X-Google-Smtp-Source: AGHT+IGnQd1kztAY4avgfZG8BTwixabZYgbRBBawEhqGsrjNGUFhp8SXWgLnOMI0cl/Wn5n5NhooZQ==
X-Received: by 2002:a17:907:e8d:b0:a51:db9a:47ca with SMTP id ho13-20020a1709070e8d00b00a51db9a47camr1001978ejc.28.1712569090032;
        Mon, 08 Apr 2024 02:38:10 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id ne6-20020a1709077b8600b00a4e5a6b57a2sm4175803ejc.163.2024.04.08.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:38:09 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH net-next v8 0/3] Add minimal XDP support to TI AM65 CPSW
 Ethernet driver
Date: Mon, 08 Apr 2024 11:38:01 +0200
Message-Id: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPm6E2YC/43QzW7CMAwH8FdBOZMt30132ntMCDmOOzJBqBrUg
 RDvvtDbpmrK0bH9y1++s0JTosLeNnc20ZxKOuda+O2G4QHyJ/EUa82UUEYopTmcnOU4lm9+jSM
 PUBJyE4NX3gofjGd1s74SDxNkPDx3v0bIqbzW+f0JUj6mTPtZPAfHiYZ0Xb7/YJkuPNP1wna1c
 0jlcp5uS65ZLv1/I8ySS94PIjgMEbQU7wFuxxQmesHzaSFn1cAoLriQ6BAAIQS3wugGRlfGxt4
 Y6KM3sJbGNDCmMtprJ8FpMD78ZrabhnVFxpKNhML4lRS2IYWtTEDZ6V52IuDaTVwD455ppCIaB
 huiHVaYroHpKoPa2w69ihD/3GT3eDx+AOgc/bfVAgAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712569087; l=2999;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=3Oe0Hs1hEKEvDoktbHfU95I86ttlMXOY6/+XRDoZZiw=;
 b=9c3VEL8gylBs0NJqjRRKrAl3fE1uu9hbotAKaeGSKKPIEaUPo1qk3Gid5iSdZL6f7XQUH7zZo
 uOuDDcsXCGWD9kKXcSpvD14RsAuXAkWbP+uz1lxCdtZzcv2trFjRSVk
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch adds XDP support to TI AM65 CPSW Ethernet driver.

The following features are implemented: NETDEV_XDP_ACT_BASIC,
NETDEV_XDP_ACT_REDIRECT, and NETDEV_XDP_ACT_NDO_XMIT.

Zero-copy and non-linear XDP buffer supports are NOT implemented.

Besides, the page pool memory model is used to get better performance.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Changes in v8:
- Fix some warnings reported by patchwork.
- Link to v7: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v7-0-c3857c82dadb@baylibre.com

Changes in v7:
- Move xdp_do_flush() function call in am65_cpsw_nuss_rx_poll().
- Link to v6: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com

Changes in v6:
- In k3_cppi_*() functions, use const qualifier when the content of
pool is not modified.
- Add allow_direct bool parameter to am65_cpsw_alloc_skb() function
for direct use by page_pool_put_full_page().
- Link to v5: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v5-0-bc1739170bc6@baylibre.com

Changes in v5:
- In k3_cppi_desc_pool_destroy(), free memory allocated for desc_infos.
- Link to v4: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v4-0-2e45e5dec048@baylibre.com

Changes in v4:
- Add skb_mark_for_recycle() in am65_cpsw_nuss_rx_packets() function.
- Specify napi page pool parameter in am65_cpsw_create_xdp_rxqs() function.
- Add benchmark numbers (with VS without page pool) in the commit description.
- Add xdp_do_flush() in am65_cpsw_run_xdp() function for XDP_REDIRECT case.
- Link to v3: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v3-0-5d944a9d84a0@baylibre.com

Changes in v3:
- Fix a potential issue with TX buffer type, which is now set for each buffer.
- Link to v2: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v2-0-01c6caacabb6@baylibre.com

Changes in v2:
- Use page pool memory model instead of MEM_TYPE_PAGE_ORDER0.
- In am65_cpsw_alloc_skb(), release reference on the page pool page
in case of error returned by build_skb().
- [nit] Cleanup am65_cpsw_nuss_common_open/stop() functions.
- [nit] Arrange local variables in reverse xmas tree order.
- Link to v1: https://lore.kernel.org/r/20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com

---
Julien Panis (3):
      net: ethernet: ti: Add accessors for struct k3_cppi_desc_pool members
      net: ethernet: ti: Add desc_infos member to struct k3_cppi_desc_pool
      net: ethernet: ti: am65-cpsw: Add minimal XDP support

 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 569 +++++++++++++++++++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  13 +
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c |  41 ++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |   6 +
 4 files changed, 578 insertions(+), 51 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240223-am65-cpsw-xdp-basic-4db828508b48

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


