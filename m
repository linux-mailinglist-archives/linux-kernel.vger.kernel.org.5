Return-Path: <linux-kernel+bounces-117834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA788B553
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157F1B637C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527B3FE5D;
	Mon, 25 Mar 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H86+MXoo"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96922224DB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395619; cv=none; b=Ex9y/ImMHGsy3Msr6WFAC9Z5PV3rChGuEOumMikauH56df2/oXgCB2MmmwwyNpGGq7uOVLVjIl8jcSmUvjsqtZwxmDpeQCSfJjpV0uXgHRmrZkihc/8qw/OE3lws5/wAu+wWSZLC17uLfsB7m+CfIKwF8LoUlnE5n5Gkizq5Sj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395619; c=relaxed/simple;
	bh=/ousucYE9TYn5+7Q7Dy7A/rriEu2QFFESEGREjhOq50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGox2oqFezI+m7EsWP1fOfFFgtY5xS1+0CKMUdiUMOyUowFZAFZvwazCdSiw9ZD494+7c9mn0J/dMFfdLzOkRcgMStFrOFF2Dcj1YU5sUPxE0sS4zoyieGdKs6sXoGuFsnLdQlNxy+OOZrYu/K1IcKmrbqoiLqFgINN2GbdupTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H86+MXoo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c3d404225dso452682b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711395615; x=1712000415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlRxmt+WFCSFHFLoUgXhs0MEn4btGaAaA6pMBaTLtKY=;
        b=H86+MXooHkFdNpftLxYLTuRgrW8ZO8kca3q7srV2EpFFXNhYw7JeuI7D+C4mwHCxxz
         uJ0B6LsZydWOQkHyF4XnoJT5vuym7KKe+9CpO6lWPyMflEyd7DsHKckjDMoAr+Gjo7b6
         OcWxmKZtW4PYCwFq6kpiH9MSAb1xyWjfxOwM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395615; x=1712000415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlRxmt+WFCSFHFLoUgXhs0MEn4btGaAaA6pMBaTLtKY=;
        b=lR4SrJdoSXH+uK98Clf0zdHOLLBEOpAUAU/KP3shBe0+K9PlDFS1oZ70EPsZwTK25P
         KcmYZG7T8uORhQtTpUAJtjEPcpfoPaYvGA9Y9/siipasApMePJjiNaSIi37KS/Qdxssx
         6keN/LyXp78Ic3k1AY/wct1RIKqDWTo5gsSyFEXtjrZvCx7mv7rmT7HSwXzb8V2uiR1w
         3FfcI9X1LFZ9dd0PxiiDjRFk1rWHrWqxDmQogFcLXpSBuW1pkyIrfEfUDy8WR4PliIGU
         obQFra3tD5JEg3mI7izgYvydT3Ar5Va2SF3MFTn2Fo1B0eTW4CY52nrBdcw2ck8torjz
         l7GA==
X-Forwarded-Encrypted: i=1; AJvYcCU8P/F0j8zeaHCUAgiWQxZX1ATb/RyDN7fmxL+HU1lPH8cGzbmXPMYYi5YlafgU7xpV6KK+9WlF+SL6vHX1vKTXDmyN2jqgkOtpsbmS
X-Gm-Message-State: AOJu0YxO4dgNcMDMAoZWESe2ZpTVW3GWdjJ8XOLCHe+fAFro4G6WEIHS
	+Jf2G11WRkUEWq4MDjt4qSmokaDC4MFHCHLfONB9Too1DwT4m51jzuIVt1CtE/Ataph6K7nPM8A
	=
X-Google-Smtp-Source: AGHT+IFvRhPWr9Je1gVcrMD21meK0CU77d73hkDj8r1NbWbB3KIyPmFypDji+Fh1NU8DgemloieOmA==
X-Received: by 2002:a05:6808:3c98:b0:3c3:9949:b457 with SMTP id gs24-20020a0568083c9800b003c39949b457mr12041268oib.22.1711395614945;
        Mon, 25 Mar 2024 12:40:14 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id ck4-20020a05622a230400b00430dcca3fb5sm2897835qtb.16.2024.03.25.12.40.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 12:40:13 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-428405a0205so62231cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:40:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgbePudyWAqMFLA7liq/cBEDid5FkJIJfWGgyqofdNOe6iWJF/Cei2xqwNv5yp0Yn6HmgvGinBe6/U0h/PXZUKcWxzK+e6Ibzt3o2I
X-Received: by 2002:a05:622a:38d:b0:430:d653:9def with SMTP id
 j13-20020a05622a038d00b00430d6539defmr1213790qtx.5.1711395613116; Mon, 25 Mar
 2024 12:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325184204.745706-1-sboyd@kernel.org> <20240325184204.745706-5-sboyd@kernel.org>
In-Reply-To: <20240325184204.745706-5-sboyd@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 25 Mar 2024 12:39:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WBg4cu0rw-yt6-sDaQfeCBNtwqiGKTroB2giM0prHPUQ@mail.gmail.com>
Message-ID: <CAD=FV=WBg4cu0rw-yt6-sDaQfeCBNtwqiGKTroB2giM0prHPUQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] clk: Get runtime PM before walking tree during disable_unused
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 11:42=E2=80=AFAM Stephen Boyd <sboyd@kernel.org> wr=
ote:
>
> Doug reported [1] the following hung task:
>
>  INFO: task swapper/0:1 blocked for more than 122 seconds.
>        Not tainted 5.15.149-21875-gf795ebc40eb8 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>  task:swapper/0       state:D stack:    0 pid:    1 ppid:     0 flags:0x0=
0000008
>  Call trace:
>   __switch_to+0xf4/0x1f4
>   __schedule+0x418/0xb80
>   schedule+0x5c/0x10c
>   rpm_resume+0xe0/0x52c
>   rpm_resume+0x178/0x52c
>   __pm_runtime_resume+0x58/0x98
>   clk_pm_runtime_get+0x30/0xb0
>   clk_disable_unused_subtree+0x58/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused_subtree+0x38/0x208
>   clk_disable_unused+0x4c/0xe4
>   do_one_initcall+0xcc/0x2d8
>   do_initcall_level+0xa4/0x148
>   do_initcalls+0x5c/0x9c
>   do_basic_setup+0x24/0x30
>   kernel_init_freeable+0xec/0x164
>   kernel_init+0x28/0x120
>   ret_from_fork+0x10/0x20
>  INFO: task kworker/u16:0:9 blocked for more than 122 seconds.
>        Not tainted 5.15.149-21875-gf795ebc40eb8 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>  task:kworker/u16:0   state:D stack:    0 pid:    9 ppid:     2 flags:0x0=
0000008
>  Workqueue: events_unbound deferred_probe_work_func
>  Call trace:
>   __switch_to+0xf4/0x1f4
>   __schedule+0x418/0xb80
>   schedule+0x5c/0x10c
>   schedule_preempt_disabled+0x2c/0x48
>   __mutex_lock+0x238/0x488
>   __mutex_lock_slowpath+0x1c/0x28
>   mutex_lock+0x50/0x74
>   clk_prepare_lock+0x7c/0x9c
>   clk_core_prepare_lock+0x20/0x44
>   clk_prepare+0x24/0x30
>   clk_bulk_prepare+0x40/0xb0
>   mdss_runtime_resume+0x54/0x1c8
>   pm_generic_runtime_resume+0x30/0x44
>   __genpd_runtime_resume+0x68/0x7c
>   genpd_runtime_resume+0x108/0x1f4
>   __rpm_callback+0x84/0x144
>   rpm_callback+0x30/0x88
>   rpm_resume+0x1f4/0x52c
>   rpm_resume+0x178/0x52c
>   __pm_runtime_resume+0x58/0x98
>   __device_attach+0xe0/0x170
>   device_initial_probe+0x1c/0x28
>   bus_probe_device+0x3c/0x9c
>   device_add+0x644/0x814
>   mipi_dsi_device_register_full+0xe4/0x170
>   devm_mipi_dsi_device_register_full+0x28/0x70
>   ti_sn_bridge_probe+0x1dc/0x2c0
>   auxiliary_bus_probe+0x4c/0x94
>   really_probe+0xcc/0x2c8
>   __driver_probe_device+0xa8/0x130
>   driver_probe_device+0x48/0x110
>   __device_attach_driver+0xa4/0xcc
>   bus_for_each_drv+0x8c/0xd8
>   __device_attach+0xf8/0x170
>   device_initial_probe+0x1c/0x28
>   bus_probe_device+0x3c/0x9c
>   deferred_probe_work_func+0x9c/0xd8
>   process_one_work+0x148/0x518
>   worker_thread+0x138/0x350
>   kthread+0x138/0x1e0
>   ret_from_fork+0x10/0x20
>
> The first thread is walking the clk tree and calling
> clk_pm_runtime_get() to power on devices required to read the clk
> hardware via struct clk_ops::is_enabled(). This thread holds the clk
> prepare_lock, and is trying to runtime PM resume a device, when it finds
> that the device is in the process of resuming so the thread schedule()s
> away waiting for the device to finish resuming before continuing. The
> second thread is runtime PM resuming the same device, but the runtime
> resume callback is calling clk_prepare(), trying to grab the
> prepare_lock waiting on the first thread.
>
> This is a classic ABBA deadlock. To properly fix the deadlock, we must
> never runtime PM resume or suspend a device with the clk prepare_lock
> held. Actually doing that is near impossible today because the global
> prepare_lock would have to be dropped in the middle of the tree, the
> device runtime PM resumed/suspended, and then the prepare_lock grabbed
> again to ensure consistency of the clk tree topology. If anything
> changes with the clk tree in the meantime, we've lost and will need to
> start the operation all over again.
>
> Luckily, most of the time we're simply incrementing or decrementing the
> runtime PM count on an active device, so we don't have the chance to
> schedule away with the prepare_lock held. Let's fix this immediate
> problem that can be triggered more easily by simply booting on Qualcomm
> sc7180.
>
> Introduce a list of clk_core structures that have been registered, or
> are in the process of being registered, that require runtime PM to
> operate. Iterate this list and call clk_pm_runtime_get() on each of them
> without holding the prepare_lock during clk_disable_unused(). This way
> we can be certain that the runtime PM state of the devices will be
> active and resumed so we can't schedule away while walking the clk tree
> with the prepare_lock held. Similarly, call clk_pm_runtime_put() without
> the prepare_lock held to properly drop the runtime PM reference. We
> remove the calls to clk_pm_runtime_{get,put}() in this path because
> they're superfluous now that we know the devices are runtime resumed.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Closes: https://lore.kernel.org/all/20220922084322.RFC.2.I375b6b9e0a0a534=
8962f004beb3dafee6a12dfbb@changeid/ [1]
> Closes: https://issuetracker.google.com/328070191
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 9a34b45397e5 ("clk: Add support for runtime PM")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk.c | 117 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 105 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

