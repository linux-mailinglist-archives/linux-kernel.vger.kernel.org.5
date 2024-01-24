Return-Path: <linux-kernel+bounces-37318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E283AE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06F128D6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC147E575;
	Wed, 24 Jan 2024 16:17:27 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E97E562;
	Wed, 24 Jan 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113047; cv=none; b=B20QLNcWJAgvQyATpBUy8ATPg198iq2HzTW4w3c8l0F+IAYJsW2gQnJkyEFhVh+1IGZv5PXusaKN0QSHdRCi0vZ/+9iCVR0ebDMeLufDZggTD5wF9/79klW1l2IyL+rvVhslO7f+CgqFRDkfn47DZpkZq1KpFSsnnhUKEey4qCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113047; c=relaxed/simple;
	bh=rXNeYjIbp304MydXOXcFoTjwZoS/dhBpt7AXuSBz4Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCCz1rI7HOh3OkQCzI0LUUaIqIZRVWf6avEUi0lZLd+MKanFNL3QIdVInfMxAl4AeWhY0tPd8BuQN34SWbSFyW84/t+3x/mP27L7hJ3kHIa6BX2ZuBadbObPoGQQqLcfeW6iIdLBoB/eTAU3pBnmjoF1VLy8YZHmLgatToGY5AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TKpy30F5Vz9swq;
	Wed, 24 Jan 2024 17:17:15 +0100 (CET)
Message-ID: <6e618827-c9c1-4ef8-9c98-27ef10b6d6a2@v0yd.nl>
Date: Wed, 24 Jan 2024 17:17:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] Bluetooth: Improve retrying of connection attempts
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240108224614.56900-1-verdre@v0yd.nl>
 <CABBYNZKV176teECGnGKTCNNo45ZYbCRs=YddETOUMUsJQX5PdA@mail.gmail.com>
 <efcc7b97-6bfc-4e5d-8e73-78f2b190fa02@v0yd.nl>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <efcc7b97-6bfc-4e5d-8e73-78f2b190fa02@v0yd.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 1/9/24 10:57 PM, Jonas Dreßler wrote:
> Hi Luiz,
> 
> On 1/9/24 18:53, Luiz Augusto von Dentz wrote:
>> Hi Jonas,
>>
>> On Mon, Jan 8, 2024 at 5:46 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>>
>>> Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
>>> requests"), the kernel supports trying to connect again in case the
>>> bluetooth card is busy and fails to connect.
>>>
>>> The logic that should handle this became a bit spotty over time, and also
>>> cards these days appear to fail with more errors than just "Command
>>> Disallowed".
>>>
>>> This series refactores the handling of concurrent connection requests
>>> by serializing all "Create Connection" commands for ACL connections
>>> similar to how we do it for LE connections.
>>>
>>> ---
>>>
>>> v1: https://lore.kernel.org/linux-bluetooth/20240102185933.64179-1-verdre@v0yd.nl/
>>> v2: https://lore.kernel.org/linux-bluetooth/20240108183938.468426-1-verdre@v0yd.nl/
>>> v3:
>>>    - Move the new sync function to hci_sync.c as requested by review
>>>    - Abort connection on failure using hci_abort_conn_sync() instead of
>>>      hci_abort_conn()
>>>    - Make the last commit message a bit more precise regarding the meaning
>>>      of BT_CONNECT2 state
>>>
>>> Jonas Dreßler (4):
>>>    Bluetooth: Remove superfluous call to hci_conn_check_pending()
>>>    Bluetooth: hci_event: Use HCI error defines instead of magic values
>>>    Bluetooth: hci_conn: Only do ACL connections sequentially
>>>    Bluetooth: Remove pending ACL connection attempts
>>>
>>>   include/net/bluetooth/hci.h      |  3 ++
>>>   include/net/bluetooth/hci_core.h |  1 -
>>>   include/net/bluetooth/hci_sync.h |  3 ++
>>>   net/bluetooth/hci_conn.c         | 83 +++-----------------------------
>>>   net/bluetooth/hci_event.c        | 29 +++--------
>>>   net/bluetooth/hci_sync.c         | 72 +++++++++++++++++++++++++++
>>>   6 files changed, 93 insertions(+), 98 deletions(-)
>>>
>>> -- 
>>> 2.43.0
>>
>> After rebasing and fixing a little bit here and there, see v4, looks
>> like this changes is affecting the following mgmt-tester -s "Pair
>> Device - Power off 1":
>>
>> Pair Device - Power off 1 - init
>>    Read Version callback
>>      Status: Success (0x00)
>>      Version 1.22
>>    Read Commands callback
>>      Status: Success (0x00)
>>    Read Index List callback
>>      Status: Success (0x00)
>>    Index Added callback
>>      Index: 0x0000
>>    Enable management Mesh interface
>>    Enabling Mesh feature
>>    Read Info callback
>>      Status: Success (0x00)
>>      Address: 00:AA:01:00:00:00
>>      Version: 0x09
>>      Manufacturer: 0x05f1
>>      Supported settings: 0x0001bfff
>>      Current settings: 0x00000080
>>      Class: 0x000000
>>      Name:
>>      Short name:
>>    Mesh feature is enabled
>> Pair Device - Power off 1 - setup
>>    Setup sending Set Bondable (0x0009)
>>    Setup sending Set Powered (0x0005)
>>    Initial settings completed
>>    Test setup condition added, total 1
>>    Client set connectable: Success (0x00)
>>    Test setup condition complete, 0 left
>> Pair Device - Power off 1 - setup complete
>> Pair Device - Power off 1 - run
>>    Sending Pair Device (0x0019)
>> Bluetooth: hci0: command 0x0405 tx timeout
>> Bluetooth: hci0: command 0x0408 tx timeout
>>    Test condition added, total 1
>> Pair Device - Power off 1 - test timed out
>>    Pair Device (0x0019): Disconnected (0x0e)
>> Pair Device - Power off 1 - test not run
>> Pair Device - Power off 1 - teardown
>> Pair Device - Power off 1 - teardown
>>    Index Removed callback
>>      Index: 0x0000
>> Pair Device - Power off 1 - teardown complete
>> Pair Device - Power off 1 - done
>>
> 
> Thanks for landing the first two commits!
> 
> I think this is actually the same issue causing the test failure
> as in the other issue I had:
> https://lore.kernel.org/linux-bluetooth/7cee4e74-3a0c-4b7c-9984-696e646160f8@v0yd.nl/
> 
> It seems that the emulator is unable to reply to HCI commands sent
> from the hci_sync machinery, possibly because that is sending things
> on a separate thread?

Okay I did some further digging now: Turns out this actually not a problem
with vhci and the emulator, but (in this test case) it's actually intended
that there's the command times out, because force_power_off is TRUE for
this test case, and the HCI device gets shut down right after sending the MGMT
command.

The test broke because the "Command Complete" MGMT event comes back with status
"Disconnected" instead of "Not Powered": The reason for that is the
hci_abort_conn_sync() that I added in the case where the "Create Connection" HCI
times out. hci_abort_conn_sync() calls hci_conn_failed() with
HCI_ERROR_LOCAL_HOST_TERM as expected, this in turn calls the hci_connect_cfm()
callback (pairing_complete_cb), and there we we look up HCI_ERROR_LOCAL_HOST_TERM
in mgmt_status_table, ending up with MGMT_STATUS_DISCONNECTED.

When I remove the hci_abort_conn_sync() we get the "Not Powered" failure again,
I'm not exactly sure why that happens (I assume there's some kind of generic mgmt
failure return handler that checks hdev_is_powered() and then sets the error).

So the question now is do we want to adjust the test (and possibly bluetoothd?)
to expect "Disconnected" instead of "Not Powered", or should I get rid of the
hci_abort_conn_sync() again? Fwiw, in hci_le_create_conn_sync() we also clean
up like this on ETIMEDOUT (maybe the spec is just different there?), so
consistency wise it seems better to adjust the test to expect "Disconnected".

Cheers,
Jonas

> 
> Cheers,
> Jonas

