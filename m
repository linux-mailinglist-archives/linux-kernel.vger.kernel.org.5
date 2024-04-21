Return-Path: <linux-kernel+bounces-152451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7000E8ABEAC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB19281144
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 06:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA16D50F;
	Sun, 21 Apr 2024 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Bhl5yF5h"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2069.outbound.protection.outlook.com [40.92.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A338C;
	Sun, 21 Apr 2024 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713680990; cv=fail; b=tfBZHNdU5dvoSPEE/ykWigeOsWZOggFwWajoxs6BU0kWgDvvCZZW5e/dtZpMunuBFTJGBaKcivB9xvSeyZYc3oFCMSSFqT/iUXfJqxWuYUKWd9J6ahCm3iBZr3FFKisMkPsZMXeG3KPcvm2MStEU76/S+e3pZKD8ozHlMmxlBS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713680990; c=relaxed/simple;
	bh=vefphyoA5Ara20dmutCjf/gJ3hOk7abEpiyesjfZ5AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aBVujQLc2NcrHUvHwn3fW0jKczK4lFjmAQEESZr0X0oxfil9L4v4vBNQWdo7slSGbbaFE51k0Axp5qbPWiJKbdVa6FEAu9j6oUqPJt2E5Ju0ma6subv+XKV0c/Vfw/seIywba3yRmZYMrQn8eUFuRdaz4fiIXds5K49LjHYgDiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Bhl5yF5h; arc=fail smtp.client-ip=40.92.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOSNxzg4Ls22MlVqk/2J8A9ibQJ+WnwxfgQDKYH/2DlI9OeLXHovnD/2VDIhEynDhem1KnT1U6T3Q8eiBW3uNztP3srRMaxAwHAt5KCBALrGWSvFaGhRkCqwTGDy3EH+KeTiXWpnJLVxGZBqIIH1DtH4KA9t6aqjSdE+0gbo/A8tV1rsOYT1nn4H5nLizZD5wU4xTlInWit9QGxGmQuO7Z/Uv0n+Xsae5s+HvmXk9TGJVnWlcxrM98Gbqx5Npo+bt7cpC/JgLicPsArMn/jssPzp5UMH9ANaa1VKdZ5MkAg68Oh8c4Y93w6fo1rLcAPViQpswi8dUqt1sattOmYkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTsp9yVABJi8u2IeuhcXFC/VY1/0mjkWaZthdbeA6bk=;
 b=hLFwnqziFASzcjBfaOFzPoGbAMPHaEd3l5qHR/65MMpDl6o2dwS41/YBSBGKBel9t/pXaUDb9YtLycB4srkgoUvW4kyDz43eOWWI7UM5UdHcSCdsIiSTSIETK7DuITsZEg3lp/AoO5fiFpxr+e6L1LDYe0aE0uhzENPxJf+DXPHkJLgYy+TzMDldwV2IHsRg9WKYJO1y+jdBNR36xYWuURHZy90Z4a2hKO7KJQ3Qv1Ova1FU1nDkZnCARqjgwMvJxYgOdzjj+cX700lT0Cc2vQeuWXxmTY7DyZxhQyIUxJHWcCmoGZuCEOOGHzgK9QAY1XMjJWVy2F0kM+nzW65UmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTsp9yVABJi8u2IeuhcXFC/VY1/0mjkWaZthdbeA6bk=;
 b=Bhl5yF5hQa3EUS+El8dlO27DESv+VpxqjvQEky959aWuHecX47nHH8JHTQ4KnPjhzy3Ew5G13++k5Fa3+I0GQCIOl0wojf2Cwb1bGwKceg4ZuJqh3QvzlfXAHG9zuIrK9bfF2nicQnlAirJDkVyrr6v9IN2u/tJZnNGKqtJ4KsammfmX0sZnTsKT7BJGK91C1FKRftjR5YfKowd/mmP3jZcVXgKo+1j0nJm81HifgXfkUXXverHF5sgSOn2i3qTMUliBPmwjBxToCYjUjF3hkIrhfwIlU5f1+PG2/LgTEDIZi6SL7Zt//JXuOM5HkikeFajVfgzMBl8hTFmGKVl6/Q==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7017.namprd20.prod.outlook.com (2603:10b6:610:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sun, 21 Apr
 2024 06:29:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7472.044; Sun, 21 Apr 2024
 06:29:46 +0000
Date: Sun, 21 Apr 2024 14:30:11 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S
 board support
Message-ID:
 <IA1PR20MB4953D0D45EB0EDB6E8046664BB132@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
 <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <e457d5f6-3289-4049-b663-2ebcfe78dce4@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e457d5f6-3289-4049-b663-2ebcfe78dce4@bootlin.com>
X-TMN: [bC0ZNwAtbOlPxMg08qFnB9wGEQZ2lA/t+lz2RrBkWe8=]
X-ClientProxiedBy: TYAPR01CA0021.jpnprd01.prod.outlook.com (2603:1096:404::33)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <y3bhkwdmgbge6g6wj4rrhti74cj4gl4h55i7ubq3q3x2pfr73q@hhhpwf272h4y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 206c43e8-f94b-496d-c500-08dc61cc6fda
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sas/4tM9BqQckrg0Ear2DCyQlcH5VL+zKm+WT2WuRKk4TuSvV7FeHjgyPtiNPNa4XQUaQGo8osbIecUaTuaLDp3IDqPhAScEYkuKtKBNR9uL9J7+eI0Qk1rPw9DnpHh9h38tcjcBzm5LIVv9K/xks7Y/+8tJWzerwMM96VzdZNmibbwEVTc5UeJ9jDfHi67BZ1C9UASd/0lkpag67fSq/tv9KKLoi0V6rXZ9Z371oglBQBGhk/XMM1dBC1oKL4u6vWHtcNaKREnTKR66TK5ACMCQu6GjBSjG3se/JxqMjPsjk8SwsdLkSdLnLptouUYAJdVEJ10Na86LRsz4cwKM62FD0K2K+YyxntwFHc6iVCqOeYyqWgbasoSJMCW4qTOY2wBRvOsuWDUtFAauNt4lIJSB9I4O3IUbyLA2eWD3wErT2MCFjBZ5aieVYRnwpY6oVYMWRcZxnl6CeavPrS2XrJvGj0m/LZBGRMB/bc3cUtOtyFqxrdXwgyWTF1I+2RCyoAW5+BGXG12pn+u7n/FoI8A9vp/vIjHdGLNhByTFa5Fi8MqjwEMHYwbOU5Cd+77tSGhTvoyZQ8j3cbjMakoFfo7kjSO1yMg2NrZYkRu2LxKN9JtImbx+Swmcg5F7HcSovIPavrhcyqxYEPkSqEqM7AddD3f9boFkc/HuuKNzK79v5bimZy1ngb5+szrHg6H+EVV/2UV5RpPHtUuG8uqYDg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ulByggYW9fk+KU8adarpk/Pne53mlFrcTb1qMCSROaB2cwPmdf+rko0iuSYj?=
 =?us-ascii?Q?iGpdH/A5o3/k2sjGBflO6s8tkICF7qysPXKMV3tUM7T2orZlbIW7ZXIisGEU?=
 =?us-ascii?Q?7qG/MHw1LqMGNQ7CXU96ExHngE1HfKBCYFtfpotSIbMXYetG4hro+8KPl6d+?=
 =?us-ascii?Q?AW5Uo96F9yT7X/GUzBwDDwAU3rYe4EjINvepXhmh1yWHMuU6IwufeyupkjTk?=
 =?us-ascii?Q?PqLM+0j/FFXfy/59vxmehvmhRz/pwjg23DpMwNG6GqJuU3OZiNqagTFrw3RG?=
 =?us-ascii?Q?pThcptBhzQToSPmfKnY2JymTjjmgiPts7D50fyGJ3C5gEFZV7ZP5dJITDyLK?=
 =?us-ascii?Q?yDsjGBBxfxyLJPwrFf+J6N1cBK8oirIwAPeM3RRCJPxrNdsQyC6qhBSa3GpN?=
 =?us-ascii?Q?3dU9WEggFm5ZJecx/ARxNEHO7wUazO5B88XzUPgNTGA0IzCXJ9KTMOQS+Xaf?=
 =?us-ascii?Q?GBaFOl8t5FYaqrJ0Xr20i2RtSgRB8X15qYZMWyeivSJtHxtlzId5WsawLKsY?=
 =?us-ascii?Q?FRXzneRnCzO08Fpj+jVHJkJRMM1KdbMG0V0bAB5SrsQJA9iZ+J+zWOa8o8pZ?=
 =?us-ascii?Q?h07inlV9KZj1RUDwBXZVXAgpIY7zwq/KFxGgfg9TlGmOc2zwLpLIOkHSbayq?=
 =?us-ascii?Q?QSqtWb6fVYqhXAY/IZFMYOZXlELLgF4ILB3Bh9xnpUq+qdiIeCDP2+jc/EwS?=
 =?us-ascii?Q?vsdvAFmAf1+IJCwylC7M9JDKUkqZmWn9zETE4sMfvf7tCpM1YsyFNz75K9QL?=
 =?us-ascii?Q?jHAzXjGNNrW5OhBhZnNAA94sXurOquuRfbeBsaS479a+ANL4UsPs/cruUAZp?=
 =?us-ascii?Q?K690qjS653FzuR/LuMwxntDtnW0mbBdNzQTGlWRfgdDEcCWCxsgQT7KGKkLD?=
 =?us-ascii?Q?bnSMh7Q8lKlzThZVamxxUQ0bLOQGjqSH6CvDlmEwMM3Q0ONs3x63fkmdy1LV?=
 =?us-ascii?Q?nqhRkk9/p8WjvSEq1gSEEmFDQuDaBedyjCpdh94cwFNB+4nuXRs6vcEOlPQF?=
 =?us-ascii?Q?aQyRLCIWxnPf2+jTgO69QlKq678e5lqUiyO33fhstnpNI/07JOb4j9MQ2ptP?=
 =?us-ascii?Q?ewwagPNFbTQOeyBiEkz1jydNMLPEATEjLY06zexY21FqqLZVg5YOoU4l6WQG?=
 =?us-ascii?Q?WufIH01SKQbnpfkaEtr+bwTGg6VjEdECjaE35Xof4X0fzuSrQxKwPe1r87mp?=
 =?us-ascii?Q?k+Vp2Dlwg8TqHjHipnXZvuLIi5O0IHokiYBbcD43+roXuxvXenNuAXGkntqL?=
 =?us-ascii?Q?3NR3QkGBffvHSWnGobhw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206c43e8-f94b-496d-c500-08dc61cc6fda
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2024 06:29:46.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7017

On Sun, Apr 21, 2024 at 07:57:01AM GMT, Michael Opdenacker wrote:
> Hi Inochi
> 
> Thanks for your advice!
> 
> On 4/17/24 at 11:34, Inochi Amaoto wrote:
> > On Wed, Apr 17, 2024 at 08:53:11AM GMT, michael.opdenacker@bootlin.com wrote:
> > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > 
> > > This adds initial support for the Milk-V Duo S board
> > > (https://milkv.io/duo-s), enabling the serial port,
> > > making it possible to boot Linux to the command line.
> > > 
> > > Link: https://lore.kernel.org/linux-riscv/171266958507.1032617.9460749136730849811.robh@kernel.org/T/#t
> > > 
> > > Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > ---
> > >   arch/riscv/boot/dts/sophgo/Makefile           |  1 +
> > >   .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 34 +++++++++++++++++++
> > >   2 files changed, 35 insertions(+)
> > >   create mode 100644 arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > > 
> > > diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> > > index 57ad82a61ea6..e008acb5240f 100644
> > > --- a/arch/riscv/boot/dts/sophgo/Makefile
> > > +++ b/arch/riscv/boot/dts/sophgo/Makefile
> > > @@ -1,4 +1,5 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
> > >   dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
> > > +dtb-$(CONFIG_ARCH_SOPHGO) += sg2000-milkv-duos.dtb
> > >   dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> > > diff --git a/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > > new file mode 100644
> > > index 000000000000..c1ecf97d5e93
> > > --- /dev/null
> > > +++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> > > @@ -0,0 +1,34 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > > +/*
> > > + * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > + */
> > > +
> > > +/dts-v1/;
> > > +
> > > +#include "cv1812h.dtsi"
> > > +
> > > +/ {
> > > +	model = "Milk-V Duo S";
> > > +	compatible = "milkv,duos", "sophgo,cv1812h";
> > > +
> > > +	aliases {
> > > +		serial0 = &uart0;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path = "serial0:115200n8";
> > > +	};
> > > +
> > > +	memory@80000000 {
> > > +		device_type = "memory";
> > > +		reg = <0x80000000 0x20000000>;
> > > +	};
> > Add a cpu specific file, and move this to it.
> 
> Now that I'm including "cv1812h.dtsi", which has the same structure, all I
> need is to change the reg setting to have 512 MB of RAM instead of 256MB,
> right? See the V6 I'm sending soon.
> 

No, Duo S does not use cv1812h, in any means. I just told you to use
cv1812h for local test. If you want to upstream Duo S, you must add 
the right cpu compatibles and necessary nodes. These two are different
things.

> > 
> > > +};
> > > +
> > > +&osc {
> > > +	clock-frequency = <25000000>;
> > > +};
> > > +
> > > +&uart0 {
> > > +	status = "okay";
> > > +};
> > > -- 
> > > 2.34.1
> > > 
> > Add necessary DT node in the cpu specific file. (clint,
> > plic and clk). You also need to rebase your patch based
> > on sophgo/for-next.
> 
> Same here, cv1812h.dtsi already configures &clint, &plic and &clk, so it
> seems to me I don't need to make changes again here. At least the board
> boots fine for me as it is.
> Cheers
> Michael.
> 
> 
> -- 
> 
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

