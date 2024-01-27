Return-Path: <linux-kernel+bounces-41463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9CE83F23D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C709C1C212E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E049B22F17;
	Sat, 27 Jan 2024 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpfmGgUC"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660621A02
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398577; cv=none; b=V84Daha5j+6ePA9fQ79IDYnXL2BDzbcA/4ttVt+4YuI+wx7f8cG0zLv9k0rQw74jKKvs7yHodV4DDaMra91DwmiMKiyevmeLGMjhyJEdOaQKrIyXLCQD4eiIbAeiMjR4RNPaizp1LNuSMrDSMQrlQckwbFTKsEfbpm/qgO/mmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398577; c=relaxed/simple;
	bh=XVKbaMpkpPl4OamNNqyBIfrPPvBb/CuhmBwz5z4c778=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8iGtTMJ/KjVO0C7Pel6JeM3/Wt1D5eKHaT5LMwxvQdRU+1VxDTgP5nJOvXB+FrqwKNiISD9218bz8e9u0SPYD7WU4NGzHeoSR+ICPVptZwYoBJVZoff84pD43JWb8LwE8zY/pQNEHaH+Ke6nF9CKrEdzV5if0jiF+y5CAS51JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GpfmGgUC; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783f0995029so60399185a.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706398573; x=1707003373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVKbaMpkpPl4OamNNqyBIfrPPvBb/CuhmBwz5z4c778=;
        b=GpfmGgUCzBt6GWD8FZab7OoSg3wEV6+Q89BeHMQDsO/fsAkiSvbomXq58QNB2qAKgR
         oh+QeOn8F7vso94xK+/eHtvYcCkUrlx8h0MfcpWDqQBC51s2GsMs2Ux3G/Ku9gB6dnxx
         feqWCcLKGl3Mhw5ccRANO1MBh+F4TWD8XqPWRyueCVvduWZTJ8MTjUYvrjaq32Cxl6vC
         lo7zJyeqpS0IuCFAtPap38X+wG3BdqJ5SzOCfPeY0iSQkESRNm0sbfYkBZbZUj/6yOtI
         dmoTZPYcKpA/QHJgcNLVs6mwl6RvPw9o1arwbUZ+cAf2+sZjsPFh1fK3vlmCljDBAFw/
         QqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706398573; x=1707003373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVKbaMpkpPl4OamNNqyBIfrPPvBb/CuhmBwz5z4c778=;
        b=A/b5QHEQYwRPXDZ3wyUQgruULSneg6DfT54kdw7E9w8iMsya8nil/tvBJksZt49vVw
         slST4YsI0HPHvWtJ0oIiw4tfXxKujnJxSPe61dWUxQ6cZx/V+NjwtH2vl/njHfKQ+T+Q
         z0ruzbVLfu2FxcJgsPgitqID10oAbtBs6a6Wd6Joo8OBTXDts2S8OhGasgiVjVoyjDj2
         vbuBTecaxbrxQnS4KiiEVbWr6KAaiOho3kqhAlQSE51NjknBPmaxY/7YHrp7rm3SlP03
         3BzTI95WMozvrSC5vvGMduGpPr5E2k6hy+SeF3uwA0F/Td4I9/B0EIdezh1rHKlm5m7g
         QWVw==
X-Gm-Message-State: AOJu0YxYByj5a2Y7y8V/36S2MpV8NzbFbq+HwlxEaerLee9NPzv1hjik
	MWgK+C4fzCcoL//n/u8uCZ+93YWohW8az6cnrUD6o70C54NgpOxlPtHzFjKw0I409xDkmC/j2sJ
	GihDwKNgmcWaCm+zIg4M5HGjCgr4li/YYBXh0eQ==
X-Google-Smtp-Source: AGHT+IEgp6Wx5JnuWyXYHz8pZVr0cnqh2sFmftzNYViLIBvxeKcfFE9nBHRj3w+ge53ptzIE4c2ITaNbwP7ir3iKXKM=
X-Received: by 2002:a05:620a:20c3:b0:783:df74:8f97 with SMTP id
 f3-20020a05620a20c300b00783df748f97mr2269258qka.148.1706398573145; Sat, 27
 Jan 2024 15:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110-pxa1908-lkml-v8-0-fea768a59474@skole.hr> <20240110-pxa1908-lkml-v8-3-fea768a59474@skole.hr>
In-Reply-To: <20240110-pxa1908-lkml-v8-3-fea768a59474@skole.hr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 00:36:02 +0100
Message-ID: <CACRpkdaZGc1z8y7NmS=xeHBSFkOe4agMaSBspcikTnrbaeB8rA@mail.gmail.com>
Subject: Re: [PATCH v8 3/9] pinctrl: single: add marvell,pxa1908-padconf compatible
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, 
	David Wronek <david@mainlining.org>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 8:04=E2=80=AFPM Duje Mihanovi=C4=87 <duje.mihanovic=
@skole.hr> wrote:

> Add the "marvell,pxa1908-padconf" compatible to allow migrating to a
> separate pinctrl driver later.
>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess you will merge all of this through the SoC tree?

Yours,
Linus Walleij

