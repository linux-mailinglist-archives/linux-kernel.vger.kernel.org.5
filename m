Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF3771DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHGKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHGKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:04:06 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7166F4;
        Mon,  7 Aug 2023 03:04:03 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 2FD5B2005B.AB1E1
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:144:242:ac11:2f])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 2FD5B2005B;
        Mon,  7 Aug 2023 12:04:01 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1691402641;
        bh=RmRz9LoqDZp6qH6qZw7V6w8nVwyQgi4xXe25hmaXnWE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fnQ6LKe8yf7cfK1Z+T99T9Gy5gZvwwdG0elfGQAbrFCcSfdlKZ26U9bMQb/+9xLQ5
         EGhKf8e+x0vDCeLuR4JFPnylkV1hZy2QWNqXDHaa3LEKDyUUI8uZKhWranrf6TNm1B
         pkAlmoeiwEq+Y0q7vjDaZmmdsUGPMQpxj5PPzoSs=
Received: from [192.168.44.147] (ptr-94-109-231-173.dyn.orange.be [94.109.231.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 86253D4F78D56;
        Mon,  7 Aug 2023 12:04:00 +0200 (CEST)
Message-ID: <a4e752f6-05c8-1fa1-54a4-f68191a617d1@cs.kuleuven.be>
Date:   Mon, 7 Aug 2023 12:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] selftests/sgx: Enclave freestanding compilation +
 separate linker options.
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-6-jo.vanbulck@cs.kuleuven.be>
 <CUE1SWKWLXPX.46QZ3KU4UAWL@seitikki>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CUE1SWKWLXPX.46QZ3KU4UAWL@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.23 21:22, Jarkko Sakkinen wrote:
> Should be split into two patches. 

Thanks, will do in the next patch revision.

> Please describe the motivation for the
> second paragraph in the patch, which adds '-ffreestanding'.

Even when passing -nostdlib, the compiler still assumes memset and 
memcpy are present [1].

I found that, when not passing '-ffreestanding', clang seems to optimize 
away the existing memcpy/memset implementations and errors with:

/bin/ld: test_encl.o: in function `do_encl_init_tcs_page':
test_encl.c:(.text+0x17e): undefined reference to `memset'

I will add this information in the next patch revision.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90701

Best,
Jo
