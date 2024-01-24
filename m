Return-Path: <linux-kernel+bounces-37668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45783B35B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642E1B22ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C91353E8;
	Wed, 24 Jan 2024 20:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNyrPPJu"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916E1350FB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129681; cv=none; b=Jpxlrh95rYrJbg7E8QOeA8Vw1v12bR7TqxIq830cQGXwezp+IdQqqzuVPErgbxCwHcuiuVodpPH7Luq40GiBMONAIaD4Loc4HGhLDpW/f8AzIzCnPqkrk7HmKQI4DyPnktjj1owEOyHcxcLvtVaW+JmelsO7zp4TQW/02j+hWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129681; c=relaxed/simple;
	bh=RTpEuATypVNj5VxAsZR6nKAIefqlONH2LbSyH6vYsXY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HIrLxUlDG4Ps1rFnDQbUA+kKN3Okl4s0lPDpn6WY5nyJ/e5IIrKQe/u01dNbCUIq0jHObXp5A9LdGLw9u676ZCSPQ02JqU7g0RvvXcQuZ52H0pQp4A7/dNu9A7EXsWudlXQ6Hfr4hdFoCL0Pw4E+RU6NorhpUXS8Z99/ntWpDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nktgrg.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNyrPPJu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nktgrg.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f325796097so107240747b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706129678; x=1706734478; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6kZSksoUVPJmWPdPL8UZDhGGNZPJOUVtvLj/gV7DXkY=;
        b=CNyrPPJucDcDwRxk2GWTMQ0CMuOObd3AUQ1J0+ABV1KmlUKKrq8tGhoLWmb4U5QIb1
         E2fPZoAtF1HfL+ikIEX+wC/YYDoA6qo3UqcsgdFFujXgf+s3TGev/q/riYCecPJsT4uj
         G547k8tgfFPJESLMg7tQH+4aBz+FbjdpqgNN72G68j752zfZMeXoLhamjKSQ0XRD4xiO
         le5P6keeTy5U6x+7SqK3ICKKVYJ55L0YkSxNRmPHDIg9PxNCV9CGTtErEI2SqbatVxyZ
         8N7Iodxoyqr9iFuuceGl9NtDWVdH9bWgltDONemrn1zwK2XXPBb3qEQ0bO6ix9zJ5ZPt
         1bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129678; x=1706734478;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kZSksoUVPJmWPdPL8UZDhGGNZPJOUVtvLj/gV7DXkY=;
        b=Lm7i/j/Qz/hTtznb4Njg8lafZ2iXBakK3GWfWmQ2OGPAmf8TgczD1VF/NcSWVMcl25
         LzDCeyAWbQTjSSVkSyV4SM1HtvKcG7SepplbkmtS4qogGRG25azczqKjfde5DFHNmcPi
         RaTsyV8BTWSmvR+9snKWtwTxezbt6wpIqhUA2ZaKmreHd/T8YvBxBwFdsNxDzWqTMaBE
         4BVfDcc8aS16Wb8OnR6xCo+2gDeB2fJwk0w8OUKTvJZppiQsEVGM5GykAJnzAM6LRVzX
         X6UssluKsul3AkryX9prSd8TIOyI14fjg+TZojk5lEzYToFXNMk/JIIcwJKzQHdf9f/7
         RMUg==
X-Gm-Message-State: AOJu0YyeLeh6su3xVcNcGkxmGmnUFeJzc0xEDQntCtI5c9ENrjkGfAyI
	toY1jonuR3JcJAPjs5HD6Zwv53q9pUhIbaZ4s5Cbx0FFlg7XsrHPkFDmHtDhSAOY1xa605Fs0Ue
	bGA==
X-Google-Smtp-Source: AGHT+IHjtj2/HTMBCL3Ia0Rwooqj0s/CdjjRlZBjwtZgoOz4UNpXofFQRXJC4Jxcw5LPdFo31JVOIhmSA54=
X-Received: from nktgrg-net.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1d21])
 (user=nktgrg job=sendgmr) by 2002:a81:b809:0:b0:5fb:7b86:db34 with SMTP id
 v9-20020a81b809000000b005fb7b86db34mr651732ywe.4.1706129678673; Wed, 24 Jan
 2024 12:54:38 -0800 (PST)
Date: Wed, 24 Jan 2024 20:54:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124205435.1021490-1-nktgrg@google.com>
Subject: [PATCH net-next] gve: Modify rx_buf_alloc_fail counter centrally and
 closer to failure
From: nktgrg <nktgrg@google.com>
To: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com, 
	shailend@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org
Cc: stable@kernel.org, Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

Previously, each caller of gve_rx_alloc_buffer had to increase counter
 and as a result one caller was not tracking those failure. Increasing
 counters at a common location now so callers don't have to duplicate
 code or miss counter management.

Signed-off-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 3cb3a9a..eb67ea9 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -93,7 +93,8 @@ static void gve_setup_rx_buffer(struct gve_rx_slot_page_info *page_info,
 
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 			       struct gve_rx_slot_page_info *page_info,
-			       union gve_rx_data_slot *data_slot)
+			       union gve_rx_data_slot *data_slot,
+			       struct gve_rx_ring *rx)
 {
 	struct page *page;
 	dma_addr_t dma;
@@ -101,8 +102,12 @@ static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
 
 	err = gve_alloc_page(priv, dev, &page, &dma, DMA_FROM_DEVICE,
 			     GFP_ATOMIC);
-	if (err)
+	if (err) {
+		u64_stats_update_begin(&rx->statss);
+		rx->rx_buf_alloc_fail++;
+		u64_stats_update_end(&rx->statss);
 		return err;
+	}
 
 	gve_setup_rx_buffer(page_info, dma, page, &data_slot->addr);
 	return 0;
@@ -143,8 +148,9 @@ static int gve_prefill_rx_pages(struct gve_rx_ring *rx)
 					    &rx->data.data_ring[i].qpl_offset);
 			continue;
 		}
-		err = gve_rx_alloc_buffer(priv, &priv->pdev->dev, &rx->data.page_info[i],
-					  &rx->data.data_ring[i]);
+		err = gve_rx_alloc_buffer(priv, &priv->pdev->dev,
+					  &rx->data.page_info[i],
+					  &rx->data.data_ring[i], rx);
 		if (err)
 			goto alloc_err_rda;
 	}
@@ -895,10 +901,7 @@ static bool gve_rx_refill_buffers(struct gve_priv *priv, struct gve_rx_ring *rx)
 				gve_rx_free_buffer(dev, page_info, data_slot);
 				page_info->page = NULL;
 				if (gve_rx_alloc_buffer(priv, dev, page_info,
-							data_slot)) {
-					u64_stats_update_begin(&rx->statss);
-					rx->rx_buf_alloc_fail++;
-					u64_stats_update_end(&rx->statss);
+							data_slot, rx)) {
 					break;
 				}
 			}
-- 
2.43.0.429.g432eaa2c6b-goog


