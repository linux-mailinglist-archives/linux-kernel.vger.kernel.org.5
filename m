Return-Path: <linux-kernel+bounces-106350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AAD87ECDF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7FA1F21C26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106D52F8D;
	Mon, 18 Mar 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaPli6sV"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BF52F7B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777539; cv=none; b=q2aDod6zLAvsjtbZJVb/40x/p7kEvKs2uukVB4EDtRiF4QHBDumuZNhH0h7WOZOrPpflpJAgC4PyNBYwK7/IYARQYzY1L/GuLvPDQR0+s3tIgl3Bcljc0oPt5FCj/iJM6EnTmmL+dU3wFyZPJopHFCZd6P39DdUrsnjxXgG73Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777539; c=relaxed/simple;
	bh=y76vbDJtHiugWfxpYYz3MtbHcW1T0fosoyhaoQiAPyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQAmuQK/xrC7TFRoHRGd7r2UcczYItfQ6dTGIXYONfBz9o9BkvMVTzJX9/lA15f5SNwq+qrTdQ9F7hl8aWkxECf64619kuDZWQORmsa1CmDB6/vhLOrB4cN/zlChMsj2jHNicZeVfVGbXPQhoZ0bsSevuRoDXqDgwZ6Xot+6xI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaPli6sV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430d3fcc511so204861cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710777537; x=1711382337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y76vbDJtHiugWfxpYYz3MtbHcW1T0fosoyhaoQiAPyg=;
        b=MaPli6sVqN+8Cm7B5NV9Om9HW/T8V6dNT5F6FPfDNotqbgJCYO0U7b5BZsjlKnVxMg
         NYPBOb9s3EM4t14mk+1qwZAkOJbadc0npRXGziT5BrggBDpziU0lvP2wvPLwmYSBiQI9
         4dwzSAeNwzY4kw1+9Fg90ojx8Db5NFbbYRDHhy6P1+jhPnbBJ3AMrwcL83hpYzOlL0Kx
         pyxFG5hUG0+R2szvYc/sFRC5Kji9fz/QlvhkDnXAvLaBHLQDitOAchvXBeSQhvI2hyid
         FGzNbrKDPX1ilf9NI5Bo/AZ9GOvBFFaCTcCH4ZiGIEBl1Waut3FF6tIQQbUd+8y3FmjZ
         I1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777537; x=1711382337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y76vbDJtHiugWfxpYYz3MtbHcW1T0fosoyhaoQiAPyg=;
        b=ROsVESTEox7BV8tBygzp4F1M4NOQ49kPBTiglfr2fa1+QkrY8Y0wgT5nNev5G1N+tG
         +wB2OaZRggV3by72KYoJ7CorBsIgRA3FlEQUXUm3kUfkUc11HsiC13TVtDL7o7rZuo9l
         CxE8SVRrnPutWXkLCpV/bL7VIqsM7RsVKwiTS0P2BQTJyxZZci0gUB2Ww8QP5QwpFrYS
         Mp81XO90DJypNL7bJi9mG9GuPZAT3/7aX1JCRCYz1GS+zKBuoxks8sMFIIF2pVQyPHBM
         oi9q+qdGqvsd8cUz2Najeai8gPva+txLxLfjBWlLdE8+ryax6PmX1shHkRHixC/n5sbK
         z00g==
X-Forwarded-Encrypted: i=1; AJvYcCUjYuSIdnsi0XQDZxWQDR+cPNlhHC8gbGh9zt8hx7N+ESxSObwJ99OW7vzHY2WOmEWGq5rIRqtY8gnQkdBbH/X+8QaLeW/w0trmhCoq
X-Gm-Message-State: AOJu0YwFsR0gNbUeXpCDINs5PpIjdtn2SEhqEGrv/E8/yD/ZaZwTXnBo
	QGnXQqK4xpJzVpKkHZKUgVs6lOmAKCo0dZyGKkGM9711KQHitL+Bsc7aXNM6EgsEZTtcdV1sN9A
	v1hGB9J+jsoEde2oG/yvqbmX+MDy8hzfmAdxo
X-Google-Smtp-Source: AGHT+IH92AsmA5CM5H9OlqSW5u+VIWFsgIEXK3B7zURDpjKRR7WOyWwIVJ3xPPtoNsV8rmrwp6HXl2P+4MhvjwRMUkY=
X-Received: by 2002:ac8:5e4b:0:b0:430:a74f:b45e with SMTP id
 i11-20020ac85e4b000000b00430a74fb45emr377484qtx.17.1710777536483; Mon, 18 Mar
 2024 08:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110855.31954-1-johan+linaro@kernel.org>
 <20240318110855.31954-2-johan+linaro@kernel.org> <CAA8EJprywWbdoyfAbys=0WzEdAkp0UK1fzzCPzxKRjyk9DrC6Q@mail.gmail.com>
 <Zfg--2_NMPSPTxK-@hovoldconsulting.com> <20240318144806.GA3963554-robh@kernel.org>
 <ZfhZffrZXwtKgZ13@hovoldconsulting.com> <CAD=FV=UpuD7Lq0DxSZAGpL4Mi2uxy9HNt3V3FZq7Y3p--gbMrg@mail.gmail.com>
 <CAD=FV=WCzrh926mkiyBnKRG_+KGuOkGN6v0DgPiXhQCD3PSQ9w@mail.gmail.com> <Zfhh-4wEg4O4Xqeu@hovoldconsulting.com>
In-Reply-To: <Zfhh-4wEg4O4Xqeu@hovoldconsulting.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 18 Mar 2024 08:58:40 -0700
Message-ID: <CAD=FV=XpOf8ZcqROgwFX9bs7B1gNGDDVOYezBztLJEy6U3AOnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991 compatible
 to fix bd_addr
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2024 at 8:47=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Mar 18, 2024 at 08:31:09AM -0700, Doug Anderson wrote:
> > On Mon, Mar 18, 2024 at 8:26=E2=80=AFAM Doug Anderson <dianders@google.=
com> wrote:
>
> > > > A new compatible string (or one-off property) would allow them do m=
ake a
> > > > change when they are ready (e.g. by only updating the devicetrees a=
fter
> > > > all boot firmware has been patched and pushed out).
> > >
> > > I have no real opinion about the exact way this is solved so happy to
> > > let DT folks decide on how they want this. I will note, however, that
> > > device trees are never shipped separately and thus we have no
> > > intrinsic need for DT backward compatbility here. It would be OK from
> > > a ChromeOS perspective to add a property or compatible string for the
> > > broken case.
> >
> > Actually, I should probably say more about this to make it clear how it=
 works.
> >
> > Chromebooks ship the kernel as a FIT image which bundles the kernel
> > and device trees together. The firmware looks at all the bundled
> > device trees and picks the proper one based on the board name,
> > revision, and SKU ID. The firmware then looks for the bluetooth node
> > (I believe it finds it from the "aliases" section) and adds the MAC
> > address there.
> >
> > ...so we could update the DT to add a property (if that's desired)
> > even if we don't update the firmware.
>
> Thanks for the details. Sounds like we could get away with adding a new
> property for the broken firmware in this case, which should resolve this
> nicely without having to deprecate anything.
>
> Could you carry such a devicetree patch out-of-tree until the firmware
> has been fixed?

IMO we shouldn't try to fix the firmware at all. Given the fact that
it took me a year to get a firmware uprev completed for one trogdor
variant for fixes that actually had functional impact, it's possible
we'll never actually get an uprev completed that includes this fix or
it will happen years from now when nobody remembers about it. I'm also
certain this whole issue will also cause a bunch of debugging over the
years if we try to fix it in firmware like that. There are cases where
people end up running with old firmware since the developer workflow
doesn't automatically update it.

The handling should be added upstream and we should just accept that
the trogdor firmware gets it backward.

-Doug

