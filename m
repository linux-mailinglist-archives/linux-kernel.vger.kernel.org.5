Return-Path: <linux-kernel+bounces-20146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9F827A91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FB7B22EE9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC15647A;
	Mon,  8 Jan 2024 22:25:54 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6855E6C;
	Mon,  8 Jan 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T87tX69Jlz9sWf;
	Mon,  8 Jan 2024 23:25:40 +0100 (CET)
Message-ID: <7cee4e74-3a0c-4b7c-9984-696e646160f8@v0yd.nl>
Date: Mon, 8 Jan 2024 23:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: Re: [PATCH v3 0/4] Disconnect devices before rfkilling adapter
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, asahi@lists.linux.dev,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, verdre@v0yd.nl
References: <20240107180252.73436-1-verdre@v0yd.nl>
 <CABBYNZ+rDo6ftN1+HdeWm6gij14YF_19WGRP7LM4Vjw-UWOTng@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZ+rDo6ftN1+HdeWm6gij14YF_19WGRP7LM4Vjw-UWOTng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T87tX69Jlz9sWf

Hi Luiz,

On 1/8/24 19:05, Luiz Augusto von Dentz wrote:
> Hi Jonas,
> 
> On Sun, Jan 7, 2024 at 1:03 PM Jonas Dreßler <verdre@v0yd.nl> wrote:
>>
>> Apparently the firmware is supposed to power off the bluetooth card
>> properly, including disconnecting devices, when we use rfkill to block
>> bluetooth. This doesn't work on a lot of laptops though, leading to weird
>> issues after turning off bluetooth, like the connection timing out on the
>> peripherals which were connected, and bluetooth not connecting properly
>> when the adapter is turned on again after rfkilling.
>>
>> This series uses the rfkill hook in the bluetooth subsystem
>> to execute a few more shutdown commands and make sure that all
>> devices get disconnected before we close the HCI connection to the adapter.
>>
>> ---
>>
>> v1: https://lore.kernel.org/linux-bluetooth/20240102133311.6712-1-verdre@v0yd.nl/
>> v2: https://lore.kernel.org/linux-bluetooth/20240102181946.57288-1-verdre@v0yd.nl/
>> v3:
>>   - Update commit message titles to reflect what's actually happening
>>     (disconnecting devices, not sending a power-off command).
>>   - Doing the shutdown sequence synchronously instead of async now.
>>   - Move HCI_RFKILLED flag back again to be set before shutdown.
>>   - Added a "fallback" hci_dev_do_close() to the error path because
>>     hci_set_powered_sync() might bail-out early on error.
>>
>> Jonas Dreßler (4):
>>    Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
>>    Bluetooth: mgmt: Remove leftover queuing of power_off work
>>    Bluetooth: Add new state HCI_POWERING_DOWN
>>    Bluetooth: Disconnect connected devices before rfkilling adapter
>>
>>   include/net/bluetooth/hci.h |  2 +-
>>   net/bluetooth/hci_core.c    | 35 +++++++++++++++++++++++++++++++++--
>>   net/bluetooth/hci_sync.c    | 16 +++++++++++-----
>>   net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
>>   4 files changed, 59 insertions(+), 24 deletions(-)
>>
>> --
>> 2.43.0
> 
> I will probably be applying this sortly, but let's try to add tests to
> mgmt-tester just to make sure we don't introduce regressions later,
> btw it seems there are a few suspend test that do connect, for
> example:
> 
> Suspend - Success 5 (Pairing - Legacy) - waiting 1 seconds
> random: crng init done
>    New connection with handle 0x002a
>    Test condition complete, 1 left
> Suspend - Success 5 (Pairing - Legacy) - waiting done
>    Set the system into Suspend via force_suspend
>    New Controller Suspend event received
>    Test condition complete, 0 left
> 

Thanks for that hint, I've been starting to write a test and managed to
write to the rfkill file and it's blocking the device just fine, except
I've run into what might be a bug in the virtual HCI driver:

So the power down sequence is initiated on the rfkill as expected and
hci_set_powered_sync(false) is called. That then calls
hci_write_scan_enable_sync(), and this HCI command never gets a response
from the virtual HCI driver. Strangely, BT_HCI_CMD_WRITE_SCAN_ENABLE is
implemented in btdev.c and the callback does get executed (I checked), it
just doesn't send the command completed event:

< HCI Command: Write Scan Enable (0x03|0x001a) plen 1                                                                                                                                       #1588 [hci1] 12.294234
         Scan enable: No Scans (0x00)

no response after...

Below is my current mgmt-tester patch adding the test:

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7dfd1b0c7..2095b7203 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -12439,6 +12439,30 @@ static const struct generic_data suspend_resume_success_5 = {
  	.expect_alt_ev_len = sizeof(suspend_state_param_disconnect),
  };
  
+static const uint8_t rfkill_hci_disconnect_device[] = {
+   0x00, 0x00, 0x01, 0x01, 0xaa, 0x00, 0x00,
+   0x05,
+};
+
+static const uint8_t rfkill_new_settings_ev[] = {
+   0x92, 0x00, 0x00, 0x00,
+};
+
+
+static const struct generic_data rfkill_disconnect_devices = {
+	.setup_settings = settings_powered_connectable_bondable,
+	.pin = pair_device_pin,
+	.pin_len = sizeof(pair_device_pin),
+	.client_pin = pair_device_pin,
+	.client_pin_len = sizeof(pair_device_pin),
+	.expect_hci_command = BT_HCI_CMD_DISCONNECT,
+	.expect_hci_param = rfkill_hci_disconnect_device,
+	.expect_hci_len = sizeof(rfkill_hci_disconnect_device),
+	.expect_alt_ev = MGMT_EV_NEW_SETTINGS,
+	.expect_alt_ev_param = rfkill_new_settings_ev,
+	.expect_alt_ev_len = sizeof(rfkill_new_settings_ev),
+};
+
  static void trigger_force_suspend(void *user_data)
  {
  	struct test_data *data = tester_get_data();
@@ -12454,6 +12478,81 @@ static void trigger_force_suspend(void *user_data)
  	}
  }
  
+enum rfkill_type {
+	RFKILL_TYPE_ALL = 0,
+	RFKILL_TYPE_WLAN,
+	RFKILL_TYPE_BLUETOOTH,
+	RFKILL_TYPE_UWB,
+	RFKILL_TYPE_WIMAX,
+	RFKILL_TYPE_WWAN,
+};
+
+enum rfkill_operation {
+	RFKILL_OP_ADD = 0,
+	RFKILL_OP_DEL,
+	RFKILL_OP_CHANGE,
+	RFKILL_OP_CHANGE_ALL,
+};
+
+struct rfkill_event {
+	uint32_t idx;
+	uint8_t  type;
+	uint8_t  op;
+	uint8_t  soft;
+	uint8_t  hard;
+};
+#define RFKILL_EVENT_SIZE_V1    8
+
+static void trigger_rfkill(void *user_data)
+{
+	int fd;
+	int latest_rfkill_idx;
+        struct rfkill_event write_event;
+        ssize_t l;
+
+	tester_print("Triggering rfkill block of hci device");
+
+	fd = open("/dev/rfkill", O_RDWR|O_CLOEXEC|O_NOCTTY|O_NONBLOCK);
+	if (fd < 0) {
+		tester_warn("Failed to open RFKILL control device");
+		return;
+	}
+
+	latest_rfkill_idx = -1;
+	while (1) {
+		struct rfkill_event event = { 0 };
+		ssize_t len;
+
+		len = read(fd, &event, sizeof(event));
+		if (len < RFKILL_EVENT_SIZE_V1)
+			break;
+
+		if (event.type == RFKILL_TYPE_BLUETOOTH)
+			latest_rfkill_idx = event.idx;
+	}
+
+	if (latest_rfkill_idx < 0) {
+		tester_warn("No rfkill device to block found");
+		return;
+	}
+
+	write_event.idx = latest_rfkill_idx;
+	write_event.op = RFKILL_OP_CHANGE;
+	write_event.soft = true;
+	
+        l = write(fd, &write_event, sizeof write_event);
+
+	close(fd);
+
+	if (l < 0) {
+		tester_warn("Failed to execute rfkill op");
+		return;
+	}
+
+	if ((size_t)l < RFKILL_EVENT_SIZE_V1)
+		tester_warn("Failed to write to rfkill file");
+}
+
  static void trigger_force_resume(void *user_data)
  {
  	struct test_data *data = tester_get_data();
@@ -12475,6 +12574,12 @@ static void test_suspend_resume_success_5(const void *test_data)
  	tester_wait(1, trigger_force_suspend, NULL);
  }
  
+static void test_disconnect_on_rfkill(const void *test_data)
+{
+	test_pairing_acceptor(test_data);
+	tester_wait(1, trigger_rfkill, NULL);
+}
+
  static const struct generic_data suspend_resume_success_6 = {
  	.setup_settings = settings_powered_connectable_bondable_ssp,
  	.client_enable_ssp = true,
@@ -14534,6 +14639,15 @@ int main(int argc, char *argv[])
  				&suspend_resume_success_5, NULL,
  				test_suspend_resume_success_5);
  
+	/* Suspend/Resume
+	 * Setup: Pair.
+	 * Run: Enable suspend
+	 * Expect: Receive the Suspend Event
+	 */
+	test_bredrle("Rfkill - disconnect devices",
+				&rfkill_disconnect_devices, NULL,
+				test_disconnect_on_rfkill);
+
  	/* Suspend/Resume
  	 * Setup: Pair.
  	 * Run: Enable suspend

