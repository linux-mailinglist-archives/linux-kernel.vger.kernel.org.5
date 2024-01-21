Return-Path: <linux-kernel+bounces-32076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8E5835626
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9730A281DE1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F967374F9;
	Sun, 21 Jan 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GIGAdFls"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC021EB37
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847854; cv=none; b=jnV2NWCYq4l+U7VDA57O+YfY2AF8kxZb5OTtwCwSRdEexKaXkBNwQap9a9FZXVOD+e1FPokZRu0JxnI0rdjOqY/KwZKSsqL6vAGD2AAm37aAkcEyYBrQCE1ZzyiIEBBI5PpZ2ew43x3aQDnhrjweOlg0CrYynZIU9W5k67BI41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847854; c=relaxed/simple;
	bh=CDApNaplKZ25oamiktN0S+Ji5xLI1g1rccClqr4J0Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo9S8BAiXRuZc4tqXs3HXoMS4nGH3v89zpFXU20n2PRhd/2hlOqmH0KJuMK56alR8qqdK/78Dt33TsOzh8dO9lsGRWDJoCcRcaYoZ/i8YyjtRt+uyLiJzQhiN5QaeY2n4BX4QKXJAl7sqvuaNcg0u8ougyHs+bjTVr9IwVPx61U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GIGAdFls; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ffb07bdce2so8411327b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 06:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705847851; x=1706452651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDApNaplKZ25oamiktN0S+Ji5xLI1g1rccClqr4J0Bg=;
        b=GIGAdFlsQvuNAbSdqWd65BGms10IGTh9g5WzevbH1z/Ywthj76JDxb4eDTCbEI6EyG
         2z4aotFWLNhfVKDjqrQz4CWOB8POqUeMRm/opVsTO38vZZRIVE2U3vPf3Ks48F2z2mPm
         1y4dfHh+/oYtepjQLx/OyYq8TWQGlPvyDz1hTe7LgzpitP+z27QT72oSBYw7Rhgf7rf+
         TtKFnqpHul5icNjgZatJYF0qTKLZCIgC6mLBjPdYBZhe8bugEsHybDnGd/70p+cADoXL
         gPRIu5n/HKSnKDqng0getzO23N9ysHYXdWuj+Znvb8nMO0UUnvTmqBVgzHHQs5donIUF
         PlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847851; x=1706452651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDApNaplKZ25oamiktN0S+Ji5xLI1g1rccClqr4J0Bg=;
        b=cWbQ8rVSdWjnorkrjDIDX+u7rX5T0qXptEq42vUNn7ZilhllcbaMh60ddegAIV0hw6
         B1TXlkk5XPHQaqggfI1O2GiQwSxQy5My8/Xi9ba9apvo0DxemxhLnfN9M7UK/b/cTlL5
         myM1c8fhdLVQPvaTYF0fQBlahB78BYzSPT8q0uBWr8VXqdNV7q1983trj+ricT83KpvB
         /fopPqzjmYZgoXiPABQxl9ACxCTxMxz5pc0Uh9AN3NUs5fi29vg2LSkroJ71VhnoclBR
         VD0fVPv7eqnjFYri02HviCU0Fe/pPANcdEDQvDsZkdCttowYLUfGNzrTZR4k/ejrYgeV
         0kFA==
X-Gm-Message-State: AOJu0YxY6b9/LBt8szJPSfWXiv81bW6Ac7HSa+wzKmr4OgvG8UqB4BfU
	BS/+xxTO8sJ2c5FxoU3eGN0AMMqV36UsDt2NQptU2nI3OS+CWMvxiQOeMLzkpUDwf+LljoLvaUD
	Ub0RQSBX4RDJA9TECE3KxeDH8NqhYvv9A75LTeA==
X-Google-Smtp-Source: AGHT+IEsDujy+qqr3r2XFC+/gU5C2SO5cQeDz63EZves/xdhXK8OzrJSa1DJzBv9cLts87tjJ1jzxqWX5kxbmIDL1RI=
X-Received: by 2002:a81:7b06:0:b0:5ff:9b70:226c with SMTP id
 w6-20020a817b06000000b005ff9b70226cmr2450527ywc.53.1705847850626; Sun, 21 Jan
 2024 06:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120-ktd2801-v3-0-fe2cbafffb21@skole.hr> <20240120-ktd2801-v3-3-fe2cbafffb21@skole.hr>
In-Reply-To: <20240120-ktd2801-v3-3-fe2cbafffb21@skole.hr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 21 Jan 2024 15:37:19 +0100
Message-ID: <CACRpkdbC0hwAZ47Q-iQUkVB4H+EZFO_nENNB2hRNRWQoNHrECA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] backlight: Add Kinetic KTD2801 backlight support
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Helge Deller <deller@gmx.de>, Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 20, 2024 at 10:27=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovi=
c@skole.hr> wrote:

> KTD2801 is a LED backlight driver IC found in samsung,coreprimevelte.
> The brightness can be set using PWM or the ExpressWire protocol. Add
> support for the KTD2801.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Very slim after abstracting out the library and the library
has the change I requested so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

