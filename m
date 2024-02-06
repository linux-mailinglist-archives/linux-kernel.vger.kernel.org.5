Return-Path: <linux-kernel+bounces-54747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5F84B324
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D6828C66A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230112FF95;
	Tue,  6 Feb 2024 11:08:26 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE53E12F5A4;
	Tue,  6 Feb 2024 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217706; cv=none; b=IMI1UOk9H14eUrpPQLV6I01paFq74L0qoyHL0InoIZFyEtnvSmrlYe0HPBFc+Y8Psf88v75wwJjPMpOMP76U2zWiQM7LZrGFthHszwkxERky4XyyE6gu76eQXJB1+VDvZWclyg+L9jgSz4XOgLcgKgpZGhr+nwPAOCCETODksKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217706; c=relaxed/simple;
	bh=H0qiN5y21fJHbc3Gsib/vVUqbIRS/mAwqCfl/lTb+XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kulBcB0QG4p9SHR7ddU8sWSE4XlC2zpBHEJ0umKZmw32GzHhAkr2XZRUt3F4Fd6OuvyIkX4M44d2d6/VBFNo41Yce6bKJ9kkICB7vXfwfmoJCJry15rX8WppNNxZG1E5UEydbqMEHmss8SRFmvyzSqbL8v69aG9RzvX3hZo8vNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TTgTb2ztYz9sX2;
	Tue,  6 Feb 2024 12:08:19 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 0/2] Bluetooth: Improve retrying of connection attempts
Date: Tue,  6 Feb 2024 12:08:12 +0100
Message-ID: <20240206110816.74995-1-verdre@v0yd.nl>
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
v2: https://lore.kernel.org/linux-bluetooth/20240108183938.468426-1-verdre@v0yd.nl/
v3: https://lore.kernel.org/linux-bluetooth/20240108224614.56900-1-verdre@v0yd.nl/
v4:
  - Removed first two commits since they are already applied
  - Removed a BT_DBG() message in the acl_create_connection() function
    while moving to hci_sync because it seemed out of place in hci_sync
  - Added a mention of the test failure in mgmt-tester to commit message

Jonas Dreßler (2):
  Bluetooth: hci_conn: Only do ACL connections sequentially
  Bluetooth: Remove pending ACL connection attempts

 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 -
 include/net/bluetooth/hci_sync.h |  3 ++
 net/bluetooth/hci_conn.c         | 83 +++-----------------------------
 net/bluetooth/hci_event.c        | 21 ++------
 net/bluetooth/hci_sync.c         | 70 +++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 93 deletions(-)

-- 
2.43.0


