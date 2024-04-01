Return-Path: <linux-kernel+bounces-126427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF638937CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50AE7B210B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3CD53BE;
	Mon,  1 Apr 2024 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAAZNJ3H"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D77137E;
	Mon,  1 Apr 2024 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711942588; cv=none; b=hnkqNSfX+My4+DEinNSneCFY99tNy+JHe6wrnqikGnCGgsxlKo1Ph0ZS3FWjPE1vdpzp/XoYCOsndQyr2YRkxrdhjrbw9q+eFs+QzO16aHFPKnLGfs4t+iMbQup/ky/LTUDgACS0kR3/Bt+jojZMNaLTk+4KgsqNruLa3VH6zdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711942588; c=relaxed/simple;
	bh=CAI4IYWxeZpJbz5iZ33JEvW4PGG6v2Lodui2BORJaw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdN/TH4H6uk8dWP0VamA2ZqlxVgEJr5/limX4XNQlgqOFLpwFNt0x9mFbY4fJt4aTf4j74JWSNwILgN9Vsql/B05LTvfXWTZ5E8+FNP+7GYduLANg0UrDX/RdUbQ10RDKRXEDeobQberg0euv/IG3ytzgxkzHMH0bVArRbhFeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAAZNJ3H; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc745927098so3468769276.3;
        Sun, 31 Mar 2024 20:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711942585; x=1712547385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVU9lGh0l2uZ+mACmFYxgWkKH4PTJuZwIYH/fG9ipLk=;
        b=XAAZNJ3HifMKq9bSoBHgq0NTNf92d7+xSGyFM+ZK/hv2gTijpre7lcvKVs2XxZn7Sg
         7LMD1VyOOAmZHdI58OHqKIZCv86h5S1IExrB3nx/wEBqIgtByYJaIrur8bh4r9LQ59OC
         1c2LA0qw+t+o7GxytJ9VDmzsgWAguRuvLh196EUYThvjq4q2KH1b/OLJ5f+BEtQWuuaZ
         ubM290tl6mdCeFR8+jf1YPCgRzjYwwgyUNe+erVjhEKf9DjH1y89dHLdvl8o5nk+Jx3+
         PA3H2hGxDlWlT45NFYJCpZNDGHt7YnzFnOvgtddETBj3Dql65xHoAgT2RvLlBdwYTiRR
         W40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711942585; x=1712547385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVU9lGh0l2uZ+mACmFYxgWkKH4PTJuZwIYH/fG9ipLk=;
        b=aKZgWXFenVy3iC3oIHQxRxmalztCcOFA19mIBgOU/JRNZdTZg9cjtuH39Kb2A8euyq
         0/jM2eThMvWioTuilqyHc1CszSmqh+gis8gCMKn2rQNQ/FmCZpKPqwnwuQLgU2LTPqZv
         +OqESfSUdDBsEcv9d0+8aR3xtWi38qu0CHQ1S59Ontc528gYTcOLRHr1f2/Y+o0kqdlX
         T7H0XYlIJkPdD83SGbJXG8C3s62DfYJWDkjSVOtWZEMnBt4KeovRKBV6m+Ie3rsuDfRF
         9I5hgC1f/Z15bTWQWgdCqT39oXmOPk+PQDar5Kqhwt2fWgt7t5WaYoTDrh2mOcf4e6fo
         O45Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtE/K8lCPPJjyy+ZWOyKG87Yv6DKMVe0T/GG6IkFu+lk/1q3LkYRgonPwwLLktAMqusYem9gEiHmQ6zhDQEz2wfIVNVsLcu0Q0Tb2gPdLlQE3PgAoaCbwgYLZieMxhs0/ZK006wpkqE2imKmCcWoA37SKd5UmpviHUE7DSQOwkgoreLQ==
X-Gm-Message-State: AOJu0YyNOsDt2uzQeDqLPyxz/MDyksanIPES7O/yk+nzpc2QHrT2oZRi
	77Kvx3QJgomX3mzPZuxrhFF3hlAvJRBVYD/PDoe5cgOyfq+U4AsNv+i0Jl8L82q8STh4ztRNJVB
	fDN/jZ+Q3tzuCXJ6kBf8pc50u3a9ry669ZDV7p88I
X-Google-Smtp-Source: AGHT+IE8raEv6RIw6m9O6AccRxjUjrpSI31IBne/uPOC0Jl22AQXlCVSznYC2r8cofitR8ZsAzCG7YWr0rg/f3RZvUs=
X-Received: by 2002:a5b:302:0:b0:dc6:4b66:2636 with SMTP id
 j2-20020a5b0302000000b00dc64b662636mr7025534ybp.19.1711942584868; Sun, 31 Mar
 2024 20:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329015147.1481349-1-dqfext@gmail.com> <261f2995-b279-48bc-b9d4-023a8a705857@linaro.org>
In-Reply-To: <261f2995-b279-48bc-b9d4-023a8a705857@linaro.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Mon, 1 Apr 2024 11:36:08 +0800
Message-ID: <CALW65jZoU8ChPg+e-5T4+ZmS2=g8O3wL96mjaRAPbomHJhg4gg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] spi: dt-bindings: add Siflower Quad SPI controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Qingfang Deng <qingfang.deng@siflower.com.cn>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sun, Mar 31, 2024 at 1:42=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 29/03/2024 02:51, Qingfang Deng wrote:
> > Add YAML devicetree bindings for Siflower Quad SPI controller.
>
> Describe the hardware. What is this Siflower?

It's a new RISC-V SoC which hasn't been upstreamed yet.

> > +properties:
> > +  compatible:
> > +    const: siflower,qspi
>
> Except that this was not tested, aren't you adding it for some SoC? If
> so, then you miss here SoC part.

I should add the "siflower" prefix to
Documentation/devicetree/bindings/vendor-prefixes.yaml, right?

Regards,
Qingfang

