Return-Path: <linux-kernel+bounces-123130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5E89028D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FFB42955F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180D912FB0E;
	Thu, 28 Mar 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="FdWvpB8g"
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B0E12F59C;
	Thu, 28 Mar 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638050; cv=none; b=MG+WVrEv/OySqbpaGcf1Dz79evrAgfX/ysL0wsBqRc/cF0HRCcp5xx3vo4X/IgB0KgeoIvyaGKQz7DXT9jy3xSDPKMzEty16ohQVvJUL55OzXefABtJL7hS5XAALJ49ZsZizZqBW1ziuNeRPrE8YIefrLzqaS7uY0vktM7a4XIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638050; c=relaxed/simple;
	bh=RPApgADsKlI29chKvdFy7O12Bng/LmzDghTbECdn9Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hO6h4aJEtPPkDNIPDl9nNuRfcL1kuRz8V0jiguTj/5jWgmOpm8bVVAF3qoqJsYDsejPe81K7WUuLKIhf0jlc+qI8v0zcFvbq2VRxnAx6uI/YKCVLbG7pVFhG/U7bZyzYbyfbJHPH5spsG4Tvx9vvTxsn7NgqyWqoySuIoeDwWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=FdWvpB8g; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:a33:0:640:d837:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 4A4E260B30;
	Thu, 28 Mar 2024 18:00:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id W0PPosAetiE0-QIB3q1ZZ;
	Thu, 28 Mar 2024 18:00:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711638043; bh=EhuReZ9ZlrI84XoRVD7915LFMz58XbYYesStZiY24qI=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=FdWvpB8gA8a2Kh3dRx5zF7roYDfXz6QoaoH/oQ0RRs7FnSwQeF1fLGnilBQrD1I7/
	 62j/erUwvTIPDN9sIx603VpSAooEQe1p6AKzOXKYQi9rAXN6/AFyBqnEckY54Pqira
	 l+5ufyhOxqPesjMjr0QIHxbSoIeuu7uxsQ62kwUs=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
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
Subject: [PATCH 5.10/5.15] ata: libata-scsi: check cdb length for VARIABLE_LENGTH_CMD commands
Date: Thu, 28 Mar 2024 18:00:26 +0300
Message-Id: <20240328150026.9129-1-mish.uxin2012@yandex.ru>
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

The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
cmd field from struct scsi_request").
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


