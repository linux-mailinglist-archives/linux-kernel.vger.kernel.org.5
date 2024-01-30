Return-Path: <linux-kernel+bounces-44676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BAC8425D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848CC1C274D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1E86D1C3;
	Tue, 30 Jan 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loLnwade"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436A6A34B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620205; cv=none; b=GI8MP4pZpSgbj9RnHTBH96z5kxuR/szb91uFDcQ7zysUt6KD1toU+IEHm46JNhTmGha5JY6SHKPub/LVqKOD17xlwhFOFZemS6qoMdmxnIG6PAoeIoCiUY4vyMo5/N1srIFuKQ7IfSQWR6VGyhoPYr/9umwWthxuDmPmVoRBflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620205; c=relaxed/simple;
	bh=4/LR4FlPqyGgY8vDOPU9zbxtotdGsmFZozHdb0jD0KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQYZvLACyWJ5Dtzc44uYIEsuZsAW2SbPrsnR+ti3wsyHQfS2AHvAvXoATSkWD+MH6qZQDG9nrm7s3EbiJBBkdoVsHMj2GlbNoxUc0eredD4dduOQ6YRG8S1mjd5IHiseriGnno6o8Xj/PJc2XW34yLjSPcqHZKcJD2KTUoWGMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loLnwade; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ffcb478512so28435857b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706620197; x=1707224997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn6tr3K56Ei1Sf/jm4iMFciPE+uwKnz5rDJj/hsfnl0=;
        b=loLnwadeSRb8t9E7lKtThgZ6LR+ulDJW8u+uLIq3dnv0ZWt2ih5MNrFkwt3TzhadvI
         wH2kNgDNJuGqZi15xU7V3vaQ1JojvBCn/vNr/DKHD/85eFxspKnPcRsmvLYVg4u7b/aU
         JF3Eunt0oYrHucyrrGUHIQTWB7VLhA+QPLluRUsyDbS20Fu4pGF+93pdDW7dHDJY+47l
         hZUpHtrZLYdbkUXyNj8YxlPq0nvmiVbsqyx/bgK7zCZ3qI6bc7zngrpYBOiKfbLbjTqE
         2P0YudDXU7mftCfTUdVLD/AOsjB5ns6rw9J+i9AcxxNInSL3U9rK+eygnZ8fBM5+4kHz
         JMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706620197; x=1707224997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cn6tr3K56Ei1Sf/jm4iMFciPE+uwKnz5rDJj/hsfnl0=;
        b=YJxlFS1DpccUaztSBTX0y3d7FnjWbJ+8BQyJ/7YGXcLIXyDnFLaza91pe9CFZOjuPY
         Jg/R/ZOcYGEUM9an1Df2XtJ/tCBe0I0H2HLCnQKvVO9Bm088JYZitsZI8p/eRMvpOy6M
         S/VUu1bhKzHz0FLcXVl9Q/clXhK5gND4saerGmX6pLNAjvxv2CVRsU9okfJX60hpfXmJ
         nRhERpA5YVBrxBlsB3iaY2DMWGzvWrwG3deobWzZb3VO5hQEtVvjxxgxEmok/eDc11Gd
         TviSZ6MHKnfG3GMxGFZ+Nn/dILm6bKA78yHmjzGnzFWaNBcvA4HuXFiVTQSLvUWUBonS
         eiFA==
X-Gm-Message-State: AOJu0YylZDfNqjw67BAqUEPNhA01+gy8Rrskxf5ppmA37AkAoxOP/E5B
	I32mqagmS+xbYmXQojwSjK/nICGbRMkowL1VrgKZs66Hb2BrOdx+2BsiQs7ZJ/lFK+0Toy9QGDI
	kgzRlYlScy3Pmn0wQy8VW1n77kHvROw9m4Wrx8g==
X-Google-Smtp-Source: AGHT+IFxUTfdcZIedBUdrEgcBFlf9mmA/qIvHlQUO1locput6LLOj0LxdZaYNFMa0fj8+nqHpKd9qjfkaiNU8is2C1w=
X-Received: by 2002:a81:e40a:0:b0:5ff:da8a:753b with SMTP id
 r10-20020a81e40a000000b005ffda8a753bmr530804ywl.50.1706620196847; Tue, 30 Jan
 2024 05:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125191756.868860-1-cristian.marussi@arm.com>
In-Reply-To: <20240125191756.868860-1-cristian.marussi@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Jan 2024 14:09:20 +0100
Message-ID: <CAPDyKFpqZf15DFWa8K6RRzSTX70chEVTV8zRgnJ3VStSq_d9UQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: arm: Fix NULL dereference on scmi_perf_domain removal
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 20:18, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On unloading of the scmi_perf_domain module got the below splat, when in
> the DT provided to the system under test the '#power-domain-cells' property
> was missing.
> Indeed, this particular setup causes the probe to bail out early without
> giving any error, so that, then, the removal code is run on unload, but
> without all the expected initialized structures in place.
>
> Add a check and bail out early on remove too.

Thanks for spotting this!

>
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> Mem abort info:
>    ESR = 0x0000000096000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x04: level 0 translation fault
>  Data abort info:
>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>  user pgtable: 4k pages, 48-bit VAs, pgdp=00000001076e5000
>  [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>  Modules linked in: scmi_perf_domain(-) scmi_module scmi_core
>  CPU: 0 PID: 231 Comm: rmmod Not tainted 6.7.0-00084-gb4b1f27d3b83-dirty #15
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>  pc : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
>  lr : scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
>  sp : ffff80008393bc10
>  x29: ffff80008393bc10 x28: ffff0000875a8000 x27: 0000000000000000
>  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>  x23: ffff00008030c090 x22: ffff00008032d490 x21: ffff80007b287050
>  x20: 0000000000000000 x19: ffff00008032d410 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>  x14: 8ba0696d05013a2f x13: 0000000000000000 x12: 0000000000000002
>  x11: 0101010101010101 x10: ffff00008510cff8 x9 : ffff800080a6797c
>  x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff6364626d
>  x5 : 8080808000000000 x4 : 0000000000000020 x3 : 00000000553a3dc1
>  x2 : ffff0000875a8000 x1 : ffff0000875a8000 x0 : ffff800082ffa048
>  Call trace:
>   scmi_perf_domain_remove+0x28/0x70 [scmi_perf_domain]
>   scmi_dev_remove+0x28/0x40 [scmi_core]
>   device_remove+0x54/0x90
>   device_release_driver_internal+0x1dc/0x240
>   driver_detach+0x58/0xa8
>   bus_remove_driver+0x78/0x108
>   driver_unregister+0x38/0x70
>   scmi_driver_unregister+0x28/0x180 [scmi_core]
>   scmi_perf_domain_driver_exit+0x18/0xb78 [scmi_perf_domain]
>   __arm64_sys_delete_module+0x1a8/0x2c0
>   invoke_syscall+0x50/0x128
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x34/0xb8
>   el0t_64_sync_handler+0x100/0x130
>   el0t_64_sync+0x190/0x198
>  Code: a90153f3 f9403c14 f9414800 955f8a05 (b9400a80)
>  ---[ end trace 0000000000000000 ]---
>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 2af23ceb8624 ("pmdomain: arm: Add the SCMI performance domain")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> I suppose the probe does NOT bail out with an error because this DT config has
> to be supported, right ?

Actually, no. It's a mistake by me, the probe should bail out with an
error code.

In fact, there is also one additional similar problem in probe, when
the number of perf-domains are zero. In that case, we should also
return an error code, rather than returning 0.

Would you mind updating the patch to cover both problems - or if you
are too busy, just let me know and I can help out.

> ---
>  drivers/pmdomain/arm/scmi_perf_domain.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
> index 709bbc448fad..d7ef46ccd9b8 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -159,6 +159,9 @@ static void scmi_perf_domain_remove(struct scmi_device *sdev)
>         struct genpd_onecell_data *scmi_pd_data = dev_get_drvdata(dev);
>         int i;
>
> +       if (!scmi_pd_data)
> +               return;
> +
>         of_genpd_del_provider(dev->of_node);
>
>         for (i = 0; i < scmi_pd_data->num_domains; i++)
> --
> 2.43.0
>

Kind regards
Uffe

