Return-Path: <linux-kernel+bounces-164853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB388B83FD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360A6B218B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CE4C7D;
	Wed,  1 May 2024 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK/2q9ST"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9424400
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527555; cv=none; b=Oq7itoQPb8i68bF0CdnWkpCKaaNqY1FahEdrmQ6OfaRIdGMlHxuvBcntKvUrPLOP+39YvLinFVIx5OclXKtsO1SMlWRC6wXAfFMuwlSlOb+if3SGrOCPi/JQcUpQ3nKO9KdlXwdoWSSDMCOUVabVnZC79M7Iq7yJhhk2PnYMCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527555; c=relaxed/simple;
	bh=ZOKWZUi05zz0D62QdKdRJgfUuzw3xMnqQIHoO2Zede4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVJlgUD4g4ai3eyM1v9Z5D+Dh1lck9N5p2oC/FRwZZNc3Vrmh2cR9v4YQ7/uS+MSJG3voaMfYG0CtFmANXewugxMqeIZ5Mj8ydf6DYQ0SPDwgY62En904klWkrkD7eF7JRKZQsOb0Gn3EstvcR/PG663laqO2OeyErWZnt+SF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK/2q9ST; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a55bf737cecso757644066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 18:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714527552; x=1715132352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w42tyA793aCNXb9Ajddb8vopQZByqQw52jMKwKE/CaQ=;
        b=CK/2q9STRqrRlifsc0fDW1BW0gVx2vDsDBbALKgs9v5VpX76NYzHXj4+Gz+w6UW1V6
         MYjdqtuljEcilrRQPLrX+o3BzsXrwLiia7d1MSckBfKMy2Nd/+WCB5wFHgDVlm3ByeNH
         Baio5V02nwgzIVkygAWhP5x2B5Bhr40afEyilXTplx0YgIIyrK5+chRMIrD+W9AXZGOX
         AU9+H0O34M4e7AZE5S7c/YzvuZOt9zLIiqUpDKmSojxZiv/qYEowq2tHkE1djBokQlDT
         PBTF+GQ8fWbr0U92s0lLFZplNVDU31tJPLHCe7YgKdIJsgqqSxaTMIk/en6ZECsmMuLd
         FBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714527552; x=1715132352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w42tyA793aCNXb9Ajddb8vopQZByqQw52jMKwKE/CaQ=;
        b=msxkGQGZc4k1IwDQPF+t3diX1WNOxquBUtOT/PgQtUXluoJRipqMdBLOtJX8Qk+k2l
         DwSsdpUeqqBQy2XLLFV6+0EjMMdPiVdVvkac6xM1MsG+c5B53FyqWfs1qH6Uis2ewcql
         ddAJNRhaQGEUwy80PIYYB2rAQgKLh+WemIyjQd2CNYTYRY5PzVmJhHgR0IMTPUmhs9xU
         x6AM9bnre81rfMNpvY8qo8wHRMRdi3de8gnNs0+3Okwcs+yjKRxQaOu/XZ/3OJ+wZB5G
         N8zS/mnvYTvrZIBJu6tRmxiSIVDkXFFkR9NfSnwr30q43G/iUaUycBER33l8nKTQylgz
         N1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu6GDvGmOy11APx7vraU6G8gbdtr/9jcahk4OqIx0EW4GzhGO8vdvDSI4ZAPiHuuewVHN2Rv8E5eU+jEC2Np5lgMhleCy0KJISfmxR
X-Gm-Message-State: AOJu0Yy7RUUjssqPKNysOzzSosv/YVEvFgR6uw/s42V4mhytDqOzYxw8
	TPqfdNGdJjqsOjlZ8UbIHaAy7+rSlb1gDyteTRprO+wD/7sx5ODOzzzHn6cCwftBgFJlvJ35D5t
	ozEQ8zlAHWFNIP4+zKDFgpJ+aMkc=
X-Google-Smtp-Source: AGHT+IHTt9hkuUv1jlQEDnVEQyDdP1uRFNrzY4K+zDyZ9iaCcKLucoM42nrmkpL3+LrAOzKtJshucMQentO7nwg17y4=
X-Received: by 2002:a17:906:d8c5:b0:a53:4cae:e40 with SMTP id
 re5-20020a170906d8c500b00a534cae0e40mr798998ejb.25.1714527551995; Tue, 30 Apr
 2024 18:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410170825.1132324-1-ben.levinsky@amd.com>
 <24bd320a-ba89-4ad0-a905-6915e00b705d@amd.com> <1ce0b581-4613-4899-ada1-5d322f006890@amd.com>
In-Reply-To: <1ce0b581-4613-4899-ada1-5d322f006890@amd.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 30 Apr 2024 20:39:00 -0500
Message-ID: <CABb+yY0vTioFvQJcfxvLkODVMfQfKxnQnLYMJ8MXBwKO357AqA@mail.gmail.com>
Subject: Re: Fwd: [PATCH v3 0/3] mailbox: zynqmp: Enable Bufferless IPIs for
 Versal based SOCs
To: Ben Levinsky <ben.levinsky@amd.com>
Cc: Tanmay Shah <tanmay.shah@amd.com>, Michal Simek <michal.simek@amd.com>, 
	shubhrajyoti.datta@amd.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 9:40=E2=80=AFAM Ben Levinsky <ben.levinsky@amd.com>=
 wrote:
>
> Ping For Review

It's a beautiful patchset :)

-jassi


> > -------- Forwarded Message --------
> > Subject: [PATCH v3 0/3] mailbox: zynqmp: Enable Bufferless IPIs for Ver=
sal based SOCs
> > Date: Wed, 10 Apr 2024 10:08:22 -0700
> > From: Ben Levinsky <ben.levinsky@amd.com>
> > To: jassisinghbrar@gmail.com, michal.simek@amd.com, shubhrajyoti.datta@=
amd.com, tanmay.shah@amd.com, linux-kernel@vger.kernel.org, linux-arm-kerne=
l@lists.infradead.org
> >
> > For Xilinx-AMD Versal and Versal NET SOC's there exist also
> > inter-processor-interrupts (IPIs) without IPI Message Buffers. For thes=
e
> > enable use of IPI Mailbox driver for send/receive as well.
> >
> > This is enabled with new compatible string: "xlnx,versal-ipi-mailbox"
> >
> > Original, buffered usage for ZynqMP based SOC is still supported.
> >
> > Note that Versal bindings are already present in xlnx,zynqmp-ipi-mailbo=
x.yaml
> >
> > v2:
> > - formatting in 2/3 patch
> > - remove extra handling in 3/3 versal_ipi_setup()
> > v3:
> > 1/3 - removed additional newline to avoid
> > ./scripts/checkpatch.pl --strict -f drivers/mailbox/zynqmp-ipi-mailbox.=
c
> > CHECK: Please don't use multiple blank lines
> > #434: FILE: drivers/mailbox/zynqmp-ipi-mailbox.c:434:
> > +
> > +
> > 2/3 - remove unused variable dev
> > drivers/mailbox/zynqmp-ipi-mailbox.c:565:24: warning: variable 'dev' se=
t but not
> > used [-Wunused-but-set-variable]
> >          struct device *mdev, *dev;
> > 3/3 - remove unused variable dev
> >                                ^
> > drivers/mailbox/zynqmp-ipi-mailbox.c:666:24: warning: variable 'dev' se=
t but not
> > used [-Wunused-but-set-variable]
> >          struct device *mdev, *dev;
> >                                ^
> >
> > Ben Levinsky (3):
> >   mailbox: zynqmp: Move of_match structure closer to usage
> >   mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
> >   mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's
> >
> >  drivers/mailbox/zynqmp-ipi-mailbox.c | 257 ++++++++++++++++++++++-----
> >  1 file changed, 212 insertions(+), 45 deletions(-)
> >

