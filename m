Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4777F68A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 22:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjKWVY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 16:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 16:24:54 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEAFD42;
        Thu, 23 Nov 2023 13:25:01 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b845ba9ba9so740222b6e.3;
        Thu, 23 Nov 2023 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700774700; x=1701379500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06m9r8pewc3sAhhWhDQGbaOQDXI7LPtwjYRXQISAdy0=;
        b=FOziBpbmjKT9iRgjJNBxzFnOcZax01LXmuAEvbi+Ic88cNcKpLHqcplzesSWEIjHg7
         w5kdOmY6i/0vRL66GGpgj8C+TYprZtJb/w9thXpxo7H3wgTkM3gYV3VALa0uMEzh3jbn
         UESqvhyh3p8ZJXbAD85NRxqC9NIRsEguMtdA7Jyom1dPCGErYZ9DFxJKgLukVnhZeIHM
         EpLHHv6oEKTWcLVw6qvHId3xlg2Gk1kWpDcMOlYoVO02iErqXQnhMLeyfKnnehfPu4fo
         abTiWU92LXU4c4B3uFBcxIJsH6uux3AvtCtA+ehjkw9zaAX9VC53kYUY7xb9K+xJGWI+
         deWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700774700; x=1701379500;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=06m9r8pewc3sAhhWhDQGbaOQDXI7LPtwjYRXQISAdy0=;
        b=Fev+g9/dw7pUOOsRSzUlM6zAy7ASv3kwjJ9vvA4p5X1VgqSW/Av8YCvEPUOazVcXlS
         3aNMQz8PWviQyBOabom+dpUpqnhfn8qMWXdMgeuPnia3VDrkhKYTjEhqYzMzJuSnHkJB
         18Sl8pywj4NFkD/ner4+mBmB7LiIaU4HcJwWDj5x3F9KP7w+MxpkaW5w0Wu8DlifQKq3
         7MYVTNyd7a0Ta4cQkd+tPuA/VOUEfmAark9syaJZV3uCfirvqbsVxVn+ydTqOrUEBtKU
         oCHRImEJACMVi1X6vQfGf92P1F79ibAhA+lQ/15B8Gz9l2tjNnqPn2acU1yYWQ5WKgiA
         E+/A==
X-Gm-Message-State: AOJu0YwEv5VXgS9ud7/2ncC2jRTLwwzwY3LBcl/KIcKJigXlMDS1UaeP
        BnRrvw1y5Fg48QAmaeaHJEI=
X-Google-Smtp-Source: AGHT+IHy6TtasYU/FTTTvHqsqdEvKxviAQxRfVS/+34Avd+oUgZfbjTuiiDQsKL6giUCtGeACy0lbw==
X-Received: by 2002:a05:6808:20a4:b0:3af:585:402a with SMTP id s36-20020a05680820a400b003af0585402amr777803oiw.39.1700774700496;
        Thu, 23 Nov 2023 13:25:00 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id o11-20020ae9f50b000000b0076cdc3b5beasm729367qkg.86.2023.11.23.13.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 13:24:59 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:24:59 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Mike Pattrick <mkp@redhat.com>, netdev@vger.kernel.org
Cc:     willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, Mike Pattrick <mkp@redhat.com>
Message-ID: <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231123183835.635210-1-mkp@redhat.com>
References: <20231123183835.635210-1-mkp@redhat.com>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Pattrick wrote:
> Af_packet provides checksum offload offsets to usermode applications
> through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on the
> socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
> af_packet will include the link level header and so csum_start needs
> to be adjusted accordingly.

Is this patch based on observing an incorrect offset in a workload,
or on code inspection?

As the referenced patch mentions, VLAN_HLEN adjustment is needed
in macvtap because it pulls the vlan header from skb->vlan_tci. At
which point skb->csum_start is wrong.

"Commit f09e2249c4f5 ("macvtap: restore vlan header on user read")
 added this feature to macvtap. Commit 3ce9b20f1971 ("macvtap: Fix
 csum_start when VLAN tags are present") then fixed up csum_start."

But the commit also mentions "Virtio, packet and uml do not insert
the vlan header in the user buffer.". This situation has not changed.

Packet sockets may receive packets with VLAN headers present, but
unless they were inserted manually before passing to user, as macvtap
does, this does not affect csum_start.

Packet sockets support reading those skb->vlan_tci stored VLAN
headers using AUXDATA.

> Fixes: fd3a88625844 ("net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload holds vlan")

The fix should target net, not net-next.

> Signed-off-by: Mike Pattrick <mkp@redhat.com>
> ---
>  net/packet/af_packet.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a84e00b5904b..f6b602ffe383 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2092,15 +2092,23 @@ static unsigned int run_filter(struct sk_buff *skb,
>  }
>  
>  static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *skb,
> -			   size_t *len, int vnet_hdr_sz)
> +			   size_t *len, int vnet_hdr_sz,
> +			   const struct sock *sk)
>  {
>  	struct virtio_net_hdr_mrg_rxbuf vnet_hdr = { .num_buffers = 0 };
> +	int vlan_hlen;
>  
>  	if (*len < vnet_hdr_sz)
>  		return -EINVAL;
>  	*len -= vnet_hdr_sz;
>  
> -	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr, vio_le(), true, 0))
> +	if (sk->sk_type == SOCK_RAW && skb_vlan_tag_present(skb))
> +		vlan_hlen = VLAN_HLEN;
> +	else
> +		vlan_hlen = 0;
> +
> +	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr,
> +				    vio_le(), true, vlan_hlen))
>  		return -EINVAL;
>  
>  	return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
> @@ -2368,13 +2376,21 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		__set_bit(slot_id, po->rx_ring.rx_owner_map);
>  	}
>  
> -	if (vnet_hdr_sz &&
> -	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
> -				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> -		if (po->tp_version == TPACKET_V3)
> -			prb_clear_blk_fill_status(&po->rx_ring);
> -		goto drop_n_account;
> +	if (vnet_hdr_sz) {
> +		int vlan_hlen;
> +
> +		if (sk->sk_type == SOCK_RAW && skb_vlan_tag_present(skb))
> +			vlan_hlen = VLAN_HLEN;
> +		else
> +			vlan_hlen = 0;
> +
> +		if (virtio_net_hdr_from_skb(skb, h.raw + macoff -
> +					    sizeof(struct virtio_net_hdr),
> +					    vio_le(), true, vlan_hlen)) {
> +			if (po->tp_version == TPACKET_V3)
> +				prb_clear_blk_fill_status(&po->rx_ring);
> +			goto drop_n_account;
> +		}
>  	}
>  
>  	if (po->tp_version <= TPACKET_V2) {
> @@ -3464,7 +3480,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  	packet_rcv_try_clear_pressure(pkt_sk(sk));
>  
>  	if (vnet_hdr_len) {
> -		err = packet_rcv_vnet(msg, skb, &len, vnet_hdr_len);
> +		err = packet_rcv_vnet(msg, skb, &len, vnet_hdr_len, sk);
>  		if (err)
>  			goto out_free;
>  	}
> -- 
> 2.40.1
> 


