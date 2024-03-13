Return-Path: <linux-kernel+bounces-102587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9987B44B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4CD1F228DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733C5A0F6;
	Wed, 13 Mar 2024 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EoelQSV3"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293DD59B4A;
	Wed, 13 Mar 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368605; cv=none; b=GGrcnIuEpLvDGY/pSjguYOavxXrNrzH1G2H4AmN38JYuI8kXUeCEy9oPd5+f58uHKC9T4VPkBXe74VukdW9mCIaSLFBykg9O3MQ1mtbPUWY/68YdkbH+u9CRGaaqoZT+4x08quvdILoPe1VKoXf1z/gqYA3un8hGsdKALaYMOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368605; c=relaxed/simple;
	bh=a8Sh3dNbafbG/9FnX5AWeGa/mggShESsl2IMd9EzZtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsOLwT4OaEqg3UtwlTkmlXzPYkGylKxgn2XVOCaidK3bo8NGpX71B2N89hrzkHn+lOPGfNr2ryNau5VcJY1iJLPENX1+SvgASdQr+17HDamnBkxA9aH6CwjBFkrpJ6r4KYL0jv0ZtpjhQCo/KiZYFVwwm6PgFfCk+DN5wTH4zdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EoelQSV3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D03211BF204;
	Wed, 13 Mar 2024 22:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710368599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LF1DgETq3+uAOl/bFUlSXoTzHAoPYEGhBrdRccuLQQ=;
	b=EoelQSV3syJ71nv3hScMYI/oP/f38N7nV2KbckHkGwKn3GP/6MVb3kUVskLwVuEv33dSpb
	S0swiDDtCYQJPmeOwt/pEmh8F3XF2lPPsfWsLs98O0L9wwaOqSNfqtaZSr+6Ga6BCPyWM+
	vus4WQYwUx0dsD2xPAs/syXMYWLvEl6ORZcJNCUTYxy0O8MeZ868zgJvn80aSO9PcvqVyX
	XkcQOcLcaGBY+CFd99rTkp9TmnWrvXnVpzKgkbdthBHoLGeYw207Z0H4k3KJe921NqZB5u
	29RdXywPV7g6Ny4IgGqZKQMDLivSZwNJC9xIFAh2vVahZFGUP8sxhGfETnXo/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: core: correct type of i
Date: Wed, 13 Mar 2024 23:23:13 +0100
Message-Id: <20240313222313.800965-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304090103.818092-1-usama.anjum@collabora.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2842dc9bc1a53893eec62ec9e49beb3b501702d0'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-03-04 at 09:01:03 UTC, Muhammad Usama Anjum wrote:
> The i should be signed to find out the end of the loop. Otherwise,
> i >= 0 is always true and loop becomes infinite. Make its type to be
> int.
> 
> Fixes: 6a9eda34418f ("mtd: spi-nor: core: set mtd->eraseregions for non-uniform erase map")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

