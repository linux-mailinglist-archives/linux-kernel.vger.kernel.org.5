Return-Path: <linux-kernel+bounces-125086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCB3891FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD891F30253
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B88F13AD00;
	Fri, 29 Mar 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q2I1hKoZ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2099.outbound.protection.outlook.com [40.107.241.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13D13A258;
	Fri, 29 Mar 2024 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722556; cv=fail; b=EYGONKZ5AI+ZtETILKxeCTt/yQ0EHbZ+L3bQsXTYpzXU93jYik60oA0WuWDf85M82CmEmREBl0QEqWtdCe+S1xsq819LSH4diz69HYoWc3vaNOwCVXNBhzBi9FPuwUxBFKsMh7Ul95UCGK8fsezCLIFgIq4mj06hU2olbu0eRkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722556; c=relaxed/simple;
	bh=8s2sF+q5jnqfQPSRKFncZIZ/4rvbVSvkb5ebJ9HoBWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OOenu6BXhTuGXp0CEvABm1b3FsqOCF/DQGH1f8mfIeLmUnVXAVbCKQibZIBgkmQ0IZ2qswpRWruNRfEqyOLaXCU65Odl21J2rcaGTCITBgIbuEIK6fvbsVH/sPea/Er7qLSObS1hKvP/ItYR/acqqj15jf2E3bxyU0ljfsebo7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q2I1hKoZ; arc=fail smtp.client-ip=40.107.241.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZHDkO9CZffuXrm8BeyZUzoPYa4iXN/N9ugVGiHHrh3yOswyQ1c0C2EYY55wmN2fWUjXXruNX/9ZBem+9MEQto7/hzZZNdOqVtonBxP664QeALe9PjbU0nwJ4WnogK1USrmhB7duswg2czclBj7YJn8qpUupgrqC65r1XEdniDKbCYUh3V6A2NvKNvS3CjSMSuO1CR376j3N3UHcfH/uVNvdLM/pEpXUOjg+TT134bqHg4wW8ChCkvIItT69FIq/6jtcTHNs3pwbaAOWPvCsVaC1IrafbvEI4fQOvDjfPXsdHOIAnWyWsLhWymLFpEF+OqBNVpb8ae9Vs0oQ+cddHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJJIFUwxJVoNtNR3FQr9qdNalJYuf0FlzAEvPcs+F+E=;
 b=dBOKn+vLwc7riYcQ4xiLaLW1rBksOhce7Lv89ilKXb8BcIu2KTvv2e2J3LWyPBAkxqFp+dHYiIAmQwHI0x0YZV/tRDeLtvk8AB4EyYZn8Z1woPWtzKEtCsYaUuN2Vr5lkqekKRB07wxvsBmRoZW311RluCJK9SDbLkwKvPk0QZNiqdj2bfnE2o2pwQeWhbVDvBoP6QEiKxUWGC8I7jTOmRclLu7VIzldtiz1niOB0pR/oS2egIYUNM2krZE/tNI5tSJ18TG7KoHI86c4UjAKhQ25l6E40U2rf4c0tBizOUHQNyOlTK63iedLveEgCwXG/CIhciAY8wwhAR2Em+oeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJJIFUwxJVoNtNR3FQr9qdNalJYuf0FlzAEvPcs+F+E=;
 b=q2I1hKoZ15FFGmAQ3lV4x62+grxBpV9E+kMNVRUlLxbVsutI1GN4WYAETlazU6rV4G6VNQk9jRaq/O1k1y0Fs/YAJSVFEKUy60tc0EJSaYKejgBJ/CKQ8WvQ5SxlphgCX1zgPRRQnsZfvtCB74pDr/9803x+pxtVnfx1BJAN8uQ=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 14:29:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 14:29:08 +0000
Date: Fri, 29 Mar 2024 10:29:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v1 3/3] phy: freescale: imx8q-hsio: Add i.MX8Q HSIO PHY
 driver support
Message-ID: <ZgbQLIo0xi68Xfui@lizhi-Precision-Tower-5810>
References: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
 <1711699790-16494-4-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711699790-16494-4-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8371:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KetegMJBlzuAJx2aX9647AHiojPO5e8Jswp6FMblmTFd3OXP2mRubVaaFuNC32Nl6FTnXz4UxI+TJ4d1c3Oe3vvk2UZMedhNt+/0Ae7ZqwvfdFJZKD9ItQKSYlEqatEcHook7Y3Mlh3pm86DdLBRSx+Xh7B1Rw2FXl18ogRxFB4eEjPTpspvrN+FJinSF8BYmcsZ7zsuLgQxHL7Kstw6C04Lk+zVEjLHHd6IcWBYeaPdyZU02PS/WdSEjwa8MS/+nIPk6R4/pn4hwQZtDt9TSdbXvr/5LGdAiTljrXnU5s5X8U0StrkPhqBomyv3roB2NEYG3ZE7zXrnBy4Ho7NI3KLABzuvS9DIzRXDwEX3eoa46/InZVeCH1KlR8z/9A572WPk12s/1dGobZc8jAK/6xL8UFEHmEExdvlVB8mdt5Xo92SmLOX20IeRSLx/InzOs6FgaTIX69ZslhEV0CR/Cav23bhlPgG5Xaf1/uNiwOZc8ZFwIBc+9DpRB+xpu3yBUXcl+uY/VPZQOEb5zbrG2Rml4suw1z2pgCLEizirz+waOTkU8u09cOnqLdOrm4+KgfhJ9GqJU5ToHOD3LbT2IJG221HudoyKXHg3oRhebXhnaR3GLC+ZWNsxZnJvvVB1nRjaJOmfB6BF6kRa8fNztFdV6R9eD8f/a+AWggmUE8elHPOZJHylIlPFRFBgxP4/dlMJVHusTKZzzo5nY78nFaiGBtMif1cTwjL6w67iQLw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(366007)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4L1/fOD+tEAY89VUdTFIRz3IZHx+wIc8vFobMHiLbp87VY8a9A8OWnfEnj0?=
 =?us-ascii?Q?0NUjTENivv/URo/vzzx6lvMlNfN7k7z9F5/BIWAs3AztxOaIOnAnFHACnX+Z?=
 =?us-ascii?Q?RorBClvRaQIM+Mia2gLP2OtSU1w6edKz+pgdeFp7DHba2YjRFJMCxhEXFdHN?=
 =?us-ascii?Q?C1GEzD0ge9hULrJZCd8EVUdT6w10Hib0rxWfzQJDbBZ0Ci+Qy0mwxc89XGH/?=
 =?us-ascii?Q?gTdjxL7Rh88wdIC2GJlnWB3aF+1hJbqA4z1ZN4rFmGsZ7Cs0FNjjKzm6stUf?=
 =?us-ascii?Q?K+2IBynfb90Tq/TQIquWKJaOetyY7AVKw+YNLuDBMnYD2t+5AgOiseuf3w2c?=
 =?us-ascii?Q?yI7EeI+oSkBtY/pi6Hk8omR+YfZINkw1LNZxxpIamf+kkZD4HRgQ51nF8rqB?=
 =?us-ascii?Q?VzV0IjgLHyWh/m1S4TGFxBy9GTK8k9x56++zVdKJF8zJt8Ni1TpM0WgKGoZU?=
 =?us-ascii?Q?yZfYZZdfDDRWm3d1m4j/6fYNbD4ugGahsfMfQoMCTzeEqpg2rHA4OVUa9PXd?=
 =?us-ascii?Q?FCIihEF7hXDU4P+8V6cFNZQNvpfTtePd6xzoBV269VkVxzwFMVsd59xvbctN?=
 =?us-ascii?Q?OlrzhBRX5YUIsjF6lN3Pmuoy9m85epSsWZEuOgFyBE+7KbCNBcAzJpuk5C9X?=
 =?us-ascii?Q?agQvzRqYzKUGtxkZxv44JYJRB9q1bpsfgNSBJXGRAMzvYemjPUs1ZO+2KsXx?=
 =?us-ascii?Q?dzF5pYk/zbDTyfjd7oOJVSqBsLXbVgQPvXIwlCUgcTucF6RpES7Ao24M0xSh?=
 =?us-ascii?Q?RFYY2aPMcJzvWMhS9KyznCpuc1eABqnlgbc+FJbQIkDHfka2e9tA+8d1746V?=
 =?us-ascii?Q?zt2UYvgksppRIUdmvXwRQ6LjKPUi8lJBGolypSsZQrogi3T6PRCswMa+w5gg?=
 =?us-ascii?Q?g5iwrb8zl5UgGjQ8MUx++jjeT6/OZNToLUYdOpwL00RkEfAOfx6GEqc6LJSf?=
 =?us-ascii?Q?dEQlBOVjU6l2uk7HOzC9tAk413qWcnEOCFMIlYIaVpWps10ZaLdoMkdVSg3T?=
 =?us-ascii?Q?/mq+KjrXw4Yy4T1rgyl7Tm58xoy5E/UKqb0w6SluhyWh/5yCi1mCbVOjS9vb?=
 =?us-ascii?Q?hOXBolt4cio9lrHYc7cyxuPaXH1thig5NMMlVp3VlWz/F9OzXIkNf8m2SIf8?=
 =?us-ascii?Q?c/8IPRJw+8ECsYY9f+CS2Few5rq27RhD98L68FK2YlOb5+mfFPE5sgD+tJ3z?=
 =?us-ascii?Q?zZJGIFkUvn+ONhKGCXxK1qyZO2NtW5Gs4JBK8PKkZw4LlBb4CxZoO/G/MgPY?=
 =?us-ascii?Q?P1bKF67UxrUqV3KyacV2aYgja9mtZ68FDHa+RhVHM8N2PV/0Kx4eBPpDmPlV?=
 =?us-ascii?Q?bzaAZD+6pfQSB+AUxrKJ33+iq60QtmjnbWZnALIguGBCRoWhQl8ADF1ntsit?=
 =?us-ascii?Q?LXALNoMGBb8SkxN9VYY1Zer4vbOcqfHLGOSixAVkxfdtsf4CT81UG7jwqbOO?=
 =?us-ascii?Q?HXmFh6Erf4EbuT3Sx682tIj2l6RjtZCsxyJ41Yv3j4Drfm1YGW0saHjFbXrj?=
 =?us-ascii?Q?O/RmWZWo0ud2eh0O4e5vLvS3hBpR5sx6MUbKuilgcHdQXZi4fryhe5POet3L?=
 =?us-ascii?Q?OY7nuEFi8zTj+VlREHqTTspX4EQCqpANilGtCTBN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de75311f-11d0-4204-cdf0-08dc4ffc97ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 14:29:08.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHRz+iwjUByVNW/C8OS+be5P7DlGiwvAXF9OaWcmmnUPkseEZflTQWs3si9UqT2J1mS943oo15fqT6piQBzYCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

On Fri, Mar 29, 2024 at 04:09:50PM +0800, Richard Zhu wrote:
> Add i.MX8Q HSIO PHY driver support.
> - Add one HSIO configuration property, that used to select the
> "PCIE_AB_SELECT" and "PHY_X1_EPCS_SEL" during the initialization.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/phy/freescale/Kconfig              |   8 +
>  drivers/phy/freescale/Makefile             |   1 +
>  drivers/phy/freescale/phy-fsl-imx8q-hsio.c | 518 +++++++++++++++++++++
>  3 files changed, 527 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8q-hsio.c
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index 853958fb2c06..bcddddef1cbb 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -35,6 +35,14 @@ config PHY_FSL_IMX8M_PCIE
>  	  Enable this to add support for the PCIE PHY as found on
>  	  i.MX8M family of SOCs.
>  
> +config PHY_FSL_IMX8Q_HSIO
> +	tristate "Freescale i.MX8Q HSIO PHY"
> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to add support for the HSIO PHY as found on
> +	  i.MX8Q family of SOCs.
> +
>  endif
>  
>  config PHY_FSL_LYNX_28G
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
> index cedb328bc4d2..db888c37fcf9 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
>  obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
>  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
> +obj-$(CONFIG_PHY_FSL_IMX8Q_HSIO)	+= phy-fsl-imx8q-hsio.o
>  obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8q-hsio.c b/drivers/phy/freescale/phy-fsl-imx8q-hsio.c
> new file mode 100644
> index 000000000000..14fc925c4f57
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8q-hsio.c
> @@ -0,0 +1,518 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +

#include <linux/bits.h> because you use BIT()

> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/pci_regs.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/pcie.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +#define MAX_NUM_LANES	3
> +#define LANE_NUM_CLKS	5
> +
> +/* Parameters for the waiting for PCIe PHY PLL to lock */
> +#define PHY_INIT_WAIT_USLEEP_MAX	10
> +#define PHY_INIT_WAIT_TIMEOUT		(1000 * PHY_INIT_WAIT_USLEEP_MAX)
> +
> +/* i.MX8Q HSIO registers */
> +#define CTRL0			0x0
> +#define APB_RSTN_0		BIT(0)
> +#define APB_RSTN_1		BIT(1)
> +#define PIPE_RSTN_0_MASK	GENMASK(25, 24)
> +#define PIPE_RSTN_1_MASK	GENMASK(27, 26)
> +#define MODE_MASK		GENMASK(20, 17)
> +#define MODE_PCIE		0x0
> +#define MODE_SATA		0x4
> +#define DEVICE_TYPE_MASK	GENMASK(27, 24)
> +#define EPCS_TXDEEMP		BIT(5)
> +#define EPCS_TXDEEMP_SEL	BIT(6)
> +#define EPCS_PHYRESET_N		BIT(7)
> +#define RESET_N			BIT(12)
> +
> +#define IOB_RXENA		BIT(0)
> +#define IOB_TXENA		BIT(1)
> +#define IOB_A_0_TXOE		BIT(2)
> +#define IOB_A_0_M1M0_2		BIT(4)
> +#define IOB_A_0_M1M0_MASK	GENMASK(4, 3)
> +#define PHYX1_EPCS_SEL		BIT(12)
> +#define PCIE_AB_SELECT		BIT(13)
> +#define CLKREQN_OUT_OVERRIDE	GENMASK(25, 24)
> +
> +#define PHY_STTS0		0x4
> +#define LANE0_TX_PLL_LOCK	BIT(4)
> +#define LANE1_TX_PLL_LOCK	BIT(12)
> +
> +#define CTRL2			0x8
> +#define LTSSM_ENABLE		BIT(4)
> +#define BUTTON_RST_N		BIT(21)
> +#define PERST_N			BIT(22)
> +#define POWER_UP_RST_N		BIT(23)
> +
> +#define PCIE_STTS0		0xc
> +#define PM_REQ_CORE_RST		BIT(19)
> +
> +#define REG48_PMA_STATUS	0x30
> +#define REG48_PMA_RDY		BIT(7)
> +
> +struct imx8q_hsio_drvdata {
> +	int num_lane;
> +};
> +
> +struct imx8q_hsio_lane {
> +	const char * const *clk_names;
> +	struct clk_bulk_data clks[LANE_NUM_CLKS];
> +	u32 clks_cnt;
> +	u32 ctrl_id;
> +	u32 ctrl_off;
> +	u32 idx;
> +	u32 phy_off;
> +	struct imx8q_hsio_priv *priv;
> +	struct phy *phy;
> +	enum phy_mode lane_mode;
> +};
> +
> +struct imx8q_hsio_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	u32 refclk_pad_mode;
> +	u32 hsio_cfg;
> +	struct regmap *phy;
> +	struct regmap *ctrl;
> +	struct regmap *misc;
> +	const struct imx8q_hsio_drvdata *drvdata;
> +	struct imx8q_hsio_lane lane[MAX_NUM_LANES];
> +};
> +
> +static const char * const imx8q_hsio_lan0_pcie_clks[] = {"apb_pclk0", "pclk0",
> +	"ctl0_crr", "phy0_crr", "misc_crr"};
> +static const char * const imx8q_hsio_lan1_pciea_clks[] = {"apb_pclk1", "pclk1",
> +	"ctl0_crr", "phy0_crr", "misc_crr"};
> +static const char * const imx8q_hsio_lan1_pcieb_clks[] = {"apb_pclk1", "pclk1",
> +	"ctl1_crr", "phy0_crr", "misc_crr"};
> +static const char * const imx8q_hsio_lan2_pcieb_clks[] = {"apb_pclk2", "pclk2",
> +	"ctl1_crr", "phy1_crr", "misc_crr"};
> +static const char * const imx8q_hsio_lane_sata_clks[] = {"pclk2", "epcs_tx",
> +	"epcs_rx", "phy1_crr", "misc_crr"};
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int imx8q_hsio_init(struct phy *phy)
> +{
> +	int ret, i;
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx8q_hsio_priv *priv = lane->priv;
> +	struct device *dev = priv->dev;
> +
> +	/* Assign clocks refer to different modes */
> +	switch (lane->ctrl_id) {
> +	case IMX8Q_HSIO_PCIEA_ID:
> +		if (lane->idx > 1) {
> +			dev_err(dev, "invalid lane ID.");
> +			return -EINVAL;
> +		}
> +
> +		lane->lane_mode = PHY_MODE_PCIE;
> +		lane->ctrl_off = 0;
> +		lane->phy_off = 0;
> +
> +		for (i = 0; i < LANE_NUM_CLKS; i++) {
> +			if (lane->idx)
> +				lane->clks[i].id = imx8q_hsio_lan1_pciea_clks[i];
> +			else
> +				lane->clks[i].id = imx8q_hsio_lan0_pcie_clks[i];
> +		}
> +		break;
> +	case IMX8Q_HSIO_PCIEB_ID:
> +		if (lane->idx > 2) {
> +			dev_err(dev, "invalid lane ID.");
> +			return -EINVAL;
> +		}
> +
> +		lane->lane_mode = PHY_MODE_PCIE;
> +		if (lane->idx == 0) {
> +			/* i.MX8QXP */
> +			lane->ctrl_off = 0;
> +			lane->phy_off = 0;
> +		} else {
> +			/*
> +			 * On i.MX8QM, only second or third lane PHY can
> +			 * be binded to PCIEB.
> +			 */
> +			lane->ctrl_off = SZ_64K;
> +			if (lane->idx == 1)
> +				lane->phy_off = 0;
> +			else /* idx == 2, the third lane is binded to PCIEB */
> +				lane->phy_off = SZ_64K;
> +		}
> +
> +		for (i = 0; i < LANE_NUM_CLKS; i++) {
> +			if (lane->idx == 1)
> +				lane->clks[i].id = imx8q_hsio_lan1_pcieb_clks[i];
> +			else if (lane->idx == 2)
> +				lane->clks[i].id = imx8q_hsio_lan2_pcieb_clks[i];
> +			else /* i.MX8QXP only has PCIEB, it's idx == 0 */
> +				lane->clks[i].id = imx8q_hsio_lan0_pcie_clks[i];
> +
> +		}
> +		break;
> +	case IMX8Q_HSIO_SATA_ID:
> +		/* On i.MX8QM, only the third lane PHY can be binded to SATA */
> +		if (lane->idx != 2) {
> +			dev_err(dev, "invalid lane ID.");
> +			return -EINVAL;
> +		}
> +		lane->ctrl_off = SZ_128K;
> +		lane->lane_mode = PHY_MODE_SATA;
> +		lane->phy_off = SZ_64K;
> +
> +		for (i = 0; i < LANE_NUM_CLKS; i++)
> +			lane->clks[i].id = imx8q_hsio_lane_sata_clks[i];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Fetch clocks */
> +	ret = devm_clk_bulk_get(dev, LANE_NUM_CLKS, lane->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_bulk_prepare_enable(LANE_NUM_CLKS, lane->clks);
> +	if (ret)
> +		return ret;
> +
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +	return 0;
> +}
> +
> +static int imx8q_hsio_exit(struct phy *phy)
> +{
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(LANE_NUM_CLKS, lane->clks);
> +
> +	return 0;
> +}
> +
> +static void imx8q_hsio_pcie_phy_resets(struct phy *phy)
> +{
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx8q_hsio_priv *priv = lane->priv;
> +
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL2, BUTTON_RST_N);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL2, PERST_N);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL2, POWER_UP_RST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL2, BUTTON_RST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL2, PERST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL2, POWER_UP_RST_N);
> +
> +	if (lane->idx == 1) {
> +		/* The second lane */
> +		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, APB_RSTN_1);
> +		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, PIPE_RSTN_1_MASK);
> +	} else {
> +		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, APB_RSTN_0);
> +		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, PIPE_RSTN_0_MASK);
> +	}
> +}
> +
> +static void imx8q_hsio_sata_phy_resets(struct phy *phy)
> +{
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx8q_hsio_priv *priv = lane->priv;
> +
> +	/* clear PHY RST, then set it */
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_PHYRESET_N);
> +
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_PHYRESET_N);
> +
> +	/* CTRL RST: SET -> delay 1 us -> CLEAR -> SET */
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, RESET_N);
> +	udelay(1);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + CTRL0, RESET_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, RESET_N);
> +}
> +
> +static void imx8q_hsio_configure_clk_pad(struct phy *phy)
> +{
> +	bool pll = false;
> +	u32 pad_mode;
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx8q_hsio_priv *priv = lane->priv;
> +
> +	pad_mode = priv->refclk_pad_mode;
> +	if (pad_mode == IMX8_PCIE_REFCLK_PAD_OUTPUT) {
> +		pll = true;
> +		regmap_update_bits(priv->misc, CTRL0,
> +				   IOB_A_0_TXOE | IOB_A_0_M1M0_MASK,
> +				   IOB_A_0_TXOE | IOB_A_0_M1M0_2);
> +	}
> +
> +	regmap_update_bits(priv->misc, CTRL0, IOB_RXENA, pll ? 0 : IOB_RXENA);
> +	regmap_update_bits(priv->misc, CTRL0, IOB_TXENA, pll ? IOB_TXENA : 0);
> +}
> +
> +static int imx8q_hsio_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, cond;
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx8q_hsio_priv *priv = lane->priv;
> +
> +	if (lane->lane_mode == PHY_MODE_PCIE)
> +		imx8q_hsio_pcie_phy_resets(phy);
> +	else
> +		/* SATA */
> +		regmap_set_bits(priv->phy, lane->phy_off + CTRL0, APB_RSTN_0);
> +
> +	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_PCIEB)
> +		regmap_set_bits(priv->misc, CTRL0, PCIE_AB_SELECT);
> +	if (priv->hsio_cfg & IMX8Q_HSIO_CFG_SATA)
> +		regmap_set_bits(priv->misc, CTRL0, PHYX1_EPCS_SEL);
> +
> +	imx8q_hsio_configure_clk_pad(phy);
> +
> +	if (lane->lane_mode == PHY_MODE_SATA) {
> +		/*
> +		 * It is possible, for PCIe and SATA are sharing
> +		 * the same clock source, HPLL or external oscillator.
> +		 * When PCIe is in low power modes (L1.X or L2 etc),
> +		 * the clock source can be turned off. In this case,
> +		 * if this clock source is required to be toggling by
> +		 * SATA, then SATA functions will be abnormal.
> +		 * Set the override here to avoid it.
> +		 */
> +		regmap_set_bits(priv->misc, CTRL0, CLKREQN_OUT_OVERRIDE);
> +		regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_TXDEEMP);
> +		regmap_set_bits(priv->ctrl, lane->ctrl_off + CTRL0, EPCS_TXDEEMP_SEL);
> +
> +		imx8q_hsio_sata_phy_resets(phy);
> +	} else {
> +		/* Toggle apb_pclk to make sure clear the PM_REQ_CORE_RST bit */
> +		clk_disable_unprepare(lane->clks[0].clk);
> +		mdelay(1);
> +		ret = clk_prepare_enable(lane->clks[0].clk);
> +		if (ret) {
> +			dev_err(priv->dev, "unable to enable phy apb_pclk\n");
> +			return ret;
> +		}
> +
> +		/* Bit19 PM_REQ_CORE_RST of pcie_stts0 should be cleared. */
> +		ret = regmap_read_poll_timeout(priv->ctrl,
> +				lane->ctrl_off + PCIE_STTS0,
> +				val, (val & PM_REQ_CORE_RST) == 0,
> +				PHY_INIT_WAIT_USLEEP_MAX,
> +				PHY_INIT_WAIT_TIMEOUT);
> +		if (ret) {
> +			dev_err(priv->dev, "PM_REQ_CORE_RST is set\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Polling to check the PHY is ready or not. */
> +	if (lane->idx == 1)
> +		cond = LANE1_TX_PLL_LOCK;
> +	else
> +		cond = LANE0_TX_PLL_LOCK;

	cond = lane->idx ? LANE1_TX_PLL_LOCK : LANE0_TX_PLL_LOCK;

> +
> +	ret = regmap_read_poll_timeout(priv->phy, lane->phy_off + PHY_STTS0,
> +			val, ((val & cond) == cond),
> +			PHY_INIT_WAIT_USLEEP_MAX, PHY_INIT_WAIT_TIMEOUT);
> +	if (ret)
> +		dev_err(priv->dev, "IMX8Q PHY%d PLL lock timeout\n", lane->idx);
> +	else
> +		dev_info(priv->dev, "IMX8Q PHY%d PLL is locked\n", lane->idx);
> +
> +	if (lane->lane_mode == PHY_MODE_SATA) {
> +		cond = REG48_PMA_RDY;
> +		ret = read_poll_timeout(readb, val, ((val & cond) == cond),
> +				PHY_INIT_WAIT_USLEEP_MAX, PHY_INIT_WAIT_TIMEOUT,
> +				false, priv->base + REG48_PMA_STATUS);
> +		if (ret)
> +			dev_err(priv->dev, "PHY calibration is timeout\n");
> +		else
> +			dev_info(priv->dev, "PHY calibration is done\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx8q_hsio_set_mode(struct phy *phy, enum phy_mode mode,
> +				   int submode)
> +{
> +	u32 val;
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx8q_hsio_priv *priv = lane->priv;
> +
> +	if (lane->lane_mode != mode)
> +		return -EINVAL;
> +
> +	val = (mode == PHY_MODE_PCIE) ? MODE_PCIE : MODE_SATA;
> +	val = FIELD_PREP(MODE_MASK, val);
> +	regmap_update_bits(priv->phy, lane->phy_off + CTRL0, MODE_MASK, val);
> +
> +	switch (submode) {
> +	case PHY_MODE_PCIE_RC:
> +		val = FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
> +		break;
> +	case PHY_MODE_PCIE_EP:
> +		val = FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ENDPOINT);
> +		break;
> +	default: /* Support only PCIe EP and RC now. */
> +		return 0;
> +	}
> +	if (submode)
> +		regmap_update_bits(priv->ctrl, lane->ctrl_off + CTRL0,
> +				   DEVICE_TYPE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int imx8q_hsio_set_speed(struct phy *phy, int speed)
> +{
> +	struct imx8q_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx8q_hsio_priv *priv = lane->priv;
> +
> +	regmap_update_bits(priv->ctrl, lane->ctrl_off + CTRL2, LTSSM_ENABLE,
> +			   speed ? LTSSM_ENABLE : 0);
> +	return 0;
> +}
> +
> +static const struct phy_ops imx8q_hsio_ops = {
> +	.init = imx8q_hsio_init,
> +	.exit = imx8q_hsio_exit,
> +	.power_on = imx8q_hsio_power_on,
> +	.set_mode = imx8q_hsio_set_mode,
> +	.set_speed = imx8q_hsio_set_speed,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct imx8q_hsio_drvdata imx8qxp_serdes_drvdata = {
> +	.num_lane = 1,
> +};
> +
> +static const struct imx8q_hsio_drvdata imx8qm_serdes_drvdata = {
> +	.num_lane = 3,
> +};
> +
> +static const struct of_device_id imx8q_hsio_of_match[] = {
> +	{.compatible = "fsl,imx8qxp-serdes", .data = &imx8qxp_serdes_drvdata},
> +	{.compatible = "fsl,imx8qm-serdes", .data = &imx8qm_serdes_drvdata},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, imx8q_hsio_of_match);
> +
> +static struct phy *imx8q_hsio_xlate(struct device *dev,
> +				    const struct of_phandle_args *args)
> +{
> +	struct imx8q_hsio_priv *priv = dev_get_drvdata(dev);
> +	int idx = args->args[0];
> +	int ctrl_id = args->args[1];
> +	int hsio_cfg = args->args[2];
> +
> +	if (idx >= priv->drvdata->num_lane)
> +		return ERR_PTR(-EINVAL);
> +	priv->lane[idx].idx = idx;
> +	priv->lane[idx].ctrl_id = ctrl_id;
> +	priv->hsio_cfg = hsio_cfg;
> +
> +	return priv->lane[idx].phy;
> +}
> +
> +static int imx8q_hsio_probe(struct platform_device *pdev)
> +{
> +	int i;
> +	void __iomem *off;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct of_device_id *of_id;
> +	struct imx8q_hsio_priv *priv;
> +	struct phy_provider *provider;
> +
> +	of_id = of_match_device(imx8q_hsio_of_match, dev);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->drvdata = of_device_get_match_data(dev);
> +
> +	/* Get PHY refclk pad mode */
> +	of_property_read_u32(np, "fsl,refclk-pad-mode", &priv->refclk_pad_mode);
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "phy");
> +	priv->phy = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->phy))
> +		return dev_err_probe(dev, PTR_ERR(priv->phy),
> +				     "unable to find phy csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	priv->ctrl = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->ctrl))
> +		return dev_err_probe(dev, PTR_ERR(priv->ctrl),
> +				     "unable to find ctrl csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "misc");
> +	priv->misc = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->misc))
> +		return dev_err_probe(dev, PTR_ERR(priv->misc),
> +				     "unable to find misc csr registers\n");
> +
> +	for (i = 0; i < priv->drvdata->num_lane; i++) {
> +		struct imx8q_hsio_lane *lane = &priv->lane[i];
> +		struct phy *phy;
> +
> +		memset(lane, 0, sizeof(*lane));
> +
> +		phy = devm_phy_create(&pdev->dev, NULL, &imx8q_hsio_ops);
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +
> +		lane->priv = priv;
> +		lane->phy = phy;
> +		lane->idx = i;
> +		phy_set_drvdata(phy, lane);
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	provider = devm_of_phy_provider_register(&pdev->dev, imx8q_hsio_xlate);
> +
> +	return PTR_ERR_OR_ZERO(provider);
> +}
> +
> +static struct platform_driver imx8q_hsio_driver = {
> +	.probe	= imx8q_hsio_probe,
> +	.driver = {
> +		.name	= "imx8q-hsio-phy",
> +		.of_match_table	= imx8q_hsio_of_match,
> +	}
> +};
> +module_platform_driver(imx8q_hsio_driver);
> +
> +MODULE_DESCRIPTION("FSL IMX8Q HSIO SERDES PHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.1
> 

