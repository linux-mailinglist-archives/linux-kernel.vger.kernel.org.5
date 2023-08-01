Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD9876C025
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjHAWJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjHAWJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:09:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEB2690;
        Tue,  1 Aug 2023 15:08:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so97912021fa.1;
        Tue, 01 Aug 2023 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690927726; x=1691532526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1hkgYbEyenByhiJwV7HkHjwBRGI9O4uNXYD4EgYxI0=;
        b=kaotcAVcJkwsqpE9BJbV/XN+eV8bYnbuh3SRhYaVa0Q/fSJh+DRrukxPvbyd8radiL
         P7aNclrVt4fzkZQSQy9toXXQEUtU33zUdgWp8436CNj6cUaj0nykCVaQQhSf+HXCpB3L
         nqVc4olywChap+KoZXu6zpr/PM2yGPeDb+pRoUESyWkGrf0UTzlDA17bWU0yUpXUhgdz
         qOMixXr2r/5m7Q80jNGtbzZKKlkmkHZutQSBLUEUtnVKFwfQi9TMzkIlqHahckUuxS5o
         cxvEConNhDfn8iiaxVy8h699euN19H+A6fxbZ4NnIhb6oLS2gMwXBYc8nFzUY/QFIipd
         devA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927726; x=1691532526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1hkgYbEyenByhiJwV7HkHjwBRGI9O4uNXYD4EgYxI0=;
        b=g0HcjneH5SXxKpSTT7a6chqV2blSYM7t2PNZkUq2OAjBAoqNubD6aoHfWiIag2s44+
         Q4yJKLHHbBaJ38FRHgKlqo6+cH7LQ+TpFNcErwT7c3JevSUcjuAbYcJ4b2HcVzAh/RZ8
         9LtmemNN77ssqyj8+1rUQ28EjJhV1jBrIR3RKdosQ5ZHYYMN2mCP/ti3O89D1ZxwyTut
         ZpEdakDvgIH1Mg+sLDNn1dmGTdWl1MwwsYFaGE9JtYG5l5WM4KbJu1poZxd55mFeMJdr
         YGJI97DoQx6KN3BO6egn4wWJfzaUTK3YRPjwkA2Tkw9+PZBdeRyWbOrAeVnFv9dWlBdd
         gX+g==
X-Gm-Message-State: ABy/qLZPYy/1xvtPOoIYX4QEET37sSHdoFr5Bj4OMX6tAlOY6LKWGua8
        NI9CIJJ34UpF/D43RJpwDid2Tje7xWcexg==
X-Google-Smtp-Source: APBJJlEQLbXtHrYLczB2Kt01YL/EZrQRIWtxgHivm16qea/RpBi1FApyfFFXUDWH4sX5Hq88RIbR4A==
X-Received: by 2002:a2e:805a:0:b0:2b6:e2aa:8fbc with SMTP id p26-20020a2e805a000000b002b6e2aa8fbcmr2976839ljg.8.1690927725514;
        Tue, 01 Aug 2023 15:08:45 -0700 (PDT)
Received: from localhost.localdomain ([77.222.27.96])
        by smtp.gmail.com with ESMTPSA id y18-20020a2e95d2000000b002b9ea00a7bbsm1391013ljh.60.2023.08.01.15.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 15:08:45 -0700 (PDT)
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        brouer@redhat.com, dsahern@gmail.com, jbrouer@redhat.com,
        john.fastabend@gmail.com, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
        Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH v4 1/2] drivers: net: prevent tun_build_skb() to exceed the packet size limit
Date:   Wed,  2 Aug 2023 01:07:11 +0300
Message-Id: <20230801220710.464-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the syzkaller repro with reduced packet size it was discovered
that XDP_PACKET_HEADROOM is not checked in tun_can_build_skb(),
although pad may be incremented in tun_build_skb(). This may end up
with exceeding the PAGE_SIZE limit in tun_build_skb().

Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
Link: https://syzkaller.appspot.com/bug?extid=f817490f5bd20541b90a
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---

Notes:
    v3 -> v4:
    * fall back to v1, fixing only missing XDP_PACKET_HEADROOM in pad and
      removing bpf_xdp_adjust_tail() check for frame_sz.
    * added rcu read lock, noted by Jason Wang <jasowang@redhat.com> in v1
    * I decided to leave the packet length check in tun_can_build_skb()
      instead of moving to tun_build_skb() suggested by Jason Wang
      <jasowang@redhat.com>. Otherwise extra packets will be dropped
      without falling back to tun_alloc_skb(). And in the discussion of v3
      Jesper Dangaard Brouer <jbrouer@redhat.com> noticed that XDP is ok
      with a higher order pages if it's a contiguous physical memory
      allocation, so falling to tun_alloc_skb() -> do_xdp_generic() should
      be ok.
    
    v2 -> v3:
    * attach the forgotten changelog
    
    v1 -> v2:
    * merged 2 patches in 1, fixing both issues: WARN_ON_ONCE with
      syzkaller repro and missing XDP_PACKET_HEADROOM in pad
    * changed the title and description of the execution path, suggested
      by Jason Wang <jasowang@redhat.com>
    * move the limit check from tun_can_build_skb() to tun_build_skb() to
      remove duplication and locking issue, and also drop the packet in
      case of a failed check - noted by Jason Wang <jasowang@redhat.com>

 drivers/net/tun.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d75456adc62a..a1d04bc9485f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1582,6 +1582,9 @@ static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
 static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 			      int len, int noblock, bool zerocopy)
 {
+	struct bpf_prog *xdp_prog;
+	int pad = TUN_RX_PAD;
+
 	if ((tun->flags & TUN_TYPE_MASK) != IFF_TAP)
 		return false;
 
@@ -1594,7 +1597,13 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 	if (zerocopy)
 		return false;
 
-	if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
+	rcu_read_lock();
+	xdp_prog = rcu_dereference(tun->xdp_prog);
+	if (xdp_prog)
+		pad += XDP_PACKET_HEADROOM;
+	rcu_read_unlock();
+
+	if (SKB_DATA_ALIGN(len + pad) +
 	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE)
 		return false;
 
-- 
2.39.3

