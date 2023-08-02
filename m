Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8276D769
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjHBTHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHBTHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FAE7D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A80161AAD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7076C433C8;
        Wed,  2 Aug 2023 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691003263;
        bh=0fw6RB4gYXf7dceIN213tkWhaI9QCwIhhC6CY/ovsZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLoWgvI7Wfc1z5MbADnwrre/gZrBEzzYkQ98VW6w1AK4+i4MlEerhiIEuQ6Qphjl9
         z9lrNgxBBjtmMUOg2BiDxEv1XZ0wgclHVPk465EJkF9gVGwIG6MtdXE6taVIH40kgK
         o0gwoLjrCscKlmriV823PmrKraMihUsGJjNcaiPze8D8TfazRgi+hvYdauVmdW2HK3
         9GKYQUOccnp2oHrtcSmpYUrYCXsFixtxSNg3Dml+s9HX5VBzYsdPfXcIZqF38Z/q2c
         IMSCRn1/IshFV/qJzWDST1gKERY86wtmGOOccsTHSuyw43pgub8oBuW3EPRZY0NgJj
         CS6/z+xoR8pkw==
Date:   Wed, 2 Aug 2023 21:07:35 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us
Subject: Re: [PATCH v1 net-next 2/4] tc: flower: support for SPI
Message-ID: <ZMqpd2DyHz4O/v17@kernel.org>
References: <20230801014101.2955887-1-rkannoth@marvell.com>
 <20230801014101.2955887-3-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801014101.2955887-3-rkannoth@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dan Carpenter

On Tue, Aug 01, 2023 at 07:10:59AM +0530, Ratheesh Kannoth wrote:
> tc flower rules support to classify ESP/AH
> packets matching SPI field.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  include/uapi/linux/pkt_cls.h |  3 +++
>  net/sched/cls_flower.c       | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 7865f5a9885b..75506f157340 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -598,6 +598,9 @@ enum {
>  
>  	TCA_FLOWER_KEY_CFM,		/* nested */
>  
> +	TCA_FLOWER_KEY_SPI,		/* be32 */
> +	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
> +
>  	__TCA_FLOWER_MAX,
>  };
>  
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 8da9d039d964..eca260272845 100644
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
> @@ -795,6 +798,24 @@ static void fl_set_key_val(struct nlattr **tb,
>  		nla_memcpy(mask, tb[mask_type], len);
>  }
>  
> +static int fl_set_key_spi(struct nlattr **tb, struct fl_flow_key *key,
> +			  struct fl_flow_key *mask,
> +			  struct netlink_ext_ack *extack)
> +{
> +	if (key->basic.ip_proto != IPPROTO_ESP &&
> +	    key->basic.ip_proto != IPPROTO_AH) {
> +		NL_SET_ERR_MSG(extack,
> +			       "Protocol must be either ESP or AH");
> +		return -EINVAL;
> +	}
> +
> +	fl_set_key_val(tb, &key->ipsec.spi,
> +		       TCA_FLOWER_KEY_SPI,
> +		       &mask->ipsec.spi, TCA_FLOWER_KEY_SPI_MASK,
> +		       sizeof(key->ipsec.spi));
> +	return 0;
> +}
> +
>  static int fl_set_key_port_range(struct nlattr **tb, struct fl_flow_key *key,
>  				 struct fl_flow_key *mask,
>  				 struct netlink_ext_ack *extack)
> @@ -1894,6 +1915,12 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
>  			return ret;
>  	}
>  
> +	if (tb[TCA_FLOWER_KEY_SPI]) {
> +		ret = fl_set_key_spi(tb, key, mask, extack);
> +		if (ret)
> +			return ret;
> +	}
> +

Hi Dan,

I'm seeing a warning from Smatch, which I think is a false positive,
but I feel that I should raise. Perhaps you could take a look at it?

net/sched/cls_flower.c:1918 fl_set_key() error: buffer overflow 'tb' 106 <= 108

>  	if (tb[TCA_FLOWER_KEY_ENC_IPV4_SRC] ||
>  	    tb[TCA_FLOWER_KEY_ENC_IPV4_DST]) {
>  		key->enc_control.addr_type = FLOW_DISSECTOR_KEY_IPV4_ADDRS;
> @@ -2066,6 +2093,8 @@ static void fl_init_dissector(struct flow_dissector *dissector,
>  			     FLOW_DISSECTOR_KEY_PPPOE, pppoe);
>  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
>  			     FLOW_DISSECTOR_KEY_L2TPV3, l2tpv3);
> +	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
> +			     FLOW_DISSECTOR_KEY_IPSEC, ipsec);
>  	FL_KEY_SET_IF_MASKED(mask, keys, cnt,
>  			     FLOW_DISSECTOR_KEY_CFM, cfm);
>  
> @@ -3364,6 +3393,12 @@ static int fl_dump_key(struct sk_buff *skb, struct net *net,
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
