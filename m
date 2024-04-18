Return-Path: <linux-kernel+bounces-149670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786628A945A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192A91F22035
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7C7757E7;
	Thu, 18 Apr 2024 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFSfEP9C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706173B79F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713426386; cv=none; b=E+YNOjQWXDjV2COCIAr58dKnxghjq8n+WykIn5ONxVr2bk+YyhCLOipGf36c4jxl80/CXQjf2c64s4mHQk/zl6AbxjuhGChx9vTJA2VIf05tgjux9qp/Tfeht5A+g85JCZ5pNtzOA9cUfV2QiT+IHgX0k+Og+2nDEgKvBnKo534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713426386; c=relaxed/simple;
	bh=llKGbsWJJugAlydvpNrlvNLT18fU0/e8MYbfh9aScqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JIhvfhuVPqpelId3IWf8DCqB7wJbHwkpJfHU0PXNRQ2jhKI9a91rrkPckXQAQrxFXkDqueWNUJHNYe14rgH24ZtA0n4RF14qWXxLfKEF5CEQB7zFfiHTvy0o5XdBC13Oic1maA6uKGLJieRbbfhlrr1ZeRJdHUh5FHRrBDeea8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFSfEP9C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713426384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8aynBx44eRT0HfwifIP95ObSSJcm85NJy67vieUQMc=;
	b=ZFSfEP9CWc0FACS5NI+TU8zNZvSVG8d9uJK91wL43RCHtSife06/g90y8ZWvwtYWU2fZhl
	8ID/KDSP2lbIlk4mcqXireaUV8dc27do1GldlR3oQZDCEx232IXlsNTB7GUoFZzTDYd6OL
	/CtctBg4NOkSSADYqBWftEUY7Z17z18=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-6eha89REMQyXgiw1jSyDTA-1; Thu, 18 Apr 2024 03:46:22 -0400
X-MC-Unique: 6eha89REMQyXgiw1jSyDTA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a4a1065dc4so841005a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713426378; x=1714031178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8aynBx44eRT0HfwifIP95ObSSJcm85NJy67vieUQMc=;
        b=ljDEKXiDw4gG+G3W0xGVmYZDedKfv3Z4EEp7NHwzv3fjZzjOZuFUO1oodadAi5Se+3
         sxjkudq7f5iaJ9h+fX6v3GVUfls53t31qv+rNL6rjOSk+57Ju1MBW2pk6Y8XQnudfnrk
         UealR5/5BQlxW+8zmOb4wsNHRavRFcoDnNzQk1dFg+xPZ1SGE7bpOWMHGPJ2m+o1/Df9
         Yiw3Ve8HmqsUULcU9Ja1FtuqkvP2EqG+5kHQ5fzJvMSIWBeRDlWcvHDr29QVO60yeTAt
         SNzNE3xhxaJzd8lfJNuH1YjeCiFLarpszSKebKv5rYrEsCal6oqr6c0bAQSdwNj5DHVp
         iSQg==
X-Forwarded-Encrypted: i=1; AJvYcCURCvFW5EMp1D2RnYW3upRqveMdPVfNEfzRaHCQinUr0IgLoTtLNecmwjBOAxdTZeJXtPyrVab3nTFHdfTYNqoqOehWQHUaRYjqRGwq
X-Gm-Message-State: AOJu0Yzlx+Xd2sRd32ZtBXjH0ADr1zyDeZH2daWjEthrCM3xsYXM+ECs
	S9tswgP8D3ao3OmWtf44SZySccrKhLRm+7jgyPrk8PDgPpFerO0PHMsftvcP78r4nEvQdoUXToY
	dnzkav5bTsjuzpsn/oA1jYWKM98SG95qcL1HdR6rEFZOV/m+j2Go2jLsxbnjrJ5GHYnUPQ1PCmq
	alscR/1+MftTDaBEAk1tY0e+3ysX+2daEKMakD
X-Received: by 2002:a17:90b:374c:b0:2ac:2b6:8d4f with SMTP id ne12-20020a17090b374c00b002ac02b68d4fmr212868pjb.45.1713426378248;
        Thu, 18 Apr 2024 00:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfqIf4uawCXSgXLqIrbzwcOfCcpO8u/zX70z+9Fok+E11Lzwon3KiW0+V16R2BfK3cXsls+i4CBab4pjMoDUQ=
X-Received: by 2002:a17:90b:374c:b0:2ac:2b6:8d4f with SMTP id
 ne12-20020a17090b374c00b002ac02b68d4fmr212852pjb.45.1713426377926; Thu, 18
 Apr 2024 00:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-1-hpa@redhat.com> <20240416053909.256319-2-hpa@redhat.com>
 <CAHp75VeuXuD7USd=bS1X=HCtKRPYWZ7r1NApPfDFZ4RRCUSRLg@mail.gmail.com>
In-Reply-To: <CAHp75VeuXuD7USd=bS1X=HCtKRPYWZ7r1NApPfDFZ4RRCUSRLg@mail.gmail.com>
From: Kate Hsuan <hpa@redhat.com>
Date: Thu, 18 Apr 2024 15:46:07 +0800
Message-ID: <CAEth8oFvVtxpd1n9rjzCqgUfHKaNCCyni8=hK9M+HvVeraPk4Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] platform: x86-android-tablets: other: Add swnode
 for Xiaomi pad2 indicator LED
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thank you for reviewing.

On Tue, Apr 16, 2024 at 9:46=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:39=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote=
:
> >
> > KTD2026 LED controller manages the indicator LED for Xiaomi pad2. The A=
CPI
> > for it is not properly made so the kernel can't get a correct descripti=
on.
> >
> > This work adds a description for this RGB LED controller and also sets =
a
> > trigger to indicate the changing event (bq27520-0-charging). When it is
> > charging, the indicator LED will be turned on.
>
> ...
>
> > +/*
> > + * The fwnode for ktd2026 on Xaomi pad2. It composed of a RGB LED node
>
> is composed

Okay.

>
> > + * with three subnodes for each color. The RGB LED node is named
> > + * "multi-led" to align with the name in the device tree.
> > + */
>
> ...
>
> > +static const struct software_node ktd2026_node =3D {
> > +       .name =3D "ktd2026"
>
> Please, leave a trailing comma as it's not a termination entry.

Okay.

>
> > +};
>
> (TBH I'm still unsure that having a name is a good idea even if it's
> supposed to be only a single device on the platform, but it's up to
> Hans who has an experience with those.)

Hans gave me an example without a name. I think, it can be dropped.
Moreover, Only one KTD2026 is on Xiaomi Pad2 so having a name is ok too.

>
> --
> With Best Regards,
> Andy Shevchenko
>


--=20
BR,
Kate


