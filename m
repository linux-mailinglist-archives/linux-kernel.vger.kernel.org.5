Return-Path: <linux-kernel+bounces-97808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A280B876FC8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176E01F21802
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85988374F5;
	Sat,  9 Mar 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cA01VfFL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2095.outbound.protection.outlook.com [40.92.23.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD62C6A9;
	Sat,  9 Mar 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709972960; cv=fail; b=r3RDWyHl37COitOZ86HunErNWjQ8sgx7wdm6WfghpmspQoJ6y02U/NeAUeWvyB956yl16JKCsjEOsRmuPCpEeRiR46EhayzKJKqZ9sidr/85rmtmKf8Zgch21nC+PhLqklDuCnWLn9bfhO1UiVrkTkL8/E7T6arzsTjDeaoJw4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709972960; c=relaxed/simple;
	bh=URKXIBghuJW3DhhqYSahh1Sq5SNnoXUnfQMYm/eouHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mEEPAp4rKYlZUPRhLQpjJbmM0s0OXsM1vbEUYVoxMz43dF/JrBUiv7H4ENexNY6Ji0J61NYtPyBDCHg7eVQex5oLEo6RPxyHDDA//69eqePzHTVgheMplNo3tlshMdyJL20fNYtZ4WUdZ24OSuMN0QrFcd6TZJNoPEQ8aBhJaPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cA01VfFL; arc=fail smtp.client-ip=40.92.23.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihQcYhF+buOrrD0tnbToriPiYsEYuAIMVbe2sThebogNdMZzJP271+o7BsAFjsL0NO0nIAVelvfSoRFELXyT7PNZOBgXmLs+lvHKd/zNWLajXCnOj7eCSOhR6awfud/MzhBMwoeU2ejOS+CQd0xBP0hzcXpsBe2AhW9MnW4VmAzXWqMZzsXjgWETbkIK91NVwdR2HidqnFyXYqMe4QxF5c5wtnGrZM2x7TDwV4XndcYGuhrjut33dEQfp8mpeK6qxNGFNx58ZvOqvW+uU2Ow02CJ+ewOJYERcvJx4pqsJjcujemsmRihcWnJFHFcITmR5MO9RZ5mKVJHVn9IpBn/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiXhvrVPJccXma9Cpkt81XFVNWyIILlpkhM42aAC7Ok=;
 b=XfCabKiqEzw10yfYJdEWAz+bwuGlAj/t7h3dVCFfKKaS7EKE7JId2ffipiGso31r8mGxSrh77XO6iHUx0zZ32D63m3nI7hWoJOGeyMLYHuL1eWMTvN3eEkrQ3U3ER4TExA0SsnUtSL24E4+O1wY/cKVjb3GWJIMz+KLpyOoEIpQRAfGTWuUXEcqzBRGPH2wKqQT5sS5kjURbXZYAEKiZ5PziquLn8jy4A0hEw5yN2I43gEVfV0xfJEWl5dl68Qe0itV3M5y1Jc+LM5aGa28UgYZ90T9plxXDWZQTZ/S6E5DgGscrEzBleHRlAib1kZZD1n9Cx7KHVklte8FbDtHwag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiXhvrVPJccXma9Cpkt81XFVNWyIILlpkhM42aAC7Ok=;
 b=cA01VfFLP/kgx8aL2cjOWlktQf0CkkydZ8n0LwLCZmXNIEFvNoslQ4RZiUhnnng8HX4NW8ZFo45cK5HLUKZ8xTV6fnhYvFwt8J8g42UJH/NoHERyYKi/UCze0p3a/m9b7v8+GAc5Gf03Bmh/HbpyRimnZb+CupXSD6SNKYgiT+Y7ISr3lv6hqErO6Aih/2lewc49E0M0twMbG1eK8F/6I7FKxLTvIOHH1RJcLoKxI5Wr7dBKhqjgFpPi6sMBExCe/uirC94Z7E/BJcRxv3m44xLS3P4NqPRr20QiQ5nchJSnr6EOyL6D/sXA1tQ2TqZ9jm2vMlcCR1VWYCRf0v3++w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5499.namprd20.prod.outlook.com (2603:10b6:930:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.32; Sat, 9 Mar
 2024 08:29:15 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::8615:efe2:7c8e:2041%3]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 08:29:15 +0000
Date: Sat, 9 Mar 2024 16:29:02 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Rob Herring <robh+dt@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/8] clk: sophgo: Add CV1800/SG2000 series clock
 controller driver skeleton
Message-ID:
 <IA1PR20MB4953835A7C72DB5DEFA1640FBB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953366482FEBFC5E7F6F34BBB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953925533ACD65B32D423D9BB4F2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <55a896bcb94af629bb58c304268ac7ec.sboyd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55a896bcb94af629bb58c304268ac7ec.sboyd@kernel.org>
X-TMN: [dxV9obeUK52wAjk6WtYG9x6bBS8kG1L7P8OS/R7xI0w=]
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <agunqpwzt35uepxgrwi2adihkmow4jzdny3mz2okvllh5vis62@rkdl4ykxrmzi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4f2e4a-32f4-4b79-d5e4-08dc40130134
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n2bH/Mx0YX+wCARR+D6vImONNL+Mc8JZ/pOt5uDjNl+0y2v1hvNahurYzEX9afWeoYK2cSWBR6/jTfx+Jg0EO2UZKCHBIGZZ/oMWshaMrZ6S9UJJHNevsOeG3JHcWvDw/dIn5CQKMaVYM70904OalvQ6w2NTaLFyqNX4CbKxr/JWJjCqKfSulsO0eV6qbtqtgFnx6cz82OaZEpSY0B+4d/Ez66XnJLXv9uuFntqqgnQdpIKVUTBibf+UFpX9Lod0/8tuDWvnDkhs4aA7khsqlvzRmtsFoieq7rJd2xHs/i9QJdYfV36LDal+QBC/MwTf406+mViyHQraOJ3FZGUaE0unnp1QNvVM7SHtU3eulkL+GF0cl6AdnHM/xLVXJsIGT7hAtM3gFeNkSsGB5Ei7D3+2DnYa6ogtQo1apKOoCEhp6wqL0ZXrePZysmQgAjEB22RIQPtWISyZpbQT37c/AlDv+BsrP2IneqyZ6pzmgHjSX71BTmsaGnk+rQflsSwQTNC6VR8KziHMKJpNzaKs7xOitNmtXEfPeXRq3Zt+V+n4wl/upV1uTfRVJtr33a4Mo+VYXLtCf5m74gJBwYc30SYFBfpG/Xs5Jynctd6at6CueKpJOpHV+klzio78oNdA
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0NnUvCRXGzVgXjrw4BzdpPa/YeLdiuypOmuu7VYqxQReamNCO10+fSVWN7Le?=
 =?us-ascii?Q?SXcy0xUhIZXPkuj5BoaRIpn045RAiDm/XPD5RMAGU0GRCfIWusT/jM19MM94?=
 =?us-ascii?Q?i2i3ozLuRN4nqU3tMRrNplTS8g+0Bqk8X9U/k06vFfChtLoW1LgaqcBFMc1b?=
 =?us-ascii?Q?ZgNcifjYuUvmWwvFuWJ9+p/kN3tg8nE3kLALVdoI/FeEzaC4fUs6NmzaCiZq?=
 =?us-ascii?Q?37ezmdVQUxQ1Pb3dF4BfFr3V7XYMm6AfBe4jRnLGzcqkTKVVcehglEIss1it?=
 =?us-ascii?Q?yGaJymmKbr2kMMR+bMkNci7ruhaa7ieF61oRG/VgQHZWtRgrkvABow70bMiP?=
 =?us-ascii?Q?08DfsJTMco2zdLCV0XUPOgTYu0f+VgpX9ZDJnO7S6O0T1utmDXEf3gdmuoUK?=
 =?us-ascii?Q?xS67HjZ7zjdkRHL1EFvsjIhCe7rk4Tm3A40gf7mtBKltNLpdw7CuNUPgnESY?=
 =?us-ascii?Q?WDqp6D8tIB1tVPJq79/4YYe83ZB0J4ZEC+e3jmPo0u/FM27GszhdPZMppkLJ?=
 =?us-ascii?Q?Krhd4JNw8RBr1nyas66XncWa7TsHom/RXIu0tQYGe1vsXAND7kkmX98LKJbK?=
 =?us-ascii?Q?K1wLQnjHSHJutB1xJ62abvXVfL3QShEy51SaFxhQsI9HuoB9VXnbh9x78eLs?=
 =?us-ascii?Q?qNFIfEmatrziSsLZEPCqdyZzoKnmO5Xd9ycekSF1ZZ3V2Cov5u5QRNNTxiHf?=
 =?us-ascii?Q?ALd92icCaiRGbTMAus9TIUv8GvHchM86BUnTtkD6O2Mb81Z6IdrzBMNJByER?=
 =?us-ascii?Q?CTlTXOosMyPLuzMsFZRARdvRl/CSar57pFAYljoziKZG/+v6dFIAZVi1LYvz?=
 =?us-ascii?Q?J1MtcjPFNFIfsn2EwOX2R3C8TRNLSLVDMYHiQyoR8yeSxuhUpN3qfIBz0dsQ?=
 =?us-ascii?Q?U4PfxK4LjVjvY1nxLp6ne/SBMYKSXOyBtKrvDtWyhbAFX8s673/YPScj1ybG?=
 =?us-ascii?Q?QO5TkYycWhbYMwpZOI0qVbE5xWJxhuP/3+KHlFrwrAYxPwrwQB9zShA7k2Sf?=
 =?us-ascii?Q?/ZuoTamVfZf0/LL1YDtpou5oAX5TepP+eXs5R4wsU0RCjmQ1eFMPrLD885tb?=
 =?us-ascii?Q?LxKs41NpKGpdogNR4tClpY2Mz2wi1LnJkM9xqr2UUjB+oLeT0jnpehGEU2wZ?=
 =?us-ascii?Q?ZKy2STYlhgySnsU/OAkrimVtZ6TVEYYw5WFTQ5a3Lvdu+CKxb/P3HumtaKJZ?=
 =?us-ascii?Q?rEevKbkPGxfDy2RZH/tCJvQihJ0A1xKjpC8nKvrzdlpnz1Wb2e6cViJ1J9ci?=
 =?us-ascii?Q?qdY2uK6QzK+D3UlbNJmy?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4f2e4a-32f4-4b79-d5e4-08dc40130134
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 08:29:15.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5499

On Fri, Mar 08, 2024 at 09:21:34PM -0800, Stephen Boyd wrote:
> Quoting Inochi Amaoto (2024-02-13 00:22:34)
> > diff --git a/drivers/clk/sophgo/Kconfig b/drivers/clk/sophgo/Kconfig
> > new file mode 100644
> > index 000000000000..d67009fa749f
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# common clock support for SOPHGO SoC family.
> > +
> > +config CLK_SOPHGO_CV1800
> > +       tristate "Support for the Sophgo CV1800 series SoCs clock controller"
> > +       default m
> 
> Please remove any default and set it in the defconfig instead.
> 
> > +       depends on ARCH_SOPHGO || COMPILE_TEST
> > +       help
> > +         This driver supports clock controller of Sophgo CV18XX series SoC.
> > +         The driver require a 25MHz Oscillator to function generate clock.
> > +         It includes PLLs, common clock function and some vendor clock for
> > +         IPs of CV18XX series SoC
> > diff --git a/drivers/clk/sophgo/clk-cv1800.c b/drivers/clk/sophgo/clk-cv1800.c
> > new file mode 100644
> > index 000000000000..7183e67f20bf
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/clk-cv1800.c
> > @@ -0,0 +1,113 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "clk-cv18xx-common.h"
> > +
> > +struct cv1800_clk_ctrl;
> > +
> > +struct cv1800_clk_desc {
> > +       struct clk_hw_onecell_data      *clks_data;
> > +
> > +       int (*pre_init)(struct device *dev, void __iomem *base,
> > +                       struct cv1800_clk_ctrl *ctrl,
> > +                       const struct cv1800_clk_desc *desc);
> > +};
> > +
> > +struct cv1800_clk_ctrl {
> > +       const struct cv1800_clk_desc    *desc;
> > +       spinlock_t                      lock;
> > +};
> > +
> > +static int cv1800_clk_init_ctrl(struct device *dev, void __iomem *reg,
> > +                               struct cv1800_clk_ctrl *ctrl,
> > +                               const struct cv1800_clk_desc *desc)
> > +{
> > +       int i, ret;
> > +
> > +       ctrl->desc = desc;
> > +       spin_lock_init(&ctrl->lock);
> > +
> > +       for (i = 0; i < desc->clks_data->num; i++) {
> > +               struct clk_hw *hw = desc->clks_data->hws[i];
> > +               struct cv1800_clk_common *common;
> > +               const char *name;
> > +
> > +               if (!hw)
> > +                       continue;
> > +
> > +               name = hw->init->name;
> > +
> > +               common = hw_to_cv1800_clk_common(hw);
> > +               common->base = reg;
> > +               common->lock = &ctrl->lock;
> > +
> > +               ret = devm_clk_hw_register(dev, hw);
> > +               if (ret) {
> > +                       dev_err(dev, "Couldn't register clock %d - %s\n",
> > +                               i, name);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +                                         desc->clks_data);
> > +
> > +       return ret;
> 
> Just return devm...
> 
> > +}
> > +
> > +static int cv1800_clk_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       void __iomem *reg;
> > +       int ret;
> > +       const struct cv1800_clk_desc *desc;
> > +       struct cv1800_clk_ctrl *ctrl;
> > +
> > +       reg = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(reg))
> > +               return PTR_ERR(reg);
> > +
> > +       desc = device_get_match_data(dev);
> > +       if (!desc) {
> > +               dev_err(dev, "no match data for platform\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       ctrl = devm_kmalloc(dev, sizeof(*ctrl), GFP_KERNEL);
> 
> Why not devm_kzalloc?
> 
> > +       if (!ctrl)
> > +               return -ENOMEM;
> > +
> > +       if (desc->pre_init) {
> > +               ret = desc->pre_init(dev, reg, ctrl, desc);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       ret = cv1800_clk_init_ctrl(dev, reg, ctrl, desc);
> > +
> > +       return ret;
> 
> This is return cv1800_clk_init_ctrl(...
> 
> > +}
> > +
> > +static const struct of_device_id cv1800_clk_ids[] = {
> > +       { }
> 
> Don't do this. Just send the whole driver as one patch.
> 

Thanks, I will squash the folling two patch with this.

> > +};
> > +MODULE_DEVICE_TABLE(of, cv1800_clk_ids);
> > +
> > +static struct platform_driver cv1800_clk_driver = {
> > +       .probe  = cv1800_clk_probe,
> > +       .driver = {
> > +               .name                   = "cv1800-clk",
> > +               .suppress_bind_attrs    = true,
> > +               .of_match_table         = cv1800_clk_ids,
> > +       },
> > +};
> > +module_platform_driver(cv1800_clk_driver);
> > +MODULE_LICENSE("GPL");
> > diff --git a/drivers/clk/sophgo/clk-cv18xx-common.c b/drivers/clk/sophgo/clk-cv18xx-common.c
> > new file mode 100644
> > index 000000000000..cbcdd88f0e23
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/clk-cv18xx-common.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/bug.h>
> > +
> > +#include "clk-cv18xx-common.h"
> > +
> > +int cv1800_clk_setbit(struct cv1800_clk_common *common,
> > +                     struct cv1800_clk_regbit *field)
> > +{
> > +       u32 mask = BIT(field->shift);
> > +       u32 value;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(common->lock, flags);
> > +
> > +       value = readl(common->base + field->reg);
> > +       writel(value | mask, common->base + field->reg);
> > +
> > +       spin_unlock_irqrestore(common->lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +int cv1800_clk_clearbit(struct cv1800_clk_common *common,
> > +                       struct cv1800_clk_regbit *field)
> > +{
> > +       u32 mask = BIT(field->shift);
> > +       u32 value;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(common->lock, flags);
> > +
> > +       value = readl(common->base + field->reg);
> > +       writel(value & ~mask, common->base + field->reg);
> > +
> > +       spin_unlock_irqrestore(common->lock, flags);
> > +
> > +       return 0;
> > +}
> > +
> > +int cv1800_clk_checkbit(struct cv1800_clk_common *common,
> > +                       struct cv1800_clk_regbit *field)
> > +{
> > +       return readl(common->base + field->reg) & BIT(field->shift);
> > +}
> > +
> > +#define PLL_LOCK_TIMEOUT_US    (200 * 1000)
> > +
> > +void cv1800_clk_wait_for_lock(struct cv1800_clk_common *common,
> > +                             u32 reg, u32 lock)
> > +{
> > +       void __iomem *addr = common->base + reg;
> > +       u32 regval;
> > +
> > +       if (!lock)
> > +               return;
> > +
> > +       WARN_ON(readl_relaxed_poll_timeout(addr, regval, regval & lock,
> > +                                          100, PLL_LOCK_TIMEOUT_US));
> > +}
> > diff --git a/drivers/clk/sophgo/clk-cv18xx-common.h b/drivers/clk/sophgo/clk-cv18xx-common.h
> > new file mode 100644
> > index 000000000000..2bfda02b2064
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/clk-cv18xx-common.h
> > @@ -0,0 +1,81 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> > + */
> > +
> > +#ifndef _CLK_SOPHGO_CV18XX_IP_H_
> > +#define _CLK_SOPHGO_CV18XX_IP_H_
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/bitfield.h>
> > +
> > +struct cv1800_clk_common {
> > +       void __iomem    *base;
> > +       spinlock_t      *lock;
> > +       struct clk_hw   hw;
> > +       unsigned long   features;
> > +};
> > +
> > +#define CV1800_CLK_COMMON(_name, _parents, _op, _flags)                        \
> > +       {                                                               \
> > +               .hw.init = CLK_HW_INIT_PARENTS_DATA(_name, _parents,    \
> > +                                                   _op, _flags),       \
> > +       }
> > +
> > +static inline struct cv1800_clk_common *
> > +hw_to_cv1800_clk_common(struct clk_hw *hw)
> > +{
> > +       return container_of(hw, struct cv1800_clk_common, hw);
> > +}
> > +
> > +struct cv1800_clk_regbit {
> > +       u16             reg;
> > +       s8              shift;
> > +};
> > +
> > +struct cv1800_clk_regfield {
> > +       u16             reg;
> > +       u8              shift;
> > +       u8              width;
> > +       s16             initval;
> > +       unsigned long   flags;
> > +};
> > +
> > +#define CV1800_CLK_BIT(_reg, _shift)   \
> > +       {                               \
> > +               .reg = _reg,            \
> > +               .shift = _shift,        \
> > +       }
> > +
> > +#define CV1800_CLK_REG(_reg, _shift, _width, _initval, _flags) \
> > +       {                                                       \
> > +               .reg = _reg,                                    \
> > +               .shift = _shift,                                \
> > +               .width = _width,                                \
> > +               .initval = _initval,                            \
> > +               .flags = _flags,                                \
> > +       }
> > +
> > +#define cv1800_clk_regfield_genmask(_reg) \
> > +       GENMASK((_reg)->shift + (_reg)->width - 1, (_reg)->shift)
> > +#define cv1800_clk_regfield_get(_val, _reg) \
> > +       (((_val) >> (_reg)->shift) & GENMASK((_reg)->width - 1, 0))
> > +#define cv1800_clk_regfield_set(_val, _new, _reg)    \
> > +       (((_val) & ~cv1800_clk_regfield_genmask((_reg))) | \
> > +        (((_new) & GENMASK((_reg)->width - 1, 0)) << (_reg)->shift))
> > +
> > +#define _CV1800_SET_FIELD(_reg, _val, _field) \
> > +       (((_reg) & ~(_field)) | FIELD_PREP((_field), (_val)))
> > +
> > +int cv1800_clk_setbit(struct cv1800_clk_common *common,
> > +                     struct cv1800_clk_regbit *field);
> > +int cv1800_clk_clearbit(struct cv1800_clk_common *common,
> > +                       struct cv1800_clk_regbit *field);
> > +int cv1800_clk_checkbit(struct cv1800_clk_common *common,
> > +                       struct cv1800_clk_regbit *field);
> > +
> > +void cv1800_clk_wait_for_lock(struct cv1800_clk_common *common,
> > +                             u32 reg, u32 lock);
> > +
> > +#endif // _CLK_SOPHGO_CV18XX_IP_H_
> > diff --git a/drivers/clk/sophgo/clk-cv18xx-ip.c b/drivers/clk/sophgo/clk-cv18xx-ip.c
> > new file mode 100644
> > index 000000000000..cd397d102442
> > --- /dev/null
> > +++ b/drivers/clk/sophgo/clk-cv18xx-ip.c
> > @@ -0,0 +1,98 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Inochi Amaoto <inochiama@outlook.com>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/io.h>
> > +#include <linux/gcd.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "clk-cv18xx-ip.h"
> > +
> > +/* GATE */
> > +const struct clk_ops cv1800_clk_gate_ops = {
> > +       .disable = NULL,
> > +       .enable = NULL,
> > +       .is_enabled = NULL,
> > +
> > +       .recalc_rate = NULL,
> > +       .round_rate = NULL,
> > +       .set_rate = NULL,
> > +};
> 
> Everything is NULL. What are you trying to do? Point out what will come
> later? Please squash patches.
> 
> > +
> > +/* DIV */
> > +const struct clk_ops cv1800_clk_div_ops = {
> > +       .disable = NULL,
> > +       .enable = NULL,
> > +       .is_enabled = NULL,
> > +
> > +       .determine_rate = NULL,
> > +       .recalc_rate    = NULL,
> > +       .set_rate = NULL,
> > +};
> > +
> > +const struct clk_ops cv1800_clk_bypass_div_ops = {
> > +       .disable = NULL,
> > +       .enable = NULL,
> > +       .is_enabled = NULL,
> > +
> > +       .determine_rate = NULL,

