Return-Path: <linux-kernel+bounces-51799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8706848F67
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738C0282208
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0492374E;
	Sun,  4 Feb 2024 16:49:52 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133FA22EF5
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065391; cv=none; b=oAFmtVB6A5Bv9MWQJhZDVbocLrm7PWkaWXs1cfwwqqfgwV5X369NQd72x3bjviWydg7Qxt2IOJY5bN/qp6RKjlCcdBG7cDtAyc0SJrc+sfgzmXrekWIYFeRUpi+s2GdH53eFOsiQXRcAfEzuPokA6jcDF7c9jwWWtZ2xoLs+10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065391; c=relaxed/simple;
	bh=ivjqsBI8+Zba2eGIulS9WoHh0xcvu95m4Jk4tFjIyQM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjbZ8Vd/H7VZMe1957iOCXrknRqmylr1RUBYHyTJdVwR8EDPcxViH/IC+nbgtKTDJ85OXBRnCOksXD1bRBgsFEDfRb05bd+02eq22jrr+mW7EN8MG377u0Kl+bM60gswzer3kZnX/P4K/ExSWwZPJEu1ksIhnkh5ffI4F19P6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-30.elisa-laajakaista.fi [88.113.26.30])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 66ab6094-c37d-11ee-b3cf-005056bd6ce9;
	Sun, 04 Feb 2024 18:49:48 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Sun, 4 Feb 2024 18:49:45 +0200
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Daniel Golle <daniel@makrotopia.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Johan Jonker <jbx6244@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v7 20/39] mtd: rawnand: add support for ts72xx
Message-ID: <Zb_AKQEBUB4Yg7JI@surfacebook.localdomain>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
 <20240118-ep93xx-v7-20-d953846ae771@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-ep93xx-v7-20-d953846ae771@maquefel.me>

Thu, Jan 18, 2024 at 11:21:03AM +0300, Nikita Shubin kirjoitti:
> Technologic Systems has it's own nand controller implementation in CPLD.

..

> +err_clean_nand:
> +	nand_cleanup(&data->chip);
> +err_handle_put:
> +	fwnode_handle_put(child);
> +	return err;
> +}
> +
> +static void ts72xx_nand_remove(struct platform_device *pdev)
> +{
> +	struct ts72xx_nand_data *data = platform_get_drvdata(pdev);
> +	struct nand_chip *chip = &data->chip;
> +	int ret;
> +
> +	ret = mtd_device_unregister(nand_to_mtd(chip));
> +	WARN_ON(ret);
> +	nand_cleanup(chip);

Missing fwnode_handle_put()?

> +}


-- 
With Best Regards,
Andy Shevchenko



