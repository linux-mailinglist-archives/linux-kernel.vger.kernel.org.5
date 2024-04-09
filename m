Return-Path: <linux-kernel+bounces-136314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427E89D28E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60541C21C61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103A762CD;
	Tue,  9 Apr 2024 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fYI4zuGn"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434743AA0;
	Tue,  9 Apr 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644895; cv=none; b=imj0OaYIfZ7x/yv4nUfAowXllMHqZeae1rl6NiD4ZZo/RX9KPewLZdnbAyAmMCQZCzL+hWMvffyzng2UjDt3gff8fil8BitlzaVEd+M31MzuCfa7tcR7qy9RzQcqp/EJkDTNUvE/wN6q5NCN5/QDOe3oSg2FCL6zLvIqKtxW+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644895; c=relaxed/simple;
	bh=hxeo5rb2iQBEwCq5OE7G7hH2PBbVJx1koBtju/YhOjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7zn9phMn/f5VaShHJvGlNPVRvm9uAd33NAasZpS2AYtX9SMPEdKfRQVkA/sUcnmP8zAx31LiwcE+tKt6m9uE+XsGjxcIN0iG4rJD/bGr3RrYrbYgERA1fslDa9MLXldetjHwJfIRMe1gCDCH0BvgqeQ0KwR7N9U1h1aa39qcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fYI4zuGn; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 609D9E0004;
	Tue,  9 Apr 2024 06:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712644890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oe7RFp+BwBZoK6hQUNiwVYCnvZd3pMjzXOyJ9JrbiaU=;
	b=fYI4zuGnf6GcgsRjKcnjOxuKk6eZPkxJTiBAAJNyeAI1vg629CeJxfSh3Xjp0iyLYXAX1q
	MNmozJ0hcpa3MrnPNWQiTnZR5VwHhYsWTFUsjJcIbtk6FtytGQqmdB3LXzwC3SPn5oQWex
	RTi62PX4vWdPRkuf/WOxzSXVZ4fLSJSzYRlym7GNOUmdv0E8a4aLD92RSysQPGPGDE3KIL
	FCxZ9NGNAyCXw+ZEKhK2PFyCKaBcquQqmjs8g5dW9FZV6R7uSOhpMNgxYrRPYnhz/grtQS
	bfVu4WjB1h2gVBqVBhe0KfhCMCSM9PWaSD8NA6pmcTUE/B4Z2nOSsv+xxVAGwg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	stable@vger.kernel.org,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: diskonchip: work around ubsan link failure
Date: Tue,  9 Apr 2024 08:41:27 +0200
Message-Id: <20240409064128.91899-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240405143015.717429-1-arnd@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'21c9fb611c25d5cd038f6fe485232e7884bb0b3d'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-04-05 at 14:30:04 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I ran into a randconfig build failure with UBSAN using gcc-13.2:
> 
> arm-linux-gnueabi-ld: error: unplaced orphan section `.bss..Lubsan_data31' from `drivers/mtd/nand/raw/diskonchip.o'
> 
> I'm not entirely sure what is going on here, but I suspect this has something
> to do with the check for the end of the doc_locations[] array that contains
> an (unsigned long)0xffffffff element, which is compared against the signed
> (int)0xffffffff. If this is the case, we should get a runtime check for
> undefined behavior, but we instead get an unexpected build-time error.
> 
> I would have expected this to work fine on 32-bit architectures despite the
> signed integer overflow, though on 64-bit architectures this likely won't
> ever work.
> 
> Changing the contition to instead check for the size of the array makes the
> code safe everywhere and avoids the ubsan check that leads to the link
> error. The loop code goes back to before 2.6.12.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel

