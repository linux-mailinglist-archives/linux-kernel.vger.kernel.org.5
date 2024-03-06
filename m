Return-Path: <linux-kernel+bounces-94458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E187987401B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA6287368
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB813E7EF;
	Wed,  6 Mar 2024 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iav4H9D6"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDE13E7CD;
	Wed,  6 Mar 2024 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752102; cv=none; b=Lgr2xezHKNLGyY+RmUBDtsvwhTrRQ05LiboWlSqd4hvEkCdksY6ykj1H3V/DrBxyFVv2UM/RcUIyEQZZen4/4xmFoQzhUxyz2qw+prDWG0tsZorb9thTN1MnvSG5VEAeBR2MGLIvTdW4VLrV/kmU4XvvX6rPQK2t3KqKfWmDEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752102; c=relaxed/simple;
	bh=RV6mL5v2qERzLuB7fby5/iAWOoXRQGIT6BUiqUllKfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpQJxk3lKdTuxGyTTzWsxYBzd4P66K/VrwK5DrhqESgQwNsx8J96ktlkue5TMvRkySGqCHuL6XSks6AtyF6c9jJnXKicOY9LPOA0ak9REfRbmL7yKl1V8l0Xhy4L3m9L0/izyUUTVgA0hywC7qSyNT8OC4y7dpBaSuhjeQXwsk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iav4H9D6; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c1ec2d05feso1858019b6e.0;
        Wed, 06 Mar 2024 11:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752099; x=1710356899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9ljfn8pzLcyr0pmoDnBqgXrNCS95cr4N6iPjugHZLU=;
        b=iav4H9D6IMq6BGQleGOCznVC1Z/cGJfaTVXXjGJyXPxC5lVsAyJLeVK9zfslPuRAae
         +4+cuK3WjQKP1ViSAywnkG0Aguo8RGNV4rL6fFJm5W+KZtqe9ufyqqYjL9LlWajTOtWU
         GG9DoFoSvgG+hskBB3H9F5OxmOiVjQc8hclDsDRE8Z0dFLwRIY8dozCGTMcO/q4wmnWy
         kml7uRJ7ujZZ4DLl3l5XfMo3iJE0U22+SuKDt13midhOezdNzVZyJ0lqZWbVHxUEOi2h
         gebPRfV1uTuO9Xe8CQ1j0IKlGSMk7GA+Wv4IqJ7FuwkaQGg2wLk9bZhsv2e9Ut2d7FSX
         flyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752099; x=1710356899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9ljfn8pzLcyr0pmoDnBqgXrNCS95cr4N6iPjugHZLU=;
        b=fec4fwLHf67YYJfOFyi67NnsE9EvtlXUXoyzcg1wiCRMdt6Vb5e89jH0wh1WJAMPc5
         K/L7wVnEJBIWg9sYtw3/egL1lHGG0oYNxKHdyLI535JdflKTFwMuHX0At+16pg9Hhtdp
         q4I5Do/LSfJY/wzKAmMOiL6GtYlTmp9uoCN+B+VK7Lev8k52Rx9PdI4sm2poSeMXhgHi
         /qXRsknupyzV8Rsfr6thc7i2FtqV8x3IAAEU73jD8+N+RM3LcPZm2JTqFiJ8zGbY7DGl
         gEAjYzxOsnxyRJz3QfD3TYfTKDjXwS8qfFgVDRxUt6kDie3RHwOtEffrJMejSNdWsP0R
         WU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVG6ydRPCwilNCx1L/iQ+010Otpb3aKrPQEM3pht3prjTpOQu792+dKn95zIYlIyX8tZVGh9lfKDiUQvbGKPCWFi/uixzM7QT4VgT7W
X-Gm-Message-State: AOJu0YzkTGdLlnjNjo7ATwlVwSTyR994kBwKbFobWmFFbldeEMshLVAD
	OPjkI+IKya50hqrJkKM1hu1Ir+R2+Avb4Hl2J6x0JBR+HSGT76rUp2IQI+1Uxi/x7Cd66v9M2AN
	rwiyxlejxZPYFHDvdIlEQ6W0zxQg=
X-Google-Smtp-Source: AGHT+IFGQgNUfYbTsIVGa0MQeXkalL+JAaMYuehv8v54bumXXrGiXEnM64uhAFoqLtkLmDxL77ohByHAhIPdLU4DRS0=
X-Received: by 2002:a05:6808:13cc:b0:3c2:1805:8cfc with SMTP id
 d12-20020a05680813cc00b003c218058cfcmr4403457oiw.53.1709752098638; Wed, 06
 Mar 2024 11:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305113135.403426564@linuxfoundation.org>
In-Reply-To: <20240305113135.403426564@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 6 Mar 2024 11:08:07 -0800
Message-ID: <CAOMdWSL6uPRvG-DwOmWRs89WfchXzPUuG0KzkBFu46ibKfv-0A@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/83] 5.15.151-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.151 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Mar 2024 11:31:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

