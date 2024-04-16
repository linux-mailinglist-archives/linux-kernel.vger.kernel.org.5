Return-Path: <linux-kernel+bounces-147254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B889F8A7195
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1CD287172
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCB482485;
	Tue, 16 Apr 2024 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYiX4XBA"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6710A22;
	Tue, 16 Apr 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285691; cv=none; b=pVx5pgM5WjX34tV8buFn48G3BoZbYJ8zouoLtXJNKhZooK0ZV1RHkelYXHqj1RdCLkF7NoZD0LHgMQGEYjBTtQvrqVjHEtmip4/P5VDb6J8KAqjBEobN52Z8BYpTv2YOx1u774fmi30zHaf26JnFsdRKE2bdWwIOoExf4Tm2gWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285691; c=relaxed/simple;
	bh=n2QPNvPuVN+mGg9aHHpFcDKDnrcqLCsURfATRKMqsz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2AWwxiSqapL8kBnxFG7MDNiXdx2JuEwdKmVnWkQJtmmm7F014BmlXVg6JSX/49ZvpFSl/a/Zdx5aY15YkoRvNBVPtPkb0rx5YW0WQGv06DgxcvGD0+WBdLcPci88K53Th/Dqqy/rCTFYZ8iWJIO+eyvpv8QZ4PcEhqAQGAz5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYiX4XBA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2aa0f3625aeso603344a91.1;
        Tue, 16 Apr 2024 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713285689; x=1713890489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1ATCU1Md8tgFRlK9+WCz2NrwVn9WPr0B+EpBjJ78NI=;
        b=PYiX4XBAOdpXEMNbHuyQk3CHVssrIxn7F1ooHKFcWSId0ED4UCCMjXkSywXbSYuYSj
         FMjQX3e2wxW9o+FDYLarlAB2QPBOscHPSCdeDcAlQ3cOsQvrXBjyRaS91k1hzsk9k/Iv
         qrZiEFciLgTcqmVHXn2Vq/ZqDX2z/8Qs1zZDwsigUfdBizCgA/eAUUsPfqqH0vIKYSgh
         Dx+JndH8N0tYItv0kri7nfKcKuPUjfAONn9XnsWkquSzMn+H30iTmc+1hp4/jOK7/MIk
         D7ZKX3y5owwyN+9Cu6XvhFKyKMfyFuRXE/CFY8jJ2Z6n+BHAYlZIKEdIHzqAVXlSE+KV
         LgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713285689; x=1713890489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1ATCU1Md8tgFRlK9+WCz2NrwVn9WPr0B+EpBjJ78NI=;
        b=BNLP7WCbsRn59sIYz2pANdn7PlYMhmSyZ2yu4Sc0CA/1snhNg8a6fHeIBpzJf5SYtB
         5EOZtynlejSULKPU5a8kQFb4slNUh3O4qJe1K5+ZTs6OwnJFbRGFMo8ZirVKshwW8NQl
         y3M53SmnjSnFqPWlovyekuTm8etejs7YOHiQgwaty0VWt3pyPW9vWMb0/vyyOrxwWIa7
         h/z3emorHvS8/fe4gyP7eAQ+ezEc6iA8o6aWQNIhuD1viWasmvZWWP1TLgTgW8mAFAiC
         fz1Kt+IIVyprFLQzCB+gYchoBYfouEyIoLhII6o5fL2C0y1ZMHKfkfv7sw1Qai1HyRyG
         zc/A==
X-Forwarded-Encrypted: i=1; AJvYcCWqSBAkByXheseRB/T5WjosGDwOFWSCkZExSY7COviOYPQojB5Gh6dKZy9+qfOJ7xzlFB4j61PfUx7N80yEnpCdF/P0TtYVv1pEfcNyWMADKKmqIFcQWhxVvqSDedggZ85RX2hkDq4QHg==
X-Gm-Message-State: AOJu0Yw7LuFXuYqY42ASXC+K4ehw3kaJzhSVm+toSS+VpfOIfRrPJ4et
	mT40arcI22IZQT8PgjU+Gov8FqT+dYr78qkXWO45nWrlsvrlMPbzcKK1LNwAEdjTKGlvmKMHb5w
	zmNxPHv9BenAXYqv4ZZBk6iPjoOM=
X-Google-Smtp-Source: AGHT+IESH7+EWeYIw4jeZC7l99COVZ+9VNJTY8eGys6W10quyfujwug7mwoD9JM3MQgKDQzehSqIvZBcghY5wmKOick=
X-Received: by 2002:a17:90a:db0f:b0:2a6:8e66:d585 with SMTP id
 g15-20020a17090adb0f00b002a68e66d585mr12675470pjv.4.1713285689175; Tue, 16
 Apr 2024 09:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416163256.2121923-1-Frank.Li@nxp.com>
In-Reply-To: <20240416163256.2121923-1-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 16 Apr 2024 13:41:17 -0300
Message-ID: <CAOMZO5DZ-8Cphm_U+ric4yE0uCXc9cTbVs2BPBzWYQd02xTN5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960 and sai[0,1,4,5]
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:33=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +&cm40_i2c {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       clock-frequency =3D <100000>;
> +       pinctrl-names =3D "default", "gpio";
> +       pinctrl-0 =3D <&pinctrl_cm40_i2c>;
> +       pinctrl-1 =3D <&pinctrl_cm40_i2c_gpio>;
> +       scl-gpios =3D <&lsio_gpio1 10 GPIO_ACTIVE_HIGH>;
> +       sda-gpios =3D <&lsio_gpio1 9 GPIO_ACTIVE_HIGH>;
> +       status =3D "okay";
> +
> +       wm8960: wm8960@1a {

Node names should be generic, so:

 wm8960: audio-codec@1a {

