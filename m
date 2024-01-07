Return-Path: <linux-kernel+bounces-18904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15448264EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB11F21560
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280E13AE1;
	Sun,  7 Jan 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A0UzMRz0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6013AC6;
	Sun,  7 Jan 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=W5XQx5jK8PhLssysir7FrxPUWqgxrh2IPRl7HIJNB6Y=; b=A0UzMRz0uVAfd4BdgjKVl99KY4
	PoGXuGRXaplrb0PFHRXrP5fZcXjJcCDQCbaQtoIfYCZEel6fUlO7AyBQW9+ChliajIhuLEvQRZzvu
	hD/Z1Vxuwo1Qqkl2LxwryCDzzdLOrC5RInVjAwynuv59SOMuapLIyzDriSPLn65v01QM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMVhK-004Zle-Tc; Sun, 07 Jan 2024 17:08:26 +0100
Date: Sun, 7 Jan 2024 17:08:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 0/5] support ipq5332 platform
Message-ID: <227543b0-e7a6-4ef6-a0ea-271165f51a6b@lunn.ch>
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <a6a50fb6-871f-424c-a146-12b2628b8b64@gmail.com>
 <cfb04c82-3cc3-49f6-9a8a-1f6d1a22df40@quicinc.com>
 <dd05a599-247a-4516-8ad3-7550ceea99f7@gmail.com>
 <ac1977f5-cd6a-4f16-b0a0-f4322c34c5f5@quicinc.com>
 <bdeca791-f2e5-4256-b386-a75c03f93686@gmail.com>
 <895eadd7-1631-4b6b-8db4-d371f2e52611@lunn.ch>
 <1df87389-d78c-48e0-b743-0fd11bd82b85@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1df87389-d78c-48e0-b743-0fd11bd82b85@gmail.com>

> Andrew, thank you so much for pointing me to that API and Christian's work.
> I have checked the DT change proposal and it fits this QCA8084 case
> perfectly.

Not too surprising, since Christian is working on another Qualcomm PHY
which is very similar.

> Am I right that all one has to do to solve this QCA8084 initialization case
> is wrap phys in a ethernet-phy-package node and use devm_phy_package_join()
> / phy_package_init_once() to do the basic initialization? So simple?

I hope so. Once the correct kernel abstracts are used, it should be
reasonably straight forward. The clock stuff should be made into a
common clock driver, so all the consumer needs to do is enable the one
clock its needs and common clock driver core goes up the tree and
enables what ever needs enabling. It could be we need to use ID values
in the compatible get the PHY driver probed, rather than enumerate it.

Hopefully Lenaro can help get this all done correctly.

    Andrew

