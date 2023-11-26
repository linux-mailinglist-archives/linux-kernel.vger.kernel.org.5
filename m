Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A3C7F934F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjKZPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKZPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:16:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA2FEA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701011821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m5u/ab7IuDASESlzxALPg8Iqhjs7X4s/7bijJ9wvXUc=;
        b=F5kHlumfw/np0dFzEGF3/SGcNHPetnaYlw4JBcL6D2uYr1tniL5MvxZ+9YV+NRTY4nJ6jh
        m8tWywxiniDWABbNq8wpmG0cM/lacJg6bO8yElOq5HindLthPfzBDYs9k81OoIKGd7xhab
        vU2Ar+lhvYaoGysngW2KPz3yX7q+1+Y=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-QN8xVvv_NoGahLXfQyFpEw-1; Sun, 26 Nov 2023 10:17:00 -0500
X-MC-Unique: QN8xVvv_NoGahLXfQyFpEw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6baaa9c0ba5so4385432b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701011819; x=1701616619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5u/ab7IuDASESlzxALPg8Iqhjs7X4s/7bijJ9wvXUc=;
        b=QOo9MW9CMd+PFmscNnJlD1wAKgr6Y/q8tGQXUczJECep2KC9CZSFYCZhPFgmKbor/y
         hy4eE37qjjvtAQywwHqrFuWNDblZ55FCepkErVORwUjE5oTmND+LVdOPwajU7z+KINKT
         Bg3Kc650HQwYNFsTXka9aebxcjco8a4uYnlK1X7MMdUUv1UKeBPpy8YLfl/yokMpCmxY
         F1lqKcAB1QnNXZZ6rpMh4+8xkUY9ucDZztW2vFAC3g0tB46Xby+ngNwMQpGVqJgETN4c
         ip/Q9X41tD6X4DDyWBFwV/P2grvFvMrN5WDDZ9JX4LtHcTfjqSFq2LtJbz3ZN64EAbr2
         2JrA==
X-Gm-Message-State: AOJu0Yz9v7jTQhYWElZml/wry9YgbEn0avWwD4MVdgHtJYgZT8i4CS7b
        dxFb+Z2TXtAZ5EMhju9t+Fz4+1K41EkSWxVpcYqByi0MsoYpmXVB1V1onzOpuc3VQklfdqdtW3e
        mlPwNZGwrHss2xcnQ0p5mrU9s2JsNGzDo
X-Received: by 2002:a05:6a20:42a0:b0:188:973c:ef84 with SMTP id o32-20020a056a2042a000b00188973cef84mr8891707pzj.9.1701011819118;
        Sun, 26 Nov 2023 07:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5K7vaXEJtvpYYFlAtX0kbwzhVEiFkQ2rZ57uByILnB7JxHiS9pynUU99kpWfoE8eavMpE1w==
X-Received: by 2002:a05:6a20:42a0:b0:188:973c:ef84 with SMTP id o32-20020a056a2042a000b00188973cef84mr8891687pzj.9.1701011818817;
        Sun, 26 Nov 2023 07:16:58 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b006cb955dc54csm5741888pfn.58.2023.11.26.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:16:58 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
Date:   Mon, 27 Nov 2023 00:16:52 +0900
Message-ID: <20231126151652.372783-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
true. For example, applications can create a malformed packet that causes
this problem with PF_PACKET.

This patch fixes the problem by dropping skb and returning from the
function if skb_pull() fails.

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/ipv4/ip_gre.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 22a26d1d29a0..95efa97cb84b 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
 		 * to gre header.
 		 */
-		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
+		if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr)))
+			goto free_skb;
 		skb_reset_mac_header(skb);
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
-- 
2.41.0

