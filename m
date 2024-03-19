Return-Path: <linux-kernel+bounces-107155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B39F87F83B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5181C219A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185A51C42;
	Tue, 19 Mar 2024 07:17:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A650A80
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832666; cv=none; b=Qz6TGvNaEy6//mFVN+0UqZfnHKOBFZ/+nucnMWuBaGxJJAvqtVau4c3bkJp1eLUj3kea52NtA0CXc1IqdUL5WeIxYqNaRdRdbbPQ2kOH2RTdT6yB/Rp/CZ0GY/5+JCqCfrO1m9rO8WYERYojUciSaWuSfElv8udfBRkzC7tsXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832666; c=relaxed/simple;
	bh=RFYP/L80IkesCq4S5f/hEdGLshAkHKf2HOddb5Qa1hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1EhTks8IuQLV3IhyDQZwc0znePt5aWWQf+niVBWhYLyEue/dLRfwHRhpnStcrgJEaLHPSG5SWPH9FO8rx6QisY+ABd63Ephr6YYU0O96JDiITDOaXGMb8oPXfJfeCr8SzAEioqpHF0ZlnQl1EXAs1ATovYo2GGvZP7mRUkWBes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rmTix-0007aO-GN; Tue, 19 Mar 2024 08:17:27 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rmTiu-007EBK-Vy; Tue, 19 Mar 2024 08:17:25 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rmTiu-006xkf-2m;
	Tue, 19 Mar 2024 08:17:24 +0100
Date: Tue, 19 Mar 2024 08:17:24 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock features
Message-ID: <20240319071724.6n4vpbkmddejksd5@pengutronix.de>
References: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
 <20240317155911.pdc32nsyxcdhs2t7@pengutronix.de>
 <DU0PR04MB941725052D5E3EF78F67A1C5882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240318095959.v5d7qeoci5v2dtkq@pengutronix.de>
 <DU0PR04MB94177A4081547764F600635E882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20240318140742.3pfn5h6wqhbtgbmj@pengutronix.de>
 <DU0PR04MB94173BD288E56BD7C7C408DD882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94173BD288E56BD7C7C408DD882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-03-18, Peng Fan wrote:
> > > > To me this sound like we can turn of the power/clock of an hardware
> > > > block which was assigned to a core running SIL-2 certified software
> > > > from an non- critical core running Linux if we follow that approach.
> > > > Also the
> > > > SIL-2 software requires the non-critical software to turn on the
> > > > power of these hardware blocks. Is this correct?
> > >
> > > Non-critical software not able to turn off power/clock of a critical
> > > resource in safety software domain.
> > > Safety software not require non-safety software to turn on power/clocks.
> > 
> > Due to lack of documentation I don't know how you implemented this in
> > HW/SW, also the system-design is telling us which parts should be seen as
> > safe and which don't. However I get your point, VPUMIX is not going to be a
> > part of the safe partition albeit it "could" due to complexity.
> 
> If safe function needs VPU feature, VPUMIX could be totally assigned to M7
> core through TRDC isolation, not assigned its BLK CTRL to system controller
> core.

Thanks for the clarification :)

Regards,
  Marco

