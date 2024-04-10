Return-Path: <linux-kernel+bounces-139015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB07E89FD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489C01F24652
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2503017B517;
	Wed, 10 Apr 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBvjwr39"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE637168;
	Wed, 10 Apr 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768070; cv=none; b=uLKGzBmIjnYDSFZRB8xmHgEaooQDs2/pc8ZZsVC9OIriCJDAEGLPtLUpFhGbiFWSbJUSPNjRkp4UkGTd6pVi5QSpqUpj3Sv6kx7z3rlA3dNmVyGqv/SiT6SXo3pmKJAqQX7kXJ/ylUFxcEA4rSN4h/pZ/hhnEKuzulmEK0gfVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768070; c=relaxed/simple;
	bh=zwlDg9/1hSuObtlSGaTY3exZ3N+xdT9nMbOiP6T3UOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeTkFc/M66f9R2wB3vB+73bKeQqBxRuPOkrrnQvHL7pn5pBSYKOHG2uulQrXZf+Dp4y0RDuqricHQPOmTrf/Depd1V3eVnZO2I7EqXpiWeADcluxZ9ExuBO2W3cVg2hrchOPoeQ7szw8mFrmF+sUUM3cdPseBY9CU+ntYngIz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBvjwr39; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e3b3e33aa7so2146261241.3;
        Wed, 10 Apr 2024 09:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712768068; x=1713372868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xCpgn3TUI1W6VpBeBlxwlanAlKAbO3XDDqGUvQLzy1E=;
        b=mBvjwr39C5Zh0iOPPREHJCfj0MMAAvtwKW1NeW4+7v5Z3PDN0PMeiiVfWhEW6QvStG
         zD8YW9eTybHUcS3jzLs3O2y9LoPEr3qB1wI3wR2IcBZGk5cSNrgxxiiW0yNXY1SDxblL
         08Debvibewsx91jNx0YeEiseUDtPWODidHjnLmxmakUsuP/APDQrafMKj5iu/bcHV/bl
         JyxB+uV5HpLhDc6/VuQcCw3RK7MCStYecYyNB17TCl26DDvgoHCPTBAYiLy40OkWPua9
         +LuK7bVju5RBSush98D74XbrR0WS++L3AnDHsoC8WBnwrMyLgcA/k/heIYnioE3fkObE
         uLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768068; x=1713372868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCpgn3TUI1W6VpBeBlxwlanAlKAbO3XDDqGUvQLzy1E=;
        b=dk+az6SPL5kyZpy1FpHy9BpgukCqJIxxOh7jr+jDBabn/oIstbp13SdWfnttKikYbq
         qGVTtOiHIuvMpX1vgSGYXvugdYNQMZaTwa+hg1H6iMoyN8rhHYZDW6jR7grgpclJvQe6
         /cB8yrG8F1EGuEs1spWrdZ2vpcX3MlHwtKQKXzRW0EqxxQj/27QuOhUrl6FBrTjUlpdI
         vh5HjBGoNy1/DxUCWourmwHRnY80fIt6nUyBT0qG4rlV9xits+5/ZR5JvVZrNTDxJxTU
         3lyxXqvMap3esYj1zvPGjCV3sJSOtCx5j++YedZTbte9xE1wXbRTtWEvyCAKASREJ/8B
         a4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU8D++PhCejpboXKWnc2BPGciTpu3zGYU+c+XgH1Nbg1duXKu5KXcynPGMCGuL2rO7FXgpWCjPI/7OOpi6MnHyjGE9dSpSYmxXEN0JT
X-Gm-Message-State: AOJu0YyEds6r0QM6vYFJddsxo9CTgCRRGreU2bjdKO4vkXDmD4oBi0Sj
	gZIqoyjJKgKLLfwDwxltr81MXNfWmTYF2B4O4OU8SWgHuARiaYEJ3t1MJ3YzzabUz/9S/O4tbmP
	86yTiwHyD8SXDhnK1+edExmtPsIhmPoQ05OZX7fGv
X-Google-Smtp-Source: AGHT+IHs0NT9FujmzqfkTaGL1Gja/LO0oPxaJHHEEJb7qEVPHKd2NAsTDAsyiqJqq3NR4g8JjriLrFHpCsuR4xvYSLU=
X-Received: by 2002:a05:6122:21a3:b0:4cd:b718:4b08 with SMTP id
 j35-20020a05612221a300b004cdb7184b08mr3476190vkd.11.1712768068041; Wed, 10
 Apr 2024 09:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173540.185904475@linuxfoundation.org>
In-Reply-To: <20240409173540.185904475@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 10 Apr 2024 09:54:17 -0700
Message-ID: <CAOMdWSJ9bD==q9ebEwkRLLKRftL0NhrJFiXj140BR_gehWMkVw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/255] 6.6.26-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.26 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

