Return-Path: <linux-kernel+bounces-103337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34687BE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB1288AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22326F53E;
	Thu, 14 Mar 2024 14:01:51 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3115C6EB73;
	Thu, 14 Mar 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424911; cv=none; b=gYkYRj8slvAQepHyOg3LPcztDpa0+CjnznOf8f+S1xgsM++ocs9YNqNIOlvxlBZZoWJwlmxb+rxgPw0xB4rrknKup3JACgyrqswhhObABSyp8KMN61eRDuWiU+k6yGpMU4pbq08E4gtfm2hj7RXsW7EC6PWZtbEc5jVdg2SeL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424911; c=relaxed/simple;
	bh=26IvTvQg8Q1DCffM7XYqhRz02vATkODwSLqGA4wHP1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqxp6agzEg0DmylYT9CrAh02wL5rbFZ94TtdFUxh+BCt3p4nparkaEBfETQ3OBSwAP/pE0ZoOC/8CMEabnwE1pjnA2saIxHbRorH7wfgw08ZWnh7tCEfv6FcjxdL43hmCktRlo5A+Fj8iD+BpyYFsV8WY941c/jENCzzJlhZJZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a46ad0d981so39491eaf.1;
        Thu, 14 Mar 2024 07:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424909; x=1711029709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlUOEVdCSeBaOUnlZslF3hthRjVOvINmoadUntekmTA=;
        b=uDmmcDMxOa8z8gsB7teoQvAwNl3CQVl9SJsZK5ZV+snqPDoSrPV5KMk3z9DWzh2gJa
         r4YxdH3CLldyov2W0QutB7Jhjm6yeEgmgnfmaHwwpAXpfF6Sy1/MspdZO01dDAyifsQL
         2bX2VjlElJL2lkhQPBRBjfLP1SA6KM+RxdnJBPlrusfAFfWy0dTv4X1/rH/iYAawptlQ
         aNwDNruKCIjh2On+a/G/vCd6ClN6Hg2c2c1Qzy2aJDqOqcC0DuzduUjD1WDkoZfLRTq/
         CRH8nrON+mYDuR7S0uIZPtdcvYRaI+l4SjncXDCA1Z3QKJqaL2pqaFbBwT/rHVDCVgUa
         Gg1A==
X-Forwarded-Encrypted: i=1; AJvYcCW1ScvB5m8yIoB6hUdE/4QtoFEeDpUbMCbcknGPx6nrMKNITECPG9CpqcUQscQ+7NdnXiPpl5lqyLxMsA1QEkNb+ekxHfPiHJUQ/WqwgUyDLZjFtg54ZPuxoAZzEgfkpG7HcUmZH2U=
X-Gm-Message-State: AOJu0YzqBhcLfrz70LtNBYC4LNGEMm7GfjzDOymbe5CwAzeMOlqfWew+
	9l0gW3fxQt16IE1qP33q6P+qS7WZ6wbQn7Zbs8/0tBv3PfS9lJWpglemwSprHwSBkPFNnSFaqR1
	Bs1Y+TrbKygYTSpWVMzeew5N9dv8=
X-Google-Smtp-Source: AGHT+IHgkJcz+tkEM2LlBM12CUpHuGpPaw+WbJZ9d5/mHiTfNKztnU4wt3pT0Ity3gbnnDlYPANT7N4C9ObuOS2h6RQ=
X-Received: by 2002:a05:6870:9209:b0:222:4480:6577 with SMTP id
 e9-20020a056870920900b0022244806577mr1953757oaf.0.1710424909035; Thu, 14 Mar
 2024 07:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314075429.1164810-1-d-gole@ti.com>
In-Reply-To: <20240314075429.1164810-1-d-gole@ti.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Mar 2024 15:01:36 +0100
Message-ID: <CAJZ5v0iUt+tudMV-rJ80GR6iNQVv06+054h0UyNgpEOUF6QLRQ@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeup: Add a missing return case in init_wakeup
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, theo.lebrun@bootlin.com, 
	Sibi Sankar <quic_sibis@quicinc.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:55=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> The device_wakeup_disable call can return an error if no dev exists
> however this was being ignored. Catch this return value and propagate it
> onward in device_init_wakeup.

Why does this matter to the callers of device_init_wakeup()?

>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  include/linux/pm_wakeup.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 6eb9adaef52b..64c7db35e693 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -232,14 +232,15 @@ static inline void pm_wakeup_hard_event(struct devi=
ce *dev)
>   */
>  static inline int device_init_wakeup(struct device *dev, bool enable)
>  {
> +       int ret;
>         if (enable) {
>                 device_set_wakeup_capable(dev, true);
> -               return device_wakeup_enable(dev);
> +               ret =3D device_wakeup_enable(dev);
>         } else {
> -               device_wakeup_disable(dev);
> +               ret =3D device_wakeup_disable(dev);
>                 device_set_wakeup_capable(dev, false);
> -               return 0;
>         }
> +       return ret;
>  }
>
>  #endif /* _LINUX_PM_WAKEUP_H */
>
> base-commit: 9bb9b28d0568991b1d63e66fe75afa5f97ad1156
> --
> 2.34.1
>

