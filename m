Return-Path: <linux-kernel+bounces-81203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659398671EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087081F28DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28320487B4;
	Mon, 26 Feb 2024 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PbNfK+Fe"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DC55C01;
	Mon, 26 Feb 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944301; cv=none; b=RgJSl8+k4xco9Ln9keU4uFxnr5MAp5NHSA4DXxYSSkjsQQx87kn9slSdN4nlrEesaRqpI735Seio/V1hngM8bF10G0uz8ecOdiSDIMHy8mXzP/AViBy3sRc/tIOw3NH7jWjRIFnHCxfRKjGkJWZ/gtiJZEzAV2C81xgPRPa9O90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944301; c=relaxed/simple;
	bh=dbzJ5HplGKB0UbVpYH6JV4HOfKZddkYMfHSn2nxZab8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0fwZ3iIk82v86fVw7L5GalhKfSIZzIuTm7/j7ieuhHKuzO68YI3eMiab+jrDYpqB7wFDx3lpzHSdhLPNjIro+8BhcsmY3uhVHcrtaQXBY+zLs5voJZPW/lul7h8MqWtjbNgWMkXsmYczsTAjnOyZqydJgiYvL5wOFbHkXkhCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PbNfK+Fe; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F18C060005;
	Mon, 26 Feb 2024 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zL/Tgozd757x0uspKJ/QO1fI2sa1DUP6bzOx+70NEX0=;
	b=PbNfK+FefzTpRRZZaLv6nXskQ+mmjm6jtVHrDL7HRvcQUxrt/ON5CBHIra+IRzW5oSP3mC
	qL0rcEu5cs9tcn9SnBMBL/eM1OxBZfSwfB/j6BSbxCBBSPT6hoADU1JUblR3QK5LVJSHMF
	MhmzEaiQP7PPOzilGKqZR8Pxp1pjllqW51/TO2+/XDxIS1lzGDEMpvXjGzbNIOhYVx13eA
	S/xIGuK89v2kZwSrZJ0PAF4SxW3+AiVnLiFBfq6vNJwE0hVbsNPyME4lPuM/CUu/mGz3z2
	4ck9hwW45k2IESMkzf5Mdo+mppFvwVwPNaY81MpS+5bJR5rghPxnyXJmZ74hiA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Erick Archer <erick.archer@gmx.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Li Zetao <lizetao1@huawei.com>,
	=?utf-8?q?Uw?= =?utf-8?q?e_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: Prefer struct_size over open coded arithmetic
Date: Mon, 26 Feb 2024 11:44:56 +0100
Message-Id: <20240226104456.490065-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240211091633.4545-1-erick.archer@gmx.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e395036504c4e19d15ba64543a4c3beca373f7a9'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sun, 2024-02-11 at 09:16:33 UTC, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> As the "chip" variable is a pointer to "struct mtk_nfc_nand_chip" and
> this structure ends in a flexible array:
> 
> struct mtk_nfc_nand_chip {
> 	[...]
> 	u8 sels[] __counted_by(nsels);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + count * size" in the
> devm_kzalloc() function.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

