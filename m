Return-Path: <linux-kernel+bounces-167950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D518BB17C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFF31F22FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5C1157A7D;
	Fri,  3 May 2024 17:10:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDA15749A
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756228; cv=none; b=DoezOGGbcZhDuaVdTqEeot4JjsaR2XSKVE3lI0KoD88YxaMJPAjTB5754F65kdpESgvaTArBCVNPVx1asodWgdMlW/OI3qeYuELQbt5BN5rR1FnUOSwJNSess4mjuT3n9STPA4/0piwhq+BbCUoTGbzhIYwqLWqrB2iB878Hfbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756228; c=relaxed/simple;
	bh=OK2458DTTcUD97r6Dol6JsWgt2qOtHUUfDftniW40Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIfjmbV8jeNAlJ7f3DLcipwNCrcdoMZSl+bgibG6AAKM7tRA7qSYgiV68KKgkhU8KAJpYe5TAJKy6UU1zZBCfh5x5BlEHxr8rfOpWqHpx4tJ5Q9ux/a0QdgKAy0goiFVzhBUj9Il73HGbL0BcaTXge+GMe5f9Zmf5C5E6F2oChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BCD713D5;
	Fri,  3 May 2024 10:10:49 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.34.156])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ED0E3F793;
	Fri,  3 May 2024 10:10:18 -0700 (PDT)
Date: Fri, 3 May 2024 18:10:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, tglx@linutronix.de, ardb@kernel.org,
	broonie@kernel.org, anshuman.khandual@arm.com,
	miguel.luis@oracle.com, joey.gouly@arm.com, ryan.roberts@arm.com,
	jeremy.linton@arm.com, ericchancf@google.com,
	kristina.martsenko@arm.com, robh@kernel.org,
	scott@os.amperecomputing.com, songshuaishuai@tinylab.org,
	shijie@os.amperecomputing.com, akpm@linux-foundation.org,
	bhe@redhat.com, horms@kernel.org, mhiramat@kernel.org,
	rmk+kernel@armlinux.org.uk, shahuang@redhat.com,
	takakura@valinux.co.jp, dianders@chromium.org, swboyd@chromium.org,
	sumit.garg@linaro.org, frederic@kernel.org, reijiw@google.com,
	akihiko.odaki@daynix.com, ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 0/8] Rework the DAIF mask, unmask and track API
Message-ID: <ZjUadl2Kbv-KyveZ@FVFF77S0Q05N>
References: <20240415064758.3250209-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415064758.3250209-1-liaochang1@huawei.com>

Hi,

On Mon, Apr 15, 2024 at 06:47:50AM +0000, Liao Chang wrote:
> This patch series reworks the DAIF mask, unmask, and track API for the
> upcoming FEAT_NMI extension added in Armv8.8.
> 
> As platform and virtualization[1] supports for FEAT_NMI is emerging, and
> Mark Brown's FEAT_NMI patch series[2] highlighted the need for clean up
> the existing hacking style approach about DAIF management code before
> adding NMI functionality, furthermore, we discover some subtle bugs
> during 'perf' and 'ipi_backtrace' transition from PSEUDO_NMI to
> FEAT_NMI, in summary, all of these emphasize the importance of rework.
> 
> This series of reworking patches follows the suggestion from Mark
> Rutland mentioned in Mark Brown's patchset. In summary, he think the
> better way for DAIF manangement look likes as following:
> 
> (a) Adding entry-specific helpers to manipulate abstract exception masks
>     covering DAIF + PMR + ALLINT. Those need unmask-at-entry and
>     mask-at-exit behaviour, and today only need to manage DAIF + PMR.
> 
>     It should be possible to do this ahead of ALLINT / NMI support.
> 
> (b) Adding new "logical exception mask" helpers that treat DAIF + PMR +
>     ALLINT as separate elements. 

I've started looking at this in the series. There are some subtleties here, and
I don't think the helpers in this series are quite right as-is. I will try to
get back to you next week with a description of those; it'll take a short while
to write that up correctly and clearly and I don't trust myself to rush that
last thing on a Friday.

Thanks,
Mark.

> 
> This patches cherry-pick a part of Mark Brown' FEAT_NMI series, in order
> to pass compilation and basic testing, includes perf and ipi_backtrace.
> 
> [1] https://lore.kernel.org/all/20240407081733.3231820-1-ruanjinjie@huawei.com/
> [2] https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/
> 
> v3->v2:
> 1. Squash two commits that address two minor issues into Mark Brown's
>    origin patch for detecting FEAT_NMI.
> 2. Add one patch resolves the kprobe reenter panic while testing
>    FEAT_NMI on QEMU.
> 
> v2->v1:
> Add SoB tags following the origin author's SoBs.
> 
> Liao Chang (5):
>   arm64: daifflags: Add logical exception masks covering DAIF + PMR +
>     ALLINT
>   arm64: Unify exception masking at entry and exit of exception
>   arm64: Deprecate old local_daif_{mask,save,restore}
>   irqchip/gic-v3: Improve the maintainability of NMI masking in GIC
>     driver
>   arm64: kprobe: Keep NMI maskabled while kprobe is stepping xol
> 
> Mark Brown (3):
>   arm64/sysreg: Add definitions for immediate versions of MSR ALLINT
>   arm64/cpufeature: Detect PE support for FEAT_NMI
>   arm64/nmi: Add Kconfig for NMI
> 
>  arch/arm64/Kconfig                   |  17 ++
>  arch/arm64/include/asm/cpufeature.h  |   6 +
>  arch/arm64/include/asm/daifflags.h   | 298 ++++++++++++++++++++++-----
>  arch/arm64/include/asm/nmi.h         |  27 +++
>  arch/arm64/include/asm/sysreg.h      |   2 +
>  arch/arm64/include/uapi/asm/ptrace.h |   1 +
>  arch/arm64/kernel/acpi.c             |  10 +-
>  arch/arm64/kernel/cpufeature.c       |  58 +++++-
>  arch/arm64/kernel/debug-monitors.c   |   7 +-
>  arch/arm64/kernel/entry-common.c     |  96 +++++----
>  arch/arm64/kernel/entry.S            |   2 -
>  arch/arm64/kernel/hibernate.c        |   6 +-
>  arch/arm64/kernel/irq.c              |   2 +-
>  arch/arm64/kernel/machine_kexec.c    |   2 +-
>  arch/arm64/kernel/probes/kprobes.c   |   4 +-
>  arch/arm64/kernel/setup.c            |   2 +-
>  arch/arm64/kernel/smp.c              |   6 +-
>  arch/arm64/kernel/suspend.c          |   6 +-
>  arch/arm64/kvm/hyp/vgic-v3-sr.c      |   6 +-
>  arch/arm64/kvm/hyp/vhe/switch.c      |   4 +-
>  arch/arm64/mm/mmu.c                  |   6 +-
>  arch/arm64/tools/cpucaps             |   2 +
>  drivers/irqchip/irq-gic-v3.c         |   6 +-
>  23 files changed, 442 insertions(+), 134 deletions(-)
>  create mode 100644 arch/arm64/include/asm/nmi.h
> 
> -- 
> 2.34.1
> 
> 

