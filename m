Return-Path: <linux-kernel+bounces-116820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF588A43C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE301F3EB38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC5B18D89A;
	Mon, 25 Mar 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DzcHDIlI"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC112A147
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362069; cv=none; b=Kys6w6iS9aT6WFZozoST4iLuO+kcf1SqAxT8vTjBVHBAM8bt0tSPv0RDksuGj587TkHI4KAK7hyRBqANkfBT4c/qfc71FwgArdWSvnVrLJPpgGw9alExykGYYDXYLK/pcvtpU6QN8pxRR+OS/UZyhGoKXHi5WI3RGMqh14iAv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362069; c=relaxed/simple;
	bh=ukM/PmOSEhPCGm07GAprsYA0zMF2NT+TMuGk6HOCLFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyrCS7mgs6kaFj25rpmwWSpJAI5FVHCkJYQ/9tJVSehjmuxNZGgHOPk/XSD0PmqBcSQmyjIpHCIwZhbWCs4cfaoQ3zy4gBhMnvmBN4HFoeEYf9deeqG53lEE6NY+m56UTYVSXz5tczHzMEHkZDhBuD7g/zYdZW28vfh90foK5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DzcHDIlI; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 450D81BF20C;
	Mon, 25 Mar 2024 10:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711362059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4tr6jXQo2B5No46bghO0NGB40nWqUW2K62Prsk80Uc=;
	b=DzcHDIlIwgk7EUTx5YG/SrQySAXw0X1+RbEVKalYXWFpidoRWeP7FtH5UXIiCqfOeEaQD1
	DgLu3bzV46BP9GyU5tj2WD+XuZfNIea/ZwHw5+pXlu1qNtYcOb/kc3gf33jLdHN37p3S4G
	Zf05loldfDABtbc+j55AUMOB+9MmQrv3jgqQ4Y94sk9QHhgsgQSEhhfngNfQsahW5YOAHo
	lp48eIl4o/dWpmcxL8M6DGf0k72HjsUYZN6tgZV2bwxqQQhjw2t7ttiInYMorOBiyGlbp4
	IkUV3dB3DWWRc2L/yVtZfxzRILJ9kIynFeZNqoQ14yx5uLYqrP6IZqhT7gEr9A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Hector Palacios <hector.palacios@digi.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] mtd: rawnand: hynix: fixed typo
Date: Mon, 25 Mar 2024 11:20:57 +0100
Message-Id: <20240325102057.262963-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6819db94e1cd3ce24a432f3616cd563ed0c4eaba'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-03-13 at 10:27:20 UTC, Maxim Korotkov wrote:
> The function hynix_nand_rr_init() should probably return an error code.
> Judging by the usage, it seems that the return code is passed up 
> the call stack.
> Right now, it always returns 0 and the function hynix_nand_cleanup()
> in hynix_nand_init() has never been called.
> 
> Found by RASU JSC and Linux Verification Center (linuxtesting.org)
> 
> Fixes: 626994e07480 ("mtd: nand: hynix: Add read-retry support for 1x nm MLC NANDs")
> 
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

