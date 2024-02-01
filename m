Return-Path: <linux-kernel+bounces-48531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296AD845D49
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B131F2B4D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482C5397;
	Thu,  1 Feb 2024 16:30:20 +0000 (UTC)
Received: from tux.runtux.com (tux.runtux.com [176.9.82.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCA6118;
	Thu,  1 Feb 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.82.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706805019; cv=none; b=WTx7jwVuQWwMOU8Zgriz4qEiYBhGMsG3qF4yLU/vA8Atzf1PhaOv6X3f7551QHaP5JeEw+kauVyvBgNLvbfu13mod+HA/qqmGh/Hqm/bN8KQ9hNZ/ZsedFcaw4Axtt2ZXAkgd63x5bhT7L83jgdPO8fjMFgkHnKXVds5TeB58/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706805019; c=relaxed/simple;
	bh=SGlKrRLF1fwmhn3oCvOUhr6yGWqDrPXeBhFE1Brl80E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOrMdMrLECDEaWoc5AWtmXpoBnCL+syTRhHDA193oYQCWP29hoG0M907LBYFMxlWlf3PRPJ8z/tfAKl3LvAp4lfmDRCYsPZn7u5NAZw3y3X6WTHGmGDna4Q0ohkd35bhvGsJzXZQFA4syuyzHwqrwWuBZT8Gj7f3OJElPCIi+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com; spf=pass smtp.mailfrom=runtux.com; arc=none smtp.client-ip=176.9.82.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=runtux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runtux.com
Received: from localhost (localhost [127.0.0.1])
	by tux.runtux.com (Postfix) with ESMTP id 8E9476EF8E;
	Thu,  1 Feb 2024 17:30:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
	by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
	with LMTP id zeeGpRYg57Kv; Thu,  1 Feb 2024 17:30:13 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
	(Authenticated sender: postmaster@runtux.com)
	by tux.runtux.com (Postfix) with ESMTPSA id 0CCB26EF20;
	Thu,  1 Feb 2024 17:30:12 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
	id A3014469; Thu,  1 Feb 2024 17:30:12 +0100 (CET)
Date: Thu, 1 Feb 2024 17:30:12 +0100
From: Ralf Schlatterbeck <rsc@runtux.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi-mxs: Fix chipselect glitch
Message-ID: <20240201163012.pf2ywwxwcd3rgsur@runtux.com>
References: <20240201131540.3dlqoxlrrbzshz7w@runtux.com>
 <20240201-tributary-fax-dd6055160dbe-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-tributary-fax-dd6055160dbe-mkl@pengutronix.de>
X-ray: beware
User-Agent: NeoMutt/20180716

On Thu, Feb 01, 2024 at 04:38:38PM +0100, Marc Kleine-Budde wrote:
> 
> nitpick: Please omit the line break change from this patch.

Thanks for the quick feedback!
I'll make a v2 when tomorrow there are no further comments.

Thanks
Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

