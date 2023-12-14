Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22AD8132ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573451AbjLNOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573436AbjLNOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:21:47 -0500
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B30FA7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rJ8VRaMAxL68T8ALEXTDFcln4Zy6so/BUy85gHqlTTU=; b=HmUI4eT7cumr78ie4CcBkziCfB
        1NC5k5rikvJN+4ltnt4vI/iOMiZ54ABVi8YNz1tnCA1hgz8JtxOiZ0Tt20f/mWn650OW9+lIwhBJ6
        h8kkGLvug/kqAUZCwpkXIhKjEDTMNIcjWXm5XZBn+dzuE3B/ripTQeXOclv88bUaZ6fkBuThTvIT5
        refexY2quviTOh1wBUjhGxwsUPe8oNEfIXUGF6Ehzowx6rLg/PsvZu023QVznGvJpTQgyEd6X+GHU
        MRdY03cBeCvwCGo597+ILcCpWFNppHU1FCgbCPNP5UmAEDWF3jBb8DcJYy4XdWsw3XfBz8TWdbIkJ
        jsgjj1gA==;
Received: from [192.168.1.4] (port=32350 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1rDmas-0006db-0t;
        Thu, 14 Dec 2023 15:21:42 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 14 Dec 2023 15:21:41 +0100
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next] net: dsa: dont use generic selftest strings for custom selftests
Date:   Thu, 14 Dec 2023 15:21:36 +0100
Message-ID: <20231214142136.17564-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if dsa device supports custom selftests than we should use custom
selftest strings for ethtool.

Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
---
 net/dsa/user.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index d438884a4eb0..d0e0d1a2bff7 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1072,7 +1072,11 @@ static void dsa_user_get_strings(struct net_device *dev,
 			ds->ops->get_strings(ds, dp->index, stringset,
 					     data + 4 * len);
 	} else if (stringset ==  ETH_SS_TEST) {
-		net_selftest_get_strings(data);
+		if (ds->ops->self_test && ds->ops->get_strings)
+			ds->ops->get_strings(ds, dp->index, stringset,
+					     data);
+		else
+			net_selftest_get_strings(data);
 	}
 
 }
@@ -1123,7 +1127,10 @@ static int dsa_user_get_sset_count(struct net_device *dev, int sset)
 
 		return count + 4;
 	} else if (sset ==  ETH_SS_TEST) {
-		return net_selftest_get_count();
+		if (ds->ops->self_test && ds->ops->get_sset_count)
+			return ds->ops->get_sset_count(ds, dp->index, sset);
+		else
+			return net_selftest_get_count();
 	}
 
 	return -EOPNOTSUPP;
-- 
2.11.0

