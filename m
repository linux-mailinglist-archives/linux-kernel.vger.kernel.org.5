Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6707D4595
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjJXCf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJXCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:35:46 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B110C3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:35:40 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77774120c6eso259524785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698114939; x=1698719739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6S93RbRglo4zJtt34VMTicjVThmJc0ap31UZOgLJcsE=;
        b=WCu9otX47GCdVRdugIJIAODwuN1dOZ9H2eEAtQfYrgUmi2E9JeCLwzPF9328sqKmM7
         RdXiUp/zbaF1EgGI/YQT39EY5C64RCCiqM6ztsE1SE4J2ZkWT6e54ghifIPsFHHS1e/g
         bC1hUwswNLjBiw4FkvBN20kAz5K9pIdbW3EUNMIWbpvIohA3HlQp893nJGEtp3j/BSE9
         0Uj/MPZ7Tg2ppgri9wn5LVowrgCZrr/6rczgvFTtx11L6vtw2v70aFEEY92OwUfGkDAc
         nXjt8OkTaT0zQQPrMYw53MCntTldvVX2t8RBeKCA0sHftL9TPi/itqIUOw3E77n2gAkM
         Gnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114939; x=1698719739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S93RbRglo4zJtt34VMTicjVThmJc0ap31UZOgLJcsE=;
        b=PrFEi7KJhFEVrG+Cs+epmD0bMwxMeGNgsVn82GVad6lavHC6sl5XpJNaE3rM6aulwQ
         vJvdZytP1VMW5l6K6f6rWjsUizcayXF6hygtaxQxNGCF6VDBkg92EuQ890ftgihLAQvJ
         LM372vCzCzPezm3vtiadF0iEtWmgBUVpukqTf2QoWsCAVM9qzikNyK0wNCaMd5fabzn3
         2UcHFwe/WPMHcAq5xVXCoiu1XvSdxhcvJnU4+6bFjdum30pSgft8yodHcgnquJVvu5b3
         SJFHmtylHxv3JtlIcA+uTS+Pn40aVVC4mgDQ+0DWOVi/gq+Kp7BY1UdZSmcWuROPc0w+
         IWIg==
X-Gm-Message-State: AOJu0YxU98KNvwfctunEcK7AO1VPuFd8TUQyMOoEYK0Uewe98lwoKCYc
        BK2gWCXdUZOGKSyNxWgR+dLUwg==
X-Google-Smtp-Source: AGHT+IFeSNLxbbaTEz7kuBUXmZKSLILtgAtkYjWmUsJsYLJo9qtUUPYsz1aa129SuvLRTlepJgm2LQ==
X-Received: by 2002:a05:620a:24cb:b0:775:9e64:f5be with SMTP id m11-20020a05620a24cb00b007759e64f5bemr12393344qkn.55.1698114939293;
        Mon, 23 Oct 2023 19:35:39 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e6-20020a05620a208600b007742218dc42sm3122060qka.119.2023.10.23.19.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:35:38 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:35:37 -0700
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
Subject: [PATCH v4 net-next 3/3] ipv6: avoid atomic fragment on GSO packets
Message-ID: <6b2347a888c8b2d8f259dbb4662c4995ba9a505e.1698114636.git.yan@cloudflare.com>
References: <cover.1698114636.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698114636.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ipv6 stack output a GSO packet, if its gso_size is larger than
dst MTU, then all segments would be fragmented. However, it is possible
for a GSO packet to have a trailing segment with smaller actual size
than both gso_size as well as the MTU, which leads to an "atomic
fragment". Atomic fragments are considered harmful in RFC-8021. An
Existing report from APNIC also shows that atomic fragments are more
likely to be dropped even it is equivalent to a no-op [1].

Add an extra check in the GSO slow output path. For each segment from
the original over-sized packet, if it fits with the path MTU, then avoid
generating an atomic fragment.

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
Reported-by: David Wragg <dwragg@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4010dd97aaf8..a722a43dd668 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -164,7 +164,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last GSO segment can be smaller than gso_size (and MTU).
+		 * Adding a fragment header would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021). Avoid that.
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
 		if (err && ret == 0)
 			ret = err;
 	}
-- 
2.30.2


