Return-Path: <linux-kernel+bounces-67382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E49D856AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C33289FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFBF13666F;
	Thu, 15 Feb 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="ax+RyCnx"
Received: from cmx-torrgo001.bell.net (mta-tor-005.bell.net [209.71.212.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20095136663;
	Thu, 15 Feb 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.212.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017245; cv=none; b=Iwq8pRm1yV5tHB9dhB//S2Kw4fzNdeiFZiW8P7aZT6TBThmXFCLb1Rsls6Hlsd/BEqW4nRRLByZx01EaI6AqYwdbAqEIr10cFyEw6SJ9dOcyMSvJMli0ap0saw4zq8+6wYJcgec6K0w9PgFtgqxBuEU+iEUsuiJnJ35Dv5W+oeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017245; c=relaxed/simple;
	bh=wMQZAjVaywaNaVIoUDPK4cu/c4mz5snPDQld1MSr6hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZtJvty7MuZzzYgscHOx3JpJ5+HDzB8+yr2vWmN/bNjC4fBhMfRYjeWixWtVeIlqnOEMAu8dg4A0gQgL7JIDrA8CwxASLvKCK34aZpuTxdmSuZjOo15jz2IwsByp67i72Jh7JCZ+mGfA/eP0nvJc4SKJgywO+WlrU0w4sbTUg5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=ax+RyCnx; arc=none smtp.client-ip=209.71.212.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1708017243; 
        bh=iqJuGfFuA5gl5PeHMO0DsPwaamL0d2WArzsU05LdegI=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=ax+RyCnxTJG+jloMAeHNf8E02fuyDq5LinzDY6vhDyHMsgyUueMfN6k5sgL2eSibjfrZgZhGLjN0G5egWaScQmYvomyk4pQipN2877aJzyBHnKiO1UNYCg2/btjAQuJBW7tnxiVQfkX87YDvAxlHBKlbUDq6lecbvzBaeL3qdvfZU1z6BddOBYq+jk7P/siJDaGRkBfCXsGW2t64bGjQPDjfsn1ydPBp9Ms5AuBnXsDZwObrbMssZDETlM6icA56DHJ4UdWChx96FkgghZCvs68C9TKXe/VULj1KsuW7lI6f6V+94F/zcDAVGPWyBbtT9JdycyX5o3lEmmVTx0/FTQ==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 65CD68AA000F769D
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceugffnnfdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhhnhcuffgrvhhiugcutehnghhlihhnuceouggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeekudelfeehieduueejvdekleefffehudefgfejgeekieduleeftdejhffghfeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedugedvrdduvdeirdduuddvrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddvrdeglegnpdhinhgvthepudegvddruddviedrudduvddrvdeffedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepffgrvhhiugdrnfgrihhghhhtsegrtghulhgrsgdrtghomhdprhgtphhtthhopeflrghmvghsrdeuohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgt
	phhtthhopegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdprhgtphhtthhopeguvghllhgvrhesghhmgidruggv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.112.233) by cmx-torrgo001.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 65CD68AA000F769D; Thu, 15 Feb 2024 12:13:42 -0500
Message-ID: <378dba2c-ebc2-404d-a0e8-f507a24ef6d2@bell.net>
Date: Thu, 15 Feb 2024 12:13:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>, Guenter Roeck <linux@roeck-us.net>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <1d5e059e-5b31-415d-ae41-593415812e94@bell.net> <Zc2GfgiCpevtKTtS@ghost>
 <11fff7fe-ec4c-4340-a67f-d1d54d0712d8@roeck-us.net> <Zc4veRSmxHHqu/bB@ghost>
 <0fa4d53a-6ce7-4f44-81b2-86282f0b9451@roeck-us.net> <Zc5A+c0gmxtygNIa@ghost>
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <Zc5A+c0gmxtygNIa@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-15 11:51 a.m., Charlie Jenkins wrote:
> On Thu, Feb 15, 2024 at 08:30:22AM -0800, Guenter Roeck wrote:
>> On 2/15/24 07:36, Charlie Jenkins wrote:
>>> On Thu, Feb 15, 2024 at 12:56:13AM -0800, Guenter Roeck wrote:
>>>> On 2/14/24 19:35, Charlie Jenkins wrote:
>>>>> On Wed, Feb 14, 2024 at 10:00:37PM -0500, John David Anglin wrote:
>>>>>> On 2024-02-14 8:58 p.m., Guenter Roeck wrote:
>>>>>>> Specifically: Yes, the carry/borrow bits should be restored. Question is
>>>>>>> if the Linux kernel's interrupt handler doesn't restore the carry bits
>>>>>>> or if the problem is on the qemu side.
>>>>>> The carry/borrow bits in the PSW should be saved and restored by the save_specials
>>>>>> and rest_specials macros.  They are defined in arch/parisc/include/asm/assembly.h.
>>>>> Why would they be needed to be restored in linux? The manual says "The
>>>>> PSW is set to the contents of the IPSW by the RETURN FROM INTERRUPTION
>>>>> instruction". This means that the PSW must be restored by the hardware.
>>>>>
>>>>> We can see the QEMU implementation in:
>>>>>
>>>>> rfi:
>>>>> https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/sys_helper.c#L93
>>>>>
>>>>> handling interrupt:
>>>>> https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/int_helper.c#L109
>>>>>
>>>>> However the implementation appears to be faulty. During an RFI, the PSW
>>>>> is always set to 0x804000e (regardless of what the PSW was before the
>>>>> interrupt).
>>>>>
>>>> Not sure if I agree. The interrupt handler in Linux is the one which needs to set
>>>> IPSW. Looking into the code, I agree with Dave that the tophys macro seems to
>>>> clobber the carry bits before psw is saved, so they can not really be restored.
>>>> The only issue with that idea is that I can only reproduce the problem with
>>>> an interrupted ldd instruction but not, for example, with ldw. This is why it
>>>> would be really important to have someone with real hardware test this.
>>>>
>>>> Thanks,
>>>> Guenter
>>> Yes, we definitely feedback from somebody with access to hardware, but I
>>> do not understand how "The PSW is set to the contents of the IPSW by the
>>> RETURN FROM INTERRUPTION" could be interpreted as anything except that
>>> the hardware is expected to over-write the contents of the PSW during
>>> the rfi.
>>>
>> Sure, I absolutely agree. But that assumes that IPSW is set correctly
>> in the Linux interrupt handler. We do know that something odd happens
> The manual defines the saving of PSW as the responsibility of the
> hardware as well: "When an interruption occurs, the current value of the
> PSW is saved in the Interruption Processor Status Word (IPSW)". I don't
> think this should be interpreted to mean that a software interrupt
> handler is required to save the IPSW.
The IPSW (cr22) is saved by save_specials to regs->gr[0].  It is modified in various
places when an interruption is handled.  In the case of emulate_ldd, we have

         /* else we handled it, let life go on. */
         regs->gr[0]|=PSW_N;

This is supposed to nullify the faulting ldd.  I've yet to find where the carry bit is getting
set in the PSW.

There is a gap between where the hardware sets IPSW and where it is saved to the stack
in save_specials.  tophys might clobber the IPSW is there is a double fault.  But it seems
more likely that regs->gr[0] is getting clobbered somehow.

Dave
>
> - Charlie
>
>> when an unaligned ldd is encountered. At least for my part I don't know
>> if the problem is in emulate_ldd() in the Linux kernel or in the ldd
>> implementation and trap handling in qemu. I do know (from my logs)
>> that qemu does see the correct PSW/IPSW values, because they do
>> show up correctly in the Linux kernel when running the qemu emulation.
>> Only it somehow gets lost when the Linux interrupt handler returns.
>>
>> Thanks.
>> Guenter
>>


-- 
John David Anglin  dave.anglin@bell.net


