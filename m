Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DC75A6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjGTGx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGTGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:53:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DE1719;
        Wed, 19 Jul 2023 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689836018; x=1690440818; i=deller@gmx.de;
 bh=4/kNM7Ipq1uMdYYgZfRESf75NFD7moYKZ1xfRPrX+Wo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IkmBVt9kZs/WnnGYg5w4ZRGbh7rQDJX7WnqZOGcoXY4OLd0KUSGA0CDG9h110AplxJQ+iy3
 IJ2xxVJx0ycAcAg+bCnmW4nkWBhNGU0Yx/3+MgGsNE6Msna2lqVK2YkrItc0c6txeoM8+nktN
 F2h5z4ZXOAkse2jGVRWlIPhmOZiQW34vIs8sflyTaNsAF7nK8i0beh+SsUPpQG2VCZvpHdFa0
 Bpsq7N8de6ExE8QyviyRo0Ge1N5Ee+/TaqZqK/INuTtoc0Irc2ZEOhK6u0soruK8vwHhD4qej
 yf9bDduMr2LXMFpXtmWbYAHO3hJ4FdzhViXCDCgeo3HrolnRoK7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.153.9]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1qXYbL0ceH-00OYrE; Thu, 20
 Jul 2023 08:53:38 +0200
Message-ID: <342d7c94-d04b-342e-7540-4aee6d8b03f5@gmx.de>
Date:   Thu, 20 Jul 2023 08:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] arm: Fix flush_dcache_page() for usage from irq
 context
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
References: <20230524152633.203927-1-deller@gmx.de>
 <20230524152633.203927-2-deller@gmx.de>
 <3e131821-7665-47f0-a8a6-44b3e4d7a88a@app.fastmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <3e131821-7665-47f0-a8a6-44b3e4d7a88a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vQJeSZTaMhJL5siCKBjdTopfh4h2nv/z3YKFFjaXxrYqG1oG3vZ
 ao6IO6gkeSQN9GA3skzm1YYv3ZOF+IzzEZbNbd//3I/9yxRdwJmB75UuExvZZWXqf9kBJSC
 NR5ghRe+wFg3DY/7LHwkrN/5Pc1xz+6dvoz5ZNppE5qO0CnCD9ECvheCjGvovWk0IC6SABS
 5rMCRQ9f100U19+0hEoUA==
UI-OutboundReport: notjunk:1;M01:P0:YlCFrtpXflE=;3hRRdr4s1RIEwyL0Sdqrqev5V6Y
 9zfxiJf7oRMumdIdxCJRcEuPA8ue/2FbUmCAweXtjTI/qmqsT6FyiHUugSiMAtYBzyrWa8fvk
 YS0IK75AlfO1PmzVGBgVFYL0yjH2ZsKWibqMCvXbMvQBwAMsePxggLQZ7pLSsEO66thoS42/1
 oBVol9zsO+ujTYK1AG9BaSgIEeLyUPnblfG4gnOokY0VqLmIyAtM7w6Kfzuen7eZE/uHD13Fs
 zzVDFyUNbeLmNhhDifRA04TYnd/zLdkB0q4oYW5ORp/AczfqSrmx2pPZz3UOy5eIhEqmeEoMg
 dVtXxNXHvPUuaq93fzALxGHzbkAP54ZhWZkul02W8AikceDIhGJWIdLX9ZJr3zHakdy/r9kAc
 jM7hSOnPMq5qjW2ZwQr95ztsaiGlLXrZQZ+ElDcShnJZnrmC+42jzVxjPZ4RsOk5u1Fr+8mNG
 fUeAMEEzXfA9aU3SV2bZP46IDzIoSEveAfOz7FDSfaFn++czSMzmdFA18FQKSLGKKmKB/L2/F
 PZ9YCO+XhLVPWjMhrek7vBK8KfcpwO1jwwEfUH2Y8cSk8LViDK+9rDgWyKTlvMRNIeR5JBb7o
 QEpK4xHiB3r/5vY0ouU9gPP+kR3lrfnSjwt3LrOVBlqro9OQkZ2ABO4F4gZIxMqgSu9P2x4Zv
 LLC2FediH5iyACXuPDLf+b/gDwAqxbnzchvGJCGD5/7uZ6DdieIdad6EYfYXDLpnZLVAmNv0o
 mlmQKMgQmPUU7S9h4T0Bl++zuJo2vAzxLkHd2SOgj6PczyP8gLTClfL1kRt/fF7oZCqiy+nN1
 B6Ezd/yG1eox3/WByg1QQc71CKJDGDPJ2E//1prvMHtg12ivY/ABEKaRgpGgfBo/FGd+X1g4q
 1CTJBylZBC4fXEe7AYd+9e4Zhte8ZmEZqD+1T5TOFYtxg6dvdbuvT4HajEReo03oQ42CZ6iI8
 vU75KaiJIoTQiu2nL+eF/3rxqQE=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 22:00, Arnd Bergmann wrote:
> On Wed, May 24, 2023, at 17:26, Helge Deller wrote:
>> Since at least kernel 6.1, flush_dcache_page() is called with IRQs
>> disabled, e.g. from aio_complete().
>>
>> But the current implementation for flush_dcache_page() on ARM
>> unintentionally re-enables IRQs, which may lead to deadlocks.
>>
>> Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
>> for the flush_dcache_mmap_*lock() macros instead.
>>
>> Cc: Russell King (Oracle) <linux@armlinux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> Cc: stable@vger.kernel.org
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
>  From what I can tell, the behavior in aio_complete has been
> there for over 10 years, since 21b40200cfe96 ("aio: use
> flush_dcache_page()"). Others may have done the same already
> back then.

gentle ping...
I think this patch hasn't been picked up yet for arm.

Helge
