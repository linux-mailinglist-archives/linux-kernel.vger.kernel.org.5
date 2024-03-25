Return-Path: <linux-kernel+bounces-116812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D488A42B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CCE1C3B3FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F9133404;
	Mon, 25 Mar 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dWD8RPs0"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9512FB36
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361925; cv=none; b=b/fHcpQsDvJrObNnoStAkAX9KGE2ec6jU+9WoAusbzINes4MRGvWWTA3Pm7tZmTgr3y15kX/QHRYbDZrlGooZf303TSufiv7U8GRrdMcCE1slDvhIGEPCXsiuLQqF5mWzfNAS5+vTjVgSm5Y2iUm6AZG7IamWbeajsvqbJvHTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361925; c=relaxed/simple;
	bh=LXFbNseSlqWcAujIdt1RG39RSAi31ms+4VYhM8+xmdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uL96/LnbTxIcZqygYtYllq7WqEQM9nLoQhQ/N7tm1LlGkCsaS5nunYgSqrpuKVKQeaeLQQ0PCA+ahJfXT8y9F0D3kGvY3OF1c1f8Fdftfe9ffYT6b6g/oo/ciLerIoZeHE4TXSCcALlbdsrBQJrJmukJYMxs82TZ6i+Be0I5PE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dWD8RPs0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CEDD06000D;
	Mon, 25 Mar 2024 10:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpKxnGuq4NGSS31UqPNZH4kFPyky5wJE4aY0gNyw2nI=;
	b=dWD8RPs0pMCGzjjHxXqZvCvws7CodSuZGLD7A8aVgTcOZkd/pahag5M9XiL9Rqh9Z0QQfM
	aN9dRYgDpLjnCtAGKrDZbAvnSQxy7yYleSGz0iqj2+/1mIoEOmPwtH9j77O86h5aaOHWgl
	jXsrnjp590kJ5uO2f7oYdbSbBo6lzvuswaWm9QY0haB5k/6iVjid9XV2+FuFkeU7O5NZ3l
	OfUSkox+Zg/Hv8uR/X0lIoUgLxO8+G8aTi3rjcu2sYsmPHZWCYF74GB32yH0WRCVjgaOMK
	qTNZfbCb9WGaLhMXuCCf2IHfUEGdRTYJvT+FOG9rd9UThG39nNWnj4zvx1EyTA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>,
	Linux MTD List <linux-mtd@lists.infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	joel.peshkin@broadcom.com,
	f.fainelli@gmail.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	kursad.oney@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	David Regan <dregan@broadcom.com>
Subject: Re: [PATCH] mtd: rawnand: brcmnand: Fix data access violation for STB chip
Date: Mon, 25 Mar 2024 11:18:38 +0100
Message-Id: <20240325101838.262387-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320222623.35604-1-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4053caf60bb349ab9ea9e36ee30c64681b696198'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-03-20 at 22:26:22 UTC, William Zhang wrote:
> Florian reported the following kernel NULL pointer dereference issue on
> a BCM7250 board:
> [    2.829744] Unable to handle kernel NULL pointer dereference at virtual address 0000000c when read
> [    2.838740] [0000000c] *pgd=80000000004003, *pmd=00000000
> [    2.844178] Internal error: Oops: 206 [#1] SMP ARM
> [    2.848990] Modules linked in:
> [    2.852061] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-next-20240305-gd95fcdf4961d #66
> [    2.860436] Hardware name: Broadcom STB (Flattened Device Tree)
> [    2.866371] PC is at brcmnand_read_by_pio+0x180/0x278
> [    2.871449] LR is at __wait_for_common+0x9c/0x1b0
> [    2.876178] pc : [<c094b6cc>]    lr : [<c0e66310>]    psr: 60000053
> [    2.882460] sp : f0811a80  ip : 00000012  fp : 00000000
> [    2.887699] r10: 00000000  r9 : 00000000  r8 : c3790000
> [    2.892936] r7 : 00000000  r6 : 00000000  r5 : c35db440  r4 : ffe00000
> [    2.899479] r3 : f15cb814  r2 : 00000000  r1 : 00000000  r0 : 00000000
> 
> The issue only happens when dma mode is disabled or not supported on STB
> chip. The pio mode transfer calls brcmnand_read_data_bus function which
> dereferences ctrl->soc->read_data_bus. But the soc member in STB chip is
> NULL hence triggers the access violation. The function needs to check
> the soc pointer first.
> 
> Fixes: 546e42599120 ("mtd: rawnand: brcmnand: Add BCMBCA read data bus interface")
> 
> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

