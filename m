Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A19A758788
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGRV5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGRV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:57:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98097198D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF05611E1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB83C433C8;
        Tue, 18 Jul 2023 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689717421;
        bh=Wo4I4cr9gdcSh0tE9VozsMVfVY5BjPp2OtQmdbI2bgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SRaR7TUrsVM04PiUfqWevP4oNgJsftX3cNM2tGjYhpRYWg2t3HOq+v4YkGMe8VfbN
         NzNw/TpIFaH48d7pVVVSe96rATGxmryJ65ZPkMA+l7e/PmkkkepzMszlLDpR7vM43F
         Ll72D7Adw1Wt3UEMWcuhl/CH+pBv7HTI73vkMuUT+UqlF5sJxDx9vcpAJc9AZWwqHd
         1vgmNN04mhrh9Vqdt+SNtoAmI6aBGqg8D7/HRhQfsjya4Kx8I/NHM3qvTasW0/OSKd
         IYJ0SQR+ik/p5485M5P4aE5wB1Wz2paF+M3B0Ix819vad8dObIhLaXYz9Ppm+Mh6vN
         j/Oj0TFk8u09Q==
Date:   Tue, 18 Jul 2023 14:57:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230718145700.5d6f766d@kernel.org>
In-Reply-To: <CABWYdi2BGi=iRCfLhmQCqO=1eaQ1WaCG7F9WsJrz-7==ocZidg@mail.gmail.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
        <20230711193612.22c9bc04@kernel.org>
        <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
        <20230712104210.3b86b779@kernel.org>
        <CABWYdi3VJU7HUxzKJBKgX9wF9GRvmA0TKVpjuHvJyz_EdpxZFA@mail.gmail.com>
        <20230713201427.2c50fc7b@kernel.org>
        <CABWYdi2BGi=iRCfLhmQCqO=1eaQ1WaCG7F9WsJrz-7==ocZidg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 16:21:08 -0700 Ivan Babrou wrote:
> > Just the stacks.  
> 
> Here you go: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/

Thanks! I'll follow the discussion there. Just the one remaining
clarification here:

> > > Even if I was only interested in one specific reason, I would still
> > > have to arm the whole tracepoint and route a ton of skbs I'm not
> > > interested in into my bpf code. This seems like a lot of overhead,
> > > especially if I'm dropping some attack packets.  
> >
> > That's what I meant with my drop vs exception comment. We already have
> > two tracepoints on the skb free path (free and consume), adding another
> > shouldn't rise too many eyebrows.  
> 
> I'm a bit confused. Previously you said:
> 
> > Specifically what I'm wondering is whether we should also have
> > a separation between policy / "firewall drops" and error / exception
> > drops. Within the skb drop reason codes, I mean.  
> 
> My understanding was that you proposed adding more SKB_DROP_REASON_*,
> but now you seem to imply that we might want to add another
> tracepoint. Could you clarify which path you have in mind?

What I had in mind was sorting the drop reasons to be able to easily
distinguish policy drops from error drops.

> We can add a few reasons that would satisfy my need by covering
> whatever results into tcp_listendrop() calls today. The problem is:
> unless we remove some other reasons from kfree_skb, adding more
> reasons for firewall drops / exceptions wouldn't change the cost at
> all. We'd still have the same number of calls into the tracepoint and
> the condition to find "interesting" reasons would be the same:
> 
> if (reason == SKB_DROP_REASON_TCP_OVERFLOW_OR_SOMETHING)
> 
> It still seems very expensive to consume a firehose of kfree_skb just
> to find some rare nuggets.

Let me show you a quick mock-up of a diff:

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index a2b953b57689..86ee70fcf540 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -5,12 +5,18 @@
 
 #define DEFINE_DROP_REASON(FN, FNe)	\
 	FN(NOT_SPECIFIED)		\
+	/* Policy-driven/intentional drops: */	\
+	FN(NETFILTER_DROP)		\
+	FN(BPF_CGROUP_EGRESS)		\
+	FN(TC_INGRESS)			\
+	FN(TC_EGRESS)			\
+	FN(XDP)				\
+	/* Errors: */			\
 	FN(NO_SOCKET)			\
 	FN(PKT_TOO_SMALL)		\
 	FN(TCP_CSUM)			\
 	FN(SOCKET_FILTER)		\
 	FN(UDP_CSUM)			\
-	FN(NETFILTER_DROP)		\
 	FN(OTHERHOST)			\
 	FN(IP_CSUM)			\
 	FN(IP_INHDR)			\
@@ -41,17 +47,13 @@
 	FN(TCP_OFO_QUEUE_PRUNE)		\
 	FN(TCP_OFO_DROP)		\
 	FN(IP_OUTNOROUTES)		\
-	FN(BPF_CGROUP_EGRESS)		\
 	FN(IPV6DISABLED)		\
 	FN(NEIGH_CREATEFAIL)		\
 	FN(NEIGH_FAILED)		\
 	FN(NEIGH_QUEUEFULL)		\
 	FN(NEIGH_DEAD)			\
-	FN(TC_EGRESS)			\
 	FN(QDISC_DROP)			\
 	FN(CPU_BACKLOG)			\
-	FN(XDP)				\
-	FN(TC_INGRESS)			\
 	FN(UNHANDLED_PROTO)		\
 	FN(SKB_CSUM)			\
 	FN(SKB_GSO_SEG)			\
@@ -80,6 +82,8 @@
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FNe(MAX)
 
+#define	__SKB_POLICY_DROP_END	SKB_DROP_REASON_NO_SOCKET
+
 /**
  * enum skb_drop_reason - the reasons of skb drops
  *
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6c5915efbc17..a36c498eb693 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1031,6 +1031,8 @@ bool __kfree_skb_reason(struct sk_buff *skb, enum skb_drop_reason reason)
 
 	if (reason == SKB_CONSUMED)
 		trace_consume_skb(skb, __builtin_return_address(0));
+	else if (reason < __SKB_POLICY_DROP_END)
+		trace_drop_skb(skb, __builtin_return_address(0), reason);
 	else
 		trace_kfree_skb(skb, __builtin_return_address(0), reason);
 	return true;
