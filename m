Return-Path: <linux-kernel+bounces-147992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A138A7C53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5A0B22DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6189453807;
	Wed, 17 Apr 2024 06:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLSBFvGa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97783537E5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335385; cv=none; b=W/630jJxvwLD1DMs8Oe411u6om57Ye45ojWxqKGutHn2i8oe00h+qEWX/FezI/aipKRGXvzBkhJpPateji7749mPZTUShMloltFeywq05eRKfbiy2tuDgvW7odRYlgbmQhubkJi0DH7gjT7Y5qZYBa4gRBEgJxszQKHvmDu27rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335385; c=relaxed/simple;
	bh=ebqb33hqc4F6zSwsMRpxS2CZvXYy0dorhRZVr5ux1J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHLDsIJQAvJk47GlRd6KTYE6UWxjx6In0sCtHd7sy5BllXGJ0Z21Wl37qtQU0kAODq3gWXP3QvijYT38epaEyEcYv8VLcPhmFMVIY5TFKjXvxLkud+zhqogEkAkqub+yAHhVwQInrXPjmp8VPzeiXzZY4DlcNJ3DtR5oomk9MHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLSBFvGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F851C072AA;
	Wed, 17 Apr 2024 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713335385;
	bh=ebqb33hqc4F6zSwsMRpxS2CZvXYy0dorhRZVr5ux1J0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLSBFvGaiGz3+TWitmIbeOotiIZFwPFcEsEMvvoRQxg9tQq93gL6LB33aKtgx5uqA
	 E+YKHlcLCcVKmZGYL/dm2YLz1fZlagEBkF7w2e+XXIRQ4zbQnma5ZpNOu7fTHkQcGL
	 Z54r1Mpu5YA1R/ijSt7qRHBk61oX4l6Vphn7bj/CMQClj8nxmTbf2cuICRUjly6XyU
	 NzwC0fPyTvAG+a13UZNQd58qG493svJDgZb27vycwQibzEvbE+JpaBNS1OA1jqGNfu
	 OekZH2l8SKMvWrRnk63KBlmD1t64gyq5XhNWal6GcUJqTVcG6SnFXgTJ/eUkmwPbHG
	 BCWJrYX6r6feQ==
Date: Wed, 17 Apr 2024 02:29:37 -0400
From: Guo Ren <guoren@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: dqfext@gmail.com, ajones@ventanamicro.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atishp@atishpatra.org,
	conor.dooley@microchip.com, heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, mark.rutland@arm.com,
	palmer@dabbelt.com, paul.walmsley@sifive.com, will@kernel.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID: <Zh9sUUUT09LZb0MO@gmail.com>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <tencent_29B81A312921AB8D9D7C3C8292DAAB8EF608@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_29B81A312921AB8D9D7C3C8292DAAB8EF608@qq.com>

On Fri, Apr 12, 2024 at 02:09:32PM +0800, Yangyu Chen wrote:
> On 2024/3/11 14:30, Qingfang Deng wrote:
> > T-Head C908 has the same IRQ num and CSR as previous C9xx cores, but
> > reports non-zero marchid and mimpid. Remove the ID checks.
> > 
> > Fixes: 65e9fb081877 ("drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores")
> > Signed-off-by: Qingfang Deng<dqfext@gmail.com>
> > ---
> >   arch/riscv/errata/thead/errata.c | 4 ----
> >   drivers/perf/riscv_pmu_sbi.c     | 4 +---
> >   2 files changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index b1c410bbc1ae..49ccad5b21bb 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -125,10 +125,6 @@ static bool errata_probe_pmu(unsigned int stage,
> >   	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
> >   		return false;
> >   
> > -	/* target-c9xx cores report arch_id and impid as 0 */
> > -	if (arch_id != 0 || impid != 0)
> > -		return false;
> > -
> >   	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> >   		return false;
> >   
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > index 452aab49db1e..87b83184383a 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -811,9 +811,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
> >   		riscv_pmu_irq_num = RV_IRQ_PMU;
> >   		riscv_pmu_use_irq = true;
> >   	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
> > -		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
> > -		   riscv_cached_marchid(0) == 0 &&
> > -		   riscv_cached_mimpid(0) == 0) {
> > +		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID) {
> >   		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
> >   		riscv_pmu_use_irq = true;
> >   	}
> > -- 2.34.1
> 
> Tested-by: Yangyu Chen <cyy@cyyself.name>
> 
> With this patch and T-Head C908 PMU being probed by OpenSBI, I can now use
> the perf record to profile RVV 1.0 software on Canaan Kendryte K230. This
> will speed up many RVV 1.0 software developments now and even for better
> performance.
> 
> However, as Inochi said, the newer version, C908 may support Sccofpmf. We
> should ask Guo Ren to clarify this so we can have the cleanest way to
> probe what to use between THEAD_PMU and Sscofpmu.
> 
> I added CC to Guo Ren. Please clarify about this.

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index c6ef09c4548c..ee6fa5b65b53 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -812,8 +812,10 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu
*pmu, struct platform_device *pde
                riscv_pmu_use_irq = true;
        } else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
                   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
-                  riscv_cached_marchid(0) == 0 &&
-                  riscv_cached_mimpid(0) == 0) {
+                  (riscv_cached_marchid(0) == 0 ||
+                   riscv_cached_marchid(0) == 0x8000000009140d00) &&
+                  (riscv_cached_mimpid(0) == 0 ||
+                   riscv_cached_mimpid(0) == 0x50000)) {
                riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
                riscv_pmu_use_irq = true;
        }

Only k230's c908 has the problem, not all XuanTie Processors. We just
need to pick it out. Could the above satisfy you?

> 
> Some off-topic things:
> 
> I need this feature recently since I am implementing a pure RVV chacha20
> algorithm. I have already sent PR to openssl to speed up the crypto
> performance on RVV without Zvkb support and maybe ported to kernel crypto
> sometimes. To speed up TLS or other applications for many chips that may
> come this year with RVV 1.0 but without Zvkb.
> 
> Link: https://github.com/openssl/openssl/pull/24069
> 
> However, the performance evaluation on K230 is not well compared to pure C
> implementation. I will need this PMU driver to do some profiling.
> 
> Thanks,
> Yangyu Chen
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

