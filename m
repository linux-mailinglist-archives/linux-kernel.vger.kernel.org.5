Return-Path: <linux-kernel+bounces-92726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EA8724F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4351C214DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D54D53B;
	Tue,  5 Mar 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HKbwYqoG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8tNakUsg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389FD267;
	Tue,  5 Mar 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657870; cv=none; b=jFRthziKkHn/53065+mcwMlqW539AIcfRuWsBh5pbOaV7q0IPymOg9s4mffcONr9URexKixYdNSq+kb9tB6aK1Bt5ljkhSXYo0X5tzNCDKs2OtmdP1VtqBABXApbG2ApWGriUWHrztRHybCUtT0VkFvuRxM/HeLfxomxQp867j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657870; c=relaxed/simple;
	bh=azjFOsktqiCXb357AvMEW9hKL9yqQ3FCu5yPd9IL/jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WRDeXsA+X9W1f/2bgtRVEf5buQZB1XboZQXxdrxGewl5w6hZTk3vsbKQ47Blm5jhqHkZoN9r6xPH8QAT5sbkQBBSO2Pfo0Yr8765H4CYAzNAsTyYOk9n1ZLVbaF/II4FFB7YepmPrOodEjIIzPk7rjsSp9mYo4YRdNWfk1vPp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HKbwYqoG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8tNakUsg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709657861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HRm+TnjyJg5idEpRreLSl5etxQBLrbJ4QAyjOJxgiHU=;
	b=HKbwYqoGgFwQ5w0c2x4gUshWZq5DHnmoTWFc3/aZZcUsyBPUvs7FtgO9sXWFeAyfxpuEi6
	xlcIADFKW3TAaX8V6Ga3Vk3KxGSZLgdUIYbQXmyX2czdZGrJV+gT+com+2AYsi4w5tCpPe
	P+3R/323Mr+jpB72RGyL7UAB2G4Y24a0f5aPuMXb2XzcFpBHmn6AX+fCh47ITffrAmlSjQ
	X0sd2R+FxjQ3skVdAjuyST0jIZLH7tS9pVec6Q/PgKFl70I0IEfjpeTld2114ViFAQn5Jb
	vMDMFcMAgaGC7ZbfrNWUXKsAS9MSi3fMQV2MyyOkR6PfJ5iMQMb9P8IPdthLhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709657861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HRm+TnjyJg5idEpRreLSl5etxQBLrbJ4QAyjOJxgiHU=;
	b=8tNakUsgVDjiTy1DgFT1yzq4jZIkpWJOqH5pgA+w3enng6vlac/FwllNiicYgryByF76pu
	dUSgco6KK8GYs2CA==
To: Bitao Hu <yaoma@linux.alibaba.com>, Doug Anderson <dianders@chromium.org>
Cc: liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
 jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yaoma@linux.alibaba.com
Subject: Re: [PATCHv11 2/4] genirq: Provide a snapshot mechanism for
 interrupt statistics
In-Reply-To: <28a24e4b-c322-4631-ad6d-7259ca3d084d@linux.alibaba.com>
References: <20240228072216.95130-1-yaoma@linux.alibaba.com>
 <20240228072216.95130-3-yaoma@linux.alibaba.com>
 <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
 <87plwdwycx.ffs@tglx>
 <3a89fafb-f62e-472f-b40b-8bf97954e9e3@linux.alibaba.com>
 <87wmqiulaw.ffs@tglx>
 <28a24e4b-c322-4631-ad6d-7259ca3d084d@linux.alibaba.com>
Date: Tue, 05 Mar 2024 17:57:40 +0100
Message-ID: <87h6hkvcor.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 05 2024 at 18:57, Bitao Hu wrote:
> On 2024/3/4 22:24, Thomas Gleixner wrote:
> "GENERIC_IRQ_STAT_SNAPSHOT" visible to the user. However, after
> analyzing the previous emails, it seems that what you were actually
> proposing was to directly disable "GENERIC_IRQ_STAT_SNAPSHOT" when
> "SOFTLOCKUP_DETECTOR_INTR_STORM" is not enabled, as a way to save
> memory. If my current understanding is correct, then the code for that
> part would look something like the following.

Correct.

> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index 2531f3496ab6..a28e5ac5fc79 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -108,6 +108,10 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
>   config GENERIC_IRQ_RESERVATION_MODE
>          bool
>
> +# Snapshot for interrupt statistics
> +config GENERIC_IRQ_STAT_SNAPSHOT
> +       bool
> +
>   # Support forced irq threading
>   config IRQ_FORCED_THREADING
>          bool
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 49f652674bd8..899b69fcb598 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1032,6 +1032,7 @@ config SOFTLOCKUP_DETECTOR
>   config SOFTLOCKUP_DETECTOR_INTR_STORM
>          bool "Detect Interrupt Storm in Soft Lockups"
>          depends on SOFTLOCKUP_DETECTOR && IRQ_TIME_ACCOUNTING
> +       select GENERIC_IRQ_STAT_SNAPSHOT

This goes into the patch which adds the lockup detector parts.

Thanks,

        tglx

