Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9647BB6B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJFLmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjJFLmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:42:37 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 856AACA;
        Fri,  6 Oct 2023 04:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=skzg0
        FxcauA9cDyPuWsiRc28EhNtwMYJk3uNIp52Two=; b=aHWPsWrHQ2Qv9sbpwKOeu
        NoZaMn16SRIIk9xtQ2XYGVbhoR5nUzcE7xR1ou/H+k4mA9rSfZdCKadf+xqvBGzs
        nLM4k3oIxCsWOa/a//ldZbNWJEqJluk5hjmd6ushrDmJbBDeg8Iky0LAbT0gGPUX
        J6mF6vodU/rILF+MhgTol4=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAHKPRU8h9lnBHVCA--.49032S4;
        Fri, 06 Oct 2023 19:41:10 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net: xfrm: fix return value check in ipcomp_compress
Date:   Fri,  6 Oct 2023 19:41:06 +0800
Message-Id: <20231006114106.3982925-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHKPRU8h9lnBHVCA--.49032S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1fWw4rWFW7CFW3Kr43Awb_yoW3CFX_CF
        WIqrsrur90vrn3Aw4kArZxtr9rXan8ur1vqr92qFWDZ34kAas5u3s7XrZxua15GFyDGFy7
        Can0gFZ7AwnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKSoXUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyBgBC1p7MBefHAAAsf
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipcomp_compress, to avoid an unexpected result returned by
pskb_trim, we should check the return value of pskb_trim().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/xfrm/xfrm_ipcomp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 9c0fa0e1786a..5f2e6edadf48 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -144,7 +144,9 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
 	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
 	local_bh_enable();
 
-	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
+	err = pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
+	if (unlikely(err))
+		goto out;
 	return 0;
 
 out:
-- 
2.37.2

