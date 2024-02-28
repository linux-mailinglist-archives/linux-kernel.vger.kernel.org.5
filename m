Return-Path: <linux-kernel+bounces-85641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D70C86B893
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5537CB22E26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66965E07B;
	Wed, 28 Feb 2024 19:49:24 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D095E06B;
	Wed, 28 Feb 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149764; cv=none; b=goLblhb0ExL1rr53ZAWozHGqf8tiU5JjN9OoIWwkIno9bpdMMLuVUfn9G0ASszCUUxOZxqHCEjjVeuryRGR+Ksahjx2MQGM45kdTQZEDQrDQmGrFrCbQttkL+u4B6guMmFy1pPobVUS39axGL6Ha7InBFoZ3qu2oHAUyb00CbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149764; c=relaxed/simple;
	bh=hNwxsxFHkT45A9U15lhdDgR4JMddTjGXDbtNCjzgf30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boDmGX4ekuw5YzcL92RYe1W1DvB+kSI2nrMQvtxdD+G6sG7pm4hhFgVK2Wv2HPm/e5kdm3AzQtaewn3f1jle0K+D2we8Y6mY6s7I2dXqKGmPnPYEIhoJ6x1lE1+kM/bmRNRW61Ds0MqfXE2l5odt8wqboeN4BTDexqK/Xokix34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a05210e560so8003eaf.1;
        Wed, 28 Feb 2024 11:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149762; x=1709754562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE1qZn3b1IzgdRSGPsE7fyXZDTJIgSzw+q5wgzCIoO4=;
        b=s/T+DIVAUCXSDDFKCVHpbEvJtjgKAjAmEobt0Ss8rCyBiLynkbMC64azZpBxkkARYq
         EcEtKH6zcnakyLqYBfFNWnK9P2BsPnSSpnJhIpwy3ny6zVHDy2HibiDFgJWMJlySu9KV
         WMsHDnYoRCm+Qd1aGYTOXRii/jll/6nFA1RWb0Ba3CDuYnblXsI/OADQDelt92AfW2t4
         vyW6poL/tqVG6zX4ZKqa/9k+iZClU81JJ4/rqJo20obaEby0Un1Xiebx6u+I9eSLLKwc
         GYXwZdnqobfgrdcBqztsd+HMhjBOrJu4pq3HBkXqAphYckjD8573/TvXE3Amb3Ddt75/
         n0kg==
X-Forwarded-Encrypted: i=1; AJvYcCVESbSkd8r/gjAM7nrrqOZ2jVAdEb98ljNWg1zYIGd2RiVpmmHj5vFmsYf+OL18Nm0PzBkV2V1rLo3Z0Sf8HeqmDMrclxxuMXTKarxf6s6AMIKNk2h4CXOhdXMqSjinWjpXxkwbzZQ=
X-Gm-Message-State: AOJu0YyJKqvKioaCxd9GyvmYrZuZP0IwMPo3xFF8YxIuEVhKYeTTz+cA
	eaqocShC4VC+t3a4sVao+HrYLauLybMcvb84aGEHez1kpv08+9ICypQ2jhJUuTi200AqLSw6q8P
	qloXQ4E04k3dMTtyu3jMZXdTJ3Yc=
X-Google-Smtp-Source: AGHT+IE+xd7u/DgBb1KRV3ePR137ikxvmmIT3/LJpCMU6zKr3aTutJNpQUrMVOtwKXAPYGcHnR9vTYjuqS4mlX+JW2o=
X-Received: by 2002:a4a:d317:0:b0:5a0:2cbe:43dd with SMTP id
 g23-20020a4ad317000000b005a02cbe43ddmr58582oos.1.1709149762003; Wed, 28 Feb
 2024 11:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227194112.1289979-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240227194112.1289979-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Feb 2024 20:49:10 +0100
Message-ID: <CAJZ5v0iC4+SiBK6efdC1ALEEG9Yb0iO0LCvMa8qwFhTZrQzqQg@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: processor_thermal: Add Lunar Lake-M PCI ID
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:41=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add Lunar Lake-M PCI ID for processor thermal device.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1 +
>  .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.h b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 95c6013a33fb..674f3c85dfbc 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -25,6 +25,7 @@
>  #define PCI_DEVICE_ID_INTEL_HSB_THERMAL        0x0A03
>  #define PCI_DEVICE_ID_INTEL_ICL_THERMAL        0x8a03
>  #define PCI_DEVICE_ID_INTEL_JSL_THERMAL        0x4E03
> +#define PCI_DEVICE_ID_INTEL_LNLM_THERMAL       0x641D
>  #define PCI_DEVICE_ID_INTEL_MTLP_THERMAL       0x7D03
>  #define PCI_DEVICE_ID_INTEL_RPL_THERMAL        0xA71D
>  #define PCI_DEVICE_ID_INTEL_SKL_THERMAL        0x1903
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_p=
ci.c
> index d7495571dd5d..4e1dfd283651 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.=
c
> @@ -407,6 +407,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm, proc_th=
ermal_pci_suspend,
>  static const struct pci_device_id proc_thermal_pci_ids[] =3D {
>         { PCI_DEVICE_DATA(INTEL, ADL_THERMAL, PROC_THERMAL_FEATURE_RAPL |
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_TH=
ERMAL_FEATURE_WT_REQ) },
> +       { PCI_DEVICE_DATA(INTEL, LNLM_THERMAL, PROC_THERMAL_FEATURE_RAPL)=
 },
>         { PCI_DEVICE_DATA(INTEL, MTLP_THERMAL, PROC_THERMAL_FEATURE_RAPL =
|
>           PROC_THERMAL_FEATURE_FIVR | PROC_THERMAL_FEATURE_DVFS | PROC_TH=
ERMAL_FEATURE_DLVR |
>           PROC_THERMAL_FEATURE_WT_HINT | PROC_THERMAL_FEATURE_POWER_FLOOR=
) },
> --

Applied, thanks!

