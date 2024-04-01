Return-Path: <linux-kernel+bounces-127197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0A8947E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B721F2349C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3F58213;
	Mon,  1 Apr 2024 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXNe6TZB"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D555733B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015138; cv=none; b=NTEq4U+fFEVAmm2MD859XM+wxzkaSICzKO44RXwzHmPz0LPgXq7oMutAgFdqycgi4yyvVOYWw+CAeqFJYukcy2+sYk1WBByESGuqozN2Uw8lgg0Xp8IGLLFzQKg3mD5WEn6yIGJ2C4AT+/qol86hxCE76sVH3IsLtQH2xeL/DLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015138; c=relaxed/simple;
	bh=+CsztK9q5tM43GGL10gYK8Kqi1f7Pf8hDsI9/3BBNzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qs1wvb+L4UY50Aho/XZ92sX7sQAy7th5/iOWJgMaTsV29pip0VRJs+4iK3vWfdI5pmUVLq5MXObHxnU3h5SvzkTCfn+sb4wT1iOfVc73IQF3jIrqip2rx5y9ler1VWtbVlvDls0HYH/EG+0HNbGWn5cBBVEChMSiDsBzZMOjnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXNe6TZB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6e71495a60dso5125629b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015136; x=1712619936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=omBG1Fp9W5XLPZF2l7sQk0iqYfHEUN+VAknuUn+rqZE=;
        b=YXNe6TZBl/kEvTwXRhlNSxxHrRPhLlfx9lkIgnhnXx0OVn7CnAEzcPUxChab9x3bLW
         kYFyi7aURr89dDUCiO1oslUcW4d/fFbFliVw8ORikUnWnPv+oB0mTM6aPAcrjUHmaZET
         knBRf7kC1c3d4URoJ71sjgwPR8KWMaUJr3sfJt5pZ3RR5IYyzCqKjiP6d5yCYrnY1EHE
         BBH7k3KVlu9dCAk4TYonQvTVh7MKFR4PsiENefVEXsp89Cuz3iTTwEBOycrCNdAbruQt
         UmRm3cGEmuFokK3k8Vm8htbh4YfD5C9pfQ5ojUAKIWAbrFm6xGZkMWEX6r3DosKtArK1
         +b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015136; x=1712619936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omBG1Fp9W5XLPZF2l7sQk0iqYfHEUN+VAknuUn+rqZE=;
        b=lIobq26/h/5wIyZA8oopRKF1M80NJnOAr6jQL1C4/WMnBeineXLZR8FAG9DY39S4ZT
         RdyE9/8XYWoH76eif6dk3NXjouQzmWqwhegwOJlAygQdTO6pudITl2rR0Oaqlxp6sgi5
         XEd6x0UWHaBo1zmT7z64GnaNq10PhZ7tPwkgT/NpENt4tiOjSE5Rv7TOK+i+zH1SzJ+l
         6CEcTsySzcuJu0tz/K7C+vF7v6NrsGU1erhnf2jth+KVhWw0MN1zhqgATvlhsYX66ihU
         L09m1CQE5GF2lLL3d1uI5zO6QQqVd7P6ggUFSu8/PknJDnZaj7lwGfHlm5+zhiF3sPdU
         nvhA==
X-Forwarded-Encrypted: i=1; AJvYcCVtbO3x+uOGS4cI+aMckz4gfbebm+R+MXl+P9wmh+tDHns/QaAKTxu2q4m/WCDT04Id3/zTnF3c/3a8L41M95E0tLIMT7EraTAtaTr7
X-Gm-Message-State: AOJu0Yy5ld+wpPe5oD6PsP/XNE0uZ1Z3VIqwWA3u+8ciEPpAGhQ65YwG
	Q/e4xxpMMILjldcrWWta/zIFHiyc+pNujP4npY8psykSeVrW0FS/xPUepHOXtSDtIIbBmXhXkte
	7Tk2cv4eG6icfLZDg68Qw6A==
X-Google-Smtp-Source: AGHT+IFPnyCpOKHXsNJyFmoIYw9mHF0nhAKa+sK2SXtLT4dW9Z+Ni+6ZQLW0B19CFvr6ZBUZQvE7c1icfY8p5Xe4pA==
X-Received: from hramamurthy-gve.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:141e])
 (user=hramamurthy job=sendgmr) by 2002:a05:6a00:1784:b0:6ea:baf6:57a3 with
 SMTP id s4-20020a056a00178400b006eabaf657a3mr215627pfg.6.1712015136495; Mon,
 01 Apr 2024 16:45:36 -0700 (PDT)
Date: Mon,  1 Apr 2024 23:45:26 +0000
In-Reply-To: <20240401234530.3101900-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234530.3101900-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234530.3101900-2-hramamurthy@google.com>
Subject: [PATCH net-next 1/5] gve: simplify setting decriptor count defaults
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, rushilg@google.com, jfraker@google.com, 
	linux-kernel@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"

Combine the gve_set_desc_cnt and gve_set_desc_cnt_dqo into
one function which sets the counts after checking the queue
format. Both the functions in the previous code and the new
combined function never return an error so make the new
function void and remove the goto on error.

Also rename the new function to gve_set_default_desc_cnt to
be clearer about its intention.

Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_adminq.c | 44 +++++++-------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index ae12ac38e18b..50affa11a59c 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -745,31 +745,19 @@ int gve_adminq_destroy_rx_queues(struct gve_priv *priv, u32 num_queues)
 	return gve_adminq_kick_and_wait(priv);
 }
 
-static int gve_set_desc_cnt(struct gve_priv *priv,
-			    struct gve_device_descriptor *descriptor)
+static void gve_set_default_desc_cnt(struct gve_priv *priv,
+			const struct gve_device_descriptor *descriptor,
+			const struct gve_device_option_dqo_rda *dev_op_dqo_rda)
 {
 	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
 	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-	return 0;
-}
-
-static int
-gve_set_desc_cnt_dqo(struct gve_priv *priv,
-		     const struct gve_device_descriptor *descriptor,
-		     const struct gve_device_option_dqo_rda *dev_op_dqo_rda)
-{
-	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
-	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
-
-	if (priv->queue_format == GVE_DQO_QPL_FORMAT)
-		return 0;
-
-	priv->options_dqo_rda.tx_comp_ring_entries =
-		be16_to_cpu(dev_op_dqo_rda->tx_comp_ring_entries);
-	priv->options_dqo_rda.rx_buff_ring_entries =
-		be16_to_cpu(dev_op_dqo_rda->rx_buff_ring_entries);
 
-	return 0;
+	if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
+		priv->options_dqo_rda.tx_comp_ring_entries =
+			be16_to_cpu(dev_op_dqo_rda->tx_comp_ring_entries);
+		priv->options_dqo_rda.rx_buff_ring_entries =
+			be16_to_cpu(dev_op_dqo_rda->rx_buff_ring_entries);
+	}
 }
 
 static void gve_enable_supported_features(struct gve_priv *priv,
@@ -888,15 +876,13 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 		dev_info(&priv->pdev->dev,
 			 "Driver is running with GQI QPL queue format.\n");
 	}
-	if (gve_is_gqi(priv)) {
-		err = gve_set_desc_cnt(priv, descriptor);
-	} else {
-		/* DQO supports LRO. */
+
+	/* set default descriptor counts */
+	gve_set_default_desc_cnt(priv, descriptor, dev_op_dqo_rda);
+
+	/* DQO supports LRO. */
+	if (!gve_is_gqi(priv))
 		priv->dev->hw_features |= NETIF_F_LRO;
-		err = gve_set_desc_cnt_dqo(priv, descriptor, dev_op_dqo_rda);
-	}
-	if (err)
-		goto free_device_descriptor;
 
 	priv->max_registered_pages =
 				be64_to_cpu(descriptor->max_registered_pages);
-- 
2.44.0.478.gd926399ef9-goog


