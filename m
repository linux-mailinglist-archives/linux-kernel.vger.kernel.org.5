Return-Path: <linux-kernel+bounces-83499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F11869A45
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA961C217E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3454FB1;
	Tue, 27 Feb 2024 15:24:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8F13DBA4;
	Tue, 27 Feb 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047462; cv=none; b=NlC+lcaYdFPEeRzTkrk9anCsLW2dihhCU8reMD451DvDw6udW1Lb1bGlSX2SNzjGWrSwNcxrXPkjrp9oCrKU0Xn2BJBte+r6Pi4iLyfbHbBmTtGHDEEXApd8U2idvubG1UXQ9f5FCs0Ln92zEjBz6TUj5+Ss+BrMVB9MQWU0jkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047462; c=relaxed/simple;
	bh=/Uwsd+biNsWqGl6YO5r7MlVVEdSRgIgi42i+iiL7RY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WERz+ganPnDpVaX+ewbTZL48oc/s/Z8a4ANj1vufjP1nguBpqcLVDfbh/Zi0kwme0QRjJjdwvsgOIg3jo329iGVfz1iXfekj9tW8Y/rEsZGm5z+VvIJt9t07pMlMUDzJY5cEqr9IBrSAFja1dQE9s9nrHLTe9QpVCcxC1iooNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BA75DA7;
	Tue, 27 Feb 2024 07:24:57 -0800 (PST)
Received: from bogus (unknown [10.57.94.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B445E3F762;
	Tue, 27 Feb 2024 07:24:16 -0800 (PST)
Date: Tue, 27 Feb 2024 15:24:15 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <20240227152415.xpa3y6226vrqfguk@bogus>
References: <20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com>
 <20240223-pinctrl-scmi-v4-3-10eb5a379274@nxp.com>
 <CACRpkdZLuWwecacBAimT=Vj67dGabzBH-7aaqzoyj1B1sY6o_A@mail.gmail.com>
 <ZdhYc90uy7yuYrx2@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdhYc90uy7yuYrx2@pluto>

On Fri, Feb 23, 2024 at 08:33:55AM +0000, Cristian Marussi wrote:
> On Fri, Feb 23, 2024 at 09:28:12AM +0100, Linus Walleij wrote:
> > On Fri, Feb 23, 2024 at 2:08 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> > 
> > > From: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > >
> > > Add basic implementation of the SCMI v3.2 pincontrol protocol.
> > >
> > > Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> > > Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > Co-developed-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > This looks ripe for merging for me, there are clearly dependencies in the SCMI
> > firmware tree so I can't apply this to the pin control tree, but if
> > someone creates
> > an immutable branch from the SCMI firmware repo (based off v6.8-rc1 or so)
> > I'm happy to also pull the branch into pin control.
> > 
> 
> Well, AFAIK there is another upcoming change in the v3.2 SCMI spec and
> I am not sure if this series accounts for it...indeed the v3.2 -bet4 was
> still pending fr feedback AFAIK (and I doubt latest changes are in since
> they have been discussed like yesterday...)....but I maybe wrong, I will
> chase for the final spec and look into this to verify if it is
> compliant...
> 
> Anyway, given the particularly long history of changes in PINCTRL v3.2
> SCMI I would wait to have the final spec officially frozen at this
> point before merging....
> 

+1, this is one reason I have been avoiding to look at pinmux changes yet.
I want to see the spec changes settle to be comfortable to merge any changes.
I think it should be fine as v6.10 material.

-- 
Regards,
Sudeep

