Return-Path: <linux-kernel+bounces-152151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80B48AB9E3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8730F1F212C3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAFD111A3;
	Sat, 20 Apr 2024 05:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MV5bn2NX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE870205E26;
	Sat, 20 Apr 2024 05:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713591758; cv=none; b=qGqqQzId8CWR09YD7E6ZS5KMYCsw3Fp31KZOzG9skNv1KEiD5M0Sl0/NpzQngsJrw/ZXVngram9YDX41m43FCfZIqFjEtimkTl5oK73R4D1WXRaDh5neBSmsZ22qEs9rhtxMuRlqWFv7MPbPlO/AJSjCLWoNJXKZSWvHJRtRTvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713591758; c=relaxed/simple;
	bh=J1dLKYPxyFkEweXN2JMF1FmYTjWv5bfJ2uMqdVJvkM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZt3lUpyWfnwG8ySJvBHVfPpUi3LJfOJ0YlNf4HSXoq4nZVpK1b1T9OFXYguAwbmzZ8Ip2rYDbdH0R/86I2MtH4NoJbcwysLmTqZpHIEz6C0dtO5M6wdG5RvdFWf8dOqeKOaHm31qT0+xU0GAveXqA15iDiLb6o/HCVal67UQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MV5bn2NX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C6FC072AA;
	Sat, 20 Apr 2024 05:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713591757;
	bh=J1dLKYPxyFkEweXN2JMF1FmYTjWv5bfJ2uMqdVJvkM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MV5bn2NX3ygNHk+oPbXbgk/gEZIAVEE+PesaSKSc1VNMcnhn/RH8gPDsQEVjVA1K5
	 KARpqMQLAUYMNUeq0LyevUWMD/fhkiDbfXhdy5REdBohu+VZ04FF8oNvpgQV7oi77c
	 GN3TU1xZoSQD25rLcPqAud3IaexysuTWG0IrJzBw=
Date: Sat, 20 Apr 2024 07:42:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Al Cooper <alcooperx@gmail.com>,
	Alexander Shiyan <shc_work@mail.ru>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Bjorn Andersson <andersson@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Fabio Estevam <festevam@gmail.com>,
	Hammer Hsieh <hammerh0314@gmail.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <michal.simek@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Richard Genoud <richard.genoud@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Timur Tabi <timur@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH 00/15] tty: serial: switch from circ_buf to kfifo
Message-ID: <2024042030-gumdrop-outdoors-fc81@gregkh>
References: <20240405060826.2521-1-jirislaby@kernel.org>
 <daf06969-15fd-470e-88b8-a717066fe312@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf06969-15fd-470e-88b8-a717066fe312@linaro.org>

On Fri, Apr 19, 2024 at 05:12:28PM +0200, Neil Armstrong wrote:
> This patchset has at least broken all Amlogic and Qualcomm boards so
> far, only part of them were fixed in next- but this serie has been
> merged in v1 with no serious testing and should've been dropped
> immediately when the first regressions were reported.

What is not yet fixed with the recent patch that was just sent to the
list?

Doing core changes like this is hard, I have seen no lack of willingness
to fix reported problems or major breakages that would deserve a revert.

greg k-h

