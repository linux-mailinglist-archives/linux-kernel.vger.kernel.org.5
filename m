Return-Path: <linux-kernel+bounces-40844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D055383E6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6141AB25852
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E4560B86;
	Fri, 26 Jan 2024 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gP4jPlKc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A812420B;
	Fri, 26 Jan 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311362; cv=none; b=lfiKhg4dKNScsmh2D1vCcri2Ch6KWd53kmCIkvXu7SF74TIvspT9SBLkNKxlGWFkW6mdWFA/m7Z7Xy75lDBH9Ap6oHU36N6s5i40zaUbIFh8tZE/wfucsQ0Ir+lHRm/64Ndu0+adKsF55mX0VgamsZf873eY1JWaAA9q7PbZ9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311362; c=relaxed/simple;
	bh=k1lLM/lKfVzuiaAVJaAchBIOPdQQvb8bXl1o4bfTGKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQo9TxStLaLABq1AvffTDnxTUXqfOoEqgyjLHwIn8APjt8ENd1zKqjSk4HojmNCNz2pdul0n3+dSMky6u/k6sADNQg9p685DpTkeOimAxO2QRli8OwX+v+I+bd2B87kfdOzs4tqS0mug/2pjRTXbKxgCU1PT49k/DHVL2cmq5zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gP4jPlKc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706311360; x=1737847360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1lLM/lKfVzuiaAVJaAchBIOPdQQvb8bXl1o4bfTGKI=;
  b=gP4jPlKcSgzd/B3aXgRwwri8x+rsW9N6YuOR0ZOhBlqEkozCC5vh5esy
   8QiFfc/MgXOmfWjps5dcUQ42WAHINlU1fia+K/xcLLHoKq4Nm2Vc1V1k1
   H3xaNg/SdtJIVCz82hKWuyeMi9EQPb32tSoZnG0saVOijKuLXpqEmBo6/
   bzfGtHi6ymC3E4tsyxqulD8w3Ff5Q388DssmcF6iMgWCmiwwfGaEpv3ll
   n9cel4MCfQD7Kh5L57OW9qG43ve+0mCVH14xgnbbk34AOAqgZstZn7HLu
   VyUpi5DqDOIYumaLKauDiQkdHQvR4PNJNY2UKudt9pmhPBKhWqxQVfwvE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="24065211"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24065211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:22:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="736831999"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="736831999"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2024 15:22:34 -0800
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: kuba@kernel.org
Cc: alexandre.torgue@foss.st.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	esben@geanix.com,
	fancer.lancer@gmail.com,
	joabreu@synopsys.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	peppe.cavallaro@st.com,
	robh@kernel.org,
	rohan.g.thomas@intel.com
Subject: RE: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Time Based Scheduling
Date: Sat, 27 Jan 2024 07:22:30 +0800
Message-Id: <20240126232230.15733-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240126121928.48a44327@kernel.org>
References: <20240126121928.48a44327@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Jan 2024 12:19:28 -0800, Jakub Kicinski wrote:
> > > The tricky part here is that the whole devicetree bindings story for the
> > > stmmac driver is filled with such configuration choices. As such, it is
> > > only natural to add the property you are suggesting here. I completely
> > > agree. But you can also argue that it is "wrong", because it does not
> > > just describe the hardware, but also a configuration choice.
> >
> > Isn't this requirement of using enhanced tx desc instead of normal tx
> > desc to support TBS is specific to Synopsys IP? Switching from
> > normal desc to enhanced desc at the time of tc-etf qdisc offload
> > cannot be done without traffic disruption, which I don't think is
> > acceptable. Since this behavior is IP specific, can we consider
> > this as an OS configuration choice?
> 
> Why is traffic disruption not acceptable when TBS gets turned on?
> User has to install the right qdisc to enable TBS, I presume,
> installing qdiscs destroys the old ones which also leads to packet
> drops.

Hi Jakub,

Agreed that packet loss is acceptable during qdisc install.

Sorry, I'm a little out of context in the above statements.
Switching between normal and enhanced desc is really not needed as
enhanced desc can support transmission of packets that don't have any
launch time also. So for any tbs supported queues we can enable
enhanced desc for tbs during stmmac_open itself.

As I mentioned in my previous reply:

> > Agreed that this feature(use of enhanced desc) can be enabled from
> > glue drivers. But I added this dt property, thinking this feature is
> > specific and common to DWMAC core and we can enable this feature for
> > stmmac platform driver without a glue driver. If this is not
> > acceptable, I can think of doing this from the glue driver.

Like Esben mentioned I think enabling tbs_en flag explicitly from the
glue driver is the way to enable tbs support for a tx-queue right now.

BR,
Rohan

