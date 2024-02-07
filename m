Return-Path: <linux-kernel+bounces-56814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F384CF93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C41C26D7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4F41C7C;
	Wed,  7 Feb 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gX1WMWHd"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2F81ADB
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326094; cv=none; b=T4pMq/1tTponySznvwtCsz+JHkJ9dxh8ixgj66q4FJgZQkn7edK3khNbdKYKWlSMP/lig8MiUS3kI/ds/8pxSR6CTa/boAqHVP3UrIEMqU9ffZbVriDWDfbZfNIq2Y5HXon2w6fuHblGD1JxE1oCaU7umWP0JKDpJVWfSvOyoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326094; c=relaxed/simple;
	bh=zwJ6TJj6CfrRjQE7WGfmf4VK3JyEog88O6/N+PwUDTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvVEflRImW/cL164ebcpJiLBR2CUGiw7355ly0ohOcfTdrlCnAW4//HrBBpEt8hNXnsdmCHQF5sLLkJPdgGT71mvv26Kg7UOJgW2ehMCtY+8kB7eG2ZyZwxdEJn1KVNpmCo1KkBY9ylULh7xeRh5nDzYXpYY/GAQLka9TtuMWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gX1WMWHd; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51168addef1so964147e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707326090; x=1707930890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/T7P/9BvRPxNVMg79qrWBeuIpEZsxp2qJ3Tjj1c2bQ=;
        b=gX1WMWHdaOF4WSLUqYybt8TfeZfdz5vMALwaGD81csMs6D6kAzkORTWst86yQigXok
         AhybRNU3ZgHazXhftYUSRbQUSaBtlBfujPDMt75PJrmyJjsf8UAPs7vqCGUwT66Z3itq
         2qMoGJqCyDxEtY656dLoAG5JiOwH5Pny/CvF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326090; x=1707930890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/T7P/9BvRPxNVMg79qrWBeuIpEZsxp2qJ3Tjj1c2bQ=;
        b=QgG3SWp7k5yFe6KHstjiJHgn5hGvGWm2gSD3O9elmxkEscUtWkD4Wmvr2kUEPWXs/w
         qTgdTyiXtZp2zFmM3o5iyxO7uxG1JP6mpYw6c6kAxxLd2aWx/1nMHI9IOPq8Smqdig2u
         gMr+/B/2BSqwl+O3dQx4jVF1IgbI+7PZ1fBHfyxv+OI8WfAGi4Esn/alo0Y/su4/WmA3
         XY3WGVILy6HXPR0hlwarriTS6oYgEJWpupt8kw2fDu2C+ZjN3zCojNdA6/vGR7koVQU/
         zOSYrz2aw/HiAxvisRZkkSXoZZssGUomccF7v2OMb8U3Dj6YkU5dSPzmiOqzT4eKgkO+
         jgHw==
X-Forwarded-Encrypted: i=1; AJvYcCU3sOtMIbw2vz7aOAZyBfSOfCqNDcW7Y9YcUi4VFguWpkkZ1NSsdmdj/QOOoXU0HsvIXw/CL8Tdwl/5B0xJyl0U92DIEWEDi3HP5hx+
X-Gm-Message-State: AOJu0YwTWtdCP0pMEvhCYFTHCjbKnV358vkHgFlm0vGx3B800HKhzsOV
	3UVrcnNY0oDFnvKJwCRGF4nszLvnRRcFlPH8AVqdKtOHK8oCD/MoMGzJvx73XspD652p754hNDk
	6Rw==
X-Google-Smtp-Source: AGHT+IGLzQ4aZ2Q3MpqvF7+VzFuTfVqDM82gDiHhXfL4rLf1Lf53d1cM4HnlPJo95K3afOIgqX0qgA==
X-Received: by 2002:a05:6512:74f:b0:511:5494:dd53 with SMTP id c15-20020a056512074f00b005115494dd53mr4068503lfs.19.1707326089946;
        Wed, 07 Feb 2024 09:14:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVm7zOX/vX2csRRdaZZJMQgQEXAGwE/93zimpbTzoZiMNEjBDw1+SN5l5HHDfTfXCWxRfmXhYhF6HF4G0UzD+PEL8CxFMergidaf8oy
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id ga25-20020a170906b85900b00a389490cb05sm409758ejb.29.2024.02.07.09.14.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 09:14:49 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ef9382752so60735e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:14:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3XWEtLYXu/CzZHxkWba7Vk8G96E7xxR5/HNWFSUkzh0sRW+bur59YHyis3Di9gWmVMxVXmm1G7qgDekD5KRaoi4T828L0ETEJgfvg
X-Received: by 2002:a05:600c:1f0c:b0:40f:cbc3:d862 with SMTP id
 bd12-20020a05600c1f0c00b0040fcbc3d862mr177485wmb.6.1707326088861; Wed, 07 Feb
 2024 09:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206095902.56406-1-yaoma@linux.alibaba.com>
 <20240206095902.56406-3-yaoma@linux.alibaba.com> <CAD=FV=V8VcmEDDpaWZi40j5dkP+HyBPFr=D_mKFG-YmXTpa_AA@mail.gmail.com>
 <8cf08d4a-fa4b-41cb-8bfa-75387122b194@linux.alibaba.com>
In-Reply-To: <8cf08d4a-fa4b-41cb-8bfa-75387122b194@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Feb 2024 09:14:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XVxaBGWa8apqyhd2KAPFtF7asmPuXvHhv++oj+oKLNsQ@mail.gmail.com>
Message-ID: <CAD=FV=XVxaBGWa8apqyhd2KAPFtF7asmPuXvHhv++oj+oKLNsQ@mail.gmail.com>
Subject: Re: [PATCHv5 2/3] watchdog/softlockup: report the most frequent interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 6, 2024 at 10:19=E2=80=AFPM Bitao Hu <yaoma@linux.alibaba.com> =
wrote:
>
> Hi,
>
> >> +static void start_counting_irqs(void)
> >> +{
> >> +       int i;
> >> +       struct irq_desc *desc;
> >> +       u32 *counts =3D __this_cpu_read(hardirq_counts);
> >> +       int cpu =3D smp_processor_id();
> >> +
> >> +       if (!test_bit(cpu, softlockup_hardirq_cpus)) {
> >
> > I don't think you need "softlockup_hardirq_cpus", do you? Just read
> > "actual_nr_irqs" and see if it's non-zero? ...or read "hardirq_counts"
> > and see if it's non-NULL?
> Sure, the existing variables are sufficient for making a determination.
> And may be I should swap it to make the decision logic here clearer,
> like this (untested)?
>
> bool is_counting_started(void)
> {
>      return !!__this_cpu_read(hardirq_counts);
> }
>
> if (!is_counting_started()) {

If you insist I guess I wouldn't object, but I don't feel it's
necessary. The whole point is just to know if you've already allocated
memory, right? ...and just checking to see if the pointer is non-NULL
or the array-size is non-zero feels pretty clear to me.


> >> +                       /*
> >> +                        * We need to bounds-check in case someone on =
a different CPU
> >> +                        * expanded nr_irqs.
> >> +                        */
> >> +                       if (i < __this_cpu_read(actual_nr_irqs))
> >> +                               counts_diff =3D desc->kstat_irqs ?
> >> +                                       *this_cpu_ptr(desc->kstat_irqs=
) - counts[i] : 0;
> >> +                       else
> >> +                               counts_diff =3D desc->kstat_irqs ?
> >> +                                       *this_cpu_ptr(desc->kstat_irqs=
) : 0;
> >
> > Why do you need to test "kstat_irqs" for 0?
> Although "alloc_desc" wil allocate both "desc" and "kstat_irqs" at the
> same time, I refer to the usage of "kstat_irqs" in "show_interrupts"
> from kernel/irq/proc.c, where it does perform a check.

Ah, I see. I hadn't noticed that you were testing the pointer before
dereferencing it. OK, seems fine to keep this check. I guess that
would make it this (untested):

if (desc->kstat_irqs) {
  counts_diff =3D *this_cpu_ptr(desc->kstat_irqs);
  if (i < __this_cpu_read(actual_nr_irqs))
    counts_diff -=3D counts[i];
} else {
  counts_diff =3D 0;
}

