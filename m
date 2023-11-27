Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8E7FA554
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjK0Py6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjK0Py4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:54:56 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB80A92;
        Mon, 27 Nov 2023 07:55:02 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b861a3be3eso1181966b6e.0;
        Mon, 27 Nov 2023 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701100502; x=1701705302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+99aoCcs4VcRRjnd4ABIm3+igMsBj2nosPKDWuod+R8=;
        b=IkA3SKIVW4Hsa1eRfeI9QDNPojKONP3L/sOGYrMjDuTR2L7Rh8ihNriu69lJHnQQUK
         4ZqqL39E37+YAQZ7NGvd+G5HKBHZ3NLvSO4fK04dvfyRCWZbRDMWPfrchqtvW+gPQ5nt
         iwvkNtMeynjdwiA9yA5P0c+vX1iDXppdhqSV4FwYUh1tCsksEeV7UuUbZggylMwoCNy9
         +k8bwwGQVBix3y9jLfaZze1OFWEdnAAsjkVppXR+oLJjSS6sSM2xpAgBmOjJE+yHrzGv
         5QSmYAgh3J8btaJCExdZGPgR8P/7iYoE2O3wO9EcfGJLYyUqpv2rDkxE8P7j0zrFl+Us
         SHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701100502; x=1701705302;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+99aoCcs4VcRRjnd4ABIm3+igMsBj2nosPKDWuod+R8=;
        b=oPeIx5A2FUMiK9QJZ3AQ8CouW/efabC7wqIYlOqmJkn4ers6NlInN7n4GjzMT5MepM
         bsnlNwr5noRNZJj3kifvYrNwRFMHbIHaDQnhFsLFzsJonvRaoMntbmdm0mVZbu/dMSLZ
         3X+Kf/E4EjdyYp7SCY45qQt14tC8gO2d14Aq8WZZqODwwQ8167RLw31YOsTES5yZ3cSJ
         IPzwYRTesIOk+l7XWtV9BJsxeN71K7G8A4ju0t02iytDPoRruystFvQQToucwD19dBrZ
         SuLWP+sCE+0El8t5HJmGJd2QFpDd/Y8pZF8TmryAertPh2kKB5t1ygMfy9OdOiumaLiF
         u2Qw==
X-Gm-Message-State: AOJu0Yy/F49m3MUyaNNxtn1r2jhpQEPlCfZCKjDoZ+UUdmzwxSziga5T
        HOKhR9gmtzlZ4lnKIeDlITk=
X-Google-Smtp-Source: AGHT+IGpJjATOQuoZq9OiDhL4fJxgNVSZh3aegQLNrGHTmQ3rNYq18czjkieYGRC2vNFrGRE0IOlYQ==
X-Received: by 2002:a05:6808:3c9:b0:3b8:6380:e9ec with SMTP id o9-20020a05680803c900b003b86380e9ecmr6593757oie.55.1701100501957;
        Mon, 27 Nov 2023 07:55:01 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id du3-20020a05621409a300b0067a2bda64a3sm2369426qvb.2.2023.11.27.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:55:01 -0800 (PST)
Date:   Mon, 27 Nov 2023 10:55:01 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Shigeru Yoshida <syoshida@redhat.com>, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Message-ID: <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231126151652.372783-1-syoshida@redhat.com>
References: <20231126151652.372783-1-syoshida@redhat.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shigeru Yoshida wrote:
> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
> true. For example, applications can create a malformed packet that causes
> this problem with PF_PACKET.

It may fail because because pskb_inet_may_pull does not account for
tunnel->hlen.

Is that what you are referring to with malformed packet? Can you
eloborate a bit on in which way the packet has to be malformed to
reach this?

FYI: I had a quick look at the IPv6 equivalent code.
ip6gre_tunnel_xmit is sufficiently different. It makes sense that this
is an IPv4 only patch.

> This patch fixes the problem by dropping skb and returning from the
> function if skb_pull() fails.
> 
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 22a26d1d29a0..95efa97cb84b 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>  		/* Pull skb since ip_tunnel_xmit() needs skb->data pointing
>  		 * to gre header.
>  		 */
> -		skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> +		if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr)))
> +			goto free_skb;
>  		skb_reset_mac_header(skb);
>  
>  		if (skb->ip_summed == CHECKSUM_PARTIAL &&
> -- 
> 2.41.0
> 


