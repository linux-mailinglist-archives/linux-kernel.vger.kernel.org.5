Return-Path: <linux-kernel+bounces-38073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4374F83BAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BAE287F39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075111CBD;
	Thu, 25 Jan 2024 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/qlP90b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A411C83;
	Thu, 25 Jan 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167950; cv=none; b=Jv3RpysOtcM81OkdG0Xig8zVDEnUWSRtQZz56VzPCjxTFStnnor9By0GM8BF/JUNuzmqzQyZEfPAzJPSwGQ2Cot6Gi4E97V1Lzd17PoS1kMfeP9W5LQmFbeNIMLO3djfOicTYVUks+Hc7O3XUUb+132wTGxishWq5P6+c0zoBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167950; c=relaxed/simple;
	bh=4YJZl/HB/FeUJBFx4g+Hq4GWbhTEDrW8F8ywC05k2CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enUMFnzbTxV/xe4wEAiMc6WplDq2GGstG4j1c9DT4X8ucdRf8WcYfYaOnFF7WdKmsqiSMoXV7yhSGESmNRY7egsLr8mrC0V47gyZP0LtGudFlIy0UCpUjChmhgIH1fmk/LVvsm6Po6B1RzeqPUk8N9n9xTPhKFsgmFoFbzYGL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/qlP90b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E8C433C7;
	Thu, 25 Jan 2024 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706167949;
	bh=4YJZl/HB/FeUJBFx4g+Hq4GWbhTEDrW8F8ywC05k2CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/qlP90bWA8vs1DoAh96IyHbdPjr4YyuZvDq0onY5ZuuTV08XQml8GYs0ScKoZDdk
	 kRNaiyxLgYIpzg1fYukUi9EtRFIRc727kYqe3wtWXR5gtzs35c/p1Y0J1fwyQZK1Ap
	 6AYBkhNKcCN91vd4Pq89IdOJXzTo/DfX9ptcP+9MEhnDjZshaFfmldWDYiRB/53swx
	 +1IA6GzmPSyirfoR+LyXczKV2zT5RxfrhLZ1jFEvHaBZKOwVLKW3QWPCviK1bmr2b8
	 GoXu6/VAAQ3DwKjghCy5ELrIOAk+v3Yh5RTjDRV/vZkGVh46K5kitkUo/oNKs++SiR
	 aXnmU6ZKh3AJg==
Date: Thu, 25 Jan 2024 09:31:57 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
	gregkh@linuxfoundation.org, patches@amperecomputing.com,
	rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, yury.norov@gmail.com, kuba@kernel.org,
	vschneid@redhat.com, mingo@kernel.org, akpm@linux-foundation.org,
	vbabka@suse.cz, tglx@linutronix.de, jpoimboe@kernel.org,
	ndesaulniers@google.com, mikelley@microsoft.com,
	mhiramat@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will@kernel.org, mark.rutland@arm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] NUMA: Early use of cpu_to_node() returns 0 instead of
 the correct node id
Message-ID: <ZbIObaA6t9WbRw9y@kernel.org>
References: <20240123045843.75969-1-shijie@os.amperecomputing.com>
 <4a13353c-cf4b-a388-5776-389c61c63ec0@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a13353c-cf4b-a388-5776-389c61c63ec0@os.amperecomputing.com>

On Wed, Jan 24, 2024 at 09:19:00AM -0800, Lameter, Christopher wrote:
> On Tue, 23 Jan 2024, Huang Shijie wrote:
> 
> > During the kernel booting, the generic cpu_to_node() is called too early in
> > arm64, powerpc and riscv when CONFIG_NUMA is enabled.
> > 
> > For arm64/powerpc/riscv, there are at least four places in the common code
> > where the generic cpu_to_node() is called before it is initialized:
> > 	   1.) early_trace_init()         in kernel/trace/trace.c
> > 	   2.) sched_init()               in kernel/sched/core.c
> > 	   3.) init_sched_fair_class()    in kernel/sched/fair.c
> > 	   4.) workqueue_init_early()     in kernel/workqueue.c
> > 
> > In order to fix the bug, the patch changes generic cpu_to_node to
> > function pointer, and export it for kernel modules.
> > Introduce smp_prepare_boot_cpu_start() to wrap the original
> > smp_prepare_boot_cpu(), and set cpu_to_node with early_cpu_to_node.
> > Introduce smp_prepare_cpus_done() to wrap the original smp_prepare_cpus(),
> > and set the cpu_to_node to formal _cpu_to_node().
> 
> Would  you please fix this cleanly without a function pointer?
> 
> What I think needs to be done is a patch series.
> 
> 1. Instrument cpu_to_node so that some warning is issued if it is used too
> early. Preloading the array with NUMA_NO_NODE would allow us to do that.
> 
> 2. Implement early_cpu_to_node on platforms that currently do not have it.
> 
> 3. A series of patches that fix each place where cpu_to_node is used too
> early.

I think step 3 can be simplified with a generic function that sets
per_cpu(numa_node) using early_cpu_to_node(). It can be called right after
setup_per_cpu_areas().

-- 
Sincerely yours,
Mike.

