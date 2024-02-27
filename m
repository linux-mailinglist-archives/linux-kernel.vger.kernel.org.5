Return-Path: <linux-kernel+bounces-83511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7440869A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753CA28FBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF07145B03;
	Tue, 27 Feb 2024 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQs8mbZk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqBCp3xt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139A145350
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048087; cv=none; b=kCzN7hboyf4nFM5diCzWXaBK4rc0EvYJmYharMhQ0mvFxXnyqYfpxbXkveeGsNmn8g5sOiCYZeVgG6zmR+loiS4+6VpIUVTvEU+HNIZwAsLjEAjDIS8BxdSQEx9eNTuMBI/P/Qy7BfAECqk0Lg5D0q0RCvRhjexh7IZSKveHfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048087; c=relaxed/simple;
	bh=EbVntXitC/QFIuP2/TmT2A2kRX1GNYhUcq+cwpTGYLQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W6BPEL1JINvgBrqU9ybtSmpFobI2jIKZ4WNdhs+4ivT1gMQVIMaxpdI+5OQ9ssFsMes5ogcso4QiNOF4zYUouK67sT2cJNySqQp235FwyXSn7416bISdBRmwbSQucTw71uhBYxZRIxlaeyvPSlPIK/KCecgJN2XE78BgGVRtaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQs8mbZk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqBCp3xt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709048083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WH0D6ST3RVYcVdf3hVGdNBojkUeGryYDXsdZakPzzPU=;
	b=YQs8mbZko2WXM8DEdp/aLmxhiX7ZdJT5jxFph/Ap2GqNMvT3Nmval6M9TXUTia9cbaGgGq
	NRoUKImNzzViZ4CdYmdo4SSpIAMNfkiSG669DlZC2axJQjJL4UcmCMOaV9mDzGThg4h/b+
	IBZG5at+88KRaV1zjyL1viXoYztsBFPqtO7F+03P7YyP8qFfZ/HSnDdye5iQkvzdzOv0zC
	qHtC4dHwzw48Bgz3qC0FJPwIsb2q+TN++JddWWSKfY0KoVXsheN8vRgYqwx7+ECSZZIOPI
	y0EWJXbSWmDeQL+dR51CRdX68JlaL31VXO/WkNQM8tRXO8HJgMbFvbV1SCbXHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709048083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WH0D6ST3RVYcVdf3hVGdNBojkUeGryYDXsdZakPzzPU=;
	b=rqBCp3xt+Clc1oLx2Fd15P8Quh+GEl7Kc1FruWJKSMt6ysYfOEtTwxdJsa1L4+oWz/aRnz
	2okVFSa/TiNkOEDA==
To: Catalin Marinas <catalin.marinas@arm.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@kernel.org>, Kees Cook <keescook@chromium.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Linux Kernel
 Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] vdso/datapage: Quick fix - use asm/page-def.h for ARM64
In-Reply-To: <Zd3nU4IbF0yYREt4@arm.com>
References: <20240226175023.56679-1-anna-maria@linutronix.de>
 <Zd3nU4IbF0yYREt4@arm.com>
Date: Tue, 27 Feb 2024 16:34:42 +0100
Message-ID: <87cyshapkd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 27 2024 at 13:44, Catalin Marinas wrote:
> On Mon, Feb 26, 2024 at 06:50:23PM +0100, Anna-Maria Behnsen wrote:
>> diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
>> index 7ba44379a095..5d5c0b8efff2 100644
>> --- a/include/vdso/datapage.h
>> +++ b/include/vdso/datapage.h
>> @@ -19,7 +19,11 @@
>>  #include <vdso/time32.h>
>>  #include <vdso/time64.h>
>>  
>> +#ifdef CONFIG_ARM64
>> +#include <asm/page-def.h>
>> +#else
>>  #include <asm/page.h>
>> +#endif
>
> I'm not a fan of guarding includes but I guess this would do until we
> merge Arnd's clean-up patches. FWIW:

Nobody is a fan of that, but the cleanup is not available tomorrow :)

