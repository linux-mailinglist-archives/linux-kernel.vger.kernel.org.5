Return-Path: <linux-kernel+bounces-69268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFAD85866E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CCDB20FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7C137C4A;
	Fri, 16 Feb 2024 19:54:53 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD46712A158;
	Fri, 16 Feb 2024 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708113292; cv=none; b=EiZWTRnuUiOre6QhFC66QV0LSbYrbZnsTvoaWNh/TT6PuLB6Pp/H+cxW9EKx0p+uzJ4JDOw7ASODHihPZZQffk2L/hrHxggbTpUU3RiSFSppZ2EOtgVKWnIpQLujy+xW4h3XYvt2r4mAOQoDluJcuCdi2Gk/0fT953C+SgejbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708113292; c=relaxed/simple;
	bh=B4jAjw1DiDA/xtjvyDVRYyJzCcc0H7WBMUUgQrnUfT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqUucYg6fmKZImx+hfg49cvR9PKfJHCpNnCqoJdKL7nbSDpig1GGMmfmcga/Nt8TbZ0+8fzepzNl43trPyt38VNhe1/Z5pUOEYGGdH8TufNoa8ehxfNWPhY0DYLx89UHau8VVaoP7pM/T05Jmozb8I8p+iZypFfqE55C7BajOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tc2Ll2C7Jz9y4gk;
	Sat, 17 Feb 2024 03:39:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 845EE140153;
	Sat, 17 Feb 2024 03:54:46 +0800 (CST)
Received: from [10.81.208.49] (unknown [10.81.208.49])
	by APP1 (Coremail) with SMTP id LxC2BwD37xhzvc9lL4ujAg--.27938S2;
	Fri, 16 Feb 2024 20:54:45 +0100 (CET)
Message-ID: <5b0ce7ef-3f4e-4c1b-a0b7-bf48e8169c4e@huaweicloud.com>
Date: Fri, 16 Feb 2024 20:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/8] KEYS: PGP data parser
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
 Dave Hansen <dave.hansen@intel.com>, =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?=
 <petr@tesarici.cz>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Xin Li <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ze Gao <zegao2021@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <jroedel@suse.de>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, David Howells
 <dhowells@redhat.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240216152435.1575-1-petrtesarik@huaweicloud.com>
 <20240216152435.1575-7-petrtesarik@huaweicloud.com>
 <Zc-Q5pVHjngq9lpX@casper.infradead.org>
 <5916fa3ac3d0ce2ade71e7ed1c9eb6923e374c1f.camel@huaweicloud.com>
 <Zc-s-42WoZhW_2c8@casper.infradead.org>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <Zc-s-42WoZhW_2c8@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwD37xhzvc9lL4ujAg--.27938S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr4DJw1kJry3try7CF1UGFg_yoWrGF1kpF
	WfKas0kF4ktr4fCr1qyw4xWryFvrs3tFy5Gr9YyryrAFn0gr12krySka1YgF9rKr4kGa1j
	qr4YvF9xCa4DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	J73DUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5pusAABs+

On 2/16/2024 7:44 PM, Matthew Wilcox wrote:
> On Fri, Feb 16, 2024 at 05:53:01PM +0100, Roberto Sassu wrote:
>> On Fri, 2024-02-16 at 16:44 +0000, Matthew Wilcox wrote:
>>> On Fri, Feb 16, 2024 at 04:24:33PM +0100, Petr Tesarik wrote:
>>>> From: David Howells <dhowells@redhat.com>
>>>>
>>>> Implement a PGP data parser for the crypto key type to use when
>>>> instantiating a key.
>>>>
>>>> This parser attempts to parse the instantiation data as a PGP packet
>>>> sequence (RFC 4880) and if it parses okay, attempts to extract a public-key
>>>> algorithm key or subkey from it.
>>>
>>> I don't understand why we want to do this in-kernel instead of in
>>> userspace and then pass in the actual key.
>>
>> Sigh, this is a long discussion.
> 
> Well, yes.  When you don't lay out why this is of value, it turns into a
> long discussion.  This isn't fun for me either.
> 
>> PGP keys would be used as a system-wide trust anchor to verify RPM
>> package headers, which already contain file digests that can be used as
>> reference values for kernel-enforced integrity appraisal.
> 
> The one example we have of usage comes in patch 7 of this series and is:
> 
> gpg --dearmor < <PGP key> | keyctl padd asymmetric "" @u
> 
> And you're already using two userspace programs there.  Why not a third?

I think this is very easy to answer. Why not extracting the public key 
from an x509 certificate in user space, sending it to the kernel, and 
using it for kernel module verification?

> gpg --dearmor < <PGP key> | ./scripts/parse-pgp-packets | keyctl padd asymmetric "" @u
> 
>> With the assumptions that:
>>
>> - In a locked-down system the kernel has more privileges than root
>> - The kernel cannot offload this task to an user space process due to
>>    insufficient isolation
>>
>> the only available option is to do it in the kernel (that is what I got
>> as suggestion).
> 
> This sounds like there's some other way of getting the key into the
> kernel which doesn't rely on userspace.  Or are you assuming that nobody
> bothered to trojan 'cat'?

Apologies for not providing the full information at once. I'm worried 
that would be too long, and pieces can be lost in the way. If it is not 
a problem, I'm going to clarify on request.

Ok, so, I'm not going to use cat to upload the PGP keys. These will be 
embedded in the kernel image, when the Linux distribution vendors build 
their kernel.

This works for both secure boot and trusted boot, since the kernel image 
can be measured/verified by the boot loader.

Another source for keys is the MOK database, since users might want the 
ability to verify their own software, which does not come from the Linux 
distribution.

I briefly anticipated the full picture, but I will tell it more explicitly.

The kernel, with the embedded PGP keys, will be able to verify the 
signature of the RPM package headers.

A component that I recently developed, the digest_cache LSM, has the 
ability to extract file digests from RPM headers and provide a simple 
interface for IMA, IPE, BPF LSM and any other component to query the 
calculated digest of files being accessed, and allow/deny access to them 
depending on whether the query is successful or not.

I already anticipate the question, if you have the problem parsing PGP 
keys, why don't you have the problem parsing RPM package headers?

I started finding a solution before this became available, and the only 
alternative I found was to formally verify my code. So, I took Frama-C, 
wrote the assertions, and verified that not only the code is 
functionally correct for correct sequences of bytes, but that there is 
no illegal memory access for any arbitrary sequence (unfortunately, I 
can prove for a small buffer size).

So, I'm probably going to do the same for the PGP parser, if this does 
not fly. But, we were very optimistic that this could be a valid 
alternative!

Roberto


