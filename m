Return-Path: <linux-kernel+bounces-143086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E10A8A33EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7381C22FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0EA14AD37;
	Fri, 12 Apr 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxmjFBIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419275491F;
	Fri, 12 Apr 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939549; cv=none; b=SH0hkSK3jz0NhcUpNPx9pyfrf2YShbwZ+E/XU1a+mZfoVCjiEgGjQwxotzxFcy1NnhMVPvjPq+LXmtCQ82L6u2YC0/g+tl9qLvgsmea7LCkFTx2mzfDMdvWMNz2S1RxESBLpE+M088npCLfpiJsFzGZjP3sYYRTJUzmqztcnibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939549; c=relaxed/simple;
	bh=0Fua1hzHG73DbB8249nNYAgyxs0cgrFwxPTdOQM+URk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEEjUag1RWoQXfrvQxFfPo40jzDCpJbY++ycvkCv9DbL8X+1XDO8vZ+bDI5c4/Tpgxdyn3y4eplctPyJyF6aEg1z7O1HXn4W+yAYkPnAqSPa+uzZq84b43XifM6W4s+KJXBbzt7wFSBB2AAN2Z65580civa/PTRefPzRGe8fdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxmjFBIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60973C113CC;
	Fri, 12 Apr 2024 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712939548;
	bh=0Fua1hzHG73DbB8249nNYAgyxs0cgrFwxPTdOQM+URk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxmjFBIXElneJwC5ApUGjhFvk0hgKUsFeYzrNkkMwtV0NzU0OuCzQ8ZASVGF3QmE1
	 WX+Ye0C1WDnMOCihbKBGoTJBjsqOhzqiwL797MpPdyYOU2Ofe8z6V99bqHiBflpdMX
	 Wjm5MfFJJZiPuScINb2gGX3E4aJA9Xl67P+cGRk9enD3g9V6IIvDRYyLypzPjNNYc+
	 pr/n7gfzdckunfkKZ8dA+jWAAu/JkJbFC+kAirGG0iWR4JgssW9g6XpKu7EcadBjXI
	 Cvmpu1ciU19BJ8oUpECytX98UkJvLl/Et9mA4HoCqtPd77ZWNTZ9t5lYq7ROTyF4Ow
	 kEX3BDRF3SDkQ==
Date: Fri, 12 Apr 2024 11:32:26 -0500
From: Rob Herring <robh@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Yannic Moog <y.moog@phytec.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	NXP Linux Team <linux-imx@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <mbrugger@suse.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-mmc@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Li Yang <leoyang.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>,
	Chester Lin <chester62515@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: serial: fsl-linflexuart: add
 compatible for S32G3
Message-ID: <171293952391.3135577.10458129035327593723.robh@kernel.org>
References: <20240324214329.29988-1-wafgo01@gmail.com>
 <20240324214329.29988-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324214329.29988-3-wafgo01@gmail.com>


On Sun, 24 Mar 2024 22:43:24 +0100, Wadim Mueller wrote:
> Add a compatible string for the uart binding of NXP S32G3 platforms. Here
> we use "s32v234-linflexuart" as fallback since the current linflexuart
> driver can still work on S32G3.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  .../devicetree/bindings/serial/fsl,s32-linflexuart.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Looks like this was missed, so I applied it, thanks!


