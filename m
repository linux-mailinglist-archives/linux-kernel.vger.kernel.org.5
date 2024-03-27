Return-Path: <linux-kernel+bounces-120241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC92388D4C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD1B21FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E7224DC;
	Wed, 27 Mar 2024 02:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzj8f8cT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE1022EF3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507505; cv=none; b=st6puLYxW59xuB5JLedTXONM5600pfxGkRrPiSEuHSWr8uzLBnezh2vfKO2ea8sArpliISoYRdlop1xRUFGXzTAz3s/OVUc0XUYM4Uc6Jyru2wgRk3U0nZSLCIrbmWX8zvtnelZqI364KaUOvith3J06KsznCs0SzOKicwb52Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507505; c=relaxed/simple;
	bh=IqGg7LyLJ4vm9PU6ptmTZNKaGaZu+PMIhLvA/eSMrIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBb38vueO7FlqF0tGYdFJFCCbwLOg282oWmjthFbMbXyApJTmv1qkc0lge/ukBA0+yM/4HtJWqBH7SYEblmUxdra5cJEo7E3nvmX5KXc7johzOX7lAy+UvRjsRjAzeT4r01bmToGR/LHG+PNat5WQ0xytBKRbrdrq2QHsT1Fdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzj8f8cT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711507503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkfmtcIYl603EVBW7jCFuDGcWJSt5orkk6Zu8ttf8Fk=;
	b=Yzj8f8cTtFYG6y5KiFk5izPD8nkSBAQtnjbCm8eOtgiz/OgDZU4etkVGG7BzxfnyZpO/at
	9IJFFUnOUdhaUD/W2sj7bOdMhCNA0GWpm6OCCZs9vCqSiFCvPfTQn+qEFD0unrheGILis1
	l5X9WtvFH9wktHYouxxhVOBc69AD/bs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-rlfewEGeNxS55itN_pZOYA-1; Tue, 26 Mar 2024 22:45:01 -0400
X-MC-Unique: rlfewEGeNxS55itN_pZOYA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a039b47c5fso334467a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711507499; x=1712112299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkfmtcIYl603EVBW7jCFuDGcWJSt5orkk6Zu8ttf8Fk=;
        b=lpJNQv2uDxFley6hYe6OWhZr7k1ZOOqdS/xC0/eRQdp9+h3f0jYqEx5nIYBpNLUrHq
         XMvlK+Gzq8FfvpvYiAci8xt/5tpL1gcjjDRkVUs4yuU44betYhZLHdyHamssQFROisIb
         Z4u7A2/yjID5nALjwjjrBWq5103MO27NAz715HFQsWQNdzU6wMx72y1bVIaw/gK+ZAl2
         eycIUwsWT8mGLtJpe0Ltu1yAEUtWxzfzmr8b41CgUFFCpjleoEMIRwUrhwEGaY8Qpl8G
         a5gr+oc6AyBGPyiGTilRp07TACtyY/w/ox7iiO6MvIOEk82iqMNB4h/lb8uZYuvH9caH
         v+cw==
X-Forwarded-Encrypted: i=1; AJvYcCUSduLbh+QoBcuhLxzJd2aO1FJWNnQLF4dB8TMwBJYJjMha7GydBDhOaULFz6tgsWuumJsE09UPXg2pp5j8mb8FWgLybT2NkoHjg/uH
X-Gm-Message-State: AOJu0YzBTYkXsonkUmu5d+TtEJ9kUVcqF5hGdtI7l9TP0DS1Bg9XGK78
	j5akjAXRxIY5bpAgM6L6hDOAz9oF6relnXLABBzK9R2ef+kNfidAkofmPq3WcT20QRmi2nyzB45
	F9aJ6dwG95l44C/DHO4HMPmbOWA1gdUqKo7rmJhbcrMGl8hSEdLJKXY0LmQiqrZK4XTBvqXqqTN
	vO7FSLKarH6LJkkJ5IX5f/4J7+G/E3bFo8DEXU
X-Received: by 2002:a17:90a:c703:b0:2a0:76b1:896 with SMTP id o3-20020a17090ac70300b002a076b10896mr4392454pjt.12.1711507499588;
        Tue, 26 Mar 2024 19:44:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3MSgO2iAnKqGRMUSsmYhf817+2wItKWdIG835eY+e3znNWn8QDzGM+32n0mUkdpfVvpgn44vCtIs5VuWjmrI=
X-Received: by 2002:a17:90a:c703:b0:2a0:76b1:896 with SMTP id
 o3-20020a17090ac70300b002a076b10896mr4392437pjt.12.1711507499282; Tue, 26 Mar
 2024 19:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326233846.1086253-1-gshan@redhat.com> <20240326233846.1086253-2-gshan@redhat.com>
 <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
In-Reply-To: <CACGkMEtyEo2QQSEh0ZnZDUJSXMMhzeO97Jp0wF4_rhzUBGk4Zg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Mar 2024 10:44:48 +0800
Message-ID: <CACGkMEtUdgDr_M-F8-gdFkJp+29Xuw9DCib2-diFmJxFxDN2Bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, davem@davemloft.net, stefanha@redhat.com, sgarzare@redhat.com, 
	keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:34=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, Mar 27, 2024 at 7:39=E2=80=AFAM Gavin Shan <gshan@redhat.com> wro=
te:
> >
> > A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
> > Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> > available ring entries pushed by guest can be observed by vhost
> > in time, leading to stale available ring entries fetched by vhost
> > in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> > grace-hopper (ARM64) platform.
> >
> >   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
> >   -accel kvm -machine virt,gic-version=3Dhost -cpu host          \
> >   -smp maxcpus=3D1,cpus=3D1,sockets=3D1,clusters=3D1,cores=3D1,threads=
=3D1 \
> >   -m 4096M,slots=3D16,maxmem=3D64G                                 \
> >   -object memory-backend-ram,id=3Dmem0,size=3D4096M                \
> >    :                                                           \
> >   -netdev tap,id=3Dvnet0,vhost=3Dtrue                              \
> >   -device virtio-net-pci,bus=3Dpcie.8,netdev=3Dvnet0,mac=3D52:54:00:f1:=
26:b0
> >    :
> >   guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
> >   virtio_net virtio0: output.0:id 100 is not a head!
> >
> > Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
> > should be safe until vq->avail_idx is changed by commit 275bf960ac697
> > ("vhost: better detection of available buffers").
> >
> > Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
> > Cc: <stable@kernel.org> # v4.11+
> > Reported-by: Yihuang Yu <yihyu@redhat.com>
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 045f666b4f12..00445ab172b3 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev,=
 struct vhost_virtqueue *vq)
> >         r =3D vhost_get_avail_idx(vq, &avail_idx);
> >         if (unlikely(r))
> >                 return false;
> > +
> >         vq->avail_idx =3D vhost16_to_cpu(vq, avail_idx);
> > +       if (vq->avail_idx !=3D vq->last_avail_idx) {
> > +               /* Similar to what's done in vhost_get_vq_desc(), we ne=
ed
> > +                * to ensure the available ring entries have been expos=
ed
> > +                * by guest.
> > +                */
>
> We need to be more verbose here. For example, which load needs to be
> ordered with which load.
>
> The rmb in vhost_get_vq_desc() is used to order the load of avail idx
> and the load of head. It is paired with e.g virtio_wmb() in
> virtqueue_add_split().
>
> vhost_vq_avail_empty() are mostly used as a hint in
> vhost_net_busy_poll() which is under the protection of the vq mutex.
>
> An exception is the tx_can_batch(), but in that case it doesn't even
> want to read the head.

Ok, if it is needed only in that path, maybe we can move the barriers there=
.

Thanks

>
> Thanks
>
>
> > +               smp_rmb();
> > +               return false;
> > +       }
> >
> > -       return vq->avail_idx =3D=3D vq->last_avail_idx;
> > +       return true;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
> >
> > --
> > 2.44.0
> >


