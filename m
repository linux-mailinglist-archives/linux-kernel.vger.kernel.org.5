Return-Path: <linux-kernel+bounces-18946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D7C826587
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB30281941
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7414008;
	Sun,  7 Jan 2024 18:11:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D813FE7;
	Sun,  7 Jan 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T7QHB0m0mz9sp6;
	Sun,  7 Jan 2024 19:11:02 +0100 (CET)
Message-ID: <f9f638bf-676e-43bf-8d83-256cae8f7bfe@v0yd.nl>
Date: Sun, 7 Jan 2024 19:10:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] Power off HCI devices before rfkilling them
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, verdre@v0yd.nl
References: <20240102181946.57288-1-verdre@v0yd.nl>
 <CABBYNZ+sTko6reoJO43W2LHGW58f0kK_8Zgc3mep7xki355=iA@mail.gmail.com>
 <548fb407-ef57-4108-aa26-52deafdca55c@v0yd.nl>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <548fb407-ef57-4108-aa26-52deafdca55c@v0yd.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/3/24 13:15, Jonas Dreßler wrote:
> Hi Luiz,
> 
> On 1/2/24 19:39, Luiz Augusto von Dentz wrote:
>> Hi Jonas,
>>
>> On Tue, Jan 2, 2024 at 1:19 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>>
>>> In theory the firmware is supposed to power off the bluetooth card
>>> when we use rfkill to block it. This doesn't work on a lot of laptops
>>> though, leading to weird issues after turning off bluetooth, like the
>>> connection timing out on the peripherals which were connected, and
>>> bluetooth not connecting properly when the adapter is turned on again
>>> quickly after rfkilling.
>>>
>>> This series hooks into the rfkill driver from the bluetooth subsystem
>>> to send a HCI_POWER_OFF command to the adapter before actually 
>>> submitting
>>> the rfkill to the firmware and killing the HCI connection.
>>>
>>> ---
>>>
>>> v1 -> v2: Fixed commit message title to make CI happy
>>>
>>> Jonas Dreßler (4):
>>>    Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
>>>    Bluetooth: mgmt: Remove leftover queuing of power_off work
>>>    Bluetooth: Add new state HCI_POWERING_DOWN
>>>    Bluetooth: Queue a HCI power-off command before rfkilling adapters
>>
>> Apart from the assumption of RFKILL actually killing the RF
>> immediately or not, I'm fine with these changes, that said it would be
>> great if we can have some proper way to test the behavior of rfkill,
>> perhaps via mgmt-tester, since it should behave like the
>> MGMT_OP_SET_POWERED.
> 
> Testing this sounds like a good idea, I guess we'd have to teach 
> mgmt-tester to write to rfkill. The bigger problem seems to be that 
> there's no MGMT event for power changes and also no MGMT_OP_GET_POWERED, 
> so that's a bit concerning, could userspace even be notified about 
> changes to adapter power?

Sent v3 of the patchset now, I didn't add a test to mgmt-tester because 
it's actually quite tricky to notice the full shutdown sequence happened 
rather than just closing the device. As long as no devices are 
connected, the difference is mostly in a few (faily random) events:

btmon without the patch:

@ MGMT Event: Class Of Device Changed (0x0007) plen 3 
 
        {0x0001} [hci0] 169.101804
         Class: 0x000000
           Major class: Miscellaneous
           Minor class: 0x00
@ MGMT Event: New Settings (0x0006) plen 4 
 
        {0x0001} [hci0] 169.101820
         Current settings: 0x00000ac0
           Secure Simple Pairing
           BR/EDR
           Low Energy
           Secure Connections

btmon with the patch:

< HCI Command: Write Scan Enable (0x03|0x001a) plen 1 
 
              #109 [hci0] 7.031852
         Scan enable: No Scans (0x00)
 > HCI Event: Command Complete (0x0e) plen 4 
 
               #110 [hci0] 7.033026
       Write Scan Enable (0x03|0x001a) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 2 
 
              #111 [hci0] 7.033055
         Extended advertising: Disabled (0x00)
         Number of sets: Disable all sets (0x00)
 > HCI Event: Command Complete (0x0e) plen 4 
 
               #112 [hci0] 7.034202
       LE Set Extended Advertising Enable (0x08|0x0039) ncmd 1
         Status: Success (0x00)
< HCI Command: LE Clear Advertising Sets (0x08|0x003d) plen 0 
 
              #113 [hci0] 7.034233
 > HCI Event: Command Complete (0x0e) plen 4 
 
               #114 [hci0] 7.035527
       LE Clear Advertising Sets (0x08|0x003d) ncmd 1
         Status: Success (0x00)
@ MGMT Event: Class Of Device Changed (0x0007) plen 3 
 
          {0x0001} [hci0] 7.035554
         Class: 0x000000
           Major class: Miscellaneous
           Minor class: 0x00
@ MGMT Event: New Settings (0x0006) plen 4 
 
          {0x0001} [hci0] 7.035568
         Current settings: 0x00000ac0
           Secure Simple Pairing
           BR/EDR
           Low Energy
           Secure Connections

Maybe we could add a fake connection and check whether that is 
disconnected on the rfkill, but I don't think mgmt-tester supports that..

Fwiw, I don't think having a test for this is super important, this is a 
regression a lot of people would notice very quickly I think.

> 
> Another thing I'm thinking about now is that queuing the HCI command 
> using hci_cmd_sync_queue() might not be enough: The command is still 
> executed async in a thread, and we won't actually block until it has 
> been sent, so this might be introducing a race (rfkill could kill the 
> adapter before we actually send the HCI command). The proper way might 
> be to use a completion and wait until the 
> set_powered_off_sync_complete() callback is invoked?
> 
>>
>>>   include/net/bluetooth/hci.h |  2 +-
>>>   net/bluetooth/hci_core.c    | 33 ++++++++++++++++++++++++++++++---
>>>   net/bluetooth/hci_sync.c    | 16 +++++++++++-----
>>>   net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
>>>   4 files changed, 56 insertions(+), 25 deletions(-)
>>>
>>> -- 
>>> 2.43.0
>>>
>>
>>
> 
> Cheers,
> Jonas

Cheers,
Jonas

