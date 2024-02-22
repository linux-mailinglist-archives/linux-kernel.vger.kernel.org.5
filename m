Return-Path: <linux-kernel+bounces-77235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5686033E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E40B2236D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3653FE2C;
	Thu, 22 Feb 2024 19:13:47 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD714B832;
	Thu, 22 Feb 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629227; cv=none; b=m6UKhLbUDxzf0gQzrrfXsbwziLe+oNwIJGWXLd0Pg83BfcZ7sAk1bu/H3SAhw7TBX6ewcOF23bIEEGR9ZciHYdRUEroCX4uyrGlPC3zDkfHmE7sJXJwrWTjrZ1pR1NiPZaVXrt18dDdcgB8XJzyFzAaEqL8cq5nbroAn0f3iqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629227; c=relaxed/simple;
	bh=IeOp+KL4CTn7TrHHxlcpdN0qbLcMYmDqSuspQpz3sCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lh18dvevn1VLLay/E0oqEeYUH3vWkP6e7+C5KlTykY+GSfeI2uVsvVmvW4Hx2Cu2adFSisjsDu/GqdH9eiF3VZTC0DKhHuqjsSDuDn88fW7KOFUBxcmyXOB57IAyVXKqRU6oexxPfp6YO/iB2EW8dyI4GevsrqjVAgwwHrtCkzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59cbf204d52so23847eaf.1;
        Thu, 22 Feb 2024 11:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708629225; x=1709234025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bw694YiLLDo87mFJ0mgfOHqHHm8OlAzRnEOiLD4+wi4=;
        b=lPws/EQ5OnmFwrtagM1//EDLfFPIgw9IU+K73CPJYMpT2/yTWEQCL2OQwVSunKJkvi
         L20He3BP6frxM7Vk4bVQIBHnaxGl+0+ueCj3enTeP03AzfJVNVpCSEZqco0P3/2Dvebu
         y6RMIHtFH08oEptXhC+UdCvqJC523QerrBM5GjXGjxxEf5awt/+JxB2eFCmJ2GF7YVbv
         CDBFPibLin3sE6O1i26U8WV/WHEwNM6/3C+V+05jDAGrH2uRweAAUa48kuEUpdFr4PCM
         aWH2BcJErUbqZoUHXbDrrwCeDUmgfk6As/NFQ0szcF+7AR/B/aD4sZRPrE5BNqw1YkeO
         O5lA==
X-Forwarded-Encrypted: i=1; AJvYcCVU9tF8QV4eMxdMmHieqw4N1uI/5QtSIOsexpcLNB5DXNcrNnpn+VMdGELKNqbbn3/gDcOiqXmPpy4u8VLlN1aFRp4xdKgHQCcv2gu3eisyjGG1jwQJKMAk2iCc6NjjO/a44KwCr3U=
X-Gm-Message-State: AOJu0YymUOEWg1ep5mpVfmLjW72z4Pe3WYPVb1ecpe+JsXCcLAb9qSis
	JdvxYtL9m0HlM8aADhuk22+xtJcEP00O+3uEo/jBtXTUwkUeduwrPCr+5Dgshm8U+wshISQfTxb
	jVBwf/su/nspbQXEYj+QmjuYYzm108OEZ
X-Google-Smtp-Source: AGHT+IFz9zGZ03+fYDSfLMiO+Uil357ihXrqoDbrrmOln7XtQGrdrlEy87hZ7aDuhAoc3J7JJi9qYm+LFIqsjPEYZxM=
X-Received: by 2002:a4a:e713:0:b0:5a0:2cbe:43dd with SMTP id
 y19-20020a4ae713000000b005a02cbe43ddmr2312337oou.1.1708629225049; Thu, 22 Feb
 2024 11:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217213010.2466-1-dsmythies@telus.net>
In-Reply-To: <20240217213010.2466-1-dsmythies@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:13:33 +0100
Message-ID: <CAJZ5v0gWPQhgmD1nCxJQhwzvUxVuCMghT28AkqCMGk-pHkuwrQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix pstate limits enforcement for
 adjust_perf call back
To: Doug Smythies <dsmythies@telus.net>
Cc: srinivas.pandruvada@linux.intel.com, rafael@kernel.org, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 10:30=E2=80=AFPM Doug Smythies <dsmythies@telus.net=
> wrote:
>
> There is a loophole in pstate limit clamping for the intel_cpufreq CPU
> frequency scaling driver (intel_pstate in passive mode), schedutil CPU
> frequency scaling governor, HWP (HardWare Pstate) control enabled, when
> the adjust_perf call back path is used.
>
> Fix it.
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index ca94e60e705a..79619227ea51 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2987,6 +2987,9 @@ static void intel_cpufreq_adjust_perf(unsigned int =
cpunum,
>         if (min_pstate < cpu->min_perf_ratio)
>                 min_pstate =3D cpu->min_perf_ratio;
>
> +       if (min_pstate > cpu->max_perf_ratio)
> +               min_pstate =3D cpu->max_perf_ratio;
> +
>         max_pstate =3D min(cap_pstate, cpu->max_perf_ratio);
>         if (max_pstate < min_pstate)
>                 max_pstate =3D min_pstate;
> --

Applied as 6.9 material, thanks!

