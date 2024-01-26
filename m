Return-Path: <linux-kernel+bounces-40443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66C383E05C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053FD1C22DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C792032B;
	Fri, 26 Jan 2024 17:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQDJjSGe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07222AD53;
	Fri, 26 Jan 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290605; cv=none; b=VIfmLOG15Ce0QwdfAEhoDjk1Z3lcaSv+eIyyrxWHsXef2k6+Qi+qtsL8umnn3GiiUcL81Y+oXf78uKZHTmSPogGrrn6qNttZ0xsuymXvueeU2Ndf/VHq+5FcYBqzTwXlKJvFwiSnSh5CeINf90+ru9yDC/Q4sk4L9FE4q9ZMk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290605; c=relaxed/simple;
	bh=ieTfurtfat+pVfBbfHgnr7Gb/OnUunNsdTZt3fG9fSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXdhiX8bzL6BeKEyGM/cNFKPOWpXJQn/BbqPqFm2IEPZq10vnth2QYbPXViheQbskSs94BfjBCO9AaDBIC1WoyelMJn6D+PbEckdG3E66fv0arFzscgvxLzrG7EitMaA7+S/t4ZRm2o2y88YPYtCZOPYj/WOXBoXnjaJsBN7/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQDJjSGe; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706290604; x=1737826604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ieTfurtfat+pVfBbfHgnr7Gb/OnUunNsdTZt3fG9fSs=;
  b=CQDJjSGe0sS/Q3TTyj7EM7zAc7KVtoh7oFmUINmt6XSLnWHQDycD38A7
   Xrl07vsZJZEid4lnMxvLtqmlq8cQ6YwkFjrdsf+4D7E4PZ7Dx7rxK/V7G
   uv6JXgSJhIAiFG2bDZSq58z8VVvod5TT/vUJ+CxJvwlkoThh+aIxmyY/x
   7PnPwVnINQoqXdMa8qNnlFGh2/IwMAgAgnF332AgGkEs1vzMyRfnhiU0E
   Tdze4QnhA+YxE5AbfHPkE6/x2iBD6LMjIR99ZHSARLwVSW4zIlmP0EXnF
   tHXcztWxcqUo4HOPs9smiThHQwhltf7h6D4OBF9V7NVwr0WwJxbadtrMd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15886426"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15886426"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 09:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930424527"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930424527"
Received: from ppglcf2090.png.intel.com ([10.126.160.96])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jan 2024 09:36:37 -0800
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
	robh@kernel.org,
	rohan.g.thomas@intel.com
Subject: RE: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Time Based Scheduling
Date: Sat, 27 Jan 2024 01:36:34 +0800
Message-Id: <20240126173634.13162-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <87msss4gtj.fsf@geanix.com>
References: <87msss4gtj.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rohan G Thomas <rohan.g.thomas@intel.com>

On Fri, 26 Jan 2024 09:52:40 +0100, Esben Haabendal wrote:
Hi Esben,

Thanks for your comments. Like to get some clarification on a few
things.

> >>
> >>Seems like OS configuration and policy.
> >
> > Tx queues need to be configured for TBS during hw setup itself as
> > special enhanced descriptors are used by the hw for TBS support
> > enabled queues. Switching between enhanced and normal descriptors on
> > run is not feasible. So this flag is for enabling "Enhanced
> > Descriptors for Time Based Scheduling". This I think is a hw specific
> > requirement.
> 
> Support for enhanced descriptors is definitely hardware specific.
> Enabling the use of enhanced descriptors is a configuration choice.
> 
> The tricky part here is that the whole devicetree bindings story for the
> stmmac driver is filled with such configuration choices. As such, it is
> only natural to add the property you are suggesting here. I completely
> agree. But you can also argue that it is "wrong", because it does not
> just describe the hardware, but also a configuration choice.

Isn't this requirement of using enhanced tx desc instead of normal tx
desc to support TBS is specific to Synopsys IP? Switching from
normal desc to enhanced desc at the time of tc-etf qdisc offload
cannot be done without traffic disruption, which I don't think is
acceptable. Since this behavior is IP specific, can we consider
this as an OS configuration choice?

Agreed that this feature(use of enhanced desc) can be enabled from
glue drivers. But I added this dt property, thinking this feature is
specific and common to DWMAC core and we can enable this feature for
stmmac platform driver without a glue driver. If this is not
acceptable, I can think of doing this from the glue driver.

> >>Doesn't eh DWMAC have capability registers for supported features? Or
> >>did they forget per queue capabilities?
> >
> > Yes, capability registers are available. For DWMAC5 IP, if TBSSEL bit
> > is set, then TBS is supported by all Tx queues.
> 
> Not true. Some NXP imx8 and imx9 chips support Synopsys MAC 5.10a IP,
> and does not support TBS for queue 0. And they have TBSSEL bit set, but
> no TBS_CH support.

AFAIU from Synopsys DWMAC5 Databook, all queues support TBS. But TBS
cannot coexist with TSO. So all glue drivers enabling TBS feature
avoid queue 0 to support TSO. Please correct me if I'm wrong.

> 
> > For DWXGMAC IP, if TBSSEL bit is set, then TBS is supported by TBS_CH
> > number of Tx queues starting from the highest Tx queue. But because of
> > the hw limitations mentioned above, TBS cannot be enabled for all
> > capable queues.
> >

BR,
Rohan

