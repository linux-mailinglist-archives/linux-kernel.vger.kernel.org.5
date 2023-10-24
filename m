Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D27D53FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjJXO0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjJXO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:26:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DF12C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7788ebea620so298807185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698157604; x=1698762404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6S93RbRglo4zJtt34VMTicjVThmJc0ap31UZOgLJcsE=;
        b=d3i0xTrtHY7fyNjAnemlo9hK6NiX9t3PE31O1zWq9PgxcDRJqY1q9oMNBafmkdCxgk
         0XG+xpmDScIs8nxH+oOpTD+6eI1p2wLTjzvH2Sd56yxz1Ue0lfAtGjCSGQ7skl9ldEGZ
         +HXu/IFuD0LmkZHj74zLH8g++vRotkEacJ5c3sPDCGJFjX7H4NkR5/X6KgFP0x91pSwN
         Z5NP9/u/l2BKIm6D6AXwt+oFLMRGt9mijYipuDlMM+Bk9uoWDbxsvcqaOxn90fmDHHY9
         reFmWU0jrLsHlDKGDMrEo6cXWq7bSgDQ8M2DH20mWqPKUYaCkzAuyLrHvt9yNtxOJPlw
         6S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157604; x=1698762404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6S93RbRglo4zJtt34VMTicjVThmJc0ap31UZOgLJcsE=;
        b=oXn6PjzyHlDdTbtB4PYct35+0Rh/LQkyakYdvRgie+PwdZEoifzJCFnnqckK69S2kt
         q+lFK0V01WTLy3m2eiSWf/92+Uy2o0Kf6V6IFHR7k06JgjXTr+ug0DM+Ho9hUCl+rHy/
         k9bnekSGtF9+8qfqoUbAB5o2e3iKz+1V2jckoX7gvU9Fu0drtqh3TNq08lc2kgKQk+Zk
         4Wunu2PLFb07X3rwf/qWcXlzyXX/W+ChbtA9A2RJkdEo+cIF5KQY+6fuVR8IoWYGMeoT
         Wky23++nx0UMThJ1y0QJ7Lf6FemU+2k41bNSpi2hR3QpRNtul9YdLhn7wXubjAXkvf4h
         4L+A==
X-Gm-Message-State: AOJu0YyS1GGWZpJK5t2wlcuNNjd3418ylSLXmVPTf6O1mG50WQ+U9wPX
        o+wYeg9UWueq3EWePAlrTeXQtQ==
X-Google-Smtp-Source: AGHT+IGqmc9ObazHQIcORgt1GoGM9BTANTeWFmH8pIDBj9tAeDXqR61l4QBgrP+2+N2QECvBi+MYyg==
X-Received: by 2002:a05:620a:d96:b0:767:c572:ab10 with SMTP id q22-20020a05620a0d9600b00767c572ab10mr13854304qkl.35.1698157604465;
        Tue, 24 Oct 2023 07:26:44 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id l15-20020a05620a0c0f00b0077892023fc5sm3466575qki.120.2023.10.24.07.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:26:43 -0700 (PDT)
Date:   Tue, 24 Oct 2023 07:26:40 -0700
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
Subject: [PATCH v5 net-next 3/3] ipv6: avoid atomic fragment on GSO packets
Message-ID: <90912e3503a242dca0bc36958b11ed03a2696e5e.1698156966.git.yan@cloudflare.com>
References: <cover.1698156966.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698156966.git.yan@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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


