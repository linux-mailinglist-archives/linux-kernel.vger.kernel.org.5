Return-Path: <linux-kernel+bounces-86047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDEB86BEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66513286E77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184041F951;
	Thu, 29 Feb 2024 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmTGH2Gz"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD01C3E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709173849; cv=none; b=RO4zmVNAIwF/VTWb2ihecZtaHUzuxawIy9yWN+KSTkM9nRJjcfJKhF7xojKk9V62WsN1kGWJ8kjl/yIObPtc6f3wDfkHaxboxiwsR27dxcxVQV1O33xJLnPocewU351qmWcQtczlsFDwV4hLtPoH0lNljMO/mbutGbp0EvK2dc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709173849; c=relaxed/simple;
	bh=kx19W7WYiB0M4dXO/WPetOI6MpiwBPuHLGXz5lPJlZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2c+L04uHUe1lgflu7nltCcIKrwHsBuVyiWRAi8XzV3CjGIKu26YjjgxFoaABQDF3aI1eFkbhlz8vMddl22/s8tS5nwqBhsVkb46XEcVjvj0FLy1xan6mbxxHwAQX9jggyYEcBONmsQjrhh4l7HPKhTrM1bx9dCi/mwl6g1L+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmTGH2Gz; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso361887a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709173847; x=1709778647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtR69MQc+qAus9idxyLy1ivq+dN+v+3IcElf7vJo7GI=;
        b=SmTGH2Gz/bMjVlPqyXE/aC+ZBaMbjecrgYV87EkqwjtyfV9LmeVBeweZiolx2Guuw4
         QzX0+ErN8zRhQShBsZdn0wXhjNUsyOIax28SuggWGgoLZgNts9CFLLnYymgTCUoK+l9L
         tjzJZ9GBn5g7rEZzI9Xq5wHaOhYbFJpzxLMPSsbuMHHJWEimj2uM7lyrPZ11nqGZLNGm
         8ggT0FIw+yovogZXPaGMeCDom6AnksWO7dxUEgTv7ST+BbuhKOth2xPs5jb+GGT7n1SL
         Tug/kpaSSuRrRrHsu6NnA3F68YaiHuvYLN3VgU5118itjpIYWmn+QofpmV38XfgZB5MD
         7XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709173847; x=1709778647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtR69MQc+qAus9idxyLy1ivq+dN+v+3IcElf7vJo7GI=;
        b=gSR6i6pSCM+zLGQi+s1QhPjpptudMD8yp58SnXfaxXrYNb+rSkRkeVuWp5MNBSQ5ZA
         Gn1Vs/3oBHUVJ/zDJaNKF3sObNKYTBYIXtY+hdssX9Vyz4YKU9NX6gVl+KDod1YleUQv
         f0CAhFBcYNiSAkQskGsA1YgQpsHfl3ooanWKlhoWyPkmhIvpNRSH+u0D6QsE9LSvuLfs
         5Tr4hexQ5TU1tB5g9WDNArD7jjM7j3g0oUFfy3CRcy2fq/yQiwN6h/zAfkI5MtJasFNu
         XRhI6eaHLB9gFaPAmUgt4MVV1eDJQkceTk1VFp5PJvt/zV2uuVCXYh0RXQRAstK7dSCO
         Ly2A==
X-Forwarded-Encrypted: i=1; AJvYcCVJYKnJZG3wti9tzanfEDEpqugkx1A5VX9iHG8lvkkzqVOOxiLACF+a2apJdPkEd/1VU2iM50jYZ2rhLzSTJiIJdgiYISx1uc8KH2nB
X-Gm-Message-State: AOJu0Yw7gfJf+GdFQjVdp4cOIeIAmWG6f5/9MDrGw796Uz5w/SNHzhHT
	O0hzJoCUkFWnntsDNQBEnocsta68OD7Xqs/XtEqXD+RA4KuDb7ZdMyFLJLd53Uf/aNpYvFkgfRb
	wvmACvPHjIOOih1mKUOYATNLyCT9m4UtIctE=
X-Google-Smtp-Source: AGHT+IGxC3FsiIV6CzD+vmnDpiyq1LDff5BD9qod+OZvvI8GMaiH8PHz3v4ZdAew1lfCCTv+50XtgCT9qly/88gI5aM=
X-Received: by 2002:a17:90a:f3c9:b0:299:489f:fd2d with SMTP id
 ha9-20020a17090af3c900b00299489ffd2dmr926488pjb.20.1709173847179; Wed, 28 Feb
 2024 18:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228181850.5895-1-apais@linux.microsoft.com>
In-Reply-To: <20240228181850.5895-1-apais@linux.microsoft.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 29 Feb 2024 10:30:35 +0800
Message-ID: <CAJhGHyD8cruwAkr+hqysv7fTQX1ovpn2cu_wU2C4TXrE5Qy8zg@mail.gmail.com>
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience function
To: Allen Pais <apais@linux.microsoft.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:18=E2=80=AFAM Allen Pais <apais@linux.microsoft.c=
om> wrote:
>
> The enable_and_queue_work() function is introduced to streamline
> the process of enabling and queuing a work item on a specific
> workqueue. This function combines the functionalities of
> enable_work() and queue_work() in a single call, providing a
> concise and convenient API for enabling and queuing work items.
>
> The function accepts a target workqueue and a work item as parameters.
> It first attempts to enable the work item using enable_work(). If the
> enable operation is successful, the work item is then queued on the
> specified workqueue using queue_work(). The function returns true if
> the work item was successfully enabled and queued, and false otherwise.
>
> This addition aims to enhance code readability and maintainability by
> providing a unified interface for the common use case of enabling and
> queuing work items on a workqueue.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  include/linux/workqueue.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index aedfb81f9c49..31bbd38ef8c8 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -678,6 +678,29 @@ static inline bool schedule_work(struct work_struct =
*work)
>         return queue_work(system_wq, work);
>  }
>
> +/**
> + * enable_and_queue_work - Enable and queue a work item on a specific wo=
rkqueue
> + * @wq: The target workqueue
> + * @work: The work item to be enabled and queued
> + *
> + * This function attempts to enable the specified work item using enable=
_work().
> + * If the enable operation is successful, the work item is then queued o=
n the

Could you please specify what "successful" means and also please
document it that it might cause unnecessary spurious wake-ups and
the caller should prepare for it if it is not desired.

Thanks
Lai

PS:

I'm afraid it can cause unnecessary spurious wake-ups in cases
where the work item is expected to be dormant ordinarily but disable/enable=
()
are called often for maintenance.  However, the user can resort to other
synchronization in this case rather than just disable/enable() only to avoi=
d the
wake-ups overheads.



> + * provided workqueue using queue_work(). It returns %true if the work i=
tem was
> + * successfully enabled and queued, and %false otherwise.
> + *
> + * This function combines the operations of enable_work() and queue_work=
(),
> + * providing a convenient way to enable and queue a work item in a singl=
e call.
> + */
> +static inline bool enable_and_queue_work(struct workqueue_struct *wq,
> +                                        struct work_struct *work)
> +{
> +       if (enable_work(work)) {
> +               queue_work(wq, work);
> +               return true;
> +       }
> +       return false;
> +}
> +
>  /*
>   * Detect attempt to flush system-wide workqueues at compile time when p=
ossible.
>   * Warn attempt to flush system-wide workqueues at runtime.
> --
> 2.17.1
>

