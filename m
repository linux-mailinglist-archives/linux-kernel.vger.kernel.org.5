Return-Path: <linux-kernel+bounces-2755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4881615A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C761F203F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DFB46B81;
	Sun, 17 Dec 2023 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ikXoGqEv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3445BF2;
	Sun, 17 Dec 2023 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=guGfcblazAtaUH8Sd9tR5HWwfwcONlL3bp2RP/xqxcE=; b=ikXoGqEvRnTUDjveUBCQ6oINCm
	qJuABa5ZJO9ZERcH6AKqRYR9Uk2fxNxUAgz0CeOKV43LGQS4oxWtwfik/jnwiVojmS7ud3BKPF59U
	ICJG1eYVUgTEg5D5FBk6v+sfDIN053cK/SeBX+uNy8U6uafEMGIe/hQLFKdZaxraoZfM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEvBj-003AF6-7U; Sun, 17 Dec 2023 18:44:27 +0100
Date: Sun, 17 Dec 2023 18:44:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, vigneshr@ti.com, kristo@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	danishanwar@ti.com, r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-icssg2: Enable PHY
 interrupts for ICSSG2
Message-ID: <b0ecbd1f-354a-443a-849b-b00d2f1554d5@lunn.ch>
References: <20231213080216.1710730-1-s-vadapalli@ti.com>
 <20231213123819.tqh3lm2ceir3qjbk@swimmer>
 <6f1c1a59-cec0-46d1-8ecb-a82d9d444ccf@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1c1a59-cec0-46d1-8ecb-a82d9d444ccf@ti.com>

> Yes, you are right! Edge-Triggered interrupts shouldn't be shared. I missed
> noticing this. Thank you for pointing it out. Since the SoC only supports
> Edge-Triggered interrupts, I believe that the correct decision would be to use
> the interrupt for only one of the two PHYs, while leaving the other PHY in
> polled mode of operation which is the default.

No, if the PHY is using level interrupts, you need the SoC to use
level interrupts. Otherwise you are going to miss interrupts.

The board design is just broken and you cannot use interrupts at all.

    Andrew

