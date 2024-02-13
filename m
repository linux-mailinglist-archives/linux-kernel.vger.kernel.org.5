Return-Path: <linux-kernel+bounces-63751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428998533F9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F158428ACC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0A5FF10;
	Tue, 13 Feb 2024 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3ADn3+X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9E5FEF6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836363; cv=none; b=YRfZtc2EkI2sE7QXk2XkixKc05N9uRJx5pIVzjjcsCasmcuYk8TetpaCi6QgL7QtwNYwzTDUhv6IG+buDTO1oLyPwymfI9ufazcrl5Fv5KSxfZR8XtzsJSdLBI66sT+wUfmgi+40nXksYyyEd1PrkX+c8hwn56riXC9GM7rJidU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836363; c=relaxed/simple;
	bh=lstsHYjspAxYFUqi/F86TsOmqitvcE7bU4snS9ufjxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVZgrMa5D2v7X3bZckuzBD1dA+hGNRVxoj5+g3YwDwl3WPOptBeiMsx1J32US7CTSnRpcJmoYWlVuvMCsp2R/A8w6pvl8RHJqKk0+3F4gi7rHnfoHJ//R358p5W+i/IaejIQSoMWJ2/5Du5UoNyfAxcawhoMU9EfFDK0o+6UQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3ADn3+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707836361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wg7XquR0+qsJPak8BqgKQIc4rSbNVnMGjqoiDcYeAqo=;
	b=f3ADn3+Xj7xYlvzkwnkkBb1MNLC1LCIwcSSiu7IYkX57nmGlHXl3onD8BjyhRvEFWiYxew
	eP95okuvA9u3xVaj9GocvlfazD+2jXCvqCu2xU+Ie9y3jRQoJDhP7XF0RlY+1FDfIciBTk
	dS+9XJI0XtgYUtztGTO8J8AOrvFFar8=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-yaDpxqXmPsi7NwG3c8nazg-1; Tue, 13 Feb 2024 09:59:19 -0500
X-MC-Unique: yaDpxqXmPsi7NwG3c8nazg-1
Received: by mail-yb1-f200.google.com with SMTP id 3f1490d57ef6-dc64f63d768so8247872276.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836359; x=1708441159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg7XquR0+qsJPak8BqgKQIc4rSbNVnMGjqoiDcYeAqo=;
        b=HKs9napy8UTyt4gflzqx2IWbtE55vcVAsU/WPgQHI6lQPg56tn8QKpygC6Tv7IlopM
         dVcQEgsmb6hgJrg1H4VoZMQcFQNngkjQdNzxQF0cj7MyJvaLQDRzpgQRrDjHRxPz6/2x
         p6f2OTrT7Jkeh2nkt9UwaU05GY4QkvTBo/onRRcQ8G57IxCH9cTewT1Hd1J5V//z0eZP
         JiUKpex+gTKNgINFy0TV9ANhfUJ0O3Q6yiq81b0jTFIGNSG1I82a+rEvFzhyTAcplHXg
         DNfVWOBLNplbRrwd66FI4VCE7khBIQVBW+/RAhFXFQUuh+cqLquwBZIa1uNzw6CwoDpM
         5mEw==
X-Forwarded-Encrypted: i=1; AJvYcCVKNpTmzE00pAdZe6moLN+fAMNs44MXtpBQg8r/QcoZ8zhGimWEOfKqCpQlTEgNCFUCPqLWQjqZ9isVZ47so4B6BKLiCcfvuIpWgtUp
X-Gm-Message-State: AOJu0YwwRTCuEFTIK3m5uI69Hqyaq+mq7HrCEVw+4sgN36lMIh4JA32T
	Q26Jt52vLeHO3S1SwCP38FKjza35tp8P4btFeLJhw3qPKwYrGMkg30SV+Lfq2wvYir7L00Nv84T
	uOubUfcj55aDm3WL6zlU/BETu773ut4nIM4KWAA34NkViYVRL3uhl2vsuVShwhoNc6uAd2O+YUK
	qs3P+gd7mJg8fUMYpcr/1QS9mQjiq5ydt0ZsnT
X-Received: by 2002:a25:10a:0:b0:dcc:7ad6:24df with SMTP id 10-20020a25010a000000b00dcc7ad624dfmr1988624ybb.17.1707836358751;
        Tue, 13 Feb 2024 06:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfGf3AV29voOESHDKbJSTz6HkBRsJzXQrBDiC4qHGQnuFLJUcRf1vHum6cTTK2KvFzGvKHvE5Smhd9Lew0jfg=
X-Received: by 2002:a25:10a:0:b0:dcc:7ad6:24df with SMTP id
 10-20020a25010a000000b00dcc7ad624dfmr1988614ybb.17.1707836358354; Tue, 13 Feb
 2024 06:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707834358-165470-1-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1707834358-165470-1-git-send-email-steven.sistare@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 13 Feb 2024 15:58:42 +0100
Message-ID: <CAJaqyWeE3hE3Mv29TL8K6CHTncexdOZXgD+BoehRCamiGfeBcA@mail.gmail.com>
Subject: Re: [PATCH V2] vdpa: skip suspend/resume ops if not DRIVER_OK
To: Steve Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:26=E2=80=AFPM Steve Sistare <steven.sistare@oracl=
e.com> wrote:
>
> If a vdpa device is not in state DRIVER_OK, then there is no driver state
> to preserve, so no need to call the suspend and resume driver ops.
>
> Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>"
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Please include a changelog from previous versions for the next series.

Thanks!

> ---
>  drivers/vhost/vdpa.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..aef92a7c57f3 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -595,6 +595,9 @@ static long vhost_vdpa_suspend(struct vhost_vdpa *v)
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
>
> +       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +               return 0;
> +
>         if (!ops->suspend)
>                 return -EOPNOTSUPP;
>
> @@ -615,6 +618,9 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         int ret;
>
> +       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +               return 0;
> +
>         if (!ops->resume)
>                 return -EOPNOTSUPP;
>
> --
> 2.39.3
>


