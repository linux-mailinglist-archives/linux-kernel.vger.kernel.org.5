Return-Path: <linux-kernel+bounces-128162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9CF895796
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39D4B29063
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709F134431;
	Tue,  2 Apr 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="a0JH/9Zr"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349612BF1F;
	Tue,  2 Apr 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068684; cv=none; b=VdG6O29xp0x6kYHXi6WtLPregGIyshtGxvd5mZo4bt3wIrGKEp0VfCnyaSi3LKV2Wu0Wr+PrhbJD5EtK5LdT6tSG0fvZ5TiRrTtIUZbN/RxAM0p7Jd4l6G8bXKPLW7MlJttDo9yEfyM9eEFhRy7sM1SJ/t//6b3u0Dd+0v4Yc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068684; c=relaxed/simple;
	bh=y93sbGXDHyqBedzkpPL4OL5mGT6a0q7FptP2qObJa8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0gatRZs1KNf4IakEie3nc8OO9v4sZHIZZmzF9PfDXpSHixmuiInZyzWX5KhnE5UWdzbSJ829WzN3353XXcNsnq3b+pYBgRcP74E/dWYisX4gd/eVO9vyRFo++grxdZGnvLth55eHhSWuC5flc+gmYriwgFwlnunwHTvtpfKkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=a0JH/9Zr; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=aJBu59wH8+zyksPlO84AEqktfR6MRWy+q+ZyQLyUzbE=;
	b=a0JH/9ZrT+x5iocC6DS5MSTBOvXdWlem2GP+brQLVVgQLACfnVD3CRcM1lv5sY
	uU4MK5GDezWPe+5k+EBe265ojSBrzKRHC0g3xwFMXPP1CwrUfsZclf4a6uFmrosk
	0wwI5AMleMej8ybrdbMzqe4YCg+QYVO/3Ebim8ALXmFro=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0R6FwxmkTqmAQ--.46595S3;
	Tue, 02 Apr 2024 22:34:36 +0800 (CST)
Date: Tue, 2 Apr 2024 22:34:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Josua Mayer <josua@solid-run.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: fsl: add NXP S32G3 board
Message-ID: <ZgwXepBYa78FhQaT@dragon>
References: <20240324214329.29988-1-wafgo01@gmail.com>
 <20240324214329.29988-2-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324214329.29988-2-wafgo01@gmail.com>
X-CM-TRANSID:ClUQrADnr0R6FwxmkTqmAQ--.46595S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxdWFUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDh+0ZVszYdX9jwAAsu

On Sun, Mar 24, 2024 at 10:43:23PM +0100, Wadim Mueller wrote:
> Add bindings for NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3) [1]
> 
> [1]
> https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!


