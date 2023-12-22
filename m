Return-Path: <linux-kernel+bounces-9979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA49B81CE12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA09B2486B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F72C19B;
	Fri, 22 Dec 2023 17:44:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084FE2C188;
	Fri, 22 Dec 2023 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 772B92F4;
	Fri, 22 Dec 2023 09:44:45 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A76543F738;
	Fri, 22 Dec 2023 09:43:56 -0800 (PST)
Date: Fri, 22 Dec 2023 17:43:53 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 7/7] pinctrl: scmi: implement
 pinctrl_scmi_imx_dt_node_to_map
Message-ID: <ZYXK2YVJ1nnETSuI@pluto>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-7-0fe35e4611f7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-pinctrl-scmi-v1-7-0fe35e4611f7@nxp.com>

On Fri, Dec 15, 2023 at 07:56:35PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
> OEM Pin Configuration type, so need i.MX specific dt_node_to_map.
> 

This does not even compile for me, as of now, when configuring the Pinctrl
SCMI driver as a module with your IMX custom additions. (I think the
Makefile with the additional pinctrl-imx is wrong in how describes the
objects composing the pinctrl-scmi module with IMX addons...)

ERROR: modpost: "pinctrl_scmi_imx_dt_node_to_map" [drivers/pinctrl/pinctrl-scmi.ko] undefined!              
make[3]: *** [dev/src/linux/scripts/Makefile.modpost:145: Module.symvers] Error 1                                   
make[2]: *** [dev/src/linux/Makefile:1863: modpost] Error 2                                                         
make[1]: *** [dev/src/linux/Makefile:234: __sub-make] Error 2 
make[1]: Leaving directory dev/out_linux       
make: *** [Makefile:234: __sub-make] Error 2                                                  

More in general, I think that this NXP OEM specific additions, which are
in general welcome (and indeed as you know part of the spec was modified
to allow for OEM specific needs), do NOT belong to this generic SCMI
Pinctrl driver, because the driver from Oleksii/EPAM was born as a
generic SCMI driver and it fits perfectly with the Generic Pinctrl
Linux subsystem and related generic bindings parsing: now with this
you are trying to stick a custom OEM slight varied behaviour (and
related binding) on top of a generic thing.

And this choice leads to a number of additional changes in the SCMI core
to support an even more complex handling of SCMI devices, which is
already too complex IMO..

IOW...I dont think that the whole idea of the per-protocol optional
compatible to be able to select slightly different behaviours/parsing
would have a great chance to fly sincerely...

I know there is an issue with having a completely distinct SCMI IMX
pinctrl driver that uses the same protocol node @19 (without the need for
the compatible trick) due to the way in which the Pinctrl subsystem
searches for devices (by of_node)...I'll think about an alternative
way to allow this but I am not sure (as you saw) that would be so easily
doable...

Also, I am wondering if this is really a problem in reality since I would
NOT expect you to load/ship both the OEM/NXP custom specific SCMI pinctrl
driver AND the generic one on the same platform (after having made them
distinct I mean...) am I wrong ?
(so you could even made them exclude each other at compile time...far
from being the best option I agree...)

Thanks,
Cristian

