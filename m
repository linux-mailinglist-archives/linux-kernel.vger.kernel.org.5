Return-Path: <linux-kernel+bounces-148243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D398A7FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C771C213FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B6013C673;
	Wed, 17 Apr 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PGSVMQjC"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2098.outbound.protection.outlook.com [40.92.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB413AA47;
	Wed, 17 Apr 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346465; cv=fail; b=cQrYK11jAdhkSJUpqDZF1QPNAZ0+S/onSGNxkaAFTstZgTw3dXxFvyWdqExao0frnIi2WddEqpu1I9tEnXsFBn8/Zb0qvFa1Xn9iUhk49Npc1hGnPHqpb4vo4dmPo2VwBrhAnwpFlTkPdjC/C5k+ULU9it+t1N8Sdiof4GetTGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346465; c=relaxed/simple;
	bh=vCTv35vO9FNsSBOMpBi8CfWbxApAvdmACih/exLqm10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sSm8W+uW5YS/1zxD4CmVH5CsGVW3iWvZ9EccGtxjVhr5ZD2cPZi65sRwyPLqZdphGp11LVmA7vhLyOnIeLdKhijnH0eosM7lhAFZxV4oT8CgqH75s0sa64Gh/xEVuZ8Ba6ULoalvVEvPBSc190xnHmU7ggSyNvs3u0o/Z08WP1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PGSVMQjC; arc=fail smtp.client-ip=40.92.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd4Cxzur0cuIolMX7k3wFmiaeN0SJciJ/fhgBd425o4wsjXnUYv56uKVvX8g+vHF8STSutgiy5hjTvGgLliMRpVP9K0omXdBuVtz2ui0alk3N7q1mywP9ScB4vveM3aZAHaBUrkwQWT16G8wsZfIRgdfWfq3VpaQ7Z+rDfH2vBz7jRl8/kuOFsn4G6E0nZJws4TQY2i4xIk1n/CL6nqZVcbzAfn9FDxYtWmPwur8O1hvj1UXvAEDJ7e3id3HP0Rtblq2MEI2vC3kufuuZ7zb+RCIitHccxpTl65dfv6nK3+N2lk0Skb9cSpUMDeAc15CQUNj4ltMyDbH5cdKL6Pt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fXYwaEsCQ3msAnuaLOE1TJLfSaRpWnHwm5saxVDOeg=;
 b=Sj+T8H1M2oBgks1RiSv7FaoaTNp7xeGPTVsa1golbiIDGbG3GNNiL58ieMjDE6fSLOilXBtBemdJQ3+4l9jreiH+rPuVz3ZElO8GNUZpfP7gMWB0OiqkGU3GL+saQmofvDBUJCwu3ppeiXuiBdvB5n8ceGMeCN1MxzPOhluKYoQhVRjDNW0vb/hme9uFVCEBvSuJVtt+lEda0jlPiocI6EZPXInJTbVjfPYmACeUVRPbyDjMXL7OQgftwDFsJaRJhkXH/C1GfduMyq5swe2zyg0DWJ8DndYfNGa33nN9duGcqRUyXbYIvisoyP3I30qJDWSFQ4WK50hU9ScBBczxSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fXYwaEsCQ3msAnuaLOE1TJLfSaRpWnHwm5saxVDOeg=;
 b=PGSVMQjCteYokFZbnBHyfj3gDtZCVsszL49KBmaEV/YMjnm+fxfVh0DzBXX2euYKqgt142ez28fDgu/Gwf5+44/O15Wv1iLN7Q2eREHdFgyg/IcUiEOqvXoizX2HKFWxojNBADvTDP5Y3PHFK5So0PnfdxliWiZzeY/yDl90Arjd0i9BKEuaeAMPDzHc+RXCtE5KGJueFRGy7RE/Zbeq9BD4yTQ1kmbgv/75gjwKN1nFmZyZHWcr/kI1qRdJIIxc+PZnyI3qlQUx0ZEunJvM/iRFIsPdrUNqiQ4NmYQO9MZrHhnDKJ3Tp5OaZWs6DSKrAKpLteYir6aqMh4kk4vWBQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7291.namprd20.prod.outlook.com (2603:10b6:408:232::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 17 Apr
 2024 09:34:21 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 09:34:21 +0000
Date: Wed, 17 Apr 2024 17:34:44 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: michael.opdenacker@bootlin.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] riscv: dts: sophgo: add initial Milk-V Duo S
 board support
Message-ID:
 <IA1PR20MB49539A380E44459ACE19DEB6BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240417065311.3881023-1-michael.opdenacker@bootlin.com>
 <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417065311.3881023-3-michael.opdenacker@bootlin.com>
X-TMN: [/wgaOumHrX6KZ+/QFrHj7ayN1sHa/AsQn52ebuz3cEU=]
X-ClientProxiedBy: SL2P216CA0101.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <5otq7fngmhrhdoniz2clckwarpb7z5itilqt3tsq2pxeqd6emk@trsmhl6srxp6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2929bd-97f1-4f3a-87e8-08dc5ec18fc2
X-MS-Exchange-SLBlob-MailProps:
	O8uo9vZ0QHVDqkOSoPIz5M4S+SNCRCoczudaXIXvZARoSselLtDteamBMRpJpUrcWwOznszVsQ8PXKplet5AmHrTWR4PoIJ6pzUQfd9ZrSjiHcU+cibdITSP/YzmEzqBftJ8wtlAy4JpJpxNluj1r0L0pS2UiBrL3e7aa3kKNOgqYlEFzn0IzXdzqNTqIDB5AFNL3JxgK/IYi8S9YVzWKrY5LkC8jy1FHoXKJ87WQQqS92JIgjSgp6Da0JfWxoBvV6QbwV/+v3O//cza8X/O3h8aN1W6BF4HZUuNsBqeSih62AE8orw9bEgwmEhmJwHOMASlIELXurDiGZgYP+5NtpLXIG5AoYqDpMOGWHUoMRVGTMBPE9SD7s6u0WjPb2d9CFf2xffpeO9KBpcE63AVRQBA4kgzfLRPsvMYDgiuKU2f8cKl7U4tlHMOGRN5klH6vZAzeivdhefFtCcmkJ/mXb3UKOvZDewcI9kgglHpeljMUUW+hlkUmAp/PT1wMPtd9KBnvmvJEMOh4DTfkPeYHAtJ2+AuLjqBfdeK5Ck/HXWZTmswOPVTHC7O8mtMXbSgMevdOTfMZDLjEkWiFtz/zc4qq0bsdC/PLq+7OflF6NaeiX1K/GpO/kqjRLTqpLLqp4hP1qQS+Pe3BidL28XWbIBnwZZjSbgkAirnzojx04MdMKn4xlKzRboN/bMk7wFcAUSQHmixnAGM3SSmmOzmwhxEuK74kMJeD1dTs5QVURk4tS7TLEy/SWAW9MLn2+2jEUBjkJU8IiftTphpmZwZ2u9UG9zEAqhaWhV/fpd/tc9Opro6GdxvkiboHr/i/GQdcIP3ahnCqe8oEYqZ/qURlKP/1/NKl7jb3JnQ718CTGDa75sUUipe1XOEqUaBOMGJTj3Ebve5L2F4kkSuz+HDpQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kX+ubGFjd7lMpWr4AlAfq98nNpKi7WBj7Gu3pvVR9CvUbl8wHIEu5DGs7utLwyzeUq2kIOMl2GkCuvmbyBixj2fMdLsFpk6YZr516c0KYojv2uWqO88N0FbA7xZbhpMQfYcVMZsTeoP117QufnE76e3SYD1MO7qz7AhTavpbsa/WU0XCH/PuzsCwKJLwnY6XfNJDG6hMSOWhG5XHpkjB5l3Y5w5hhC8vzkiIcvgyZlyTwhr6oj8ltqwdDYSG1CCV8hwgZ4Lap+FjvYrNgFJjiTw0UECH64PdeeKGGX9HdahM3ZnoYQS3Ho6NvHlERvJlrr2KjMSujiSNRd0Kt9WcLd/2o1X7l5sDWAc8arwe10C2RTl9JAQes7Bk5ENnxO7+lV4+h9P1R8tMsnaoQOzpf+w2XfLiaLXNCXPVuG+qglsuKjYMEomx8jZCt2wCsbgMkKVPR1JH24kJrcQSbDXk5NF2w1lCTwppdag4xYrqHoPsGjPNQ2ejs+KcYnCLdhllcMAh4h8QfH2aqwUMDMe21oE3iQHCUKiQcoHpdW22JaqhiQcZ1e2dxdqzffeyYstMZEEG3LHrZsYHuEm7pPRHc6yzx3Yt9c7wHT/nsxPgiWYmGFGkXNXqmuymrYhsIyALlr7FZ3W+ftf/Fg9+rKtD2MqYPEtHFNqZA/HSzlHw+64kult+kaPUqatuu4bIClo8TVXlDQoR9XTyX/5ytWSnvg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kc1jkS5I1YXgIWQPTuAfjNn/9xCh5y2ZjrwBrxCO7kDy5rZRCCFmhoxhgJiF?=
 =?us-ascii?Q?5nME4tUKURCZHSacfyk9h5i5Nq4qUDZOaXxU+koCvN8tWDSzAZFtW09qzY83?=
 =?us-ascii?Q?0QkpX7DuqvkEZocXI7KGtCkloVteEpMbzL5EjqkckxLc0k8tns8NmcQInGFE?=
 =?us-ascii?Q?7QGUoIM77cOshUYXhuw31NyXHVqu7Xkk4jP68tnsUiuwwrmJDgJqakkP5FEU?=
 =?us-ascii?Q?rfuFw7VCZ5OWOZBdSkzVJlKjohY9iuDcjmZ3E3jZmnVqvsHLgXRAr/cJcL/L?=
 =?us-ascii?Q?rJk2p+s4JdiG+5N1lmuVgD3d5+Kjakqqj0Z0KODJCc7s8KKj9p9JjuuR671+?=
 =?us-ascii?Q?19Ds6XF3ZiCFU4i4FMC88njfOpZRAapj6VTghlZZz5DXxmsj2sLdUpMmLagp?=
 =?us-ascii?Q?u19+VlJWref8gE6B/D2zED7Sj2xwxxFZmPxL0n8nbCZH6pnxKC6/hSq5hHdL?=
 =?us-ascii?Q?7IKbKlWTObvNls3mtvOXVtAJaU/UofSrpMrOgY6l9WIUrhXZr0QWeboktFxJ?=
 =?us-ascii?Q?5ObQMBTO7PUaADBUhJF7Rl+QJUrlXYl4iNba5RWxgvDJjsKR6aGfLZYafdd3?=
 =?us-ascii?Q?q0CZ0vhC4Nt0ZN+vBXaSFSZcre5GOrHnCYH4nM5pbP2wxgfo+HjrVvOVwmu4?=
 =?us-ascii?Q?/xeuTStLYu8MY5mfo8zF/zvXRRuYzLfdNj6XxiG/H5ijKAYzGl2wohV6lAtS?=
 =?us-ascii?Q?gJrLc9qPyLgA1eeZBXi2hF3Qn+hHU9X7OsGOHXxiCvK8jClInfKEThhT5kYp?=
 =?us-ascii?Q?8ea1gB/lM7mVvdQiAlwjAA6sPQlFJxYbO7/G0zdgCAGH+QUCTM+Qr5wdKsNX?=
 =?us-ascii?Q?69eRUzmA36mvCaZNOfPY8Id6L5n+vyvCJojvSgP2DjGFDJgfFcCMAFECIy1e?=
 =?us-ascii?Q?SXrAayuEru1873vFy5JiLcpYzeOS9nKUY36jnDl8lYD4S/n6MNfwi8qpvmro?=
 =?us-ascii?Q?C4Pu5oESva/le+4wokdk218Y5OF4ptIBg1IXyyZMlI1Lra00Jzb+nIVY8HbF?=
 =?us-ascii?Q?19A5nhR75GLA6w8zGyOwNdtwnR0QOLQCpOiG5SF3JW2iMx5g9eTbftxuLiUZ?=
 =?us-ascii?Q?UYhzhvQI3SWbcl80l8ZbCHCjk0JDyWQ0kQs5Coojc1mEdSsXxbb3On2yhRzU?=
 =?us-ascii?Q?DIGxnjkeGgt3kcYlexZeB6FY/6W5XarYRhIQksOelipthxmaFrm9BqNnmDkk?=
 =?us-ascii?Q?AhshGVzmrzh3UadL8CAnt7RAy8mzMS3r2xtLTpze8Q5Lj0U0LswPixeFsDau?=
 =?us-ascii?Q?HNpPtQhRcHPTSeScOEfG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2929bd-97f1-4f3a-87e8-08dc5ec18fc2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 09:34:21.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7291

On Wed, Apr 17, 2024 at 08:53:11AM GMT, michael.opdenacker@bootlin.com wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> This adds initial support for the Milk-V Duo S board
> (https://milkv.io/duo-s), enabling the serial port,
> making it possible to boot Linux to the command line.
> 
> Link: https://lore.kernel.org/linux-riscv/171266958507.1032617.9460749136730849811.robh@kernel.org/T/#t
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  arch/riscv/boot/dts/sophgo/Makefile           |  1 +
>  .../boot/dts/sophgo/sg2000-milkv-duos.dts     | 34 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> 
> diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
> index 57ad82a61ea6..e008acb5240f 100644
> --- a/arch/riscv/boot/dts/sophgo/Makefile
> +++ b/arch/riscv/boot/dts/sophgo/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SOPHGO) += cv1800b-milkv-duo.dtb
>  dtb-$(CONFIG_ARCH_SOPHGO) += cv1812h-huashan-pi.dtb
> +dtb-$(CONFIG_ARCH_SOPHGO) += sg2000-milkv-duos.dtb
>  dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
> diff --git a/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> new file mode 100644
> index 000000000000..c1ecf97d5e93
> --- /dev/null
> +++ b/arch/riscv/boot/dts/sophgo/sg2000-milkv-duos.dts
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2024 Michael Opdenacker <michael.opdenacker@bootlin.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "cv1812h.dtsi"
> +
> +/ {
> +	model = "Milk-V Duo S";
> +	compatible = "milkv,duos", "sophgo,cv1812h";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>;
> +	};

Add a cpu specific file, and move this to it.

> +};
> +
> +&osc {
> +	clock-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> -- 
> 2.34.1
> 

Add necessary DT node in the cpu specific file. (clint, 
plic and clk). You also need to rebase your patch based
on sophgo/for-next.


