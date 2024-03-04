Return-Path: <linux-kernel+bounces-90540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B9D8700E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3172CB21B01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15A3B780;
	Mon,  4 Mar 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wMXYIEUi"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9A39AF1;
	Mon,  4 Mar 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553660; cv=none; b=LsCSH3rUGBgJm4Y7H6cBYY/t9DlsK62xvc4XL3WafV2f+eaS+UP1Xe3A/hFQuuPCErbLvITTF1GZhFTpiSBLe4X4ebyG4s4qFPiLWTbCj7phfg36FJUTyYi7LtzswQjqimGVOTDL5BjOnYjAiD7GSrhk5+4zD4zPHYNbRPLpeJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553660; c=relaxed/simple;
	bh=SRlbTG/jH+XLr3HBMhDyMWI2WxBCgIajzCfFemzedW0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KzOd7jd/Wpanq1z3ByKpmEFzzx8nxeyRgQBsh5uYKZJBnSpiaULIf6z3AW4GUBepFRHPPvwywZbbcpFyM7o6j33+jVpUjQueAC3HGAERgEnAAWdCUu6SLkbw1lEZMHVlghIRLoY6JVaONAmEBpls6l0B1H8br8mhkfDjtN6G5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wMXYIEUi; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709553647; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=rtN+/ylfbynl2rH4WVBwWc3AC3awpv+1WF5WI7ypLYI=;
	b=wMXYIEUiwoVJH/xnD1RvI2dR+AACaMqlSOE/kB1fCanYeBJcd+yiA3TmmUiLeBlTbeJ3QMKsldMGq+xh3PcplByOaChpd3P/WTjzH4pDPi/mUpBC1csmwDWf3XI/0vN0O2SNCbbIo939zRN84aiPQMYkn9Resxb+Nh9u6Jdlk2I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1pZInn_1709553643;
Received: from 30.178.88.130(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1pZInn_1709553643)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 20:00:45 +0800
Message-ID: <3a89fafb-f62e-472f-b40b-8bf97954e9e3@linux.alibaba.com>
Date: Mon, 4 Mar 2024 20:00:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCHv11 2/4] genirq: Provide a snapshot mechanism for interrupt
 statistics
To: Thomas Gleixner <tglx@linutronix.de>,
 Doug Anderson <dianders@chromium.org>
Cc: liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
 jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yaoma@linux.alibaba.com
References: <20240228072216.95130-1-yaoma@linux.alibaba.com>
 <20240228072216.95130-3-yaoma@linux.alibaba.com>
 <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
 <87plwdwycx.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87plwdwycx.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/3/2 03:22, Thomas Gleixner wrote:
> Doug!
> 
> On Wed, Feb 28 2024 at 14:44, Doug Anderson wrote:
>> I won't insist on it, but I continue to worry about memory
>> implications with large numbers of CPUs. With a 4-byte int, 8192 max
>> CPUs, and 100 IRQs the extra "ref" value takes up over 3MB of memory
>> (8192 * 4 bytes * 100).
>>
>> Technically, you could add a new symbol like "config
>> NEED_IRQ_SNAPSHOTS". This wouldn't be a symbol selectable by the end
>> user but would automatically be selected by "config
>> SOFTLOCKUP_DETECTOR_INTR_STORM". If the config wasn't defined then the
>> struct wouldn't contain "ref" and the snapshot routines would just be
>> static inline stubs.
>>
>> Maybe Thomas has an opinion about whether this is something to worry
>> about. Worst case it wouldn't be hard to do in a follow-up patch.
> 
> I'd say it makes sense to give people a choice to save memory especially
> when the softlock detector code is not enabled.
> 
> It's rather straight forward to do.
> 
> Thanks,
> 
>          tglx
> ---
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -24,7 +24,9 @@ struct pt_regs;
>    */
>   struct irqstat {
>   	unsigned int	cnt;
> +#ifdef CONFIG_GENIRQ_STAT_SNAPSHOT
>   	unsigned int	ref;
> +#endif
>   };
>   
>   /**
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -978,6 +978,7 @@ static unsigned int kstat_irqs(unsigned
>   	return sum;
>   }
>   
> +#ifdef CONFIG_GENIRQ_STAT_SNAPSHOT
>   void kstat_snapshot_irqs(void)
>   {
>   	struct irq_desc *desc;
> @@ -998,6 +999,7 @@ unsigned int kstat_get_irq_since_snapsho
>   		return 0;
>   	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irqs->ref);
>   }
> +#endif
>   
>   /**
>    * kstat_irqs_usr - Get the statistics for an interrupt from thread context
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
>   config GENERIC_IRQ_RESERVATION_MODE
>   	bool
>   
> +# Snapshot for interrupt statistics
> +config GENERIC_IRQ_STAT_SNAPSHOT
> +	bool
> +
>   # Support forced irq threading
>   config IRQ_FORCED_THREADING
>          bool

I think we should follow Douglas's suggestion by making
"config GENERIC_IRQ_STAT_SNAPSHOT" automatically selectable by
"config SOFTLOCKUP_DETECTOR_INTR_STORM". This can prevent users
from inadvertently disabling "config GENERIC_IRQ_STAT_SNAPSHOT"
while enabling "config SOFTLOCKUP_DETECTOR_INTR_STORM".

Best Regards,
	Bitao Hu

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 2531f3496ab6..9cf3b2d4c2a8 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -108,6 +108,15 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
  config GENERIC_IRQ_RESERVATION_MODE
         bool

+# Snapshot for interrupt statistics
+config GENERIC_IRQ_STAT_SNAPSHOT
+       bool
+       help
+
+         Say Y here to enable the kernel to provide a snapshot mechanism
+         for interrupt statistics.
+
+
  # Support forced irq threading
  config IRQ_FORCED_THREADING
         bool
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 49f652674bd8..899b69fcb598 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1032,6 +1032,7 @@ config SOFTLOCKUP_DETECTOR
  config SOFTLOCKUP_DETECTOR_INTR_STORM
         bool "Detect Interrupt Storm in Soft Lockups"
         depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
+       select GENERIC_IRQ_STAT_SNAPSHOT
         default y if NR_CPUS <= 128
         help
           Say Y here to enable the kernel to detect interrupt storm

