Return-Path: <linux-kernel+bounces-81205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4A8671F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C01328E814
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2556466;
	Mon, 26 Feb 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YSM5//Dj"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC655E79;
	Mon, 26 Feb 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944308; cv=none; b=RGc+qEB3GrMZwccqwJEDUfuiHacIClL5YGV2+JWs6uiG7GxopEoVWWznDd6FpcqFCDmNRNnsUQ6wllJWWYiM+J15oiTEZVPLBEdSei9it7qBugKyqMPYiH+7Pqo5V4eAQ1nrBa5CuXhjCYZppXSVw6lUEl1n/6RwSsPHjXyZEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944308; c=relaxed/simple;
	bh=5hRWP8w7u3GTMa9wrvVcIUEgllEBtm+WJ7H/wCNR8Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mb3Ecwc5naMKneDTHxQ99HDm64itFvCxLb895ppNS8baF4TT6z3bxP/+MkM4LUqiAY+q1ynKZ7M0hjzat8v+S/BTjfKUOmq5CpA0nYKRqoywHf5WyoUIAm9dhzx1pFKjSQpoZBZrzZabnEnjxv+QVznXaCOuwSHfGAiU8gePq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YSM5//Dj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D84DDC0003;
	Mon, 26 Feb 2024 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYWYbEcL0LZiU1LAQRsUtVSe1ESaZH+8FD5tt71//JQ=;
	b=YSM5//DjDEbFXDh9KyH1O/eN8heVsBdAQQZ0iqQtWj1AP0ldH9kdTgwddeTIXFmc9Ojksk
	/VTLysgF67xFxszfyivlSH/hdK0BCEPJ/vnDY7PAAiUhKiUq0hIt9ZoFQ23PcTF3papF57
	nvH5JrYa8UiZz5DGiK5jjmEr3hpVZEzQA6JmVcmShsDDD4O/zaHaynjj2JZrhvo1u7qsPI
	194ywQTXoyjqlT579aRYs2iiL3vw+N5lX5gDEaUf5k96GmFItPab69JcLC/d61JYlGwZ0p
	A2QoWIthMxKLztvhbWVtBlAgnMammBIabSzqGmK3OlqhQ4z6D8Yj7YaIyo66og==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Colin Ian King <colin.i.king@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: remove redundant assignment to variable bbtblocks
Date: Mon, 26 Feb 2024 11:45:04 +0100
Message-Id: <20240226104504.490157-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209174019.3933233-1-colin.i.king@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9367043f1c02a1e4bc3ee50df2772c7c557ce617'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-09 at 17:40:19 UTC, Colin Ian King wrote:
> The variable bbtblocks is being assigned a value that is never
> read. The assignment is redundant and can be removed.
> 
> Cleans up clang scan build warning:
> drivers/mtd/nand/raw/nand_bbt.c:579:3: warning: Value stored to
> 'bbtblocks' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

