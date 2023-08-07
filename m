Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2FF7723C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjHGMW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjHGMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:22:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446A5E6F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:22:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so27079765ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691410967; x=1692015767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C7bHaMSd+SY+pPB7Vtx4/6UZIJ72tWmfxoauVOSVx0=;
        b=l4xJiWEEbz2IEuorkINwxBVQ/5PnK9fhGmaLj2DODmbsWX93ppJtAyvJqtF6Ztvco0
         qKs5yAkD9hAZSetvftFm3zxR/knZZ++YSY80dIXgMn379PWrH9U+ANOEFtJ5x6RdTS6y
         XYQRI5TmfzgqmA/jmahEN6XMtndm/UPo/TG3A38K7ZeoLVOpfRYn0RtvpgZ6YhmhUr1J
         CI+kA1hDqOrfZX6Sz9COvQCAz3m1QiMtcNQs5WrsThDatldjRHsjJs4H/HTeQfp2eoCk
         DWewbiMqktZxszv2kbOsjYlz7Zxvm2rJ0/8QkdTvMZdbCRocQG6aL3AflCYjgw6/LhuT
         Q8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410967; x=1692015767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C7bHaMSd+SY+pPB7Vtx4/6UZIJ72tWmfxoauVOSVx0=;
        b=iP3fu+JA+lr2vbn1kFd6Ed23VN9SI7B5Nbo8RKgKAqeuyV+gKngX2B3AJxp92iDLx9
         6Hcy4LhQkHVE8ir7s294d2Jo2sVjs5QJgeXuVzwynHxdfqTkPnmDjOLIdX0lUUnlwKaY
         HG60K9QuhKuSEeX6NMHVoMDVkZoHTvebIlkcu5UYWLdCiYxG31fnMMOj3dDZGJ+prtMg
         jS4YzZv+KuRvPSDfieh4dM+Vz7urILR7oeRVq7tTY6sitj40/kaOIwswp/2jWngsYSCs
         pxQZNty0/siCglmaO11hAQ3saU0dz4M9pxdKVmOSGXY0U9tDFBlVfLjktdbXy24WGgN0
         uWZw==
X-Gm-Message-State: AOJu0Yy2FLDevLDkzHx1ANuhnNBDDoPn4Zz9hxEeZrTYzsoRlsaJybYa
        +RssVeh24jkPOPN4CWaicmVR2g==
X-Google-Smtp-Source: AGHT+IE89np5AUQBiPFRPVGYnS82GPk320IaciVQZYSLKkUoZ+GQA8NGhOsYaOaNrp4N9CL1ZFsYag==
X-Received: by 2002:a17:902:82c5:b0:1b8:6cae:4400 with SMTP id u5-20020a17090282c500b001b86cae4400mr7028201plz.37.1691410966789;
        Mon, 07 Aug 2023 05:22:46 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id jk21-20020a170903331500b001bbfa86ca3bsm6819846plb.78.2023.08.07.05.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:22:46 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC v2 Optimizing veth xsk performance 3/9] veth: add support for send queue
Date:   Mon,  7 Aug 2023 20:22:38 +0800
Message-Id: <20230807122238.85463-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in order to support native af_xdp for veth. we
need support for send queue for napi tx.
the upcoming patch will make use of it.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 77e12d52ca2b..25faba879505 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -56,6 +56,11 @@ struct veth_rq_stats {
 	struct u64_stats_sync	syncp;
 };
 
+struct veth_sq_stats {
+	struct veth_stats	vs;
+	struct u64_stats_sync	syncp;
+};
+
 struct veth_rq {
 	struct napi_struct	xdp_napi;
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
@@ -69,11 +74,25 @@ struct veth_rq {
 	struct page_pool	*page_pool;
 };
 
+struct veth_sq {
+	struct napi_struct	xdp_napi;
+	struct net_device	*dev;
+	struct xdp_mem_info	xdp_mem;
+	struct veth_sq_stats	stats;
+	u32 queue_index;
+	/* for xsk */
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+		u32 last_cpu;
+	} xsk;
+};
+
 struct veth_priv {
 	struct net_device __rcu	*peer;
 	atomic64_t		dropped;
 	struct bpf_prog		*_xdp_prog;
 	struct veth_rq		*rq;
+	struct veth_sq		*sq;
 	unsigned int		requested_headroom;
 };
 
@@ -1495,6 +1514,15 @@ static int veth_alloc_queues(struct net_device *dev)
 		u64_stats_init(&priv->rq[i].stats.syncp);
 	}
 
+	priv->sq = kcalloc(dev->num_tx_queues, sizeof(*priv->sq), GFP_KERNEL);
+	if (!priv->sq)
+		return -ENOMEM;
+
+	for (i = 0; i < dev->num_tx_queues; i++) {
+		priv->sq[i].dev = dev;
+		u64_stats_init(&priv->sq[i].stats.syncp);
+	}
+
 	return 0;
 }
 
@@ -1503,6 +1531,7 @@ static void veth_free_queues(struct net_device *dev)
 	struct veth_priv *priv = netdev_priv(dev);
 
 	kfree(priv->rq);
+	kfree(priv->sq);
 }
 
 static int veth_dev_init(struct net_device *dev)
-- 
2.20.1

