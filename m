Return-Path: <linux-kernel+bounces-16061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CC0823797
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706A51F25B39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8F1DA47;
	Wed,  3 Jan 2024 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T44+r7RH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A961DA38;
	Wed,  3 Jan 2024 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=dYc0x9K6lAapMkuTW+dEplfDBg0HI6A9abMFOxgyD0Y=; b=T44+r7RHqpam8QXhKjJycJ0eZ2
	omN01U+SvK5J5Q4ORKMh+wBxi+1/G6vJLivxWlhBisCtQEIAgHbqjDNgf5vqTqvW7eu5kkVGRTTGJ
	gBfT1AfyymL1kgtZLVScfY104BpXP1lIK3aU3sUXy5q4pfGFq/yJeF6FgNZeZB1PKLz4aP6EGTQq5
	bjUjjRjQrOlDnSlj2/7D+yXInZbjYj/1sApj0yE8RxZF69PBv4Lt1bOZga58cNNfDBegJhCpNDMh8
	q+iC0emInpTHTmUBHZ0wai4k/U6GvpftrUOFpH1whtV9+nH76pPbwrIIQwgUTsh/x5S2CHiSW3d4i
	NKPNzs3g==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9W4-00CEtr-2L;
	Wed, 03 Jan 2024 22:15:12 +0000
Message-ID: <f10aa2d0-da42-4824-ba30-926040574e70@infradead.org>
Date: Wed, 3 Jan 2024 14:15:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] kernel-doc: handle X86 DEFINE_IDTENTRY() variants
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-doc@vger.kernel.org
References: <20240102061700.3807-1-rdunlap@infradead.org>
 <87il4a9n37.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87il4a9n37.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 12:30, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Teach scripts/kernel-doc to handle the various DEFINE_IDTENTRY*() flavors.
>>
>> This corrects 2 kernel-doc warnings:
>>
>> arch/x86/entry/common.c:211: warning: expecting prototype for int80_emulation(). Prototype was for DEFINE_IDTENTRY_RAW() instead
>>
>> arch/x86/kernel/apic/apic.c:2170: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
>>
>> The script uses 'uname -m' to determine if it is running on i386 or x86_64
>> or something else. It also uses "ARCH=<arch>" in the environment variables
>> to allow for overriding the processed ARCH.
>>
>> Alternatively, we could remove the "/**" kernel-doc markers from those
>> 2 functions. There are 60 uses of DEFINE_IDTENTRY*() that I see and
>> only 2 of them have kernel-doc comments.
> 
> So I feel like I'm missing something here; the docs build should be the
> same regardless of the architecture it's running on, right?  So why do
> we need architecture checks in kernel-doc?

OK, I could do it that way...

> Honestly, it might be better to just remove the kerneldoc comments
> rather than add this much more complexity.

but I am just as happy with that solution. Thomas, is that OK with you?


thanks.
-- 
#Randy

