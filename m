Return-Path: <linux-kernel+bounces-158197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDD08B1CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A40B282EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33295757E1;
	Thu, 25 Apr 2024 08:32:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DF528EB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033941; cv=none; b=kXPBVT6H0seMdHOjd6PvvtZXYI8eiHvMXvMMTdlACM9yeYe4d3fBgWg9Rln1+mUFxiqhl2zPGKEASamyyU+hYhBRCdIsKFK08jKdrd/IrxZZO7FyRW1b0GHOkgk1sTRc+QQJOPsoWP3incdOA05uSatC7yF+2NyDB2oC6qjTxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033941; c=relaxed/simple;
	bh=9zDiuV2xL0Aq10ewDaI0F73qzwXbNYOhjJNI2Th0OG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4dHzqce99/kc3Oc6hhmKQ0oSBT/O0IH9UOMPB6uhmeKdqbfBdBykNeuTB2y78YWNtippNTIvkmDfQ433TkQxUTGug6XdhB3cbkg7BOB419QeJr52MR5QerHDHBIe70Yt8vR0JEHkNB1XmxTc1Nd1tr9qa6EHivs8fkcevx9T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1rzuWd-00049P-RN; Thu, 25 Apr 2024 10:32:15 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1rzuWc-00EEJR-Nb; Thu, 25 Apr 2024 10:32:14 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1rzuWc-00DEQd-21;
	Thu, 25 Apr 2024 10:32:14 +0200
Date: Thu, 25 Apr 2024 10:32:14 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, peng.fan@nxp.com,
	s.hauer@pengutronix.de, sboyd@kernel.org, festevam@gmail.com,
	mturquette@baylibre.com, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
	shawnguo@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
	linux-arm-kernel@lists.infradead.org, abelvesa@kernel.org
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power
 saving
Message-ID: <20240425083214.g6xplxql4g32zxud@pengutronix.de>
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
 <20240424164725.GA18760@francesco-nb>
 <CAA+D8AMxcAOdeSUhLnFdX2tjXSiWKg8-oxfZ8oT06-qQPnNKqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AMxcAOdeSUhLnFdX2tjXSiWKg8-oxfZ8oT06-qQPnNKqA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-04-25, Shengjiu Wang wrote:
> On Thu, Apr 25, 2024 at 12:47 AM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > On Thu, Mar 21, 2024 at 09:14:02PM +0800, Shengjiu Wang wrote:
> > > Add pm_runtime support for power saving. In pm runtime suspend
> > > state the registers will be reseted, so add registers save
> > > in pm runtime suspend and restore them in pm runtime resume.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >
> > Is this introducing a regression?
> >
> >   800 13:50:19.713052  <6>[   16.531134] clk: Disabling unused clocks
> >   801 13:50:19.727524  <2>[   16.535413] SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
> >   802 13:50:19.731400  <4>[   16.535421] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5-next-20240424 #1
> >   803 13:50:19.742514  <4>[   16.535428] Hardware name: Toradex Verdin iMX8M Plus on Dahlia Board (DT)
> >   804 13:50:19.747157  <4>[   16.535431] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> >   805 13:50:19.758468  <4>[   16.535442] pc : clk_imx8mp_audiomix_runtime_resume+0x24/0x48
> >   806 13:50:19.759372  <4>[   16.535456] lr : pm_generic_runtime_resume+0x2c/0x44
> >   807 13:50:19.759587  <4>[   16.535465] sp : ffff800082b8bb90
> >   808 13:50:19.774512  <4>[   16.535468] x29: ffff800082b8bb90 x28: 0000000000000000 x27: 0000000000000000
> >   809 13:50:19.775367  <4>[   16.535482] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
> >   810 13:50:19.790567  <4>[   16.535495] x23: ffff0000c0f7a4e0 x22: ffff0000c26922f8 x21: 0000000000000000
> >   811 13:50:19.791308  <4>[   16.535508] x20: ffff0000c2692000 x19: ffff0000c0e30c10 x18: 0000000000000000
> >   812 13:50:19.794834  <4>[   16.535521] x17: 000000007e4712cb x16: ffff80008296f800 x15: 0000000000000030
> >   813 13:50:19.807341  <4>[   16.535532] x14: ffff0000c00b8080 x13: 00000000000003f9 x12: 0000000000000000
> >   814 13:50:19.810740  <4>[   16.535545] x11: 0000000000000000 x10: 0000000000000aa0 x9 : ffff800082b8bb20
> >   815 13:50:19.822528  <4>[   16.535559] x8 : ffff0000c00b8b00 x7 : 0000000000000000 x6 : ffff0000c00b8000
> >   816 13:50:19.827173  <4>[   16.535570] x5 : ffff8000836b0000 x4 : ffff0000c2f3a488 x3 : ffff8000813660d0
> >   817 13:50:19.838446  <4>[   16.535583] x2 : 0000000000000004 x1 : 0000000000000001 x0 : 00000000ff777777
> >   818 13:50:19.839321  <0>[   16.535597] Kernel panic - not syncing: Asynchronous SError Interrupt
> >   819 13:50:19.839983  Matched prompt #9: Kernel panic - not syncing
> >   820 13:50:19.840155  Setting prompt string to ['end Kernel panic[^\\r]*\\r', '/ #', 'Login timed out', 'Login incorrect']
> >   821 13:50:19.854524  <4>[   16.535601] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5-next-20240424 #1
> >   822 13:50:19.855261  <4>[   16.535609] Hardware name: Toradex Verdin iMX8M Plus on Dahlia Board (DT)
> >   823 13:50:19.858660  <4>[   16.535613] Call trace:
> >   824 13:50:19.870455  <4>[   16.535616]  dump_backtrace+0x94/0xec
> >   825 13:50:19.870763  <4>[   16.535626]  show_stack+0x18/0x24
> >   826 13:50:19.871258  <4>[   16.535635]  dump_stack_lvl+0x38/0x90
> >   827 13:50:19.874714  <4>[   16.535647]  dump_stack+0x18/0x24
> >   828 13:50:19.874964  <4>[   16.535656]  panic+0x388/0x3c8
> >   829 13:50:19.886551  <4>[   16.535667]  nmi_panic+0x48/0x94
> >   830 13:50:19.888318  <4>[   16.535679]  arm64_serror_panic+0x6c/0x78
> >   831 13:50:19.888531  <4>[   16.535688]  do_serror+0x3c/0x78
> >   832 13:50:19.892592  <4>[   16.535693]  el1h_64_error_handler+0x30/0x48
> >   833 13:50:19.902540  <4>[   16.535703]  el1h_64_error+0x64/0x68
> >   834 13:50:19.903437  <4>[   16.535709]  clk_imx8mp_audiomix_runtime_resume+0x24/0x48
> >   835 13:50:19.907712  <4>[   16.535719]  __genpd_runtime_resume+0x30/0xa8
> >   836 13:50:19.918505  <4>[   16.535729]  genpd_runtime_resume+0xb4/0x29c
> >   837 13:50:19.918770  <4>[   16.535741]  __rpm_callback+0x48/0x198
> >   838 13:50:19.919372  <4>[   16.535749]  rpm_callback+0x68/0x74
> >   839 13:50:19.922715  <4>[   16.535754]  rpm_resume+0x3cc/0x680
> >   840 13:50:19.934495  <4>[   16.535762]  __pm_runtime_resume+0x4c/0x90
> >   841 13:50:19.934784  <4>[   16.535769]  clk_pm_runtime_get_all+0x58/0x164
> >   842 13:50:19.935344  <4>[   16.535780]  clk_disable_unused+0x2c/0x178
> >   843 13:50:19.938873  <4>[   16.535793]  do_one_initcall+0x6c/0x1b0
> >   844 13:50:19.950539  <4>[   16.535799]  kernel_init_freeable+0x1c8/0x290
> >   845 13:50:19.951360  <4>[   16.535812]  kernel_init+0x20/0x1dc
> >   846 13:50:19.951585  <4>[   16.535821]  ret_from_fork+0x10/0x20
> >   847 13:50:19.954803  <2>[   16.535831] SMP: stopping secondary CPUs
> >   848 13:50:19.966688  <0>[   16.535838] Kernel Offset: disabled
> >   849 13:50:19.967221  <0>[   16.535841] CPU features: 0x0,00000040,00100000,4200421b
> >   850 13:50:19.967360  <0>[   16.535845] Memory Limit: none
> >   851 13:50:19.985117  <0>[   16.788060] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> >
> > from
> >
> > https://storage.kernelci.org/next/master/next-20240424/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-verdin-nonwifi-dahlia.html
> > https://lore.kernel.org/all/66293535.170a0220.21fe.a2e7@mx.google.com/
> >
> 
> Sorry that I didn't use a clean community kernel for the test.

:/ I have asked you if you have tested this feature since I was aware of
bugs regarding PM.

> On my local side I added delay in drivers/pmdomain/imx/gpcv2.c
> so there was no such issue.
> 
> But according to drivers/pmdomain/imx/gpcv2.c, seems that I need
> to add delay in this driver, like this:

"Seems" shouldn't be really a "The root cause for this is".

Regards,
  Marco

>  static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
>  {
> +       /*
> +        * According to the drivers/pmdomain/imx/gpcv2.c
> +        * need to wait for reset to propagate
> +        */
> +       udelay(5);
> +
> 
> I will submit a patch for it.
> 
> Thanks for reporting it
> 
> Best regards
> Shengjiu Wang
> 
> 
> 
> > Francesco
> >
> 
> 

