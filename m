Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20C175B7CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGTTSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:18:45 -0400
X-Greylist: delayed 102564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 12:18:44 PDT
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE60C171E;
        Thu, 20 Jul 2023 12:18:43 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 997932017A.A8505
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:136:242:ac11:f])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 997932017A;
        Thu, 20 Jul 2023 21:18:41 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1689880721;
        bh=wT2ajQ1kfewKJX422z0heJVj7aRddlYlx1HCTVwZE4A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Z+eww62MRpRKaRz8ezHJ1DsC+1LY3TWderO+uo20L7cESvuqyAZBXw1HTYCrUhdCH
         R8iUPb+OP+i+tVHBxdtB631/39v+fQSmHEcEsB503fcYFVHK8fN+YG/b2Z6h8XU8KG
         6R3uTNyRHt98BgIrmGDcaKhoVuXRNeS5W7NOiDxI=
Received: from [IPV6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda] (unknown [IPv6:2a02:1210:6c17:f000:af2b:c1b5:c15b:acda])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 543BCD4EC61AE;
        Thu, 20 Jul 2023 21:18:41 +0200 (CEST)
Message-ID: <818446ff-082f-7bef-eded-9fb14524db13@cs.kuleuven.be>
Date:   Thu, 20 Jul 2023 21:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] selftests/sgx: Store base address and size in test
 enclave
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230719142500.13623-1-jo.vanbulck@cs.kuleuven.be>
 <20230719142500.13623-3-jo.vanbulck@cs.kuleuven.be>
 <CU76ENNUAMHF.15D3KJY99C50@suppilovahvero>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CU76ENNUAMHF.15D3KJY99C50@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.23 19:29, Jarkko Sakkinen wrote:

>> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
>> index d3c7a39f4..bad963c79 100644
>> --- a/tools/testing/selftests/sgx/main.c
>> +++ b/tools/testing/selftests/sgx/main.c
>> @@ -182,6 +1827 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>>   	FILE *maps_file;
>>   	unsigned int i;
>>   	void *addr;
>> +	uint64_t encl_size_addr;
> 
> Should be the first declaration (reverse xmas tree order).

Will do

> I'd rename this as encl_end, as the current name is cryptic.

Thank you, agreed the current name is cryptic. However, encl_end is 
incorrect as this is the location in the enclave that stores the _size_ 
and the location itself is also _not_ at the end of the enclave.

I'll rename this in the next patch revision to encl_size_pt and make it 
of type uint64_t*, which seems more logical to me. Let me know if you 
prefer otherwise!

Best,
Jo
