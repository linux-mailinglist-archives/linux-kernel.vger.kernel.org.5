Return-Path: <linux-kernel+bounces-63618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34F0853258
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 235F0B26693
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09E356749;
	Tue, 13 Feb 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCCW2vmc"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB45674B;
	Tue, 13 Feb 2024 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832400; cv=none; b=UWFYKUWqkalAbwsEHUUSjE4wysjX+igz9bg1UihSQcwJr+TqJimR/6iNaAdNjwNcrSJrtbffYmbA4Mgxh3KNGM+zQVRoopl7L8szQQaGsAB7EQ8llCywEXwzGdDdt8bFOryIPMI6xPX7gC0N1NWRtE9WG4sLr5Ut7qTwzB50bh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832400; c=relaxed/simple;
	bh=B2Ue+hDfl+m5G2hGaMiDiw2jjGGWc3+YxMBflUIzaWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+1OHgHmYD2XfKRTtqsgF7e6xj3cHYyhCp8oh4fcDNgzQweAarGKAnxdgNFhK5zLt8YHz2CCxd52US81Di5Ocurw58wiyQPm994J52OopkJWs/hASJ9y6Sw4VUd6qwnZATnTBCQauShW/fSvwycYWR5p4Ee1vIMwBNTNrEzlVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCCW2vmc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dc8961f5a9so73856a12.1;
        Tue, 13 Feb 2024 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707832398; x=1708437198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Ue+hDfl+m5G2hGaMiDiw2jjGGWc3+YxMBflUIzaWM=;
        b=lCCW2vmcw7zagVmCQzKG4SV8iX69qck8tq05OQcryLeSj8UtiT6riwrSLkTgUOtjXL
         WzpcEjt2xFI/9WtYEbhp+bePE5iSi78d8253XzlFfdUZ6zawEZFneSCZRBC/StD/RPeJ
         wO/Jp2hPbDwcha7h8ewRBKpsaixHLXWaybe8XrUMPL0JDp6DOwWgNwwE1KXJuzv68+NX
         ywsSDtKPNSJYs+99nPA0QgX2PtUFznAli0mvTMjeTOBrQAgHvdx9rwCFmilgmSYtNKeB
         1GlYFJLiLu4iMHoXua0B9+xTH4x7vKhGsFARokKwec0Vm4N2wcK0QSqT3FRQrOD8JD4s
         ajYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832398; x=1708437198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Ue+hDfl+m5G2hGaMiDiw2jjGGWc3+YxMBflUIzaWM=;
        b=bkoRgCtVpAD0e4gyiT4Soolfux0kufv3MiAycTfODaJ30sTYKcQbW7sAJzpxklPxpX
         FlrmvTv48NBeczF6mgSyZUZtrrf2nc0rmcANR9lBO58pDqoneGGOjjsnKxTQTNtO4KZ+
         x6wJyWPQN7ki2CkpDs+1PPpApR2KE02OVgcZyF2i76f0Uu/S8pZzX2ojnv/3GhTkiamz
         6K3u6GVEjYbBTqWvVM5uCK8NniBg+gfPsKOACvrvtn6zmToA6bOJF7rkRb1HTef+l/UJ
         PkMZ7G8m203zLAd53VJrTirdkB92810RqHrr4I+AgFARMY4A7jhibSXVP3pMIRo+7aaa
         rpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Fy7Ktx0cf0T2Htl5/eXPGzWret/i45yVQfr9erVO6weOydRlmtYhlL9Rlkw4LmbdHUQNCJmDbdPFcKycryglH8Ab3wTp29p/EtRqB6BsI3mDlSx8VjfVj6vKf589s9HC4DW+Q/XkXA==
X-Gm-Message-State: AOJu0Yz11jVKQs09lNIBNnxSbBCU3VtnrHiZ3dwBxALODVCu0EXLlyoh
	+Goa2fYt8ezp/wWUTkw+Srrg50XzYBp5Ntc9jtS/hiZ33jp8zDoFPeRJ3zWep7vBBRBVC2FUf2k
	fQj1aZRMgWaXpuilt85HlUOOyfkw=
X-Google-Smtp-Source: AGHT+IHl0wY8HalJSuc70Ci1sxHHD4/CGJYNc38Fg7u7sBtYnjj+oqvC8p6y/6VUopUPpAIW5AIJ5muiEsmUj1L+B5E=
X-Received: by 2002:a05:6a20:7d81:b0:19e:ca20:1374 with SMTP id
 v1-20020a056a207d8100b0019eca201374mr9161063pzj.0.1707832398131; Tue, 13 Feb
 2024 05:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213010347.1075251-1-sre@kernel.org> <20240213010347.1075251-13-sre@kernel.org>
In-Reply-To: <20240213010347.1075251-13-sre@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Feb 2024 10:53:05 -0300
Message-ID: <CAOMZO5BUzaqHEvd877te_Tgiaz+QvWrvLC_oKg+mRPzmL26pDw@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:03=E2=80=AFPM Sebastian Reichel <sre@kernel.org>=
 wrote:
>
> Replace all "xnur-gpio" with "xnur-gpios" in the
> i.MX6UL(L) Touchscreen node.

Please explain the reason for doing this.

