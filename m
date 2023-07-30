Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4EE7684A9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjG3Jj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG3Jjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:39:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48A1BDA;
        Sun, 30 Jul 2023 02:39:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d58b3efbso3159550f8f.0;
        Sun, 30 Jul 2023 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690709991; x=1691314791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRAG2y5s5jsU57Ef4re95fs4ggBIVFmrGwBiaiHU1mc=;
        b=s3ymq2gEh2sqzFH6eqK2NbhQ/Qz5ntzHr8uZDZKVNQKk3orQ9D+ZJj8CdbFWvcgGFP
         lcP4q446xVKGTZAYMyFLyr8kUufoq4COJyzqm9jbRxgAP0PntzFddF2mrEaYTvnW1KrS
         axFJm/Y6NX5gR73g5JJPKTo8gjF1xHw8fg5JLBmfhK5H7Im9UDMgK3DI6loXO9XUEqTQ
         DBGjGmTH/YqmUvrIhP3O5o9G+ROPVdcAFCCezifE+9h0kuxxxQjwlEWlH43QYCpxfHty
         U6Y5u+8vdRU2/+eeN8Y9j/DO+rm+685K70BbRzEzqSmFz33otwp03iTbj445QB9ikyoY
         he8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690709991; x=1691314791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRAG2y5s5jsU57Ef4re95fs4ggBIVFmrGwBiaiHU1mc=;
        b=AhrJ8qWaH7BUdEUdcnCVl/Q72hkbVPMdxlXXZHWz470jlYUWoARAIecwwm0lqCcb3c
         aiuEvcI7I7ySLnLIV1APzDlqZp76MNrx6jYoHe5CI5kaqFTDDO7m95TUd7M7PdOAQPIz
         CWv9KopuJ4QZ6BJfBEPC861oG9OtKOkk3ZtssxUD/lqTIPew/ww5K6PRmVuOe9dMwy64
         jS8lOz98VEObOX/ahHJCcZeIvD5yV+E0UbSnrU45sAqfRKJ4gcmopJgvUwtdA1KVtRb0
         iY2xkPEiZ3yTxC30JHSsgoY4BtI20W34FkEpcdRkcBvg1qbM8bphmKTr3WmKyuutS6tw
         fHvQ==
X-Gm-Message-State: ABy/qLZM2/QIx+Rnub0dxng2PntZVcQqtmFjXyPWYacNOL2DK4wXTKNB
        q8v2vXMUwHQzGVRZrQKjgY0=
X-Google-Smtp-Source: APBJJlGKqG4u0OtFceKUNe0E1pLghIwW4JNpbGOfD4LrswczxE5umvvnEGrTsen13A+6K3pNyEi9ew==
X-Received: by 2002:a5d:4f05:0:b0:317:66c0:9d82 with SMTP id c5-20020a5d4f05000000b0031766c09d82mr4471002wru.64.1690709991021;
        Sun, 30 Jul 2023 02:39:51 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffa90000000b0031423a8f4f7sm9574599wrr.56.2023.07.30.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 02:39:50 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>,
        Michal Kubiak <michal.kubiak@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [net-next PATCH v3 1/5] net: dsa: tag_qca: return early if dev is not found
Date:   Sun, 30 Jul 2023 09:41:09 +0200
Message-Id: <20230730074113.21889-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently checksum is recalculated and dsa tag stripped even if we later
don't find the dev.

To improve code, exit early if we don't find the dev and skip additional
operation on the skb since it will be freed anyway.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
changes v2:
- Add review tag

 net/dsa/tag_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/tag_qca.c b/net/dsa/tag_qca.c
index e757c8de06f1..e5ff7c34e577 100644
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -75,10 +75,6 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 		return NULL;
 	}
 
-	/* Remove QCA tag and recalculate checksum */
-	skb_pull_rcsum(skb, QCA_HDR_LEN);
-	dsa_strip_etype_header(skb, QCA_HDR_LEN);
-
 	/* Get source port information */
 	port = FIELD_GET(QCA_HDR_RECV_SOURCE_PORT, hdr);
 
@@ -86,6 +82,10 @@ static struct sk_buff *qca_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	if (!skb->dev)
 		return NULL;
 
+	/* Remove QCA tag and recalculate checksum */
+	skb_pull_rcsum(skb, QCA_HDR_LEN);
+	dsa_strip_etype_header(skb, QCA_HDR_LEN);
+
 	return skb;
 }
 
-- 
2.40.1

