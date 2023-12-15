Return-Path: <linux-kernel+bounces-1527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38A814FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02A21C230E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E35F3013E;
	Fri, 15 Dec 2023 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xVG+9PPM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337845BE0;
	Fri, 15 Dec 2023 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BFFOjxN006697;
	Fri, 15 Dec 2023 19:27:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=selector1; bh=BjOqj4pPwqHC177zwB45U
	ceMHy2woG5K27cvATFEIgQ=; b=xVG+9PPMP/NNfvHzLlg8bFX0nUwQRQagg6eHK
	EymLJP1VCsqopbltlFV9CW89DE9+PN0LQyuUIBrgxYUe/5y/CCIm5Z3a+4OrKd42
	uhy4bOUH3+/MzhXqUvF+GEpfUaP0fMaIkuOeUnSG+jUk5I/75fpc3+qMlkb3hZn3
	EXAQoAhjalrA+V86WAV7vCKCkJoYCR2nH/g+lhBQDjCZ1v6ozi9VXkhi94PuLjFT
	eUgb4pmOG0xrbxYzun2xw2fUZcPAPkYpz0j114FdGbZJmwkVQdjR1Q2MWPxJx/Qu
	++NcfFYImtxked1Z++nhgr2Fr2lif4O/I8xlAjwlJvaT7o2sg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvg0hapcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 19:27:46 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 624B0100052;
	Fri, 15 Dec 2023 19:27:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5928424C433;
	Fri, 15 Dec 2023 19:27:45 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Dec
 2023 19:27:45 +0100
Date: Fri, 15 Dec 2023 19:27:39 +0100
From: Alain Volmat <alain.volmat@foss.st.com>
To: Mark Brown <broonie@kernel.org>
CC: Ben Wolsieffer <ben.wolsieffer@hefring.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
Subject: Re: [PATCH] spi: stm32: use runtime PM to enable/disable controller
Message-ID: <20231215182739.GA96945@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
References: <20231204202055.2895125-1-ben.wolsieffer@hefring.com>
 <58897511-3187-4583-bf29-11871dd4d136@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58897511-3187-4583-bf29-11871dd4d136@sirena.org.uk>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02

Hi,

sorry for the delay.

On Thu, Dec 14, 2023 at 10:58:54AM +0000, Mark Brown wrote:
> On Mon, Dec 04, 2023 at 03:20:55PM -0500, Ben Wolsieffer wrote:
> > Instead of disabling the SPI controller between each message, do it
> > as part of runtime PM.
> 
> This doesn't apply against current code, please check and resend.

I rapidly gave a try on this patch on top of the spi/for-next branch
(manually fixing the conflict due to the MASTER->HOST renaming).
It turns out that with that applied, transfers on the MP13
(compatible: st,stm32h7-spi) are not working anymore while simply
removing it back it works again.
(test is simply doing loopback spidev_test)

spi mode: 0x0
bits per word: 8
max speed: 500000 Hz (500 kHz)
TX | 8D D6 73 8B 9D 8B 1C 7D 8D 80 EC 32 F9 0D BA AD 9F 88 A5 9B 3F AA 48 8C 21 35 0D C1 C8 E5 6A 81  |..s....}...2........?.H.!5....j.|
RX | 8D 00 00 00 D6 00 73 00 8B 00 00 00 9D 00 00 8B 1C 00 00 00 7D 00 00 8D F9 00 00 00 BA 00 00 00  |......s.............}...........|

The RX data contains lots of 00 between each byte.  Moreover it seems
that with this patch applied non-dma transfer (when there is no dmas
properties within the node) are now failing.

I'll check that and give more details but could you avoid applying this
patch for the time being ?

Thanks.
Alain

