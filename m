Return-Path: <linux-kernel+bounces-79036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE2861CAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E000B286423
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4221468E8;
	Fri, 23 Feb 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZ+SNR75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F81448E7;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717025; cv=none; b=DFA9wM0Isz2rHo8ZWGEY8YTSbAYuX0Cb7qVipmEB6t5917GWgi/nadptyScHlbOt3ufopAJTfcBGO4GqTSYP18PlSwvf+axRZGT2fymialOyWRjwhFT5GRneEEJr4X0Rrq1fPUUZp4bKh9pV23it9F+wSJBsUB5M+Qjt7uPIPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717025; c=relaxed/simple;
	bh=Taq9zZXEuHop6oOVmeOcYk2VH2LXPBW64JCCgCMPo0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ejmw4B5IdVBr676gL8ivQDf3Ju1d7hF4+/lcR/9GOIWWwbElyzilBlbM5pZmng2cCNaN3kTgMOThgzoVR225ssbLLUMann1drTAtQBDNT5icqxH/RBNBWKHeOrfaowMj2zClX33G0SyGNitZourfwj7VApR68xGBj2irDybJ4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZ+SNR75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9BFFC43399;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717024;
	bh=Taq9zZXEuHop6oOVmeOcYk2VH2LXPBW64JCCgCMPo0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tZ+SNR755LXQJveMS4oSWqODRHhIqYCow5DlvPGxxhSofZ9itYKbIDlnRW6SPE/Sw
	 GIufooeq/g3Txs5HedOXR8GbV/mzfaKeTDbzV7MRWK6l4wOu33dLLDSmHEwWIAvui+
	 Zlt73W07DxNbwyvnfC92rf3xFjw81csgP1EkV1HWK2qhuZEGSrhH4SJKIeVrXBGVhI
	 nm3L2zL8c1451GKtQTbKP4Gw8H8TOVejUTxz3Ws8aOYKRC5zcSQNuLH99xu9C2MCCB
	 dJfQ7mpIPBxOcDkDpJ3BvpYcPTz+0o2xOaiaaZ0BTxi/gladdb4jK3vc/XsE0XLzCj
	 bzHwn5/edD3AA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8BC5478C;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Fri, 23 Feb 2024 20:36:50 +0100
Subject: [PATCH 4/6] usb: host: uhci-grlib.c: Fix build, add
 platform_device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240223-sam-fix-sparc32-all-builds-v1-4-5c60fd5c9250@ravnborg.org>
References:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
In-Reply-To:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708717023; l=843;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=sqg/lm4wXEPuq1ytjSL9tNUQrRYWPLYkbsaS7YxPZOY=; =?utf-8?q?b=3DYf6oyH4OQPmC?=
 =?utf-8?q?CmYgJxW7N28fyQCoMKKSNxs0vlLUK+Lg5W2SRp3H7IsbaZO1i623Y9GP7SuTpFfy?=
 25H90LSdBlCgPq5t3KXirIB1wjdzTcK3MRLjedm+C9KL9F2qtvOb
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

Fix the followig build error:
uhci-grlib.c:92:29: error: invalid use of undefined type 'struct platform_device'

The fix was straightforward, and no attempt was made to understand why
the build failed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/uhci-grlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/uhci-grlib.c b/drivers/usb/host/uhci-grlib.c
index ac3fc5970315..cfebb833668e 100644
--- a/drivers/usb/host/uhci-grlib.c
+++ b/drivers/usb/host/uhci-grlib.c
@@ -22,6 +22,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 
 static int uhci_grlib_init(struct usb_hcd *hcd)
 {

-- 
2.34.1


