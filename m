Return-Path: <linux-kernel+bounces-160090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287AB8B38FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75221F21474
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEAF148318;
	Fri, 26 Apr 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UahOrDm7"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B5147C99;
	Fri, 26 Apr 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139559; cv=none; b=CN6k/fc9PQjLrAdu/AJFszdPs9lFyNHiVlJad47NBaxgyxnc7aTaBuM847cZ84/idH3lKKi2kutVi2yE3c5XzQB2Iqw0+Cf5V8EtMt8kYHmtzDjK3bj2MHXr0e50+J+V5O5ss82noQKUyRr2NJGTrbaan1SUaE+ldk/Et/R+9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139559; c=relaxed/simple;
	bh=gMtHGUb4M5s/DcbVs8UWDKiLf+2lO+ad/+QYz4lqtIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQcy5feRDrlqWjBYYJp0nAMjLIYKaJkqe1+irVQzu+UOG84/uEpzeSL4oRv/G6M6asc3APPpN5EBYQAGGV5qygoKSZ763t+vKNDDBOfqRP49JSPvYhYDeXRO/WZmnx+9gQM0zJqeuKqWLK7LJc7naU3Q04vPRkCQ7Vi1xA4dgP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UahOrDm7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so5643036a12.0;
        Fri, 26 Apr 2024 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139555; x=1714744355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdC/8U1Kxz1mEJxl3Cf8RJ3ZSt5Qcg4msblYJFG7Ecg=;
        b=UahOrDm7I27KO8ZNv/bI1dltnxpFzf20FGUhMmFjnvGXooh9sPdLgcj9c/kLiX9XCg
         DIMy2/I2lZNoA6z9WupBtvJ534IoKNsNORtXN1U/nR9QsGWq5BMOM5XsP2Hugcs3cPUL
         hrlJib5kvNd93NXL54D/EkcdvLRScx6Wz9igp2aBAh6f5TJrY1j61HAXNwZ0NjsXz2Ck
         Q99vpl0Y8Cnv08zyso6TVFW0iHsEcuztUNXr4RleIzSWYHi7/b1d8n5VctfnRg9RQHz7
         QswzLfbwJZvqfuBslUAP9kyR4/1gYvFcH7sl1NnZHFhFEc2H1zv78GL1OrLDaAQjpLmp
         56oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139555; x=1714744355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdC/8U1Kxz1mEJxl3Cf8RJ3ZSt5Qcg4msblYJFG7Ecg=;
        b=Xbv1UY2M67QQsSiUWWfhAsKC9PjnS9mL9Mrj/PFpQm36FK/uIlXuXWAp2yOgScpoAU
         lF9kwB0BO8kIfTfHRMzIpoV6FjNLf21j8mZJvyMVLhjQCKTM3ZIhMzgu+Ae3dueA9MR4
         c5l+hNIoQ012WjMhX1UePRJsBCCOzOED5KlhYC2xVfO9VP/g6/SMgZVJumPY1wAaJuud
         2rk6d9O80Qjhpw+hDykF8ijnLxGRozJmLoR39PzhbSidV6MfoU/07Fx12WZ9vQsWaVlq
         8/JQiGuqZTz1JaLFynVMfQi/OzUzggLFic90HNAhzoQ/GA4icp4FN57z3qsxL1KHTT8e
         FcSw==
X-Forwarded-Encrypted: i=1; AJvYcCWyxTipuDaXprWw4W8rvf1P/PEgEZ4QHF0i0j5IEfhgNHPi8OfcM8TA4DCv781al+gDGne+E4Cb2qxo7OPJkzgGKF1LhX4uI2zbj4w6XhfPWhzh6icgR3wr/uamg8IYLcpgCNESOa2KWXPvVClcs0AnWPnrLZwuj3YldIkpe/q0g9YmtLzy
X-Gm-Message-State: AOJu0Yzcr+BHj/MJR/13ndsLt5GFsz+vhw1I5/L0uB2KoInEfZImGa26
	q3kpBJt7lwZqaXb5UWRJC8OiXj+e0Fx2zoIK1c8g5y0sVNX7fG0jkq/9pfUPsZ8l6yJAAXbwEeZ
	wfwrguiHMruF+mb61sYg5F+pjxeo=
X-Google-Smtp-Source: AGHT+IHXG0x9JABiG3fS/W399UgGKpb+PNo0PDtz+cJyxFStDFH5E0ooy9h6KyWG0L0HmW6tLrPDFwGQ90Prtx1rfq8=
X-Received: by 2002:a17:906:d107:b0:a4e:24e6:9880 with SMTP id
 b7-20020a170906d10700b00a4e24e69880mr6030876ejz.33.1714139555199; Fri, 26 Apr
 2024 06:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404222009.670685-1-andreas@kemnade.info> <20240404222009.670685-3-andreas@kemnade.info>
 <CAHp75VeZ9U_+1rJQjr4KvvzjYQGzfKtk+BK00vqvKcVn2-yP3g@mail.gmail.com>
 <20240405182832.4e457695@aktux> <CAHp75VckoDheCN-KQ0KcSk9rE_-cXFUujurtA4sK6KAixDttQQ@mail.gmail.com>
 <20240425185417.0a5f9c19@aktux> <7dd1eb70-b011-4247-aea9-173ddcd17dc7@kaechele.ca>
 <20240426095617.4e442681@aktux>
In-Reply-To: <20240426095617.4e442681@aktux>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 26 Apr 2024 16:51:59 +0300
Message-ID: <CAHp75VdA_peJBWXFWSs-vDxA86y6MG0J7ixzXExqDxJJzfJ7mA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: edt-ft5x06 - add ft5426
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Felix Kaechele <felix@kaechele.ca>, dmitry.torokhov@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	o.rempel@pengutronix.de, u.kleine-koenig@pengutronix.de, hdegoede@redhat.com, 
	ye.xingchen@zte.com.cn, p.puschmann@pironex.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	caleb.connolly@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:56=E2=80=AFAM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
> On Thu, 25 Apr 2024 22:54:13 -0400
> Felix Kaechele <felix@kaechele.ca> wrote:
> > On 2024-04-25 12:54, Andreas Kemnade wrote:
> > > On Fri, 5 Apr 2024 20:21:19 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > >> On Fri, Apr 5, 2024 at 7:28=E2=80=AFPM Andreas Kemnade <andreas@kemn=
ade.info> wrote: >>> On Fri, 5 Apr 2024 18:13:45 +0300
> > >>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

..

> > >>>> Why a different vendor prefix?
> >
> > >>> I sorted by the numbers. Looking at datasheets for other controller=
s I see >>> https://www.displayfuture.com/Display/datasheet/controller/FT5x=
06.pdf
> > >>> it only mentions FocalTech Systems Co., Ltd.
> > >>
> > >> But does the driver use that? AFAICS it uses edt. Perhaps it's due t=
o
> > >> a business split, not to my knowledge anyway.
> >
> > I've been looking into this over the past few weeks as I was working on
> > mainline support for an Android device.
> > And please forgive me if any of the following is not fully accurate, I'=
m
> > not an industry expert.
> >
> > After some research, my understanding of this is as follows:
> >
> > - There are companies that make touch ICs, LCD driver ICs and sometimes
> > even ICs that are both. Focaltech or Himax are examples of such compani=
es.
> >
> > - There are companies that make LCMs. These are complete assemblies of
> > panel, backlight, touch layer and driver circuitry PCBs. This is what
> > OEMs generally purchase when they design a consumer device. Emerging
> > Display Technologies Corp. (EDT) is such a LCM manufacturing company.
> > More often than not LCM manufacturers do not make their own driver ICs.
> >
> > LCM manufacturers include ICs from Focaltech in their LCMs.
> > To my knowledge Focaltech is not a manufacturer of LCMs.
> >
> > As such, an interpretation of the compatible string "edt,edt-ft5406"
> > could be: Unspecified EDT LCM with Focaltech FT5406 IC.
> >
> >  From my perspective, more correct would either be something like
> > "edt,etm070001bdh6" (the LCM by EDT that contains this IC, especially i=
f
> > it had model specific quirks) or "focaltech,ft5406".
> > But "edt,edt-ft5406" is incorrect if being specific is the goal here.
> > Given that the driver predates much of the DT binding rigour it's what
> > we have now though.
> >
> I think focaltech,ft5406 is better because it is consistent with other dr=
ivers/
> bindings. We do not specify the display it is used on on other touchscree=
n
> bindings. We do not specify the actual LEDs behind a LED interface chip.
> And often the chip name is more easily to find out than the name of a
> display.

I'm _not_ a DT person, you should clarify this with them. I just
pointed out the possible mistake (from Linux / DT perspective), and
not hardware / business related one. If they are fine with focaltech
prefix, then it's fine to me as well!

--=20
With Best Regards,
Andy Shevchenko

