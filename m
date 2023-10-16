Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6415C7CB4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjJPVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjJPVAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:00:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E6EA;
        Mon, 16 Oct 2023 14:00:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so2062745a12.1;
        Mon, 16 Oct 2023 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697490031; x=1698094831; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vqMEI5McRYBRcnY5DsFznYEwtiSp0zmUfYkNsrVqgKw=;
        b=FyOQ7rPMYQkApDdPaGrt+kSd0xNOqGOvadz4nloCIwFWP/tpZvEr2WdYjzRbVNmQgI
         7+hAaBFciO6vD6RwUx36GQrFQzRUamFzfUyqBp6iKOBMHonvPDVSKNLaLM75cKNF7EV1
         RL1+49tCbRmTbo5zj9pQViUh6sMsNtB1wh8YnKIcyvvwfvvhhc6EMtz1WXDMobBTlAEX
         XJzVQKXXBj4utg76pKs8NRG5Ub3CdjHtTmpQ/vE8KpPA2ESsMXjPOinLNRT3aqC+d9xo
         VoQ0PMB2kx5MFyEvMW/0di19T6m39z5WcW05cS4RS5Hs2pMzGjckzw1RmKUdJeGVna9K
         LFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490031; x=1698094831;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqMEI5McRYBRcnY5DsFznYEwtiSp0zmUfYkNsrVqgKw=;
        b=hg46xJ916NUVygBqyJOXGYikRDObwji+B5mjzD/XD5Hl2sb4+pZD7tz7VaKVpv/Hox
         tgeCtiMaQv4uFXzV3EA+Tk391vJnB0bUn6MpfEfS3+/vEPowNMkW8e/cMwiEb3rsgFYC
         OzNg+UyCqZqkAwDbMgP8Gpylvd9GZa8MudLWOiwqJWWA3u41kfdlcteAvWyjxKCdEX3R
         5WQnQjTZXCN4RkG2Cd1hFKhvAo15KwANZ9xMv0KFzwZ7hsIgkCOBQkjwnPgTiBHMNyNn
         qLrhs7jen2HQp1TE5skjyClUnPVFCt8C6w+aCuj0c4XaBc4THIPn6Gfs07liNdoH9llf
         hfjA==
X-Gm-Message-State: AOJu0YyLSaX2F7Pz7LpLW2y4wLRFRI8I2EASSc3raU5fI2DlgTQSe7NR
        J7fvyP0oyue4Ye7KEIrrjIs=
X-Google-Smtp-Source: AGHT+IFpxtTmo5zETULmEFXR0xJgMtt8BaoJCOGg64yhQHehPYoERy+TYHT3AmhC6YNl6sBu/GDLNg==
X-Received: by 2002:a17:90b:2b47:b0:27d:27a7:b0b8 with SMTP id rr7-20020a17090b2b4700b0027d27a7b0b8mr319787pjb.13.1697490030664;
        Mon, 16 Oct 2023 14:00:30 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id z92-20020a17090a6d6500b0026801e06ac1sm43707pjj.30.2023.10.16.14.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:00:30 -0700 (PDT)
Message-ID: <4c524eba575992cc1adfc41b2b230835946b126c.camel@gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
From:   Alexander H Duyck <alexander.duyck@gmail.com>
To:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 16 Oct 2023 14:00:28 -0700
In-Reply-To: <ZS1/qtr0dZJ35VII@debian.debian>
References: <ZS1/qtr0dZJ35VII@debian.debian>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 11:23 -0700, Yan Zhai wrote:
> GSO packets can contain a trailing segment that is smaller than
> gso_size. When examining the dst MTU for such packet, if its gso_size is
> too large, then all segments would be fragmented. However, there is a
> good chance the trailing segment has smaller actual size than both
> gso_size as well as the MTU, which leads to an "atomic fragment". It is
> considered harmful in RFC-8021. An Existing report from APNIC also shows
> that atomic fragments are more likely to be dropped even it is
> equivalent to a no-op [1].
>=20
> Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> processing. It mirrors __ip_finish_output logic now. Add an extra check
> in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> sending PTB packets for MTU < 1280").
>=20
> Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
> Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 proc=
essing")
> Suggested-by: Florian Westphal <fw@strlen.de>
> Reported-by: David Wragg <dwragg@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  net/ipv6/ip6_output.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index a471c7e91761..1de6f3c11655 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -162,7 +162,14 @@ ip6_finish_output_gso_slowpath_drop(struct net *net,=
 struct sock *sk,
>  		int err;
> =20
>  		skb_mark_not_on_list(segs);
> -		err =3D ip6_fragment(net, sk, segs, ip6_finish_output2);
> +		/* Last gso segment might be smaller than actual MTU. Adding
> +		 * a fragment header to it would produce an "atomic fragment",
> +		 * which is considered harmful (RFC-8021)
> +		 */
> +		err =3D segs->len > mtu ?
> +			ip6_fragment(net, sk, segs, ip6_finish_output2) :
> +			ip6_finish_output2(net, sk, segs);
> +
>  		if (err && ret =3D=3D 0)
>  			ret =3D err;
>  	}
> @@ -170,10 +177,19 @@ ip6_finish_output_gso_slowpath_drop(struct net *net=
, struct sock *sk,
>  	return ret;
>  }
> =20
> +static int ip6_finish_output_gso(struct net *net, struct sock *sk,
> +				 struct sk_buff *skb, unsigned int mtu)
> +{
> +	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> +	    !skb_gso_validate_network_len(skb, mtu))
> +		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);

If we are sending fakejumbo or have a frame that doesn't pass the
muster it is just going immediately to ip6_finish_output. I think the
checks that you removed are needed to keep the socket from getting
stuck sending frames that will probably be discarded.

> +
> +	return ip6_finish_output2(net, sk, skb);
> +}
> +
>  static int __ip6_finish_output(struct net *net, struct sock *sk, struct =
sk_buff *skb)
>  {
>  	unsigned int mtu;
> -

This blank line can probably be left there to separate variable
declarations from code.

>  #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
>  	/* Policy lookup after SNAT yielded a new policy */
>  	if (skb_dst(skb)->xfrm) {
> @@ -183,17 +199,14 @@ static int __ip6_finish_output(struct net *net, str=
uct sock *sk, struct sk_buff
>  #endif
> =20
>  	mtu =3D ip6_skb_dst_mtu(skb);
> -	if (skb_is_gso(skb) &&
> -	    !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
> -	    !skb_gso_validate_network_len(skb, mtu))
> -		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
> +	if (skb_is_gso(skb))
> +		return ip6_finish_output_gso(net, sk, skb, mtu);
> =20
> -	if ((skb->len > mtu && !skb_is_gso(skb)) ||
> -	    dst_allfrag(skb_dst(skb)) ||
> +	if (skb->len > mtu ||

This change looks a bit too aggressive to me. Basically if the frame is
gso you now bypass the ip6_fragment entirely and are ignoring the
dst_allfrag and frag_max_size case below. See the fail_toobig code in
ip6_fragment.

>  	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size)=
)
>  		return ip6_fragment(net, sk, skb, ip6_finish_output2);
> -	else
> -		return ip6_finish_output2(net, sk, skb);
> +
> +	return ip6_finish_output2(net, sk, skb);
>  }
> =20
>  static int ip6_finish_output(struct net *net, struct sock *sk, struct sk=
_buff *skb)

