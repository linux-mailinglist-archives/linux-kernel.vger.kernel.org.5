Return-Path: <linux-kernel+bounces-53170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8B584A1A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF6280C43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5745C1C;
	Mon,  5 Feb 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdizWcUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F85482C4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155922; cv=none; b=VLXxhE+1oIPdS8VEe5/o58jT0MMsB0qsyItJLajFRwmddQQiP5zsJ+BetsT1c85EFNay6M8Dh71nuWhPD4eVF8Ng9SoXICPBM70sMKYi97C0Fb28Yv/gxZBw9Wc3O3cTPeIdNGFp6D9emmziwoH7PGBG0qW3hHHmte1qwcHO+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155922; c=relaxed/simple;
	bh=JI34Z1tQRWIcNzFT0PfIry4qmoRAYebqMYRLIjQEZI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhh3QogAGmmgtNUw26k6Kt5/5BVhnBYMW0HfSQWiorlUbQrA8fLYXyQY053jnPgYJVD/4M/XiVKP6HMuQvj7x2bdtLQNjpN4RYKiWsYk0fx3V10qHSHifcLMifnCwuxhguP9CI0Ot/ohTdm0/ea4323cbNYS8PoRHenTMUBT0bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdizWcUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707155919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YEl0o9ZueCpXJpYRSdl4wnuz6goJxIXt9A+9h2SVrg=;
	b=SdizWcUyFqNDuTcKBN1NrV96JthRa1IYtwvHe075+FP0R+l78mL76IqSNmEHJqItdh18c2
	4IQWg4JL1pAyFqOaeBqo/sEq5RzwPHRCMgmdPSXbXn3UHt2MKvCnFsgEeAQ9D3KpnCMASS
	gCIY+K5+CfPkiigz/vr6Ueeg2WBlmzM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-MkDA28H4MKKJmNoB-brFdA-1; Mon, 05 Feb 2024 12:58:38 -0500
X-MC-Unique: MkDA28H4MKKJmNoB-brFdA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bb91e121e6so3165822b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155917; x=1707760717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YEl0o9ZueCpXJpYRSdl4wnuz6goJxIXt9A+9h2SVrg=;
        b=SzpSs9JzdzpfddKidDs2FD8r422+fQHaAkx1F69yZwzSMs4aeiKGr3/kldmSY/93Ln
         BaeylkZIwhUaPfcGBeCptJj35tEWbjIYC/3K2Ua17NrNpspJYICviKebD5BOcOVCugV4
         LnaXmrHLLZ7UrJFHePj4ffCFpWTUXT0VjdMc08L5R5ka6gvqe9ldwI/rImAt8OM3WtMq
         Tde4L+Ynwe6zhOIfRyyhsLQJSchO/sFN04jIkI4jx/Pvs+d7IPnG+OhulKgAOZmQcEid
         NpvdzfQvAXq+uYi58copfcBTvw0bRXnDGphKxbzXVGspZuvw5vptMNwWzsPG+LU46drL
         D0jQ==
X-Gm-Message-State: AOJu0Yx3POj3h29g0BWvxT92NLxy3flEIsSLjBvnLZgXXuDlweW6Mnsn
	UhoRAWIWFDV1SrZlGlPco25s+C5kY0dcqYsLglWuC4nWhNvHTamaXfPYKMMSd9mJX0CPO7y0Sdv
	IkUmGSpOOsO1OaBHF8qubSa3OrluXsDFiP0Fghy6w9Sntlsu0v1iFt/M35uAFBgelu86ZyPErOk
	tefQA0SdxAg1XSzL4ZIS220qpNhuq+WIvJSOac
X-Received: by 2002:a05:6808:10c7:b0:3bd:692e:26b4 with SMTP id s7-20020a05680810c700b003bd692e26b4mr177514ois.26.1707155917566;
        Mon, 05 Feb 2024 09:58:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMUCI5N740gGZ0rQScz2/ZI1BarnJzuT7xOBbPs6fdig5Jn+PGlpaHDZsjaQpTTN2szD5H6UPCUjabgOjgsuQ=
X-Received: by 2002:a05:6808:10c7:b0:3bd:692e:26b4 with SMTP id
 s7-20020a05680810c700b003bd692e26b4mr177502ois.26.1707155917321; Mon, 05 Feb
 2024 09:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201142308.4954-1-j-choudhary@ti.com> <92d7de31-2c14-469d-8da8-11bb70ea2707@ti.com>
In-Reply-To: <92d7de31-2c14-469d-8da8-11bb70ea2707@ti.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 5 Feb 2024 18:58:26 +0100
Message-ID: <CALE0LRuTL8wOAG465-63JsUrXT6e=aBfGt48LNco+tKWTY5FHA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] arm64: dts: ti: k3-am69-sk: remove
 assigned-clock-parents for unused VP
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Jayesh Choudhary <j-choudhary@ti.com>, tomi.valkeinen@ideasonboard.com, nm@ti.com, 
	vigneshr@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kristo@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, rogerq@kernel.org, 
	sabiya.d@ti.com, u-kumar1@ti.com, eballetbo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jayesh,

Many thanks for the patch.

On Fri, Feb 2, 2024 at 6:17=E2=80=AFAM Aradhya Bhatia <a-bhatia1@ti.com> wr=
ote:
>
>
>
> On 01-Feb-24 19:53, Jayesh Choudhary wrote:
> > VP2 and VP3 are unused video ports and VP3 share the same parent
> > clock as VP1 causing issue with pixel clock setting for HDMI (VP1).
> > The current DM firmware does not support changing parent clock if it
> > is shared by another component. It returns 0 for the determine_rate
> > query before causing set_rate to set the clock at default maximum of
> > 1.8GHz which is a lot more than the maximum frequency videoports can
> > support (600MHz) causing SYNC LOST issues.
> > So remove the parent clocks for unused VPs to avoid conflict.
> >
> > Fixes: 6f8605fd7d11 ("arm64: dts: ti: k3-am69-sk: Add DP and HDMI suppo=
rt")
> > Reported-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>
> Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
>

This patch fixes the issue I see on my AM69-SK board and after
applying it  the HDMI of the board works again so

Tested-by: Enric Balletbo i Serra <eballetbo@redhat.com>

> Regards
> Aradhya
>
> > ---
> >
> > v1: <https://lore.kernel.org/all/20231221113042.48492-1-j-choudhary@ti.=
com/>
> >
> > Changelog v1->v2:
> > - Updated commit message
> > - Picked up Tomi's R-by from v1
> > - Removed "Closes:" link since its invalid now
> >
> > (NOTE: Sending again as forgot to put mailing list in cc earlier)
> >
> >  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dt=
s/ti/k3-am69-sk.dts
> > index 8da591579868..370980eb59b0 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> > @@ -918,13 +918,9 @@ &dss {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&dss_vout0_pins_default>;
> >       assigned-clocks =3D <&k3_clks 218 2>,
> > -                       <&k3_clks 218 5>,
> > -                       <&k3_clks 218 14>,
> > -                       <&k3_clks 218 18>;
> > +                       <&k3_clks 218 5>;
> >       assigned-clock-parents =3D <&k3_clks 218 3>,
> > -                              <&k3_clks 218 7>,
> > -                              <&k3_clks 218 16>,
> > -                              <&k3_clks 218 22>;
> > +                              <&k3_clks 218 7>;
> >  };
> >
> >  &serdes_wiz4 {
>


