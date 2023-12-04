Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB80803B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjLDRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjLDRQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:16:14 -0500
X-Greylist: delayed 13022 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 09:16:20 PST
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D085083
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:16:20 -0800 (PST)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 7F9FE2FEC41;
        Tue,  5 Dec 2023 02:16:14 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 7F9FE2FEC41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1701710175; bh=R9d/LxjW9D+F/KWDSUaDSzC/pIpfAk44uZOjf3M81lg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QIXaCUu1NcJWlHNuY9H/SJzu5NBMP5d/02bfqVd57C+EumyiHMe/cvE0UkVxB7mUD
         X2QUDtXdVbcMNV6RD69ZRtRuBSppywfYGVsqG4Qtd5CXzKVrZpssdwHaESJuPa8aLE
         mFfmtVtqSzIjs2A4zfaWmQrrdB4sZMGOcirspMns=
Message-ID: <378cda77-98c0-4c7e-8e40-f765750f3c87@soulik.info>
Date:   Tue, 5 Dec 2023 01:16:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: optee: os: toolchains would include linux target macros likes
 __linux__
Content-Language: en-US
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, jerome.forissier@linaro.org
References: <bfba8d2c-646d-4d62-9f71-8e388e70f782@soulik.info>
 <CAHUa44FEkdtA+4AuoQnNEnObKzcUX3qkFD8iV8Z_pGJ7ZPWw2A@mail.gmail.com>
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <CAHUa44FEkdtA+4AuoQnNEnObKzcUX3qkFD8iV8Z_pGJ7ZPWw2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/5 00:34, Jens Wiklander wrote:
> Hi Randy,
>
> On Mon, Dec 4, 2023 at 2:39 PM Randy Li <ayaka@soulik.info> wrote:
>> Hello
>>
>> I wonder why Optee OS would use a linux target toolchains but not a bare
>> metal target(none os)?
> I guess it started with that we didn't want to download both one Linux
> and one bare metal toolchain. We need both AArch32 and AArch64
> versions so it doubles up.
>
>> gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
>> -dM -E - < /dev/null|grep linux
>> #define __linux 1
>> #define __gnu_linux__ 1
>> #define linux 1
>> #define __linux__ 1
>>
>> That makes hard to share a header files between Linux kernel and Optee.
>> We like to pass some structure in SHM, but optee don't have all those
>> Linux types likes <linux/types.h>.
> Surely you can define a .h file in a way that you can include it in
> both environments. We try to stick to ISO C.

Sometimes, we just need the macro functions like defined in 
<helper/bits.h> or <helper/align.h>

But in the Linux kernel environment, we don't have such header file.

Are there any safe environment macro that we could use to distinguish 
between Linux kernel and Optee TEE part(both OS and TA) ?

>> If optee didn't choose the toolchains for the Linux, we could easily
>> decide which part would use for Client Agent(Linux kernel) side or TEE
>> OS side.
>>
>> Why we don't use bare metal toolchains ?
> Feel free to do so.
>
> Cheers,
> Jens
