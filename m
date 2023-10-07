Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAA17BC369
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjJGAvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjJGAvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:51:45 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9437BD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 17:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=p3Qx7
        B082VtZrFxOuYcTvp7+pBO3IhmptOg+FirYoRY=; b=l6pmgkCAodebYncQaXmxV
        5k6RMMYuPSUmRT4u5AupptzsHN2NiEFmk47GZUtl834nZLPEz7OxHR/0UNA59CMw
        ANmedTEuCsJDNVCV0fbrzxIBZmq1VxgtpN8GPXZRpO1RBmIb+bNnKwjiTT3cOBhy
        yHzOCl8a9Bn06/xtypPL7g=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wD33OZ5qyBlC+QfEA--.50324S4;
        Sat, 07 Oct 2023 08:51:14 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, xiangyang3@huawei.com,
        make_ruc2021@163.com
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] um: vector: fix return value check in vector_mmsg_rx
Date:   Sat,  7 Oct 2023 08:51:04 +0800
Message-Id: <20231007005104.3994678-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD33OZ5qyBlC+QfEA--.50324S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUXr1DAw4kAFy8urW7Arb_yoWfXFX_Gw
        n7XanrJr4xKFn0qr1kCr13uryava1q9F95ZF1FqrW3ZwsxZw1xAF909r15A3WUWa9rGrsr
        Kr93GrW09r1rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM5l8UUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFQICC2B9oZceNAAAsf
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

In vector_mmsg_rx, to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 arch/um/drivers/vector_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29576..c280ce5ea6ce 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1013,8 +1013,8 @@ static int vector_mmsg_rx(struct vector_private *vp, int budget)
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
 			}
-			pskb_trim(skb,
-				mmsg_vector->msg_len - vp->rx_header_size);
+			if (pskb_trim(skb, mmsg_vector->msg_len - vp->rx_header_size))
+				return 0;
 			skb->protocol = eth_type_trans(skb, skb->dev);
 			/*
 			 * We do not need to lock on updating stats here
-- 
2.37.2

