Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D472D7EE905
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjKPV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjKPV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:56:59 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CACEA;
        Thu, 16 Nov 2023 13:56:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlaCKEel8AbY+26SQuvvA9a7q5UWugT5ok+yUCJmlPB6T7y2VGZtb4GrjBIxYGVV7fb14Hq8VY+SKpEsrMjArOhO8Szg3hCrqIzItVgNr6sZT3DIZG5UZ8JpxpoHhs8vqdP4pLlyg7/UcKAmqIOCyIFslcnaif8NOYzcLXszfere+G3f0ZL2eH56z8ATW/bj/MekaXWZ9Czrp1DChUftQn/66DDEPVd5OhDdyCcTKkBZAtrU312Eg47sBRIN2+QYo9oH67WkkJrYZ/QcF3eh4Ri+wVCYlgboXwfJh/fFC5znHS+A+78t4xqqrFZx2lJA9ylEMXLD9F7PBLYhDCht9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyO9lYW65SMl4yOzcwPGuzTnXPj2vJBXm2lKmwpwrmc=;
 b=gpLHWTpmabfVoDdYsBdoQTaNh9l2tCoohHmoLb/ROAI8QStmOK4MgvX0DzmlmPz9lYOcx7YMaRcnJ8BnZKeHfYFtszwxw7LctBt65sfh8rdgwUkvjwY/3eBt+uEZTIakWDqxDRxa/tlgesTfk+mGXo8LXkawmmCNoofRYHFIO3+NuAmak9Aak0D6/eEbc1r2pk8LqUTD2FuddIrFMwAEGVF+gOOodIZvt5FPF0uSRA22lo/hWmjkreS9u4KiT10LOyYAY61fUFa+FUYwM5dFcHL97TIpKH6C/KLuNC/y3UPkV2nYlJ33Vz75uKcX21zSqSV0D3dwm/lgsnO7HOeRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyO9lYW65SMl4yOzcwPGuzTnXPj2vJBXm2lKmwpwrmc=;
 b=HAz765e6C8L00rLPhxg6w7AbvCKilkRmAGXkbBTSbFryVMjvOFamIOndsGW6PcpIFholdegZK6VTA+BsmDOCajyIP7OToGJ1FdowmuF33BuLCLSIlW5W5mRsFusByPCMYBKDJ3qxiTuT09QOJcjMgLL18hcqXalv7vt2GovVNBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9136.eurprd04.prod.outlook.com (2603:10a6:150:27::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Thu, 16 Nov
 2023 21:56:50 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 21:56:49 +0000
Date:   Thu, 16 Nov 2023 23:56:45 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Romain Gantois <romain.gantois@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 3/8] net: qualcomm: ipqess: introduce the
 Qualcomm IPQESS driver
Message-ID: <20231116215645.3ex4yp36hrrm4uti@skbuf>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-4-romain.gantois@bootlin.com>
 <20231114105600.1012056-4-romain.gantois@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-4-romain.gantois@bootlin.com>
 <20231114105600.1012056-4-romain.gantois@bootlin.com>
X-ClientProxiedBy: AM9P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b08efe-6319-4db4-ef5b-08dbe6eeef64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FjLkRmhD4QaUxNIxbycFAK1hiY9bpZd62d7L7IQdxU5TDpVAmDRciyftOmtegtE7nCVeYTywVedpM6xbmixWoOZTeu+QXrv06f+QrALAvMD+Ebbv6kt0I6PaEnPWBCOsZQ+RFfOYsq0QeA3nCbl3qDKitLsaJF0jcjbyAyMm8r4bnIrIqCYyJ2DZhYkai+cUhr7rarG/PTmfrdDOoyNpdTL7X/9q+uhmr83WmMtKktB4ZramG3moTzhSb5J9mddWO1UBuUCSt2PL9bHfQcd5OeviAHvQYMyQK9HsUpnevWvXnhTKQfBEnfrjM+XhDKgUrPsCa/S4vTt4ijqRLaKaNZBEINh/3+9iPLm8OdTE/AGgWuu2STAWKa0wynFFs41Jrx5BCGUcMeyXq6LbKw8BeOBl6icrZGSEaBJtvKuEz6fo+hnAJofH2ter1bgqkHjjpqIU947JC3xgOtylk9UF8d44W6uOeTQruhkKuJ4hZLZ/7nR++RtHuce8JtdI4d0ORZ4OSm6tSfXlKjFHYSTUVKlicokbqVbFdgBSZWUNTb53i0C7W1CPY0wW01h8uL1HTFil2hPPrwOJ3KxHZn1DIWpZeY1AgZJfMy74ZarobX24GKUBaJ9DU1QSLwbZpep
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799009)(451199024)(64100799003)(54906003)(6512007)(9686003)(316002)(66476007)(66946007)(110136005)(66556008)(26005)(1076003)(66899024)(6486002)(478600001)(6506007)(6666004)(30864003)(33716001)(7416002)(5660300002)(86362001)(2906002)(38100700002)(83380400001)(8676002)(41300700001)(8936002)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKS0YIppAxHr+DGC6VX8Dc2O3zSKEygZRv+UTJornWbRWNPYl3bJYCREHmwS?=
 =?us-ascii?Q?iwZyYvZ5U1IkIzBKvsa8kGfgEMcsP5sYVLz3hhfJeE6Y9YEauI5qdDIyfBvv?=
 =?us-ascii?Q?c2vlj6tolVU6U1uZ3aNZXm5eUZ4whTrHff7AmDZXZS9+m/QWkDMGR4+mtazi?=
 =?us-ascii?Q?+abSv8bs3YhZvkFJiNrq9Dvm1SBfrWYibWwCFPdH3JKaNInZmc4nWGQGMhzh?=
 =?us-ascii?Q?mj+WTWwIfzIqrIJ6W3Ge0d+r48A/PcUFvvFAmKnVXYEdMbL5Atf8Gz6XIbd0?=
 =?us-ascii?Q?O+BqIMhPecmkqVf6BZdEBjzh8rk8KlpvqHZmy+VnBF0LOjfOZToh7oIeNjSH?=
 =?us-ascii?Q?qdvMauS6yYYW7yvwnyUPupLcRtJSrVTcNFtTD6woKldz+++qz8vg3ozOHEgm?=
 =?us-ascii?Q?s1gUHU31pNCmkRVDo3hu1mODReqQbWyJL7mdtVROHKkP58m5NQGTSV9wgpqV?=
 =?us-ascii?Q?QujQH8QggFd7Z9SCciYzDePCt7gxeA1PUvysbCKJTgPc2BF3tBfHOu84z3GN?=
 =?us-ascii?Q?ghg9T/jco30nuHOdPVAaPEqjXLj8j/Hk3SUPWVY7yKR245soR1HsMEtKmRtH?=
 =?us-ascii?Q?mXIIOk0lOcxDknUZDjmd6yVssrmaqq+3pl1RjgilcWL6tt2cmzLMPPuIgUo7?=
 =?us-ascii?Q?CqsnAN0eqknouaMI88Twl2tqyz82nvGQO9GX1o95+9XMmDnQ40M/CfW/tezc?=
 =?us-ascii?Q?7B9ALZl9CTY/Zf65hGNYVvTcDvbVbz/ur7LmTko/sIlv1/i4ap17x1N2R2FM?=
 =?us-ascii?Q?oy5SsY4CqjEIRaFSxf/no991WOSt5VAqHdk4dz9ufYTBPNp+wG3Xv7oHoR7B?=
 =?us-ascii?Q?O7gum5j5v1Mjlha9ywlAWHvdkrob+Wd5M2o6IhHqSXybz+YmpOubh1l4FBbn?=
 =?us-ascii?Q?O9phWu34blff4dThmnpLLnLM26ZF7uUZWY77ChXgPCB7tKP7NZKAmEsQiyqJ?=
 =?us-ascii?Q?EgtQi2hQ/iqEEUB/SlkbHpe2YTlCs8aIuyEnlP+FzoQT7ZyuOrTlJYNZ7Vqw?=
 =?us-ascii?Q?AMnD57RbjaPrU6Z75WMe0yeIR8VhGP83v4Mi5hF+4Em0JF+26K1CHitwp7UD?=
 =?us-ascii?Q?Q6FHRWGB1HaAfDmcGSALNmT2Sp0cvvIhEjdEkfooGuHAf7vlztL1kLJp331+?=
 =?us-ascii?Q?xpI9+JGDcMoFEWlxUN+SN7Faw1w0d8JRhNV97uPE45aZlThiP5FcFbFrZPML?=
 =?us-ascii?Q?rVJhPkcejflQlby5TobmT/w7tPAWjo1HBjnn27PZg1wkV1rgGKRGhuF/heEf?=
 =?us-ascii?Q?4Our32qXi850qmXvxNX+24efhmBhqLiN3wd483e703t11pvhxc8kkOjEr4HW?=
 =?us-ascii?Q?VuFO0yyFtH/POmPA2VD8PTo69RihpZhX36bBnAkt2m84wqjp0LpcywFM2Go3?=
 =?us-ascii?Q?YYL/zsPMl4mQLBM5dcR0Y8g3FMLfYIZg7V6lxma0GNpNYbmg+fXqW2Mk01E8?=
 =?us-ascii?Q?vLe3IhiMSaslhEulKQ5ssh8tH3Gt2xvwdMCuQbbb4L6PIrCibxf0hsN/6+Ll?=
 =?us-ascii?Q?l7jDYBQOSwXelGWg1FLVpjOzlgBFiKuCT2mHc7bHv6OARGpQc+jz7GbTWdYS?=
 =?us-ascii?Q?/+GH40WXcUQETl31P1hACaKcw7bjjBd/ycLx7789FRJ+MQiYJ9qB1iCGwG1n?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b08efe-6319-4db4-ef5b-08dbe6eeef64
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 21:56:49.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpGZKHaQwK/H4MlbHSmCU562lMmnN1tgpNjvhSl1KX78WpljMgrU1BrHVFoFwG4lM8hZxxSm40pZ98yw1UVQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 11:55:53AM +0100, Romain Gantois wrote:
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 56663770382e..a66a821ce4d6 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -79,6 +79,19 @@ int qca8k_rmw(struct qca8k_priv *priv, u32 reg, u32 mask, u32 write_val)
>  {
>  	return regmap_update_bits(priv->regmap, reg, mask, write_val);
>  }
> +EXPORT_SYMBOL_GPL(qca8k_rmw);
> +
> +int qca8k_set_bits(struct qca8k_priv *priv, u32 reg, u32 bits)
> +{
> +	return regmap_set_bits(priv->regmap, reg, bits);
> +}
> +EXPORT_SYMBOL_GPL(qca8k_set_bits);
> +
> +int qca8k_clear_bits(struct qca8k_priv *priv, u32 reg, u32 bits)
> +{
> +	return regmap_clear_bits(priv->regmap, reg, bits);
> +}
> +EXPORT_SYMBOL_GPL(qca8k_clear_bits);

No motivation given for these. Also, no one uses them in this change.

> diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
> index 9210ff360fdc..008d20ec9eae 100644
> --- a/drivers/net/ethernet/qualcomm/Kconfig
> +++ b/drivers/net/ethernet/qualcomm/Kconfig
> @@ -61,6 +61,20 @@ config QCOM_EMAC
>  	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
>  	  Precision Clock Synchronization Protocol.
>  
> +config QCOM_IPQ4019_ESS
> +	tristate "Qualcomm Atheros IPQ4019 Ethernet Switch Subsystem support"
> +	depends on (OF && ARCH_QCOM) || COMPILE_TEST
> +	select PHYLINK
> +	select NET_DSA

NET_DSA has dependencies, you cannot select something with dependencies
unless you also depend on all of NET_DSA's dependencies too (which you don't).

You shouldn't depend on the NET_DSA framework as far as I can tell,
since you use nothing from it. You just need NET_DSA_QCA8K_LIB, which in
my mind should have been a DSA-unaware hardware library, with its own
data structures and functions shareable by both driver front-ends. To
get to that, drivers/net/Makefile currently has obj-$(CONFIG_NET_DSA) +=
dsa/, but maybe it should have had obj-y += dsa/, to make
NET_DSA_QCA8K_LIB available without NET_DSA.

> +	select NET_DSA_QCA8K_LIB
> +	select PAGE_POOL
> +	help
> +	  This driver supports the Qualcomm Atheros IPQ40xx built-in
> +	  Ethernet Switch Subsystem.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ipqess.
> +
>  source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
>  
>  endif # NET_VENDOR_QUALCOMM
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> new file mode 100644
> index 000000000000..f0f5fe3a7c24
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.c
> @@ -0,0 +1,757 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Handling of a single switch port
> + *
> + * Copyright (c) 2023, Romain Gantois <romain.gantois@bootlin.com>
> + * Based on net/dsa
> + */
> +
> +#include <linux/if_bridge.h>
> +#include <linux/etherdevice.h>
> +#include <linux/if_vlan.h>
> +#include <linux/of_net.h>
> +
> +#include "ipqess_port.h"
> +#include "ipqess_edma.h"
> +#include "ipqess_switch.h"
> +#include "ipqess_notifiers.h"
> +
> +#define ipqess_port_from_pl_state(config, pl_config)\
> +container_of(config, struct ipqess_port, pl_config)
> +
> +static struct device_type ipqess_port_type = {
> +	.name	= "switch",
> +};
(...)
> +	SET_NETDEV_DEVTYPE(netdev, &ipqess_port_type);

Why do you do this?

> +static void ipqess_port_stp_state_set(struct ipqess_port *port,
> +				      u8 state)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 stp_state;
> +	int err;
> +
> +	switch (state) {
> +	case BR_STATE_DISABLED:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_DISABLED;
> +		break;
> +	case BR_STATE_BLOCKING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_BLOCKING;
> +		break;
> +	case BR_STATE_LISTENING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_LISTENING;
> +		break;
> +	case BR_STATE_LEARNING:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_LEARNING;
> +		break;
> +	case BR_STATE_FORWARDING:
> +	default:
> +		stp_state = QCA8K_PORT_LOOKUP_STATE_FORWARD;
> +		break;
> +	}
> +
> +	err = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port->index),
> +			QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> +
> +	if (err)
> +		dev_warn(priv->dev,
> +			 "failed to set STP state %d for port %d: err %d\n",
> +			 stp_state, port->index, err);
> +}

Does this have to reimplement qca8k_port_stp_state_set()?

> +static int ipqess_port_enable_rt(struct ipqess_port *port,
> +				 struct phy_device *phy)
> +{
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	qca8k_port_set_status(priv, port->index, 1);
> +	priv->port_enabled_map |= BIT(port->index);
> +
> +	phy_support_asym_pause(phy);

Question mark here, phylink_bringup_phy() should do this to. I see it
comes from qca8k_port_enable(), so I don't think we need this there
either.

> +
> +	ipqess_port_set_state_now(port, BR_STATE_FORWARDING, false);
> +
> +	if (port->pl)
> +		phylink_start(port->pl);
> +
> +	return 0;
> +}
> +static netdev_tx_t ipqess_port_xmit(struct sk_buff *skb,
> +				    struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +
> +	dev_sw_netstats_tx_add(netdev, 1, skb->len);
> +
> +	memset(skb->cb, 0, sizeof(skb->cb));

What use do you make of skb->cb?

> +
> +	return ipqess_edma_xmit(skb, port->netdev);
> +}
> +
> +static int ipqess_port_set_mac_address(struct net_device *netdev, void *a)
> +{
> +	struct sockaddr *addr = a;
> +	int err;
> +
> +	/* If the port is down, the address isn't synced yet to hardware
> +	 * so there is nothing to change
> +	 */
> +	if (!(netdev->flags & IFF_UP)) {
> +		eth_hw_addr_set(netdev, addr->sa_data);
> +		return 0;

In DSA, the MAC address is programmed to hardware in dsa_user_open().
Please help me see where the same thing happens in the ipqess switch
driver, as the copied comment suggests.

> +	}
> +
> +	if (!ether_addr_equal(addr->sa_data, netdev->dev_addr)) {
> +		err = dev_uc_add(netdev, addr->sa_data);
> +		if (err < 0)
> +			return err;
> +	}

I guess this should have programmed something to hardware. It looks like
an inept adaptation of dsa_user_set_mac_address(). The major difference
is that with DSA, the dev_uc_add() is done on the conduit interface.
Here it's done on itself.

> +
> +	return 0;
> +}
> +
> +static int ipqess_port_get_iflink(const struct net_device *dev)
> +{
> +	return dev->ifindex;
> +}

What do you need an iflink for?

> +static int ipqess_port_do_vlan_add(struct qca8k_priv *priv, int port_index,
> +				   const struct switchdev_obj_port_vlan *vlan,
> +				   struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	int ret;
> +
> +	ret = qca8k_vlan_add(priv, port_index, vlan->vid, untagged);
> +	if (ret) {
> +		dev_err(priv->dev, "Failed to add VLAN to port %d (%d)", port_index,
> +			ret);
> +		return ret;
> +	}
> +
> +	if (pvid) {
> +		ret = qca8k_rmw(priv, QCA8K_EGRESS_VLAN(port_index),
> +				QCA8K_EGREES_VLAN_PORT_MASK(port_index),

A preliminary patch renaming EGREES to EGRESS would be nice.

> +				QCA8K_EGREES_VLAN_PORT(port_index, vlan->vid));
> +		if (ret)
> +			return ret;
> +
> +		ret = qca8k_write(priv, QCA8K_REG_PORT_VLAN_CTRL0(port_index),
> +				  QCA8K_PORT_VLAN_CVID(vlan->vid) |
> +				  QCA8K_PORT_VLAN_SVID(vlan->vid));
> +	}
> +
> +	return ret;
> +}

I'm not clear why this reimplements qca8k_port_vlan_add().

> +/* phylink ops */
> +
> +static void
> +ipqess_phylink_mac_config(struct phylink_config *config,
> +			  unsigned int mode,
> +			  const struct phylink_link_state *state)
> +{
> +	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	switch (port->index) {
> +	case 0:
> +		/* CPU port, no configuration needed */
> +		return;
> +	case 1:
> +	case 2:
> +	case 3:
> +	case 4:
> +	case 5:
> +		if (phy_interface_mode_is_rgmii(state->interface))
> +			regmap_set_bits(priv->regmap,
> +					QCA8K_IPQ4019_REG_RGMII_CTRL,
> +					QCA8K_IPQ4019_RGMII_CTRL_CLK);
> +		return;
> +	default:
> +		dev_err(priv->dev, "%s: unsupported port: %i\n", __func__,
> +			port->index);
> +		return;
> +	}
> +}
> +
> +static void
> +ipqess_phylink_mac_link_down(struct phylink_config *config,
> +			     unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
> +	struct qca8k_priv *priv = port->sw->priv;
> +
> +	qca8k_port_set_status(priv, port->index, 0);
> +}
> +
> +static void ipqess_phylink_mac_link_up(struct phylink_config *config,
> +				       struct phy_device *phydev,
> +				       unsigned int mode,
> +				       phy_interface_t interface,
> +				       int speed, int duplex,
> +				       bool tx_pause, bool rx_pause)
> +{
> +	struct ipqess_port *port = ipqess_port_from_pl_state(config, pl_config);
> +	struct qca8k_priv *priv = port->sw->priv;
> +	u32 reg;
> +
> +	if (phylink_autoneg_inband(mode)) {
> +		reg = QCA8K_PORT_STATUS_LINK_AUTO;
> +	} else {
> +		switch (speed) {
> +		case SPEED_10:
> +			reg = QCA8K_PORT_STATUS_SPEED_10;
> +			break;
> +		case SPEED_100:
> +			reg = QCA8K_PORT_STATUS_SPEED_100;
> +			break;
> +		case SPEED_1000:
> +			reg = QCA8K_PORT_STATUS_SPEED_1000;
> +			break;
> +		default:
> +			reg = QCA8K_PORT_STATUS_LINK_AUTO;
> +			break;
> +		}
> +
> +		if (duplex == DUPLEX_FULL)
> +			reg |= QCA8K_PORT_STATUS_DUPLEX;
> +
> +		if (rx_pause || port->index == 0)
> +			reg |= QCA8K_PORT_STATUS_RXFLOW;
> +
> +		if (tx_pause || port->index == 0)
> +			reg |= QCA8K_PORT_STATUS_TXFLOW;
> +	}
> +
> +	reg |= QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> +
> +	qca8k_write(priv, QCA8K_REG_PORT_STATUS(port->index), reg);
> +}
> +
> +static const struct phylink_mac_ops ipqess_phylink_mac_ops = {
> +	.mac_config = ipqess_phylink_mac_config,
> +	.mac_link_down = ipqess_phylink_mac_link_down,
> +	.mac_link_up = ipqess_phylink_mac_link_up,
> +};

phylink mac ops are a reimplementation of the qca8k ops. So are the pcs
ops, for that matter. For the pcs ops, there is the option of moving the
code to drivers/net/pcs/ for easier sharing.

> +static int ipqess_phylink_create(struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct phylink_config *pl_config = &port->pl_config;
> +	phy_interface_t mode;
> +	struct phylink *pl;
> +	int err;
> +
> +	err = of_get_phy_mode(port->dn, &mode);
> +	if (err)
> +		mode = PHY_INTERFACE_MODE_NA;
> +
> +	switch (port->index) {
> +	case 1:
> +	case 2:
> +	case 3:
> +		__set_bit(PHY_INTERFACE_MODE_PSGMII,
> +			  pl_config->supported_interfaces);
> +		break;
> +	case 4:
> +	case 5:
> +		phy_interface_set_rgmii(pl_config->supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_PSGMII,
> +			  pl_config->supported_interfaces);
> +		break;
> +	case 0: /* CPU port, this shouldn't happen */
> +	default:
> +		return -EINVAL;
> +	}
> +	/* phylink caps */
> +	pl_config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> +		MAC_10 | MAC_100 | MAC_1000FD;
> +
> +	pl = phylink_create(pl_config, of_fwnode_handle(port->dn),
> +			    mode, &ipqess_phylink_mac_ops);
> +	if (IS_ERR(pl))
> +		return PTR_ERR(pl);
> +
> +	port->pl = pl;
> +	return 0;
> +}
> +
> +static int ipqess_port_phy_connect(struct net_device *netdev, int addr,
> +				   u32 flags)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +
> +	netdev->phydev = mdiobus_get_phy(port->mii_bus, addr);
> +	if (!netdev->phydev) {
> +		netdev_err(netdev, "no phy at %d\n", addr);
> +		return -ENODEV;
> +	}
> +
> +	netdev->phydev->dev_flags |= flags;
> +
> +	return phylink_connect_phy(port->pl, netdev->phydev);
> +}
> +
> +static int ipqess_port_phy_setup(struct net_device *netdev)
> +{
> +	struct ipqess_port *port = netdev_priv(netdev);
> +	struct device_node *port_dn = port->dn;
> +	u32 phy_flags = 0;
> +	int ret;
> +
> +	port->pl_config.dev = &netdev->dev;
> +	port->pl_config.type = PHYLINK_NETDEV;
> +
> +	ret = ipqess_phylink_create(netdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = phylink_of_phy_connect(port->pl, port_dn, phy_flags);
> +	if (ret == -ENODEV && port->mii_bus) {
> +		/* We could not connect to a designated PHY or SFP, so try to
> +		 * use the switch internal MDIO bus instead
> +		 */
> +		ret = ipqess_port_phy_connect(netdev, port->index, phy_flags);
> +	}

Do you need a non-OF based phy_connect()? Will you not always have a
phy-handle or a fixed-link?

> +
> +	if (ret) {
> +		netdev_err(netdev, "failed to connect to PHY: %pe\n",
> +			   ERR_PTR(ret));
> +		phylink_destroy(port->pl);
> +		port->pl = NULL;
> +	}
> +
> +	dev_info(&netdev->dev, "enabled port's phy: %s",
> +		 phydev_name(netdev->phydev));
> +	return ret;
> +}
> +
> +/* netlink */
> +
> +#define IFLA_IPQESS_UNSPEC 0
> +#define IFLA_IPQESS_MAX 0
> +
> +static const struct nla_policy ipqess_port_policy[IFLA_IPQESS_MAX + 1] = {
> +	[IFLA_IPQESS_MAX] = { .type = NLA_U32 },
> +};
> +
> +static size_t ipqess_port_get_size(const struct net_device *dev)
> +{
> +	return nla_total_size(sizeof(u32));
> +}
> +
> +static int ipqess_port_fill_info(struct sk_buff *skb,
> +				 const struct net_device *dev)
> +{
> +	if (nla_put_u32(skb, IFLA_IPQESS_UNSPEC, dev->ifindex))
> +		return -EMSGSIZE;
> +
> +	return 0;
> +}
> +
> +static struct rtnl_link_ops ipqess_port_link_ops __read_mostly = {
> +	.kind         = "switch",
> +	.priv_size    = sizeof(struct ipqess_port),
> +	.maxtype      = 1,
> +	.policy       = ipqess_port_policy,
> +	.get_size     = ipqess_port_get_size,
> +	.fill_info    = ipqess_port_fill_info,
> +	.netns_refund = true,
> +};

What the hell do you use netlink for?

> +/* devlink */
> +
> +static int ipqess_port_devlink_setup(struct ipqess_port *port)
> +{
> +	struct devlink_port *dlp = &port->devlink_port;
> +	struct devlink *dl = port->sw->devlink;
> +	struct devlink_port_attrs attrs = {};
> +	const unsigned char *id;
> +	unsigned int index = 0;
> +	unsigned char len;
> +	int err;
> +
> +	id = (const unsigned char *)&index;
> +	len = sizeof(index);
> +	memset(dlp, 0, sizeof(*dlp));
> +
> +	attrs.phys.port_number = port->index;
> +	memcpy(attrs.switch_id.id, id, len);
> +	attrs.switch_id.id_len = len;
> +	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> +	devlink_port_attrs_set(dlp, &attrs);
> +
> +	err = devlink_port_register(dl, dlp, port->index);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +/* register */
> +
> +int ipqess_port_register(struct ipqess_switch *sw,
> +			 struct device_node *port_node)
> +{
> +	struct qca8k_priv *priv = sw->priv;
> +	struct net_device *netdev;
> +	struct ipqess_port *port;
> +	const char *name;
> +	int assign_type;
> +	int num_queues;
> +	u32 index;
> +	int err;
> +
> +	err = of_property_read_u32(port_node, "reg", &index);
> +	if (err) {
> +		pr_err("Node without reg property!");
> +		return err;
> +	}
> +
> +	name = of_get_property(port_node, "label", NULL);

The "label" device tree property is deprecated in favor of using udev
for predictable netdev names.

> +	if (!name) {
> +		name = "eth%d";
> +		assign_type = NET_NAME_ENUM;
> +	} else {
> +		assign_type = NET_NAME_PREDICTABLE;
> +	}
> +
> +	/* For the NAPI leader, we allocate one queue per MAC queue */
> +	if (!sw->napi_leader)
> +		num_queues = IPQESS_EDMA_NETDEV_QUEUES;
> +	else
> +		num_queues = 1;
> +
> +	netdev = alloc_netdev_mqs(sizeof(struct ipqess_port), name, assign_type,
> +				  ether_setup, num_queues, num_queues);
> +	if (!netdev)
> +		return -ENOMEM;
> +
> +	if (!sw->napi_leader)
> +		sw->napi_leader = netdev;
> +
> +	port = netdev_priv(netdev);
> +	port->index = (int)index;
> +	port->dn = port_node;
> +	port->netdev = netdev;
> +	port->edma = NULL; /* Assigned during edma initialization */
> +	port->qid = port->index - 1;
> +	port->sw = sw;
> +
> +	of_get_mac_address(port_node, port->mac);
> +	if (!is_zero_ether_addr(port->mac))
> +		eth_hw_addr_set(netdev, port->mac);
> +	else
> +		eth_hw_addr_random(netdev);
> +
> +	netdev->netdev_ops = &ipqess_port_netdev_ops;
> +	netdev->max_mtu = QCA8K_MAX_MTU;
> +	SET_NETDEV_DEVTYPE(netdev, &ipqess_port_type);
> +	SET_NETDEV_DEV(netdev, priv->dev);
> +	SET_NETDEV_DEVLINK_PORT(netdev, &port->devlink_port);
> +	netdev->dev.of_node = port->dn;
> +
> +	netdev->rtnl_link_ops = &ipqess_port_link_ops;
> +
> +	netdev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
> +	if (!netdev->tstats) {
> +		free_netdev(netdev);
> +		return -ENOMEM;
> +	}
> +
> +	err = ipqess_port_devlink_setup(port);
> +	if (err)
> +		goto out_free;
> +
> +	err = gro_cells_init(&port->gcells, netdev);
> +	if (err)
> +		goto out_devlink;

If the switch doesn't insert DSA tags, you don't need GRO cells.
Normal GRO should work just fine on the receive side of the DMA engine.

> +
> +	err = ipqess_port_phy_setup(netdev);
> +	if (err) {
> +		pr_err("error setting up PHY: %d\n", err);
> +		goto out_gcells;
> +	}
> +
> +	/* We use the qid and not the index because port 0 isn't registered */
> +	sw->port_list[port->qid] = port;

port_list is an array? :)

> +
> +	err = register_netdev(netdev);
> +	if (err) {
> +		pr_err("error %d registering interface %s\n",
> +		       err, netdev->name);
> +		rtnl_unlock();

Where did you rtnl_lock()?

> +		goto out_phy;
> +	}
> +
> +	return 0;
> +
> +out_phy:
> +	rtnl_lock();
> +	phylink_disconnect_phy(port->pl);
> +	rtnl_unlock();
> +	phylink_destroy(port->pl);
> +	port->pl = NULL;
> +out_gcells:
> +	gro_cells_destroy(&port->gcells);
> +out_devlink:
> +	devlink_port_unregister(&port->devlink_port);
> +out_free:
> +	free_percpu(netdev->tstats);
> +	free_netdev(netdev);
> +	sw->port_list[port->qid] = NULL;
> +	return err;
> +}
> +
> +void ipqess_port_unregister(struct ipqess_port *port)
> +{
> +	struct net_device *netdev = port->netdev;
> +
> +	unregister_netdev(netdev);
> +
> +	devlink_port_unregister(&port->devlink_port);
> +
> +	rtnl_lock();
> +	phylink_disconnect_phy(port->pl);
> +	rtnl_unlock();
> +	phylink_destroy(port->pl);
> +	port->pl = NULL;
> +
> +	gro_cells_destroy(&port->gcells);
> +
> +	free_percpu(netdev->tstats);
> +	free_netdev(netdev);
> +}
> +
> diff --git a/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> new file mode 100644
> index 000000000000..26bac45dd811
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ipqess/ipqess_port.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR ISC */
> +
> +#ifndef IPQESS_PORT_H
> +#define IPQESS_PORT_H
> +
> +#include <net/gro_cells.h>
> +#include <net/devlink.h>
> +
> +#include "ipqess_edma.h"
> +#include "ipqess_switch.h"
> +
> +struct ipqess_port {
> +	u16 index;
> +	u16 qid;
> +
> +	struct ipqess_edma *edma;
> +	struct ipqess_switch *sw;
> +	struct phylink *pl;
> +	struct phylink_config pl_config;
> +	struct device_node *dn;
> +	struct mii_bus *mii_bus;
> +	struct net_device *netdev;
> +	struct devlink_port devlink_port;
> +
> +	u8       stp_state;
> +
> +	u8       mac[ETH_ALEN];

Inconsistent mix of single space, many spaces and tabs for alignment.

> +
> +	/* Warning: the following bit field is not atomic, and updating it
> +	 * can only be done from code paths where concurrency is not possible
> +	 * (probe time or under rtnl_lock).
> +	 */
> +	u8			vlan_filtering:1;

In dsa_switch, where you copied this comment from, there are actually
multiple bitfields which share the same u32. Here, there's a single one.
So the comment actually does not apply.

Not to mention that this can be simply "bool".

> +
> +	unsigned int		ageing_time;
> +
> +	struct gro_cells	gcells;
> +
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	struct netpoll		*netpoll;
> +#endif

Do you actually use netpoll?

> +};

I think that commenting on the rest is slightly pointless.

I'm 99% sure that I know the answer to the questions I formulated thus
far: you didn't do the most basic step of assessing what you need from
DSA, and only taking it as a loose implementation example of a switchdev
driver.

What we see here is a snapshot of DSA from October 2023 which was copied
and pasted with some renaming.

Snap out of the mentality where you can copy DSA and call it a day, and
think about it as a new driver - your driver. Present it feature by
feature, and even more importantly, test it feature by feature. After it
is merged, you'll have to maintain it. The DSA bug fixes won't magically
fix the ipqess driver copy as well. Every line that you add is a line
that you're responsible for. I'm not sure how someone who was this
negligent copying code word for word can be less negligent maintaining
it.

I'm very serious about this, and I'm sorry that Wojciech spent so much
energy reviewing essentially a clumsy duplication of DSA. Let's stop and
think how we can proceed forward. I'm not saying that the "two frontends,
one common hardware library" idea cannot be successfully implemented
(after all, ocelot/felix is just that), but maybe I understated the fact
that it is a complex task that should be taken seriously. As things
stand, the variant with the "in-band DSA tags" was more palatable than
this.

@Florian, in Documentation/networking/dsa/dsa.rst we say this:

| TODO
| ====
|
| Making SWITCHDEV and DSA converge towards an unified codebase
| -------------------------------------------------------------
|
| SWITCHDEV properly takes care of abstracting the networking stack with offload
| capable hardware, but does not enforce a strict switch device driver model. On
| the other DSA enforces a fairly strict device driver model, and deals with most
| of the switch specific. At some point we should envision a merger between these
| two subsystems and get the best of both worlds.

Now we have Bootlin's ipqess project as a clear use case for this switch
handling "library code" that we could extract out of DSA. So it is a
good moment to talk about whether there is any value to this
long-standing TODO. I'm not saying yes or no, but at least, if it can't
help here, I would like to put the idea to rest and delete the TODO.

If we do see a path forward for that TODO through this discussion, the
way I see it is that one of the DSA maintainers will have to sit down a
while and prototype something. It can also be me who spends that time,
but I don't personally have an idea how to get started - how to extract
that code to a library without it getting extremely clunky and limiting
the flexibility of other drivers that may use it.
