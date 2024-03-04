Return-Path: <linux-kernel+bounces-90725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE85B870407
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B995284875
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908B45BF6;
	Mon,  4 Mar 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rq4HWVZv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4SzUl53"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA83FE47;
	Mon,  4 Mar 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562287; cv=none; b=k9E750xZiULi464me+Y4vcpvBjn597G9Z7CSxcuC7ZU6AJhMG9jqQ39e/5p4t3jenDlhedPg28AwrCGdznRehzmGBZKRt3O58g72OdNekv21jWERi0zqvUsaWjxxWxpQlj9JjdU9t1b4RKx7MQq32BTsrWE/s38m9sTsh0fzGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562287; c=relaxed/simple;
	bh=mcKITX6v37iZwxRKJJBrkFjTf4ftbKe8/GBF0582cnc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C87qesAFfNDTPiLqRbvwdgwP1X+igplvDmXNsHXPYryI4eh08PdbZ+XcBTMcsOnEvJ2XosYpDipdrjXx2j32Q3tUn8HkQf/GLlw5XimDKf7HmtncgrAHWQ/u9ESYNBFc8uxdDnNUKzzWg85G3FkFEYHOEOlBrm9/SYA4kq2xL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rq4HWVZv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4SzUl53; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709562280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHKSpmj3DHeQFSFdUlKh9foXfF7ZumMJ/fAU2N/1zwg=;
	b=Rq4HWVZvvMHVESuVLtocY6NYdSEH/dE2Xp+N+TBjJXWY+OrV4fvA+rn/A7w0wJxyIjPIJf
	QTa6R4Eb1wokypLG7dbaBsi5i8zhEDi9LU9bptZXEFvUbnDBg6gerU+lhPZyaHxNZkAOsS
	mTzpDlnqKUJvNXA4L04jqwX3JzVkSU+ZGiPLJ/VCTxlTohnbPbe+z1CnQSRu+cce6LH9h0
	Sa370W8eh0GbAfR9vmQvwZNst0eSpaxdW8ZouLeirMq3p8RKUQs7fQG3uvIt9pLE0Wq4zp
	R3ZPirxAPzPASBf+TTa1N00LDKMiFM2cjj8a2CEL2UYtF0F7MnMFkxu8gmdXjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709562280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eHKSpmj3DHeQFSFdUlKh9foXfF7ZumMJ/fAU2N/1zwg=;
	b=I4SzUl53PxaS52fDo8iHgVdIzZ8oprWFwZxy69wJaPobECSxLSjV/QRnCr94seWE4mCgtZ
	MoFnmWnDVT3IBKAw==
To: Bitao Hu <yaoma@linux.alibaba.com>, Doug Anderson <dianders@chromium.org>
Cc: liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
 jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, yaoma@linux.alibaba.com
Subject: Re: [PATCHv11 2/4] genirq: Provide a snapshot mechanism for
 interrupt statistics
In-Reply-To: <3a89fafb-f62e-472f-b40b-8bf97954e9e3@linux.alibaba.com>
References: <20240228072216.95130-1-yaoma@linux.alibaba.com>
 <20240228072216.95130-3-yaoma@linux.alibaba.com>
 <CAD=FV=U1b+8atmju_w4eRmVKmSqjj6WCsy5EawYqj31fQ1kvrw@mail.gmail.com>
 <87plwdwycx.ffs@tglx>
 <3a89fafb-f62e-472f-b40b-8bf97954e9e3@linux.alibaba.com>
Date: Mon, 04 Mar 2024 15:24:39 +0100
Message-ID: <87wmqiulaw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 04 2024 at 20:00, Bitao Hu wrote:
>> +# Snapshot for interrupt statistics
>> +config GENERIC_IRQ_STAT_SNAPSHOT
>> +	bool
>> +
>>   # Support forced irq threading
>>   config IRQ_FORCED_THREADING
>>          bool
>
> I think we should follow Douglas's suggestion by making
> "config GENERIC_IRQ_STAT_SNAPSHOT" automatically selectable by
> "config SOFTLOCKUP_DETECTOR_INTR_STORM". This can prevent users
> from inadvertently disabling "config GENERIC_IRQ_STAT_SNAPSHOT"
> while enabling "config SOFTLOCKUP_DETECTOR_INTR_STORM".

The above is not even configurable by the user. It's only selectable by
some other config option.

> +# Snapshot for interrupt statistics
> +config GENERIC_IRQ_STAT_SNAPSHOT
> +       bool
> +       help
> +
> +         Say Y here to enable the kernel to provide a snapshot mechanism
> +         for interrupt statistics.

That makes is visible which is pointless because it's only relevant when
there is an actual user.

Thanks,

        tglx

