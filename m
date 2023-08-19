Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FEC781834
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344793AbjHSIEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344729AbjHSIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:04:18 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07956170E;
        Sat, 19 Aug 2023 01:04:15 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 8698F201C6.A9414
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:145:242:ac11:22])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 8698F201C6;
        Sat, 19 Aug 2023 10:04:13 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692432253;
        bh=pVJ4XvLSR0NdIOXzh1DnBoXVYNsx7fW/DomcH7RKC0k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UsERANQ6t9f/VvKSh3urjrvKz80nN446rqH/PjgsEBmUVLK/IiydizfYRwfWs0ghW
         urW3bN7zM5squuCLb0NAIW8E1xpBcpXWuqgTGYl6H7CjRTuRbWFemSd0V8zYyMOEUN
         9woEJTnh/PaXN5RB2y9vS/oKlSBgJ1pgSV3NL9sA=
Received: from [192.168.44.147] (ptr-94-109-233-233.dyn.orange.be [94.109.233.233])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 1A072D4E69702;
        Sat, 19 Aug 2023 10:04:11 +0200 (CEST)
Message-ID: <d6db0aed-8e08-d850-b952-d8b102624669@cs.kuleuven.be>
Date:   Fri, 18 Aug 2023 17:32:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/8] selftests/sgx: Handle relocations in test enclave
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, kai.huang@intel.com,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230808193145.8860-1-jo.vanbulck@cs.kuleuven.be>
 <20230808193145.8860-4-jo.vanbulck@cs.kuleuven.be>
 <CUP5FP8OHD3I.2MUE3TTRVNRTQ@suppilovahvero>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CUP5FP8OHD3I.2MUE3TTRVNRTQ@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.23 13:32, Jarkko Sakkinen wrote:
> What happens if I only apply 1/8 and 2/8 from this patch set?

This would work fine for gcc -O0/1/2/3, as encl_op_array happens to be 
locally initialized:

00000000000023f4 <encl_body>:
      /* snipped */
      2408:       48 8d 05 ec fe ff ff    lea    -0x114(%rip),%rax
# 22fb <do_encl_op_put_to_buf>
      240f:       48 89 45 b0             mov    %rax,-0x50(%rbp)
      2413:       48 8d 05 18 ff ff ff    lea    -0xe8(%rip),%rax
# 2332 <do_encl_op_get_from_buf>
      241a:       48 89 45 b8             mov    %rax,-0x48(%rbp)
      241e:       48 8d 05 44 ff ff ff    lea    -0xbc(%rip),%rax
# 2369 <do_encl_op_put_to_addr>
      /* snipped */

However, when compiling with -Os, the initialization proceeds through a 
prepared copy from .data with hard-coded (ie non RIP-relative) function 
addresses:

 > 00000000000021b5 <encl_body>:
 >      /* snipped */
 >      21bc:       48 8d 35 3d 2e 00 00    lea    0x2e3d(%rip),%rsi
 > # 5000 <encl_buffer+0x2000>
 >      21c3:       48 8d 7c 24 b8          lea    -0x48(%rsp),%rdi
 >      21c8:       b9 10 00 00 00          mov    $0x10,%ecx
 >      21cd:       f3 a5                   rep movsl %ds:(%rsi),%es:(%rdi)
 >      /* snipped */

> I'm just wondering why there is no mention of "-static-pie" here.

This patch 3/8 is expected to be applied on top of 2/8 which adds 
"-static-pie". While "-static-pie" is necessary to generate proper, 
position-independent code when referencing global variables, there may 
still be relocations left. These are normally handled by glibc on 
startup, but we don't have that in the test enclave, so this commit 
explicitly handles the (only) relocations for encl_op_array.

When only applying 2/8, gcc generates correct code with -O0/1/2/3, as 
the local encl_op_array initialization happens to be initialized in 
encl_body:

>> +extern uint8_t __attribute__((visibility("hidden"))) __enclave_base;
> 
> I'd rename this as __encl_base to be consistent with other naming here.
> 
> You could also declare for convenience and clarity:
> 
> 	static const uint64_t encl_base = (uint64_t)&__encl_base;
> 

Thanks, makes sense!

>> +
>> +void (*encl_op_array[ENCL_OP_MAX])(void *) = {
>> +	do_encl_op_put_to_buf,
>> +	do_encl_op_get_from_buf,
>> +	do_encl_op_put_to_addr,
>> +	do_encl_op_get_from_addr,
>> +	do_encl_op_nop,
>> +	do_encl_eaccept,
>> +	do_encl_emodpe,
>> +	do_encl_init_tcs_page,
>> +};
>> +
> 
> Why you need to drop "const"? The array is not dynamically updated, i.e.
> there's no reason to move it away from rodata section. If this was
> kernel code, such modification would be considered as a regression.

I dropped "const" to work around a clang warning:

test_encl.c:130:2: warning: incompatible pointer types initializing 
'const void (*)(void *)' with an expression of type 'void (void *)' 
[-Wincompatible-pointer-types]

But I agree dropping const is inferior and it's better to fix the 
incompatible pointer types as per below.

> I would also consider cleaning this up a bit further, while you are
> refactoring anyway, and declare a typedef:
> 
> 	typedef void (*encl_op_t)(void *);
> 
> 	const encl_op_t encl_op_array[ENCL_OP_MAX] = {

Thanks this is indeed cleaner. This also fixes the above clang warning.

> 
>>   void encl_body(void *rdi,  void *rsi)
>>   {
>> -	const void (*encl_op_array[ENCL_OP_MAX])(void *) = {
>> -		do_encl_op_put_to_buf,
>> -		do_encl_op_get_from_buf,
>> -		do_encl_op_put_to_addr,
>> -		do_encl_op_get_from_addr,
>> -		do_encl_op_nop,
>> -		do_encl_eaccept,
>> -		do_encl_emodpe,
>> -		do_encl_init_tcs_page,
>> -	};
>> -
>>   	struct encl_op_header *op = (struct encl_op_header *)rdi;
>>   
>> +	/*
>> +	 * Manually rebase the loaded function pointer as enclaves cannot
>> +	 * rely on startup routines to perform static pie relocations.
>> +	 */
> 
> This comment is not very useful. I'd consider dropping it.

Dropped.

> 
>>   	if (op->type < ENCL_OP_MAX)
>> -		(*encl_op_array[op->type])(op);
>> +		(*(((uint64_t) &__enclave_base) + encl_op_array[op->type]))(op);
>                                ~
> 			      should not have white space here (coding style)

Thanks for pointing this out.

> This would be cleaner IMHO:
> 
> void encl_body(void *rdi,  void *rsi)
> {
> 	struct encl_op_header *header = (struct encl_op_header *)rdi;
> 	encl_op_t op;
> 	
> 	if (header->type >= ENCL_OP_MAX)
> 		return;
> 
> 	/*
> 	 * "encl_base" needs to be added, as this call site *cannot be*
> 	 * made rip-relative by the compiler, or fixed up by any other
> 	 * possible means.
> 	 */
> 	op = encl_base + encl_op_array[header->type];
> 
> 	(*op)(header);
> }

Thanks, this is indeed much cleaner! Including this in the next revision.

>> +		/* Dynamic symbol table not supported in enclaves */
> 
> I'd drop this comment.

Dropped.
