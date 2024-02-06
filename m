Return-Path: <linux-kernel+bounces-55065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20AB84B71E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C39283C02
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D40132C25;
	Tue,  6 Feb 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6BSKRYf"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A60131752;
	Tue,  6 Feb 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227882; cv=none; b=DiSCXxYMp+YBZ6Tb33KGUB5K7xNnVzGYcaUZKhczTK+T/+0ILwXTMkescdEPlUOBNWKbBcKFw2ZSvmdl6PPCiamKThuR2eRtvzQveXGHy6gL+/TU1ONrVth37zMhwGjKfN47+0kkCpppJ5QkjsI1rtWq1uOTeQ5XFbxPa02pX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227882; c=relaxed/simple;
	bh=q02mHhaddDcRKzpFEPdlX+JxRT7xIFYvkN9gyf7ZbiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtxFstKTXpx1e/qGYiHXtGdGolgh7BV8iOwALcAoQEqI9ejWfcx43/eryxFFXW0Nxlka4rOkXyupwnF5puVu8uVzBhETtz0h9xdihEHKwxLywiLKRy6ntuf39ba3oZSqaju5Pq+/IfMJuyos/xUiqd/UkB/ii76Co7EJqeQ/gE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6BSKRYf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e04c4f494cso1154085b3a.2;
        Tue, 06 Feb 2024 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707227880; x=1707832680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zn1XlDFCWeXKDOQNaPTzbFjaMq+xLvUS0lr29kDeSyQ=;
        b=T6BSKRYfqysOLM//T/wAn4Lb7Wzy7Yg+mAXKQA0u4x+vFWJyBe+g0MLJE6i+rWkxY/
         dv/AqnYUKA8OKaz8xhAHJVI1Ieh5ZwpuEN8JcjT93qaGSWLpTuFZE7IsjUF2zj70ZnBs
         VIYwmCiCzLcumJS+U62f+ABLeLgZiy9aplvJCmke0au8ZJgimjvckrODpKMYWkCA5sfl
         +U9XshuyOGceA3UiEoVzN4JucCNSx6kKrzsloWNBlMUTfRtk6sEXa/GH9itSGUiYl8Cn
         ILVLqUSNz61UZFD6EkLTv/dchHKpzBI9CBD+62g4h0pYb/j8w49XB+5X0sAT97HwujWv
         oRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707227880; x=1707832680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn1XlDFCWeXKDOQNaPTzbFjaMq+xLvUS0lr29kDeSyQ=;
        b=VT76Zg9Cb7TjakJmtfhQBU1tz0figmQCSuxkzm1AxLtGZP6ySrmJ2iakJfGsr/ybWR
         MePGmBVfsWMkqEhlNWFPFrLXHNoa7rAcx+eZhP6lshJC6SVY5Rtg9P9k4DXFxdZHQZOc
         fe3m5rEq/Ywr4s0P35cRG4RgrAAnQNtpS1D0SC5nQq9GNrOb7MOkcj8Bpisq2V23Zp5o
         w0xW9kNeGQyE0PN4925L0Prn9sQP7DlvDMXwoaPWE3MjG9IoJ1vVbY93PLSKjFiKlZlE
         /K3HFU7h38H799CdIAkGrbVp8/haaPYuX0+HNbddbbvamKpJ3A4vwPFs6jXxuVakLALF
         X1vg==
X-Gm-Message-State: AOJu0YyueQziLl334TFiZ3VgrFAtpQLW16HpgQdYsv5Eejn4y7JJunZb
	V+Be7VtERd/8377OPvvvrJEydLu5JG9aXU7HEK/2XkuxW7cx2s+1ZSFceFpXucyWypyj6QZM0Ec
	4Z7mnqL/9wIMm3T0DfZTBYi4SlA==
X-Google-Smtp-Source: AGHT+IFusAQZEyMGImB609QpXmGKL6MF7Rh5QsPUF+CBtYamVjEGjuzotit6/vTcmOtkSG6ijVXPDKH9O4ARY8ZQJ4k=
X-Received: by 2002:a05:6a20:26a7:b0:19c:a0f8:4b77 with SMTP id
 h39-20020a056a2026a700b0019ca0f84b77mr1302035pze.47.1707227879944; Tue, 06
 Feb 2024 05:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191808.998754-1-frut3k7@gmail.com> <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk>
 <CAKEyCaB2Cw0Ey73je96xDgofuXDnsC4DgeS9=HkOM6Kufrwbaw@mail.gmail.com> <ZcIwGRU5NEZGpRy9@finisterre.sirena.org.uk>
In-Reply-To: <ZcIwGRU5NEZGpRy9@finisterre.sirena.org.uk>
From: frut3k7 <frut3k7@gmail.com>
Date: Tue, 6 Feb 2024 14:57:49 +0100
Message-ID: <CAKEyCaCQk+iL_zOr_0LFOA4Fw+SwyuzSWOvVgmO0Tn8Ygv-4hw@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: spidev: Add Qualcomm spidev device compatible
To: Mark Brown <broonie@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:11=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, Feb 06, 2024 at 02:01:27PM +0100, frut3k7 wrote:
> > On Tue, Feb 6, 2024 at 10:37=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
> > > On Mon, Feb 05, 2024 at 08:18:05PM +0100, Pawe=C5=82 Owoc wrote:
>
> > > > +     { .compatible =3D "qca,spidev", .data =3D &spidev_of_check },
>
> > > No, this needs to correspond to the hardware being controlled via spi=
dev
> > > not to an implementation detail.  Any new compatibles also need to be
> > > documented.
>
> > The device for which I want to add compatibility is originally used in =
the
> > router and this is what the dts fragment looks like:
>
> >
> >       spi@3 {
> >         compatible =3D "qca,spidev";
> >         reg =3D <0x00>;
> >         spi-max-frequency =3D <0x16e3600>;
> >       };
> >     };
>
> > According to this commit, Qualcomm use this compatibility:
> > https://github.com/dissent1/msm-2/commit/d6160218393552fea1b7973787f2bd=
154f870ee2
>
> This is out of tree, it's not exactly a good guide for mainline.  The DT
> should describe the hardware, not how some particular software stack
> chooses to drive it.
>
Will changing from "spidev" to "qca4024" be enough?

> > > I'm also missing patch 2 of this series so don't know what's going on
> > > there.
>
> > The second patch was sent only to the devicetree bindings project:
> > https://lore.kernel.org/all/20240205191828.998783-1-frut3k7@gmail.com/
> > It's probably done wrong...
>
> You should send the bindings change along with the driver change, they
> usually get merged together.

