Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131487D079F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346936AbjJTFc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbjJTFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:32:56 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E70D51
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:32:54 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b6d6773d05so173403241.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697779973; x=1698384773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QERO0uRdQXqqSaQdJAhee2LXGn28nhRHE84yn6ioXDc=;
        b=UCHRbXYL3xC0knyXFuBAsnyrkLGlT5t1Rqg+cpKWHrQednZoHGoTfiInP7UE+NCSFR
         wXSUe6Jwu7zzaVd3n85LoZnXW8+dqlE1Bhuxl3jPFfvL6x46DSNj9/D3DLF2LqmuCB9D
         tWbot+5hrUbZVTCTn349B4xeWIal6d8nHMFgT+1sGLA7ZjBc5ojYa5D9rR9B8t5ub5VW
         NV0+7zd6FNrsiehybQSpW6+JXRZkUN448cicU2ypFjj3plmy96MfLdNhMBjvLdQQpkcG
         wiKlBsYehe+nSW73EcWYNU+qIicC6wCqfKAZSWXlkk4Az0wwxr7oLzYz2pnDrUz+I0OD
         VnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697779973; x=1698384773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QERO0uRdQXqqSaQdJAhee2LXGn28nhRHE84yn6ioXDc=;
        b=aqQ+LsCZoMiYLBEGsYOTp+vGHqfqYecB+bporfHrgE8OZSC7976KFkEMSRumIjNJYG
         t4WpeH9zbLKsJJKk8O5V4KwCJbopmTFd6NeAvBw7GCf5Sym8EVQAxvY3SI1k5sx2NGc2
         YohNR+8JdUn1g1qoAgWkz2KZENYCPdBNQLdK0X3F09XzLsWxYMLbowF3zkz76Phz49qY
         JAnGAxlN2pdmfmMXQYT10qtHMyTsShpjnAG2p8zqS0y16ulTxzAH0r5HEEZEqLNrjstd
         dE2/56xE1SphCBiXB53fK70i/9FyoGTjalE6pVrfb2hDzFCHx40T20d6S06XnjmOhIpg
         GctQ==
X-Gm-Message-State: AOJu0YxiDwRHEwcEZltAN6po6lp/lGU/+Y8jRwlXGLuWAeMWDF/Mwgy1
        Q231svhk+SYt9Ffn86a5yuf2HA==
X-Google-Smtp-Source: AGHT+IEuHUJNvQq/HPA6H9apAJz8f05F78aDSMAqahV84NRcnvPy5dpCqHEpkhIlb+0srBHZfqHiYw==
X-Received: by 2002:a67:ae05:0:b0:452:5798:64bd with SMTP id x5-20020a67ae05000000b00452579864bdmr920744vse.35.1697779973258;
        Thu, 19 Oct 2023 22:32:53 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id vq6-20020a05620a558600b0076e672f535asm359098qkn.57.2023.10.19.22.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 22:32:52 -0700 (PDT)
Date:   Thu, 19 Oct 2023 22:32:51 -0700
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
Subject: [PATCH v3 net-next 3/3] ipv6: avoid atomic fragment on GSO packets
Message-ID: <77423bb774612f0e8eaabfd9501d03389ff2cdbd.1697779681.git.yan@cloudflare.com>
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
index 3270d56b5c37..3d4e8edaa10b 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -162,7 +162,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
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


