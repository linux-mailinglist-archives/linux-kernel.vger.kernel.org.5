Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449976333D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbjGZKQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGZKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:15:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622461995;
        Wed, 26 Jul 2023 03:15:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qObYg-0002RF-VA; Wed, 26 Jul 2023 12:15:55 +0200
Message-ID: <31ddce1d-6014-bf9f-95da-97deb3240606@leemhuis.info>
Date:   Wed, 26 Jul 2023 12:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Another regression in the af_alg series (s390x-specific)
Content-Language: en-US, de-DE
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        regressions@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690366557;77d5a048;
X-HE-SMSGID: 1qObYg-0002RF-VA
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

What's the status wrt to this regression (caused by c1abe6f570af from
David)? It looks like there never was a real reply and the regression
still is unresolved. But maybe I missed something, which can easily
happen in my position.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 13.07.23 10:03, Ondrej Mosnáček wrote:
> Hi,
> 
> It turns out that beneath the first bug [1] there was another one
> hiding. It seems to happen only on the s390x architecture when running
> the following libkcapi [2] reproducer:
> 
> kcapi -x 2 -s -c "gcm(aes)" -i 0d92aa861746b324f20ee6b7 \
>     -k f4a6a5e5f2066f6dd9ec6fc5169c29043560ef595c9e81e76f42d29212cc581c \
>     -a "" -t 5f24c68cbe6f32c29652442bf5d483ad -q ""
> 
> Frequently (but not always) it triggers an oops like this one:
> 
> [ 3986.766763] Unable to handle kernel pointer dereference in virtual
> kernel address space
> [ 3986.766774] Failing address: 0000000a00000000 TEID: 0000000a00000803
> [ 3986.766776] Fault in home space mode while using kernel ASCE.
> [ 3986.766778] AS:00000000a43a0007 R3:0000000000000024
> [ 3986.766825] Oops: 003b ilc:2 [#1] SMP
> <snip>
> [ 3986.766877] CPU: 0 PID: 271064 Comm: kcapi Tainted: G        W
>     6.5.0-rc1 #1
> [ 3986.767070] Hardware name: IBM 8561 LT1 400 (z/VM 7.2.0)
> <snip>
> [ 3986.767151] Call Trace:
> [ 3986.767153]  [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
> [ 3986.767160]  [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
> [ 3986.767166]  [<00000000a2a60888>] aead_recvmsg+0x478/0x698
> [ 3986.767169]  [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
> [ 3986.767175]  [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
> [ 3986.767177]  [<00000000a273e066>] vfs_read+0x26e/0x2a8
> [ 3986.767182]  [<00000000a273e8c4>] ksys_read+0xbc/0x100
> [ 3986.767184]  [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
> [ 3986.767189]  [<00000000a312ff30>] system_call+0x70/0x98
> [ 3986.767193] Last Breaking-Event-Address:
> [ 3986.767193]  [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]
> [ 3986.767198] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> This time the regression was bisected to:
> 
> commit c1abe6f570aff4b6d396dc551e60570d2f50bd79
> Author: David Howells <dhowells@redhat.com>
> Date:   Tue Jun 6 14:08:52 2023 +0100
> 
>    crypto: af_alg: Use extract_iter_to_sg() to create scatterlists
> 
> I can't see what the problem is with the commit, so I'm reporting here
> hoping that David or someone else can pick it up from here.
> 
> Cheers,
> Ondrej
> 
> [1] https://lore.kernel.org/linux-crypto/CAAUqJDvFuvms55Td1c=XKv6epfRnnP78438nZQ-JKyuCptGBiQ@mail.gmail.com/T/
> [2] https://github.com/smuellerDD/libkcapi/
