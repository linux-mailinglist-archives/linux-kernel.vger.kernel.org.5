Return-Path: <linux-kernel+bounces-23383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F782ABF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054EAB25BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E514F65;
	Thu, 11 Jan 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuziKOq7"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA014278;
	Thu, 11 Jan 2024 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704968788; x=1736504788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75Kadan5gs4ZuP5cPTGG7+GIKF7osPeROaXB2BrU9gM=;
  b=SuziKOq76gnG9XNyPBW8fuo6P7bB9fEq2dAKQp0UoFflPt95touTDJDm
   /sTI4VLt1wmW59jq18sC+QPKHRBhVf93Bb7116EWgJSlLHg9prH5KisN0
   bHC4awATOOrmMLFxRjL+DWg3MP7JJouTnzLsDTayb0kNO9B8fVFDmDBRL
   w9QJyP5IU8OoYVTGNNTuEwUk2Q0EiQ807/v/usxA4C8CxpnG6SAydNUwn
   UIsEKTX7Ml2nsRfv35tTroh74u7z/uYsTpq7rTOFM5uyOn7kTI8zaHWng
   H7aZ4nqDUdQql9TjduDqXDw+CX4qMyqaBODoavCRCebfdKBaOTHSXwvzK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="463093405"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="463093405"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="30950728"
Received: from ppglcf0286.png.intel.com ([10.126.161.20])
  by orviesa001.jf.intel.com with ESMTP; 11 Jan 2024 02:26:22 -0800
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: quic_abchauha@quicinc.com
Cc: ahalaney@redhat.com,
	alexandre.torgue@foss.st.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	elder@linaro.org,
	fancer.lancer@gmail.com,
	joabreu@synopsys.com,
	kernel.upstream@quicinc.com,
	krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peppe.cavallaro@st.com,
	quic_bhaviks@quicinc.com,
	robh+dt@kernel.org,
	rohan.g.thomas@intel.com
Subject: Re: [PATCH net-next 2/2] net: stmmac: TBS support for platform driver
Date: Thu, 11 Jan 2024 18:26:18 +0800
Message-Id: <20240111102618.17734-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <92892988-bb77-4075-812e-19f6112f436e@quicinc.com>
References: <92892988-bb77-4075-812e-19f6112f436e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jan 2024 20:20:39 +0000 : Abhishek Chauhan (ABC) wrote:

> Qualcomm had similar discussions with respect to enabling of TBS for a
> particular queue.
> We had similar discussion on these terms yesterday with Redhat. Adding
> Andrew from Redhat here
> 
> What we discovered as part of the discussions is listed below.
> 
> 1. Today upstream stmmac code is designed in such a way that TBS flag is put
> as part of queue configurations(see below snippet) and as well know that
> stmmac queue configuration comes from the dtsi file.
> 
> //ndo_open => stmmac_open
> int tbs_en = priv->plat->tx_queues_cfg[chan].tbs_en;(comes from
> tx_queues_cfg)
> 
> /* Setup per-TXQ tbs flag before TX descriptor alloc */ tx_q->tbs |= tbs_en ?
> STMMAC_TBS_AVAIL : 0;
> 
> 2. There is a no way to do this dynamically from user space because we don't
> have any API exposed which can do it from user space and also TBS rely on
> special descriptors aka enhanced desc this cannot be done run time and
> stmmac has to be aware of it before we do DMA/MAC/MTL start. To do this
> dynamically would only mean stopping DMA/MAC/MTL realloc resources for
> enhanced desc and the starting MAC/DMA/MTL. This means we are disrupting
> other traffic(By stopping MAC block).
> 
> 3. I dont think there is a way we can enable this dynamically today. I would like
> upstream community to share your thoughts as well.
> 
> 4. I agree with Rohan's patch here and want upstream community to accept it.
> This will allow use to configure the queues where TBS needs to be enabled as
> hardcoding in the code unless upstream has better way to this using
> userspace.
> 
> Please let us know if you think otherwise.
> 
> 

Hi Abhishek,

Thanks for bringing this to discussion and a better explanation from
your side. I agree with you.

Best Regards,
Rohan

