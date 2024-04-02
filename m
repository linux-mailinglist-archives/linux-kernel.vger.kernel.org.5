Return-Path: <linux-kernel+bounces-127499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF9B894C84
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DB61F21734
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDB3A1A3;
	Tue,  2 Apr 2024 07:18:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB52C6B3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042307; cv=none; b=cxXJlxlxfouHPYwwv0d86AAroLccfPgyj7sT7/anDdLcnS43eLW+MZScH2ji6Kn9QHXscF3UtwEmGkRr9vHTkzKVSGOJZdLugerjJh3KluGjQklShHOkWbev0BOb+m4fcmKL5qaqrzPnm0XYuCCbQR/xQWyIbyf8OCAyEKCnR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042307; c=relaxed/simple;
	bh=Z+zJUqfPOF+jbZ01WAERHLtrTeG63ePwxKaJCB3WiPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEDk2PfYeLqOC7LDIA/tXbT2JlZXRAQviZJyLE/SP1KurKvmJEzZRjO5IIIS9SLjfjcw3oIi8Bo7g5mcrYzTD2NYNJHb0zpD3j6MNl8CyyIvxikw2TJIqNa3FQBKkNhqMgRFFqofVb+zKX2zrFFAlBo9v/nbgf722ZuL9hx43HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF319C433C7;
	Tue,  2 Apr 2024 07:18:25 +0000 (UTC)
Message-ID: <dd659c33-59ed-4a39-a260-aac45cd5b408@linux-m68k.org>
Date: Tue, 2 Apr 2024 17:18:23 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Avoid CONFIG_COLDFIRE switch in uapi header
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
References: <20240219160126.510498-1-thuth@redhat.com>
 <6f3b246e-7417-4455-abe4-ca3b42fdda4c@linux-m68k.org>
 <4824192b-5573-4246-a47c-ad6249e2900e@app.fastmail.com>
 <c2832612-9a67-4dc1-a8c2-4cc026b14567@redhat.com>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <c2832612-9a67-4dc1-a8c2-4cc026b14567@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 23/2/24 18:13, Thomas Huth wrote:
> On 20/02/2024 16.09, Arnd Bergmann wrote:
>> On Tue, Feb 20, 2024, at 15:13, Greg Ungerer wrote:
>>> On 20/2/24 02:01, Thomas Huth wrote:
>>>> We should not use any CONFIG switches in uapi headers since these
>>>> only work during kernel compilation; they are not defined for
>>>> userspace. Fix it by moving the struct pt_regs to the kernel-internal
>>>> header instead - struct pt_regs does not seem to be required for
>>>> the userspace headers on m68k at all.
>>>>
>>>> Suggested-by: Greg Ungerer <gerg@linux-m68k.org>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    v2: Move the struct instead of changing the #ifdef
>>>>
>>>>    See previous discussion here:
>>>>    https://lore.kernel.org/lkml/6e3f2a2e-2430-4b4f-9ead-d9a4d5e42713@linux-m68k.org/
>>>
>>> I am fine with this. FWIW the following architectures do
>>> not define pt_regs in their uapi/ptrace.h header either:
>>> arc, arm64, loongarch, nios2, openrisc, riscv, s390, xtensa
>>> Though quite a few of them have a user_pt_regs instead.
>>>
>>> So for me:
>>>
>>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>>>
>>> Geert, Arnd, do you have any thoughts on this?
>>
>> It clearly doesn't change the ABI, so that part is fine.
>>
>> If asm/ptrace.h is included by some userspace tool to
>> get the definition, it might cause a compile-time error
>> that needs a trivial source change.
>>
>> This could be needed for ptrace (gdb, strace) or signal
>> handling and setjmp (libc), though it's more likely that these
>> already have their own copies.
> 
> If we still feel unsure, we should maybe rather go with v1:
> 
>   https://lore.kernel.org/lkml/20231110103120.387517-1-thuth@redhat.com/
> 
> ?

We have not had much movement on this.
So... I am confidant that v2 is good, but lets err on the side of caution first up.
I have applied v1 to the m68knommu git tree, for-next branch.

Thanks
Greg



