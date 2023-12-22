Return-Path: <linux-kernel+bounces-9218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE1E81C26F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D72285B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C598A53;
	Fri, 22 Dec 2023 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxBcCIzz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047D818;
	Fri, 22 Dec 2023 00:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C3EC433C8;
	Fri, 22 Dec 2023 00:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703206141;
	bh=1DA8bmTOYGPA5GbuB9k2g469eTAv0F3olwtXeYlHwR0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gxBcCIzz0cbD3ugkonPp9VYh2HSxnLxa44GHnYR4IW6PW3J4Rgn6Pi+WryMmWt1u+
	 5wnyPnVzVHb6DgT2GO27/QCOg4t+BvjuTcwizCAit096W6X13xq+4fB/fkm9xMJ+mV
	 XzzXiN6P8tqW/3UKazKRBC1dyh6uQYainN29c7Cz5EVUloedh5VnVDqEwg5ox/ZTPE
	 WAnKi/wnq12bdu9JOoLCsG2Hs1BtJrFNhXZ6TLM0u4y2mx2j+ug/sbSq8E3XmcfDh4
	 /mURGarpcdtNGvskvrtl4VatuZlGrDntmlitK3JCfTA5uqUMlr1JBBqsp/hc9VSEVz
	 hmabHJBfCHumw==
Message-ID: <a2d96b8259eed101c649fd71f7c1e453.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <21f758cb-ae25-4d74-905c-0d4820f00070@foss.st.com>
References: <20231219130909.265091-1-gabriel.fernandez@foss.st.com> <20231219130909.265091-2-gabriel.fernandez@foss.st.com> <c98539f99030f174583d7ee36802b4b9.sboyd@kernel.org> <21f758cb-ae25-4d74-905c-0d4820f00070@foss.st.com>
Subject: Re: [PATCH v7 1/2] clk: stm32: introduce clocks for STM32MP257 platform
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 Dec 2023 16:48:59 -0800
User-Agent: alot/0.10

Quoting Gabriel FERNANDEZ (2023-12-21 02:31:53)
>=20
> On 12/20/23 23:16, Stephen Boyd wrote:
> > Quoting gabriel.fernandez@foss.st.com (2023-12-19 05:09:08)
> >> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk=
-stm32mp25.c
> >> new file mode 100644
> >> index 000000000000..313e022c6142
> >> --- /dev/null
> >> +++ b/drivers/clk/stm32/clk-stm32mp25.c
> >> @@ -0,0 +1,1826 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
> >> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMi=
croelectronics.
> >> + */
> >> +
> >> +#include <linux/clk.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#include "clk-stm32-core.h"
> >> +#include "reset-stm32.h"
> >> +#include "stm32mp25_rcc.h"
> >> +
> >> +#include <dt-bindings/clock/st,stm32mp25-rcc.h>
> >> +#include <dt-bindings/reset/st,stm32mp25-rcc.h>
> >> +
> >> +static const struct clk_parent_data adc12_src[] =3D {
> >> +       { .name =3D "ck_flexgen_46" },
> > This is a new driver. Don't use .name here. Instead use .index or .hw
> > and if that can't work then use .fw_name.
>=20
> These parent clocks are managed by a secure world and exposed through SCM=
I.
>=20
> If I use .index or .fw_name, do I have to expose 122 clocks in my DT node=
 ?
>=20
> This will significantly increase the size of the DT file
>=20
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 clock-names =3D=
 "hse", "hsi", ..., "ck_scmi_stm500";
>  =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 clocks =3D <&sc=
mi_clk CK_SCMI_HSE>, <&scmi_clk CK_SCMI_HSI>,=C2=A0=20
> ... , =C2=A0 <&scmi_clk CK_SCMI_STM500>;
>=20

Yes? We want DT to express the connections between device nodes, and if
the clks managed by SCMI are consumed here then they need to be
specified via the clocks property.

>=20
> >
> >> +       { }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
> >> +
> >> +static int get_clock_deps(struct device *dev)
> > What is the explanation for this function?
>=20
> It 's to manage the dependency with the SCMI clock driver.

Please elaborate. Are you making sure the SCMI clk driver has probed
before this driver? Why? What's wrong with probing this driver first?

