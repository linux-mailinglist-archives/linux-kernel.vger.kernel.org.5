Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13578F624
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbjHaX0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHaX0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:26:14 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be (icts-p-cavuit-3.kulnet.kuleuven.be [134.58.240.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C9EE54;
        Thu, 31 Aug 2023 16:26:08 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: C24182017B.AE84F
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:139:242:ac11:1e])
        by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id C24182017B;
        Fri,  1 Sep 2023 01:26:06 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693524366;
        bh=6EILQpN+PATT3WfrGpfJSLOOctF4Xu7IVJo/9l/bIg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=l8jF3isenjlU8SgIhCNSVMfmToNatRJSote0lDegkZ3YA2NIDVBnI7OiNVNghWxYn
         y6f8g97tI1TvDyyOfIhuu4t/T2glNTgUgHgD4Qo8gxjpt6mXZmZlT+iLx5tCKgiEP1
         dZDdRBFRgdyXqebFrujsMSEcLpbQBrZnuKA4sLUI=
Received: from [IPV6:2a02:1811:d31:8b00:7b:ca5b:4c4b:289a] (ptr-82s0fs5n58q1yp1l9ju.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:7b:ca5b:4c4b:289a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 88BC8D4F61BC1;
        Fri,  1 Sep 2023 01:26:06 +0200 (CEST)
Message-ID: <55ef3859-774e-1bd3-0e2a-5105cbf0d33a@cs.kuleuven.be>
Date:   Fri, 1 Sep 2023 01:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 08/13] selftests/sgx: Handle relocations in test
 enclave
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230831134144.22686-1-jo.vanbulck@cs.kuleuven.be>
 <20230831134144.22686-9-jo.vanbulck@cs.kuleuven.be>
 <c68971b3b9d4962d30fed845e8796ad028a65a74.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <c68971b3b9d4962d30fed845e8796ad028a65a74.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.23 01:13, Huang, Kai wrote:
>> encl_body:
>>      /* snipped */
>>      lea    encl_op_array(%rip), %rcx
>>      lea    __encl_base(%rip), %rax
>>      add    (%rcx,%rdx,8),%rax
>>      jmp    *%rax
> 
> call *%rax
> 
> ?
> 
>>      ret

Good catch, but this is indeed the code as generated with gcc -Os (for 
readability). It seems the compiler choose a JMP over a CALL (as the 
stack is untouched and the callee can immediately return to the caller).

Somehow, the compiler still emits a RET after the JMP (which is not 
supposed to return here) though. I agree this is unnecessarily confusing 
and can simply remove the RET from the commit message.

Best,
Jo
