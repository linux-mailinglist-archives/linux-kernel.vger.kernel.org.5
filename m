Return-Path: <linux-kernel+bounces-35390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9C839044
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E86A287004
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB595EE97;
	Tue, 23 Jan 2024 13:36:00 +0000 (UTC)
Received: from welho-filter1.welho.com (welho-filter1b.welho.com [83.102.41.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAD5F546;
	Tue, 23 Jan 2024 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.102.41.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706016960; cv=none; b=BhvlyFu6FvCsslPFWjS+DpMMkiHdnJoF8Glr4kqaetpjXxOWMzhLR430Rv1vCwBnA5bL5HH8pjSU8dY2CZLJs2RbK09HVejm1Xln2axCqOxk3SUN9OYCTJZ8JYvPPYfYu7Cfu6LTOIpK/1qLBnNEmiM81CwfiKB7ltqr4E3bbs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706016960; c=relaxed/simple;
	bh=cFBQlzkCg1NzV3wANQZ9Afl/LsvBY/B9nxsgzPXXHP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueSOXqnzpZS+7oWcR5cdoI/N9D0L4zP6/2TcwSBzmsR9Ffsu6FMrHud0XzWQJ+Rrk88+P8ghR7ePytb3Is59uSFBlXxN7IejHlPApsTjnCN0T6xv9wbq2TrHuIoWu9ePysSWrGW6hUWgLozKlFxa3DQtgCDoBG9zLj0bYd8UAOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helsinkinet.fi; spf=pass smtp.mailfrom=helsinkinet.fi; arc=none smtp.client-ip=83.102.41.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helsinkinet.fi
Received: from localhost (localhost [127.0.0.1])
	by welho-filter1.welho.com (Postfix) with ESMTP id 3A5751EB3A;
	Tue, 23 Jan 2024 15:30:10 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from welho-smtp3.welho.com ([IPv6:::ffff:83.102.41.86])
	by localhost (welho-filter1.welho.com [::ffff:83.102.41.23]) (amavisd-new, port 10024)
	with ESMTP id 6wcG2ajQJusf; Tue, 23 Jan 2024 15:30:09 +0200 (EET)
Received: from [192.168.1.105] (82-181-33-216.bb.dnainternet.fi [82.181.33.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by welho-smtp3.welho.com (Postfix) with ESMTPSA id C26D62309;
	Tue, 23 Jan 2024 15:29:55 +0200 (EET)
Message-ID: <c915b476-784c-4d64-8063-f18837350568@helsinkinet.fi>
Date: Tue, 23 Jan 2024 15:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/82] m68k: Refactor intentional wrap-around calculation
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Liam Howlett <liam.howlett@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, linux-m68k@lists.linux-m68k.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-27-keescook@chromium.org>
 <CAMuHMdWa9tXQRHkkX-W+5n8kuCvEFZdsfStPtYGA0MZpTGX79Q@mail.gmail.com>
From: Eero Tamminen <oak@helsinkinet.fi>
In-Reply-To: <CAMuHMdWa9tXQRHkkX-W+5n8kuCvEFZdsfStPtYGA0MZpTGX79Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 23.1.2024 10.13, Geert Uytterhoeven wrote:
> On Tue, Jan 23, 2024 at 1:35 AM Kees Cook <keescook@chromium.org> wrote:
>> In an effort to separate intentional arithmetic wrap-around from
>> unexpected wrap-around, we need to refactor places that depend on this
>> kind of math. One of the most common code patterns of this is:
>>
>>          VAR + value < VAR
>>
>> Notably, this is considered "undefined behavior" for signed and pointer
>> types, which the kernel works around by using the -fno-strict-overflow
>> option in the build[1] (which used to just be -fwrapv). Regardless, we
>> want to get the kernel source to the position where we can meaningfully
>> instrument arithmetic wrap-around conditions and catch them when they
>> are unexpected, regardless of whether they are signed[2], unsigned[3],
>> or pointer[4] types.
>>
>> Refactor open-coded unsigned wrap-around addition test to use
>> check_add_overflow(), retaining the result for later usage (which removes
>> the redundant open-coded addition). This paves the way to enabling the
>> unsigned wrap-around sanitizer[2] in the future.
>>
>> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
>> Link: https://github.com/KSPP/linux/issues/26 [2]
>> Link: https://github.com/KSPP/linux/issues/27 [3]
>> Link: https://github.com/KSPP/linux/issues/344 [4]
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Liam Howlett <liam.howlett@oracle.com>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for your patch!
> 
>> --- a/arch/m68k/kernel/sys_m68k.c
>> +++ b/arch/m68k/kernel/sys_m68k.c
>> @@ -391,10 +391,11 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
>>
>>                  mmap_read_lock(current->mm);
>>          } else {
>> +               unsigned long sum;
> 
> "sum" sounds like this is a dummy variable, to please the third
> parameter of check_add_overflow()...
> 
>>                  struct vm_area_struct *vma;
>>
>>                  /* Check for overflow.  */
> 
> I agree with Liam: please drop the comment.
> 
>> -               if (addr + len < addr)
>> +               if (check_add_overflow(addr, len, &sum))
>>                          goto out;
>>
>>                  /*
>> @@ -403,7 +404,7 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
>>                   */
>>                  mmap_read_lock(current->mm);
>>                  vma = vma_lookup(current->mm, addr);
>> -               if (!vma || addr + len > vma->vm_end)
>> +               if (!vma || sum > vma->vm_end)
> 
> ... Oh, it is actually used. What about renaming it to "end" instead?

IMHO this is more descriptive:
+               if (check_add_overflow(addr, len, &sum))

than this:
+               if (check_add_overflow(addr, len, &end))

"sum" is IMHO quite obviously sum of the preceding args, whereas I do 
not know what "end" would be.


	- Eero

>>                          goto out_unlock;
>>          }
> 
> With the above fixed:
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> If you want me to take this through the m68k tree (for v6.9), please
> let me know.
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

