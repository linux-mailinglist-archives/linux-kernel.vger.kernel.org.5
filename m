Return-Path: <linux-kernel+bounces-72480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F985B408
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F11C22E36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9583D5B673;
	Tue, 20 Feb 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northern.tech header.i=@northern.tech header.b="ZEkcR4lx"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF155B662
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414256; cv=none; b=qlQmew5RHPWcODkQ5nCnLVxxKfg6NEQFIXVKTWJzkbh9Z7YRmu6EBZcgRysuZvGD9/fV8e0aku+4olBmORvDvp8/BYhD/e14oK+acPvtqTwv0PuJw3xi8YPYQl/oOzOA2KhSBpwWn2V9VcEww/4bNF1xyigYNHj3/WhmHBe5gB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414256; c=relaxed/simple;
	bh=byQMZB6yOsK2F8J7yVXxve/DOqrouOKGfoytBZdyRDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRsHReiOdrh/TAoxptiBgTvzYd3HEp9L5/WEB1p3ztui4mq0ob/CVCMLR6jRhPGWwBDUIW+70xPylyA24diNiPWumXnIctnDOUUigzQGcKyNt3yyXR30RVbT0guXvfXNJEYj4Fu277HwB5kp5XbvSczQGErVoy69HA8pe8sLTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=northern.tech; spf=pass smtp.mailfrom=northern.tech; dkim=pass (2048-bit key) header.d=northern.tech header.i=@northern.tech header.b=ZEkcR4lx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=northern.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=northern.tech
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512c4442095so470411e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northern.tech; s=google; t=1708414253; x=1709019053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byQMZB6yOsK2F8J7yVXxve/DOqrouOKGfoytBZdyRDE=;
        b=ZEkcR4lxUb6wmBERb7hsD7dFMyDl2SnIYvPxg3R1gRtaYESYhEY2w5AV31ZgllqPA+
         ybmPWL/HBf4zqLSTPkwGrmkEk4LX/LcNNs65oKDqhbl+G6R19GAFCVF3caVyqWOc5Lj7
         UYorIkCp/pT1oWlGJ9Yab0cnm6Iw1jYHdfnrs/2DKGKwv3No+9CUaP0FI+Iqb8RxzMAK
         jGyD8p/ClAeT71Fvbp/QgbbJlU4LGTcOpSWCxoleVnWbiY8gwZb1QuhP9apIT2B0YRXz
         lSj5YD6zoPG5pL4WaGJB+Mfm+XPl0YDJMP111jdSS1dVcPtMNP/jKJYOUCUjtmFj9p2b
         PsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414253; x=1709019053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byQMZB6yOsK2F8J7yVXxve/DOqrouOKGfoytBZdyRDE=;
        b=Cm7quXv1G0GR8GHVC7Lyglod5/Yn5iN1GXVeJrGnIWJyT4vQtW5GGAzjtstz12OPNg
         3p1HwlNR8945nLUHtxSeXek5ewN2W3rBT5ewDIkuMHJzG/UwZuZIWKxMX7GE/ARDwHEg
         MCvupCQf43TVEd3aBJ3+zjWkuQHd8b5QKHmG8R4BpEwzmqUeT5Ge90B34IV1I1ouqZ7a
         gs0IYpE58Oyd48Kwe+jtrCyoN8D/vEeDKlVjSka9WyDlaD616GmWc+uKoXzM5Gt7rjkx
         pU7nomHu6cFjLsNo2IHQ1HhQ24R82WyzgwOJ8i8EoI0wqlJh61uXkPJDtsUEG953nhFt
         52yg==
X-Forwarded-Encrypted: i=1; AJvYcCWI5uSWY96LE5jr6nMOvsT5taAntSRfqirZwtTR5BWitb5jqwkwRx/1anqc2AVOM+PAOMwf8a8glecBgdguKQycuhW7JkayooXjFOBX
X-Gm-Message-State: AOJu0Ywb3efJtfFsrAw1Cx/RaSVbK5AkNUT/fzQFg9oq1Gr/2Fv/0UHP
	r01eFDG3fXUmZkN80mWh3V2IKOkueI5ESecXzbx2SA5+u3tnGBUrzGPeVc5TCovI95/G4RasknY
	BeHD2zFXjIlCP/utR+KVoInxSxEZI+FN5wXCZ0ugBAVi7PxfKyli244YPSupWgfUYTZZBXdUsn3
	eLilzy/dtd5TdtYY53EJTGlxv78Q==
X-Google-Smtp-Source: AGHT+IFOKYH09y5iol3m1TkiUV+SqBmVC7mMi+48KfGZJAWBq1cqVKXihViQz4dI6LGklctgAdCdlEkS8tRTzXNnAjo=
X-Received: by 2002:ac2:4e0b:0:b0:512:b3f9:6ef3 with SMTP id
 e11-20020ac24e0b000000b00512b3f96ef3mr3610667lfr.47.1708414253207; Mon, 19
 Feb 2024 23:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209112807.1345164-2-ole.orhagen@northern.tech> <CACRpkda=b-uZmSfqRLkkC6Lp-JbSoi+YZpwhVn9-RMOPxiXszA@mail.gmail.com>
In-Reply-To: <CACRpkda=b-uZmSfqRLkkC6Lp-JbSoi+YZpwhVn9-RMOPxiXszA@mail.gmail.com>
From: Ole Orhagen <ole.orhagen@northern.tech>
Date: Tue, 20 Feb 2024 08:30:42 +0100
Message-ID: <CAD5A3CvRNpAibArAZg11TdfKP62V9Eeb9ccUhiQwWLiGKgk+Sw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: vexpress: Set stdout-path to serial0 in the
 chosen node
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, ole@orhagen.no, 
	kristian.amlie@northern.tech, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Andre Przywara <andre.przywara@arm.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>, 
	Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 2:02=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Fri, Feb 9, 2024 at 12:29=E2=80=AFPM Ole P. Orhagen
> <ole.orhagen@northern.tech> wrote:
>
> > Specify v2m_serial0 as the device for boot console output through the
> > stdout-path in the chosen node.
> >
> > Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>
>
> It's also the right way to do it.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Sudeep: are you queueing Vexpress DTS changes or do you want me
> to handle it with other Versatile-ish ARM DTS stuff?
>
> Yours,
> Linus Walleij


Is there anything else I need to do here, or can I consider this a
valid handoff and forget about it?

Yours,
Ole P.

