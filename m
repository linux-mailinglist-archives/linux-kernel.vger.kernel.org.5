Return-Path: <linux-kernel+bounces-143677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372728A3C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA39F1F2180C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE83FB1B;
	Sat, 13 Apr 2024 10:29:40 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E673F9DD
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004180; cv=none; b=Z7ePCevr9wCdkmGEbcdA2z873z3pwPCwHia9CN0PynsFIhNTqD8BgMr5g9PZnyWBlySn5PQsYM+GAgxxjLxYLjMBvNNq3Fkvw8APJ0kusW05FP57yfotHUs4lunmLE+jcIK/a4yreXkcy9KXhrEQPmrNx5FXRJvsRbZnFY8dcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004180; c=relaxed/simple;
	bh=z2h06yack0fK40W+GWlFkNS0ymn52Hu97igyPosiycQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkF8EUwiBqYnEEsADIHwLfukb9K8jLUHQVIZEijTbkxAY2pf3hBoWpI7B0HyGymjIGt2GvPcGCq4i0JVrv/np2qZD9uCFTDONSZ0IEwB9UvI9bFrAEwYRYZ5XxSo4zbfq65ed9JX32ObX7OTQxCo/DdCrrDLvl6iTXBBpI0TxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp82t1713004161tqfmgqgp
X-QQ-Originating-IP: C+nUWCov3kIB/+sUkmX76C6lyabNjLf2iVqueN7tlvY=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 13 Apr 2024 18:29:20 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: PiR6b16voI1VBJikAA9JPSRefE4hhF1KzajzLCFKjKilDZdnTUuBAOEykAtwH
	2LL5a7lH7W35LuauYkBiVuZBsV4wTxK1qy3s2JH9nwClrIIEaEqL//O+Mxggnt8vOXBt3sQ
	UUy6QZ/g5qYszGnFiSTHaB6qjpb3IVzUHwb6x4i6IQ87XfZ91o8F0OnIovwlrLUpA83gkq0
	MW7MCaPabbcWifwscY3Mq8e0d2/wCKRJCF8uz73lrG1PclzwOvpK0lL4e+3fiPJgukEbt/D
	YdBR7iQjXZR40xh1gU39+E3kxtpjrgOONW+j3aTeNkZk3D8dbiumyT0o1tVo7XetVjAeGCY
	ffCL16KmWu1KSvXGhM5wfCZW2wC/dz+Q7A0HUyuA7+t8PTRWag6skcwx/XHB8TrMRlJl5u4
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 7046996157122337646
Date: Sat, 13 Apr 2024 18:29:20 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: Marc Zyngier <maz@kernel.org>
Cc: tglx@linutronix.de, yury.norov@gmail.com, akpm@linux-foundation.org,
	florian.fainelli@broadcom.com, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, anup@brainfault.org, palmer@dabbelt.com,
	samuel.holland@sifive.com, linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] irqchip/gic-v3-its: Avoid explicit cpumask
 allocation on stack
Message-ID: <08D93AF972A58F13+ZhpegNehN5/RYie5@centos8>
References: <20240412105839.2896281-1-dawei.li@shingroup.cn>
 <20240412105839.2896281-4-dawei.li@shingroup.cn>
 <86il0msn4z.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86il0msn4z.wl-maz@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi Marc,

Thanks for the review.

On Fri, Apr 12, 2024 at 02:53:32PM +0100, Marc Zyngier wrote:
> On Fri, 12 Apr 2024 11:58:36 +0100,
> Dawei Li <dawei.li@shingroup.cn> wrote:
> > 
> > In general it's preferable to avoid placing cpumasks on the stack, as
> > for large values of NR_CPUS these can consume significant amounts of
> > stack space and make stack overflows more likely.
> >
> > Remove cpumask var on stack and use proper cpumask API to address it.
> 
> Define proper. Or better, define what is "improper" about the current
> usage.

Sorry for the confusion.

I didn't mean current implementation is 'improper', actually both
implementations share equivalent API usages. I will remove this
misleading expression from commit message.

> 
> >
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index fca888b36680..a821396c4261 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -3826,7 +3826,7 @@ static int its_vpe_set_affinity(struct irq_data *d,
> >  				bool force)
> >  {
> >  	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> > -	struct cpumask common, *table_mask;
> > +	struct cpumask *table_mask;
> >  	unsigned long flags;
> >  	int from, cpu;
> >  
> > @@ -3850,8 +3850,11 @@ static int its_vpe_set_affinity(struct irq_data *d,
> >  	 * If we are offered another CPU in the same GICv4.1 ITS
> >  	 * affinity, pick this one. Otherwise, any CPU will do.
> >  	 */
> > -	if (table_mask && cpumask_and(&common, mask_val, table_mask))
> > -		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
> > +	if (table_mask && cpumask_intersects(mask_val, table_mask)) {
> > +		cpu = cpumask_test_cpu(from, mask_val) &&
> > +		      cpumask_test_cpu(from, table_mask) ?
> > +		      from : cpumask_first_and(mask_val, table_mask);
> 
> So we may end-up computing the AND of the two bitmaps twice (once for
> cpumask_intersects(), once for cpumask_first_and()), instead of only
> doing it once.

Actually maybe it's possible to merge these 2 bitmap ops into one:

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..7a267777bd0b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3826,7 +3826,8 @@ static int its_vpe_set_affinity(struct irq_data *d,
                                bool force)
 {
        struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-       struct cpumask common, *table_mask;
+       struct cpumask *table_mask;
+       unsigned int common;
        unsigned long flags;
        int from, cpu;

@@ -3850,10 +3851,13 @@ static int its_vpe_set_affinity(struct irq_data *d,
         * If we are offered another CPU in the same GICv4.1 ITS
         * affinity, pick this one. Otherwise, any CPU will do.
         */
-       if (table_mask && cpumask_and(&common, mask_val, table_mask))
-               cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
-       else
+       if (table_mask && (common = cpumask_first_and(mask_val, table_mask)) < nr_cpu_ids) {
+               cpu = cpumask_test_cpu(from, mask_val) &&
+                     cpumask_test_cpu(from, table_mask) ?
+                     from : common;
+       } else {
                cpu = cpumask_first(mask_val);
+       }

> 
> I don't expect that to be horrible, but I also note that you don't
> even talk about the trade-offs you are choosing to make.

With change above, I assume that the tradeoff is minor and can be ignored?

And I aplogize if I am missing something.

> 
> > +	}
> >  	else
> >  		cpu = cpumask_first(mask_val);
> 
> Please fix the coding style (if () { ... } else { ... }).

Ack.


Thanks,

    Dawei

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 

