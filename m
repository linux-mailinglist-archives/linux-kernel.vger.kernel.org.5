Return-Path: <linux-kernel+bounces-149617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BE8A9383
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2571C20BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EECC2C6BB;
	Thu, 18 Apr 2024 06:48:20 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DE200DD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422900; cv=none; b=J5AjOr3bd2GajT6nEeGGomNZIxtjFZM3hPzKIRXOrH9rvEG2zpyKV3oWYO4eqayfI2TQVstYyxS3Eq8dGdAN8LLEyNPqqD30InHd9tJZkbtSLLUFNnOJQgrbofWbvGTKdPOUR43xagvht3mMp+FIVZofXXUJjjSdNrn1jvzNkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422900; c=relaxed/simple;
	bh=yb3o3xIWsyVwEILtcBGv9zgdhKQCsmYLCEHaDsy4ghw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqkgm79Mi6ixKMcTh9kD16V4FvvEM4MFHrT6DA4H7TWCEFLP5hHFEJCwG8BigJl5Yn8lVcS7GokcNB9Io8T/RTb1/h0jGMYzg8bwto8NvgZTvoQGTFWVfH+NmplvRm59LlN5XUYBTGjFvEgAvgYJLj7e2vwnm7MxJ1tQ+WJLMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rxLZ3-0001ho-Jz; Thu, 18 Apr 2024 08:48:09 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rxLZ2-00CvY7-CK; Thu, 18 Apr 2024 08:48:08 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rxLZ2-001SuO-0u;
	Thu, 18 Apr 2024 08:48:08 +0200
Date: Thu, 18 Apr 2024 08:48:08 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: nand: mxc_nand: disable subpage reads
Message-ID: <ZiDCKGlG4MZ23Tqo@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
 <20240417-mtd-nand-mxc-nand-exec-op-v1-4-d12564fe54e9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417-mtd-nand-mxc-nand-exec-op-v1-4-d12564fe54e9@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2024 at 09:13:31AM +0200, Sascha Hauer wrote:
> The NAND core enabled subpage reads when a largepage NAND is used with
> SOFT_ECC. The i.MX NAND controller doesn't support subpage reads, so
> clear the flag again.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/raw/mxc_nand.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> index f44c130dca18d..19b46210bd194 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -1667,6 +1667,8 @@ static int mxcnd_probe(struct platform_device *pdev)
>  	if (err)
>  		goto escan;
>  
> +	this->options &= ~NAND_SUBPAGE_READ;
> +

Nah, it doesn't work like this. It turns out the BBT is read using
subpage reads before we can disable them here.

This is the code in nand_scan_tail() we stumble upon:

	/* Large page NAND with SOFT_ECC should support subpage reads */
	switch (ecc->engine_type) {
	case NAND_ECC_ENGINE_TYPE_SOFT:
		if (chip->page_shift > 9)
			chip->options |= NAND_SUBPAGE_READ;
		break;

	default:
		break;
	}

So the code assumes subpage reads are ok when SOFT_ECC is in use, which
in my case is not true. I guess some drivers depend on the
NAND_SUBPAGE_READ bit magically be set, so simply removing this code is
likely not an option.  Any ideas what to do?

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

