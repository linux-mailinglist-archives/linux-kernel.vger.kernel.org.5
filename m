Return-Path: <linux-kernel+bounces-40445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BD83E086
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD071C221F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713672032A;
	Fri, 26 Jan 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAA9jn2b"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843A1EB49;
	Fri, 26 Jan 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290774; cv=none; b=Su9fvh21eU6yeVgfKRrsfPCiLQDvVWVuv6DxvgzoVdE0nbjyk/3epBWRYfU4JGEaCxaeJtKxaWh8+xUG80t5yVRVyUUNgG5efLyngyaGhJgd4JOZBg93bN0L9RWb5d5vs4/QN2cnxPoM3+cj/X/4ziNBLrFFFszQqMpnH8pfJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290774; c=relaxed/simple;
	bh=0I2/Kn+FW5P/KKPj6mUmkJMaL/ErP8cdilIPuLRdXFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LwJseSV9cnkh1V/o7Y8oGe4UeeUd0T4Xcnw8/FqJjFYm7JYC43aOSVPGmhgt17Blim5ViarLlWLfEf3ELM+GLcD9lV9WEeaScke5JmPMGybKDCk//Xm2RfGTqG/N08+7HVhqQbV7edPtOYPjPQ/sv7/X75zSPNMiUTkKrvcCSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAA9jn2b; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706290773; x=1737826773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0I2/Kn+FW5P/KKPj6mUmkJMaL/ErP8cdilIPuLRdXFU=;
  b=SAA9jn2bAvd1DDrZCdBmvOAPEzOnHE7CVoJZbOnydIpHxu2CrFwgBmml
   x539T0XfQd3k47Hl9oeKxD6oMEEkUsAKd2t8kcx+MlVuwrW3DlByKzYYR
   vA5Pt6e9EsbGYBjqE9cujJWAPZcZuJALU4olO0zlGb217uC4sSWUyXzea
   5cBMJn+Cbwkv2AwBxmBAM/F2YNlvjwkAp6LuyYh5rW2GAWemz60QREwfb
   tzz2Y50LukruDVt4JQ0mb1X7ytA6pojs5PBJYPLgmVPSP3aepcZtOdyNM
   PTH3g1WyO7EIIM4MsFSmMa2iLZLhWyQZwgncwU1C6XY0TtPnX3oqUWxPV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="399686983"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399686983"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 09:39:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="1118313677"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1118313677"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2024 09:39:27 -0800
From: rohan.g.thomas@intel.com
To: esben@geanix.com
Cc: alexandre.torgue@foss.st.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	fancer.lancer@gmail.com,
	joabreu@synopsys.com,
	krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peppe.cavallaro@st.com,
	robh+dt@kernel.org,
	rohan.g.thomas@intel.com
Subject: RE: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
Date: Sat, 27 Jan 2024 01:39:25 +0800
Message-Id: <20240126173925.16794-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <87v87g4hmy.fsf@geanix.com>
References: <87v87g4hmy.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rohan G Thomas <rohan.g.thomas@intel.com>

On Fri, 26 Jan 2024 09:35:01 +0100, Esben Haabendal wrote:
Hi Esben,

Thanks for your comments. Please find my reply inline.

> > +	/* If TBS feature is supported(i.e. tbssel is true), then at least 1 Tx
> > +	 * DMA channel supports TBS. So if tbs_ch_num is 0 and tbssel is true,
> > +	 * assume all Tx DMA channels support TBS. TBS_CH field, which gives
> > +	 * number of Tx DMA channels with TBS support is only available only
> for
> > +	 * DW xGMAC IP. For other DWMAC IPs all Tx DMA channels can
> support TBS.
> 
> The Ethernet QOS controllers found in various i.MX socs does not support TBS
> on TX queue 0. I believe this patch would break the dwmac driver for these
> platforms.

AFAIU from Synopsys DWMAC5 Databook, all queues support TBS. But TBS
cannot coexist with TSO. So all glue drivers enabling TBS feature are
avoiding queue 0 to support TSO. Also packets requesting TSO are
always directed to queue 0 by stmmac driver.

> 
> > +	 */
> > +	if (priv->dma_cap.tbssel && !priv->dma_cap.tbs_ch_num)
> > +		priv->dma_cap.tbs_ch_num = priv-
> >dma_cap.number_tx_channel;
> > +

I don't think updating tbs_ch_num with number_tx_channel would break
the dwmac driver for i.MX socs. tbs_ch_num is used by 'Earlier check
for TBS' loop to set tbs flag. 

> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3773,12 +3773,18 @@ stmmac_setup_dma_desc(struct stmmac_priv
> *priv, unsigned int mtu)
> >  		dma_conf->dma_rx_size = DMA_DEFAULT_RX_SIZE;
> >
> >  	/* Earlier check for TBS */
> > -	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++) {
> > -		struct stmmac_tx_queue *tx_q = &dma_conf-
> >tx_queue[chan];
> > -		int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
> > +	if (priv->dma_cap.tbssel) {
> > +		/* TBS is available only for tbs_ch_num of Tx DMA channels,
> > +		 * starting from the highest Tx DMA channel.
> > +		 */
> > +		chan = priv->dma_cap.number_tx_channel - priv-
> >dma_cap.tbs_ch_num;

For IPs which don't have tbs_ch_num, this loop goes from 0 to
number_tx_channel to check if tbs_enable is set by glue driver.
Existing logic is also the same. Unless you set tbs_en flag of
queue 0 from the glue driver or dts configuration this patch doesn't
set tbs flag for queue 0. This is a sanity check to avoid wrong
configuration for IPs which support tbs only in a few number of
queues.

> > +		for (; chan < priv->plat->tx_queues_to_use; chan++) {
> > +			struct stmmac_tx_queue *tx_q = &dma_conf-
> >tx_queue[chan];
> > +			int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;
> >
> > -		/* Setup per-TXQ tbs flag before TX descriptor alloc */
> > -		tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
> > +			/* Setup per-TXQ tbs flag before TX descriptor alloc
> */
> > +			tx_q->tbs |= tbs_en ? STMMAC_TBS_AVAIL : 0;
> > +		}
> >  	}

Please correct me if I've misstated anything.

BR,
Rohan

