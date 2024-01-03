Return-Path: <linux-kernel+bounces-15498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF8822CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA812858B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B919440;
	Wed,  3 Jan 2024 12:16:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA218EB0;
	Wed,  3 Jan 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T4pbH31vgz9snN;
	Wed,  3 Jan 2024 13:15:55 +0100 (CET)
Message-ID: <548fb407-ef57-4108-aa26-52deafdca55c@v0yd.nl>
Date: Wed, 3 Jan 2024 13:15:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/4] Power off HCI devices before rfkilling them
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, verdre@v0yd.nl
References: <20240102181946.57288-1-verdre@v0yd.nl>
 <CABBYNZ+sTko6reoJO43W2LHGW58f0kK_8Zgc3mep7xki355=iA@mail.gmail.com>
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <CABBYNZ+sTko6reoJO43W2LHGW58f0kK_8Zgc3mep7xki355=iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T4pbH31vgz9snN

Hi Luiz,

On 1/2/24 19:39, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Tue, Jan 2, 2024 at 1:19 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> In theory the firmware is supposed to power off the bluetooth card
>> when we use rfkill to block it. This doesn't work on a lot of laptops
>> though, leading to weird issues after turning off bluetooth, like the
>> connection timing out on the peripherals which were connected, and
>> bluetooth not connecting properly when the adapter is turned on again
>> quickly after rfkilling.
>>
>> This series hooks into the rfkill driver from the bluetooth subsystem
>> to send a HCI_POWER_OFF command to the adapter before actually submitting
>> the rfkill to the firmware and killing the HCI connection.
>>
>> ---
>>
>> v1 -> v2: Fixed commit message title to make CI happy
>>
>> Jonas Dreßler (4):
>>    Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
>>    Bluetooth: mgmt: Remove leftover queuing of power_off work
>>    Bluetooth: Add new state HCI_POWERING_DOWN
>>    Bluetooth: Queue a HCI power-off command before rfkilling adapters
> 
> Apart from the assumption of RFKILL actually killing the RF
> immediately or not, I'm fine with these changes, that said it would be
> great if we can have some proper way to test the behavior of rfkill,
> perhaps via mgmt-tester, since it should behave like the
> MGMT_OP_SET_POWERED.

Testing this sounds like a good idea, I guess we'd have to teach 
mgmt-tester to write to rfkill. The bigger problem seems to be that 
there's no MGMT event for power changes and also no MGMT_OP_GET_POWERED, 
so that's a bit concerning, could userspace even be notified about 
changes to adapter power?

Another thing I'm thinking about now is that queuing the HCI command 
using hci_cmd_sync_queue() might not be enough: The command is still 
executed async in a thread, and we won't actually block until it has 
been sent, so this might be introducing a race (rfkill could kill the 
adapter before we actually send the HCI command). The proper way might 
be to use a completion and wait until the 
set_powered_off_sync_complete() callback is invoked?

> 
>>   include/net/bluetooth/hci.h |  2 +-
>>   net/bluetooth/hci_core.c    | 33 ++++++++++++++++++++++++++++++---
>>   net/bluetooth/hci_sync.c    | 16 +++++++++++-----
>>   net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
>>   4 files changed, 56 insertions(+), 25 deletions(-)
>>
>> --
>> 2.43.0
>>
> 
> 

Cheers,
Jonas

