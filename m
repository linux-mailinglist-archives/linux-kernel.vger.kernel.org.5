Return-Path: <linux-kernel+bounces-20102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A782794C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94DE1C23152
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA1555E51;
	Mon,  8 Jan 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x1zvwAIy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H43+TDbz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C455E46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 8 Jan 2024 21:43:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704746629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VV0nzTHtCZc+si0IK+/GbDKwN1YnszLL2QEQ1ZBeZ3g=;
	b=x1zvwAIyiiZjVQhft+G+0WDvbad+rpt4AwvwqlRLniUgt95/lFK4CsAyX8SZLmB1SHZqST
	gmwnxKTIwIP+gGCUY7XvmMrAT0Fk5AlVWZCPSMsFBEw5XmYp7tt2/4q+1lVJivBF2Gkxza
	VCnk0bmOxMRP/Pxg/XwhUd28uaNwdv1irbFLYYgqdMMRVeKSNa5q+vap6ouonsA1y6B2QP
	G8A51tZ4TEtQsaAg/l/Z/p2tLBjhbNmXAWkGX9b+UKgTd1VVZK1NvE5cL8w9YoWiub9O/m
	emmdzz9keUXDkjK7bI11+C5cStnJLc7uj1EIbcXYjLN+GlvqQ03r+guNJVJgDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704746629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VV0nzTHtCZc+si0IK+/GbDKwN1YnszLL2QEQ1ZBeZ3g=;
	b=H43+TDbz7wiW1b8KHXyk/tfck3QSmu4ILFH+4XlAnaRphFcXG8ItFSuORnDPFExbJ1TmMM
	/F+VIDKCVrXJJoAQ==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Jisheng
 Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v2] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
Message-ID: <20240108214346.5fd93127@namcao>
In-Reply-To: <20240108193640.344929-1-alexghiti@rivosinc.com>
References: <20240108193640.344929-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jan 2024 20:36:40 +0100 Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> Allow to defer the flushing of the TLB when unmapping pages, which allows
> to reduce the numbers of IPI and the number of sfence.vma.
> 
> The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
> batched/deferred tlb shootdown during page reclamation/migration") that
> was multithreaded to force the usage of IPI shows good performance
> improvement on all platforms:
> 
> * Unmatched: ~34%
> * TH1520   : ~78%
> * Qemu     : ~81%
> 
> In addition, perf on qemu reports an important decrease in time spent
> dealing with IPIs:
> 
> Before:  68.17%  main     [kernel.kallsyms]            [k] __sbi_rfence_v02_call
> After :   8.64%  main     [kernel.kallsyms]            [k] __sbi_rfence_v02_call
> 
> * Benchmark:
> 
> int stick_this_thread_to_core(int core_id) {
>         int num_cores = sysconf(_SC_NPROCESSORS_ONLN);
>         if (core_id < 0 || core_id >= num_cores)
>            return EINVAL;
> 
>         cpu_set_t cpuset;
>         CPU_ZERO(&cpuset);
>         CPU_SET(core_id, &cpuset);
> 
>         pthread_t current_thread = pthread_self();
>         return pthread_setaffinity_np(current_thread,
> sizeof(cpu_set_t), &cpuset);
> }
> 
> static void *fn_thread (void *p_data)
> {
>         int ret;
>         pthread_t thread;
> 
>         stick_this_thread_to_core((int)p_data);
> 
>         while (1) {
>                 sleep(1);
>         }
> 
>         return NULL;
> }
> 
> int main()
> {
>         volatile unsigned char *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                          MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>         pthread_t threads[4];
>         int ret;
> 
>         for (int i = 0; i < 4; ++i) {
>                 ret = pthread_create(&threads[i], NULL, fn_thread, (void *)i);
>                 if (ret)
>                 {
>                         printf("%s", strerror (ret));
>                 }
>         }
> 
>         memset(p, 0x88, SIZE);
> 
>         for (int k = 0; k < 10000; k++) {
>                 /* swap in */
>                 for (int i = 0; i < SIZE; i += 4096) {
>                         (void)p[i];
>                 }
> 
>                 /* swap out */
>                 madvise(p, SIZE, MADV_PAGEOUT);
>         }
> 
>         for (int i = 0; i < 4; i++)
>         {
>                 pthread_cancel(threads[i]);
>         }
> 
>         for (int i = 0; i < 4; i++)
>         {
>                 pthread_join(threads[i], NULL);
>         }
> 
>         return 0;
> }
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> Tested-by: Jisheng Zhang <jszhang@kernel.org> # Tested on TH1520

Before:
    real 0m36.674s
    user 0m0.173s
    sys  0m36.493s
After:
    real 0m18.016s
    user 0m0.125s
    sys  0m17.885s

Tested-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

