Return-Path: <linux-kernel+bounces-43857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494C4841999
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1119B220F8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981836B0D;
	Tue, 30 Jan 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVKMemRU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FC3716E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583058; cv=none; b=SsUnqZ+rLI5A8xel+u0DWeZsh3iJuYOW8uyi0I8Hwg9xo/Hp8fZ2wzJn48eauvM5R9afbww8yL2WZSJOIRKuJgrp/00pBIct4uR/HiMiCKw0tEyUlQogH4GdTjGmQwLB2z5HimuXyckGlryJnnoVyIT7Z9gIv6pyyB2cLn5VzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583058; c=relaxed/simple;
	bh=7/4OOmT0P01j47RMj7+gCYaiskBPgI0I+DKiyvwAdv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zy6jyMtugfAd81RnA5BXnwkM1z6584HpA10CjJNZ8C0iRGD8Vf/F7dNQsUbFy/9g7LyBYgoPcU99ap2wT1zq3LCYLQZVjBgN5/Ojgn3FwBwlifuKw19RAaeoKnAOf/bEmDKXzHGXDC1XvHuxycquI4V3x9w8MVNY5TS0K2oXLpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVKMemRU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706583056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCU7cgSJXt8eqbIH0viYPN7vEYcJ8K/tx6HHt1Qm1ig=;
	b=TVKMemRUzNprPYtG6pIhGlUoiWX9YULfvzt3/SV0uoUyvVFQ7WJmJYaR4GkwqVmG8Z7suZ
	Hgh4mCzEnI5vRFVVaVuhVQT47shZdY2NDsJt3pCTJXBwScSce7UvR8sfLWxNWOJnBNRckL
	8ATnnbT/qkPiGnfzz5FuFdN0slWKidY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-GsZ3WZ_bNAGUtJLDRjnOIw-1; Mon, 29 Jan 2024 21:50:54 -0500
X-MC-Unique: GsZ3WZ_bNAGUtJLDRjnOIw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6dde04e1c67so2224642b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583053; x=1707187853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCU7cgSJXt8eqbIH0viYPN7vEYcJ8K/tx6HHt1Qm1ig=;
        b=ToCS8V43G7O63T+oBSGkW7hP/qcoDOzJ1A5cAlpPsCU+aRTBRcOMVh3lVa/cLVS4qc
         PVuOHvHMRcT2Gp9vfo8r54zm1ZSHcPIWY3+EcAGX6fQU1piLOlRylIupk9/6e/bX3/AO
         tzN7gPnL9CoN9eO2jp39sJ+1L+RWvY8AoYvr0zgnkHkpxbKIhgdV36sIiMswl395JLed
         tDoQXKyd9GBHqWpmW0VJAc+F5da1YZG571SZ9eTBNf9CnL/UVtYMmk7EUfkqF+d0wlIm
         Ntb715PjWXDBwhKcBam+RHqdwwGwVcMWRAW60ZYKtpBV4Op0LTQbIXgDfxFP5vpmmSMY
         cjlQ==
X-Gm-Message-State: AOJu0YypXLY6bqGXop+K1YqLabKLGypt1X9Dwvir2Rx42LU915a6UyL7
	3IrX9wo0uMSWTOkAZBaKGtYHsO7z3kKqFxwPrtqSY4V/IRT0SxEFetNPrxPtQDA9t4m0/X8QFRC
	RA/rP3bFgrweX8edFXU4zW4vDU/b6Zokg54hVI1vs2W2aDr2xMo7JuTgYhl2AJ/rdxi4Ky9vF31
	dgMBJLwA3M77/AWi4m8wUb2ebQ69Xf9JNAWKGK
X-Received: by 2002:a05:6a00:be4:b0:6db:7073:f845 with SMTP id x36-20020a056a000be400b006db7073f845mr3665894pfu.18.1706583053108;
        Mon, 29 Jan 2024 18:50:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm5Itgw8YJiSPgIZ0ocMlecuXm83mHLHvX+aoPWUkQQ+32MJb0boVV1sfx4sU6lrRD47v7bJs7prWQkWvVf4w=
X-Received: by 2002:a05:6a00:be4:b0:6db:7073:f845 with SMTP id
 x36-20020a056a000be400b006db7073f845mr3665879pfu.18.1706583052830; Mon, 29
 Jan 2024 18:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706089075-16084-1-git-send-email-wangyunjian@huawei.com>
 <CACGkMEu5PaBgh37X4KysoF9YB8qy6jM5W4G6sm+8fjrnK36KXA@mail.gmail.com>
 <ad74a361d5084c62a89f7aa276273649@huawei.com> <CACGkMEvvdfBhNXPSxEgpPGAaTrNZr83nyw35bvuZoHLf+k85Yg@mail.gmail.com>
 <0141ea1c5b834503837df5db6aa5c92a@huawei.com>
In-Reply-To: <0141ea1c5b834503837df5db6aa5c92a@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 10:50:41 +0800
Message-ID: <CACGkMEsyvgnezk2DXX-Z7Wt9zHV9o=w_wcN8z+dyoZ9LB1qqjA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
To: wangyunjian <wangyunjian@huawei.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, xudingke <xudingke@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 7:40=E2=80=AFPM wangyunjian <wangyunjian@huawei.com=
> wrote:
>
> > -----Original Message-----
> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Monday, January 29, 2024 11:03 AM
> > To: wangyunjian <wangyunjian@huawei.com>
> > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com; kuba@kernel.org;
> > davem@davemloft.net; magnus.karlsson@intel.com; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>
> > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
> >
> > On Thu, Jan 25, 2024 at 8:54=E2=80=AFPM wangyunjian <wangyunjian@huawei=
com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > > Sent: Thursday, January 25, 2024 12:49 PM
> > > > To: wangyunjian <wangyunjian@huawei.com>
> > > > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com;
> > > > kuba@kernel.org; davem@davemloft.net; magnus.karlsson@intel.com;
> > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > kvm@vger.kernel.org; virtualization@lists.linux.dev; xudingke
> > > > <xudingke@huawei.com>
> > > > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
> > > >
> > > > On Wed, Jan 24, 2024 at 5:38=E2=80=AFPM Yunjian Wang
> > > > <wangyunjian@huawei.com>
> > > > wrote:
> > > > >
> > > > > Now the zero-copy feature of AF_XDP socket is supported by some
> > > > > drivers, which can reduce CPU utilization on the xdp program.
> > > > > This patch set allows tun to support AF_XDP Rx zero-copy feature.
> > > > >
> > > > > This patch tries to address this by:
> > > > > - Use peek_len to consume a xsk->desc and get xsk->desc length.
> > > > > - When the tun support AF_XDP Rx zero-copy, the vq's array maybe =
empty.
> > > > > So add a check for empty vq's array in vhost_net_buf_produce().
> > > > > - add XDP_SETUP_XSK_POOL and ndo_xsk_wakeup callback support
> > > > > - add tun_put_user_desc function to copy the Rx data to VM
> > > >
> > > > Code explains themselves, let's explain why you need to do this.
> > > >
> > > > 1) why you want to use peek_len
> > > > 2) for "vq's array", what does it mean?
> > > > 3) from the view of TUN/TAP tun_put_user_desc() is the TX path, so =
I
> > > > guess you meant TX zerocopy instead of RX (as I don't see codes for
> > > > RX?)
> > >
> > > OK, I agree and use TX zerocopy instead of RX zerocopy. I meant RX
> > > zerocopy from the view of vhost-net.
> >
> > Ok.
> >
> > >
> > > >
> > > > A big question is how could you handle GSO packets from
> > userspace/guests?
> > >
> > > Now by disabling VM's TSO and csum feature.
> >
> > Btw, how could you do that?
>
> By set network backend-specific options:
> <driver name=3D'vhost'>
>         <host csum=3D'off' gso=3D'off' tso4=3D'off' tso6=3D'off' ecn=3D'o=
ff' ufo=3D'off' mrg_rxbuf=3D'off'/>
>     <guest csum=3D'off' tso4=3D'off' tso6=3D'off' ecn=3D'off' ufo=3D'off'=
/>
> </driver>

This is the mgmt work, but the problem is what happens if GSO is not
disabled in the guest, or is there a way to:

1) forcing the guest GSO to be off
2) a graceful fallback

Thanks

>
> Thanks
>
> >
> > Thanks
> >
>


