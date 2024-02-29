Return-Path: <linux-kernel+bounces-86421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36C86C523
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062FD28E09D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE415D478;
	Thu, 29 Feb 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W8YMYZFA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA65B697;
	Thu, 29 Feb 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198905; cv=none; b=TzzmtIzFrn2TNTP6kwtpdA8qbWt8QjDqy8RY6hhCaGuVotE1wCsoY8yk5C8LZAhYpmb8hodOMkUKPIxjygWOw1M2fxh6qjfraL+jyeH1TglCHp/FXXmNMIS04W4BJ653F4GEnm2ozw6btjsX1XdfxD1O1VLm5MLOef8DQSu+dCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198905; c=relaxed/simple;
	bh=4Z2ckJYc2X1eKlf+Pruh4UD5514kZq9qLpckK12vBs0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMK6aqgvpEy/X1iXMRWhYePjgZ7eboIDMObwUimwJwVN0zvJ7BppJphCXRGWKqSM4DtAW0103ZtiNd7Wwdr7X5/vqpof0w7OpjtBE6E1ELELL6zYTiq2hHP7ATWS0De8Mt8RgXrGBwMNL1Tz9aT+U2PAW9ahnDEOZvK2z1QXp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W8YMYZFA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41T9RoZe012078;
	Thu, 29 Feb 2024 03:27:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709198870;
	bh=GzKfgPrCzPpYr7lfuwIgLdFgDGketk3AdQD7tugAgqU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=W8YMYZFACerPlpM5giQNVGU4rBqte6vfifJMRl01jPHMQjUCLYx3e4bsbL/bCYrZ+
	 bf2v1pieqHH8jIuVUEiechrmpsfn7Xnn4QwjmgaAcfs0YlGwuvJTVJ/NbhEHNtMDQr
	 4HJjLPPuZW0HFuR5/STT+E/YINQ7kzKHuQgOO+40=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41T9RoYu074642
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 03:27:50 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Feb 2024 03:27:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Feb 2024 03:27:49 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41T9RnMl089761;
	Thu, 29 Feb 2024 03:27:49 -0600
Date: Thu, 29 Feb 2024 14:57:48 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Jiri Pirko <jiri@resnulli.us>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <vladimir.oltean@nxp.com>,
        <hkallweit1@gmail.com>, <dan.carpenter@linaro.org>, <horms@kernel.org>,
        <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
Message-ID: <0004e3d5-0f62-49dc-b51f-5a302006c303@ti.com>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho>
 <7d1496da-100a-4336-b744-33e843eba930@ti.com>
 <Zd7taFB2nEvtZh8E@nanopsycho>
 <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
 <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <10287788-614a-4eef-9c9c-a0ef4039b78f@lunn.ch>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Feb 28, 2024 at 02:36:55PM +0100, Andrew Lunn wrote:
> > What if there is no kernel behavior associated with it? How can it be mimicked
> > then?
> 
> Simple. Implement the feature in software in the kernel for
> everybody. Then offload it to your hardware.
> 
> Your hardware is an accelerator. You use it to accelerate what linux
> can already do. If Linux does not have the feature your accelerator
> has, that accelerator feature goes unused.

Is it acceptable to have a macro in the Ethernet Driver to conditionally
disable/enable the feature (via setting the corresponding bit in the
register)?

The current implementation is:

	/* Control register */
	writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
	       common->cpsw_base + AM65_CPSW_REG_CTL);

which sets the "AM65_CPSW_CTL_VLAN_AWARE" bit by default.

Could it be changed to:

#define TI_K3_CPSW_VLAN_AWARE 1

...

	/* Control register */
	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
	      AM65_CPSW_CTL_P0_RX_PAD;

#ifdef TI_K3_CPSW_VLAN_AWARE
	val |= AM65_CPSW_CTL_VLAN_AWARE;
#endif

	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);

Since no additional configuration is necessary to disable/enable the
functionality except clearing/setting a bit in a register, I am unsure of
the implementation for the offloading part being suggested. Please let me
know if the above implementation is an acceptable alternative.

Regards,
Siddharth.

