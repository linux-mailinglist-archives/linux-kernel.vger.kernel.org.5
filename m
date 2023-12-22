Return-Path: <linux-kernel+bounces-9269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40E81C32E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40BA1F25596
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC106111;
	Fri, 22 Dec 2023 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APMB8Rwn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A527539A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703213439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rARXe/M3buLmbooBFlbuBkY4DPHQz0HXHq7uJnNjHYE=;
	b=APMB8Rwn5Qe/wkEjVMXmei41u8ZwqJGiq1vySgvvh6qRIeygmfk5Gt4zRkaeE72AJgfrKe
	QEOxYEZt1iBxbqLkVTlzx5ISq2hWW+d6qou2c17sZ57Z4Cui26lGYJda3tHgLNmWu4Zl8t
	qAIp+neLwH12t1dRchtggQNRiAgB75g=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-PJdwCRACO6WpjaT6j__i7A-1; Thu, 21 Dec 2023 21:50:37 -0500
X-MC-Unique: PJdwCRACO6WpjaT6j__i7A-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b88ac1f09cso1388490b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703213437; x=1703818237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rARXe/M3buLmbooBFlbuBkY4DPHQz0HXHq7uJnNjHYE=;
        b=I7+v/BnhrdhzLBm1UysMvHzi/dW0iAbcUrzz97tnlNSApyzgUUoGS9hlUoG9o/uYqy
         PQQDqs790vlh5kFpQCYp97DKaeK9MHNWfyP80Wt8JVWYI7hI5TUZBXgL7nsCs3w0LKnG
         XxoV384zrPfFLdMfgX5ExM4QXjNoXk2DRzmOFHpsVREHVy7dvzfZIt37Hi+/JBdRAaT9
         cNOUukph+stXzQYtIcYlubFhSMu8tBc7YgdKOjg+nQYz6YTb0wIj3HZT/wU/1/GnFZm1
         97LAK2nUM9DpwfPpPzr+evE98LUtnXV/qnqpxJYQP1j8ox+RGZIgjncs8ClrbBeqf8km
         27bg==
X-Gm-Message-State: AOJu0YwoPSG7h4jLlzbw6Mg+fE6aSZVOVzP8vRmYbstJExOTsQ4WTjNO
	AMNP/Bq8h1/3hs0ijReWH+JEujO4db2iBgIp/OOnALOfjzfhLuKOaIxjdU7MDPPkj0gbk7wLhC4
	d2R1T2b4LD1oRwGM5wl6sOzMgDpaic4VpDuHK1Ysb9C457Adx
X-Received: by 2002:a05:6808:180e:b0:3bb:7a42:4ba2 with SMTP id bh14-20020a056808180e00b003bb7a424ba2mr579303oib.88.1703213436745;
        Thu, 21 Dec 2023 18:50:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO1uG4G5FyZVnd3+iqHHCMbz+2HmpzmOrrCFAI6gos35aS67gSZrmEuQkPq2y8BpAvnM12qgDrpJYJz2Q7v60=
X-Received: by 2002:a05:6808:180e:b0:3bb:7a42:4ba2 with SMTP id
 bh14-20020a056808180e00b003bb7a424ba2mr579298oib.88.1703213436467; Thu, 21
 Dec 2023 18:50:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com>
 <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
 <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
 <CACGkMEuM7bXxsxHUs_SodiDQ2+akrLqqzWZBJSZEcnMASUkb+g@mail.gmail.com> <CAJaqyWeBVVcTZEzZK=63Ymk85wnRFd+_wK56UfEHNXBH-qy1Zg@mail.gmail.com>
In-Reply-To: <CAJaqyWeBVVcTZEzZK=63Ymk85wnRFd+_wK56UfEHNXBH-qy1Zg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2023 10:50:23 +0800
Message-ID: <CACGkMEv8bQwahTB8x7JjYB3hTT76_QYQEMiHm7jN_gQXPz4Wsw@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 3:47=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 21, 2023 at 3:03=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Dec 20, 2023 at 9:32=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > > > >
> > > > > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@=
nvidia.com> wrote:
> > > > > >
> > > > > > The virtio spec doesn't allow changing virtqueue addresses afte=
r
> > > > > > DRIVER_OK. Some devices do support this operation when the devi=
ce is
> > > > > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND fl=
ag
> > > > > > advertises this support as a backend features.
> > > > >
> > > > > There's an ongoing effort in virtio spec to introduce the suspend=
 state.
> > > > >
> > > > > So I wonder if it's better to just allow such behaviour?
> > > >
> > > > Actually I mean, allow drivers to modify the parameters during susp=
end
> > > > without a new feature.
> > > >
> > >
> > > That would be ideal, but how do userland checks if it can suspend +
> > > change properties + resume?
> >
> > As discussed, it looks to me the only device that supports suspend is
> > simulator and it supports change properties.
> >
> > E.g:
> >
> > static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> >                                   u64 desc_area, u64 driver_area,
> >                                   u64 device_area)
> > {
> >         struct vdpasim *vdpasim =3D vdpa_to_sim(vdpa);
> >         struct vdpasim_virtqueue *vq =3D &vdpasim->vqs[idx];
> >
> >         vq->desc_addr =3D desc_area;
> >         vq->driver_addr =3D driver_area;
> >         vq->device_addr =3D device_area;
> >
> >         return 0;
> > }
> >
>
> So in the current kernel master it is valid to set a different vq
> address while the device is suspended in vdpa_sim. But it is not valid
> in mlx5, as the FW will not be updated in resume (Dragos, please
> correct me if I'm wrong). Both of them return success.
>
> How can we know in the destination QEMU if it is valid to suspend &
> set address? Should we handle this as a bugfix and backport the
> change?

Good point.

We probably need to do backport, this seems to be the easiest way.
Theoretically, userspace may assume this behavior (though I don't
think there would be a user that depends on the simulator).

>
> > >
> > > The only way that comes to my mind is to make sure all parents return
> > > error if userland tries to do it, and then fallback in userland.
> >
> > Yes.
> >
> > > I'm
> > > ok with that, but I'm not sure if the current master & previous kerne=
l
> > > has a coherent behavior. Do they return error? Or return success
> > > without changing address / vq state?
> >
> > We probably don't need to worry too much here, as e.g set_vq_address
> > could fail even without suspend (just at uAPI level).
> >
>
> I don't get this, sorry. I rephrased my point with an example earlier
> in the mail.

I mean currently, VHOST_SET_VRING_ADDR can fail. So userspace should
not assume it will always succeed.

Thanks

>


