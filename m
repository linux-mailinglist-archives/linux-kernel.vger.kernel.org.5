Return-Path: <linux-kernel+bounces-58321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA484E4A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EA2B28D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9FB7D3E7;
	Thu,  8 Feb 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J+4E98wz"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309B7D40E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408243; cv=none; b=oxDb/xwfV8P33ozKp3YB1kFLl8/PXkPqsnAY0xalYerLb00r0mfkjcTl8k/DbqCYSzHnmhqRgQi3j5ybz9104SBX3mq/MPVIuY7pEAulEeWXHAZsUGqJGM7ZKYOP4l0J1yvjliCE+3evFTkgFgx7iqBQwFvEYhivBWnvZ6kvOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408243; c=relaxed/simple;
	bh=gvJpZS11BzZMp2hzfVGCMM9vzMDbNfee6LnMNKjcnMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbAi2R02tPT7n1AB7SboOPnqTc6sqnE3ddPU+K5azelFHf0+xSP9JuPhe5n4HUOreX9Ju3yVvxhpHuM/WU3YM3cZp2IAe31ROnaN3z9ikhJDVbuJTYpnx8Xxa2jh6Lnh6/TyJT7/XefgvPKpPPJHxjtLSoNeafHa0uLCHN768lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J+4E98wz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so16488a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707408238; x=1708013038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLQAwLL+ARXcz67zINSwsbUXytNa3thwUCJJRDPt8sE=;
        b=J+4E98wzYoMFDu7R7DBNlDBeXdG1MnzyOyTuyqfYW0xeAUG0V74eZ6HGRgc2g+HCtP
         t+e6Mj2xkMY6tCQCNL0uHiDgSnnE3n5pEiRFc1S3axwK3foKPE10Qaf3j5Cic/1HvXPB
         hgs3B1UX+SbOR48dbkabt/eq897bjzmOg1C7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707408238; x=1708013038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLQAwLL+ARXcz67zINSwsbUXytNa3thwUCJJRDPt8sE=;
        b=dCsguy8gZK+BeWQOdzZU/lI3jX3BsrIP5mxAhUsCYRipVnNU6Y6H1n0v8R6IP8+AdW
         4Rg6wseLh314XQKvHMsVh6g/jqibvlwUS+OJ4zuvRk6LlQiJpSvGzYRUz/F3tsCCcL+X
         twsL9ZxAHEMuo7s+z2qG5u1+RUxkcMHkg5Fjh/+Knxq++HNndvyCIJPp+o73Gl3gC3Xb
         lb1XAifuGvXCLRr9Q+REgWPDV0nf0MjriFnnBcXX12n+eGv7lanuTz31c8vCtU9nVJCh
         s+n4m3Amt1i5244jpJSS5Y1KAgd4pFLXgbf0aEprcWVu4MwfkPt2DMdgggG36hFQbBAF
         +QnA==
X-Forwarded-Encrypted: i=1; AJvYcCVAkI55LB+LWTpKkNxxaxzpe4W+wPPaKHFVZ2FF2J142+DheCaloR2JM6G+M35nYZG4ta/lV1zczCq4iy2BV6Iqb+UMzxmERHiK7BF6
X-Gm-Message-State: AOJu0YxeUEZDIYBDE5cmXk52ejCqGQvrD67PEksOrORqynaHdfiSExRX
	XOiA/tYPRiYuSRNF6/ZX/04rtt/dBpMtjP9gjPfs4TcnPpkJpGWcnTUfPl5DlIWQllk1guaGBoZ
	b5g==
X-Google-Smtp-Source: AGHT+IFxuj4q8gOM+7e3gZQFKQBBiwHpwRGs5D3s9Ro7U2X6ZhGKi2wBObKgRB0nvn+MiFVk1DlClw==
X-Received: by 2002:a17:906:3d21:b0:a38:a174:1316 with SMTP id l1-20020a1709063d2100b00a38a1741316mr2506763ejf.72.1707408238254;
        Thu, 08 Feb 2024 08:03:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVmFPx7lsgBMYZoAkC6qqAMw1sb1rLUiay1rzI58vM/lOpEsAHXPo+tUx9PlzwDRm1hLJVXoMiZG/ON0GF1kr5fxEaBeGceHnj3+jym
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id mm10-20020a170906cc4a00b00a389a8b187csm186190ejb.108.2024.02.08.08.03.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:03:57 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40f00adacfeso75115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:03:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3IDbfn8/6Bw4ZCef91HbpydcBCHdD1g7NiZSnBBHndaCWs9DXaU3lbf3qZ0tXBIzptS7vNwpGci4tLOtDu8x7Xb+ZFTZJdk22pV66
X-Received: by 2002:a05:600c:a385:b0:40f:dd8f:152c with SMTP id
 hn5-20020a05600ca38500b0040fdd8f152cmr425928wmb.4.1707408236833; Thu, 08 Feb
 2024 08:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208125426.70511-1-yaoma@linux.alibaba.com> <20240208125426.70511-2-yaoma@linux.alibaba.com>
In-Reply-To: <20240208125426.70511-2-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 8 Feb 2024 08:03:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W2g==7vQYP06_WfaVp_sPV16zX7_3V55J5AXCekT8taA@mail.gmail.com>
Message-ID: <CAD=FV=W2g==7vQYP06_WfaVp_sPV16zX7_3V55J5AXCekT8taA@mail.gmail.com>
Subject: Re: [PATCHv6 1/2] watchdog/softlockup: low-overhead detection of interrupt
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 8, 2024 at 4:54=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> w=
rote:
>
> The following softlockup is caused by interrupt storm, but it cannot be
> identified from the call tree. Because the call tree is just a snapshot
> and doesn't fully capture the behavior of the CPU during the soft lockup.
>   watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>   ...
>   Call trace:
>     __do_softirq+0xa0/0x37c
>     __irq_exit_rcu+0x108/0x140
>     irq_exit+0x14/0x20
>     __handle_domain_irq+0x84/0xe0
>     gic_handle_irq+0x80/0x108
>     el0_irq_naked+0x50/0x58
>
> Therefore=EF=BC=8CI think it is necessary to report CPU utilization durin=
g the
> softlockup_thresh period (report once every sample_period, for a total
> of 5 reportings), like this:
>   watchdog: BUG: soft lockup - CPU#28 stuck for 23s! [fio:83921]
>   CPU#28 Utilization every 4s during lockup:
>     #1: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #2: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #3: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #4: 0% system, 0% softirq, 100% hardirq, 0% idle
>     #5: 0% system, 0% softirq, 100% hardirq, 0% idle
>   ...
>
> This would be helpful in determining whether an interrupt storm has
> occurred or in identifying the cause of the softlockup. The criteria for
> determination are as follows:
>   a. If the hardirq utilization is high, then interrupt storm should be
>   considered and the root cause cannot be determined from the call tree.
>   b. If the softirq utilization is high, then we could analyze the call
>   tree but it may cannot reflect the root cause.
>   c. If the system utilization is high, then we could analyze the root
>   cause from the call tree.
>
> The mechanism requires a considerable amount of global storage space
> when configured for the maximum number of CPUs. Therefore, adding a
> SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob that defaults to "yes"
> if the max number of CPUs is <=3D 128.
>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>  kernel/watchdog.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug | 13 +++++++
>  2 files changed, 104 insertions(+)

Thanks, this looks great now!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

