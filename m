Return-Path: <linux-kernel+bounces-14743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC5822159
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B345280F41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FF15AE7;
	Tue,  2 Jan 2024 18:49:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3691515AD0;
	Tue,  2 Jan 2024 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T4MMT3lScz9sXk;
	Tue,  2 Jan 2024 19:49:09 +0100 (CET)
Message-ID: <13fc1f7f-9990-4ad4-b8a8-54a9365083e2@v0yd.nl>
Date: Tue, 2 Jan 2024 19:49:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] Bluetooth: Queue a HCI power-off command before
 rfkilling adapters
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240102181946.57288-1-verdre@v0yd.nl>
 <20240102181946.57288-5-verdre@v0yd.nl>
 <CABBYNZ+uy50g2CSJ37DL63ycSJc96Xegdjcr6N2weJfCiGO_Aw@mail.gmail.com>
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <CABBYNZ+uy50g2CSJ37DL63ycSJc96Xegdjcr6N2weJfCiGO_Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T4MMT3lScz9sXk

On 1/2/24 19:31, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Tue, Jan 2, 2024 at 1:19 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> On a lot of platforms (at least the MS Surface devices, M1 macbooks, and
>> a few ThinkPads) firmware doesn't do its job when rfkilling a device
>> and the bluetooth adapter is not actually shut down on rfkill. This leads
>> to connected devices remaining in connected state and the bluetooth
>> connection eventually timing out after rfkilling an adapter.
>>
>> Use the rfkill hook in the HCI driver to actually power the device off
>> before rfkilling it.
>>
>> Note that the wifi subsystem is doing something similar by calling
>> cfg80211_shutdown_all_interfaces()
>> in it's rfkill set_block callback (see cfg80211_rfkill_set_block).
> 
> So the rfkill is supposed to be wait for cleanup, not a forceful
> shutdown of RF traffic? I assume it would be the later since to do a
> proper cleanup that could cause more RF traffic while the current
> assumption was to stop all traffic and then call hdev->shutdown to
> ensure the driver does shutdown the RF traffic, perhaps this
> assumption has changed over time since interrupting the RF traffic may
> cause what you just described because the remote end will have to rely
> on link-loss logic to detect the connection has been terminated.

Yes, it seems to me that as soon as the rfkill happens, anything in the 
drivers hdev->shutdown to shut things down will no longer go through to 
the card. I'd assume this is something that's enforced by firmware and 
we can't change, or would that be a bug on our side?

But yeah, proper shutdown of the adapter requires a bit more RF traffic. 
If rfkill guarantees that it shuts down all RF traffic *immediately*, 
maybe it would be better to expect power-off MGMT commands from 
userspace before rfkilling? But given that the disconnect appears to 
happen fine on some hardware, this seemed like the obvious and more 
reliable way to me.

> 
>> Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
>> ---
>>   net/bluetooth/hci_core.c | 33 ++++++++++++++++++++++++++++++---
>>   1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 1ec83985f..1c91d02f7 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -543,6 +543,23 @@ int hci_dev_open(__u16 dev)
>>          return err;
>>   }
>>
>> +static int set_powered_off_sync(struct hci_dev *hdev, void *data)
>> +{
>> +       return hci_set_powered_sync(hdev, false);
>> +}
>> +
>> +static void set_powered_off_sync_complete(struct hci_dev *hdev, void *data, int err)
>> +{
>> +       if (err)
>> +               bt_dev_err(hdev, "Powering HCI device off before rfkilling failed (%d)", err);
>> +}
>> +
>> +static int hci_dev_do_poweroff(struct hci_dev *hdev)
>> +{
>> +       return hci_cmd_sync_queue(hdev, set_powered_off_sync,
>> +                                 NULL, set_powered_off_sync_complete);
>> +}
>> +
>>   int hci_dev_do_close(struct hci_dev *hdev)
>>   {
>>          int err;
>> @@ -943,17 +960,27 @@ int hci_get_dev_info(void __user *arg)
>>   static int hci_rfkill_set_block(void *data, bool blocked)
>>   {
>>          struct hci_dev *hdev = data;
>> +       int err;
>>
>>          BT_DBG("%p name %s blocked %d", hdev, hdev->name, blocked);
>>
>>          if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
>>                  return -EBUSY;
>>
>> +       if (blocked == hci_dev_test_flag(hdev, HCI_RFKILLED))
>> +               return 0;
>> +
>>          if (blocked) {
>> -               hci_dev_set_flag(hdev, HCI_RFKILLED);
>>                  if (!hci_dev_test_flag(hdev, HCI_SETUP) &&
>> -                   !hci_dev_test_flag(hdev, HCI_CONFIG))
>> -                       hci_dev_do_close(hdev);
>> +                   !hci_dev_test_flag(hdev, HCI_CONFIG)) {
>> +                       err = hci_dev_do_poweroff(hdev);
>> +                       if (err) {
>> +                               bt_dev_err(hdev, "Powering off device before rfkilling failed (%d)",
>> +                                          err);
>> +                       }
> 
> You already have the error printed on set_powered_off_sync_complete
> not sure why you have it here as well.
> 
>> +               }
>> +
>> +               hci_dev_set_flag(hdev, HCI_RFKILLED);
> 
> Before we used to set the HCI_RFKILLED beforehand, is this change
> really intended or not? I think we should keep doing it ahead of power
> off sequence since we can probably use it to ignore if there are any
> errors on the cleanup, etc.

Good point, it's been a while since I wrote that patch, maybe something 
in the power-off logic bails out if HCI_RFKILLED is set and that's why I 
moved it below, I'll check that...

> 
>>          } else {
>>                  hci_dev_clear_flag(hdev, HCI_RFKILLED);
>>          }
>> --
>> 2.43.0
>>
> 
> 

