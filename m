Return-Path: <linux-kernel+bounces-70924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F694859E16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3046B1F22F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B721115;
	Mon, 19 Feb 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4ceavaI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF02134A;
	Mon, 19 Feb 2024 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708330869; cv=none; b=dQdEQr/avsHl/0s03dfoj/Gv11fOWCtKsuISl7DIgKhZJWdn5EEnW3NtLxjSVVEbYkI9jHCIb6tFXBGJe3ETE5TqXr2gFRmoClSPhrBFDOJPLVeQmUoJomdHh01ezUMqWUqIUKnsiFS21Rx6QuyheLC+oApxCh685rojciGcisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708330869; c=relaxed/simple;
	bh=sYTiaAWQhnMgaRIFaGK1lzfzRuZUwLRb4TIavexCdCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcLZipmV/ifYadzaxmUb0lkhSwMhe1GSOncARNp/rFrN+C7T3h8ekgUMbhFqJm1oi/ZX+TL/Lj2e7DpuT1voMcJu5gquwRojgvQ9clBSQ4enHQOwndfB4WdS9MzCAqOjNDzFOgbqZdHlahN4WrbcVhtvWlqUSyl0c0nyOaJaZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4ceavaI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so8068399a12.1;
        Mon, 19 Feb 2024 00:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708330866; x=1708935666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBKDXP+4q2FP5//e66ThZpAWcTrY4eAILWbq0sVnKpI=;
        b=A4ceavaICxcqiQdZL+FfcS1MojOAihtDxkAnXbV3/izuKmDwS5sp2taVLN/OJna7d6
         YZ/yIpYcR7uMAAEuFWfmkaRIcC7Jv/n+d//VgYKnAv0ULh579ScOJ5no+etBH/bQyXpS
         GdCs//Dfc9sybdcvXudryejU2cceR2NDCVgvROFK7TBOt602KqGvp2i3rn49Ju455OAY
         1jduX1zZy+Ysz8tFhsmCdr6p0VAVhqbzDTyIpheGvVq8A4YYwAeBN5xiASUAUcpypCSz
         dhPuhLLBeqiByhXfuSJbTZu/s1RiEplLyomQx9+tmRO/SIs9prV7BgWRbYA6Y6bVcjj3
         CQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708330866; x=1708935666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBKDXP+4q2FP5//e66ThZpAWcTrY4eAILWbq0sVnKpI=;
        b=Vc0k7MMbQMSBW58eNDmVe87S9X9di5MyG+YTQlSnNMtYwRoNyeJ3EJuxo9hfxfvCoT
         cz07/W9jJbSoHLJUR1cIXIUZSeNm0h277wn1aZdfTQ6mnDl+N/eCnafdy26oSFeUISWw
         pRE7aIia444loRCIr6iI3btIjUQA/Fv7v2dpjNjaMN4JtolcSclMHKOueueJ1N6biGM8
         S6ZGJ6Zg70bLDy7Z28EWT49IAmdd3qeVkIVxqWmT5G61xgT0QRbKMKqrrPczJD7wTJaz
         eWfwO6gJdL/eIbiO8M1rAE1XI2u2DGXLi23kVV89dTS5jcCbfuw+d2mI1cSI52cu9J0o
         ZSiA==
X-Forwarded-Encrypted: i=1; AJvYcCU+o6btQB6TW5GwaGmXhBEQ48y3IlTxVZBLfzxJxhgsLo1Xr9flgJ6veJxp+8eHfbyDa8+Mwiq1vDVOR7L4fjVzdOhBEdzOkUBwIUoyw7iHaT1X3e66ER6vJLhqe+HJTFRkjwdxN5nk1w==
X-Gm-Message-State: AOJu0Yz1ZiMwGzv4hXlbyBLbpiQZhshrnCGU29eLMesh4N/+NbOmMSYP
	qxJVEV4jpQBwlcVv68cS1u1IzmKPwHp5203rTVaj4z4iJgXQOa/c7UNEfkBnXEeBSU0Zhn8v6dQ
	IrAISk0WjygKQHK2llTG3DHA1DfI=
X-Google-Smtp-Source: AGHT+IEsJAubvCl5vdc5tgko+DNharyYkEwBy+6jjjKck75mGFBtNg4Xia6jN5YanvWhnw7HJrZgviXNXN/+a3bigfE=
X-Received: by 2002:a05:6402:1513:b0:561:33dd:621c with SMTP id
 f19-20020a056402151300b0056133dd621cmr9912390edw.7.1708330866311; Mon, 19 Feb
 2024 00:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218065407.652213-1-zhangzj@rock-chips.com>
 <20240218085314.658223-1-zhangzj@rock-chips.com> <20240218085314.658223-2-zhangzj@rock-chips.com>
In-Reply-To: <20240218085314.658223-2-zhangzj@rock-chips.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Mon, 19 Feb 2024 16:20:55 +0800
Message-ID: <CAHk0HovRrm3=99eTNvs+4UmdC-LYSuuuuP1Tuobr7KYbD23tCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: rockchip: Add Toybrick TB-RK3588X
To: Elon Zhang <zhangzj@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, weizhao.ouyang@arm.com, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 4:53=E2=80=AFPM Elon Zhang <zhangzj@rock-chips.com>=
 wrote:
>
> Add devicetree binding for Toybrick TB-RK3588X board from Rockchip Toybri=
ck.
>
> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>

Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>

BR,
Weizhao

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index 5cf5cbef2cf5..d29df97c7b25 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -878,6 +878,11 @@ properties:
>            - const: rockchip,rv1108-evb
>            - const: rockchip,rv1108
>
> +      - description: Rockchip Toybrick TB-RK3588X board
> +        items:
> +          - const: rockchip,rk3588-toybrick-x0
> +          - const: rockchip,rk3588
> +
>        - description: Theobroma Systems PX30-uQ7 with Haikou baseboard
>          items:
>            - const: tsd,px30-ringneck-haikou
> --
> 2.34.1
>

