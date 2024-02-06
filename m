Return-Path: <linux-kernel+bounces-55728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA1084C0ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF5B287559
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A51CD2A;
	Tue,  6 Feb 2024 23:33:25 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B11CD1B;
	Tue,  6 Feb 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262405; cv=none; b=aupVQrbeRRGdZaU3y4Sl2imzlPJYuUGvL05tvj/mG7+KT1eKflz3sN4sP5ca23JfDe60a5cyYX1I2NANxpTUUZrD/8r0AFhF4LrawC8/4JltNmqmSHaNWcK3U/PhgHc9l8/U/Tb3aI+/3z6yB0wNafSXsTEWyJM97XaYjWWUvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262405; c=relaxed/simple;
	bh=jnKwKyBLwfWp6fRdpiJAMuzoCw4XPssRIE3TQikj8BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYzVSU+rvdDYHNFvFkehw45K+j86XybqiHtk8Th6EMWDTyEGH77LJCCcR+5NDUknZ82PHVObxTzrf6LEQ+ulD34wR8Gh7URH5z6W5AHOvE1ndYM+F3PiWBXx75pMVnbh/kWp+Z/Us0suippAhbR6aYX/ng7SQoP2Tuu2U+JUSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TTzvD1XQGz9sdS;
	Wed,  7 Feb 2024 00:28:08 +0100 (CET)
Message-ID: <13f5b50e-94b7-42ea-a47b-7d6270105d1d@v0yd.nl>
Date: Wed, 7 Feb 2024 00:28:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/2] Bluetooth: Improve retrying of connection attempts
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240206110816.74995-1-verdre@v0yd.nl>
 <CABBYNZJgKCeGfL+CngEA2QcVZAtf5yEqiX7ccQsuWVtjZhCvjw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <CABBYNZJgKCeGfL+CngEA2QcVZAtf5yEqiX7ccQsuWVtjZhCvjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TTzvD1XQGz9sdS

Hi Luiz,

On 06.02.24 23:22, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Tue, Feb 6, 2024 at 6:08 AM Jonas Dreßler <verdre@v0yd.nl> wrote:
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
>> v3: https://lore.kernel.org/linux-bluetooth/20240108224614.56900-1-verdre@v0yd.nl/
>> v4:
>>    - Removed first two commits since they are already applied
>>    - Removed a BT_DBG() message in the acl_create_connection() function
>>      while moving to hci_sync because it seemed out of place in hci_sync
>>    - Added a mention of the test failure in mgmt-tester to commit message
>>
>> Jonas Dreßler (2):
>>    Bluetooth: hci_conn: Only do ACL connections sequentially
>>    Bluetooth: Remove pending ACL connection attempts
>>
>>   include/net/bluetooth/hci.h      |  1 +
>>   include/net/bluetooth/hci_core.h |  1 -
>>   include/net/bluetooth/hci_sync.h |  3 ++
>>   net/bluetooth/hci_conn.c         | 83 +++-----------------------------
>>   net/bluetooth/hci_event.c        | 21 ++------
>>   net/bluetooth/hci_sync.c         | 70 +++++++++++++++++++++++++++
>>   6 files changed, 86 insertions(+), 93 deletions(-)
>>
>> --
>> 2.43.0
> 
> 
> Doesn't seem to work with the new test:
> 
> Sequential connect - setup complete
> Sequential connect - run
>    Create connection finished
>    Connect failed for Pair Device
>    Create connection finished
> Sequential connect - test timed out
> Sequential connect - teardown
> 

Oh you're right, it's because of the increased delay to 5.12 seconds for
sending the page timeout. We're actually waiting for connections to fail,
so the test will now take at least 5.12s * 3 instead of 2s * 3, which means
test timeout needs to be increased from 7 to more like 16 seconds.

Sorry for not catching this one, should've run the test before submitting
the patch...

Cheers,
Jonas

