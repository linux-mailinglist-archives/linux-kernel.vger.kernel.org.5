Return-Path: <linux-kernel+bounces-14405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA8821C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D8EB2199D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A6101C3;
	Tue,  2 Jan 2024 13:33:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9632AFBE7;
	Tue,  2 Jan 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4T4DLz07j3z9t1C;
	Tue,  2 Jan 2024 14:33:15 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	asahi@lists.linux.dev,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/4] Power off HCI devices before rfkilling them
Date: Tue,  2 Jan 2024 14:33:06 +0100
Message-ID: <20240102133311.6712-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T4DLz07j3z9t1C

In theory the firmware is supposed to power off the bluetooth card
when we use rfkill to block it. This doesn't work on a lot of laptops
though, leading to weird issues after turning off bluetooth, like the
connection timing out on the peripherals which were connected, and
bluetooth not connecting properly when the adapter is turned on again
quickly after rfkilling.

This series hooks into the rfkill driver from the bluetooth subsystem
to send a HCI_POWER_OFF command to the adapter before actually submitting
the rfkill to the firmware and killing the HCI connection.

Jonas Dreßler (4):
  Bluetooth: HCI: Remove HCI_POWER_OFF_TIMEOUT
  Bluetooth: mgmt: Remove leftover queuing of power_off work
  Bluetooth: HCI: Add new state HCI_POWERING_DOWN
  hci: Queue a HCI power-off command before rfkilling adapters

 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/hci_core.c    | 33 ++++++++++++++++++++++++++++++---
 net/bluetooth/hci_sync.c    | 16 +++++++++++-----
 net/bluetooth/mgmt.c        | 30 ++++++++++++++----------------
 4 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.43.0


