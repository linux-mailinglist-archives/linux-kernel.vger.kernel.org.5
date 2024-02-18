Return-Path: <linux-kernel+bounces-70146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE088593F6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C361C20BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54FC15C8;
	Sun, 18 Feb 2024 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFzvIwhW"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB899A5F;
	Sun, 18 Feb 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222053; cv=none; b=AZ7POVJYfOtLE4kixIlEBC1XOf1yinntYEe0O+p7+91LF+llr7zN5C+Dis75B9scAsFOI4YoHQAn1hjNLCSKZBvNDLaQR1AYc3mjq+4I8nKXrqdBygXHpWIPrEgu9TycRCoG/0nKp19UYGhYTUyGdabkqEJH6dfUgtbXX1VCbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222053; c=relaxed/simple;
	bh=T83tRAukTC4i/CSWhekDzeqyHGGX7XYLnJn1VXTutTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TACkHa5nEs8jCrrDWIgBSA6vtRqPw2vcBLLA/1zzc2dn4fU7JwurLQA/Od+3wkAi4GcfvhoklV3gnd8LDATQwentqbOKXugvWGxNDyZZNaKeVfwLSg6EwXunkJkLBOYSDNGqaHj+ydSoB8x8jXmaWy+xq9+7W+xs9sDRKmptTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFzvIwhW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e46cb8ba0so40116966b.3;
        Sat, 17 Feb 2024 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708222050; x=1708826850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/ZLs1Wtik5BE9YKZ9jSu1oBwUrciCOZ+jg9J6PzI9c=;
        b=YFzvIwhWZlDNugQoe3pZrFr1L3ZBDEfnqZhh2BToJIwW2wdkMgaIEWgUfY4kJA6MnY
         9kn0j5Pn2vMVQBUdPG0yFKZZukpzldR/L5ErTua/7/5T1Z5o4zJPyZc0vSLan/a24/yW
         77JbGMKgMT9ASboaX2PXUMgAFwRhyWQpDecxmZasd8biNksx9N+XFMPeH+a4+pPup8WK
         Mam2syT2OLz2i7e7/+BB1uWhsuxi6hI/QXWAgrrtqDaNqbkxheqtgIw+hPwOgX3gv+Yt
         OImRHk3TrPW2XhQxsf7xv849zNWp9x9w6mu3YYQGnSf/jc95opLrIloC7UouIzTjljxN
         px0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708222050; x=1708826850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3/ZLs1Wtik5BE9YKZ9jSu1oBwUrciCOZ+jg9J6PzI9c=;
        b=FcO3h1o/kMGQMws62svEGrQN8ypjDaocPALM9ffpWpLi9+ufWYhsdhgNEtJRvUkiOJ
         TUG2l4R5tgPb11VjEijovBo24gG6TUL8EB+CLzvpPeFbHbv8QSOqio6x9BZVxjLjCoW2
         iPG9dAxgSbPWejmlhglvYksOVnuHB9J5CyiIorkYGuMk8e15friYHX/3yhZVUlf/3Zbf
         7g/EZdy6SaaMzl5b8jIwlGU8Y2Yq/28S3QMJnZoRg1bjL0e+6ITDMXqve6DI95+/3A6e
         MXCPyhJUK7p2781Uim4AkNihDlnCJghCDvQyEYRiEOC5ygL/dTd7kUVJTCpRFgN3VgHn
         kjqw==
X-Forwarded-Encrypted: i=1; AJvYcCUe/nmsTks0CfgTqNsU9Od8sRXUq9kJrNqViR9nYs5dwAAOUYEMUTN4c/e5roGlyGr9VQFYuHGySP8BfcjDhPJJfiXQm8qxTvc9Gyt/WdpHjQqmwMKDPXjO7qI+raq79t73mWcsvVKFpw==
X-Gm-Message-State: AOJu0YxdI/M1DiPyr8p4oCJwgLmIR3IGgf2QU5XQUKLlmElEV8uCH8Li
	J1lq2SRCtFIuf8w6mKRHhDB+ZCbd1v1/Cnq5qCKLiJ/kEFflb0IFYb0mvfQcAZMaH+IRwECQaqh
	s67KIrfV39rS+PiJiaiYIaeRiSBxupZSO
X-Google-Smtp-Source: AGHT+IEqb1Sad1YC4zFV3dDXA4iAXL+u7sCDBHlEsq4wO5fwRuBWc/3NUojcOqX8E2vogMwYuTkoeMNsD+sYobEvgMc=
X-Received: by 2002:a17:906:3b94:b0:a3d:26b2:94f4 with SMTP id
 u20-20020a1709063b9400b00a3d26b294f4mr6311314ejf.73.1708222049922; Sat, 17
 Feb 2024 18:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com> <PA4PR04MB941646795F4E19D1EC35134F88522@PA4PR04MB9416.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB941646795F4E19D1EC35134F88522@PA4PR04MB9416.eurprd04.prod.outlook.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 17 Feb 2024 20:07:18 -0600
Message-ID: <CABb+yY0aM9Dn3LPBqb11vU3Ln4bCCGOBXX77sF499cyb_sXiUA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

On Sat, Feb 17, 2024 at 7:38=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Jassi
>
> > Subject: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
> >
> > - Add dt-bindings
> > - i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
> >   the TR/RR num is different. To make code reusable and not add too muc=
h
> >   macros, add runtime detect number of TR and RR by reading PAR_OFF
> >   registers.
> > - Add i.MX95 ELE/V2X MU entry in driver
>
> Ping..
>
dt bindings and compatibles first need to be acked by dt maintainers.

thanks

