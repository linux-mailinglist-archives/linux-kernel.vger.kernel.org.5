Return-Path: <linux-kernel+bounces-97497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE97876B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFD61C20FF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F55916D;
	Fri,  8 Mar 2024 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FeJ7rCBT"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8858AC5;
	Fri,  8 Mar 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925108; cv=fail; b=QJ8h3lOE2kMkXpXr4eGfjf3A/CHlMaMcoLvMQC3ezMrrTu4Nq0G35J7UdrL/ZIakIJY9j1RbrZDbnd+onpIJ1KBVrDt2Xl3gurYNfBI6/7jaR2YxaW91TNImJr6Vuqp8JCDGVAOc3rqm3wanBXuPxR9HJI9zNxacXSDpFUvvukY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925108; c=relaxed/simple;
	bh=nbwIbRsHpjhVdgOu8mQxdHH5VpUoyegi2uGJz5NwBcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=km0v351shnO34kJFdjmkX1WYgadC7ImJKNCVzE+JefDuLsh6vgsOdLwA2ti6YKkqolAHJHIAAJ41R8agy/E9ljjJYpvyXQ8HyOLul8qQu1G1ARFEdiy6pOU8Omhswr8sheP6VkruXxU8F9YiRkCKhDJw/eBB9P8xz/e6ywCYaSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FeJ7rCBT; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec0/ApShpKE1UO21NMWBqPip91My7YJv0F6QOmPabZe/jtmlt8lttov7+jSPwS8AHDhQHI2JgygSJiAcrfrw4vgqKKzlUTPwDSCFJ7OdU8vWTrMZpmpr1pBq5xe9/ETT4tIFCN28HjA4EVjlYkQ9vZle8vYa+1VBWRF8S6+ZQ7ESHqPv9jb06ACA3Grq5NdPELNs7tPwPoLm9w/QREOUqNq/WP7xIbPoEvaiMjSmWdSCFmRKVAHK8JLcWsv70Nx5VYDl73Yc/ElJQ2c239rn9x+S9y4+TBMSM9vMZs/qyucM4miq+MM6DoJHQyndOjnQBEHj5TA2gXLSsbLAtGwyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/shYkFSPQCFmtRw8GMa2DZdUvaX3XK+N2FCFCD0FbI=;
 b=RJkQ6L1cF7w+uxYqYbYYn8JY5LWzNF6haZKPTbGXV2/X+l+AgsW3rRkJM1GhWOSu82a7gtd38zvfwYmCjDbD4BkJRwwaSHZEc45G0dWV83xr8aZOFDZuOfZWq10GpV8BXv6TXvCIYcANZwoqJ/Y4qGfFXSZD+sYp1l4NSvD6obbZlgwx9ecCFr91di/3O3yE2qTGOteIfG/z6v86fhNdFmoZys+29D5FpSILmwS2HMKs4tiS16zyEfTtcb8qpd6YgbDgiuSDMGMW/MMrKk618VTYpXbscgZ2axBLMVyE+3OKIV/dSvSCRZZztIq4y7g+YtYX5bOuHhy9G2MnTMoQPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/shYkFSPQCFmtRw8GMa2DZdUvaX3XK+N2FCFCD0FbI=;
 b=FeJ7rCBT8gwelvoYbtZ75Vwoi6Yby1NETS/L5cUDVxe5PbbOlX3ZHeLMbdkqaQu1jY109Lr6NKs2mCGBQpsKiIyX4UvGsGKkapOwMhMN3IlCytPUfmcPw5qQxkkHpz8rz9dRg7xg62Nk6CsZGFVle8S4xcivvZ9STqX9xQHktnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9742.eurprd04.prod.outlook.com (2603:10a6:102:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 19:11:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:11:42 +0000
Date: Fri, 8 Mar 2024 14:11:34 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <Zeti5mFUUh9UedAx@lizhi-Precision-Tower-5810>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-2-e08f6d030e09@nxp.com>
 <20240308181103.GA855753-robh@kernel.org>
 <ZetgiaZ1+wt5lCkB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZetgiaZ1+wt5lCkB@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd0ae21-1d14-4818-86d1-08dc3fa3972a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D6VVGZGdEUCQj3wAx84uL1x/BwDxFc2B+85Q80pC//A3rbrUf7Tyq3MelKvQi9OEUGRBvndaoUkkZIWxT9ntvMP/h5SKd7/vuOTxL8me42kjh3UpkWbybaPG+hWQTdywO8a139C5YpEoYcVXA/mah28GlZpTipB/jXGw2BSH55tyfVJsQQetm9+Mk+JRcj9AsgG161yRV22EN23MdWur+AJx0G8U0HGMucNcsi9l2d+IxIL9NcOpbMvyA5MmlGfNicqGk/sIAABSNuVKBKSwOn2ez1hjROgEaHE97RH0g4HqfT3Jw3zAEE5UqIaQCP4g7SyByG07V9G+U/brRv+0BiEjcM9OqedIbvAMcBGZewbJKnk1nhWvMKaPj2QDy4YvvzgPermtTPFoswMk7b17OvwHIXuyWSuRjE2qSC7Qb74lJjDLoefv0KH+7r+WkBLXpQ1rsDfPoVrLBGP7sVk2DJnpfQpuPs6e4jUpVmfU6y+/aynj5zO4jLn7fLHZgJcqqgouLlAFBTbLcPbgnGizfBYVTw+A1DiM34b6HFQx1f9GGH2BxrNXyT6yktVyXRsq6YwnVs44B7c6OP1ywbiKyBMtpXMCO48/oIHTkPUiLcxjOs+W0ge8lVBkuolJ+TNlVvW8rbrwruQgwGDaYbkVa/+5WFgvHo2FZbjMUV3PtdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPBRnFS1t0Um3plx8EEhjsWfsTOquEjRMFFFQiWIUwzArBc2HYtJxqF0vogf?=
 =?us-ascii?Q?gOg6UsuwKxoaV/xID/hxK+4qSbwRpHqYkQ8UjHHCv7dlQSWXFe6tF72uKvsV?=
 =?us-ascii?Q?j5NYrHkPUpcp2E6s2f71CBXQxRM8HschIOgo51ZNmhCau/bFmP7y+kaRpMvk?=
 =?us-ascii?Q?eC+2TZpDEuQNYXDJRiYUusm2n2k3KRRN3SpbcUXVkKYTE37ElULgw6+qXP1D?=
 =?us-ascii?Q?P53chY/QJsCbV7MmBqpYaFUm+wpU49vPJnkEZf2928OUov22Y6CF/3jAM7u+?=
 =?us-ascii?Q?L3l7H7sKO0j7FkCQgHDAg90wvhZSSN2WR2dsXEbc1YCIXSl4aUR5cL965/KQ?=
 =?us-ascii?Q?nrfFqy4jEbwTW5M6889wwjigl7GFzajct+xft6S1gIC/xgqQ/OBOwQPqHJZh?=
 =?us-ascii?Q?BYi+i3mfzdhxesLlj2v58NcxqFvDZjeqHVOKNkDxhQ2EZT4gN1PnoLWcp/M9?=
 =?us-ascii?Q?OubZhyu8ABJBw/F4ROoufFIM+lbSn1vXuVC1xrG/03uiwshaFzlsX56kal6v?=
 =?us-ascii?Q?YEWazlUFxkoChU6KBD6pV7P7CKz58QuRy4PuAPE77d8TY66l4ak/9HBCA/Uw?=
 =?us-ascii?Q?RL0xT379CNyqY0zHLEHTC1yay7dsDeKT8po2KwOGeXTpcKYL4M5URsXiDLLD?=
 =?us-ascii?Q?+n0jEa/wQVaJMPi1RQ9U/D9YYRzLJqcXV6sgd6iKp38COIn92xlzoFmD5kLk?=
 =?us-ascii?Q?1VLLRlFiIzHYg+xwO4gMIY0gnhlxLHr0eETMjGfpUwRwFTOwCKLu2vdk1GUD?=
 =?us-ascii?Q?dfoID/gLlJ3zYXoTgWDPQ67KKzs8riEQDt4exCpVHSMyVIIUgX5fociu8sg0?=
 =?us-ascii?Q?Siu+lTRTfNr9y2eceMzqvthqz+6Di+GQtB4CgzH9EMbgbMf6QTuzvU/Usp76?=
 =?us-ascii?Q?H6V3fTVeH19UOQ6YH3rZO3swVuEfRZnEuKPsrs+jAkKA0JGeXHZOuHStnMPJ?=
 =?us-ascii?Q?zoLdao0yKT/sGpTCp/p/rIpyqRNRDOTGwiHICRNuDk9Kp9DaTsGBs9dXDW+h?=
 =?us-ascii?Q?A8nsX7EzweRRrUsdfyuTAHqAmEPvPLmBFSp05e1QSDthT3+dWfBJU7GT6hCO?=
 =?us-ascii?Q?H32WF2dPBINPsbFBE7muCZK5yKnKX7nqZAxlEHOnY30Q/FIy8XXmB74xlaR3?=
 =?us-ascii?Q?nrCb8LdvZ8Jk5n7pwhbnYIYLUOpC1z9oWf3KhPxVNgRMZtejb36oTvbLorWE?=
 =?us-ascii?Q?DfVa2T0L2819zcxlU0LqIDliEsH/KVK9SPVCX87z1AyDBLwd552u72ra1QJ/?=
 =?us-ascii?Q?I8A0sOtmgD/A1XbPDStiFt0kUjvk4TxZEGVQ9UNnLm6M/L4Wf5MeM/uBdi42?=
 =?us-ascii?Q?O8ghTxERk5WUQztTBchlZfYl5fAo3x0vjvO9IV/fsyC6CQhPw5u37FW4WTF7?=
 =?us-ascii?Q?3SVJLHHgr2TRIFzS/IVYc2SLKYu0XycqdmwZv5y/yMXYN2GRKc+XDvwc7kjV?=
 =?us-ascii?Q?9+8w+qw7EVBb4w1ExEKaOB8yFPv3yz8328eXBqA02F1321f6BXjieQcq7IX1?=
 =?us-ascii?Q?5aYsTCERfKqYC0XCHKf4N+YEXLbnuSb2+958o37L2FPPvjJmKjSifok2YXv6?=
 =?us-ascii?Q?7KYA9W/iOqQ23NVYfI9DRQg0LOb7DQpFbTOiYxYg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd0ae21-1d14-4818-86d1-08dc3fa3972a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:11:42.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/kqAm5x0GhDArMYuhiMNlJHkrxsjnt9znsuyPddXDyQ7v8ooz2MEEqDBsjzEIA2ber1ykfn+YBlAMj2t+29Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9742

On Fri, Mar 08, 2024 at 02:01:29PM -0500, Frank Li wrote:
> On Fri, Mar 08, 2024 at 12:11:03PM -0600, Rob Herring wrote:
> > On Fri, Mar 08, 2024 at 10:30:51AM -0500, Frank Li wrote:
> > > fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> > > have 1 interrupt.
> > > 
> > > Increase max interrupt number to 2 and add restriction for platforms except
> > > i.MX8QXP and i.MX8QM.
> > > 
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../devicetree/bindings/sound/fsl,spdif.yaml        | 21 ++++++++++++++++++++-
> > >  1 file changed, 20 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > index 56f8c0c8afdea..a242f68f99f18 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> > > @@ -31,7 +31,11 @@ properties:
> > >      maxItems: 1
> > >  
> > >    interrupts:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    items:
> > > +      - description: Combined or receive interrupt
> > > +      - description: Transmit interrupt
> > 
> > Test your patches please because this will have warnings. Or, you can 
> > put in *exactly* what I provided because this is not it.
> > 
> > If you continue to just toss crap at us at the rate you are, the DT 
> > maintainers will either just start ignoring your patches or require some 
> > trusted review by another NXP colleague first (offhand, not sure who 
> > that would be which is part of the problem).
> 
> Sorry, I run wrong command to check another dtb file. So have not catch
> this problem.

Strange when I run second time, spdif warning disappeared.

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  CHECK_DTBS=y freescale/imx8dxl-evk.dtb
  DTC_CHK arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: /: fixedregulator@101: 'anyOf' conditional failed, one must be fixed:
	'reg' is a required property
	'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: bus@34000000: clock-cm40-ipg: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], 'clock-frequency': [[132000000]], 'clock-output-names': ['cm40_ipg_clk'], 'phandle': [[15]]} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: intmux@37400000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@591f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@591f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@599f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: serial@5a070000: Unevaluated properties are not allowed ('resets' was unexpected)
	from schema $id: http://devicetree.org/schemas/serial/fsl-lpuart.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a1f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a1f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a9f0000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-controller@5a9f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: bus@5b000000: clock-conn-bch: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], 'clock-frequency': [[400000000]], 'clock-output-names': ['conn_bch_clk']} should not be valid under {'type': 'object'}
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-apbh@5b810000: $nodename:0: 'dma-apbh@5b810000' does not match '^dma-controller(@.*)?$'
	from schema $id: http://devicetree.org/schemas/dma/fsl,mxs-dma.yaml#
/home/lizhi/source/linux-upstream-dts/arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: dma-apbh@5b810000: 'clock-names', 'interrupt-names', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/dma/fsl,mxs-dma.yaml#



> 
> Frank
> 
> > 
> > Rob

