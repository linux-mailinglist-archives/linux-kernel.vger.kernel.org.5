Return-Path: <linux-kernel+bounces-109920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A968857C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5140C1C21C32
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569B58129;
	Thu, 21 Mar 2024 11:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dcr67GiT"
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678358213;
	Thu, 21 Mar 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019154; cv=none; b=RYjOQg9Gt989MEZzg/WmKvB4Hx9ObSYasz15Gu74LoJb8ONFpnNJE+mwB8/LTwok/suCG0iFia/S19ccUDvvOcL/SRTIfb9LNx0CMdZ1EtXEwkqvFkPPx3J6h6dJapu88r/vlfrJMnSwaY6SGY/D8Ne8sd66gm1P98w9agRgJN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019154; c=relaxed/simple;
	bh=Rz/7QeGwGWVQ23cVl//CoUspDWwVdJjOPTplV8dC39E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NgIkSseUpjJu3QdLf9EQToCKpzfrAMe2YnhktU/Q1HQF+91W7H2WnyRT1cl/1K+EzqFAXC6btvHNQgLbcliGhvO026Oj+mEvYM7kig6+AzWZehCqWLkKmlemWDoTbk8AJ+Zmrrg8XsR76GrmBagHKVCT9YMXbwRuh6R3tihrKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dcr67GiT; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4619:0:640:d09:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id 78E3C60A8A;
	Thu, 21 Mar 2024 14:05:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id D5EwJf8ZnW20-cjVk97x4;
	Thu, 21 Mar 2024 14:05:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711019141; bh=si9CmxfbTTi+fzS7ZgV1gg2/IENW5eLorkGc5P/t0aU=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=dcr67GiTKWsuoYVCZRSpl/qun0eAAaOuBKZKzi2EHDixj9XLJRPUeDgpyPvExYdKg
	 VZHmGVfmvFhFeAoMUPEvWv6g+SeSk0hClHp5O3Ty4qC/Z1+i3w8i/laOqXOnRVfOYS
	 denliSur7IfAyXRY3cRJa76KOekeR/6P57HDnUew=
Authentication-Results: mail-nwsmtp-smtp-production-main-38.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>,
	Mikhail Ivanov <iwanov-23@bk.ru>
Subject: [PATCH 5.10/5.15] scsi: add a length check for VARIABLE_LENGTH_CMD commands
Date: Thu, 21 Mar 2024 14:02:29 +0300
Message-Id: <20240321110229.9534-1-mish.uxin2012@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
ata_scsi_pass_thru.

The error is fixed in 5.18 by commit
ce70fd9a551af7424a7dace2a1ba05a7de8eae27.
Backporting this commit would require significant changes to the code so
it is bettter to use a simple fix for that particular error.

The problem is that the length of the received SCSI command is not
validated if scsi_op == VARIABLE_LENGTH_CMD. It can lead to out-of-bounds
reading if the user sends a request with SCSI command of length less than
32.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Signed-off-by: Mikhail Ivanov <iwanov-23@bk.ru>
---
 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dfa090ccd21c..77589e911d3d 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4065,6 +4065,9 @@ int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
 
 	if (unlikely(!scmd->cmd_len))
 		goto bad_cdb_len;
+
+	if (scsi_op == VARIABLE_LENGTH_CMD && scmd->cmd_len < 32)
+		goto bad_cdb_len;
 
 	if (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ZAC) {
 		if (unlikely(scmd->cmd_len > dev->cdb_len))
-- 
2.25.1


