Return-Path: <linux-kernel+bounces-14750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4E182218B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3162BB22594
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F09815AEF;
	Tue,  2 Jan 2024 18:59:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0D15AC7;
	Tue,  2 Jan 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T4MbW62Cxz9smm;
	Tue,  2 Jan 2024 19:59:35 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/5] Bluetooth: Improve retrying of connection attempts
Date: Tue,  2 Jan 2024 19:59:27 +0100
Message-ID: <20240102185933.64179-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T4MbW62Cxz9smm

Since commit 4c67bc74f016b0d360b8573e18969c0ff7926974, the kernel supports
trying to connect again in case the bluetooth card is busy and fails
to connect.

The logic that should handle this became a bit spotty over time, and also
cards these days appear to fail with more errors than just "Command
Disallowed".

This series tries to improve the logic for retrying "HCI Create
Connection" and adds support for two more errors that can indicate the
hardware being busy.

Jonas Dreßler (5):
  Bluetooth: Remove superfluous call to hci_conn_check_pending()
  Bluetooth: hci_event: Use HCI error defines instead of magic values
  Bluetooth: hci_event: Remove limit of 2 reconnection attempts
  Bluetooth: hci_event: Do sanity checks before retrying to connect
  Bluetooth: hci_event: Try reconnecting on more kinds of errors

 include/net/bluetooth/hci.h |  3 ++
 net/bluetooth/hci_event.c   | 57 +++++++++++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.43.0


