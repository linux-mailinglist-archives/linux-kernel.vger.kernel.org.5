Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5860C7B392A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjI2Rud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjI2Ru0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:50:26 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67AC19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:50:23 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-65af726775eso4268156d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1696009823; x=1696614623; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72PAJei39nrMMwm0fE8A8KKvNqYVfjffekZbQ4no+DM=;
        b=RzoNY2897Fect+FfbNq1WDPmzGIvAyj+JzmEdxYdMRczO4VpoHulmIxE+T+UkMQDb4
         klX4UzZq+/oMbQUqSzkpihiPMl9rLfvfnZAqC1ScIxnI0tfMPSzZgaBMUIwgh+gUNqp9
         O0IUe+MeTEWY0lmA3WrLSdxl2uMFxtczVd+EXljsyZuPhC1S4hWEaTZ29En0IT3O/FOn
         aHuUaMyyziO1im2tPmVyEP+Uq/T2gU/isyetB8wuBca8HHMB74syUc6fYzBEW5dusf6N
         bgbK83veZOh5Cp+nfr0x6jSlMV/ES4ibVtApzbV7/s70bv91YdLviFFGDWDozt3ZH2Ya
         59lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009823; x=1696614623;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72PAJei39nrMMwm0fE8A8KKvNqYVfjffekZbQ4no+DM=;
        b=AisJBdTvC9BnXqtv6kIazJNtXr2QuIiRNDF6sD9R3A0mguA72x00pbzIdl/rF0xdAi
         83ebXxVc8VZqw/fQuwSU/fX+WFtiappQxI2SX0ijLrq0A96/xRzFDJSX8TGBW4hLgZWd
         zI3YkNjUOGwZ6YRjVWbgUsEYSqJs+cQmBagCnAQG/IMWd/YRf+KNmHs151ulzjcfor/R
         G1O/LK286CpNv8jWVXn3y9sXoEzl4UL2jT5bP7GO51kQENMdpVTf5nNhNb+XzZm8jaSJ
         F9P6iY9QCCIT5Tf6ERoEW005mewFNO198Oj6VOXkAg4mIdQAB6pHIbN1sYsWWkPmQSOS
         +2qQ==
X-Gm-Message-State: AOJu0YwKubuEpD+sRR/dwBXxCwCg1t3qpifnZGSIE/ixZYcd9Z50igMM
        k4bRTVOV9ONW42LcErr+77aIFA==
X-Google-Smtp-Source: AGHT+IH5euOHYtP4n7HpCFvXZFhOdvtdAJY1b8zVr+fQkgtHjdNgMXUO940oXRIXFpeL+QCblAyVhQ==
X-Received: by 2002:ad4:55cf:0:b0:65b:12b1:d54f with SMTP id bt15-20020ad455cf000000b0065b12b1d54fmr5656730qvb.22.1696009822937;
        Fri, 29 Sep 2023 10:50:22 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id p17-20020a0cf551000000b0065b1b5cd70csm3711634qvm.31.2023.09.29.10.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:50:22 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:50:20 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: [PATCH net] ipv6: avoid atomic fragment on GSO packets
Message-ID: <ZRcOXJ0pkuph6fko@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSO packets can contain a trailing segment that is smaller than
gso_size. When examining the dst MTU for such packet, if its gso_size
is too large, then all segments would be fragmented. However, there is a
good chance the trailing segment has smaller actual size than both
gso_size as well as the MTU, which leads to an "atomic fragment".
RFC-8021 explicitly recommend to deprecate such use case. An Existing
report from APNIC also shows that atomic fragments can be dropped
unexpectedly along the path [1].

Add an extra check in ip6_fragment to catch all possible generation of
atomic fragments. Skip atomic header if it is called on a packet no
larger than MTU.

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
Reported-by: David Wragg <dwragg@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 951ba8089b5b..42f5f68a6e24 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -854,6 +854,13 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	__be32 frag_id;
 	u8 *prevhdr, nexthdr = 0;
 
+	/* RFC-8021 recommended atomic fragments to be deprecated. Double check
+	 * the actual packet size before fragment it.
+	 */
+	mtu = ip6_skb_dst_mtu(skb);
+	if (unlikely(skb->len <= mtu))
+		return output(net, sk, skb);
+
 	err = ip6_find_1stfragopt(skb, &prevhdr);
 	if (err < 0)
 		goto fail;
@@ -861,7 +868,6 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	nexthdr = *prevhdr;
 	nexthdr_offset = prevhdr - skb_network_header(skb);
 
-	mtu = ip6_skb_dst_mtu(skb);
 
 	/* We must not fragment if the socket is set to force MTU discovery
 	 * or if the skb it not generated by a local socket.
-- 
2.30.2

