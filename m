Return-Path: <linux-kernel+bounces-117848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8888B066
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36881C3B996
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2E21CA9C;
	Mon, 25 Mar 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mguR9Rwi"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B23FE5D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396028; cv=none; b=MECP/zC3hqzDPGz/+t1Zm/BBA1+T1XQnVYIQ9Oa5FGAVeBPlDMipua3QKcz6ujSpaQfXjWc2CmDnODwRoY2A5tuSL68KA6Z4pT1MuEwXRp9yjMDyiyL0mO33gSV/0xAgc7kqFQQyj/izQMX5kM6qbmQ6eBaOeMG34KsVXRaPfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396028; c=relaxed/simple;
	bh=kgRtfk0vuvluQBowgTHKKn5pVK9giM5jzH4FTzts2hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMO9mAg8sOnjjHJAZObznVKULerevts7IGQ9xLaG1EJEHflQ8cbEgTHndVABjklnIe68bC3+rTnvp7mrabvPDdDwPUuMS2AbwBWw2x50zR3nxcHb39lUesCHD3IcmyCiHKjHVHSz72QqH0AwUmSIr4HkEGOhfuTqeqZIkOoEcmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mguR9Rwi; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-476665f067fso1845917137.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396025; x=1712000825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LalIJ7OKE58mjJv0TRf9HxJG41ZS+Mo8eCL99ZHe6Vg=;
        b=mguR9Rwi2JedHEVB93eKiT34epYbRySNxC0x7jWTkUbVWXKnlYWA/eNpjW9AXy6iNM
         yzEw+pDHNVEl32F8uYByHBaY8G2NDgDI/Ib3nYyWEIKFcSEThYJDFMFhlDN7S/u+/zjj
         SP7fCMmAEJE4z6oIWi3Lu9jT0NUPO+XNolAl5iSTJHfG9o8Puq4/k8E8hyGt99Kq15Vx
         9vEWtvcEjP6oOV4WKuD1AX2WaEKEQeXB9diYRDnhOthPSFaw/4a/TysEvG5nigPeYyv4
         vCs4sdgn6t3hJ9cmM0rxIKjZoR0OyCTGZHMnazTwkRG3Nnno4VRizsVwymOURgiqLcuW
         zDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396025; x=1712000825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LalIJ7OKE58mjJv0TRf9HxJG41ZS+Mo8eCL99ZHe6Vg=;
        b=o/uJViCFL1ip6u1rm9Fl+HeCYPB7pd4ETVyR9j8pxs49mT2+CfoTBda6kmO7EFR5l7
         39HThGwrzFQCULZ+I0oNbBFEGcN9UP01I+cvwsyfGwKp1ClQdO6XDjxcqaKIZzQB1O6x
         weHio0eJ3p5oAEZCA+IeGVahcjbwLdtJb3XvKgLjyFfp2/8I5ZzIjmZTq1IJx4HBPEXD
         AxheiKo1DE6YZMBy7aPSazoJQlYj3SHHV+FLT902iy7Dzf8cfb17dU6C9/mnq8hxbjqQ
         89OlYCQ7vSPt6CzVkqK0G2asiV3UV453imIhgEkCiofiE0JEPJkoBor+oDxg4WFGje3A
         bbmA==
X-Forwarded-Encrypted: i=1; AJvYcCVDUqQGm6Kd9p4ACK93wOaBNMnCv/nz0ociRq0XYlrOXzZCMDdajb31e28EL+pm1zhFHt8Mj5CQ6vVzthkU9oRVaVvJDKuFgUOw6owi
X-Gm-Message-State: AOJu0YyObvz8iqfmLEnm3c8h85E1rCVpWUasSAT27Hv6H8DKAhdbPy11
	/XYt6ynmRh6kRnXzImmO+Nmyo+s5NyJdkCxLdwtIfDmaPzBGuwWeZaLIaobv0K4wJv2VuxS3f4n
	dAy7WefTwGXuj0mCJkEZHOY+HNTY=
X-Google-Smtp-Source: AGHT+IHhbIIu/fyNMVHDJFg78q/wN7nE9/cV7wPs95YL9HvEPmd5IBhf1clIBt0MfJeTrflF7mhoD0PfvtERx33aD1Y=
X-Received: by 2002:a05:6102:c2:b0:475:111d:c0dc with SMTP id
 u2-20020a05610200c200b00475111dc0dcmr5652235vsp.14.1711396025129; Mon, 25 Mar
 2024 12:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325180201.6027-1-apais@linux.microsoft.com> <ZgHTvwIerkcRem2s@slm.duckdns.org>
In-Reply-To: <ZgHTvwIerkcRem2s@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 25 Mar 2024 12:46:53 -0700
Message-ID: <CAOMdWSLD8McswfEmn_B74F9EejTW8Zi_XAmakA_=19GDgnMRRg@mail.gmail.com>
Subject: Re: [PATCH v2] kernel: Introduce enable_and_queue_work() convenience function
To: Tejun Heo <tj@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, jiangshanlai@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The function comment felt a bit too verbose. I applied the following
> compacted version to wq/for-6.10 which hopefully still contains all the
> necessary information. Please let me know if you disagree.
>

 Looks fine to me. Thanks for fixing it.

- Allen

> Thanks.
>
> --- 8< ----
> From 474a549ff4c989427a14fdab851e562c8a63fe24 Mon Sep 17 00:00:00 2001
> From: Allen Pais <apais@linux.microsoft.com>
> Date: Mon, 25 Mar 2024 18:02:01 +0000
> Subject: [PATCH] workqueue: Introduce enable_and_queue_work() convenience
>  function
>
> The enable_and_queue_work() function is introduced to streamline
> the process of enabling and queuing a work item on a specific
> workqueue. This function combines the functionalities of
> enable_work() and queue_work() in a single call, providing a
> concise and convenient API for enabling and queuing work items.
>
> The function accepts a target workqueue and a work item as parameters.
> It first attempts to enable the work item using enable_work(). A successful
> enable operation means that the work item was previously disabled
> and is now marked as eligible for execution. If the enable operation
> is successful, the work item is then queued on the specified workqueue
> using queue_work(). The function returns true if the work item was
> successfully enabled and queued, and false otherwise.
>
> Note: This function may lead to unnecessary spurious wake-ups in cases
> where the work item is expected to be dormant but enable/disable are called
> frequently. Spurious wake-ups refer to the condition where worker threads
> are woken up without actual work to be done. Callers should be aware of
> this behavior and may need to employ additional synchronization mechanisms
> to avoid these overheads if such wake-ups are not desired.
>
> This addition aims to enhance code readability and maintainability by
> providing a unified interface for the common use case of enabling and
> queuing work items on a workqueue.
>
> tj: Made the function comment more compact.
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  include/linux/workqueue.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index bfcf8d38f4b1..2df1188c0f96 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -682,6 +682,32 @@ static inline bool schedule_work(struct work_struct *work)
>         return queue_work(system_wq, work);
>  }
>
> +/**
> + * enable_and_queue_work - Enable and queue a work item on a specific workqueue
> + * @wq: The target workqueue
> + * @work: The work item to be enabled and queued
> + *
> + * This function combines the operations of enable_work() and queue_work(),
> + * providing a convenient way to enable and queue a work item in a single call.
> + * It invokes enable_work() on @work and then queues it if the disable depth
> + * reached 0. Returns %true if the disable depth reached 0 and @work is queued,
> + * and %false otherwise.
> + *
> + * Note that @work is always queued when disable depth reaches zero. If the
> + * desired behavior is queueing only if certain events took place while @work is
> + * disabled, the user should implement the necessary state tracking and perform
> + * explicit conditional queueing after enable_work().
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
>   * Detect attempt to flush system-wide workqueues at compile time when possible.
>   * Warn attempt to flush system-wide workqueues at runtime.
> --
> 2.44.0
>
>


-- 
       - Allen

