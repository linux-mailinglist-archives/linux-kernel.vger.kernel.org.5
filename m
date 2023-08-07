Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B57723DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjHGMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjHGMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:25:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A736185
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:25:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55ba895d457so2555635a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411131; x=1692015931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=b6g1SIob3LrwBUcULHenYei5xyOCHfj5Kh/mGyOEaHiip8n13U8ZcRqE1k4T3MDRRM
         x2lyr1DY3nGrczG7wBhPI60UBpEUdI9Yp4s5Q5XKKOaIvcIYIfsq0SHygtuZHrrI7/sJ
         Dlw1F7V3yl9asBUH5U+jnwECabs8oBnRRvhpSAs5tbaWVm8eZsL1DqJT3hUePtkjCdh7
         bvda0PHpxMRijzygp+Y8ikxGAeYHfTAnRmjG5DASvvWfIX12EvDGN49oe5Z6lsQwmrxz
         JgtNTjH/Frz9Dr2Sj/uWIuSuX/buM8Vv/M5TcyzdDutZU8EX80YmYzJCZuv/0ObD+jQG
         sWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411131; x=1692015931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=EmWxuLDUuVqeIukTWqmjPl3K0FPUt+1ViXtUEDuOAztcV3sLziQ2gu0/Z0PFyhOTph
         KtLstA6dFd63WXdUm5Tt7uwWf4P6D1z0pkMB1zSL0zcAJ2/aGh2Pf2q2Y9xBBXuRoVAy
         gg6Q2tmO/93U0ro9DXquL2ErPF7mX561XRlrbvKagKuHlorD7A2jq7EJwhmn4jLEban+
         OI7u1SWjZqmfho7BsN1TEoGC5t6snX4agGhWUdhukP+bhXJclZ1XnBYfg8xf3YRo/PQN
         EtBJF+u+jLChoehYX2zlyuAHiKt51pG/gNgCTXaI+5GD+q6VTWJMpUczit8Ll2F1aNXJ
         GydA==
X-Gm-Message-State: AOJu0YzcifGJ2pk6ikdijtsFJVPd/PW+0KTEiZuqJfLZbcSyOGLDQZY9
        GCCZuXB2A6JNykfMPxyKN79TpQ==
X-Google-Smtp-Source: AGHT+IHci0yjfkSv+HxTsOnZgFme2ZxQQuK4ytn/nitEZzci3avLuAUQEYY9VIvr9bZB5W1yGy+2Gg==
X-Received: by 2002:a17:90b:692:b0:268:6e30:600f with SMTP id m18-20020a17090b069200b002686e30600fmr7060392pjz.32.1691411130684;
        Mon, 07 Aug 2023 05:25:30 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a4b4e00b00268b439a0cbsm5942391pjl.23.2023.08.07.05.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:25:30 -0700 (PDT)
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
Subject: [RFC v2 Optimizing veth xsk performance 6/9] veth: add ndo_xsk_wakeup callback for veth
Date:   Mon,  7 Aug 2023 20:25:22 +0800
Message-Id: <20230807122522.85762-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add ndo_xsk_wakeup callback for veth, this is used to
wakeup napi tx.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 28b891dd8dc9..ac78d6a87416 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1805,6 +1805,44 @@ static void veth_set_rx_headroom(struct net_device *dev, int new_hr)
 	rcu_read_unlock();
 }
 
+static void veth_xsk_remote_trigger_napi(void *info)
+{
+	struct veth_sq *sq = info;
+
+	napi_schedule(&sq->xdp_napi);
+}
+
+static int veth_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct veth_priv *priv;
+	struct veth_sq *sq;
+	u32 last_cpu, cur_cpu;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= dev->real_num_rx_queues)
+		return -EINVAL;
+
+	priv = netdev_priv(dev);
+	sq = &priv->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->xdp_napi))
+		return 0;
+
+	last_cpu = sq->xsk.last_cpu;
+	cur_cpu = get_cpu();
+
+	/*  raise a napi */
+	if (last_cpu == cur_cpu)
+		napi_schedule(&sq->xdp_napi);
+	else
+		smp_call_function_single(last_cpu, veth_xsk_remote_trigger_napi, sq, true);
+
+	put_cpu();
+	return 0;
+}
+
 static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			struct netlink_ext_ack *extack)
 {
@@ -2019,6 +2057,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_set_rx_headroom	= veth_set_rx_headroom,
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
+	.ndo_xsk_wakeup		= veth_xsk_wakeup,
 	.ndo_get_peer_dev	= veth_peer_dev,
 };
 
-- 
2.20.1

