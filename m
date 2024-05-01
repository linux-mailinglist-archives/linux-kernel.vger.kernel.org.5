Return-Path: <linux-kernel+bounces-165011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B786D8B8673
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C193283E69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BE4DA14;
	Wed,  1 May 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5dq+4r2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE664AEC1;
	Wed,  1 May 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550058; cv=none; b=W5PmIbk2bBVmKMCnkhXvB8ys53IynJchbkRJOCG72LuKpaP3+f6MyhCnufapgIUlRqFq4O81CaOmAXrrUsU0NsJZn8Wgt40tuKPGGp+RS1TDZH1IrrQhD0Y3xWDyvwtQxXJLz2ARIqgm3pbqYWrrncD8pWhzhSHPeSVr7czGFmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550058; c=relaxed/simple;
	bh=wedsxPYnWe3svN27pHrKR9fEba7DnsL9R9lkf2Ec65I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Mqg+MCfYxZmFkaL3yyiB0Uq+pIUE3llK4jUiilfTp9DXl15NOHIhCCgpLMfDO7UnNHpBcCmUtJkCfPZqzCXv4B7+30xgxQJMakvOHayfk+ezm8yt8dyl3bo7h60Ouo2fj7hjK+klEb6f0LqrIOc+7b+/iUpHpP+QeqfY7rf4WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5dq+4r2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e86d56b3bcso60023645ad.1;
        Wed, 01 May 2024 00:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714550056; x=1715154856; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdi7hSvh4vLFL7CRd236GwWPyYOKcCvd2F/0NPzmT58=;
        b=k5dq+4r286KOlGnaO8EeR5F1SycrSfaz4onEaAX/LIhAHajWsQ75I2fijm++A/vExV
         mHZtFInC6BLU+UzmjgL0BaCNlM+f05fpmEUmB7P6W3pvkvlrucuiSDQOcJHX3/MAS/qP
         /taYJy20oVQwUC5SkSBjhvWc3D1CiNom49IznOVkQKD9WKwdVAgehMBk42c8OJRN1kfy
         AZATEw7mSpzagcbzj3il0Y18lYE2rHI9Bjx/TjLueNZ5JXjOaUYjMpXwjGvZ6RZyOKfh
         fvPV2Y19BM/Vxro1Db0Bv890Qmhg2hapT5PuNSCHqwjQ2/LHR8WTR58kkRlIfF6iasfT
         u3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714550056; x=1715154856;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdi7hSvh4vLFL7CRd236GwWPyYOKcCvd2F/0NPzmT58=;
        b=gHSmXjD5HI9fSLLvAQSfR4/ASCIzrRZ+K6Doh2ntZH5br4qsetBIgfz98LlmZ7W6sd
         6p7olteO6Y7Sw2VQkRlbH3UvQzOnJW2GI9gmpZkGOiWKsOpmCPjI3iDYKimv4j88Klw+
         pf47Ptwae9kF5bj6e3vr4iMfkijduDWmmCkqFD3dGAUwA0c+WK82Kx++TjrhQp0q0g8M
         zU9eGoIxka0YQIWVi3J62iivyKvSBVPF8LQIi1dhlyjfR1d5DQWbzZxMyTYPnKE0Dijo
         IyIHPGnJYBDbbeMVqyG93LBVe23aXJyAPS85WQwspikiWnfNmsxPhEC6Z+3PW9qNlnGc
         TYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWZTWC9FMI+vvVLLpQ+6sjDWQJC2lVvY0YwO9C3pL1Jl9lEsowpAmJDJe+bgCuOG/0JZIfEY/JIhdylPb7IqxwKauwGO3POdGvgIJvgpIkh/Iriquv1uSsG1KKaGVsxBm2o/kNz5cCHDXE=
X-Gm-Message-State: AOJu0YwsIAFfeGpwaAUvWeCTU9GY2SyDbSbJp+/R2LjqktyM9xxLm+km
	reWxe8soxKZWcf9NOh+Kja5O0xu05owCvg4OTq1ZEJyofckY/uRCy8nopExrS6mk5ADF8UVE+0D
	kwJAsHTn548iPVHx3p12QEJJucPY=
X-Google-Smtp-Source: AGHT+IFaK0WaTn9UV3z7IZGtBN4HIzSs6rKN988oGAq/YIF6bhzaKPI5SWcyRZSADAJipq0LBd/o5ksfLlG9XD69NCE=
X-Received: by 2002:a17:90b:24c:b0:2ad:f278:77b4 with SMTP id
 fz12-20020a17090b024c00b002adf27877b4mr1927070pjb.23.1714550056415; Wed, 01
 May 2024 00:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308121021.1732-1-yongsuyoo0215@gmail.com> <CANXPkT4_9dkLVe8VUBaOceFRTBMqZOD=u9a1=X54TqvcOjv67A@mail.gmail.com>
In-Reply-To: <CANXPkT4_9dkLVe8VUBaOceFRTBMqZOD=u9a1=X54TqvcOjv67A@mail.gmail.com>
From: YongSu Yoo <yongsuyoo0215@gmail.com>
Date: Wed, 1 May 2024 16:54:07 +0900
Message-ID: <CANXPkT5YMTLJTmZLv3yB8Db4vDB_iDmyqNh9aoPGyBdzLKUA2w@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_ca_en50221: Fix a bug for detecting CI MODULE
To: mchehab@kernel.org, yongsuyoo0215@gmail.com, v4bel@theori.io, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear All

Can you review this patch ?
Can you share how this is going ?

2024=EB=85=84 4=EC=9B=94 11=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:03, Y=
ongSu Yoo <yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Dear All
>
> Can you review this patch ?
> Can you share how this modification is going ?
>
> 2024=EB=85=84 3=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:10, =
<yongsuyoo0215@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > From: Yongsu yoo <yongsuyoo0215@gmail.com>
> >
> > Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>
> >
> > In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET
> > ioctl is called, the dvb_ca_en50221_slot_shutdown will also be called.
> > Inside of the dvb_ca_en50221_slot_shutdown,
> > the ca->slot_info[slot].slot_state will become DVB_CA_SLOTSTATE_NONE.
> > In the most of cases, the ca->slot_info[slot].slot_state will quickly
> > becomes restored to other states by the subsequent operations of the
> > thread dvb_ca_en50221_thread_state_machine.
> > But in some rare cases, when the CA_GET_SLOT_INFO ioctl is immediately
> > called after the CA_RESET ioctl is called, the
> > the ca->slot_info[slot].slot_state can still remains at
> > DVB_CA_SLOTSTATE_NONE, and this causes CA_GET_SLOT_INFO ioctl not to
> > return CA_CI_MODULE_PRESENT as info->flags even if CA_CI_MODULE is
> > really connected on TV. This means that the CA_GET_SLOT_INFO ioctl
> > does not return right informtion. This is a Bug. We fix this bug.
> > ---
> >  drivers/media/dvb-core/dvb_ca_en50221.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dv=
b-core/dvb_ca_en50221.c
> > index baf64540dc00..8d37c3c13227 100644
> > --- a/drivers/media/dvb-core/dvb_ca_en50221.c
> > +++ b/drivers/media/dvb-core/dvb_ca_en50221.c
> > @@ -1403,6 +1403,10 @@ static int dvb_ca_en50221_io_do_ioctl(struct fil=
e *file,
> >                     (sl->slot_state !=3D DVB_CA_SLOTSTATE_INVALID)) {
> >                         info->flags =3D CA_CI_MODULE_PRESENT;
> >                 }
> > +               if ((sl->slot_state =3D=3D DVB_CA_SLOTSTATE_NONE) &&
> > +                   (sl->camchange_type =3D=3D DVB_CA_EN50221_CAMCHANGE=
_INSERTED)) {
> > +                       info->flags =3D CA_CI_MODULE_PRESENT;
> > +               }
> >                 if (sl->slot_state =3D=3D DVB_CA_SLOTSTATE_RUNNING)
> >                         info->flags |=3D CA_CI_MODULE_READY;
> >                 break;
> > --
> > 2.17.1
> >

