Return-Path: <linux-kernel+bounces-92194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD1871C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CB71C23077
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB659B44;
	Tue,  5 Mar 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H1/qCxCj"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B958ABA;
	Tue,  5 Mar 2024 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636263; cv=none; b=uJlrjDLEF+V7e0hPSSHpPE6713LqGF39hRJZb8zPmPX3LXHwUShd3ThOsTpsvRze5nSdTxgaCVuU8hD12WJxunrdCskUqEm51qt+MC9sYb1I6Lh+Vimrkh8pyl8pS+Zfgbw+Q21cnIHeyqGpfTQOtgH3veF7oTOtJMIhvlxWQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636263; c=relaxed/simple;
	bh=d6wEI8+wCMnSdkIqW6YoHtvK6Oha6qUUulRHtofV6I8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PZ25PkYfl0ggp/hVjJIrQRrJKxYDCYjYqOYqVc30w/L3WPXbkZ794qtLOOoBFt0M8YY1nPF/hSJkCB6jmZQTVCfQ7FJLiwoQ6Vzgt74PMUkKmWSsuse5D+ZbQrzyO2xgYNTrweEyrZqyumXUc2xzRznfu2wX25+Y05mqPuNRQcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H1/qCxCj; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709636258; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=j65dJlefD3YD0cqeyDWt8oxBp32fVKAN6EtBWBvh2Tg=;
	b=H1/qCxCjObiT8ZRpTbxrm3JPjTc5jfZzkb9nYiues2enoNRa2LXll1Pv2rC4JxMXU19xiOGHWpmIj1UrXpWHhEyr5qFm4rH5flsBn2EzAIUd6IjVtza+Pd8v/5C3Dj7TkDPL1me+EE8fCAUztK4/44mDaqxj32RlQJa2QD6Fkhk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1tyYEr_1709636255;
Received: from 30.178.67.161(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1tyYEr_1709636255)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 18:57:37 +0800
Message-ID: <28a24e4b-c322-4631-ad6d-7259ca3d084d@linux.alibaba.com>
Date: Tue, 5 Mar 2024 18:57:34 +0800
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
 <3a89fafb-f62e-472f-b40b-8bf97954e9e3@linux.alibaba.com>
 <87wmqiulaw.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87wmqiulaw.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/3/4 22:24, Thomas Gleixner wrote:
> The above is not even configurable by the user. It's only selectable by
> some other config option.
> 
>> +# Snapshot for interrupt statistics
>> +config GENERIC_IRQ_STAT_SNAPSHOT
>> +       bool
>> +       help
>> +
>> +         Say Y here to enable the kernel to provide a snapshot mechanism
>> +         for interrupt statistics.
> 
> That makes is visible which is pointless because it's only relevant when
> there is an actual user.
I guess I may have misunderstood your intentions earlier. Initially, I
thought you were suggesting that when "SOFTLOCKUP_DETECTOR_INTR_STORM"
is not enabled, people should be able to choose
"GENERIC_IRQ_STAT_SNAPSHOT" through menuconfig, so I attempted to make
"GENERIC_IRQ_STAT_SNAPSHOT" visible to the user. However, after
analyzing the previous emails, it seems that what you were actually
proposing was to directly disable "GENERIC_IRQ_STAT_SNAPSHOT" when
"SOFTLOCKUP_DETECTOR_INTR_STORM" is not enabled, as a way to save
memory. If my current understanding is correct, then the code for that
part would look something like the following.

Does this align with your expectations?

Best Regards,
	Bitao Hu

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 2531f3496ab6..a28e5ac5fc79 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
  config GENERIC_IRQ_RESERVATION_MODE
         bool

+# Snapshot for interrupt statistics
+config GENERIC_IRQ_STAT_SNAPSHOT
+       bool
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







