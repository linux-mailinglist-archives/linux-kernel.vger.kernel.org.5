Return-Path: <linux-kernel+bounces-37477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A94683B0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0CF1C22D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE612A15D;
	Wed, 24 Jan 2024 18:00:58 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A260BA8;
	Wed, 24 Jan 2024 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119257; cv=none; b=tsou6XrC50gK/2rG5jfpki81mUS3h64QN9x5w5rHTKs7PbSZNQk7dTCq69TqGU+yrXv6jXeTdz3IYrbPhFnCPufSht/qTBswMmQItc6cwfeVA/Jzo19/pIKr/mnN40BPhH5ZPtI0ro5FdOxlP3RqABMGk0KPRSgzFC+B1qLG1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119257; c=relaxed/simple;
	bh=y+GV44TKGAZRCfEif+mWQgS9naJ3wDiKRpCKLjDslXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAFuu3Tf67ob2TGskA4wJ9E0vK/3k0SJNQbDJPB3xmarjFan6FA9Zrx/wv/CQYMK547JAAd9OeCBboATvfWccIYtdzAfWgbjQMwSOpYQSW/O6oDJ4RRe8jaWPS2gOlMt8uM83v0qbOPcUK/Xh8P3ugNfV3pgmcnUHKPm+JBv5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TKsFT2hF3z9t3B;
	Wed, 24 Jan 2024 19:00:45 +0100 (CET)
Message-ID: <e6f4e681-63ca-4d85-b050-e215f86a63bf@v0yd.nl>
Date: Wed, 24 Jan 2024 19:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] Disconnect devices before rfkilling adapter
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240107180252.73436-1-verdre@v0yd.nl>
 <CABBYNZ+rDo6ftN1+HdeWm6gij14YF_19WGRP7LM4Vjw-UWOTng@mail.gmail.com>
 <7cee4e74-3a0c-4b7c-9984-696e646160f8@v0yd.nl>
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <7cee4e74-3a0c-4b7c-9984-696e646160f8@v0yd.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 1/8/24 11:25 PM, Jonas Dreßler wrote:
> Hi Luiz,
> 
> On 1/8/24 19:05, Luiz Augusto von Dentz wrote:
>> Hi Jonas,
>>
>> On Sun, Jan 7, 2024 at 1:03 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>>
>>> Apparently the firmware is supposed to power off the bluetooth card
>>> properly, including disconnecting devices, when we use rfkill to block
>>> bluetooth. This doesn't work on a lot of laptops though, leading to weird
>>> issues after turning off bluetooth, like the connection timing out on the
>>> peripherals which were connected, and bluetooth not connecting properly
>>> when the adapter is turned on again after rfkilling.
>>>
>>> This series uses the rfkill hook in the bluetooth subsystem
>>> to execute a few more shutdown commands and make sure that all
>>> devices get disconnected before we close the HCI connection to the adapter.
>>>
>>> ---
>>>
>>> v1: https://lore.kernel.org/linux-bluetooth/20240102133311.6712-1-verdre@v0yd.nl/
>>> v2: https://lore.kernel.org/linux-bluetooth/20240102181946.57288-1-verdre@v0yd.nl/
>>> v3:
>>>   - Update commit message titles to reflect what's actually happening
>>>     (disconnecting devices, not sending a power-off command).
>>>   - Doing the shutdown sequence synchronously instead of async now.
>>>   - Move HCI_RFKILLED flag back again to be set before shutdown.
>>>   - Added a "fallback" hci_dev_do_close() to the error path because
>>>     hci_set_powered_sync() might bail-out early on error.
>>>
>>> Jonas Dreßler (4):
>>>    Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
>>>    Bluetooth: mgmt: Remove leftover queuing of power_off work
>>>    Bluetooth: Add new state HCI_POWERING_DOWN
>>>    Bluetooth: Disconnect connected devices before rfkilling adapter
>>>
>>>   include/net/bluetooth/hci.h |  2 +-
>>>   net/bluetooth/hci_core.c    | 35 +++++++++++++++++++++++++++++++++--
>>>   net/bluetooth/hci_sync.c    | 16 +++++++++++-----
>>>   net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
>>>   4 files changed, 59 insertions(+), 24 deletions(-)
>>>
>>> -- 
>>> 2.43.0
>>
>> I will probably be applying this sortly, but let's try to add tests to
>> mgmt-tester just to make sure we don't introduce regressions later,
>> btw it seems there are a few suspend test that do connect, for
>> example:
>>
>> Suspend - Success 5 (Pairing - Legacy) - waiting 1 seconds
>> random: crng init done
>>    New connection with handle 0x002a
>>    Test condition complete, 1 left
>> Suspend - Success 5 (Pairing - Legacy) - waiting done
>>    Set the system into Suspend via force_suspend
>>    New Controller Suspend event received
>>    Test condition complete, 0 left
>>
> 
> Thanks for that hint, I've been starting to write a test and managed to
> write to the rfkill file and it's blocking the device just fine, except
> I've run into what might be a bug in the virtual HCI driver:
> 
> So the power down sequence is initiated on the rfkill as expected and
> hci_set_powered_sync(false) is called. That then calls
> hci_write_scan_enable_sync(), and this HCI command never gets a response
> from the virtual HCI driver. Strangely, BT_HCI_CMD_WRITE_SCAN_ENABLE is
> implemented in btdev.c and the callback does get executed (I checked), it
> just doesn't send the command completed event:
> 
> < HCI Command: Write Scan Enable (0x03|0x001a) plen 1                                                                                                                                       #1588 [hci1] 12.294234
>          Scan enable: No Scans (0x00)
> 
> no response after...
> 

So I think I found the problem here too:

The problem with this one is that calling hci_set_powered_sync() from
within the context of the write to the rfkill device blocks the write()
until the HCI commands have returned. Because the mgmt-tester process is
stuck in write(), it can't reply to the HCI commands using the emulator
(which runs in the same thread), and after two seconds the HCI command
times out and the test ends.

I haven't really been able to confirm this other than that we're indeed
blocked in write(), does this sound like a sane explanation to you?

Seems like for this to work we'd either have to stop blocking userspace
until the rfkill has finished/failed (don't think that's a good idea), or
write to the rfkill device from an separate thread in mgmt-tester? The
latter should be fairly easy, so I'll give that a shot.

Cheers,
Jonas

