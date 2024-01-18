Return-Path: <linux-kernel+bounces-30169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F876831AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E943EB21562
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254BE288DD;
	Thu, 18 Jan 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAmaggMp"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60825750;
	Thu, 18 Jan 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586032; cv=none; b=WwjMl1MoYVJ0HahPqh/elryhoNWKVioW5LMW8FemZVMElwgC2EJn4c4zXuS5wngvX3oX2GCr4JIukGKGKMWzn3j+p/rbo67lTovLpLDHyYl36c4Dpsc1pzqxc3QHfGzLJzN9sh/xcwAeI1TOlcDiP5cXyVgAw90CtthxqDuzll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586032; c=relaxed/simple;
	bh=BYMgkED4+IQyIXVefEkLBQ8h0FGA2kOiawJ5Ea0ivOM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer; b=ZSiyBMT1Tme905d6er+5VaO9BIQd366OPu9LwMXckgcU7t3TKZCLbkdosNLOWiuhN/CPlVuKfmSD1C0P+uUgUhHI32UYFBJVzeU48q9C3RXQSf1jzOCtaxNNzCfT/lrpeG0y5SVp6P2bEI9MGJbXYxtES3dbupy44MOFrufXIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAmaggMp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2a17f3217aso1341054966b.2;
        Thu, 18 Jan 2024 05:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705586029; x=1706190829; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9MIswHWLD+GgE2qONMoQxUs8h+Lw0Idmat3zpcBgpc=;
        b=EAmaggMplRwrm3O+5ztjYViV8rfGX2Cfv5eBOHQeZhq7+mqkSLNbxMogzkmOSm1SAL
         KUcLUgejzTZqP7gPGti6VqArXfGE20aUQTut02ax6qGSpu8bAVujr5kJexP6CePm9F3I
         1YO+iZO1cDGL3n5U9b22Jj2swpXGFErKiLkwA3gyb/VSnsvzillA50UzFzfQBCco4Hxh
         aiodJ2sxN+R2yFNegrvSh7TeJ0JCRAZDpHnJ4Nc6oIgRoKMQRcATtubT+ZO61oLkvO/v
         NKSTgHEX7SnYWM5/D6KZ+3I6IB3QI0+w3KtWL3iUKj8Ckg4e90uAXHhuL38pgaJP2N2k
         h8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705586029; x=1706190829;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9MIswHWLD+GgE2qONMoQxUs8h+Lw0Idmat3zpcBgpc=;
        b=bAjecBcgu1rg6I3R3We0pVCnCCK+AEYRQfJoIR6s4lvRL/JwuNQCVsxTcwReiOM9Yc
         M9sxs6s4ERNkt5GElKZ1TvXOwdanoC+l94iuyn7XPPweT0X7vFqJ8gpOmk41G6DVdzkB
         nWcywI2MJri4nvmWS0FtNhYOfdGNLOFjWngMQxFGvlWjJzwjgWks+hgBhupAgAZlkGv8
         4A3k6MUHDAg5sUd97KfOi73AEzdnaJ/8LviSQSzU902pZSliniKiUONexk66/T2V9D+E
         ZjT+Lm17xD5vI2Zvudu3fYhTamtX+R8YhdspgTk3EO3aiZyxVuEsOpFLQ9aO6B4m4C/O
         MtDQ==
X-Gm-Message-State: AOJu0Yx8fD5oz4hS0wzuTEQUzYhhbDxOibVym9y9vFA/WBNUnJf0QCyt
	nuziQ55j6hyxe3czRSqc70fqQn4mgzKHfBWZ9sqWlGdLVlq/px+5
X-Google-Smtp-Source: AGHT+IG2xmWsdIRyNzSjpjlSc8OqjB+07Y553XsPhCpFvi46hCvtzIWdtadtbNxngmjCGlOEe3H8MA==
X-Received: by 2002:a17:907:8744:b0:a2f:24ca:3b93 with SMTP id qo4-20020a170907874400b00a2f24ca3b93mr745883ejc.117.1705586028995;
        Thu, 18 Jan 2024 05:53:48 -0800 (PST)
Received: from smtpclient.apple (84-10-101-169.static.chello.pl. [84.10.101.169])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906541800b00a26f0f49dd2sm9276238ejo.11.2024.01.18.05.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2024 05:53:48 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH v3 0/2] [v3]Add hantro g1 video decoder support for RK3588
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20240118113051.10773-1-liujianfeng1994@gmail.com>
Date: Thu, 18 Jan 2024 14:53:47 +0100
Cc: nicolas@ndufresne.ca,
 conor+dt@kernel.org,
 devicetree@vger.kernel.org,
 elezegarcia@gmail.com,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 knaerzche@gmail.com,
 krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 mchehab@kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 sfr@canb.auug.org.au,
 amazingfate <liujianfeng1994@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CFF2A39-6416-4599-AD32-E99EF95F5A36@gmail.com>
References: <5490507acc121113e52a8cdddb155fddf6dbb374.camel@ndufresne.ca>
 <20240118113051.10773-1-liujianfeng1994@gmail.com>
To: liujianfeng1994@gmail.com
X-Mailer: Apple Mail (2.3654.120.0.1.15)


> Wiadomo=C5=9B=C4=87 napisana przez amazingfate =
<liujianfeng1994@gmail.com> w dniu 18.01.2024, o godz. 12:30:
>=20
> Before rkvdec2 launching mainline

Ooooo - is there concrete plan for this?

Asking as imho rk35xx can be really nice multimedia soc.

Can be=E2=80=A6. but is not due current lack of hevc/vp9 hw decode in =
mainline due lack of rkvdec2 support
This seems to be clear blocker for many multimedia use cases :-(

Having rkvdec2 support via v4l2_request in mainline imho will make =
rk35xx killer soc for multimedia=E2=80=A6.

ps: rkvdec support seems available since years on mainline and works =
well.
So maybe rkvdec code base can be basis to gradually added support for =
rkvdec2?
  =20



