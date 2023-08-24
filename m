Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C226786DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbjHXL30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbjHXL3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:29:17 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE7810FE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:29:12 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 93BDA480A94;
        Thu, 24 Aug 2023 07:29:11 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692876551;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=rZ2he4Mdtq8h71/ckeBbMY4eP2beNycVRu9+nDI/LtI=;
 b=DrfrxhNWjnzMfrCoWg2Dk1FFavXmVuyhT2QiUVrVf1OK2SSTQO3gRKFoVsVNGEpWbdQfB
 zB22vg5xXthZ2UTAA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692876551;
        cv=none; b=gzNGUBgNNvaWOc+LXN3p/iXArc6vIGM4jW04i0+a+KjAE7mNEuYLxxMlbnSi1EPOhJe2hDUUFWI9bVMFSIAHFEBPPOBJn1+pPam7iTtvrn3sz9CgyTQuBd6iLJ0pTzYxc8H56YcsTIV+ys69tV1COeMFnFPdNQ+3JmPM0gYlMKx+toIpuDKybVF2k5EcS9GaP99yn0HiH9JYXYJNZYDlz3Uc7sBigA7/Xz3DOko0/e3EnM8CjwrvTCO4YLFs0UdPfhAP2/A1qzgIxcwqEC6ehZ5R1dqrM5LXR5XWW2qaiW0mAcEItw6kFToDHgY0SUKe0uXpvgxg2WGiRcELg4YUug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1692876551; c=relaxed/simple;
        bh=Nx1A+sRwHAGlgn7Xne833IH4vtwjiO7q6mIStrHv0c4=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=unSXKCTynNKYf6G63Eo2da8ucVZlmCEsuSd5QzcD/L5YMOAw9JNxhxEkU26LCe1kpUPyxNvEq7AXOZDkH09wccjAJJ/uEgkkTWErem335CxZOMZZlDjGZR9DWZMNu6WpyjYUDjOJJfXGmLTiOzs1cR3+ZLpVILuRCVwj8Cejk0dU+mdVzL/SbkpIRLJ2gkwMf6Be8+NLo5Yt5NcWv0qvuTHJfTyrU/1eTQGUAkjJzC9KSkAW/aMZIa8JqGMo7YW6XGMl2r4mN9eFh3nXe0K0Da6/oYGiYuhU3oo2NrAo1ZXeB8IU9/isMkvea00mmHqI8PB1d933BntgXY+7Zp0NVw==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692876551;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=rZ2he4Mdtq8h71/ckeBbMY4eP2beNycVRu9+nDI/LtI=;
 b=ni41ligdeHxPrnyUVg36yLtjJ9UWdETxXi4kyPfLEKTlear0+2dysffJKfdRZxAS7fgnv
 3zC6My6IJrA2QqCO6pY1QIj7qb7YLiAB2OKjfFWIV9ud0FQY9uOzGsfo+94g3lqw36oznwW
 9Pi832aRf6nj2BZTuA42qhFUdr8MMesJVL9fZeSrd08O2seF8pA1GmO/Hfh6ldxaO/Fnetl
 qEUnAZP1x9+jFf19v5oJoQ/htlEOlrg/s8w6Lq+o0WbjROJLQSQSTkzSq7eM6zFZPn7+kVV
 qsC6QYjzAAfTjWLAHyS/AbMj0TMcNllO2dDhKnPKRmiEf531LBtFnaBGMfFg==
Message-ID: <b622dbe4-9b18-4406-b82d-942e3ec01ff2@sapience.com>
Date:   Thu, 24 Aug 2023 07:29:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, hch@lst.de, arnd@arndb.de,
        ricky_wu@realtek.com, gregkh@linuxfoundation.org
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
From:   Genes Lists <lists@sapience.com>
In-Reply-To: <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
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

On 8/23/23 13:41, Keith Busch wrote:
> On Thu, Aug 17, 2023 at 05:16:01AM -0400, Genes Lists wrote:
>>> ----------------------------------------------------------------
>>> 69304c8d285b77c9a56d68f5ddb2558f27abf406 is the first bad commit
>>> commit 69304c8d285b77c9a56d68f5ddb2558f27abf406
>>> Author: Ricky WU <ricky_wu@realtek.com>
>>> Date:   Tue Jul 25 09:10:54 2023 +0000
>>>
>>>       misc: rtsx: judge ASPM Mode to set PETXCFG Reg
>>>
>>>       commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.
>>>
>>>       ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
>>>       to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
>>>       always set to HIGH during the initialization.
>>>
>>>       Cc: stable@vger.kernel.org
>>>       Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
>>>       Link:
>>> https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
>>>       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>>    drivers/misc/cardreader/rts5227.c  |  2 +-
>>>    drivers/misc/cardreader/rts5228.c  | 18 ------------------
>>>    drivers/misc/cardreader/rts5249.c  |  3 +--
>>>    drivers/misc/cardreader/rts5260.c  | 18 ------------------
>>>    drivers/misc/cardreader/rts5261.c  | 18 ------------------
>>>    drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
>>>    6 files changed, 6 insertions(+), 58 deletions(-)
>>>
>>> ------------------------------------------------------
>>>
>>> And the machine does have this hardware:
>>>
>>> 03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A
>>> PCI Express Card Reader (rev 01)
>>>           Subsystem: Dell RTS525A PCI Express Card Reader
>>>           Physical Slot: 1
>>>           Flags: bus master, fast devsel, latency 0, IRQ 141
>>>           Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
>>>           Capabilities: [80] Power Management version 3
>>>           Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>>           Capabilities: [b0] Express Endpoint, MSI 00
>>>           Kernel driver in use: rtsx_pci
>>>           Kernel modules: rtsx_pci
>>>
>>>
>>>
>>
>>
>> Adding to CC list since bisect landed on
>>
>>     drivers/misc/cardreader/rtsx_pcr.c
>>
>> Thread starts here: https://lkml.org/lkml/2023/8/16/1154
> 
> I realize you can work around this by blacklisting the rtsx_pci, but
> that's not a pleasant solution. With only a few days left in 6.5, should
> the commit just be reverted?


Looks like here are more people having same problem than I was aware of 
earlier [1].

My recommendation now is to revert this.

thanks

gene

[1] https://bugs.archlinux.org/task/79439#comment221262


