Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16902776561
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHIQsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHIQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:48:02 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618AF1FCC;
        Wed,  9 Aug 2023 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691599682; x=1723135682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RZ0TDIAWVWjKzQG/fNH2WZoDHlB8BqVrxrTKmYL0yWg=;
  b=i4YqLRU+bm0mYYtMw0nAxEroCu+WZB/RppLKwPI7QaW9/bA61fBX/058
   dxGrFD5vYwtPiNxF3WjU98p8tdahTc0S/QRO9B65FHRW6qd6Gv5/asp5U
   ByQ3LTOOczDMYUUtxGBqMJAgvFBToxWBelkGm9p6Y/MxT7DoWNOcNhCv7
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,159,1684800000"; 
   d="scan'208";a="601118400"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 16:48:00 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id BEB0D1040B3;
        Wed,  9 Aug 2023 16:47:58 +0000 (UTC)
Received: from EX19D019UWB001.ant.amazon.com (10.13.139.189) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 16:47:57 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D019UWB001.ant.amazon.com (10.13.139.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 16:47:56 +0000
Received: from u7187ce7291cc57.ant.amazon.com (10.135.199.88) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Wed, 9 Aug 2023 16:47:55 +0000
From:   Tahsin Erdogan <trdgn@amazon.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Tahsin Erdogan <trdgn@amazon.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] tun: avoid high-order page allocation for packet header
Date:   Wed, 9 Aug 2023 09:47:52 -0700
Message-ID: <20230809164753.2247594-1-trdgn@amazon.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gso.hdr_len is zero and a packet is transmitted via write() or
writev(), all payload is treated as header which requires a contiguous
memory allocation. This allocation request is harder to satisfy, and may
even fail if there is enough fragmentation.

Note that sendmsg() code path limits the linear copy length, so this change
makes write()/writev() and sendmsg() paths more consistent.

Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
---
v4: updated commit message address comments from Willem
v3: rebase to latest net-next
v2: replace linear == 0 with !linear
v1: https://lore.kernel.org/all/20230726030936.1587269-1-trdgn@amazon.com/
 drivers/net/tun.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 973b2fc74de3..62106464f1b9 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1523,7 +1523,7 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
 	int err;
 
 	/* Under a page?  Don't bother with paged skb. */
-	if (prepad + len < PAGE_SIZE || !linear)
+	if (prepad + len < PAGE_SIZE)
 		linear = len;
 
 	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
@@ -1840,6 +1840,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			 */
 			zerocopy = false;
 		} else {
+			if (!linear)
+				linear = min_t(size_t, good_linear, copylen);
+
 			skb = tun_alloc_skb(tfile, align, copylen, linear,
 					    noblock);
 		}
-- 
2.41.0

