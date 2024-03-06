Return-Path: <linux-kernel+bounces-93824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B8D873536
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592561C216C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18060DFC;
	Wed,  6 Mar 2024 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLNoQeRd"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DE6089A;
	Wed,  6 Mar 2024 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722744; cv=none; b=c3R6CYVT+/WlUndbwYRpuM5v6/1QIt6XWbTY0axOgQkz8OrLrtWe4rTGd5ls+InLu3mtRNUzrTdqKCdAH51649ZyDN0h+ROl7lNrJj9/dRejIGPjyjWsj/9o/MgnpTCn6oHNdJc4h/fsgnBuH9TyODr51sWnScbajenFXQmFGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722744; c=relaxed/simple;
	bh=9irRIG0KFERmL3sNKB1GcQ9JLqgiQH8nptVh6vPu5mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VliGbM4R5bT6kmJCKDGBFN9zRmNdu1Yqhqk6Nx9aBLG9QJDlYT32/zn14V/HzNvDuBbpZlgo3t4wK68eSAr+aRXI6kCAcKf8AbzrBAuTxMU2zhIzrCKOwe0EH3zHqYNSNhXvXCn7FYI1Uujh9By4j1sgRjnZ42Yx04rB7KQtKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLNoQeRd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a45c006ab82so48093266b.3;
        Wed, 06 Mar 2024 02:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709722741; x=1710327541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5Z0N03v/ohpTjWPfQRgP/mEBY6xf/mkdG3hCpH/bMQ=;
        b=OLNoQeRdmYFCi95vmYODy9EeMtLhKh0hrbhqiLnsRjh2hLjXjak/QSF719cR1lKRdk
         tsSHBcKiLOjjpxLB6ZzNfEA8mzVvDsjojSW5/qb6LiUgwxrXR8zubekDPJH3k97hxlGi
         i1d2l1p+u9h+8ydVAxPPWM2lSGXmKUxmeYOXI+PcmhqR75HeC55qSV4wfjDKqIVRu/9L
         e/ISVoOd8Jq9J60xa+XUHAS0LXD/2ZVXdcJCxwtXltt4oFGUUeE2YR1WcqOPSEkZfLrs
         L6H8zEMkP32OrKmTe10FlO896R/9TVPD6Mkx8grxndR13SXpOV/AsDerLtEhksXQvmzo
         aEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722741; x=1710327541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5Z0N03v/ohpTjWPfQRgP/mEBY6xf/mkdG3hCpH/bMQ=;
        b=nEF++5i84TkhByeDUxp7jJyyp+Ustq+bp7bNoIDGIaugWvsATdv5DEyVr5QzKNyzAP
         X+wH3uFxBheeYjYKSFmp0iTgCfUt9e8YXNyp50J1W4pp4+4AHfW2cO1GjTfNc+4hRJt6
         whnzM/n/czQZaqrkrDhJWdaWPPz+n7U0+yegBmelQbbQElyo6Ni2BzxENI1jfeNS/T0t
         5I/TlN07MxaT44CKHP1w7K3dkmYscGtygaOGcQYmhDyKo2FwWWeC55TI3lNl6+Bgbz/l
         Ans4aHOnXylX4svykQc1lxgURSdqqx9GxI4YPq+W8IhrPjO+EGuMLyROLGaiaubYjQEp
         08/g==
X-Forwarded-Encrypted: i=1; AJvYcCWF4rqL9eNRaFhc75g9Wke9kSkA+l65bvtCy1FhCfNjjcJ6P5zzLXNIlfBesmdS4//BVGZ7wwTXFHnibu3sFKBcoYjFkl2l1uAaGBdVDWPS6OBcywWFLLzFwKh3tpGS0pKJg77nQDO1rHz9rk2w9kLl3X4Fbo1EfSO2R1Bwz9fRxd0NlQQ=
X-Gm-Message-State: AOJu0YxI6P/JbQCHcGd6CnDBetaZu2d0Aq4UGmJJHotAK9pUPo5PPtX4
	ujM6m93VlIRf5hlyomoHXLmQQQR4ODygn9gOUfGRhKGu7wqTvzycmZD3yicGZe3sJW8sguqLTNm
	odM0LjDSIoIZM4oRxvEh35TPGZyo=
X-Google-Smtp-Source: AGHT+IFR/RKGlCn3Fh34/aH2tzfQC9FgfHtJe362qDydqHz8e5ZEJGTvks01Qy+NFLTjVu8vZdi1vIdnJoYGzqQGu6I=
X-Received: by 2002:a17:907:20b9:b0:a43:6cd2:7a27 with SMTP id
 pw25-20020a17090720b900b00a436cd27a27mr9255436ejb.19.1709722740894; Wed, 06
 Mar 2024 02:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305035853.916430-1-chris.packham@alliedtelesis.co.nz>
 <20240305035853.916430-2-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdXF+12PHa5A7WeyPMfvsGcJN13WaPuCbTmJU52Huq=osA@mail.gmail.com>
 <Zecy1RsSfpmH-cvG@smile.fi.intel.com> <216eb75d-5384-4654-9e86-4a9856494ad0@alliedtelesis.co.nz>
In-Reply-To: <216eb75d-5384-4654-9e86-4a9856494ad0@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Mar 2024 12:58:24 +0200
Message-ID: <CAHp75Vdi8K2mf2JSCG=e4vX+18CuNyaH-U5Q8-NGvihhyrJBJg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] auxdisplay: Add 7-segment LED display driver
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	"robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>, 
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "lee@kernel.org" <lee@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 12:34=E2=80=AFAM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 6/03/24 03:57, Andy Shevchenko wrote:
> > On Tue, Mar 05, 2024 at 09:23:07AM +0100, Geert Uytterhoeven wrote:
> >> On Tue, Mar 5, 2024 at 4:59=E2=80=AFAM Chris Packham
> >> <chris.packham@alliedtelesis.co.nz> wrote:

..

> >>> +       priv->segment_gpios =3D devm_gpiod_get_array(dev, "segment", =
GPIOD_OUT_LOW);
> >>> +       if (IS_ERR(priv->segment_gpios))
> >>> +               return PTR_ERR(priv->segment_gpios);
> >> This needs some validation of priv->segment_gpios->ndescs, else the
> >> call to gpiod_set_array_value_cansleep() in seg_led_update() may
> >> trigger an out-of-bounds access of the values bitmap.
> > Alternatively we can call gpiod_count() beforehand and check its result=
.
> Unless there are any objections I think I'll go with the ndescs check as
> it'll be easier to update to the subnode style in the future.

Either works for me.

> It does
> mean there will be some extra allocations/frees (handled via the devm_
> APIs) in the error case.


--=20
With Best Regards,
Andy Shevchenko

