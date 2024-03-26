Return-Path: <linux-kernel+bounces-119087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F4688C407
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0771F6149F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FAF74C05;
	Tue, 26 Mar 2024 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LZmL/4d/"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFE70CC2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460625; cv=none; b=AIFSmmlaiCDUp/CUp3inImMCEj4pdOQKXKZqUbkOrsEtc/8laiqOZmNQNLuSyXXhknx8QLm+3Cawgsihw3xhOXmpV4RsI6x37B9WVyLrF8St9rLTehkHMCljiD8nb/leTcGGSyXBofqvX+vcl88WCy+/Vzi71sfJaYxWygqIlS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460625; c=relaxed/simple;
	bh=ljMe5J3C6/sjNT1yUQPJWicsFLE8AOz/s4ig62CFcoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGO1a9D5TeCl6bUDtvbKGLJVMrbQVuXVFff7kcBnFwHM8VjiGA93uRRG2qaH+WIViKYTGVrpV0J0XyN2JNP/b1/ulODaAU0wfP0VJ3nBDwZUC0rBBaSbmSJAZ3Y9Lg0UhjN3MhpTmHIBlh44EAbZMIAhwpTDlkWQYHG8f/7ws/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LZmL/4d/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-696719f8dfcso24638686d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711460620; x=1712065420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruCfZHq43zIiPZrKz5ByYkrM7Dnhqu1J3mZX9CrPvSQ=;
        b=LZmL/4d/skmyJLELh6oIodn308sOvBbo35hv7F4qbyCgp9kE8hbUvwNc4W4LtGCLV9
         5Pl3eSsOxbezpOlTcDr2X6Rdc83EHvbjFYqBbmEYHRKUdxg+eTgtHrCLBop50KYW0ZZK
         OZCPF7VgNvWIQ30p7ErPVL65QdJZL/uXjMwJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460620; x=1712065420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruCfZHq43zIiPZrKz5ByYkrM7Dnhqu1J3mZX9CrPvSQ=;
        b=QgUEcYgp1VUsOO/ikZ6VgbvORQRGAoOMqeQeFTe5w3/URVauVpLr23E8X/siM2kbTO
         bNKuVfsnlbQ1c9Y6bU4xK14Vo0PIk3fUPsUeIvH6BKRGYx9t0pxykcVKuNW7BM1KN0uw
         rG3KiKkHcA/ejoSCjEl0+DZcB5R+jYC3lXNy6xUEsz7yqjk2Y/0AdU9nx5yF9mnKTrcw
         bEr2Q/vxRI7H5fnlIBAE0NYN37xsRNLAf18lJwpWThCeSVGKGYk/n50WIjl86wYBzk5M
         bSWLDGFsFLZ3W3jvquauYHfgynSt04/wimNDZpCy+O+luENQHx9QWcvnerNopz8MzRhf
         2lCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOC7bTJq+U4omeGLb7DjXnagOFDJjECUhffofN2TnCXLY+x5eJLsVviCIBfwtrzdQMNjpW95eQdAQQv8jVimyb4Gy3rvI0hD7cgWht
X-Gm-Message-State: AOJu0Yzf1P9IIldj0HTBs7bitLmIoFw7mweWeWcfj+durku27rEKH/vO
	Gl3oVr5ZTeBOYl3ATS93XZHvpDHqchpqRq/wsEIlUF8uatumlI0Fe729F4ZDZGT1TsepC1o27Pw
	=
X-Google-Smtp-Source: AGHT+IESz4IrqxPVqq0rJ6k0fjo/Vn0bvTvkXExHN2KweuvCKp94dvKBI98E1gic1c2bBZC8LK7pKA==
X-Received: by 2002:a05:6214:20a6:b0:696:3a48:1278 with SMTP id 6-20020a05621420a600b006963a481278mr11948528qvd.52.1711460620178;
        Tue, 26 Mar 2024 06:43:40 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id pt9-20020a056214048900b0068ff0778895sm5195823qvb.81.2024.03.26.06.43.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 06:43:39 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-428405a0205so304771cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:43:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQHScTtuxZErGQhCrFNwUnCbp2VEE9dCVxX7gp6Bfe2IuawbD3Hhh99A097CdGdkwbig5ZlS+2K/JACDZpxUFJFCh05fxOOO7PmULV
X-Received: by 2002:a05:622a:248c:b0:431:5ac0:a1e0 with SMTP id
 cn12-20020a05622a248c00b004315ac0a1e0mr246953qtb.12.1711460618700; Tue, 26
 Mar 2024 06:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325105452.529921-1-lma@chromium.org> <CAD=FV=VHps2d4dqLXCqE=hNMbk4pxeN607nFA0nEkd7chNAr3A@mail.gmail.com>
 <CAE5UKNpob9dT4YXSYKsrKGQ3cZP7o3OF7y-eb925Xd-gH3BEXA@mail.gmail.com>
In-Reply-To: <CAE5UKNpob9dT4YXSYKsrKGQ3cZP7o3OF7y-eb925Xd-gH3BEXA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 26 Mar 2024 06:43:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XdOOfHK-regXRzRkky0=iV2JMDPrKid2T_JS1=eu9H3w@mail.gmail.com>
Message-ID: <CAD=FV=XdOOfHK-regXRzRkky0=iV2JMDPrKid2T_JS1=eu9H3w@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 26, 2024 at 1:58=E2=80=AFAM =C5=81ukasz Majczak <lma@chromium.o=
rg> wrote:
>
> > nit: checkpatch should have yelled at you saying that you should
> > specify a commit in the format:
> >
> > commit b3a81b6c4fc6 ("HID: i2c-hid: check if device is there before
> > really probing")
> >
> I will do it, but I did run the checkpatch (with --strict option) and
> it didn't complain about anything.

Weird that checkpatch didn't yell, but perhaps somehow your commit
message didn't trigger its regex. ;-)



> > nit: I believe your sign off should be last. It's also unclear why two
> > signoffs. Did Radoslaw author it and you changed it? ...or was it
> > Co-Developed-by, or ...? You'll probably need to adjust your tags a
> > bit depending on the answers.
> >
> Yes, we've discussed this patch together and the original
> investigation was done by Rad.

Sounds good. Probably the best way to tag is these tags in this order:

Co-developed-by: Radoslaw Biernacki <rad@chromium.org>
Signed-off-by: Radoslaw Biernacki <rad@chromium.org>
Signed-off-by: Lukasz Majczak <lma@chromium.org>


> > Having both ends of the usleep be 400 is iffy. In this case it's at
> > probe time so I wonder if udelay() is better? If not, maybe give at
> > least _some_ margin?
> >
> >
> > > +       } while (tries-- > 0 && ret < 0);
> >
> According to Documentation/timers/timers-howto.rst:
> " SLEEPING FOR ~USECS OR SMALL MSECS ( 10us - 20ms):
>                 * Use usleep_range"
> It was also pointed out by checkpath (when I initially used msleep).
> I think giving some margin (eg. 400,500) would be ok.

Yeah, usleep_range(400, 500) would be fine. udelay(400) would also be
OK. The later would be more "accurate" but also more wasteful of CPU
cycles. Given that this is at probe time and only run a small handful
of times, it probably doesn't matter lots though perhaps the sleeping
function would allow more parallelism of other running probes.


-Doug

