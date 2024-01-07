Return-Path: <linux-kernel+bounces-18940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC5826577
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438A61F21725
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA313FFB;
	Sun,  7 Jan 2024 18:03:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43313FE9;
	Sun,  7 Jan 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T7Q5t1ScCz9stL;
	Sun,  7 Jan 2024 19:02:58 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 0/4] Disconnect devices before rfkilling adapter
Date: Sun,  7 Jan 2024 19:02:46 +0100
Message-ID: <20240107180252.73436-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apparently the firmware is supposed to power off the bluetooth card
properly, including disconnecting devices, when we use rfkill to block
bluetooth. This doesn't work on a lot of laptops though, leading to weird
issues after turning off bluetooth, like the connection timing out on the
peripherals which were connected, and bluetooth not connecting properly
when the adapter is turned on again after rfkilling.

This series uses the rfkill hook in the bluetooth subsystem
to execute a few more shutdown commands and make sure that all
devices get disconnected before we close the HCI connection to the adapter.

---

v1: https://lore.kernel.org/linux-bluetooth/20240102133311.6712-1-verdre@v0yd.nl/
v2: https://lore.kernel.org/linux-bluetooth/20240102181946.57288-1-verdre@v0yd.nl/
v3:
 - Update commit message titles to reflect what's actually happening
   (disconnecting devices, not sending a power-off command).
 - Doing the shutdown sequence synchronously instead of async now.
 - Move HCI_RFKILLED flag back again to be set before shutdown.
 - Added a "fallback" hci_dev_do_close() to the error path because
   hci_set_powered_sync() might bail-out early on error.

Jonas Dreßler (4):
  Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
  Bluetooth: mgmt: Remove leftover queuing of power_off work
  Bluetooth: Add new state HCI_POWERING_DOWN
  Bluetooth: Disconnect connected devices before rfkilling adapter

 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_core.c    | 35 +++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_sync.c    | 16 +++++++++++-----
 net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
 4 files changed, 59 insertions(+), 24 deletions(-)

-- 
2.43.0


