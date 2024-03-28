Return-Path: <linux-kernel+bounces-122649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F188FAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E94B261E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9A5F876;
	Thu, 28 Mar 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAEmTYP5"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801142A95
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617416; cv=none; b=XmKbUPrcCPl744PQ02x7L2pLErOZvboyknG1FnDnc4o0EwzockKxY+J87t9wOVzRgtwTMctqjqDKjhkVme/BhjxzgiXgy/01Y6EU6/zBPCSiSJa8VJuvgft+X0pF6XwPJip1PZQQmDfzatxpWEXkaiw4lip4C11QOyOod/jf0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617416; c=relaxed/simple;
	bh=W275z/IWuD11PMCB9o4TcgDN428EIWjLe3KPPkx6rzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMus/rqvmt5+SyANYGes+pYvRTWPlAyuwNvPv37Aor4QS09lNTmHz2DTTSiFpJeNrfTNto8aI7wc75YqEYre+TR25mNw+Qo0MtpptBy9flKYhKhXcFE/rNOVbsxj31XDC0EZ/pLKtwl3vYiUKdc+m06IFa4mJj0BO9it6NPv/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAEmTYP5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609f060cbafso8372727b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711617413; x=1712222213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W275z/IWuD11PMCB9o4TcgDN428EIWjLe3KPPkx6rzE=;
        b=FAEmTYP5X/26sh9oCve6i1z5bkmVJmZUnLhZ/kTBsmidosM/L2rpci5lyZlX3L4qiY
         xEAfApqFCdauvyLfdVEQQPStonDu3XZFV8Pgy8fw7bdXok8BBKFUMxYlIfA4mu7LiPL9
         /SWFjfHnPxbTo1sFEl7UVpxOrBd/g5QEoRC52UkV3dkbygG0OqwIPz73JbJAlHgl4+j3
         GatM+JdMSxI7GQ4SFiHrf4c6Uil9P+qxy9RGn7e8QDoaaf+OTNGROCezgihPdnZ8I2Ln
         FU28GwDoE6MUR2upyefabuJ6WHUNJnz5iPCHikum/OnmnCJJw7hVTwgHDhF7ayy5ue7g
         X/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617413; x=1712222213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W275z/IWuD11PMCB9o4TcgDN428EIWjLe3KPPkx6rzE=;
        b=jZ97mgU+JpjQC/6mgBapnIk8YSgl8DM7ArDimhROXQgO5R84OHb0UOp/guuobx3SoL
         JbZ/ztHm51iXYyTN98wAtFcx18AEqTfJIAlpmbmHBUcSSd2SnphfnDtD2Jg3X6SFMRKg
         SrC1szpNqp5L2+aCDfUKTO+R3lSeeN74ALDrlza5l2B/GAVqrThE05OZcnLgN16cLaD5
         2dEa3L+bPxH7+2/pfcebWAiRppXjylQe9cNrmj5+sDMRv0i+T72GxPy6Jogh3EE2lqLH
         0cLmhWe90UxeYH7h/DOfh+wBTYAJ+IlCF0H97l8yLPWaJxo1Nj6ZJjl5CG0fKY+rqfC1
         Mw7g==
X-Forwarded-Encrypted: i=1; AJvYcCWjMEtlUIaRRJcAeTN+fS7SnluhkkWU7gDXZeZPVK86YDPcBMxJ/Ryk8O/qwRxF/1ww7qkosp+dc8+B30z2vDWnCFgiBzqRRwXFYLma
X-Gm-Message-State: AOJu0YyENTVTJ7sEnHYc4Xmo1vluSd/7eQ4lmwcV6Ld1Yc4tcZ80cCqw
	O0f9LzVTkLPIFl6ZokvLY/XQRz/j/+G0AhOWc86YGwlSgZRmQakigPJRBJmXs/yZQirheAc1nIf
	u1fCdx/IyB8czGJhCrZiHYrzFqGVFr0tFLuXIAw==
X-Google-Smtp-Source: AGHT+IHRkTf8inGn2mE27T4DDRAM0a3h+ktBujX/BRlohTZAhDo+tStkRZRLPI58v2EqcZVGGY+9kbz/nNjf253kWd0=
X-Received: by 2002:a25:6906:0:b0:dd0:c2a:26f9 with SMTP id
 e6-20020a256906000000b00dd00c2a26f9mr2067038ybc.27.1711617413679; Thu, 28 Mar
 2024 02:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313024210.31452-1-Delphine_CC_Chiu@wiwynn.com> <TYZPR04MB58539A1D94340F330CAF3CF9D62A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
In-Reply-To: <TYZPR04MB58539A1D94340F330CAF3CF9D62A2@TYZPR04MB5853.apcprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 10:16:42 +0100
Message-ID: <CACRpkdZuSdkTXBF+4P1gMD4p4DsOJYivgrquuXas-R_UKg=JmQ@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: pinctrl-aspeed-g6: correct the offset of SCU630
To: "Delphine_CC_Chiu/WYHQ/Wiwynn" <Delphine_CC_Chiu@wiwynn.com>
Cc: "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 7:57=E2=80=AFAM Delphine_CC_Chiu/WYHQ/Wiwynn
<Delphine_CC_Chiu@wiwynn.com> wrote:

> Please don't review this patch since ASPEED also provided the patch to
> fix this issue.

I added your Reported-by tag to Billy's patch since you obviously found the
same issue.

Yours,
Linus Walleij

