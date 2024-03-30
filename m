Return-Path: <linux-kernel+bounces-125600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B35089296D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8312E2838C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 05:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FE8BFA;
	Sat, 30 Mar 2024 05:09:05 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418523FF1;
	Sat, 30 Mar 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711775345; cv=none; b=gfLWY1ioFi9jl1ZBFjmxmFW2tHmdP96al/rViDheOnyYsGPNiY/6rojsa6KuCViu6ospo8JqIPmrQ5kYhXxI4fWTd13oBUM7loEJ816ctuoV5AIOJRDqdy8LJMFGF588bEGNcNoJZnlMJ+26z+gcXZ2kaQlCf0QR+U0nKFsVYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711775345; c=relaxed/simple;
	bh=nYsJpAvl6D6Ldufd73Rjy7YF1XYSzElH1fykgREgPxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPDDajRC5sef6WYcCenUzFrJabkj3nFiAaNM8jxBguQE+fYD0jUXLYNwIYYdx/DfR8ex7tUilcegtdOsom4YdWhROAmwHDAxg4AfPonb2M1mMwD3xYUyVNldguOl29V8JvaRRyAAWjRH+cUhqKQq6qdlYHWWn1MFfLqI2qghuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz13t1711775229tdi4p2
X-QQ-Originating-IP: RfTYRleHqifmaUL5vg3HHBAADHtyt3J2efZxDgCsTa0=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 30 Mar 2024 13:07:07 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: OtIeQkg1QQHVkELNGhnn3Ao/OxN3u837g2WY2miXs+dKwNICeHodGDXYI+XIN
	MLiksvoY6OK484p/H1Pd7HcbM0rICeev22amIC6/BI2BPXdj7hZR/NjRgIzO0ujc7AJYyuh
	hSs4kN6XesHATJzk7YtHOv0oscVKSJDG1YcCID61KeNwB//v/SP6Vco5Zi0zVzK2CryiHy7
	MDlcbxtiVcvQbWgHR9uJniyBUgkXuWUpSRm9PGge+rsWbj+CoXH7KA5p92J+1tMYPfc3pMS
	a2+D1HW1CQDyFXgH/iGbdQU2wmJ3Udzd7Q8BgYnuoVkISFF2Z3cH4G9BqZDzzOAp62v8M7U
	2sZsZTz6rWN4NWIO+LXnMPEd2Ftx/MDN8OxPXGUXp3ZrWXMIP1dg4Nut1Jfsg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10889329762490604258
Date: Sat, 30 Mar 2024 13:07:06 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	ioana.ciornei@nxp.com, wintera@linux.ibm.com,
	twinkler@linux.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
Message-ID: <4E49057A4198779C+Zged+hXhxE4GksiL@centos8>
References: <20240329105610.922675-1-dawei.li@shingroup.cn>
 <20240329105610.922675-2-dawei.li@shingroup.cn>
 <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJzuw8_ti4P4tJ_A3Fd0QCjHTBjasbm_J3N8up=gK8Aow@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Eric,

On Fri, Mar 29, 2024 at 02:21:28PM +0100, Eric Dumazet wrote:
> On Fri, Mar 29, 2024 at 11:57 AM Dawei Li <dawei.li@shingroup.cn> wrote:
> >
> > For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
> > variable on stack is not recommended since it can cause potential stack
> > overflow.
> >
> > Instead, kernel code should always use *cpumask_var API(s) to allocate
> > cpumask var in config-neutral way, leaving allocation strategy to
> > CONFIG_CPUMASK_OFFSTACK.
> >
> > Use *cpumask_var API(s) to address it.
> >
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  net/iucv/iucv.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
> > index a4ab615ca3e3..b51f46ec32f9 100644
> > --- a/net/iucv/iucv.c
> > +++ b/net/iucv/iucv.c
> > @@ -520,14 +520,19 @@ static void iucv_setmask_mp(void)
> >   */
> >  static void iucv_setmask_up(void)
> >  {
> > -       cpumask_t cpumask;
> > +       cpumask_var_t cpumask;
> >         int cpu;
> >
> > +       if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
> > +               return;
> 
> This can not be right. iucv_setmask_up() is not supposed to fail.
> 
> Since iucv_setmask_up() is only called with iucv_register_mutex held,
> you could simply add a 'static' for @cpumask variable.

Correct, iucv_register_mutex is a global lock and can serialize access
on static cpumask var.

I will respin V2 as you suggested.

Thanks,

    Dawei
> 
> 
> 
> > +
> >         /* Disable all cpu but the first in cpu_irq_cpumask. */
> > -       cpumask_copy(&cpumask, &iucv_irq_cpumask);
> > -       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), &cpumask);
> > -       for_each_cpu(cpu, &cpumask)
> > +       cpumask_copy(cpumask, &iucv_irq_cpumask);
> > +       cpumask_clear_cpu(cpumask_first(&iucv_irq_cpumask), cpumask);
> > +       for_each_cpu(cpu, cpumask)
> >                 smp_call_function_single(cpu, iucv_block_cpu, NULL, 1);
> > +
> > +       free_cpumask_var(cpumask);
> >  }
> 

