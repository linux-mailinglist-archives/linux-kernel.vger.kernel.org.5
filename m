Return-Path: <linux-kernel+bounces-72534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24685B4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33D1284A97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9E25C8E2;
	Tue, 20 Feb 2024 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8sjxzfE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDB5D75A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417266; cv=none; b=C1KmIdU2HWR81pNNGxQ1eSOOMlq3vDOXm1GKg7s78j6F9kuKvF9XRhEmidXZflbKkFxTLGRoOPWu/fpET/uEcHH5WbcThUr0fPcjbI0RCCiRwQlwPOx1c98fw9efhpbSb+j6n8drRkwlaCQY8wa6xcEp060I13+V/R/r6btkk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417266; c=relaxed/simple;
	bh=o54ifFwgPSsxzCggMuxYL9ZhcWftfWMsUn207YwDOZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHFg+JNMXWX90NileV78sf2zTINdeTB8LWrw1TWGu81E3FQBcIhqe4uk7IvHtu92UcSwr+3Foe31mwBLJrNl67kVR/+qy3jhOURpJ8FmmRkG8X3NtSZGeFGnPGba9YRFfFmJ3c4R2v5yHTN9CBPr4V3UAckvTsPlECcBlaMWGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8sjxzfE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso2114595a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708417263; x=1709022063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/y0ZRcM9AeqXbMHdo/rZFfK9pZ+QAzjI5XqSR9aH7rI=;
        b=E8sjxzfE2lI6zaVTeZgAeYDNfF5b2uiqr1/kt+/M6nYCX61HS2fCn5D/wrPH6byMTJ
         +IP0gG1d7EL/hU9ZA6HIHFGc1FqSHGIt7YnAp3TafnzgOZrLHiHLuM867gvyzOniA5GE
         jrBVJk0niBaSp7ZAsMH2qmhza8ZA9YpteyxxxA7iVOtZ0Bs0unAI3DPozsYBhCOj82aL
         JftLuuN26Ul6Wnb9KN77IybwvwgQaWu0zUy0iMkBU3NglD9Q7j7HTx5JraQrgSuhTMKZ
         r1/y5KPFn4fOChsC4RcFVikbya2ici1YQEF27PgRAa4f42UWyUUxOYxCObN85BL7gBC7
         8p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417263; x=1709022063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/y0ZRcM9AeqXbMHdo/rZFfK9pZ+QAzjI5XqSR9aH7rI=;
        b=IkHUOmqXuVvdMe5UUC8X9cXfoPulXy8tr7s7wAx+BGJ/WQujYzCM6UM1UByfYnt9Oo
         RjkLjoKmBD1qkY3aNvYfBJRZPxtn957xxveGxzUQOESvi+Pzmm5kmYa4bhzjvEjsqTiq
         a1FFB+DNz16OEcKiNaqpri5YMsEWc5eAOJExuLSb3jhKebV4zYi/HkVE+e0eJFWIV1tu
         9TVu1cjxxEua2tAwh1LuyoScDMXNBaLS8NLB/2O4fLVkZkmnbTWk1786BBBhMEGe+9kU
         GDJih/q1bCBuyBtNk0l5dNYa/CI2a0ItXIOBcV6IBXMuLZkeKreZ5GBNYw+LZAs2sAV9
         E41g==
X-Forwarded-Encrypted: i=1; AJvYcCW+Mu7QTVZEm/P13apZWUC5nN1TZ4q/SfQYPR5FZDvOvSSJgDk699b+q5cUmG6kBVNuF0ZzkvEN3xpu22kxd2DzxgogLTHVqI2W/XmW
X-Gm-Message-State: AOJu0YzR2JmQThfW4/jKbAzjc0asIFER6XnhZBoGkUvwKZZgRWDWP4Ah
	IMhhjTTVzQT3cERt/HrCi8/SGQCSI43vVtE7Qs4JXzVpA+3lxYJ895+fKOcb/tAC8CtGMPI+XGL
	wEUF55r8qHXjAcxxrU7/ex2zJ/f9iWslzHIgS
X-Google-Smtp-Source: AGHT+IFJd7ykTaiF5QgxEIxuB8aW3uriUy20BSKF+VODu+o5a9+WR16O88j7rZTp7Zcps7RfwH/iXdALxGGiS0b6mJo=
X-Received: by 2002:aa7:d685:0:b0:564:67d0:b8c5 with SMTP id
 d5-20020aa7d685000000b0056467d0b8c5mr4053570edr.0.1708417262542; Tue, 20 Feb
 2024 00:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220081205.135063-1-raychi@google.com>
In-Reply-To: <20240220081205.135063-1-raychi@google.com>
From: Ray Chi <raychi@google.com>
Date: Tue, 20 Feb 2024 16:20:50 +0800
Message-ID: <CAPBYUsAnuyLwek39GJiwin_Pit0waH-2fhQv-G21OYkjoz051w@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: gadget: remove warning during kernel boot
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	quic_uaggarwa@quicinc.com
Cc: albertccwang@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:12=E2=80=AFPM Ray Chi <raychi@google.com> wrote:
>
> The dwc3->gadget_driver is not initialized during the dwc3 probe
> process. This leads to a warning when the runtime power management (PM)
> attempts to suspend the gadget using dwc3_gadget_suspend().
>
> This patch adds a check to prevent the warning.
>
> Cc: stable@vger.kernel.org
> Fixes: 61a348857e86 ("usb: dwc3: gadget: Fix NULL pointer dereference in =
dwc3_gadget_suspend")
> Signed-off-by: Ray Chi <raychi@google.com>
> ---
>  drivers/usb/dwc3/gadget.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 28f49400f3e8..de987cffe1ec 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -4708,6 +4708,9 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
>         unsigned long flags;
>         int ret;
>
> +       if (!dwc->gadget_driver)
> +               return 0;
> +
>         ret =3D dwc3_gadget_soft_disconnect(dwc);
>         if (ret)
>                 goto err;
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Attached the warning message.

02-20 06:01:24.227725  root    86    86 W Call trace:
02-20 06:01:24.227730  root    86    86 W         :
dwc3_ep0_out_start+0xec/0x22c
02-20 06:01:24.227738  root    86    86 W         :
dwc3_ep0_stall_and_restart+0xb8/0xd4
02-20 06:01:24.227747  root    86    86 W         :
dwc3_gadget_soft_disconnect+0x1a8/0x284
02-20 06:01:24.227756  root    86    86 W         :
dwc3_gadget_suspend+0x18/0xe4
02-20 06:01:24.227764  root    86    86 W         :
dwc3_suspend_common+0x5c/0x320
02-20 06:01:24.227774  root    86    86 W         :
dwc3_runtime_suspend+0x30/0x4c
02-20 06:01:24.227783  root    86    86 W         :
pm_generic_runtime_suspend+0x3c/0x54
02-20 06:01:24.227793  root    86    86 W         : __rpm_callback+0xfc/0x7=
6c
02-20 06:01:24.227802  root    86    86 W         : rpm_suspend+0x534/0xd78
02-20 06:01:24.227811  root    86    86 W         : dwc3_runtime_idle+0xcc/=
0x104
02-20 06:01:24.227819  root    86    86 W         : rpm_idle+0x228/0x4e0
02-20 06:01:24.227827  root    86    86 W         : update_autosuspend+0x50=
/0xb8
02-20 06:01:24.227836  root    86    86 W         :
__pm_runtime_use_autosuspend+0x50/0x6c

