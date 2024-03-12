Return-Path: <linux-kernel+bounces-100542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5EF87995D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF06281D53
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA0135A7E;
	Tue, 12 Mar 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne+yVxXu"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DAE12BEA1;
	Tue, 12 Mar 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710262196; cv=none; b=A0Yv2ULeVnae1AAVM39gzQJ2I6fyPoQbpfzYaDuOgWX2CF8EH8C1YvjBr85MCQF1eppGTQEWqiN5NCLcGPPpJbL4ENd1JCEsiFCFs7aOZGMm1idEuU8v2MFEHyzPrzbob2edGoCegf3tfJ+nGY90lBgJ/E/nMJCiRv+KZGFuEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710262196; c=relaxed/simple;
	bh=DVvAedCwujQR7TnsHghnS4fZ1e54MTftbvR2uxBpON4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP+OQbT2nYOPVj1QUnl+89pyQl37oE0mBFBiT5PmnnFXRYWPtS/wOJmtU6QRXYrqrj7fmtdeA6uPgffcrEqO9pLkQ107oVVdT3S8EnofgmzBFf7S5ojvZksyEhPag9Ac3IQslZf1uBHDuidOkti7EvrbMKDhufju6eIo8lIGWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne+yVxXu; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e530b53bb5so1292895a34.0;
        Tue, 12 Mar 2024 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710262194; x=1710866994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVvAedCwujQR7TnsHghnS4fZ1e54MTftbvR2uxBpON4=;
        b=ne+yVxXu5kywr26U2+HdyfKIvI0KmM4qk69MjIUhDipvqFCyXoaoSpvoJT71lrzzWg
         6xibWkB5KtJn8BlF6YIcQ1cLaA0nKtZ4c3NBn78jtAVzrrYvHMs7xt93+cvSkLViONtT
         vmsXrNk2YxSHhG6vbhQHDQ9Q1t/ihepWfCHxwTKmk/0l6c6exoJz1vGhIj3PyThw2pX6
         u+gFm+AQoeu5u6gl3F1x0N8VqTcGqKNW7WSgwCduLhruZyY5g+QcUisCEjnE1ekNZ68a
         GY9GhVkcMcQgAlMYVQv2wYu+ECTBj3LAeQoQYg/hk/m1zkEp87ZspcL6dVRSS9ht2geP
         6HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710262194; x=1710866994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVvAedCwujQR7TnsHghnS4fZ1e54MTftbvR2uxBpON4=;
        b=e/HcKmgH6niLccdQ7RKeqc/92O890seBzr8pcH5uZ+/hI+iV1DS6sWup3nwEKp/aT5
         aJL9WACgHWcDaRS4yHYiXEXyyfPcbpiEe7F8viK+qVV4DEuR07l0RWeEr+8zVLxCqGXz
         Ntnyd9PcCSEYe6zORdBUP74LVzPyatQ3+V93hGHqVCncQrC1mStoxhRfoIbbdWNmPp1b
         AQJ6dZPFYfpdxcUfPHsLbWvtBKolV6ncJFZkEFHTeWE1kw88gd4IrLA0I1kBOE86C/4p
         K3RHvu4RBA7QvILOF0sGRnM+vsvY+DMUQ8tbM3tq6eV74sM2Y0VoMDmEPLHEHS4rEAhZ
         hPww==
X-Forwarded-Encrypted: i=1; AJvYcCVY/V4RpPlCQVavM/xP8VLsSwopIC/H+tzx5q9JfGL8aTzaAH2tUIttZwD/iB57Rcz796oMOx05D3uSLfvh4z/coFGfDyEc2jvnZPU2sAcXdolL88TqslVNkqVNHnlyXAmx4zFJmQwnqGhkGskxe++mQrPpwJUKUWQltOafxvx70+9c+A==
X-Gm-Message-State: AOJu0YyRT096fzFAiwBWYOiDP3mtYcoHkvwEX8vGwgzkz0gNFNEbtJWZ
	54wBaKXc/stDPLN/Jls2CEs7eXAsCUrCHNXLnDTYBmQVRfVRQwqw74TYcOydm93TvvVud/SveBJ
	/EtlOY1w1U3Wm1lxggmd1a9yX96BszW/bWeA+wQ==
X-Google-Smtp-Source: AGHT+IEys+zMMKlLnlVX3wt8sr5YMcXvWfe1xEdzJrs0K1SaH3AYusXm3bEz6EEFD1jfhusxkz9VibxbVTh1xIEyeMM=
X-Received: by 2002:a05:6870:9722:b0:21e:a2c0:fd1 with SMTP id
 n34-20020a056870972200b0021ea2c00fd1mr737219oaq.34.1710262193850; Tue, 12 Mar
 2024 09:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311140435.34329-1-animeshagarwal28@gmail.com> <045ae9cf-104d-472e-94f0-ea7cd5298214@linaro.org>
In-Reply-To: <045ae9cf-104d-472e-94f0-ea7cd5298214@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Tue, 12 Mar 2024 22:19:42 +0530
Message-ID: <CAE3Oz83x54L9j0TOJmM1C8QGO8Ed=ZY107a0eSL2dO7dXOKfRg@mail.gmail.com>
Subject: Re: [PATCH v7] dt-bindings: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:55=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Thank you for improving the commit msg. It looks a bit oddly wrapped. In
> the future, please wrap commit message according to Linux coding style /
> submission process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597

I was just trying to get the lines wrapped within 75 characters
without making it harder to read. I'll follow getting line wrapped at
75 columns more strictly now. Thanks for pointing it out.

> Oh my... missing space after coma, but more important: what is happening
> here? The space was here before in previous versions, so you removed it!
> At least till v4 it was correct and bam - now it is not. Why? It's the
> same confusing as new line appearing suddenly in v6.
>
> It looks like between each revisions of patchset some random changes
> appear in your code. How is it possible? Don't you work with Git? You
> change file, git add -p and git commit --amend. Why unrelated changes
> keep happening?
>
> While the actual space is a nitpick, it points to the fact that your
> patch experiences some changes in an unexpected way and we cannot trust
> that you did only what you claim in changelog.

As you pointed out I indeed made a mistake at v5 by removing the space
and adding a line at the end. I removed the line in v7 and didn't add
the space back. I acknowledge my mistake and will be more careful.

Warm regards,
Animesh

