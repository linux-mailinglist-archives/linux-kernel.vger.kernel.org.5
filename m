Return-Path: <linux-kernel+bounces-63076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD2852A90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43EF01C21AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D213918021;
	Tue, 13 Feb 2024 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Usbbman+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CB134CD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811745; cv=none; b=pkbJ56fGmVdKIcw5VB6W1ZkvizVBkn8NVrrfGkUkiyz0/1VpqQWLvblYJjFDOpdNfUDr8NRvjJ/34Cr1SLGfdKCL63R93snv/Qh+DrA67GJOZa37f6pwc8AP7XZn0HDFokhSzBUliE38Z4Jy3EK+MgKsGUQzSJFB0bYlHlmlQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811745; c=relaxed/simple;
	bh=Him3uu+VhmW+P97SEtrpmNC4Q3nMKaWaoPwFM5roTjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnHV3ikBXP8I8YHU54amSE3JJuZFg5d253nfysHJKiu3xF05h/MVYliXzp87SbMpHKUncI2mbWCan/8Tr45cUgs3HIUujXeutgnWL8XCYZlt8MBUOlXGvPXeFL5s1n9EgPXLm4uwCcR5sD9E3sMiJYVTn4Xw2InB6zMRw7V80RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Usbbman+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707811741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2znvQ6ssT4uVnr2WUtHz2BuLWLoRgEnRzMe+E1iIug=;
	b=Usbbman+AgSMfvbOFyLP0ITv6M2QdcD+s7JbmG+ovTIj1L7muv/he7qERAn3VMYBaG5tV8
	LY09Xb6l9m5xM91yGVIf7HWp+93UGbjU0Txle6r3wA7yHf6ssxIkuwN5bJikM98VjoVMSI
	AmD5jhXV+fq9BWYJl+E5p+lrLPQJF08=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-sp_88SMtOJGx1uxW7Wmcmw-1; Tue, 13 Feb 2024 03:08:58 -0500
X-MC-Unique: sp_88SMtOJGx1uxW7Wmcmw-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so4860919276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707811737; x=1708416537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2znvQ6ssT4uVnr2WUtHz2BuLWLoRgEnRzMe+E1iIug=;
        b=Hp8IhjvODu3T9dVHEK0iXzC7MQGjSsJVzQNKPH81D9lh8hBLxnDA/5ZguoatOptHDa
         ReKTS//42CzvWPQa3/7XyO+lHlPttdyvat+H3MkDfR45j2wmuZJoGReVhO6yDuJ07yQy
         xHeGOtlv14CvmX4dlmzR06qrXi1d6PbognprtI/+tae+LiV+h69k6cG+XPlKmhcQE/er
         quCFbExhJOQHUN1zYUZWKG7GvRJiNbUIcSqmTJweRkTDtDfVcisVJpPc8SO6CEPak3NP
         lofj+wf/iZv4BZ5WrjvGSTzOUNd7fAEFl/91XuyN3q4pQFz1IT7IDL5whmM6LZvUEplw
         Fl0g==
X-Forwarded-Encrypted: i=1; AJvYcCVwYCecjxeL+VaCN6qsPJFhVIEhyNqDtxLr2fM49UGFdz6GKlLb2et8jgJ3/j64m3hT0Z2VL+t2GUdbcSrJhK1YCogQFq7CCMuC/YpA
X-Gm-Message-State: AOJu0Yxv9YipL6o4P51qehFBtbgBNp33J27wYruWJWY2bseBqfxPGtrT
	4SEvPN2bMEE4Qo7NqRgdntNbOqxrc9U/GUWavDD9uqS6agu69xWYsVCfAPlUq4JigcWDPHV4Fi5
	tEa05ZU6GitBvBV0NNQowaMtqhsOSyFN3mW4pG94Us8ad5RI+jaf0O8ucQ+eHsDtze7ua18tSDO
	cpU3qkZdK/oJroCgPAGRYmqhv1hWKhujWo4U5t
X-Received: by 2002:a25:c5cc:0:b0:dcc:2da:e44e with SMTP id v195-20020a25c5cc000000b00dcc02dae44emr2067605ybe.61.1707811737591;
        Tue, 13 Feb 2024 00:08:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB85iA0wuX+bkrV7RmCTb44Tsqf91DLHEXY9MpcVOEMNtO1sH+p0OEz/bSxFF4evsBn6zlqrdsfYYEIKF7iFA=
X-Received: by 2002:a25:c5cc:0:b0:dcc:2da:e44e with SMTP id
 v195-20020a25c5cc000000b00dcc02dae44emr2067598ybe.61.1707811737307; Tue, 13
 Feb 2024 00:08:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707517799-137286-1-git-send-email-steven.sistare@oracle.com>
 <20240212031722-mutt-send-email-mst@kernel.org> <CAJaqyWcyoDCp6OVQQbU=Pd73tGki0dBQmb82=i5MmsLcZTZfyw@mail.gmail.com>
In-Reply-To: <CAJaqyWcyoDCp6OVQQbU=Pd73tGki0dBQmb82=i5MmsLcZTZfyw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 09:08:21 +0100
Message-ID: <CAJaqyWcmYMXvLmJ2JYbrcF818doz1og625CHst7fWED6oMBCHQ@mail.gmail.com>
Subject: Re: [PATCH V1] vdpa: suspend and resume require DRIVER_OK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, 
	virtualization <virtualization@lists.linux-foundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 8:49=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Feb 12, 2024 at 9:20=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Feb 09, 2024 at 02:29:59PM -0800, Steve Sistare wrote:
> > > Calling suspend or resume requires VIRTIO_CONFIG_S_DRIVER_OK, for all
> > > vdpa devices.
> > >
> > > Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >
> > I don't think failing suspend or resume makes sense though -
> > e.g. practically failing suspend will just prevent sleeping I think -
> > why should guest not having driver loaded prevent
> > system suspend?
> >
>
> In the QEMU case the vhost device has not started, so QEMU should
> allow the system suspension.
>
> I haven't tested the QEMU behavior on suspend (not poweroff) with the
> guest driver loaded, but I think QEMU should indeed block the
> suspension, as there is no way to recover the device after that
> without the guest cooperation?
>
> > there's also state such as features set which does need to be
> > preserved.
> >
>
> That's true if the device does not support resuming. Well, in the
> particular case of features, maybe we need to keep it, as userspace
> could call VHOST_GET_FEATURES. But maybe we can clean some things,
> right.
>
> > I think the thing to do is to skip invoking suspend/resume callback, an=
d in
> > fact checking suspend/resume altogether.
> >
>
> I don't follow this. What should be done in this cases by QEMU?
> 1) The device does not support suspend
> 2) The device support suspend but not resume
>
> In my opinion 1) should be forbidden, as we don't support to resume
> the device properly, and 2) can be allowed by fetching all the state.
>

Ok I missed the whole other thread, everything is clear now.

Thanks!

> Thanks!
>
> > > ---
> > >  drivers/vhost/vdpa.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index bc4a51e4638b..ce1882acfc3b 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -598,6 +598,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa =
*v)
> > >       if (!ops->suspend)
> > >               return -EOPNOTSUPP;
> > >
> > > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +             return -EINVAL;
> > > +
> > >       ret =3D ops->suspend(vdpa);
> > >       if (!ret)
> > >               v->suspended =3D true;
> > > @@ -618,6 +621,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *=
v)
> > >       if (!ops->resume)
> > >               return -EOPNOTSUPP;
> > >
> > > +     if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +             return -EINVAL;
> > > +
> > >       ret =3D ops->resume(vdpa);
> > >       if (!ret)
> > >               v->suspended =3D false;
> > > --
> > > 2.39.3
> >
> >


