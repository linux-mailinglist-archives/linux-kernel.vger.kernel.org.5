Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79C7BB78E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjJFM20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJFM2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:28:21 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE3F4CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1a/vW
        nH3Ah5pXEyFX/8tf2+Zvr5M8bQvxpTQY3e+UqA=; b=C2T7kyfWIAIMoRJ/bRm2z
        xeT3mpMXCpdPWWNAMnQ8dsaGaPQdGELhq0nz99G9DzEyLGaQ/Co3dPNbpdmy7Tva
        itDV8YzNT5/RNMS08f29Y6bUuyLAqoHNkc4VzElSalnNWBf7gj08o9hqN3LnWCho
        Eiyw7Az5WzGNa4wglW5IP4=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g3-4 (Coremail) with SMTP id _____wAnLUQn_R9lBEAAEA--.49286S4;
        Fri, 06 Oct 2023 20:27:28 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, make_ruc2021@163.com,
        xiangyang3@huawei.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: fix return value check in vector_legacy_rx
Date:   Fri,  6 Oct 2023 20:27:17 +0800
Message-Id: <20231006122717.3984017-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnLUQn_R9lBEAAEA--.49286S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUXr1DCr1kZF4DAFyUGFg_yoWfGrX_Kw
        1xZanrGr47Grn8Xr1DGF13urya93WkZFZ8Z3WFqr9xZw43Z34fAws0qrn8A3WUWay7Wwsr
        Kry3GrWjkw1rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNeOJUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRkBC2B9oZDe6wABse
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vector_legacy_rx, to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 arch/um/drivers/vector_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29576..822a8c0cdcc1 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *vp)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb, pkt_len - vp->rx_header_size);
+			if (pskb_trim(skb, pkt_len - vp->rx_header_size))
+				return 0;
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			vp->dev->stats.rx_bytes += skb->len;
 			vp->dev->stats.rx_packets++;
-- 
2.37.2

