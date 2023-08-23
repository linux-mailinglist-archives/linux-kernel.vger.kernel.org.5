Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D2786160
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjHWUZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbjHWUZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 16:25:13 -0400
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133E1A5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:25:10 -0700 (PDT)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id CDC57480A3D;
        Wed, 23 Aug 2023 16:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692822309;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=Ft03CV2PAvrd6Ou6FSTiA4u/1nSBwbfPWSQS7Uu0uW0=;
 b=VFSvEnctGQ7Pbrci/n7uhRb3x3mfT1DP+fWhgihksY/Dt2nSADWnR1OTH/PGLt2N9D3UW
 IkpK1Ui24LowyzZDg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692822309;
        cv=none; b=JLo8rB8M7KFPFp1d5FLvd/KTpSS3OIK2i3eMvAgXE0tXZvhiXt6Zg101c+yOu6p1Kfk7wzajT8Ey9yaV/6uJogj6Odo4Hb4k3Jy0QgOZFHPZ88417YbVF4mRwBRR4JkCwCOWvJgxRNc/voZj9iu0OIghueenlGmUY7z94PCVGsBuWwggyAjW46zYYJKI/1oX1OeTJ6sB+uRcpnYbEnrLski3NGWDf6Y19QRpfnzCWjuslBY1D6YOFYHSjEzXpIAwOXbFFMaX7QAp3QfWvd0K2EsKrUaVMOdjSN5nXaf+Vt5kPQYHwoXMsllCWP+vdLmW1Ov2rI1S66UJEqk9GYyT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1692822309; c=relaxed/simple;
        bh=1WiXPw6udIcWYNpBiU1SuaqbQe6zJ8KvPhSxwPE/kEY=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:To:Cc:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=kkD34ra9+s20M5pTmukJWy4wF1X05d8sFla80Huil8OGn/Eevpymrj0JlnvAzYMCHvC2Sm7RyEYE0b5/nzzcALTXtQ+6Lk3c4Fpy8XTHrbNnIAjfy1ks6I/YVwjQEcY/uf4/8XQ6eZDUQ1jPHBc7ng+5lixb/aLagHcv0xGcmxoaiJ48to89ygO5T1GfQ7a6I4dBKnXXnyEzMwSSMZrjW90OwrJLEueDI115FGMyPvMqr7oLqmc4MVc6ijknTbHc8tqdfYqO5SSXxBZrcL3nO7nOyjrAY1VReeWDxdPlkotrg3uBCvLAHa5x0+5C9eB9qnpziqLRb917SsICPchhNA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692822309;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=Ft03CV2PAvrd6Ou6FSTiA4u/1nSBwbfPWSQS7Uu0uW0=;
 b=IJyHNePtaGtm0bc3DsnSiZlVpi0UQIYZ0FzZk+IXr1wukn+0oSc/eD6bJZ2SIoXXMLHjO
 zWfbGL1LWs1UuZQq/aEMZb84q598X4oo6u/VBaZv4iJj/e//yr4DNaRY1f5MQmH5qliC7Rh
 jJdLWET0GoYxJj1DhDPxg/7PJlH0xd3oZhMPsFBCJXfv7Y5NFXB0frkax1inRdH36gKvgAF
 UYwugW8upS2bmKdlg7M6uuG8cwtJUI1RIHb/Cee07ZQmb4usU24j/WtlLVKRxh3hD7f7xr9
 Zpqhh15yHnFHR1KFo84XO2UB0/8r42m1zDPM05qpqzLfwuriy+8tp5cAOHvg==
Message-ID: <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
Date:   Wed, 23 Aug 2023 16:25:09 -0400
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Keith - thanks for reminder.

The card reader device itself is non-critical and very low priority.

What perhaps is a little more worrisome is the change in rtsx somehow 
prevented nvme from functioning normally and the machine then not 
booting (at least for some combination(s) of hardware).

If there is a simple fix to prevent nvme from being impacted by the rtsx 
driver that would be more than sufficient?

On the other hand 6.4.11 is out, and I'm guessing there isn't a lot of 
noise on this either. From what I've seen, 1 other user with same 
problem [1] and 1 with same card reader not having a problema [2].
And no 'me-too's in the kernel bugzilla [3] either.


Gene


[1] https://bbs.archlinux.org/viewtopic.php?id=288095
[2] https://bugs.archlinux.org/task/79439
[3] https://bugzilla.kernel.org/show_bug.cgi?id=217802



