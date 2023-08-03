Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4104376EBCE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHCOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjHCOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:07:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330D46AC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:06:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbc64f9a91so8987615ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071580; x=1691676380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAdtU7SLip58WY/jMpbQZS/1BOrBTm47cvrvRETW+jo=;
        b=gje/ZNVdV37PsuBXcn9JcvDF1Ybdczh0zKLeYvcGuYmGxjT6hPC415oZTPIOtzx83g
         7FFCFIT6Kmor5VCwN/i3qktqe92oFscFmNOAH082Ja7YR86GHFserclV4lc3CJNE1JVd
         +JiXjBg0V2wOrubU8ZMJeKXuoUv0Ozj0un1MiQjMdSXoHWHZZSf8vRs5OnkLjIX36jjU
         ig5yH157Hd/7+McdeYRCdJOIPawm3lbgYqB1DJYMWZGMAML63qPftJeILVLdeNK3uyOL
         pQHZQMLoxkAmw95IlOXouBPXN7IMMwa9psr71neaanIiaQcBn8UqW9AyIOJ3Td1T4F+e
         6mDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071580; x=1691676380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAdtU7SLip58WY/jMpbQZS/1BOrBTm47cvrvRETW+jo=;
        b=eiV3SsjyqBDXvvqFwe9QFTCKYNA0c9Mcd+1XEcBIUkHLhjMkvubMqzlV6Y/PHZghLR
         BBiYzK8xY4kfH+4qIS3F6YFqccdgjF/dIuPq29Z1WXvyUsdkf6kIsuxAaQGzkbX65VR1
         GEZnHvLKjYFH4DOFeWT1F7RJvk6MAj5XmQRdhwXcnLwyNpGgsjEmSziC5XChjR53e+HM
         TH8VNhU/RmMpNl8o8/5C2jDpaDSb5xll6e3ojUILSA9DOoEgVgCVpBzZ7d3S2TqegJp7
         mIzpwbIGGiEVMRpEFYnH0MTyY8ZZeNMVW4o2mBsB1uAYrfOjc48DJggY0epa4dWlpBQw
         +wrg==
X-Gm-Message-State: ABy/qLZSQ3NPtex4x6ectbaTjmMpbhUoGdfeJFhImJ6bDYGdsiD0LGTP
        5Rw4zJtX3+rg9x0YMZ4v5crpDQ==
X-Google-Smtp-Source: APBJJlEB4J2N6PwO/XzHjVb9E/ZDHejJFXzJmb2/i3ejuedYImdsgBFrlBMRUUbpVS6DJIX4pEtG5w==
X-Received: by 2002:a17:902:e807:b0:1b9:e091:8037 with SMTP id u7-20020a170902e80700b001b9e0918037mr23334397plg.30.1691071580298;
        Thu, 03 Aug 2023 07:06:20 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:06:19 -0700 (PDT)
From:   "huangjie.albert" <huangjie.albert@bytedance.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Gobert <richardbgobert@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 06/10] veth: add ndo_xsk_wakeup callback for veth
Date:   Thu,  3 Aug 2023 22:04:32 +0800
Message-Id: <20230803140441.53596-7-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 944761807ca4..600225e27e9e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1840,6 +1840,45 @@ static void veth_set_rx_headroom(struct net_device *dev, int new_hr)
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
+	if (last_cpu == cur_cpu) {
+		napi_schedule(&sq->xdp_napi);
+	} else {
+		smp_call_function_single(last_cpu, veth_xsk_remote_trigger_napi, sq, true);
+	}
+
+	put_cpu();
+	return 0;
+}
+
 static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			struct netlink_ext_ack *extack)
 {
@@ -2054,6 +2093,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_set_rx_headroom	= veth_set_rx_headroom,
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
+	.ndo_xsk_wakeup		= veth_xsk_wakeup,
 	.ndo_get_peer_dev	= veth_peer_dev,
 };
 
-- 
2.20.1

