Return-Path: <linux-kernel+bounces-51850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD5848FFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBD71C21DDD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ADD24B5B;
	Sun,  4 Feb 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TcLobck9"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0824A0E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707073154; cv=none; b=eDipUs7aMcvf4nTpNQ5dsW//SxZ04Cr5qzusp9XVdmHOUhiN38QRQdKBC8HAPbCCafW1vz/4pyJyFsmO2f2u3xW6TwsQXJa2CGul1GSXTFdCaB4ijD5LV8GoGRFjrF/3Y78p3Hj3y77xO+NFjX69yFcIsLqHQBnUAkPl0ZZzoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707073154; c=relaxed/simple;
	bh=ThwihqpEmkYEH6ts2ZleGCKVjv2HQKJYQcUmGXzJeKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxLoWy+n2WfkNM03sk4q3C4DUz5xHzwRbLIh2+o/pgvOXTGzJhqzzRdxyb2Rm/5BnqpvdjxqSAipcgxylRnTfN459z7NQvn8KTv6EL2zYyif36L7jB++sWa2ascz17tFBpfIdXizb5wxHh0jFIntl6gqjdx7H4miWr8ZbLRhiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TcLobck9; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a27fbe832so1772439eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707073151; x=1707677951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThwihqpEmkYEH6ts2ZleGCKVjv2HQKJYQcUmGXzJeKU=;
        b=TcLobck9QO/BvL2gm5h3mjwqRpAcvsmJjYvzB3ui89q8mfqyjR52mOTr8ZKRAWM2Gm
         Rr4eOfRZU/O72Iyy7HYhlvQIQJQydpIa+63hfkVz0Cjs0NFNkbgYCRzcepGark2tdyvh
         544jwxfia2h8svJ7DRT3gD91jyJmePhMeLrADdooEXfNKqEvMza5JtgXnt5ONdK6+FQ4
         z7rAHQWNKm+FoYlR5r6Q3AanTssXeErJKMEiB5Ygc6/vUu/1d137LtVgWGzLVncs2NSi
         p2R6fQeD37cDQHHsvu4iqgCCVH4+Xf1r53mG8ZkRbU1pmft1QWMwG4Rt53WaFxKxxvMo
         3odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707073151; x=1707677951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThwihqpEmkYEH6ts2ZleGCKVjv2HQKJYQcUmGXzJeKU=;
        b=VjzivtpnkAqqwsaS0mrC8eunbuDVKpG8fKwvRZkl5kt8KOIkhvxEP6FBMwpLssmmFl
         yAHNxEcmrrrZEO24+1NICZXQg4LAmQnjVGdCuoF/mD9e316UNhd1VZCQth2o5S9o5Avi
         NWygwiXOleg9jRV7xZwXtBio9a7fCQCXlRUpyJFbgZIzJWK7sLG11t1IA4N0cItOilT/
         k+KJoROG/ANsVDwtGlUoEYcpA5myHOv8WYftTzcZRHNYAzSO7OlSRhNy2/ZsOWKx/BO7
         tEZBVLAXSmdPhEI5CARsG19acM0Nlg2PNDrPDE5vnWTlwiMJeTM3/n4iTbJR1G9OV724
         RddA==
X-Gm-Message-State: AOJu0YzEMW6HVz5tAaJDW7otaxbhbAmHSKEdL8bmwaTf3INGkcyrrRH7
	GY1y9l7Kd8Sf4KyDlrc/O+Vkn5ycou/GsX+f0uaR9gT5mR05IFJ7SgUCW2OANIKMb0TqJD0Qt/u
	QhuRwCCuhX2FfgDJ+8MUeq5tb4pS8Q0U/nt/G1A==
X-Google-Smtp-Source: AGHT+IHZPu7JOhnW+WabPixZNvtP59ved/O5akA186CvDVtY1vrwCCE7jLzI4JXeMQbjH+avQ17YQs5oJxkTJaAnVyY=
X-Received: by 2002:a05:6358:721:b0:178:8cc8:4c7b with SMTP id
 e33-20020a056358072100b001788cc84c7bmr10710494rwj.24.1707073151246; Sun, 04
 Feb 2024 10:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com> <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
 <DU0PR04MB9417A9074C5DC49AE689E65288432@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zbt-QkWhz5d9P-v6@pluto> <DU0PR04MB9417CA6CF089B264112C32A088402@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417CA6CF089B264112C32A088402@DU0PR04MB9417.eurprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Feb 2024 19:58:59 +0100
Message-ID: <CACRpkdYCrbNB8wu4rO3Yx0qomxR3kTt0P7YH7kc2HPCbrgt=tg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"souvik.chakravarty@arm.com" <Souvik.Chakravarty@arm.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 10:29=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:

> Using generic pinconf means the firmware needs exporting groups/functions=
/pins
> and etc, the firmware design will be complicated and code size enlarged.

This is very much to the core of the problem isn't it?

So the argument is to save code effort and size in the firmware.

This reflects some of the reasoning behind the device tree bindings
that encode "magic numbers" in the DT nodes to mux and configure
pins. Often the argument is that it saves space and effort.

When the i.MX driver was first discussed it used the standard scheme actual=
ly.
Look at i.MX 53 for example:
https://lore.kernel.org/linux-kernel/1322999384-7886-2-git-send-email-b2939=
6@freescale.com/

Groups and functions! As strings!

Then the DT bindings were discussed back and forth between Dong
Aisheng (the original driver author), Sasha Hauer and Shawn Guo
before arriving at the fsl,pins scheme.

Back in the day I was pretty much clueless about device tree and
relied on others to review the bindings, which ended up like this:
Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt

This was in 2011/2012 so many things were not considered. It is
clear that this scheme with a number of integers that get poked into
registers is convenient for some DT authors, also pinctrl-single uses
this as well as I think Mediatek and maybe a few others.

Over the years I have come to regret it a bit, I think insisting on
groups and functions as strings is better for abstraction. And the point
of firmware is to abstract things so they work the same on all systems.

Yours,
Linus Walleij

