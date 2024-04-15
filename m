Return-Path: <linux-kernel+bounces-144760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803538A4A58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B18281140
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949D3771C;
	Mon, 15 Apr 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3fRARni"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CBA364DC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169740; cv=none; b=Sz1o59iRIM1SyD8Gbb78/geKmMvQpkPqjyFpSCkD2o6WoWuz5AzdzgElN8MWvQRW5KdeYPTtStNzwzHcTrw6RKxJkYGSr/jERrOKJwC1kSLP3+pf+z2pqL9KrmNANSZ9ZuPXQd1qYXhREvgu/FyEBcOU2FnaU/fWBRoW1DLoSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169740; c=relaxed/simple;
	bh=g11QqmbkDPrU2HyfPuX2M8pembz+Hi35FyACwPLnOIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvjiR1yjv0aOqHAG0tJvTv43KTr78yMGVdPt+puratduHKVtGKghAtAd4wHGdy+8UdFd7fkl1KW99gO2qjl1CE+X9ESFyrdf0lyEsMknAOU5GDmoKKI2WZvDqZlWRc25FCDIdk/B9TRtdSj9Oe1kH80+HxbPRo7doQ64YYQC+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3fRARni; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713169737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+tf9SnOnHLqT5q4tQiv3UN0FjYFcbXUVL6l2rl/L1I=;
	b=a3fRARni5YvZILbzGFuV0YbovvLc4pA+Qan5T3p7XqVhaJ0yEY2PxXtR1RXKNaWZvkFu1R
	K3WsyWhECnmN/L/lgdxWBNWl9nFct7HUY2C3vMYGBrllA+Jzklf77GqcXhWRvzT814tEhw
	Fm5dZEvVTSR3Yz64y5fpY3oE/FxpBzk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-LH54lToUPXqDJijj2nr8cw-1; Mon, 15 Apr 2024 04:28:56 -0400
X-MC-Unique: LH54lToUPXqDJijj2nr8cw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6fcb884bbso24623271fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169734; x=1713774534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+tf9SnOnHLqT5q4tQiv3UN0FjYFcbXUVL6l2rl/L1I=;
        b=ngcLdck8AFw/Seh8qKqjS+KkXuQilET9eEviDBAVW6tZ9I4GV1AU+ly+MbyfKI+riI
         KoO2AmYR29jYKmvIyIThccOwUW5j4b08SX+9fCxnWzXsEpRCX91HrusPhvBEtoChURQm
         9nn4yBc61YOD9io99a2UkN6ZrX6r4K/0O+tDthoLyvOxwvdvlIivIvGuW11XvyMr/TxA
         CthaxzGPGBJOJHuW0LuokAFPvefQkkF6mr2VcRpq3Hbe6s8EjVaMs+dtvC17qrUcaR/p
         KUjwMAYicGnO5tTEQnmoEd7TM8cEtsCoY3riVgZ5EYRfd8+gRcC5lVKpShzB+2kKU5Ce
         uGAA==
X-Forwarded-Encrypted: i=1; AJvYcCWG4iDee9M1AaF8LdqTRg5KxHZe5NWCd32sBbQNaH5lFzX+SNJFg6LCGMqu6u/7GQX8fLzVuBhi0eJg9MtJDfXZ/+AaNWPcikhzvRyK
X-Gm-Message-State: AOJu0YyIeYsYuY9u49bgGQAcGL6wXGLMu/jR6cogRWS1or6PLU9v1Dti
	uQUUQNX74dRlIyju7f7Zua2Y0YyH2fa2wsRUlrFl+Uaoqn3x0Eu9WlyAO55Wdm2vrz0vG8oIigM
	heo7oGrgcuF0seR6GGQaWBmp/XyzA6x7AmgWJIXKqzc447BW4BlWXuLPZQ2XCZA==
X-Received: by 2002:a2e:3815:0:b0:2da:5f41:10c8 with SMTP id f21-20020a2e3815000000b002da5f4110c8mr2451687lja.3.1713169734451;
        Mon, 15 Apr 2024 01:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnaWhO8kV0NnEt1Tu69gzDj2un/ADxh/1SZoIktVoFWj49rCxo2t6ZtkoKKWd6uKza2mxtGw==
X-Received: by 2002:a2e:3815:0:b0:2da:5f41:10c8 with SMTP id f21-20020a2e3815000000b002da5f4110c8mr2451674lja.3.1713169733820;
        Mon, 15 Apr 2024 01:28:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:a95b:a91:79d:72cd:ca48])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm18790311wmb.46.2024.04.15.01.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:28:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 04:28:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lei Chen <lei.chen@smartx.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] tun: limit printing rate when illegal packet
 received by tun dev
Message-ID: <20240415042840-mutt-send-email-mst@kernel.org>
References: <20240415020247.2207781-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415020247.2207781-1-lei.chen@smartx.com>

On Sun, Apr 14, 2024 at 10:02:46PM -0400, Lei Chen wrote:
> vhost_worker will call tun call backs to receive packets. If too many
> illegal packets arrives, tun_do_read will keep dumping packet contents.
> When console is enabled, it will costs much more cpu time to dump
> packet and soft lockup will be detected.
> 
> net_ratelimit mechanism can be used to limit the dumping rate.
> 
> PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
>  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
>  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
>  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
>  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
>  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
>     [exception RIP: io_serial_in+20]
>     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
>     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
>     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
>     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
>     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
>     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
>  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
>  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
>  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
>  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
>  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
>  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
>  #12 [ffffa65531497b68] printk at ffffffff89318306
>  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
>  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
>  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
>  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
>  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
>  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
>  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> 
> Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes from v4:
> https://lore.kernel.org/all/20240414081806.2173098-1-lei.chen@smartx.com/
>  1. Adjust code indentation
> 
> Changes from v3:
> https://lore.kernel.org/all/20240412065841.2148691-1-lei.chen@smartx.com/
>  1. Change patch target from net tun to tun.
>  2. Move change log below the seperator "---".
>  3. Remove escaped parentheses in the Fixes string.
> 
> Changes from v2:
> https://lore.kernel.org/netdev/20240410042245.2044516-1-lei.chen@smartx.com/
>  1. Add net-dev to patch subject-prefix.
>  2. Add fix tag.
> 
> Changes from v1:
> https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
>  1. Use net_ratelimit instead of raw __ratelimit.
>  2. Use netdev_err instead of pr_err to print more info abort net dev.
>  3. Adjust git commit message to make git am happy.
>  drivers/net/tun.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
>  drivers/net/tun.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 0b3f21cba552..92da8c03d960 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2125,14 +2125,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  					    tun_is_little_endian(tun), true,
>  					    vlan_hlen)) {
>  			struct skb_shared_info *sinfo = skb_shinfo(skb);
> -			pr_err("unexpected GSO type: "
> -			       "0x%x, gso_size %d, hdr_len %d\n",
> -			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> -			       tun16_to_cpu(tun, gso.hdr_len));
> -			print_hex_dump(KERN_ERR, "tun: ",
> -				       DUMP_PREFIX_NONE,
> -				       16, 1, skb->head,
> -				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +
> +			if (net_ratelimit()) {
> +				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
> +					   sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
> +					   tun16_to_cpu(tun, gso.hdr_len));
> +				print_hex_dump(KERN_ERR, "tun: ",
> +					       DUMP_PREFIX_NONE,
> +					       16, 1, skb->head,
> +					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
> +			}
>  			WARN_ON_ONCE(1);
>  			return -EINVAL;
>  		}
> -- 
> 2.44.0
> 


