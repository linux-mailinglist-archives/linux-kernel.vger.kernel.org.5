Return-Path: <linux-kernel+bounces-137498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2489E2EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4333F1F21C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9762156F5E;
	Tue,  9 Apr 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ubO/PRkb"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E156F43;
	Tue,  9 Apr 2024 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689621; cv=none; b=aQYyPJpQ64ybEnlnUCdQqngC/zyI3b6rhQixrvMHQR48Cp1RNZMrPp17K5oUFcgoyrS7YxEW2q/GzMk2cw9D4QVIT75o0jlBRc8PQPzau1k9lCRncboDN1sq+XkvM/nqOfP4wkY4kO0TT4zPJSFHWeMU0Humd+WpsLFpIbFXVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689621; c=relaxed/simple;
	bh=WvrvA8ry5wlmlhMRCu3d3k1nKJ8/xuVrTMzhVu41sKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI5tDe9ZqUjCS7leK5plXr+P6O8MI4OcjgjCv2jJCKN5K3dYpvcnCSLQhJ32ETCcMlVVnAsXQVkgfyFfB2g8QCG0G9k+TNrAFa8NV9hn2WXRFNalPz18hxonn353GC1ZLUKAhlRUZ4xD1f25iaWr/hR0u9ZcNqRvbO3/QVquUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ubO/PRkb; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439J6ZXv054752;
	Tue, 9 Apr 2024 14:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712689595;
	bh=NN4bleqQvrERN+/tmCDHDi906k24PoXwUYgENukAc1g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=ubO/PRkbjzvU95KRL9RetX77NF6UqrfI8Vy/NW9q7vW1gqrrA7waE+FXmp3lr2QGI
	 fFJ371vpBRpgm9OkpzgHq1y3jwG9FmzzOz7hSINwySoDFXZFQ+k2Ok0I/KZudeKp9f
	 OFN8bWXxfVJwSsO98ys/MtnzoAlbKduWP0vjR2WA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439J6Za7107842
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:06:35 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:06:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:06:35 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439J6Zaa036245;
	Tue, 9 Apr 2024 14:06:35 -0500
Date: Tue, 9 Apr 2024 14:06:35 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Michael Walle <mwalle@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-evm: Enable eMMC support
Message-ID: <20240409190635.twbv45ewbbprhqme@jimmy>
References: <20240403102302.3934932-1-mwalle@kernel.org>
 <20240404074515.GA5639@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404074515.GA5639@francesco-nb>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:45-20240404, Francesco Dolcini wrote:
> Hello Michael,
> 
> On Wed, Apr 03, 2024 at 12:23:02PM +0200, Michael Walle wrote:
> > The J722S EVM has an on-board eMMC. Enable the SDHC interface for it.
> > There is no pinmuxing required because the interface has dedicated pins.
> > 
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > ---
> > v2:
> >  - move status="okay" last
> > ---
> >  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> > index cee3a8661d5e..6b148da2bcdc 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> > +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> > @@ -369,6 +369,13 @@ partition@3fc0000 {
> >  
> >  };
> >  
> > +&sdhci0 {
> > +	ti,driver-strength-ohm = <50>;
> 
> According to the latest DTS coding style guidelines this needs to be
> just before status.
> 
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node
> 
> Yes, we would need a checker, I know and I agree. At least now we moved
> out of the tribal knowledge way of working with every maintainer having
> slightly different expectation on this topic ... one step at a time :-)

Since this is the first cycle, I have done this fixup locally.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

