Return-Path: <linux-kernel+bounces-108128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D4880664
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7481C2212D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE33D0B8;
	Tue, 19 Mar 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lScGxJFz"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794C3FB8D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882021; cv=none; b=MXqXWV3tvFN3Emfu7yB21Ut7Yiw+aEsqz2j+Mb+2R73cHfc1r1OGdLmpSKWYNIygbchUUZXLq64bL09hVgS3MfsllzNOi9dl0wzXx1cuH6IShxTcDMeHU2xiAqWS6+SJgs8leMfdCR+Xd4aVQR0rvyY5lvSCRQufKrOGB3FDBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882021; c=relaxed/simple;
	bh=wpmJb/vawcr/bgZTTTWypOk/KxnH3sCIe+53p9+QArc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShDGamOy7uxM7L4cbBrRgBXNTeYgRnCcuyM80yqZ6Jl4ksfnOxerB1qiU2k48HHQD3PZij/1C2XQwg1kOXvQaRsa4bmVvGoCNexZ831aoOIpr+3TgsTb6r8sew/AIct9G/ubRxLkoLQmxAQ4bc/lnU7Ja2LE9pzfvnH1Ef/eX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lScGxJFz; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso7795872a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710882018; x=1711486818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiHFjOZrEM4sT036lCzm+As9FCgL6wQXfthUNkxfzew=;
        b=lScGxJFzdPXAS2VhAKigrNtZft+Ev/Vy/cvRAqhcW/ItpNMKPe8tSuGLOrfBs4e5As
         l8bRZeCMo2j6c7ALIYNoMCkJe8Z5OYEgl0XjztCusoK/9s9QneU4nolmhQvGIUqKs5cA
         H60zI5r2cUbKZ6GtZ1vvF2aoEDfiAKijulthMD6afY69TbytbS9FfIg8iqle9JauAg/6
         FlI0UsFeIEppMIN6sa36GRONAdRtBAuH9KDShbMy4PKzvuHRf2/2O+hX/ykw7vmYXp+L
         jlMuoSxPZV7+hKiiM0witkDycah52qUJGwEGHb/6cNN9a+KRy7y1QtmYhxrrKxpDu35n
         5/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882018; x=1711486818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiHFjOZrEM4sT036lCzm+As9FCgL6wQXfthUNkxfzew=;
        b=RYmU9U2aiMbCetxV9yn7X1pEv2fSNiLPEXwjjETiPM2CzdY1/9O5DDGBcsQiuOLXSF
         b5N46Mts/6CwnrYs+DiNpC3HIkvYAr7cIt7N7QiBKZkqUcD1k65pk9ZNIJCe5xqDn9Fz
         SHL6L0M5j+067Qp9voRHTASPbInBX1KHq5TJQcmXlosZrnDBdh2rmpUtA0RLPvqIRnSM
         Qj6nublEaGxxoruDjyMnjJXy8p2f38HfZvt1KGFgR7I3J+V05/taeRVyRZru7rWiew+r
         uEOHTLw2OoFGaU0WjI4934eUhfwRB+UVZAoZtoOGxp11FeceqFupCd+SB9kbFmMrF3Gm
         pKUw==
X-Forwarded-Encrypted: i=1; AJvYcCX9xUfo4TG3MSSpu4QwCzdp1rcG4GXMBKuLsAkRL0AQb4IBUC4TzH1K8ropwrc3wXhx1dSD3qdFfDvwderPK/5a4Ko+hkiOA6F/FWaR
X-Gm-Message-State: AOJu0YwkHnithBxBMlkEUOG1eNn3j9M4WdOzUrf8a88pBRb6EvINR7Wc
	LQqocYlvwKlkbBabQW2ggoL7fWAectMmRTZ3en0vlzRclKYjChWekFmXuYVdwYNyY5raspc5Ta6
	7E09XGP11heURhjBWHNEQVoyYYLC5hi3o/QTR
X-Google-Smtp-Source: AGHT+IGsCM7wuFKHn5ZhX2dMOIOSw8LutGxSmqkY9l0OFvWbZ/BAMaVK+Mi+Tr26DwvFctw8kZL19/iVtdSMVZfhoHs=
X-Received: by 2002:a05:6402:1f8c:b0:568:9b15:112e with SMTP id
 c12-20020a0564021f8c00b005689b15112emr11012930edc.19.1710882017946; Tue, 19
 Mar 2024 14:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9bba38df-5881-43f7-b1b3-f77e7b57bbe7.6c628ed6-0c2a-48f7-ba62-bcb23589b41f.60196f95-e445-4678-a450-875badf86498@emailsignatures365.codetwo.com>
 <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com> <AS8PR05MB9810B8AC6B5033FD6660EC69832C2@AS8PR05MB9810.eurprd05.prod.outlook.com>
In-Reply-To: <AS8PR05MB9810B8AC6B5033FD6660EC69832C2@AS8PR05MB9810.eurprd05.prod.outlook.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 19 Mar 2024 14:00:05 -0700
Message-ID: <CAFhGd8rBd7_7apXF9XTtBHkUG4FSmfa4YLkiQVow_pA05-9mSw@mail.gmail.com>
Subject: Re: [PATCH] tty: n_gsm: replace deprecated strncpy with strscpy
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 2:11=E2=80=AFAM Maarten Brock <Maarten.Brock@sttls.=
nl> wrote:
>
> Hi Justin,
>
> > ---
> > Note: build-tested only.
>
> Really? Without warnings?
>
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -4010,7 +4010,7 @@ static int gsm_create_network(struct gsm_dlci *dl=
ci,
> > struct gsm_netconfig *nc)
> >       mux_net =3D netdev_priv(net);
> >       mux_net->dlci =3D dlci;
> >       kref_init(&mux_net->ref);
> > -     strncpy(nc->if_name, net->name, IFNAMSIZ); /* return net name */
> > +     strscpy(nc->if_name, net->name); /* return net name */
>
> Where did IFNAMSIZ go?

There's a new 2-argument strscpy introduced in Commit e6584c3964f2f
("string: Allow 2-argument strscpy()"). Since the compiler can find
nc->if_name's size (which is =3D=3D IFNAMSIZ) it should be A-OK to swap to
this new form.

>
> Kind regards,
> Maarten Brock
>

Thanks
Justin

