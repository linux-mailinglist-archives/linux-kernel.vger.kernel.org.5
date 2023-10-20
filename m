Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7817D079E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbjJTFc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbjJTFcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:32:53 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBD7119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:32:52 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-778927f2dd3so23391185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697779971; x=1698384771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xpTogBhloZZ3cgxOHAvGjGFV2B6QzeETWE0jVApmhU=;
        b=W5HYo6CzHn0n+hoSyGPdXLRPk7sDe9kyTLVSvCoWtjMgPhbsnd6DDmh+tFU5wF8rfQ
         RJqEmYP3AU7cmo2moTlMJpLaQ3puZno8yFfEbkDM5H4pLKeTQmWxq8uEsW9WfOFD6I00
         /fB2kMHootI9Y+koucBakT4yLrQPVCLHsxVuvi2cEVfQaTUWOhAUc65d1dHSyABO+ANL
         G9IiC9klk/NZuF12Lc9wfpFHF5RDocpAEGuncVjd3Dps2HpEI8lih07s0p4oQ2FrN67f
         osEGTtzFj/Nt/tAswwLlMTqWHyBSK0FbtVkfRqFOGX7QzKpWAgu15VCQBYGUQoOtQfTM
         kYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779971; x=1698384771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xpTogBhloZZ3cgxOHAvGjGFV2B6QzeETWE0jVApmhU=;
        b=SWsA3AVFgyAdU1kpPT0DCOu+8LxHWZHbJbsHDeT/+FCQQBwpbRTfcW3Srh5/lQ/TVY
         /TKTAlvXFuFae8ENExqlcUlQ7jNk5+ZWHK+d2j/6eDIIWjGlfOdM0Lqm2QE92OTubzPh
         B2MK3EO0SclbU4ckoUZjef1bfpPgsgZnk15c3ccNNwgsE3wejZIoeBGswsuNyLC6cz0/
         odoLzx7HiV36Hc5/K15eP6wcgjMaH7LecK2xjKUc+/3QJH7jbhuPWKbsyhqWXjw0/IeL
         ljL9SUfdOfJwDOywapenVTdIz7gYmhVMVPyuI7Jan4jZJVmSTLJ2+fvwEMw+IAaowiNn
         g5vg==
X-Gm-Message-State: AOJu0Yzbqrx38/k745rkc2IFSGueJDinJQ72oFhEWEcqYmnjclsAh29R
        /EMRgqODkK9kWng2ByKp2eKGGQ==
X-Google-Smtp-Source: AGHT+IGSkCTT/zquQUwd3swviH/Fg+gESUjwa/1PtV2qfkXpbULyGWMHdHpXDFA8evkAJp9nQqvX3Q==
X-Received: by 2002:a05:620a:40c5:b0:778:8ce0:221a with SMTP id g5-20020a05620a40c500b007788ce0221amr824644qko.63.1697779971342;
        Thu, 19 Oct 2023 22:32:51 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id bq12-20020a05620a468c00b007678973eaa1sm356816qkb.127.2023.10.19.22.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:32:50 -0700 (PDT)
Date:   Thu, 19 Oct 2023 22:32:49 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v3 net-next 2/3] ipv6: refactor ip6_finish_output for GSO
 handling
Message-ID: <496ccff707e16e98163d2a3fbcfbc1f824fd8ec3.1697779681.git.yan@cloudflare.com>
References: <cover.1697779681.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697779681.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate GSO and non-GSO packets handling to make the logic cleaner. For
GSO packets, frag_max_size check can be omitted because it is only
useful for packets defragmented by netfilter hooks. Both local output
and GRO logic won't produce GSO packets when defragment is needed. This
also mirrors what IPv4 side code is doing.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ae87a3817d4a..3270d56b5c37 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -170,6 +170,16 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 	return ret;
 }
 
+static int ip6_finish_output_gso(struct net *net, struct sock *sk,
+				 struct sk_buff *skb, unsigned int mtu)
+{
+	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
+	    !skb_gso_validate_network_len(skb, mtu))
+		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
+
+	return ip6_finish_output2(net, sk, skb);
+}
+
 static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	unsigned int mtu;
@@ -183,16 +193,14 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 #endif
 
 	mtu = ip6_skb_dst_mtu(skb);
-	if (skb_is_gso(skb) &&
-	    !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
-		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
+	if (skb_is_gso(skb))
+		return ip6_finish_output_gso(net, sk, skb, mtu);
 
-	if ((skb->len > mtu && !skb_is_gso(skb)) ||
+	if (skb->len > mtu ||
 	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
-	else
-		return ip6_finish_output2(net, sk, skb);
+
+	return ip6_finish_output2(net, sk, skb);
 }
 
 static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
-- 
2.30.2


