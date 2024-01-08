Return-Path: <linux-kernel+bounces-19980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9908277CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A751C21271
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D154F8F;
	Mon,  8 Jan 2024 18:39:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0D54F83;
	Mon,  8 Jan 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T82sq1N58z9sch;
	Mon,  8 Jan 2024 19:39:43 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/4] Bluetooth: Improve retrying of connection attempts
Date: Mon,  8 Jan 2024 19:39:32 +0100
Message-ID: <20240108183938.468426-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
v2:
  - Move to using hci_sync queue for "Create Connection" and therefore
    always serialize those requests.
  - Follow commit message style better and properly cite patches

Jonas Dreßler (4):
  Bluetooth: Remove superfluous call to hci_conn_check_pending()
  Bluetooth: hci_event: Use HCI error defines instead of magic values
  Bluetooth: hci_conn: Only do ACL connections sequentially
  Bluetooth: Remove pending ACL connection attempts

 include/net/bluetooth/hci.h      |  3 ++
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 51 ++++++++++++++++----------------
 net/bluetooth/hci_event.c        | 29 +++++-------------
 4 files changed, 35 insertions(+), 49 deletions(-)

-- 
2.43.0


