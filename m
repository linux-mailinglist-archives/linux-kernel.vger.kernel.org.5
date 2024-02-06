Return-Path: <linux-kernel+bounces-55644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554B84BF63
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9D7289119
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976921CD27;
	Tue,  6 Feb 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WkntNrth"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5141CD21
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255750; cv=none; b=kEn1DxM0ZmBpFtPyrFqXdjtajH7ck0gK9kzAIoCSOCCGC81v8l3VlWP6oo/78nLRSfe5+L5H05+K6XAnvjN3ZtRURb8E4ip60SH90VtEOM1I6dXqjuFDB+oxiZfABow48eV2IaDYTc4jZBCp+j3eKbHvdsbJb8D/IrLQDTxAvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255750; c=relaxed/simple;
	bh=9EpY3q27+kVFUHToUhf8WVkvo8Qy2CfXMiaHw46HdDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTu0G+YcRsj2k8KPzZarPtqg5H20rAA+HLxB1yKpEA+HQWzeLoRcz83tFPAlLWyz2viymk0DtgSrqnY5arwADb8uymwRARqHqd+IGFW/BoTjsWt/ICGAuZjoZ8EiHyctkAU/AgQe/GedsOCMKHxoaPK97QEtllhTcNkl9dOFs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WkntNrth; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3832ef7726so121947266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707255746; x=1707860546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iryYz7hylJ1DT93uDmSpsU126/1wNwHrK3BHuf/iIR8=;
        b=WkntNrthPGEsuGEsvvswmdQ3XISMHaXF5jjZvlLTx+/TbupXUZk64S41DaCBgcgki1
         VTjOJzAwrFsoRWM+fmW6kor/G/yr3Gvzgl5tZSaotzbe77fwlUn8ZwlKZJ0QSABlNAMe
         4sRn2ZE/n40tnmqTEL6SC/9ev+Ty+WGawORs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255746; x=1707860546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iryYz7hylJ1DT93uDmSpsU126/1wNwHrK3BHuf/iIR8=;
        b=F1NXSiLQ+eaLERqrXc5/k6sNAQC8nFzyEp+PAD+PeLOBcicpAdV4UlXjwU41nyFylE
         0hK27s6O4OYGB+0Ec9uZS0Z5iAylEwqeCwaZI6pASZ7b2e3eQAoA0ZqQNkHDKnrDddi4
         /9muBTWIbTvlI846fwvh543xoHSH9DYhZ+j9wL8RU78XWlp/o0W66+FM6t+LWGv1sG7e
         0FoEdlzmZ0XtGm3oAJTEvbVqpm3CUIrJh5er6r4has0v+A2s/W3TuNO4ymSHMdlN20ES
         r/sNajAF+ZDDJHpBma6tSrBww7Mz6kSSMKNCYo7+DE+GNBxDDvNUMkBhv6GVoyeRigm5
         9zbg==
X-Forwarded-Encrypted: i=1; AJvYcCVSZCSxeoo5J5XPLSie9q3mPl2GUsMDg2tdyCKfshanCpcCirWRTXY2MiCzsRCuszX3Uknou9CFEsxqpZtZOtQMQNdw25wANdks8jVp
X-Gm-Message-State: AOJu0YxEcEfZX80aTBNOrArYxKhb1OOSHV1lJvC6fDJuuEW6ihnGTM/F
	U9Q++0ZpDRuKvwPT7YxftImhm/X8P6nJGq5E/6HI4GCWP9O8PBIn6aRMw70sW576s8JcjtDgPxN
	ABA==
X-Google-Smtp-Source: AGHT+IHrGefYEk7kFTI6LIFtsSKLFSKOIcd2wU3YiZhLt4d5dbQ9OJfeaKTlNB4u1fcMXjlheRemCw==
X-Received: by 2002:a17:906:a95:b0:a36:3f34:9476 with SMTP id y21-20020a1709060a9500b00a363f349476mr2808010ejf.44.1707255746402;
        Tue, 06 Feb 2024 13:42:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXlWfVYEcHH8Gx/FRoXXoqswE2Av8gor29EVCz8X3LH0FtXPs0gz2GF0QCAOoLMpbSLOLYPpeORZFTkId8vEFKzMoe8vFAh6/24BXAm
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id y25-20020a1709060a9900b00a35de0619dbsm1578014ejf.200.2024.02.06.13.42.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 13:42:25 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so21405e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:42:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl13WBOl4nSVhbu8RXQBxa5D/mXIuMwNnI5lREWQFM3uBtQS2zvTriGOx857Kg2aLiA/Pu4HwpVoBwi8mYdLCPkrqPmDJqy3tb13gA
X-Received: by 2002:a05:600c:4e13:b0:40f:e6f6:f9da with SMTP id
 b19-20020a05600c4e1300b0040fe6f6f9damr13851wmq.3.1707255745322; Tue, 06 Feb
 2024 13:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206095902.56406-1-yaoma@linux.alibaba.com> <20240206095902.56406-4-yaoma@linux.alibaba.com>
In-Reply-To: <20240206095902.56406-4-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Feb 2024 13:42:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XtZvgv8_gceKF0zztOv-yk7_0Kd19M93sWFqu-DF9V1Q@mail.gmail.com>
Message-ID: <CAD=FV=XtZvgv8_gceKF0zztOv-yk7_0Kd19M93sWFqu-DF9V1Q@mail.gmail.com>
Subject: Re: [PATCHv5 3/3] watchdog/softlockup: add SOFTLOCKUP_DETECTOR_INTR_STORM
 Kconfig knob
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 6, 2024 at 1:59=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> w=
rote:
>
> The interrupt storm detection mechanism we implemented requires a
> considerable amount of global storage space when configured for
> the maximum number of CPUs.
> Therefore, adding a SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob that
> defaults to "yes" if the max number of CPUs is <=3D 128.
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>  kernel/watchdog.c |  2 +-
>  lib/Kconfig.debug | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)

IMO this should be squashed into patch #1, though I won't insist.


> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 26dc1ad86276..1595e4a94774 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -338,7 +338,7 @@ __setup("watchdog_thresh=3D", watchdog_thresh_setup);
>
>  static void __lockup_detector_cleanup(void);
>
> -#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +#ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
>  #define NUM_STATS_GROUPS       5
>  #define NUM_STATS_PER_GROUP    4
>  enum stats_per_group {
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 975a07f9f1cc..74002ba7c42d 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1029,6 +1029,19 @@ config SOFTLOCKUP_DETECTOR
>           chance to run.  The current stack trace is displayed upon
>           detection and the system will stay locked up.
>
> +config SOFTLOCKUP_DETECTOR_INTR_STORM
> +       bool "Detect Interrupt Storm in Soft Lockups"
> +       depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
> +       default y if NR_CPUS <=3D 128
> +       help
> +         Say Y here to enable the kernel to detect interrupt storm
> +         during "soft lockups".
> +
> +         "soft lockups" can be caused by a variety of reasons. If one is=
 caused by
> +         an interrupt storm, then the storming interrupts will not be on=
 the
> +         callstack. To detect this case, it is necessary to report the C=
PU stats
> +         and the interrupt counts during the "soft lockups".

It's probably not terribly important, but I notice that the other help
text in this file is generally wrapped to 80 columns. Even though the
kernel has relaxed the 80 column rule a bit, it still feels like this
could easily be wrapped to 80 columns without sacrificing any
readability.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

