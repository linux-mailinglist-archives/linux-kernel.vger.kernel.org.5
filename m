Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67E788890
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbjHYN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245125AbjHYN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:27:42 -0400
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [134.58.240.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652DB1FDF;
        Fri, 25 Aug 2023 06:27:36 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 3308E113.AEEDF
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 3308E113;
        Fri, 25 Aug 2023 15:27:33 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692970053;
        bh=Ok+sDm5y05OIlJ4pZdJgTo4C7On0MUNwp4IKLhYQYdk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CN1IY+J4fCQ4mWSuMDLTAS/gBHQY3qu187QDT2CdJe6JOoEativiLqZtxxwvep4PU
         BJbbG9enMmuXw10lkfI0C0C+8qVjqzFWzN56j84QNRuc0/KK0fEPzsK6K8QegJbQA9
         VKPTQsNk7xXWC+7ESRuwCVHlvGaieFczUtnovH1M=
Received: from [IPV6:2a02:1811:d31:8b00:b56b:371:2317:a8f2] (ptr-82s0fs8e775rpuqrs36.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:b56b:371:2317:a8f2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id E261FD4EBD175;
        Fri, 25 Aug 2023 15:27:32 +0200 (CEST)
Message-ID: <8c950b3d-0650-1a73-b7f7-eaddff2bc876@cs.kuleuven.be>
Date:   Fri, 25 Aug 2023 15:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/9] selftests/sgx: Handle relocations in test enclave
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-4-jo.vanbulck@cs.kuleuven.be>
 <90ad8638bc1c26505e33b3f436fdbc22c8d74ba9.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <90ad8638bc1c26505e33b3f436fdbc22c8d74ba9.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 03:11, Huang, Kai wrote:>> +/*
>> + * Symbol placed at the start of the enclave image by the linker script.
>> + * Declare this extern symbol with visibility "hidden" to ensure the
>> + * compiler does not access it through the GOT.
>> + */
>> +extern const uint8_t __attribute__((visibility("hidden"))) __encl_base;
>> +static const uint64_t encl_base = (uint64_t)&__encl_base;
> 
> I had hard time to understand this.  The __encl_base is a symbol which is a
> fixed value set by the compiler/linker.  encl_base has the real storage in the
> .data section, but the value is also build-time fixed.  IIUC we need some code
> to explicitly override it, but I don't see where it's done.  Perhaps I missed
> something?

Thank you for catching this. Such initialization would indeed have to be 
explicitly overridden at runtime and I somehow overlooked this (it seems 
I left the line to actually run the tests commented out after 
compilation in my test script for all versions; this is now fixed). 
Apologies for the confusion, my bad! I've reverted this back to an 
explicit (uit64_t)&__encl_base cast in the next patch iteration to avoid 
such confusion.

>> +
>> +typedef void (*encl_op_t)(void *);
>> +const encl_op_t encl_op_array[ENCL_OP_MAX] = {
>> +	do_encl_op_put_to_buf,
>> +	do_encl_op_get_from_buf,
>> +	do_encl_op_put_to_addr,
>> +	do_encl_op_get_from_addr,
>> +	do_encl_op_nop,
>> +	do_encl_eaccept,
>> +	do_encl_emodpe,
>> +	do_encl_init_tcs_page,
>> +};
> 
> Any reason it cannot be 'static'?

I tested static indeed also works and will include this in the next 
iteration.

>> diff --git a/tools/testing/selftests/sgx/test_encl.lds b/tools/testing/selftests/sgx/test_encl.lds
>> index 62d37160f..b86c86060 100644
>> --- a/tools/testing/selftests/sgx/test_encl.lds
>> +++ b/tools/testing/selftests/sgx/test_encl.lds
>> @@ -32,6 +32,8 @@ SECTIONS
>>   		*(.note*)
>>   		*(.debug*)
>>   		*(.eh_frame*)
>> +		*(.dyn*)
>> +		*(.gnu.hash)
> 
> This looks can be in a separate patch, because it's not directly related to what
> you are trying to fix.
> 
> But I don't want to make things unnecessarily complicated for selftests, so fine
> to me if you still want to keep it.  But if you do, perhaps you can add some
> justification to the changelog saying something like: opportunistically discard
> ".dyn*" and ".gnu.hash" which the enclave loader cannot handle.  Anyway, still
> better to make a separate patch for such purpose IMHO.

Thanks, splitting this off in a separate commit for the next iteration.

Best,
Jo
