Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4D763881
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjGZOIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjGZOHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7F930D6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140712euoutp024571152b2fbbf9e6de860cca0b654ac3~1cAwVGXKF1608116081euoutp02Q
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140712euoutp024571152b2fbbf9e6de860cca0b654ac3~1cAwVGXKF1608116081euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380432;
        bh=zV6NK1bOT7jAIeViULG7reTqUFYKfHTzkiJZni8yHtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bruaHRbr42VkRh/qfcRULFN/xrZjWD9E8bHu8H1ChgNhnYXwrYUMb+3S032pQQehV
         gvYKYKZ381/s//zMEKeAlYVpV0HAaGEpHq+XlvTE0lhs69pyCLGHbPqc61ZYd+7xgG
         JvRUN+GGfPwhybBhlhRKRmsXH5lhyS41ojKTXOYs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726140711eucas1p214dadbb42dd76ca07c8791c7d08d861b~1cAv40m5x1969419694eucas1p2N;
        Wed, 26 Jul 2023 14:07:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7E.66.37758.F8821C46; Wed, 26
        Jul 2023 15:07:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140711eucas1p25a947afeef5593e21578f778355db192~1cAviQmRq0080900809eucas1p2g;
        Wed, 26 Jul 2023 14:07:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140711eusmtrp129a255c6e058423b93a5158f0fac4994~1cAvhqgAO2411224112eusmtrp1Q;
        Wed, 26 Jul 2023 14:07:11 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-34-64c1288fc24c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.57.14344.F8821C46; Wed, 26
        Jul 2023 15:07:11 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140711eusmtip244e8e96d9a2910724634c8526608f09e~1cAvTjpRq1659816598eusmtip2j;
        Wed, 26 Jul 2023 14:07:11 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     willy@infradead.org, keescook@chromium.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] vrf: Update to register_net_sysctl_sz
Date:   Wed, 26 Jul 2023 16:06:32 +0200
Message-Id: <20230726140635.2059334-13-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djPc7r9GgdTDJp/6lrMOd/CYrFuVyuT
        xdNjj9gtlu5/yGjxf0G+xZnuXIsL2/pYLS7vmsNmcWPCU0aLYwvELL6dfsNo8fvHHDYHHo/Z
        DRdZPLasvMnksWBTqcfmFVoet17bemxa1cnm8X7fVTaPvi2rGD0+b5IL4IzisklJzcksSy3S
        t0vgypjd4Vfwna1i+dsVrA2Mt1i7GDk5JARMJObf7WTuYuTiEBJYwSjx5t42JgjnC6PEv7+d
        UM5nRol3X3cBtXCAtUyaxgYRX84ocXHRRnaQUUICLxklniyWBLHZBHQkzr+5AzZWROA0o8Tp
        v7vYQRxmkI5Xi6+ygFQJC9hI3Lj4BKybRUBVoq93PRvIBl4BO4kfr9Ih7pOXaLs+nRHE5gQK
        r1z7HexuXgFBiZMzn4CNYQaqad46G2yZhMAXDonHb1awQTS7SLyc+wvqUWGJV8e3sEPYMhKn
        J/ewQDRMZpTY/+8DO4SzmlFiWeNXJogqa4mWKyDXcQCt0JRYv0sfIuwosfTRGUZIUPBJ3Hgr
        CHEEn8SkbdOZIcK8Eh1tQhDVKhJ9S6ewQNhSEtcv74Q6zUNiQ+9U9gmMirOQvDMLyTuzEPYu
        YGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZi4Tv87/nUH44pXH/UOMTJxMB5ilOBg
        VhLhNYzZlyLEm5JYWZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qB
        SeVzOUuAv+L5qw3NIQ+s/mfrVD064788Z7vnGt4F4SpRMvLCP1pTAxctvWOUP/lZctkef7W1
        N5dujd234Mh5C+WpH23f2Fpkezgv3v9ApsDzz8+49UIvo+SM3j6aP7/t5bET2Tx31k46Z97D
        ns3Y+EvG+8j9DXdc/RnE19XamX6e1VP+4cYBvzS1LZVqRr4FpgEhXo8NI5/suMys/HKDZHeA
        0nzn5DjxTVxJC5X6DizLDpq4cvNk/dvHok4s+LI5pGXVlFWZu0231W17c+v/s9C4jQI3mmdG
        7JWMKvtl/ldu0t4NQq9sQm8LSTeWTQo8EzBFe+a7ky8nn13xWXbin19vl7+Izmjc8WoiR5Kv
        nbgSS3FGoqEWc1FxIgDpfxGOywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7r9GgdTDGbeF7eYc76FxWLdrlYm
        i6fHHrFbLN3/kNHi/4J8izPduRYXtvWxWlzeNYfN4saEp4wWxxaIWXw7/YbR4vePOWwOPB6z
        Gy6yeGxZeZPJY8GmUo/NK7Q8br229di0qpPN4/2+q2wefVtWMXp83iQXwBmlZ1OUX1qSqpCR
        X1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzG7w6/gO1vF8rcrWBsY
        b7F2MXJwSAiYSEyaxtbFyMUhJLCUUWLHkk9MEHEpie/LOLsYOYFMYYk/17qgap4zSryde4cF
        JMEmoCNx/s0dZpCEiMBFRom+x5fYQRxmgbWMEvOmTwOrEhawkbhx8Qk7iM0ioCrR17ueDWQD
        r4CdxI9X6RAb5CXark9nBLE5gcIr135nBbGFBGwleqY+BWvlFRCUODnzCdhIZqD65q2zmScw
        CsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYHxtO/Zzyw7Gla8+6h1iZOJg
        PMQowcGsJMJrGLMvRYg3JbGyKrUoP76oNCe1+BCjKdDZE5mlRJPzgRGeVxJvaGZgamhiZmlg
        amlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAtI5R/pP+kgomJ3tWpewcd01Xka+XTss9
        5409IaNxJlHqj9OkFxtVI+vbsn5L5Zp0Mn7jNXg/q+33oUrOIy7hYhHyp9fsuvzpQxuTwLyL
        QVffLWeZvbXfrF1ZvGV24wbnLKbP/ft+NaTI15x1Fp15eP6nhnM6FdVF9tpnLzkK/05SVmEy
        qoq+fDm1cZ1hpsgfn8KcO0tXFzcLHfQ54bvmg3Jdu3ApY6UI59fP0kk2Nz0F9JR3F9wtmavA
        v5OJr9X2VcWzSeeXbr3hxbqiScmZf9PsZd8YvGwzeNJbLDOjpy5d9uXonxMmMgwyi2+c8+px
        bBa4d8Z4avSNd9/nutkpLpX/qxslly9eu/vpNhklluKMREMt5qLiRAD1/g2bOAMAAA==
X-CMS-MailID: 20230726140711eucas1p25a947afeef5593e21578f778355db192
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140711eucas1p25a947afeef5593e21578f778355db192
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140711eucas1p25a947afeef5593e21578f778355db192
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140711eucas1p25a947afeef5593e21578f778355db192@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the effort to remove the sentinel (last empty) element
from the ctl_table arrays. We update to the new function and pass it the
array size.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/net/vrf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bdb3a76a352e..f4c3df15a0e5 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1979,7 +1979,8 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 	/* init the extra1 parameter with the reference to current netns */
 	table[0].extra1 = net;
 
-	nn_vrf->ctl_hdr = register_net_sysctl(net, "net/vrf", table);
+	nn_vrf->ctl_hdr = register_net_sysctl_sz(net, "net/vrf", table,
+						 ARRAY_SIZE(vrf_table));
 	if (!nn_vrf->ctl_hdr) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

