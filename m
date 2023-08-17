Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D7B77F311
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbjHQJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349546AbjHQJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:16:58 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2C63581
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:16:33 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 44AED480A94;
        Thu, 17 Aug 2023 05:16:02 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692263762;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=RI0tHOzOlHNkQ1F5oUIfvapy24sExHgDkvhR0J+nH4Q=;
 b=IqcIQnLNeanqRTTUPvCpK8wldtRtr7BbgqDxm64ilLXApTZF+lXWKF/jl9+5yaHrxKv+1
 fRyEJDQkQzTlqe+CQ==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692263762;
        cv=none; b=OWJBJTWSXgHJ3/ER9peQte2DBWJyu2/7NLoCEIw+Tar5lGTsjoBxPr0Fv2iExwTO3Oy3jNZkcunfiBH1VNo1j8tyFRug0sYcH/i4Lmur28pZoQLyFcw7CPEbivOwMY6BaCswQIrdMMD2DFKh/f1o05ujw4JCfK8mbDyODstG5dPYrrNHppQhzWMUBuMksRgZGs45q9Vh5FHW+FxN1rRX5sa6HS0HoRHOY9Ed4DBZ26W31EpecUEqu8xyq/HPLlDIB5ekVJprV7UVzbSHoNuPuR4Ubc6NUzToKj6DGx38qZi4Qr5Fc4Mnjbae/jp+tCdtj4J6MOYvcKlso3fWglVacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1692263762; c=relaxed/simple;
        bh=UeKODA6GpQi+D7TPxqYmN6LXdtGAzg74SPZ1W4MmfIQ=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:From:To:Cc:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=MwpYuNRSfmieGvPg6ydCPHv4M/T7qDqiHGupcFrQ8IAmO3RrOkF2GPLL+PZROLNv8pPHNmO7OpQKJ3DtBeWPzwaoIesTiHHgWnBfok7rnhOuMqHlgI/9W42X39VTt52/nseHuIrhYNyWs5RIyOKMJ47AFCmmEmjRX9S5KpsuSlNWiiT/x5XtlBhNtb1nBPiuisfFBVq/s7/gz2m4KFf+urxZyVoY9grEshsoUYDrU3oiMdaibjtiHdMXAZ60yqbTZuvKqG9lu84dE/PYrOxN9tSOE9yf+X6hOjXmtilkR4WVzoregJKLyaLP/cwKlTUEXA+/ACrFYNRV0/bDvv1tKQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692263762;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=RI0tHOzOlHNkQ1F5oUIfvapy24sExHgDkvhR0J+nH4Q=;
 b=nuxp9DV5cWpxjDTxFCFvDjI/rlkPK24J521jJAWFnSpP1LL+0Kbq3xwMNtLCDFw0/Ogkw
 4j28zzrmi9IGCXS5B6wJ1YI1/DxWVJ2Din2skyc13VbT7tJFrLbtH5GKUBxMONBLfSBw2EC
 LPc9+QFoFwARLpReTeRRQnk0zHi9j4m/aIuBLO7oLOwISqzQmtoL7IPfNYdh4j16WYe8xRa
 g3FVosgluv23by9eW/RxgFsMzQACBzwouMVhedNGk+q4ay0fxC7aim8FyITOcz8mIXMPTgx
 nc7K1wrIkjtWoo/bjxk146CWeW+ST7sUqRbWAaaPBy9l7PuERxyGJkaz84+w==
Message-ID: <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
Date:   Thu, 17 Aug 2023 05:16:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
From:   Genes Lists <lists@sapience.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, hch@lst.de, arnd@arndb.de,
        ricky_wu@realtek.com, gregkh@linuxfoundation.org
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
In-Reply-To: <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/23 21:30, Genes Lists wrote:

> On 8/16/23 17:04, Keith Busch wrote:
> ...
>> It sounds like you can recreate this. Since .10 worked and .11 doesn't,
>> could you bisect the git commits? It looks like it will take 7 steps
>> between those two versions.
>>
>> I don't think there are any nvme specific patches that could contribute
>> to what you're seeing, it's more likely some lower level platform patch
>> if a kernel change really did cause the regression. None of the recent
>> commits really stood out to me, so bisect is what I'd recommend.
> 
> Thank you
> 
> Bisect done - This is result:
> 
> ----------------------------------------------------------------
> 69304c8d285b77c9a56d68f5ddb2558f27abf406 is the first bad commit
> commit 69304c8d285b77c9a56d68f5ddb2558f27abf406
> Author: Ricky WU <ricky_wu@realtek.com>
> Date:   Tue Jul 25 09:10:54 2023 +0000
> 
>      misc: rtsx: judge ASPM Mode to set PETXCFG Reg
> 
>      commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.
> 
>      ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
>      to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
>      always set to HIGH during the initialization.
> 
>      Cc: stable@vger.kernel.org
>      Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
>      Link: 
> https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>   drivers/misc/cardreader/rts5227.c  |  2 +-
>   drivers/misc/cardreader/rts5228.c  | 18 ------------------
>   drivers/misc/cardreader/rts5249.c  |  3 +--
>   drivers/misc/cardreader/rts5260.c  | 18 ------------------
>   drivers/misc/cardreader/rts5261.c  | 18 ------------------
>   drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
>   6 files changed, 6 insertions(+), 58 deletions(-)
> 
> ------------------------------------------------------
> 
> And the machine does have this hardware:
> 
> 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A 
> PCI Express Card Reader (rev 01)
>          Subsystem: Dell RTS525A PCI Express Card Reader
>          Physical Slot: 1
>          Flags: bus master, fast devsel, latency 0, IRQ 141
>          Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
>          Capabilities: [80] Power Management version 3
>          Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
>          Capabilities: [b0] Express Endpoint, MSI 00
>          Kernel driver in use: rtsx_pci
>          Kernel modules: rtsx_pci
> 
> 
> 


Adding to CC list since bisect landed on

    drivers/misc/cardreader/rtsx_pcr.c

Thread starts here: https://lkml.org/lkml/2023/8/16/1154

Thank you,

gene

