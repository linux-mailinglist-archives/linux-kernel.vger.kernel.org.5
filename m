Return-Path: <linux-kernel+bounces-81202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D08671ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9FB1C28B89
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F555790;
	Mon, 26 Feb 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DVwvJSXc"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FD454F9F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944298; cv=none; b=EX1+Ct5bRdPOR/KlAUkfmfDXB+S6jW9RjfSjjCxrSCsG/Zo28dFA6n6svoZ3q3yv9uVnTeZrNhcrvJmIcyP2ysIOZNC2+5vcn7bLH9HypKWpr6MP4PcQAhfvt+SKJUCokoXCDgTfOldi6FMFhFkXILjbnKI7KVcD5AxbJ8lBGZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944298; c=relaxed/simple;
	bh=nj7tYez+LHia6toK2y4Hm7RfLH1JHuWltTwOQmbktg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjyHXPJPT/48DfyX9d0Yf7di8qjsuwDG7uYsMd9x/9/gRapsigv/AcqE0momzzubAbRuWz6dqojxFJt+X/MDtWmwbHSDCeI2yp8WznDS0D4jYLNzMFyVfM/dCaNdQsVQuLtTj0BjuhZOyL3P+xm7d4tsLrAXI+NF5nw0625NvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DVwvJSXc; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF8E860004;
	Mon, 26 Feb 2024 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGgPJz7fSzd/AZd1yCsvBP21oXYDl6x0rUru9QRjD0w=;
	b=DVwvJSXc5bXXPn2OPpJw7oRqWLPyrxYwOS3U3LQ/yXluXgLPB8m7RJsSCoqZgY1P20oC64
	qllddgqLbaLor00kNBhegbQIVaGaKDOmgvk6sHoR4HyP4SGAE1xX9QDLLR8UGeVWB5cysR
	bBdJy2znddpu9ejf/buZ5G48djWvNj3SiUtJuT+SQ4k90crC1gkxfcIKVwRq5VMMgNKokE
	ynUOOV3c9mdL+oSNN1TelRJU62h0pvjpTo0ZjvYIhKbrRc6aSdKBgt8iC9J2ORJ9fUdXuM
	6p+hWmfX+IrtkE7Ij4Mrhfq23om1OPNsKQynZXuRKALOGTXzC8LscfZmVv4QYQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Roland Stigge <stigge@antcom.de>,
	David Woodhouse <David.Woodhouse@intel.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: rawnand: lpc32xx_mlc: fix irq handler prototype
Date: Mon, 26 Feb 2024 11:44:52 +0100
Message-Id: <20240226104452.490015-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213100146.455811-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'347b828882e6334690e7003ce5e2fe5f233dc508'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-02-13 at 10:00:09 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-16 warns about mismatched function prototypes:
> 
> drivers/mtd/nand/raw/lpc32xx_mlc.c:783:29: error: cast from 'irqreturn_t (*)(int, struct lpc32xx_nand_host *)' (aka 'enum irqreturn (*)(int, struct lpc32xx_nand_host *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
> 
> Change the interrupt handler to the normal way of just passing
> a void* pointer and converting it inside the function..
> 
> Fixes: 70f7cb78ec53 ("mtd: add LPC32xx MLC NAND driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

