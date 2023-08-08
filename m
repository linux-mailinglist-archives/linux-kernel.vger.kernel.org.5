Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8F773794
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHHDVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHHDU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:20:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A405310F0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 20:20:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bba54f7eefso40768345ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 20:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464828; x=1692069628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=Kl4mmZ6wC30QI0KYvWfqwsTsY4ihiWC63YfNOwTtHsCTiPRlVcI029sp+MJOROKfoo
         2ZSjwgqwyuqMHwmhreAo6j9KGFeqiP4JTgT+5eIfWSoSekMcFAsja8NYdATAxJRAzZha
         LgHGf3BWqBvWvn5Ibdk2tZLiEfEVgU7EokhG1/IOeN7a4Al8TjQt7K1s0XC5mN196l4D
         ObsT7B1ydnVq2hD/R+PJ3GIdyMv70DAsQoTfRJJk0ZiyITCwrdg2BpYb2NUERKzwD37q
         7WVSfkeOaG8pIqpShLoRNDtTBASpWi86pCdSd4Sb5itRrV6POLS4x2CKUFvjHQ28tKtd
         jk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464828; x=1692069628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLQYdihKrZnqzA8pyJFR0KmRfev22Y9Nk5IK1CsNWSQ=;
        b=fc1qJZKqx8Era/X7nlTfEb0JCHScaCLd6yjIIWiYB0C1LzCutcR+qf0O8rC62l7wSP
         nu9XFrUNm3Tnwn11KTRXjzh/jBo1ACkDbEJ9vbwf2vO98n75b7fQvSEDIw/YlEi4zxzA
         /SK3SPt0XPsng7CJ8s2LCkpKlzrnKFTeNZA1YSOycpb7Qjj90g6qlQlsalqfQb88dT2P
         IApRvEedZh0tEvoOA3ul1oHas9YL2h54vYmBozuuUGDwalgHmW3Wd/SgwurAvUs0vm6g
         TOoVQGn/Y0Bb2mJNGggtBxnQE8dBDqcKr5G97S/pkKEH5FfWhfscInQGzEHmGSCmU5oz
         5hUQ==
X-Gm-Message-State: AOJu0YwuUb3FsS7kih4CIfjoQrrJkzETNehPLGLiPRsrlIgEQt8wU2Zk
        r43tgmZU+XEtJJ45XeDveVXfKw==
X-Google-Smtp-Source: AGHT+IGLpz+58KIOin27q8snOr3n0kQTemVujLRn7G1yFjy5FFK/EozRt3B6Cq5rzwpxMgPHKWxaaw==
X-Received: by 2002:a17:902:d4c8:b0:1bc:1e17:6d70 with SMTP id o8-20020a170902d4c800b001bc1e176d70mr11761596plg.24.1691464827688;
        Mon, 07 Aug 2023 20:20:27 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:20:27 -0700 (PDT)
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
Subject: [RFC v3 Optimizing veth xsk performance 1/9] veth: Implement ethtool's get_ringparam() callback
Date:   Tue,  8 Aug 2023 11:19:05 +0800
Message-Id: <20230808031913.46965-2-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some xsk library calls get_ringparam() API to get the queue length
to init the xsk umem.

Implement that in veth so those scenarios can work properly.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..77e12d52ca2b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -255,6 +255,17 @@ static void veth_get_channels(struct net_device *dev,
 static int veth_set_channels(struct net_device *dev,
 			     struct ethtool_channels *ch);
 
+static void veth_get_ringparam(struct net_device *dev,
+			       struct ethtool_ringparam *ring,
+			     struct kernel_ethtool_ringparam *kernel_ring,
+			     struct netlink_ext_ack *extack)
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

