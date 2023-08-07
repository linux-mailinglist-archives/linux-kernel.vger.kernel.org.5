Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC7771D7F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjHGJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHGJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:50:44 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95831735;
        Mon,  7 Aug 2023 02:50:27 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: DAE6720281.ADC0B
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id DAE6720281;
        Mon,  7 Aug 2023 11:50:22 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691401822;
        bh=J2IDbMkMyJYC4UkTlO8Iif9l+y0kPHYA/UHVBxF5tZg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Qql9cBgf/D0KjIHEtzQ77NBTvuBJB21O8bbM0VZJLeWqUSkSnirMh6wA/w7EKWWLH
         kwYXQrrPDoXvkp9XJbxpFbUHdqYUyMa5bD9x3SBEIjy02vWCmw4N14z88CL/2OcFeA
         6U9zeGXhmsCjcDbhWBqUHqeXMDV7zFDfKREH+IZk=
Received: from [192.168.44.147] (ptr-94-109-231-173.dyn.orange.be [94.109.231.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 17D56D4F7A3BF;
        Mon,  7 Aug 2023 11:50:21 +0200 (CEST)
Message-ID: <a2dfe906-0794-09bd-793a-ef663b6f5cbb@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 11:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] selftests/sgx: Ensure expected enclave data buffer
 size and placement.
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-5-jo.vanbulck@cs.kuleuven.be>
 <ea91bcfdf3ae32fb0f7ac4f866c63dbf5bbaa0ab.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <ea91bcfdf3ae32fb0f7ac4f866c63dbf5bbaa0ab.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.23 06:22, Huang, Kai wrote:
> The "encl_buffer" array is initialized to 1 explicitly, which means it should be
> in .data section.  As Jarkko commented, can you add more information about in
> what cases it can be optimized away?

Yes it will indeed be in .data, but it may be reduced in size. See my 
reply to Jarkko's question for more information and a concrete example.

> I am not quite following how does "RIP-relative addressing" fix any problem?  Is
> there any hard relationship between "RIP-relative addressing" and the problem
> that you are having?

Good point. I think this is now cleared up with the -static-pie 
discussion in reply to you other point on patch 2/5.

Concretely, the reason -fPIE is needed is that otherwise global 
variables (i.e., not declared as static) would not be addressed 
RIP-relative, but as hard-coded addresses assuming the -static binary is 
loaded at a fixed address.
> So this change is not to fix the problem that "the compiler may optimize away
> the encl_buffer array", correct?

Correct, this fix ensures the expected location. As per my reply to 
Jarkko's question:

> 2. adding _attribute__((section(".data.encl_buffer"))) ensures that we can control the expected location at the start of the .data section. I think this is optional, as encl_buf always seems to be placed at the start of .data in all my tests. But afaik this is not guaranteed as per the C standard and such constraints on exact placement should better be explicitly controlled in the linker script(?) 

Perhaps I better split this into 2 separate patches?

The location-control may also not be needed in practice, but afaik that 
would be undefined C behavior (cf above) and better be avoided?

Best,
Jo


> 
>>
>> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
>> ---
>>   tools/testing/selftests/sgx/Makefile      | 2 +-
>>   tools/testing/selftests/sgx/test_encl.c   | 5 +++--
>>   tools/testing/selftests/sgx/test_encl.lds | 1 +
>>   3 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
>> index 50aab6b57da3..c5483445ba28 100644
>> --- a/tools/testing/selftests/sgx/Makefile
>> +++ b/tools/testing/selftests/sgx/Makefile
>> @@ -13,7 +13,7 @@ endif
>>   
>>   INCLUDES := -I$(top_srcdir)/tools/include
>>   HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
>> -ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
>> +ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIE \
>>   	       -fno-stack-protector -mrdrnd $(INCLUDES)
>>   
>>   TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
>> diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
>> index aba301abefb8..5c274e517d13 100644
>> --- a/tools/testing/selftests/sgx/test_encl.c
>> +++ b/tools/testing/selftests/sgx/test_encl.c
>> @@ -7,9 +7,10 @@
>>   /*
>>    * Data buffer spanning two pages that will be placed first in .data
>>    * segment. Even if not used internally the second page is needed by
>> - * external test manipulating page permissions.
>> + * external test manipulating page permissions. Do not declare this
>> + * buffer as static, so the compiler cannot optimize it out.
>>    */
>> -static uint8_t encl_buffer[8192] = { 1 };
>> +uint8_t __attribute__((section(".data.encl_buffer"))) encl_buffer[8192];
>>   
>>   enum sgx_enclu_function {
>>   	EACCEPT = 0x5,
>> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
>> index ca659db2a534..79b1e41d8d24 100644
>> --- a/tools/testing/selftests/sgx/test_encl.lds
>> +++ b/tools/testing/selftests/sgx/test_encl.lds
>> @@ -24,6 +24,7 @@ SECTIONS
>>   	} : text
>>   
>>   	.data : {
>> +		*(.data.encl_buffer)
>>   		*(.data*)
>>   	} : data
>>   
> 
