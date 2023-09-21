Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744707A9FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjIUU0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjIUU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F990F22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygHtBtpH+AYcTIeKQGzp990WYlglkTlgePf9jVI9zWQ=;
        b=NjfRsltsaKSwgaJK0/gGk8chtCwjcrimG07RAoUzNg4J0SBzu8/hVzGPbK6Xt1itPQaKl1
        jUrLBQI5XTIlLvY0V4nB0KYT1DxTYxF/8CracUPK/1Rq5BJBP0cF73H2rzll04mRNq2mAp
        a94c788UPP+uEnFJBJyvMU58/lQtjAk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-pViDkVKWNMyCYxD027v-_Q-1; Thu, 21 Sep 2023 07:24:03 -0400
X-MC-Unique: pViDkVKWNMyCYxD027v-_Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae3a2a03f7so11488066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 04:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695295442; x=1695900242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygHtBtpH+AYcTIeKQGzp990WYlglkTlgePf9jVI9zWQ=;
        b=qB8L5z79L6ouOuiJZCFAH152liRiIw81zugtRhvEQmiDzxMfystC5LqyOjCbj5xiGF
         hHTwsi/8wmAxLDopSyIfk+/bKxZU0aCmIzL1lFEWBa8Lv76ZNWZY0LIzBPVHX8bT5OJd
         lDmrxv47E1HljCLl/tIiCHh7hJumLtLppHubMfmXEJIS09jP+nkMSNn6PhFz4PLaBP6O
         7itbPtHFcYEibntErVhQZFmKlU3Igfe9JzdmFJXcsUrVNzKidzomJKBvOySCFPWUokUo
         HZiiP0FF/gAH2VUQS27++29mY8/vBhWkhAmIZPGRR8vuya6SwqRWADhOQbIfiJlGMexU
         OFBw==
X-Gm-Message-State: AOJu0YzurI5o6TYW98LpS9g1FzyI14lK7LsG7qTdO1ccvO5lCjj2ypVx
        KDbaNxWHSWmvgzNEG2jFSQfupiSq9pflIzuWQV6T5e60OWRQSgfnwm3IGnPON8wKxUcVe5E3LTB
        QklM+dnhgPTiwJiwrm1G5lfcH
X-Received: by 2002:a17:906:20d4:b0:9ae:2f35:442a with SMTP id c20-20020a17090620d400b009ae2f35442amr4193924ejc.5.1695295441871;
        Thu, 21 Sep 2023 04:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENAjFn0unFFCYoYVDN+dwN9WCfoMxEELZbXGO7j1dMyw+7LCQLZ3h6vliS/KNbNvtsKvcsDw==
X-Received: by 2002:a17:906:20d4:b0:9ae:2f35:442a with SMTP id c20-20020a17090620d400b009ae2f35442amr4193914ejc.5.1695295441535;
        Thu, 21 Sep 2023 04:24:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id lf23-20020a170906ae5700b00991d54db2acsm888899ejb.44.2023.09.21.04.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 04:24:01 -0700 (PDT)
Message-ID: <c2c0b0684b9c2a930ae6001bcc0044dd7a0862d5.camel@redhat.com>
Subject: Re: [PATCH v12 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Dmitry Safonov <dima@arista.com>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Date:   Thu, 21 Sep 2023 13:23:59 +0200
In-Reply-To: <20230918190027.613430-7-dima@arista.com>
References: <20230918190027.613430-1-dima@arista.com>
         <20230918190027.613430-7-dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-18 at 20:00 +0100, Dmitry Safonov wrote:
> @@ -1361,16 +1385,48 @@ static int __tcp_transmit_skb(struct sock *sk, st=
ruct sk_buff *skb,
>  		th->window	=3D htons(min(tp->rcv_wnd, 65535U));
>  	}
> =20
> -	tcp_options_write(th, tp, &opts);
> +	tcp_options_write(th, tp, &opts, &key);
> =20
> +	if (tcp_key_is_md5(&key)) {
>  #ifdef CONFIG_TCP_MD5SIG
> -	/* Calculate the MD5 hash, as we have all we need now */
> -	if (md5) {
> +		/* Calculate the MD5 hash, as we have all we need now */
>  		sk_gso_disable(sk);
>  		tp->af_specific->calc_md5_hash(opts.hash_location,
> -					       md5, sk, skb);
> -	}
> +					       key.md5_key, sk, skb);
>  #endif
> +	} else if (tcp_key_is_ao(&key)) {
> +#ifdef CONFIG_TCP_AO
> +		struct tcp_ao_info *ao;
> +		void *tkey_buf =3D NULL;
> +		u8 *traffic_key;
> +		__be32 disn;
> +
> +		ao =3D rcu_dereference_protected(tcp_sk(sk)->ao_info,
> +					       lockdep_sock_is_held(sk));
> +		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
> +			if (tcb->tcp_flags & TCPHDR_ACK)
> +				disn =3D ao->risn;
> +			else
> +				disn =3D 0;
> +
> +			tkey_buf =3D kmalloc(tcp_ao_digest_size(key.ao_key),
> +					   GFP_ATOMIC);
> +			if (!tkey_buf) {
> +				kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> +				return -ENOMEM;
> +			}
> +			traffic_key =3D tkey_buf;
> +			tp->af_specific->ao_calc_key_sk(key.ao_key, traffic_key,
> +							sk, ao->lisn, disn, true);
> +		} else {
> +			traffic_key =3D snd_other_key(key.ao_key);
> +		}
> +		tp->af_specific->calc_ao_hash(opts.hash_location, key.ao_key,
> +					      sk, skb, traffic_key,
> +					      opts.hash_location - (u8 *)th, 0);
> +		kfree(tkey_buf);
> +#endif

I'm sorry for the incremental feedback.

The above could possibly deserve being moved to a specific helper, for
both readability and code locality when TCP_AO is enabled at compile
time but not used.

Cheers,

Paolo

