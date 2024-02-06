Return-Path: <linux-kernel+bounces-55643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDED884BF62
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B702B242A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5E1BF44;
	Tue,  6 Feb 2024 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aAPIwpl1"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EA1B95A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255744; cv=none; b=Ea3FhkTSFFrgMJmLFPwHU9blVwy9OZauanEJ1oHseF+O/xNqgncjHDjRbK1VLp9vHfwANDm9EMrZt//OjcH0XBi/A+pHYysWgFaXJ3lUnk+IJL8BwUqdKj725HnYFxkH4O9UA2fx3o+83kuD4WT4cMU8OYsaounuKGHQcBDYVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255744; c=relaxed/simple;
	bh=vk9PLs48agCG49NUIWScKhwWSlcW3F9MXCvJkj8343Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6YjDWxB/LIm8AacL1Ari2GG7FWJYHeoH5AoJxIjwZQL9ON3GPZF9fTibCJQmpgPgK3E0AbncjIAaAugtwHUud2mdOdWj/MbnX7rY4rgYU8Ik0XkF6vfo8FiKGYp1ATn1NzDnahlKMOZ3yWPR4l5+OzEyWrI1UHYJCqjGAqUYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aAPIwpl1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7451187a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707255740; x=1707860540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hug5p+0LmgccPUIHshHRftAZbcHvTUsKD1fGu5pg30=;
        b=aAPIwpl1qyqMSMqt/brVn7OCcsQdM7/18p08uR7Wo4U0apU54kNzQjtmWQrgkPjGtS
         +jReygpGoyIEd0hoQlJr2TGDNHxSFGnzUTMHwULXvQeezwb/OUFLyt8FiA3D52yPg7Fx
         pNnO6ZQ+n8+O7zOPskU8J4Lb5rqiqyblAo7qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255740; x=1707860540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hug5p+0LmgccPUIHshHRftAZbcHvTUsKD1fGu5pg30=;
        b=Bga3tDFi4bYsgFcPA4LouRvZ9bABM1Dk2AmiEf6H/cWyOIyyoCZqT5BxVnK18BPhcs
         cqKi+EicLn39x8kLIj9mKFkM8xoIkFk1m0jLL5qE0lyXGPX/iVwB51AZ4Xt0I2gY0Aru
         Id5B8AlwvaLKMVZiM9foZWTMfl/CDwa6v2l9xjnW3jTWlQ6msgXmgbofAwcfEVUUsgbf
         N1ocxvLJgUyjuOxQB8JufYiTdfGHyH07vyiL1aMO+bcvd8YNIr9hrJkYZxsjuDp0daC8
         pN2qVSToGFu4NhXc5q79G3ZxJ6lTDT81peQFhzTQ3GV40HwYrEBMlHFOCjr2YI/1M6BM
         QyaQ==
X-Gm-Message-State: AOJu0Yxm40ciTG0F/oYcZqYh24EPGxzxhw2VVQY1b9uQZ3b01ZDkQ+C9
	CeUMXTcvD3lFbGIg2/SYa6MXMNNGCCPt6JIqZJzxkVWFGl6E0X2dDe/UAPY+z45OPiq3AxkABig
	4WQ==
X-Google-Smtp-Source: AGHT+IF2yH5Gt2kHFEV+IfYA6qdo6jxgYsoFJhx00g/YwvFIrC0KnEQcYpYnTe9pFXE6lHuU1YrHRw==
X-Received: by 2002:a17:907:785a:b0:a37:ee9c:273e with SMTP id lb26-20020a170907785a00b00a37ee9c273emr2398819ejc.53.1707255740043;
        Tue, 06 Feb 2024 13:42:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbVjQx2t90oFK3VQQmYGd75lbRVu/VQaMD9SoNBSQoArqjMZUdC5njQI5+8rs7uL46tM2ksjm3LeJ+QA0vrd0TsDiCbA+DdG6VTIyf
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a386a32a9d9sm35092ejc.194.2024.02.06.13.42.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 13:42:19 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fd15fe6a8so21375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:42:19 -0800 (PST)
X-Received: by 2002:a05:600c:5025:b0:40f:cdd4:4407 with SMTP id
 n37-20020a05600c502500b0040fcdd44407mr15270wmr.1.1707255738888; Tue, 06 Feb
 2024 13:42:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206095902.56406-1-yaoma@linux.alibaba.com> <20240206095902.56406-3-yaoma@linux.alibaba.com>
In-Reply-To: <20240206095902.56406-3-yaoma@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Feb 2024 13:42:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V8VcmEDDpaWZi40j5dkP+HyBPFr=D_mKFG-YmXTpa_AA@mail.gmail.com>
Message-ID: <CAD=FV=V8VcmEDDpaWZi40j5dkP+HyBPFr=D_mKFG-YmXTpa_AA@mail.gmail.com>
Subject: Re: [PATCHv5 2/3] watchdog/softlockup: report the most frequent interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 6, 2024 at 1:59=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> w=
rote:
>
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 71d5b6dfa358..26dc1ad86276 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -18,6 +18,9 @@
>  #include <linux/init.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/math64.h>
> +#include <linux/irq.h>
> +#include <linux/irqdesc.h>
> +#include <linux/bitops.h>

These are still not sorted alphabetically. "irq.h" and "irqdesc.h"
should go between "init.h" and "kernel_stat.h". "bitops.h" is trickier
because the existing headers are not quite sorted. Probably the best
would be to fully sort them. They should end up like this:

#include <linux/bitops.h>
#include <linux/cpu.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <linux/irqdesc.h>
#include <linux/kernel_stat.h>
#include <linux/kvm_para.h>
#include <linux/math64.h>
#include <linux/mm.h>
#include <linux/module.h>
#include <linux/nmi.h>
#include <linux/stop_machine.h>
#include <linux/sysctl.h>
#include <linux/tick.h>

#include <linux/sched/clock.h>
#include <linux/sched/debug.h>
#include <linux/sched/isolation.h>

#include <asm/irq_regs.h>


> +static void start_counting_irqs(void)
> +{
> +       int i;
> +       struct irq_desc *desc;
> +       u32 *counts =3D __this_cpu_read(hardirq_counts);
> +       int cpu =3D smp_processor_id();
> +
> +       if (!test_bit(cpu, softlockup_hardirq_cpus)) {

I don't think you need "softlockup_hardirq_cpus", do you? Just read
"actual_nr_irqs" and see if it's non-zero? ...or read "hardirq_counts"
and see if it's non-NULL?


> +               /*
> +                * nr_irqs has the potential to grow at runtime. We shoul=
d read
> +                * it and store locally to avoid array out-of-bounds acce=
ss.
> +                */
> +               __this_cpu_write(actual_nr_irqs, nr_irqs);

nit: IMO store nr_irqs in a local variable to avoid all of the
"__this_cpu_read" calls everywhere. Then just write it once from your
local variable.


> +               counts =3D kmalloc_array(__this_cpu_read(actual_nr_irqs),
> +                                      sizeof(u32),
> +                                      GFP_ATOMIC);

should use "kcalloc()" so the array is zeroed. That way if the set of
non-NULL "desc"s changes between calls you don't end up reading
uninitialized memory.


> +static void stop_counting_irqs(void)
> +{
> +       u32 *counts =3D __this_cpu_read(hardirq_counts);
> +       int cpu =3D smp_processor_id();
> +
> +       if (test_bit(cpu, softlockup_hardirq_cpus)) {
> +               kfree(counts);
> +               counts =3D NULL;
> +               __this_cpu_write(hardirq_counts, counts);

nit: don't really need to set the local "counts" to NULL. Just:

__this_cpu_write(hardirq_counts, NULL);

..and actually if you take my advice above and get rid of
"softlockup_hardirq_cpus" then this function just becomes:

  kfree(__this_cpu_read(hardirq_counts));
  __this_cpu_write(hardirq_counts, NULL);

Since kfree() handles when you pass it NULL...


> +static void print_irq_counts(void)
> +{
> +       int i;
> +       struct irq_desc *desc;
> +       u32 counts_diff;
> +       u32 *counts =3D __this_cpu_read(hardirq_counts);
> +       int cpu =3D smp_processor_id();
> +       struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] =3D {
> +               {-1, 0}, {-1, 0}, {-1, 0}, {-1, 0},
> +       };
> +
> +       if (test_bit(cpu, softlockup_hardirq_cpus)) {
> +               for_each_irq_desc(i, desc) {
> +                       if (!desc)
> +                               continue;

The "if" test above isn't needed. The "for_each_irq_desc()" macro
already checks for NULL.



> +                       /*
> +                        * We need to bounds-check in case someone on a d=
ifferent CPU
> +                        * expanded nr_irqs.
> +                        */
> +                       if (i < __this_cpu_read(actual_nr_irqs))
> +                               counts_diff =3D desc->kstat_irqs ?
> +                                       *this_cpu_ptr(desc->kstat_irqs) -=
 counts[i] : 0;
> +                       else
> +                               counts_diff =3D desc->kstat_irqs ?
> +                                       *this_cpu_ptr(desc->kstat_irqs) :=
 0;

Why do you need to test "kstat_irqs" for 0? Also, ideally don't
duplicate the math. In other words, I'd expect this (untested):

if (i < __this_cpu_read(actual_nr_irqs))
  count =3D counts[i];
else
  count =3D 0;
counts_diff =3D *this_cpu_ptr(desc->kstat_irqs) - count;

I guess I'd also put "__this_cpu_read(actual_nr_irqs)" in a local
variable like you do with counts...

