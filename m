Return-Path: <linux-kernel+bounces-21454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58035828F59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67DF1F263E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5103DBAC;
	Tue,  9 Jan 2024 21:58:02 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0D3DB84;
	Tue,  9 Jan 2024 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T8lCw6nPKz9sd0;
	Tue,  9 Jan 2024 22:57:48 +0100 (CET)
Message-ID: <efcc7b97-6bfc-4e5d-8e73-78f2b190fa02@v0yd.nl>
Date: Tue, 9 Jan 2024 22:57:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: Re: [PATCH v3 0/4] Bluetooth: Improve retrying of connection attempts
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, verdre@v0yd.nl
References: <20240108224614.56900-1-verdre@v0yd.nl>
 <CABBYNZKV176teECGnGKTCNNo45ZYbCRs=YddETOUMUsJQX5PdA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZKV176teECGnGKTCNNo45ZYbCRs=YddETOUMUsJQX5PdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T8lCw6nPKz9sd0

Hi Luiz,

On 1/9/24 18:53, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Mon, Jan 8, 2024 at 5:46 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
>> requests"), the kernel supports trying to connect again in case the
>> bluetooth card is busy and fails to connect.
>>
>> The logic that should handle this became a bit spotty over time, and also
>> cards these days appear to fail with more errors than just "Command
>> Disallowed".
>>
>> This series refactores the handling of concurrent connection requests
>> by serializing all "Create Connection" commands for ACL connections
>> similar to how we do it for LE connections.
>>
>> ---
>>
>> v1: https://lore.kernel.org/linux-bluetooth/20240102185933.64179-1-verdre@v0yd.nl/
>> v2: https://lore.kernel.org/linux-bluetooth/20240108183938.468426-1-verdre@v0yd.nl/
>> v3:
>>    - Move the new sync function to hci_sync.c as requested by review
>>    - Abort connection on failure using hci_abort_conn_sync() instead of
>>      hci_abort_conn()
>>    - Make the last commit message a bit more precise regarding the meaning
>>      of BT_CONNECT2 state
>>
>> Jonas Dreßler (4):
>>    Bluetooth: Remove superfluous call to hci_conn_check_pending()
>>    Bluetooth: hci_event: Use HCI error defines instead of magic values
>>    Bluetooth: hci_conn: Only do ACL connections sequentially
>>    Bluetooth: Remove pending ACL connection attempts
>>
>>   include/net/bluetooth/hci.h      |  3 ++
>>   include/net/bluetooth/hci_core.h |  1 -
>>   include/net/bluetooth/hci_sync.h |  3 ++
>>   net/bluetooth/hci_conn.c         | 83 +++-----------------------------
>>   net/bluetooth/hci_event.c        | 29 +++--------
>>   net/bluetooth/hci_sync.c         | 72 +++++++++++++++++++++++++++
>>   6 files changed, 93 insertions(+), 98 deletions(-)
>>
>> --
>> 2.43.0
> 
> After rebasing and fixing a little bit here and there, see v4, looks
> like this changes is affecting the following mgmt-tester -s "Pair
> Device - Power off 1":
> 
> Pair Device - Power off 1 - init
>    Read Version callback
>      Status: Success (0x00)
>      Version 1.22
>    Read Commands callback
>      Status: Success (0x00)
>    Read Index List callback
>      Status: Success (0x00)
>    Index Added callback
>      Index: 0x0000
>    Enable management Mesh interface
>    Enabling Mesh feature
>    Read Info callback
>      Status: Success (0x00)
>      Address: 00:AA:01:00:00:00
>      Version: 0x09
>      Manufacturer: 0x05f1
>      Supported settings: 0x0001bfff
>      Current settings: 0x00000080
>      Class: 0x000000
>      Name:
>      Short name:
>    Mesh feature is enabled
> Pair Device - Power off 1 - setup
>    Setup sending Set Bondable (0x0009)
>    Setup sending Set Powered (0x0005)
>    Initial settings completed
>    Test setup condition added, total 1
>    Client set connectable: Success (0x00)
>    Test setup condition complete, 0 left
> Pair Device - Power off 1 - setup complete
> Pair Device - Power off 1 - run
>    Sending Pair Device (0x0019)
> Bluetooth: hci0: command 0x0405 tx timeout
> Bluetooth: hci0: command 0x0408 tx timeout
>    Test condition added, total 1
> Pair Device - Power off 1 - test timed out
>    Pair Device (0x0019): Disconnected (0x0e)
> Pair Device - Power off 1 - test not run
> Pair Device - Power off 1 - teardown
> Pair Device - Power off 1 - teardown
>    Index Removed callback
>      Index: 0x0000
> Pair Device - Power off 1 - teardown complete
> Pair Device - Power off 1 - done
> 

Thanks for landing the first two commits!

I think this is actually the same issue causing the test failure
as in the other issue I had:
https://lore.kernel.org/linux-bluetooth/7cee4e74-3a0c-4b7c-9984-696e646160f8@v0yd.nl/

It seems that the emulator is unable to reply to HCI commands sent
from the hci_sync machinery, possibly because that is sending things
on a separate thread?

Cheers,
Jonas

