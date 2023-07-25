Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456FA760912
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGYFMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGYFMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096FF171E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 770CD61526
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EF5C433C7;
        Tue, 25 Jul 2023 05:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690261922;
        bh=o4tAA6epNSPCuaR+b7SiG4Fd+cnPUOgYF9o/2OUaee8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntTD5lziDYeAlPaLsZkUueuFUbrJRXlgDMjMBdyFUKIdBIQUgweSuiat38Tgieg79
         IgaK8y9ysnSt7oQbbe+ER3qf+CQ43AW33MUFhJvo7pnotxefag5BYr8eHYEmyPQNuF
         +7NDXsyaqj/bdBeFlXkLfCRL92MMybXJTla4I9xq9yofijwNoIPinSw9+nTedWxtuh
         P41x6ZAx8qH72lvYpYUK3T57qMJ/WkNOeBH166T0m2SDeM9I+dV6sFiMXUk+7jCvls
         u5EqTnKiS7f/7r3kZM+lwNGsWswPpt6Phgw3iN5e++owR7sDF+APhoP1ZPItaTxeE8
         D/BBKVOgzTzAw==
Date:   Tue, 25 Jul 2023 08:11:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next] flow_dissector: Add IPSEC dissectors
Message-ID: <20230725051158.GG11388@unreal>
References: <20230725032451.505189-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725032451.505189-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:54:51AM +0530, Ratheesh Kannoth wrote:
>  Support for dissecting IPSEC field SPI (which is
>  32bits in size) for ESP and AH packets.

Please don't add extra space in the beginning of lines.

> 
>  This implementation does not support NAT-T
>  (encapsulation of ESP packets over UDP).

And how will user distinguish kernel which supports flow_dissector with
NAT-T vs. without NAT-T?

> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  include/net/flow_dissector.h |  9 ++++++
>  include/net/flow_offload.h   |  6 ++++
>  include/uapi/linux/pkt_cls.h |  3 ++
>  net/core/flow_dissector.c    | 53 +++++++++++++++++++++++++++++++++++-
>  net/core/flow_offload.c      |  7 +++++
>  net/sched/cls_flower.c       | 18 ++++++++++++
>  6 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
> index 8664ed4fbbdf..ffec739f049a 100644
> --- a/include/net/flow_dissector.h
> +++ b/include/net/flow_dissector.h
> @@ -301,6 +301,14 @@ struct flow_dissector_key_l2tpv3 {
>  	__be32 session_id;
>  };
>  
> +/**
> + * struct flow_dissector_key_ipsec:
> + * @spi: identifier for a ipsec connection
> + */
> +struct flow_dissector_key_ipsec {
> +	__be32 spi;
> +};
> +
>  /**
>   * struct flow_dissector_key_cfm
>   * @mdl_ver: maintenance domain level (mdl) and cfm protocol version
> @@ -353,6 +361,7 @@ enum flow_dissector_key_id {
>  	FLOW_DISSECTOR_KEY_NUM_OF_VLANS, /* struct flow_dissector_key_num_of_vlans */
>  	FLOW_DISSECTOR_KEY_PPPOE, /* struct flow_dissector_key_pppoe */
>  	FLOW_DISSECTOR_KEY_L2TPV3, /* struct flow_dissector_key_l2tpv3 */
> +	FLOW_DISSECTOR_KEY_IPSEC, /* struct flow_dissector_key_ipsec */
>  	FLOW_DISSECTOR_KEY_CFM, /* struct flow_dissector_key_cfm */
>  
>  	FLOW_DISSECTOR_KEY_MAX,
> diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
> index 118082eae48c..9efa9a59e81f 100644
> --- a/include/net/flow_offload.h
> +++ b/include/net/flow_offload.h
> @@ -64,6 +64,10 @@ struct flow_match_tcp {
>  	struct flow_dissector_key_tcp *key, *mask;
>  };
>  
> +struct flow_match_ipsec {
> +	struct flow_dissector_key_ipsec *key, *mask;
> +};
> +
>  struct flow_match_mpls {
>  	struct flow_dissector_key_mpls *key, *mask;
>  };
> @@ -116,6 +120,8 @@ void flow_rule_match_ports_range(const struct flow_rule *rule,
>  				 struct flow_match_ports_range *out);
>  void flow_rule_match_tcp(const struct flow_rule *rule,
>  			 struct flow_match_tcp *out);
> +void flow_rule_match_ipsec(const struct flow_rule *rule,
> +			   struct flow_match_ipsec *out);
>  void flow_rule_match_icmp(const struct flow_rule *rule,
>  			  struct flow_match_icmp *out);
>  void flow_rule_match_mpls(const struct flow_rule *rule,
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 7865f5a9885b..a90b0e3d351f 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -594,6 +594,9 @@ enum {
>  
>  	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
>  
> +	TCA_FLOWER_KEY_SPI,		/* be32 */
> +	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
> +
>  	TCA_FLOWER_L2_MISS,		/* u8 */
>  
>  	TCA_FLOWER_KEY_CFM,		/* nested */
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 85a2d0d9bd39..7162594d7940 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -205,6 +205,50 @@ static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
>  	skb_flow_get_icmp_tci(skb, key_icmp, data, thoff, hlen);
>  }
>  
> +static void __skb_flow_dissect_ah(const struct sk_buff *skb,
> +				  struct flow_dissector *flow_dissector,
> +				  void *target_container, const void *data,
> +				  int nhoff, int hlen)
> +{
> +	struct flow_dissector_key_ipsec *key_ah;
> +	struct ip_auth_hdr _hdr, *hdr;

In tunnel mode, this struct is ip_esp_hdr and not ip_auth_hdr.

Thanks

> +
> +	if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_IPSEC))
> +		return;
> +
> +	hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
> +	if (!hdr)
> +		return;
> +
> +	key_ah = skb_flow_dissector_target(flow_dissector,
> +					   FLOW_DISSECTOR_KEY_IPSEC,
> +					   target_container);
> +
> +	key_ah->spi = hdr->spi;
> +}
> +
> +static void __skb_flow_dissect_esp(const struct sk_buff *skb,
> +				   struct flow_dissector *flow_dissector,
> +				   void *target_container, const void *data,
> +				   int nhoff, int hlen)
> +{
> +	struct flow_dissector_key_ipsec *key_esp;
> +	struct ip_esp_hdr _hdr, *hdr;
> +
> +	if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_IPSEC))
> +		return;
> +
> +	hdr = __skb_header_pointer(skb, nhoff, sizeof(_hdr), data, hlen, &_hdr);
> +	if (!hdr)
> +		return;
> +
> +	key_esp = skb_flow_dissector_target(flow_dissector,
> +					    FLOW_DISSECTOR_KEY_IPSEC,
> +					    target_container);
> +
> +	key_esp->spi = hdr->spi;
> +}
> +
>  static void __skb_flow_dissect_l2tpv3(const struct sk_buff *skb,
>  				      struct flow_dissector *flow_dissector,
>  				      void *target_container, const void *data,
> @@ -1571,7 +1615,14 @@ bool __skb_flow_dissect(const struct net *net,
>  		__skb_flow_dissect_l2tpv3(skb, flow_dissector, target_container,
>  					  data, nhoff, hlen);
>  		break;
> -
> +	case IPPROTO_ESP:
> +		__skb_flow_dissect_esp(skb, flow_dissector, target_container,
> +				       data, nhoff, hlen);
> +		break;
> +	case IPPROTO_AH:
> +		__skb_flow_dissect_ah(skb, flow_dissector, target_container,
> +				      data, nhoff, hlen);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
> index acfc1f88ea79..bc5169482710 100644
> --- a/net/core/flow_offload.c
> +++ b/net/core/flow_offload.c
> @@ -146,6 +146,13 @@ void flow_rule_match_tcp(const struct flow_rule *rule,
>  }
>  EXPORT_SYMBOL(flow_rule_match_tcp);
>  
> +void flow_rule_match_ipsec(const struct flow_rule *rule,
> +			   struct flow_match_ipsec *out)
> +{
> +	FLOW_DISSECTOR_MATCH(rule, FLOW_DISSECTOR_KEY_IPSEC, out);
> +}
> +EXPORT_SYMBOL(flow_rule_match_ipsec);
> +
>  void flow_rule_match_icmp(const struct flow_rule *rule,
>  			  struct flow_match_icmp *out)
>  {
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 8da9d039d964..7ba839057d3c 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -72,6 +72,7 @@ struct fl_flow_key {
>  	struct flow_dissector_key_num_of_vlans num_of_vlans;
>  	struct flow_dissector_key_pppoe pppoe;
>  	struct flow_dissector_key_l2tpv3 l2tpv3;
> +	struct flow_dissector_key_ipsec ipsec;
>  	struct flow_dissector_key_cfm cfm;
>  } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
>  
> @@ -726,6 +727,8 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
>  	[TCA_FLOWER_KEY_PPPOE_SID]	= { .type = NLA_U16 },
>  	[TCA_FLOWER_KEY_PPP_PROTO]	= { .type = NLA_U16 },
>  	[TCA_FLOWER_KEY_L2TPV3_SID]	= { .type = NLA_U32 },
> +	[TCA_FLOWER_KEY_SPI]		= { .type = NLA_U32 },
> +	[TCA_FLOWER_KEY_SPI_MASK]	= { .type = NLA_U32 },
>  	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
>  	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
>  };
> @@ -1894,6 +1897,13 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
>  			return ret;
>  	}
>  
> +	if (tb[TCA_FLOWER_KEY_SPI]) {
> +		fl_set_key_val(tb, &key->ipsec.spi,
> +			       TCA_FLOWER_KEY_SPI,
> +			       &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
> +			       sizeof(key->ipsec.spi));
> +	}
> +
>  	if (tb[TCA_FLOWER_KEY_ENC_IPV4_SRC] ||
>  	    tb[TCA_FLOWER_KEY_ENC_IPV4_DST]) {
>  		key->enc_control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
> @@ -2066,6 +2076,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
>  			     FLOW_DISSECTOR_KEY_PPPOE, pppoe);
>  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
>  			     FLOW_DISSECTOR_KEY_L2TPV3, l2tpv3);
> +	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
> +			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
>  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
>  			     FLOW_DISSECTOR_KEY_CFM, cfm);
>  
> @@ -3364,6 +3376,12 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
>  				 sizeof(key->l2tpv3.session_id)))
>  		goto nla_put_failure;
>  
> +	if (key->ipsec.spi &&
> +	    fl_dump_key_val(skb, &key->ipsec.spi, TCA_FLOWER_KEY_SPI,
> +			    &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
> +			    sizeof(key->ipsec.spi)))
> +		goto nla_put_failure;
> +
>  	if ((key->basic.ip_proto == IPPROTO_TCP ||
>  	     key->basic.ip_proto == IPPROTO_UDP ||
>  	     key->basic.ip_proto == IPPROTO_SCTP) &&
> -- 
> 2.25.1
> 
> 
