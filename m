Return-Path: <linux-kernel+bounces-87166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B587186D087
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65979287748
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5276D70AE6;
	Thu, 29 Feb 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cou7Vty8"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6570AD2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227559; cv=none; b=mPpp33XKzOAKXrcim5Z/Ay67oqpMBcvy4rlI38N6H/gSFtI5/BWN0ONC60IoPKuQegoGg5jUX1ov/b2ovawhAAgzFVktbJMSLtN75pHtBkcD26w+DCC/rZ9vdFRPhhxVZQtTetpiSun4eTRbOILesAvfgLVjJw0VylgPdwLxhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227559; c=relaxed/simple;
	bh=x023CuxQEDUhqmIMeqnfqJUbjUEG0Bp8dWnHTJB3rdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ1lqDtH/S1C5uVanYi2t61jsczk71JWl003aifUi+fIuGnEurkEKxvyLMabAEUUGossYlgxLmpYyJV9u7k1KE2IPS8R4j2txPAEC9TKr+LL/nxqJQaJM50Pr6vzJN8mFpMrUCraMNk1nGEf+wlAHFvweaBSZPlJnDmbKt94JDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cou7Vty8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so1826425a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709227555; x=1709832355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x023CuxQEDUhqmIMeqnfqJUbjUEG0Bp8dWnHTJB3rdI=;
        b=cou7Vty8VLoEFq4M6Yv86Ms99c7KUcdIfpRyFMLAeAznWgxF68ZxfCozRKV3mWOo8T
         GEHS2DXF20JjjV4frDcXWoUIQq4+m+Ll0G7b2IwOGHqCdCc9RvIolbiyejpJKygZBwLy
         dtUr0nq86E3jtQe83tMlNpOm+EZ8uZ6puVlTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227555; x=1709832355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x023CuxQEDUhqmIMeqnfqJUbjUEG0Bp8dWnHTJB3rdI=;
        b=Bnk8wH8gGwguLdjaBpBV7vdnBTzXVQMa7qCBgN7VFzietWhcsiAU2kGSB6EVTpggHQ
         j3M5ilB1BegiQSdDOxrrTQo8crdi+F4kU1dH8vBd8zwu59U897wGPh7uCrE34R2aaOVC
         T54ZhIegqAMXIzXofoN8R+06doTPrcpSAMyJWZ+hq5Tn0HC8rD+MTCu5fgqCIWMqPH0G
         l374ycBYZ1C4OMNpzvTV5SMmZ+i+H4XlXa4a+Pfg+sEf2RC80BBfUjgcrYRHZ16sB9vw
         QpMnszSSxtjIm4NGpJo7u44pmOl8N+Q3fBkXGfpRBx24zEEkz6jndIq8GgVVHlQQa/+5
         +cNA==
X-Forwarded-Encrypted: i=1; AJvYcCU6wP6RONXHdWvE/fhyXb6gXEForSaatHwB22tTxTM8orkNqM/oWQVS3ocxpMYMAAdcihAdiLPREweuOEKX4d3ZzPR0kDmc/qPMcH1B
X-Gm-Message-State: AOJu0YwMi8tS/a0PFWzq2m9GJkPMhO0EfZhI947kIMtD/lqJzc5Hp1jT
	foOtZYb/U0qQ2IOCoRjKLrHQrDpAISrRKHMSrPdZhwuK1Jnr0YRS3ff9SCpnK/abKXp+1706+eP
	p1K9U
X-Google-Smtp-Source: AGHT+IFScoizlu7JiGmm/w1R1n7r3v02zrvK71MWDPqoB7RViOOrxeck70klBXRvvUjDLdkLFeL+tQ==
X-Received: by 2002:a05:6402:26c5:b0:564:dd13:56e9 with SMTP id x5-20020a05640226c500b00564dd1356e9mr2388255edd.29.1709227554879;
        Thu, 29 Feb 2024 09:25:54 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id be27-20020a0564021a3b00b0056650031d94sm781572edb.90.2024.02.29.09.25.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:25:54 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so84705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:25:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXYopRXolOw1kmaW72X0R85UVz7nwDY2D8fQ8WprLa4Si2nu1hq37XDL03FWeezRU2rivd2EmTnrSHdJ5pS1tLOq3PV0ZQbQe130kL
X-Received: by 2002:a05:600c:3d90:b0:412:ba6c:8067 with SMTP id
 bi16-20020a05600c3d9000b00412ba6c8067mr151782wmb.5.1709227553392; Thu, 29 Feb
 2024 09:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229154946.2850012-1-sashal@kernel.org> <20240229154946.2850012-21-sashal@kernel.org>
 <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com> <05cbeae5-cd40-45a9-9b4f-68b9b20a6839@sirena.org.uk>
In-Reply-To: <05cbeae5-cd40-45a9-9b4f-68b9b20a6839@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Feb 2024 09:25:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VG1DpW3YukX691P59eN=oAnDxfWvm6CjpWFg5SxUmCRA@mail.gmail.com>
Message-ID: <CAD=FV=VG1DpW3YukX691P59eN=oAnDxfWvm6CjpWFg5SxUmCRA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 21/21] arm64/sve: Lower the maximum allocation
 for the SVE ptrace regset
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Will Deacon <will@kernel.org>, catalin.marinas@arm.com, oleg@redhat.com, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 29, 2024 at 9:13=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Feb 29, 2024 at 08:51:09AM -0800, Doug Anderson wrote:
>
> > As I mentioned [1], there's a hidden dependency here and without it
> > the patch doesn't actually do anything useful in kernel 6.6 nor kernel
> > 6.1. Maybe the right answer is to backport this with the hardcoded
> > value of "16" for those older kernels? Maybe Mark has a better
> > suggestion?
>
> Your suggestion should be fine.

Crud. Ignore me. The patch is fine as-is for 6.1, 6.6, and 6.7. :(

git tag --contains f171f9e4097d
..shows that the needed patch is actually in 5.19+

Instead of using the above "git tag --contains", I was naively just running=
:

git grep ZCR_ELx_LEN_SIZE

..and I saw that it still came back 9 on v6.6. ...but that's because
it was still set as 9 in the tools directory and I didn't notice.

Sorry for the noise. We could still do the hardcoded solution of
defining it as 16 for 5.15 and older if folks want.

-Doug

