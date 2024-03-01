Return-Path: <linux-kernel+bounces-89234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC8086ED0B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066992862EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E05F473;
	Fri,  1 Mar 2024 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44Eeg3Qv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAjuBIDm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64659149
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336963; cv=none; b=fahdOWjtuAR1gcRchVp+wzj4856gWv0yJpSVSn6iS/ZzQzidzzxCiwoavupUwuex8jDjS7f8c1YDMPH7PMtHp2+/mb0teYh1ydhLGLlKKoBKpkZlt9UNX5DsYECal+ULAsIjuWgr6/fB6DFy0T+Dd+ONvFiVSUg1s9Fz75zACRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336963; c=relaxed/simple;
	bh=4yFQVN6Z3zwGDJgs3QMQjw11XVWKSudhtUWj8jqRuvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gos6aDpH9zbFQ1E4BTvxPvme2SZWLkokSCDbPrBi57CdGxjYMx/wFAslRCLm6R3fmce+9PQcxZQYVzWcBuX4ZXF4zLfD8NliJd+WIlf1F6Iet255Fp4Hy7/yCd1imldz8h0Gc9N8QloZo1LMcXXwFZ2Y5qn8vcEvscWLIDF9n7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=44Eeg3Qv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAjuBIDm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709336958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/i1V2icgGuwaQkdg1eB8PJzeYOX9pq5WMw5wIBkgF0Q=;
	b=44Eeg3QvBdLWRq2GLlJotFGuMmo45T2dwFdDVBk4A2fOWM/9PHFYT0W8+zfa84sK1LNsdr
	gm5vaCZL9MVOd3DbOGUy50JPWNkAfFqtXLqSVxZotSmuZjS5CZoAzndbfKNiXXuIACbmIF
	9sufHDmDt8ub2m27cnp4RSjJcLVBk129FfvIe6/PnGf4VBKdV8DKroTC6qUuK3MG0/jAmj
	2N6U6fdOh66t8WNFK6m9JYdMVqO3vwCmXQ3btkETpB61/nBb1vTgd1kmzStVYo9//jbaPP
	xeJuQxiWxpF4hFDu+4FaJYfBdph0Ib/7MMdB+rcpcCcfaZ1IU8wYUg1rYmIBjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709336958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/i1V2icgGuwaQkdg1eB8PJzeYOX9pq5WMw5wIBkgF0Q=;
	b=QAjuBIDmkn7LKN/8CBgrO91mO7wLcx61a5iJNyCon4u/dsuiXhqwCYmif23OzJDd/ZXs58
	QuTc45wOTpocyTCA==
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: arch/x86/kernel/cpu/debugfs.c:11:33: sparse: sparse: incorrect
 type in initializer (different address spaces)
In-Reply-To: <202403020747.CxX5V2dB-lkp@intel.com>
References: <202403020747.CxX5V2dB-lkp@intel.com>
Date: Sat, 02 Mar 2024 00:49:18 +0100
Message-ID: <874jdpwm0x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 02 2024 at 07:38, kernel test robot wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d17468c6f1f49e6259698f6401b8d7a5b90eac68
> commit: 48525fd1ea1cfa059a580e77b10ea8790914efa2 x86/cpu: Provide debug interface
> date:   5 months ago
> config: x86_64-randconfig-121-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020747.CxX5V2dB-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020747.CxX5V2dB-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403020747.CxX5V2dB-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>
>
> vim +11 arch/x86/kernel/cpu/debugfs.c
>
>      7	
>      8	static int cpu_debug_show(struct seq_file *m, void *p)
>      9	{
>     10		unsigned long cpu = (unsigned long)m->private;
>   > 11		struct cpuinfo_x86 *c = per_cpu_ptr(&cpu_info, cpu);

This is the line which allegdly causes that new bogus warning, but your
report does not include the warning itself. How useful...

Though don't bother to send me the warning. It's going to be completely
bogus anyway as all the other ones.

Thanks,

        tglx


