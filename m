Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9277876EBC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjHCOHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbjHCOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:06:48 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0963C25
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:05:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb775625e2so7268545ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071521; x=1691676321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lti4noGvWp81QMD78qgE1vMb8ru0CmeNy8GFo0ds5M=;
        b=ARPb/1sWh5T9p5GWjB03DuP/6QZsEazyqs/OXDGx5lkxhGk5XSHzLq7ODIElIYrFOb
         w6NmJppncUr5m/HHnhC+ubn3OXKSO93n7CunQ91Kqvw7Tf48agwl/sfkzVFunkSBsUwL
         JDSPtcxynczQTY4LUWfzEj8vza7wxX8VrrPUBZDCl9dsKp1h0oShS+rTDk01lxfzOOiw
         y6/9vPodJQo4JciEVHY9A/tNsegQ1GZOZrbkayOHoEORYyBxV7vd9Endd5Bcsumt2EBl
         c0qPe6AsKe7fZ1nTpg/XssSjVOlfsWqyaGzoMubvQPNbG7/icyQChTqyeTV/5C8talsZ
         Co2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071521; x=1691676321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lti4noGvWp81QMD78qgE1vMb8ru0CmeNy8GFo0ds5M=;
        b=LVUvMh/N1OyEo325jm2XgPtHi+obj91DFiPu8vN5zzxHQ1IBSkTXRd7CiHOuq/k0OX
         fs2E900aZ4qx7YaC4SmHhlmIRQn2VWGQSMnZWadvPJxI2Qin7mlhRT+ix9RaaYdqo4A5
         IKwq+ZizWZc+tro9nC+OW0PnVCwKXg2ZKT11EU5r5bshSWVXS4a0uhiLRh85AfW00Whi
         Qkw7uatliGRfs/aXP29bxJMt13G5IP8mtzVveePgXm4j5kdZWGeKecG9IGArv5xFSWkQ
         vnmhIXtMTKzHnq0vyMmEvYt2iBd+oM3ipc1MCOoEvwTG//1Pd+RoZwgGNOi2/0JW5+6k
         4cvw==
X-Gm-Message-State: ABy/qLagPxku/X5JVCHhfo2/Ls0ePYcDrBuzXxjyjelE29NBxwzdY3gr
        RWE5rp4txnATuaLmQTQx9nZx1A==
X-Google-Smtp-Source: APBJJlFo2cNFMR6i7kmoV21NH6/h1fH77lSujUPrSipJAFbQsyZD+jUKaJqFZK1ENQnjLqiibq8j6w==
X-Received: by 2002:a17:902:6943:b0:1b8:6984:f5e5 with SMTP id k3-20020a170902694300b001b86984f5e5mr18474453plt.12.1691071521455;
        Thu, 03 Aug 2023 07:05:21 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:05:20 -0700 (PDT)
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
        Menglong Dong <imagedong@tencent.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Richard Gobert <richardbgobert@gmail.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 01/10] veth: Implement ethtool's get_ringparam() callback
Date:   Thu,  3 Aug 2023 22:04:27 +0800
Message-Id: <20230803140441.53596-2-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some xsk libary calls get_ringparam() API to get the queue length
to init the xsk umem.

Implement that in veth so those scenarios can work properly.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..c2b431a7a017 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -255,6 +255,17 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static void veth_get_ringparam(struct net_device *dev,
+				  struct ethtool_ringparam *ring,
+				  struct kernel_ethtool_ringparam *kernel_ring,
+				  struct netlink_ext_ack *extack)
+{
+	ring->rx_max_pending = VETH_RING_SIZE;
+	ring->tx_max_pending = VETH_RING_SIZE;
+	ring->rx_pending = VETH_RING_SIZE;
+	ring->tx_pending = VETH_RING_SIZE;
+}
+
 static const struct ethtool_ops veth_ethtool_ops = {
 	.get_drvinfo		= veth_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -265,6 +276,7 @@ static const struct ethtool_ops veth_ethtool_ops = {
 	.get_ts_info		= ethtool_op_get_ts_info,
 	.get_channels		= veth_get_channels,
 	.set_channels		= veth_set_channels,
+	.get_ringparam		= veth_get_ringparam,
 };
 
 /* general routines */
-- 
2.20.1

