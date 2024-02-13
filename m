Return-Path: <linux-kernel+bounces-63059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA008852A44
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD661C21D28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4C17996;
	Tue, 13 Feb 2024 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KG8R4afc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AD17980
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810603; cv=none; b=STrFmj+WFdaI33TEoLFmUySje53DireZ1TC/43Da59rJNiLTzQPlaxgBKfHpoH5wsYGo/buYLpNRzykDJWc2JkV2j/6Y6un8v+nFgavlyTJ6oPPiDTazQwI6EfZ8BZhWMtu0eUzTIBKE9eXKWMFrqzUt8oZ6T8v3DFNG18jZn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810603; c=relaxed/simple;
	bh=IGlJct8UocHdJXhuIkJ7ySUjtintsyyQjIJPu0zBh04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNY6hh+cYyMQRfLMJd2EqbDZcTVvYNU/pVENTDvlr4IlWrWdaJ05ngkxRXsE8EcLNDlv91QGlLRoAKHdMv6EY8xC4UYze24S3+Dg/Q9oPq0iA8pZ6FmUtlt1Lq4gf1yw9oxXl6L0qo3YmSHWh1y71bBP+A8vBdXM+v7p0Wft4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KG8R4afc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707810600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WD8HyMi+KDRNtPWM+Apb/3cJueC+uBY6p5Bp0UVVdjU=;
	b=KG8R4afc0U7TgOVs8SM7z7AridpfKpx6QzNkj1iiicsfsXsJ0IZvkyFKo3xIiwSgO7X4Vc
	FrL0Lp61Su4ensm1D0MURZGetK1F77uBhzkQiJTPgNgFgYAnkKQLiBqDwlp6ysTCTQuGXs
	ItcXASZ5gKup9ibxyk3OXA27oK3JKbc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-jhctR3YeOpqHrTMkU9MiLg-1; Tue, 13 Feb 2024 02:49:58 -0500
X-MC-Unique: jhctR3YeOpqHrTMkU9MiLg-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dc693399655so7409961276.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810598; x=1708415398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WD8HyMi+KDRNtPWM+Apb/3cJueC+uBY6p5Bp0UVVdjU=;
        b=e67Nm4YaUqky0uHdloSJg0nYNPYW6dz1D/c9PtoYjgI2hfamO3WwuM0GNui9jv3kSt
         pDZbZny+Qfx+gX5DjjHehrQFsyBc/8AaDn33Uli+IRISd6yoEUGv6U2PWCKWOcVzHBkY
         SnJE4fNspynLF0td1FTpnpuz5aI2FEM3xnAGIyn62arSVzD8FuEwDMgu+aWgfyLbn086
         jDYqc8WnFcjo62yAqeuku6mxjmaU4ny5lN9LfiF2hzrZnMS0dEV71m/xKQZI3o3qwdXe
         47ZMMaOCor23P3X0gSoIcv51prsRNd0YTXRb/ESITiY7CCyySOBJheqIB3sGKBQrhdMF
         pX/A==
X-Gm-Message-State: AOJu0Yw19ua7EdXrUIxTgYr7gTmZo+41UidUODwHXhGnvm1yoeQ8iWMe
	L9ZQEcdGYdAdp0Z8KvYTpgVETkuxl86GoNPEl8TgDztXBkDbC3wTlEAGztl15QtNbelWavIxR9O
	sI14ZHxkrgljSqx2gQrDWzbVDv3pSHajHoM3BeU0sNOWMMipdKqOgbwlYmETDwnrO2RtVk1XYUw
	CU7dtnPJoFbS2yRDbEoRE45V1xYt8eHtJm3Od+
X-Received: by 2002:a25:820d:0:b0:dbd:5bfa:9681 with SMTP id q13-20020a25820d000000b00dbd5bfa9681mr7462173ybk.37.1707810598327;
        Mon, 12 Feb 2024 23:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYSPexmJxuxFZYyjtjDwgf/rqjhXzefnrHu+jPWU4Rz8j5IBWPCVxEBALDrlrkPWF6ACDM/ejf9firzPkcRGw=
X-Received: by 2002:a25:820d:0:b0:dbd:5bfa:9681 with SMTP id
 q13-20020a25820d000000b00dbd5bfa9681mr7462164ybk.37.1707810598045; Mon, 12
 Feb 2024 23:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com> <20240212031722-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240212031722-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 08:49:21 +0100
Message-ID: <CAJaqyWcyoDCp6OVQQbU=Pd73tGki0dBQmb82=i5MmsLcZTZfyw@mail.gmail.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 9:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> > Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> > vdpa devices.
> >
> > Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>
> I don't think failing suspend or resume makes sense though -
> e.g. practically failing suspend will just prevent sleeping I think -
> why should guest not having driver loaded prevent
> system suspend?
>

In the QEMU case the vhost device has not started, so QEMU should
allow the system suspension.

I haven't tested the QEMU behavior on suspend (not poweroff) with the
guest driver loaded, but I think QEMU should indeed block the
suspension, as there is no way to recover the device after that
without the guest cooperation?

> there's also state such as features set which does need to be
> preserved.
>

That's true if the device does not support resuming. Well, in the
particular case of features, maybe we need to keep it, as userspace
could call VHOST_GET_FEATURES. But maybe we can clean some things,
right.

> I think the thing to do is to skip invoking suspend/resume callback, and =
in
> fact checking suspend/resume altogether.
>

I don't follow this. What should be done in this cases by QEMU?
1) The device does not support suspend
2) The device support suspend but not resume

In my opinion 1) should be forbidden, as we don't support to resume
the device properly, and 2) can be allowed by fetching all the state.

Thanks!

> > ---
> >  drivers/vhost/vdpa.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index bc4a51e4638b..ce1882acfc3b 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v=
)
> >       if (!ops->suspend)
> >               return -EOPNOTSUPP;
> >
> > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             return -EINVAL;
> > +
> >       ret =3D ops->suspend(vdpa);
> >       if (!ret)
> >               v->suspended =3D true;
> > @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
> >       if (!ops->resume)
> >               return -EOPNOTSUPP;
> >
> > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             return -EINVAL;
> > +
> >       ret =3D ops->resume(vdpa);
> >       if (!ret)
> >               v->suspended =3D false;
> > --
> > 2.39.3
>
>


