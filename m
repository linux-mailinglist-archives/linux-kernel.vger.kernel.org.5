Return-Path: <linux-kernel+bounces-8566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F317B81B977
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770F8B209D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2C6D6F8;
	Thu, 21 Dec 2023 14:24:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9396D6D9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3065C433C9;
	Thu, 21 Dec 2023 14:24:42 +0000 (UTC)
Date: Thu, 21 Dec 2023 09:25:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Florent
 Revest <revest@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 6/9] powerpc/ftrace: Update and move function
 profile instructions out-of-line
Message-ID: <20231221092545.1b696eb6@gandalf.local.home>
In-Reply-To: <e2e467a3-7283-4f22-8cd9-2d1875f60e92@csgroup.eu>
References: <cover.1702045299.git.naveen@kernel.org>
	<39363eb6b1857f26f9fa51808ad48b0121899b84.1702045299.git.naveen@kernel.org>
	<e2e467a3-7283-4f22-8cd9-2d1875f60e92@csgroup.eu>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 10:46:08 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> > To enable ftrace, the nop at function entry is changed to an
> > unconditional branch to 'tramp'. The call to ftrace_caller() may be
> > updated to ftrace_regs_caller() depending on the registered ftrace ops.
> > On 64-bit powerpc, we additionally change the instruction at 'tramp' to
> > 'mflr r0' from an unconditional branch back to func+4. This is so that
> > functions entered through the GEP can skip the function profile sequence
> > unless ftrace is enabled.
> > 
> > With the context_switch microbenchmark on a P9 machine, there is a
> > performance improvement of ~6% with this patch applied, going from 650k
> > context switches to 690k context switches without ftrace enabled. With
> > ftrace enabled, the performance was similar at 86k context switches.  
> 
> Wondering how significant that context_switch micorbenchmark is.
> 
> I ran it on both mpc885 and mpc8321 and I'm a bit puzzled by some of the 
> results:
> # ./context_switch --no-fp
> Using threads with yield on cpus 0/0 touching FP:no altivec:no vector:no 
> vdso:no
> 
> On 885, I get the following results before and after your patch.
> 
> CONFIG_FTRACE not selected : 44,9k
> CONFIG_FTRACE selected, before : 32,8k
> CONFIG_FTRACE selected, after : 33,6k
> 
> All this is with CONFIG_INIT_STACK_ALL_ZERO which is the default. But 
> when I select CONFIG_INIT_STACK_NONE, the CONFIG_FTRACE not selected 
> result is only 34,4.
> 
> On 8321:
> 
> CONFIG_FTRACE not selected : 100,3k
> CONFIG_FTRACE selected, before : 72,5k
> CONFIG_FTRACE selected, after : 116k
> 
> So the results look odd to me.


BTW, CONFIG_FTRACE just enables the tracing system (I would like to change
that to CONFIG_TRACING, but not sure if I can without breaking .configs all
over the place).

The nops for ftrace is enabled with CONFIG_FUNCTION_TRACER.

-- Steve

