Return-Path: <linux-kernel+bounces-39529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC783D25E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520D41F244E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA181522D;
	Fri, 26 Jan 2024 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SpAOtV/x"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9044683
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706234968; cv=none; b=kwxt8EGKHrNRZjEY+mFtKOk0unfnFeXIGkZvhUlnock9sPQpmrkMsfKjSKW7bZjcc1abO8P1ibdBIiOnH1U3i1Posnddm31nIesdJSbb2k3mbIMAeFzRs4DMnrddTawx6sciERdMsjpVV9Z9up7tawka9avmSjBzvgmfRusiLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706234968; c=relaxed/simple;
	bh=gKSsN1jIW1mdBnpWSvKhtasAeERdX0dQlnV/an3+1fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktwkV+GP4fz+VSM8lIKTdvvLFgc0ibtPCmP1NVS4vCSg5BoXmisVojrnedADZYOeIQpzmQmKyHVeNwz0GIGP4KRGd0PiD2y66XPT3cjWXqTmZQSQkJAVPV2UIryspm1uzkRQtukbvGMgbr+bXFCawW5ygf4AXbyjvjEx4BIS++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SpAOtV/x; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a7765511bso57081cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706234965; x=1706839765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5amz6Dx9uklFZzeQD+cVMfgm94Iu/oKxh8ZpkE1jLY=;
        b=SpAOtV/xOdNxD62v4vVWdHT0agAiNJ3uviHtBniaPldIvpCNdJzK7HJUfYL56UDGnQ
         WBolz3K0MXv65cnWbQVbN/8fmdQnFm2KZJRlEP3YOkNOE0wRpo5JSxH5dskFAULAjB9i
         HZE7ICaj90L8dyHdKtTtKk/pRT6k5BSiDFnxK85mDILtT5FB3zAiidiXS4YC7wY8Wo8p
         6VhkInjWWSZm6nlb3Wi1d0l9Sb6OBY4i5N7YIVqU3SE6G/OKN8K4jGQVLoC3Drh8pDOk
         BbnoSRdyVPILk9QFu3bvQcZqbCVODUnklV3O1Iv60AxCLUJ5HOhtEcCKTtQ/wi31u5dF
         l9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706234965; x=1706839765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5amz6Dx9uklFZzeQD+cVMfgm94Iu/oKxh8ZpkE1jLY=;
        b=MnZIZWISJ9iYyJ5tZ+DYZi7ghpMwWBc0p22RZZ699XshPArbdIxhbkORsUz6Vk/rqL
         1sV43+KSvYKdpCe5ahb+onB2i/3T+JUZubjKBnFE3TZkD+rBLbSCXIdu/tkj8V2EY+Ce
         5XILaAloICEUNEUNxL/DvGWGOo+aYtjw7gu4mJHjCuX1yi53xPadVL5oELiQJpWpJZV9
         PcJhL9t4O5xeU64EUwn/0aa+xBNbJDgvSyiXgde63tKcFXO1s7WBrCzbgdsXrrEH0SXr
         5xcIOtS7LaxfgR6X8JRtWgUar0MyIXbBOtJGISm1m0JtbtvWspuhs1SvzN+KhlR0fQ+v
         32Yw==
X-Gm-Message-State: AOJu0YyAE7ZAsb5AH65iIIFTz50Vb3B/kdkJrxE/n46dg3onGcAX0pKJ
	9yqpR84F+xjyb14XUXkZtAJXil4hs1V+nmKW83nXOmdi01sco7txOF5X+76jhDBba64+oUVYLq3
	GQuwEIelWvqP2CuHjaxzd36+Ep8lkCSIhGbzRTIZZy9Zvp8CI4+TXw8o=
X-Google-Smtp-Source: AGHT+IHCJHF25X2TEl/aPytP4xDfa74efG9D09U3G7tYM1h+/qwluhQ9njKJ7jvXENSBw9FeP3k9Uly/jb09iOo9nTw=
X-Received: by 2002:a05:622a:1dc9:b0:42a:31d1:e4d5 with SMTP id
 bn9-20020a05622a1dc900b0042a31d1e4d5mr79311qtb.7.1706234964614; Thu, 25 Jan
 2024 18:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124084636.1415652-1-xu.yang_2@nxp.com> <CAGETcx9h8gA8EenyR0B0OPa23uw_8dk-Kft8c8+F3StfpyMtaw@mail.gmail.com>
 <DU2PR04MB8822047A07680596415A61358C7A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB8822047A07680596415A61358C7A2@DU2PR04MB8822.eurprd04.prod.outlook.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 25 Jan 2024 18:08:47 -0800
Message-ID: <CAGETcx8HeseChCoOzOkUNf_LyXbVqgyisuHy_9U=PcP74NwV4A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] driver core: improve cycle detection on fwnode graph
To: Xu Yang <xu.yang_2@nxp.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:21=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Saravana,
>
> >
> > On Wed, Jan 24, 2024 at 12:40=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wr=
ote:
> > >
> > > Currently, cycle detection on fwnode graph is still defective.
> > > Such as fwnode link A.EP->B is not marked as cycle in below case:
> > >
> > >                  +-----+
> > >                  |     |
> > >  +-----+         |  +--|
> > >  |     |<-----------|EP|
> > >  |--+  |         |  +--|
> > >  |EP|----------->|     |
> > >  |--+  |         |  B  |
> > >  |     |         +-----+
> > >  |  A  |            ^
> > >  +-----+   +-----+  |
> > >     |      |     |  |
> > >     +----->|  C  |--+
> > >            |     |
> > >            +-----+
> > >
> > > 1. Node C is populated as device C. But nodes A and B are still not
> > >    populated. When do cycle detection with device C, no cycle is foun=
d.
> > > 2. Node B is populated as device B. When do cycle detection with devi=
ce
> > >    B, it found a link cycle B.EP->A->C->B. Then, fwnode link B.EP->A,
> > >    A->C and C->B are marked as cycle. The fwnode link C->B is convert=
ed
> > >    to device link too.
> > > 3. Node A is populated as device A. When do cycle detection with devi=
ce
> > >    A, it find A->C is marked as cycle and convert it to device link. =
It
> > >    also find B.EP->A is marked as cycle but will not convert it to de=
vice
> > >    link since node B.EP is not a device.
> >
> > Your example doesn't sound correct (I'l explain further down) and it
> > is vague. Need a couple of clarifications first.
> >
> > 1. What is the ---> representing? Is it references in DT or fwnode
> > links? Which end of the arrow is the consumer? The tail or the pointy
> > end? I typically use the format consumer --> supplier.
>
> Sorry, I represent "-->" as "supplier --> consumer" and it's a fwnode lin=
k.
>
> >
> > 2. You say "link" sometimes but it's not clear if you mean fwnode
> > links or device links. So please be explicit about it.
>
> It=E2=80=99s fwnode link by default.
>
> >
> > 3. Your statement "Such as fwnode link A.EP->B is not marked as cycle"
> > doesn't sound correct. When remote-endpoint properties are parsed, the
> > fwnode is created from the device node with compatible property to the
> > destination. So A.EP ----> B can't exist if I assume the consumer -->
> > supplier format.
>
> The fwnode is not created from the device node with compatible property
> since below commit. The endpoint node is the supplier. No, you can see my
> case later.
>
> 4a032827daa8 (of: property: Simplify of_link_to_phandle(), 2023-02-06)

I think my confusion was because you use ----> in the opposite way to
what I have used for all my fw_devlink and cycle detection patches.

The part I was referring to is related to how driver/of/property.c has
node_not_dev set to true for pasrse_remote_endpoint.

> >
> > 4. Has this actually caused an issue? If so, what is it? And give me
> > an example in an upstream DT.
>
> Yes, there are two cycles (B.EP->A->C->B and B.EP->A/A.EP->B) in above
> example. But only one cycle (B.EP->A->C->B) is recognized.
>
> My real case as below:

I think you still missed some details because usb3_phy0 seems
irrelevant here. Can you just point me to the dts (not dtsi) file for
this platform in the kernel tree?
Also, can you change all the pr_debug and dev_dbg in
drivers/base/core.c to their info equivalent and boot up the system
and give me the logs? That'll be a lot easier for me to understand
your case.

> ---
> tcpc@50 {
>     compatible =3D "nxp,ptn5110";
>     ...
>
>     port {
>         typec_dr_sw: endpoint {
>             remote-endpoint =3D <&usb3_drd_sw>;
>         };
>     };
> };
>
> usb@38100000 {
>     compatible =3D "snps,dwc3";
>     phys =3D <&usb3_phy0>, <&usb3_phy0>;
>     ...
>
>     port {
>         usb3_drd_sw: endpoint {
>             remote-endpoint =3D <&typec_dr_sw>;
>         };
>     };
> };
>
> usb3_phy0: usb-phy@381f0040 {
>     compatible =3D "fsl,imx8mp-usb-phy";
>
>     ...
> };
>
> And fwnode links are created as below:
> ---
> [    0.059553] /soc@0/bus@30800000/i2c@30a30000/tcpc@50 Linked as a fwnod=
e consumer to /soc@0/usb@32f10100/usb@38100000/port/endpoint
> [    0.066365] /soc@0/usb-phy@381f0040 Linked as a fwnode consumer to /so=
c@0/bus@30800000/i2c@30a30000/tcpc@50
> [    0.066624] /soc@0/usb@32f10100/usb@38100000 Linked as a fwnode consum=
er to /soc@0/usb-phy@381f0040
> [    0.066702] /soc@0/usb@32f10100/usb@38100000 Linked as a fwnode consum=
er to /soc@0/bus@30800000/i2c@30a30000/tcpc@50/port/endpoint
>

So let's say I see your logs and what you say is true, but you still
aren't telling me what's the problem you have because of this
incorrect cycle detection. What's breaking? Is something not allowed
to probe? If so, which one? What's supposed to be the right order of
probes?

> >
> > Btw, I definitely don't anticipate ACKing this patch because the cycle
> > detection code shouldn't be having property specific logic. It's not
> > even DT specific in this place. If there is an issue and it needs
> > fixing, it should be where the fwnode links are created. But then
> > again I'm not sure what the actual symptom we are trying to solve is.
>
> Sorry for the inconvenience. I saw that you push some patches about fwnod=
e
> link and device link handling, so I think you may understand this issue
> well and give some suggestions.

No worries at all. Thanks for reporting the issue and thanks for
trying to fix it.

-Saravana

