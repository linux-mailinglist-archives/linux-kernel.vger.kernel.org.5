Return-Path: <linux-kernel+bounces-74556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9285D5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0181F240BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FD63BB34;
	Wed, 21 Feb 2024 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="m+svlqX1"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD552E637
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512312; cv=none; b=i63K60wa/gtX4J28nQaTaVwBapo984+xiKjDADt4gih0X75JJF8z6W1pBLDaZun7MxNWZCUNzICxNZkQNr/5V8ddM9icL8/yh+da5SeT8T4sNDuZEguoniW3HkfVVoCQme3yowEAg7WpGDBQkoNqsrWsM7QBX7agpILwNYQlZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512312; c=relaxed/simple;
	bh=B+pFKzfHCAn1l9phqimNCv3GOadgzMPuRi6KuJaaOLo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UIMtwVGaOoigbBLWpD2fBZvi5OekHiHQeZNYxkavu/FX/ryBZmCSdrRZ39dO8C/WQlffIQApjbX5tfGpGXEjAwPkENAZMMoEn4Rbe6c4KqLvRCWc8SYLMnrdVBY0aQohDNtUiHUuLV7uZpG+tyrE2fRUyhtJ2mhrLd4F/5wZwd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=m+svlqX1; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1708512302; x=1708771502;
	bh=ALAUWDo1q/pR2NBpJFnmEYadC1ZlGbn8mjRrWt60C40=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=m+svlqX1hRCs4J4W5yLiwQZfqk4xDYx8LnEnZJYACPKrr+fBDgNxqDhlQClYyMeTH
	 lhaYUtTEOoMFmciUkS+W8ooZFZHVLPkq3TuZ/UxtljFazPcJExt9L7mJ6O4wNt5e3Y
	 5HN9iwJocnRPinMTSaS0qN+5vPCG49ywpY6lgZvg2DDVA0bWXBjcWjngogij9ZmyXp
	 Dp15QVBASSQ4nB5JTrwzGK5fhQxlvTG0VdAuZGwW7HQtgV+x+qr2tXmMh5Vn+EoTUc
	 sPVsnc4jer6r/d8llyroTgJSs24At98KKlTdMUhSmLdDnA9kxeaNm1ERQkEQ+QafV1
	 jM8RUe/upHodQ==
Date: Wed, 21 Feb 2024 10:44:53 +0000
To: linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
From: Emil Kronborg <emil.kronborg@protonmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Bluetooth issues with hci_sync after v6.4+
Message-ID: <4o3o7jaskrim3aajexbhlxn46d3ej5y6bjwe6htevzywgymn7d@uvdewtfe444z>
Feedback-ID: 20949900:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

After updating Linux on an i.MX28 board, I encountered errors related to
Bluetooth:

$ journalctl -p3 -xb
(...)
Feb 06 14:05:49 hp1 bluetoothd[183]: /usr/src/debug/bluez5/5.69-r0/src/adap=
ter.c:reset_adv_monitors_complete() Failed to reset Adv Monitors: Failed (0=
x03)
Feb 06 14:05:50 hp1 bluetoothd[183]: Failed to clear UUIDs: Failed (0x03)
Feb 06 14:05:50 hp1 bluetoothd[183]: Failed to add UUID: Failed (0x03)
Feb 06 14:05:50 hp1 bluetoothd[183]: Failed to add UUID: Failed (0x03)
Feb 06 14:05:50 hp1 bluetoothd[183]: Failed to add UUID: Failed (0x03)

I found that [1] encountered similar errors, which were addressed in
95b701543305 ("Bluetooth: btusb: Fix bluetooth on Intel Macbook 2014").
However, the board I am working with uses the Bluetooth HCI UART driver
instead of the USB driver. After bisecting, I identified the offending
commit as d883a4669a1d ("Bluetooth: hci_sync: Only allow
hci_cmd_sync_queue if running"). While reverting the commit would
resolve my issues, I am uncertain if this problem is unique to my setup,
as I have not come across other reports for ARM boards or the Bluetooth
HCI UART driver. Do you have any ideas how to solve this? Any pointers
are appreciated.

Below is (some) of the log when running the daemon in debug mode. I only
included part of it to not clutter the mail. Let me know if you want the
full log instead.

$ /usr/libexec/bluetooth/bluetoothd -n -d
(...)
bluetoothd[384]: /usr/src/debug/bluez5/5.69-r0/src/shared/mgmt.c:send_reque=
st() [0x0000] command 0x0053
bluetoothd[384]: /usr/src/debug/bluez5/5.69-r0/src/shared/mgmt.c:can_read_d=
ata() [0x0000] command 0x53 status: 0x03
bluetoothd[384]: /usr/src/debug/bluez5/5.69-r0/src/adapter.c:reset_adv_moni=
tors_complete() Failed to reset Adv Monitors: Failed (0x03)
bluetoothd[384]: /usr/src/debug/bluez5/5.69-r0/src/shared/mgmt.c:send_reque=
st() write failed: Network is down
bluetoothd[384]: Failed to clear UUIDs: Failed (0x03)
bluetoothd[384]: /usr/src/debug/bluez5/5.69-r0/src/shared/mgmt.c:send_reque=
st() write failed: Network is down
bluetoothd[384]: Failed to add UUID: Failed (0x03)

And here is some information about the device. Note that I anonymized
the MAC address.

$ hciconfig -a
hci0:   Type: Primary  Bus: UART
        BD Address: XX:XX:XX:XX:XX:XX  ACL MTU: 1021:6  SCO MTU: 180:4
        UP RUNNING
        RX bytes:5761 acl:0 sco:0 events:494 errors:0
        TX bytes:70546 acl:0 sco:0 commands:494 errors:0
        Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF
        Link mode: PERIPHERAL ACCEPT
        Name: 'BlueZ 5.69'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Version: 4.2 (0x8)  Revision: 0x0
        LMP Version: 4.2 (0x8)  Subversion: 0xac0f
        Manufacturer: Texas Instruments Inc. (13)

Let me know if I can provide more information.

[1]:
https://bugs.archlinux.org/task/78980.html

--=20
Emil Kronborg


