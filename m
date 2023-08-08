Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58177379B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjHHDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjHHDVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:21:06 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047281729
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:21:05 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53482b44007so3016567a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464864; x=1692069664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=lutZ0A2WljE0PHMq69IriO2rZ3mTGdwt4yVVFZOwx7KaXGHtsYthZEnorDptzuoR9Z
         3bTfCPeVS8fpSvafHRcMLxrDNgnA2loby72Wgu9cfloNQRxmHCbPK3vKdpTZfK8jUlmF
         7p0hYB/3nnDjWEtIceXVAL8kl4qqmuLDT5CgZQQRARE9KRnFvExGQzyuneXXfHttAgdL
         zsKB0Oh+uxe0BPwxqJaQMOPzn/nTgtz9LdZMlVg0RTJdKhq0bRAT7rJsnC7zn+ynGm5n
         Lymc0VkgXf3C5i+q0ZNqVquZH5V2gVRVSKb9Yn7GpEFzEVlv3u68qZNnVPavuo/G/XFK
         RNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464864; x=1692069664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICV3oSZrEepyfkdFh294C2oc/HDgt3q4tnvL6u1XOSo=;
        b=OqbWEPWagk7j7me7n4HvNtO0vOTtZbHqulCu8PGlR4gJ7tWy+doWvPAMKrLIHwWde8
         wK8gnkDxy6c9ZBoKlWPV6DltHAG4aC6BHNuQuNHqBFHY03tbaJn8zwuLz3ekXQNznojE
         25/IaMNvpv4junlTnmmZ0TTA1J+tu7lj4MlaWY17j8PJhCnchdcYRVIjfTryk8zw3U/b
         pW2RKqU2KkavmrfXsG0sg6aH5eRAPlzPUdZoCXmxVHa6KbuhLZpA9bsRNvXj1YcWd39h
         IaGqmv8l5RbTtRMHQPIUR8wrzQ7kzC9albHhPUafURtLwkFsxUPmduhkUaXoi7KdeImJ
         fr5Q==
X-Gm-Message-State: AOJu0YwYrKRa849FSqDMigPx3vEG013aFqpbfwX6McIQ8h8sovGNQQMQ
        A/wDReLqryiH2Z2c3968wD4uAg==
X-Google-Smtp-Source: AGHT+IF76sZiV7Ae2VDxsLeP3TXhil8es9a99enu8nvMpK1GwLMowzM4hBRaMRVwS8bSHHASr/moLg==
X-Received: by 2002:a05:6a21:2713:b0:133:2974:d31a with SMTP id rm19-20020a056a21271300b001332974d31amr8482956pzb.17.1691464864453;
        Mon, 07 Aug 2023 20:21:04 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:21:04 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 6/9] veth: add ndo_xsk_wakeup callback for veth
Date:   Tue,  8 Aug 2023 11:19:10 +0800
Message-Id: <20230808031913.46965-7-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

