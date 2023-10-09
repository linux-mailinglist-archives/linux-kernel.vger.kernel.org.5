Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFE7BD1BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 03:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344983AbjJIBPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 21:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbjJIBPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 21:15:04 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81678B9;
        Sun,  8 Oct 2023 18:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=965mj
        5bVJjuRzIOLXKTTNC1mfCFD/qdXMo0Guhu3pSw=; b=ULOEtenyqgcNc2uzC7/Af
        wWGepiCUOuDbuuk8mDbLeFn6Vb76+yt+pEFLHTdxUUAIG72lfN5GDSKZb/5yG6Cy
        pK5892XrSyYYhma3g8U+RgWjPrSAhd3t9/8KsA6UX0mrbGeCCPwXhdWHh4FM6dhO
        QPfgQH0ho1IWSUsmFywoVE=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3nxzCUyNl60QnAA--.26088S4;
        Mon, 09 Oct 2023 09:13:47 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: ipv4: fix return value check in esp_remove_trailer
Date:   Mon,  9 Oct 2023 09:13:37 +0800
Message-Id: <20231009011337.4037007-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3nxzCUyNl60QnAA--.26088S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyUXr4rXr48Xr1DAFW8JFb_yoWxtFg_Ga
        9rXr4kW3W8uFn7ZF43Zr47tFy5t348XFWFvF1ftayavwnrAw1rJws7CrZ8u3sxGa9rCr13
        AFnxCrWIyas0vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKJ5rDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFRsEC2B9obSsEQAAs0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In esp_remove_trailer(), to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/ipv4/esp4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 2be2d4922557..d18f0f092fe7 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -732,7 +732,9 @@ static inline int esp_remove_trailer(struct sk_buff *skb)
 		skb->csum = csum_block_sub(skb->csum, csumdiff,
 					   skb->len - trimlen);
 	}
-	pskb_trim(skb, skb->len - trimlen);
+	ret = pskb_trim(skb, skb->len - trimlen);
+	if (unlikely(ret))
+		return ret;
 
 	ret = nexthdr[1];
 
-- 
2.37.2

