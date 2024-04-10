Return-Path: <linux-kernel+bounces-137872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B489E8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC3B1F25193
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4FDC132;
	Wed, 10 Apr 2024 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LotjtHT3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9C10953
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721650; cv=none; b=kmvq5AWoVvo5bqUXypSg93119RY9/hDa9iZN8/SZCmMSb2678/cxuNpa/aIOfRY1619Dwz6NL+OlNVe21Uj2UmaqZfFRM6+d5rFeM1oOYXXeV5VvXIJJGnHvqsf4/+eLuuZYESnkjrKGe2vqD9Bin8eVzgqgL8+mCdLcYe+sLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721650; c=relaxed/simple;
	bh=C9iX9EN5K2Ro8VVAAiuWt++9y2FBI0Zpc08FBH0LuDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KszsHGqQvYMgDBQN4VzdXFXxDso+FvIbFlT18li+Z7sa72QJ4MVWHCrbR81V3AajoFTVe7JHl2JLjeVYJ3JlAsqwppFmZrN3V7DnfQaiUXfhn+IQCYyyCTBi2ccq0PcWg756Z7TNPhA0TbXoM+Dgw7TrtpEcJ/EwtFBak9VEp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LotjtHT3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712721647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=de15/AUuRjUO/tt3yX92+ptttxMxCuHyuP0n2Hf4wZc=;
	b=LotjtHT3gXS4CBsZa/xllzHxQScNKezwq7w/7s1TASGBz6Ur4ViITH7oVU07/UYC7QMdnO
	KlmVUNNSixGwBluEM5rYbISpSbh6Gyvs3vfvaTA1u0hY77bXBr5qpn/ZLnmfSBxH2HjKvU
	A2zvoH5GDbSij4ixFN23c251IKMn8E4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-ciHlWjZpO7SywIPDO0WnTQ-1; Wed, 10 Apr 2024 00:00:45 -0400
X-MC-Unique: ciHlWjZpO7SywIPDO0WnTQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a090878480so4529562a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712721644; x=1713326444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de15/AUuRjUO/tt3yX92+ptttxMxCuHyuP0n2Hf4wZc=;
        b=FL/AyGysmu+dMRaLHLCyVrKNllNfzeu+Ft6mHMdJSZ5PXqePTu+CD27eqTrzweJl/v
         VKevEfzEJHF2fuWuW+Hfq86Z9Ln3cMEhKNTxmeVfpCtP/HwQAlzkNKuSjs3ElhRDWisZ
         Hk4PWnkrQT4bj51/C6FKYB/W/FB+Z1c8kHVZfnkKg3R3F1AlqdgkyJNXFkD6RcBknfTi
         S8tUjVvOoIw/klGz1EDfmh5j9CvfHosP2A9OHLS179paoIwcrfzCE78+WKG49kLj3rtU
         EBtdKW1AHVGmjy0ATtEaruQTuv0bERYP7rXNBEui1YPBgYK9wk8OXahq5mFyMtAHAqTi
         q19w==
X-Forwarded-Encrypted: i=1; AJvYcCUYgNF/FsP2vgS1O6dZshF5xIizE931iBLTtqvDb+axy2+Awg56sO+C2+OBFb6DqzZCXcN4nU2u3pzHG9/mXjlqHNU+Yw9jtVfdpX+p
X-Gm-Message-State: AOJu0YyE/vYKGLEkqx/cKt4Wv7yePIcod3LcLGeGfBvzFG60NSQf2Nqq
	ngiwOPIxXh8y85q/faa9X1plw6VES5VaSJsMQs8uXI5qRbblSchHhQJkKhfHD4ZR6oIbOCoitcJ
	/+9RhS0Vpca5H8cJ7Dk5nmni0iKY5rG75G4ZLQCIajAnrQeAB9DecJzjOblO+aCZX4zY8B2AfTd
	+t+uQCHP2ck5JefTI7OpDUjL4HE0t66QjsaqV2
X-Received: by 2002:a17:90a:ac0c:b0:2a5:575:c58d with SMTP id o12-20020a17090aac0c00b002a50575c58dmr6289021pjq.16.1712721644502;
        Tue, 09 Apr 2024 21:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdHFAwhw+2G4PAM3Oz2MINPfDmb6Jxw1Tf4U1Ia7sHQk6lKkVYIl3TRV/Ubft2JqDpzfOhy9+AFpizuC/SKtU=
X-Received: by 2002:a17:90a:ac0c:b0:2a5:575:c58d with SMTP id
 o12-20020a17090aac0c00b002a50575c58dmr6288996pjq.16.1712721644112; Tue, 09
 Apr 2024 21:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409062407.1952728-1-lei.chen@smartx.com> <0e5a96b6-0862-4c00-b07f-7485af232475@lunn.ch>
 <CAKcXpBwE-8p+naDgJnCU41ODxRhWq7CkhEeeOAw+Ode4-J6CLw@mail.gmail.com>
In-Reply-To: <CAKcXpBwE-8p+naDgJnCU41ODxRhWq7CkhEeeOAw+Ode4-J6CLw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 12:00:32 +0800
Message-ID: <CACGkMEuiROr4EydSp+HFgG2GPqsda0zpfge5DvsSDEbsyWDuLg@mail.gmail.com>
Subject: Re: [PATCH] net:tun: limit printing rate when illegal packet received
 by tun dev
To: Lei Chen <lei.chen@smartx.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:23=E2=80=AFAM Lei Chen <lei.chen@smartx.com> wro=
te:
>
> On Tue, Apr 9, 2024 at 8:52=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote=
:
> >
> > On Tue, Apr 09, 2024 at 02:24:05AM -0400, Lei Chen wrote:
> > > vhost_worker will call tun call backs to receive packets. If too many
> > > illegal packets arrives, tun_do_read will keep dumping packet content=
s.
> > > When console is enabled, it will costs much more cpu time to dump
> > > packet and soft lockup will be detected.
> > >
> > > Rate limit mechanism can be used to limit the dumping rate.
> > > @@ -2125,14 +2126,16 @@ static ssize_t tun_put_user(struct tun_struct=
 *tun,
> > >                                           tun_is_little_endian(tun), =
true,
> > >                                           vlan_hlen)) {
> > >                       struct skb_shared_info *sinfo =3D skb_shinfo(sk=
b);
> > > -                     pr_err("unexpected GSO type: "
> > > -                            "0x%x, gso_size %d, hdr_len %d\n",
> > > -                            sinfo->gso_type, tun16_to_cpu(tun, gso.g=
so_size),
> > > -                            tun16_to_cpu(tun, gso.hdr_len));
> > > -                     print_hex_dump(KERN_ERR, "tun: ",
> > > -                                    DUMP_PREFIX_NONE,
> > > -                                    16, 1, skb->head,
> > > -                                    min((int)tun16_to_cpu(tun, gso.h=
dr_len), 64), true);
> > > +
> > > +                     if (__ratelimit(&ratelimit)) {
> >
> > Maybe just use net_ratelimit() rather than add a new ratelimit
> > variable?
>
> Thanks for your suggestion, net_ratelimit is a better way to make it.

+1

Thanks

>
> >
> > A separate issue, i wounder if rather than pr_err(),
> > netdev_err(tun->dev, ...) should be used to indicate which TUN device
> > has been given bad GSO packets?
>
> I got it, I'll remake the patch, thanks.
>


