Return-Path: <linux-kernel+bounces-127516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B843894CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5121C21964
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35033CF65;
	Tue,  2 Apr 2024 07:48:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5753B29A;
	Tue,  2 Apr 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044132; cv=none; b=d3aPi6jfMUFzRSLky+xQOTPwMhl6/bMOS+kT827pzC3ZHhE7GvxRLAjgp05WYaVarXibm6CHvoZPEyA71ViqRM26sviEQkmzIoPQ8W17HWeBdr8orhDbuMY3pZMfC2NEPXVKxCtYKnq4pstMHLe1OxEPco4TKVQxKfqa83ElZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044132; c=relaxed/simple;
	bh=xudrbFG1OklbyuU2y6nzlMSY6MlqTsTkKxZNUae6GEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob6bMVZHeZiHChgNKymtnc81jxf0YrV0iQOK/fkruCTSoQyMHAOF/ZfLCdK9y7CxbApmcaaISnmDptR9YbjiAvZnOrOcrOdmqo43Jq7Hr5rgnI9IOEOl2SWv6KPBKbKGpTbrAJiD1Kq1qe0DYz50EzZ8AUByzh/D07pLvI70ENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D201B1042;
	Tue,  2 Apr 2024 00:49:20 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C72A3F64C;
	Tue,  2 Apr 2024 00:48:46 -0700 (PDT)
Date: Tue, 2 Apr 2024 08:48:44 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <Zgu4Tok43W5t8KM0@pluto>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Sun, Mar 31, 2024 at 01:44:28PM +0000, Peng Fan wrote:
> Hi Andy,
> 

Hi Peng,


> > Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> > protocol basic support
> > 
> > Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoitti:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add basic implementation of the SCMI v3.2 pincontrol protocol.
> > 
> > ...
> > 
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> > > scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o
> > > system.o voltage.o powercap.o
> > 
> > Actually you want to have := here.
> > 
> > > +scmi-protocols-y += pinctrl.o
> > 
> > 
> > 
> > >  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y)
> > > $(scmi-transport-y)
> > 
> > Side note: The -objs has to be -y
> > 
> > ...
> > 
> > > +#include <linux/module.h>
> > > +#include <linux/scmi_protocol.h>
> > > +#include <linux/slab.h>
> > 
> > This is semi-random list of headers. Please, follow IWYU principle (include
> > what you use). There are a lot of inclusions I see missing (just in the context of
> > this page I see bits.h, types.h, and  asm/byteorder.h).
> 
> Is there any documentation about this requirement?
> Some headers are already included by others.
> 

Andy made (mostly) the same remarks on this same patch ~1-year ago on
this same patch while it was posted by Oleksii.

And I told that time that most of the remarks around devm_ usage were
wrong due to how the SCMI core handles protocol initialization (using a
devres group transparently).

This is what I answered that time.

https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937-lin/#t

I wont repeat myself, but, in a nutshell the memory allocation like it
is now is fine: a bit happens via devm_ at protocol initialization, the
other is doe via explicit kmalloc at runtime and freed via kfree at
remove time (if needed...i.e. checking the present flag of some structs)

I'll made further remarks on v7 that you just posted.

Thanks,
Cristian


