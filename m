Return-Path: <linux-kernel+bounces-136512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDD89D500
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDA81F219DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD187E580;
	Tue,  9 Apr 2024 08:59:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A317E58D;
	Tue,  9 Apr 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653162; cv=none; b=uFZOq3dHNrI89mn5TZ/JO63X00nO8sw1G4dfZO0xTgwpdno2m/o5yl4khhnwhFvl8Fe2MVp/HU8lotkRHLBsQwf+oat91RH0eQuA5sof/UlfevU9a+OE3ezjEWHLbAvLnJYm9CINJZaF7PZ23S2xb01KYf+NqMVVzBUdZkNXMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653162; c=relaxed/simple;
	bh=KCpOq37DoZ0XlecPHNOet095n+CLFkfvniEzo6nfVBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGyqz8nOrWpKkAOfI+Uq2yyI7oUg9sq0+ZGZ7yUnff/U3a1zLvLBCTPqJJNoBVhWJVLeanC4JEw91BQj4om3yYLSuLmL2o50xCt5ByiByqkybABtiH1v2gp7fiwIl8hOUbw/VWGCg9PAtMsNK5VF9c40QTXXjro8Qci1GwZcylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C3A4DA7;
	Tue,  9 Apr 2024 01:59:51 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE60F3F6C4;
	Tue,  9 Apr 2024 01:59:18 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:59:16 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] firmware: arm_scmi: add initial support for i.MX
 BBM protocol
Message-ID: <ZhUDZGJilhczKlDD@bogus>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-3-9fc9186856c2@nxp.com>
 <ZhQxu8LVNKf5QDLm@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQxu8LVNKf5QDLm@pluto>

On Mon, Apr 08, 2024 at 07:04:43PM +0100, Cristian Marussi wrote:
> On Fri, Apr 05, 2024 at 08:39:25PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > The i.MX BBM protocol is for managing i.MX BBM module which provides
> > RTC and BUTTON feature.
> > 
> 
> I appreciate that you added versioning but I think a bit of documentation
> about what the protocol and its comamnds purpose is still lacking, as asked
> by Sudeep previously
> 
> 	https://lore.kernel.org/linux-arm-kernel/ZeGtoJ7ztSe8Kg8R@bogus/#t
>

I have decided to ignore all these vendor protocol patches until they have
some documentation to understand what these protocol are for, what are
the commands, their input/output parameter details, any conditions are the
caller and callee,..etc very similar to SCMI spec.

To start with can you please expand what is BBM or MISC protocol is ?
Don't expect me to respond if the requested details are still missing in
the future versions, I am going to ignore it silently.

I have asked for these in atleast 2 different threads may be not just NXP
patches but in one instance Qcom patches, but they apply equally here.

-- 
Regards,
Sudeep

