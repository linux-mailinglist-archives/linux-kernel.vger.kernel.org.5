Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6B7D53F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343768AbjJXO0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbjJXO0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:26:43 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD49129
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:41 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2f4a5ccebso3062702b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698157600; x=1698762400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANWtBi2MdCaxrrm0KgoW1Ul1Iz1M5CJm2G0yJPXRo30=;
        b=OrnhSMSdnKPjUG1TT6wTvS5HRvmsZ9hWsPtUMTg6VK65BsAxIb3Gkks1OcNzP2K+ow
         qtXqofVsB40pAhadA03cDCKXbiwzsCt8d0OuZKJsjYArGw9/WfRJFCmqcVzXpzu4f3xl
         g5hXAEnhPe0ZuM7a9KTP784W8jISd0D0zAIETr4g4j1IcvirURdEhbCbVlTT+xJbhzM6
         KeZ2WlSHSftRzEN4HsFKWn94vcifxduJT8Kb6AQA80ReNl9Zmcfaxt1+fH3Z7Za8gOht
         q4MkavJpxMktMppkz+okCLpkSkO+LIw7uMt5i0s88ZKFLTLAioEp3u34B/XBWIwWWrA7
         ZcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157600; x=1698762400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANWtBi2MdCaxrrm0KgoW1Ul1Iz1M5CJm2G0yJPXRo30=;
        b=I7FAlfcxf1vpdR1wh82QRJRpnH9mQHFxD/xu/G/rUQIg8lwbPbpoJcbb8zwqnrh0hg
         KCEWN8hKCuZQrG4lAiHnxKg909l1FQijs0wxUyehnOhVoakml0ucruw2Euy9TDJXh01a
         JCnculg4i6f+3haNmIVhuaX5MomEJZCSo/rCxZjpEteiSr6KuVZX8jt8E09T6Nfa7kUS
         M+o/uqp9a6msaE7bF7P3A86yL5SDElHVl3KlgMxJdQdcZueGHG2j0tG136/5n4/S+0BD
         8ymRmZEAx4Co6fD5ggBoiztlTM/dD1PbrdJw4XHcTx1UrkTVtX8XRGJUhXQRVYHR+nqG
         Dhew==
X-Gm-Message-State: AOJu0YwwlIftCLZ7b79R0rG8+fJxltJAVivDLzBYVdNiW2DrNuptDVup
        wngIv2E8hqsODLd+RiNyTk49Fw==
X-Google-Smtp-Source: AGHT+IGJ8RdODPXrpuAh5/kXjL5m8Ext5pjgkWa9Kz6JhFQNZqRIsLHPw7wMgpaO01nVJq74fjQcww==
X-Received: by 2002:a05:6870:7e0d:b0:1ea:29cc:d2dc with SMTP id wx13-20020a0568707e0d00b001ea29ccd2dcmr15920283oab.11.1698157600641;
        Tue, 24 Oct 2023 07:26:40 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id kr25-20020ac861d9000000b004181c32dcc3sm3487025qtb.16.2023.10.24.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:26:40 -0700 (PDT)
Date:   Tue, 24 Oct 2023 07:26:37 -0700
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
Subject: [PATCH v5 net-next 2/3] ipv6: refactor ip6_finish_output for GSO
 handling
Message-ID: <0e1d4599f858e2becff5c4fe0b5f843236bc3fe8.1698156966.git.yan@cloudflare.com>
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

Separate GSO and non-GSO packets handling to make the logic cleaner. For
GSO packets, frag_max_size check can be omitted because it is only
useful for packets defragmented by netfilter hooks. Both local output
and GRO logic won't produce GSO packets when defragment is needed. This
also mirrors what IPv4 side code is doing.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/ip6_output.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 86efd901ee5a..4010dd97aaf8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -172,6 +172,16 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
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
@@ -185,16 +195,14 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
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


