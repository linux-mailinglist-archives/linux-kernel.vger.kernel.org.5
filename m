Return-Path: <linux-kernel+bounces-37557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4183B199
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622F228546F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E2131E27;
	Wed, 24 Jan 2024 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GIqZE93q"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC2131749;
	Wed, 24 Jan 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122604; cv=none; b=kXiGXrjUljyKjJA4qiACp2CYoKCwh4xdnSbl8ZmV8F+V4/c7sJdbISoyd5YPLZBCHPCwHrx64Ewpzx+2s/IkR7Zt5uUuSyW52WjGez5KD0Pclqpkv8XlIs3LJEiURTN2Br7l7h/FgHWj7LksYS/gYkXwz0+zoFklmbaK2kNmFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122604; c=relaxed/simple;
	bh=fDgg8tctrn6emEkzshBFTOOEhEUdkdDODjW+wwsHgnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTLkl8GjTOvV7lVWT2sg0Nnv/MpH/xbTocWsOk0qW/z6IuJkEoKBkcuBsI6vAUfxHKMhepX+gw8UUuasbuMHji28QfWHRCXStN3B9CWUxrBSPOOTi+Vk2mjweBtsVBb4PUS6vsLv/Lu1Lscxl74gk+L6s4STAlSQOur7vbRo1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=GIqZE93q; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706122599;
	bh=fDgg8tctrn6emEkzshBFTOOEhEUdkdDODjW+wwsHgnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GIqZE93qwRmJH38eufPCxDmBlobXjUjtf9LO71Cd6BqdAn3+KILbVJqzUUuIQ+t8r
	 50enT+rOVnRPsPWiDuVJ3PfVyRZBTgwuYT5B6E+0DTnKDrb2Grg19TjQGhApoaFTiu
	 xOJFpG7FAwVXjMVJ9gYR2wFYFGm8oJ3tfx2cpp2UQWjW2hvynNgoFAPtnt/5Gsxt8J
	 1Xj7OqtUEM1zq3tQqe79mpmZu23v0vPbxppiZ4t86pVWE7sNana2YjbFjymgJ3CcF4
	 v5sDKO1R1TQ2gDlxEYeIspgjjzH1pYwT7MYrLH0fo/ocSoXqQvQYi2LvnDpJcFFgnI
	 53aOA3D0lNr4w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TKtTz2L4CzV7C;
	Wed, 24 Jan 2024 13:56:39 -0500 (EST)
Message-ID: <e4e1ee4d-b96c-47c7-bf81-5f4d3b0ce5dc@efficios.com>
Date: Wed, 24 Jan 2024 13:56:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] membarrier: riscv: Provide core serializing
 command
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 paulmck@kernel.org, corbet@lwn.net, mmaas@google.com, hboehm@google.com,
 striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-5-parri.andrea@gmail.com>
 <aabea058-0088-41bb-822a-402669f348bb@efficios.com> <ZbFahHxi5laA6CbI@andrea>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZbFahHxi5laA6CbI@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-24 13:44, Andrea Parri wrote:
>>> +# riscv uses xRET as return from interrupt and to return to user-space.
>>> +#
>>> +# Given that xRET is not core serializing, we rely on FENCE.I for providing
>>> +# core serialization:
>>> +#
>>> +#  - by calling sync_core_before_usermode() on return from interrupt (cf.
>>> +#    ipi_sync_core()),
>>> +#
>>> +#  - via switch_mm() and sync_core_before_usermode() (respectively, for
>>> +#    uthread->uthread and kthread->uthread transitions) to go back to
>>> +#    user-space.
>>
>> I don't quite get the meaning of the sentence above. There seems to be a
>> missing marker before "to go back".
> 
> Let's see.  Without the round brackets, the last part becomes:
> 
>    - via switch_mm() and sync_core_before_usermode() to go back to
>      user-space.
> 
> This is indeed what I meant to say.  What am I missing?

Would it still fit your intent if we say "before returning to
user-space" rather than "to go back to user-space" ?

Because the switch_mm(), for instance, does not happen exactly on
return to user-space, but rather when the scheduler switches tasks.
Therefore, I think that stating that core serialization needs to
happen before returning to user-space is clearer than stating that
it happens "when" we go back to user-space.

Also, on another topic, did you find a way forward with respect of
the different choice of words between the membarrier man page and
documentation vs the RISC-V official semantic with respect to "core
serializing" vs FENCE.I ?

Thanks,

Mathieu


> 
>    Andrea

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


