Return-Path: <linux-kernel+bounces-144479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A68A46D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E275283699
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA7C168C7;
	Mon, 15 Apr 2024 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="LGAzhJCO"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E613FC11
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713147110; cv=none; b=Xt3yjyoB9jVfbQ7jd+S2w3r2K4kpa06epw5CMn8APpapr2N0ogzAoSUFlSuUcp5zGRl/EQNH7haSb9B05N4/GHXJNEUjTuZ4FDo0k2kcNJXkpx38Zr84Ua60iWR3NZlJLN1wNMgtwOtLwwq0tvvlW9sbAKVPZdFp3dWblWxg0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713147110; c=relaxed/simple;
	bh=FNI2hbZQ6yRPcqMBiF73nsNUvU2wdZwTxHyMc7YirRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMJD8i8JSoGKIQOfgfi9gTDgFxNFd7uHRPbKyFgFfePl9M82YRfsSEhGwrvxcSJoXmBeX1pYbKjObreSYlqd03knpvEjRA/6SR+qjZHgBajtWjxk5WOnKFdNMqhSWj2Rc8MfHOLrjmGtcHzDc02h5LwiXQaPsgdyBlGvDKeIoVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=LGAzhJCO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-614ec7ee902so26992797b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 19:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713147107; x=1713751907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgP2Xak0QM5b9Kf4Rg1Xpla0bktktcV08KWV5hlHTuc=;
        b=LGAzhJCORVvHIk11qcs5HmdzTnnNSnjkWR0tuWjN1YraXDuzQLSNlZdPAxH9Mv7bKV
         DY5OBl3p/n9M23C7xrRbJS5YzugrSBNJyw+78m7BJOf5bwTho9f6+vY0PI6iT4wOt3Hh
         x3r+FwUi90Vdkca+4ZOPk1oC2ZgidKXIgAK02uDyoNLom7f1Tw5ncS721byzS25BGgYM
         9Ekl33kizVb7/ZagNEBMbJ7yY0cA77W+DWrRlFfNWTyPbY/k6lUBuZKHu+4nbMvy1i0J
         i3pgF0jXTeHwhO8rDEZN2mrjT9/WqTumSUpZnTPSqJEl6F1FY/8O7x4x2KJYw5w61Ii9
         3nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713147107; x=1713751907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgP2Xak0QM5b9Kf4Rg1Xpla0bktktcV08KWV5hlHTuc=;
        b=PKeAkEjKz6FI2tDRPGi7MeU/jKIEOxmyFvXk7vAe79ycRZKBVfATryGf/tAqU7gAA6
         WKBWEdBQj2kVkr/3/Cnq4IKnZ//Vcl/JLq0K+V+67DzjD3dALjvo7B/I4eF+vteWL/6L
         Dl2UnTs2/EqeUYXZwPckzwOBbWwvxIaV0+aenPreo5dnEBxh8N6MmLXN7rXdjln+Kqrg
         XHr6AqmzlIPLzdic58VpNEUhHrD+nErRW2lq+TQrXO/uodHqBa+etPc7kulGPPN/dL5X
         ZavdaGr/cp/kFGhRyjtHAIv/rExbZRp1Qu+t8ijhA2g6Dv7Ic3DXfciixM1rWCRqCyjg
         2V2g==
X-Forwarded-Encrypted: i=1; AJvYcCUpJmd91Z/WvoiaUZ6SmcRWNIhM8HfPbMLFn275s5jogqI9nbG8EZWQPoe7EkvjOV9I6HV4gxg6rTy9pKWZ7GAK7l7ikMWjXsZ2bJ0h
X-Gm-Message-State: AOJu0YwkP1WU+X8pNLMgFZUWx6Cw9BIAVaCcH8QNneFvLAbWebtbLyHB
	4Jbuj1FCt4EbsUPZmi+fqvem4K7ziOcyQbF75BWGeNwX/F8zj/R7GMjsyzkN9fsk9Fh8eSYxG9p
	uLZvaG5A+N3uAw25US+jGaWHDKm95EKjqFH15oQ==
X-Google-Smtp-Source: AGHT+IHuZPGAYMGmK+xQck7BPRSsMQvuAbbxfYteFWh16Ru2myx792iHZagtWkO2ud0Lu46rEMVk1tapW6/J/6kT15A=
X-Received: by 2002:a81:af06:0:b0:61a:bff8:2153 with SMTP id
 n6-20020a81af06000000b0061abff82153mr2337501ywh.7.1713147106378; Sun, 14 Apr
 2024 19:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414081806.2173098-1-lei.chen@smartx.com> <661c03b8c6cae_3e7732294f8@willemb.c.googlers.com.notmuch>
In-Reply-To: <661c03b8c6cae_3e7732294f8@willemb.c.googlers.com.notmuch>
From: Lei Chen <lei.chen@smartx.com>
Date: Mon, 15 Apr 2024 10:11:34 +0800
Message-ID: <CAKcXpBwYjLi0xet0fCXkhFQmj5KesvdmgzdPH2dqhnb9oWF_qg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] tun: limit printing rate when illegal packet
 received by tun dev
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:26=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Lei Chen wrote:
> > vhost_worker will call tun call backs to receive packets. If too many
> > illegal packets arrives, tun_do_read will keep dumping packet contents.
> > When console is enabled, it will costs much more cpu time to dump
> > packet and soft lockup will be detected.
> >
> > net_ratelimit mechanism can be used to limit the dumping rate.
> >
> > PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
> >  #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
> >  #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
> >  #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
> >  #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
> >  #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
> >     [exception RIP: io_serial_in+20]
> >     RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
> >     RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
> >     RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
> >     RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
> >     R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
> >     R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >  #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
> >  #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
> >  #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
> >  #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
> >  #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
> >  #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
> >  #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
> >  #12 [ffffa65531497b68] printk at ffffffff89318306
> >  #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
> >  #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
> >  #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
> >  #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
> >  #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
> >  #18 [ffffa65531497f10] kthread at ffffffff892d2e72
> >  #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f
> >
> > Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
> > Signed-off-by: Lei Chen <lei.chen@smartx.com>
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes from v3:
> > https://lore.kernel.org/all/20240412065841.2148691-1-lei.chen@smartx.co=
m/
> >  1. Change patch target from net tun to tun.
> >  2. Move change log below the seperator "---".
> >  3. Remove escaped parentheses in the Fixes string.
> >
> > Changes from v2:
> > https://lore.kernel.org/netdev/20240410042245.2044516-1-lei.chen@smartx=
com/
> >  1. Add net-dev to patch subject-prefix.
> >  2. Add fix tag.
> >
> > Changes from v1:
> > https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.co=
m/
> >  1. Use net_ratelimit instead of raw __ratelimit.
> >  2. Use netdev_err instead of pr_err to print more info abort net dev.
> >  3. Adjust git commit message to make git am happy.
> >  drivers/net/tun.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 0b3f21cba552..ca9b4bc89de7 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -2125,14 +2125,16 @@ static ssize_t tun_put_user(struct tun_struct *=
tun,
> >                                           tun_is_little_endian(tun), tr=
ue,
> >                                           vlan_hlen)) {
> >                       struct skb_shared_info *sinfo =3D skb_shinfo(skb)=
;
> > -                     pr_err("unexpected GSO type: "
> > -                            "0x%x, gso_size %d, hdr_len %d\n",
> > -                            sinfo->gso_type, tun16_to_cpu(tun, gso.gso=
_size),
> > -                            tun16_to_cpu(tun, gso.hdr_len));
> > -                     print_hex_dump(KERN_ERR, "tun: ",
> > -                                    DUMP_PREFIX_NONE,
> > -                                    16, 1, skb->head,
> > -                                    min((int)tun16_to_cpu(tun, gso.hdr=
_len), 64), true);
> > +
> > +                     if (net_ratelimit()) {
> > +                             netdev_err(tun->dev, "unexpected GSO type=
: 0x%x, gso_size %d, hdr_len %d\n",
> > +                                    sinfo->gso_type, tun16_to_cpu(tun,=
 gso.gso_size),
> > +                                    tun16_to_cpu(tun, gso.hdr_len));
>
> Indentation. checkpatch or patchwork will also show this.

Thanks for your help, and sorry about that. A new patch has been sent.


>
> > +                             print_hex_dump(KERN_ERR, "tun: ",
> > +                                            DUMP_PREFIX_NONE,
> > +                                            16, 1, skb->head,
> > +                                            min((int)tun16_to_cpu(tun,=
 gso.hdr_len), 64), true);
> > +                     }
> >                       WARN_ON_ONCE(1);
> >                       return -EINVAL;
> >               }
> > --
> > 2.44.0
> >
>
>

