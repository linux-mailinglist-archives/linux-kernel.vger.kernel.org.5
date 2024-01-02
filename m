Return-Path: <linux-kernel+bounces-14700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD48220E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D87B22821
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09A156FA;
	Tue,  2 Jan 2024 18:19:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603C156E1;
	Tue,  2 Jan 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T4Ljd1DTkz9sRn;
	Tue,  2 Jan 2024 19:19:49 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/4] Power off HCI devices before rfkilling them
Date: Tue,  2 Jan 2024 19:19:16 +0100
Message-ID: <20240102181946.57288-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In theory the firmware is supposed to power off the bluetooth card
when we use rfkill to block it. This doesn't work on a lot of laptops
though, leading to weird issues after turning off bluetooth, like the
connection timing out on the peripherals which were connected, and
bluetooth not connecting properly when the adapter is turned on again
quickly after rfkilling.

This series hooks into the rfkill driver from the bluetooth subsystem
to send a HCI_POWER_OFF command to the adapter before actually submitting
the rfkill to the firmware and killing the HCI connection.

---

v1 -> v2: Fixed commit message title to make CI happy

Jonas Dreßler (4):
  Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
  Bluetooth: mgmt: Remove leftover queuing of power_off work
  Bluetooth: Add new state HCI_POWERING_DOWN
  Bluetooth: Queue a HCI power-off command before rfkilling adapters

 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_core.c    | 33 ++++++++++++++++++++++++++++++---
 net/bluetooth/hci_sync.c    | 16 +++++++++++-----
 net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
 4 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.43.0


