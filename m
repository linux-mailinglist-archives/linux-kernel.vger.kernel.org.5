Return-Path: <linux-kernel+bounces-20158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F52827AC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BFA284E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBCF5645E;
	Mon,  8 Jan 2024 22:46:30 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B791DDDC;
	Mon,  8 Jan 2024 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T88LR4mJnz9sWf;
	Mon,  8 Jan 2024 23:46:23 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 0/4] Bluetooth: Improve retrying of connection attempts
Date: Mon,  8 Jan 2024 23:46:05 +0100
Message-ID: <20240108224614.56900-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T88LR4mJnz9sWf

Since commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
requests"), the kernel supports trying to connect again in case the
bluetooth card is busy and fails to connect.

The logic that should handle this became a bit spotty over time, and also
cards these days appear to fail with more errors than just "Command
Disallowed".

This series refactores the handling of concurrent connection requests
by serializing all "Create Connection" commands for ACL connections
similar to how we do it for LE connections.

---

v1: https://lore.kernel.org/linux-bluetooth/20240102185933.64179-1-verdre@v0yd.nl/
v2: https://lore.kernel.org/linux-bluetooth/20240108183938.468426-1-verdre@v0yd.nl/
v3:
  - Move the new sync function to hci_sync.c as requested by review
  - Abort connection on failure using hci_abort_conn_sync() instead of
    hci_abort_conn()
  - Make the last commit message a bit more precise regarding the meaning
    of BT_CONNECT2 state

Jonas Dreßler (4):
  Bluetooth: Remove superfluous call to hci_conn_check_pending()
  Bluetooth: hci_event: Use HCI error defines instead of magic values
  Bluetooth: hci_conn: Only do ACL connections sequentially
  Bluetooth: Remove pending ACL connection attempts

 include/net/bluetooth/hci.h      |  3 ++
 include/net/bluetooth/hci_core.h |  1 -
 include/net/bluetooth/hci_sync.h |  3 ++
 net/bluetooth/hci_conn.c         | 83 +++-----------------------------
 net/bluetooth/hci_event.c        | 29 +++--------
 net/bluetooth/hci_sync.c         | 72 +++++++++++++++++++++++++++
 6 files changed, 93 insertions(+), 98 deletions(-)

-- 
2.43.0


