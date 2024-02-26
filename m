Return-Path: <linux-kernel+bounces-81255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4611A8672B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E4028D10F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC771EB40;
	Mon, 26 Feb 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RAYgkdh2"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FA1EB23
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708945889; cv=none; b=jRMw58ndHJQp+a909IbVTkT1YsVs/ogs6kZxClO60xRGq+Xllqx2+ZsBdwnr+mn8KL3mwHbZfvDtzzjSZIQy7NxvFNeDsH6EQCc6X287khX6zaRXyoDK86ZvRI67G/50GXWRTq4lkAXRei/a6m6vcsXTTRABqcJ0qNq7PdCekt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708945889; c=relaxed/simple;
	bh=P9cU0vaYka19qwN3ginu+whrji0mzZMkVUdC+zBKbLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oYyZ3IAXstktW9ZpTiafZA3sdvPoKCku6JV/A+4XzBcgnPNpjcbaAPNNWKPCvsemiFONTAwYv2cYGRZKNux9g7czygxiVvO/mPw8ffmOQc7u7kgunBdOyhnhrRSCVXSfX0rFAcJyHHwo7Xsu83z+gaTfq8RSQyB9Ta2FvASh+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RAYgkdh2; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5806B240008;
	Mon, 26 Feb 2024 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708945885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zj+MygKb5ZUUUy0ooxu8lQ+0Uq7LCSNKhmYOAZa6N4o=;
	b=RAYgkdh2jRMqfDPoddRnnETB6wqNn8A9Gr7qYeshN/TM5cxEi+uL+2ZV7ktMsxAA0vYdVe
	Rk+fCyJewxbXJ2HQz3m/2q8zgoy8YRTzC5oPR6Mqtox6Sy/+s4TPs0mTCaLqk9WOfOD5ep
	EnzloJ5jZqMzEZ6+vPL43v0e/SkdIBZ3k+3vYUqV+NgV9t3EFI1fIF+UhqkKJ3GHnID4tQ
	eS286RGFp0/YJPhlCN/KYMKXaJ6T6lrzYbKgf6pm6StOn/FtU7KY/zyJCHK2pSSm6j7KuH
	ql+r4s5dAn+tdex0kyApdiHQDCaOINmAMQk75ChDQaTAJH3w6N/U4Kn5Dwuotg==
Date: Mon, 26 Feb 2024 12:11:24 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael
 Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 6.8-rc7
Message-ID: <20240226121124.0cad7cdf@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Linus,

This is a fixes MTD PR for v6.8-rc7.

Thanks,
Miqu=C3=A8l

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.8-rc7

for you to fetch changes up to e6a30d0c48a1e8a68f1cc413bee65302ab03ddfb:

  mtd: rawnand: marvell: fix layouts (2024-02-05 16:16:24 +0100)

----------------------------------------------------------------
Many NAND page layouts have been added to the Marvell NAND controller
but could not be used in practice so they are being removed.

Regarding the SPI-NAND area, Gigadevice chips were not using the right
buffer for an ECC status check operation.

Aside from these driver fixes, there is also a refcount fix in the MTD
core nodes parsing logic.

----------------------------------------------------------------
Elad Nachman (1):
      mtd: rawnand: marvell: fix layouts

Han Xu (1):
      mtd: spinand: gigadevice: Fix the get ecc status issue

Miquel Raynal (1):
      mtd: Fix possible refcounting issue when going through partition nodes

 drivers/mtd/mtdcore.c               |  1 +
 drivers/mtd/nand/raw/marvell_nand.c | 13 +++++--------
 drivers/mtd/nand/spi/gigadevice.c   |  6 ++++--
 3 files changed, 10 insertions(+), 10 deletions(-)

