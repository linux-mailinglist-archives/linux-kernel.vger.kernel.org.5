Return-Path: <linux-kernel+bounces-136311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9C589D288
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7E7284B73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4281A6E5EC;
	Tue,  9 Apr 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XH5Ev4Go"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8031A66;
	Tue,  9 Apr 2024 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644860; cv=none; b=V+H/4so7/71J5dy13CL6L5zMC9uYYXrzpIp/IORuQ3JiuN4ykBfbJZUUcmM/LD3lROOxACEayDPPUxUeuROz/sp9OeQuFWGWHo9oIQzfajpj/fn9vw8HJ4pqdqROBAL1D9o9KH5+r6BV8jtZYvnhcylQaGmfbWtgTAjlckpDTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644860; c=relaxed/simple;
	bh=GZxSAXRKtbGww5a6qfLWU9cez/PQgMG8rq5k8imZh/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNu4TEsBkXatl3OkaB5cI/x3k+QIb3g7kuC2Q6/Tws/Yk8mWAId3iqgupjbvfboYKWItkYhxIQjfSFmN8N+Xj+sKY33vYy7KWNvLFQig7RA4FWmzvzAoLyHPUcaaof5NDxV5+IdJTAW+rcQ+TMD5GaH4+VrqOHpq4vW4ade6Wmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XH5Ev4Go; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD3C91C0006;
	Tue,  9 Apr 2024 06:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712644855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jM/2z26pHl1ahZGM5qsx5eHbqGHFWgwdLhCwXDhXfU=;
	b=XH5Ev4GoCWiNGeuljZR2mZAVid1756rDIx9BMDPGPJEPuz/AnpYxKPJM5z4XBXWaP8nema
	Yoi+rYt/q0fY3akBTuLWmv1cxWW07fpVH1EIhtEyXQWB+rVPB+HzeMmvcMseHZwBPJIO6G
	P3fKNhH2aeb9DBvtR4t7LTO78ZhXyewJegqV4ze33Xtmwo0+DdHWcnju35j4Wtd2IdP8Bq
	BQycnPZP0DNTe7cpvXpFNUc+bXfxp36lrm23IXP88OOU4zzrBiur6rZTdAcy9JVi/j8NZO
	BC49GccZpVP6CKy5JtO8Hmca6lIrXkqwUlokzBzQ8P2iLNB5gFJiZokID1zF3g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Erick Archer <erick.archer@outlook.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: maps: sa1100-flash: Prefer struct_size over open coded arithmetic
Date: Tue,  9 Apr 2024 08:40:51 +0200
Message-Id: <20240409064051.91775-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To:  <AS8PR02MB7237AC633B0D1D2EBD3C40E98B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3ef4600f12269d489933b3835fe8d43621e4ee6c'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sat, 2024-03-30 at 17:55:35 UTC, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "info" variable is a pointer to "struct sa_info" and this
> structure ends in a flexible array:
> 
> struct sa_info {
> 	[...]
> 	struct sa_subdev_info	subdev[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + size * count" in
> the kzalloc() function.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

