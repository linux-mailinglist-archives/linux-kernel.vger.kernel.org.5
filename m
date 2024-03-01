Return-Path: <linux-kernel+bounces-88631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E486E48D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697D71F267B2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559127002C;
	Fri,  1 Mar 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iX589oPb"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822D3A8F8;
	Fri,  1 Mar 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709307598; cv=fail; b=hvx7raX8GEAEG/tQ1nRBUJMfkq1G89jj+qqs1+NR47FrcRomJtUcB2+kaJBJgKYJ18RdCZCjY74XeCORdo3WJPpF7uidVbJfp0pz3vkToy/wqoYPPEq/ZCOS1nsk6ZPS+zjXywnzELLdgfHk6OO/ETLQc5K8s24bLx/+R5nEw2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709307598; c=relaxed/simple;
	bh=jCtZaSv9Epn+ahW05Qto6qVVp2uFfMJ1YR/QXOszjXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SYqNEDVGqTA5L+MGQ6Tb/BYJKjMH17eva8i0vz9pAq1/E3PFXL4X8fNr9X6K3HpKM43rA1EuJ2+L4m+7vRUp+2gXQCL5rwvlRmuV8BQDVvdho0TFNDaWzf3+mvPfH4YPwHYpllYuzhLEDqEiaRF378QO4/T8NO1tbVlSEzZ2G+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iX589oPb; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwJ1xmrbE0Hn8TnMVXjtM2UEGyiYMLY2aTcQQ8OqKOxroNFwfm/Ig7muDkAJ8dcyuPcI4yZd5iLwStilaxj2VLuvA0gb22eU2ysfLbwXLxpkj6G/zrFXI6JzzovLOEmvt6nU9IpBVED7DXTPIc88EqqVbaeQmwU4iWe+cOwuvxvlbjV1VO1XkC8IVLP5cqeCi0JugTX9UJ0uJqr3bCUz3jvD6sEZTD1l4yWBIpjExhvU6i5DGYfdCORvqh1OjSRtSlJ+RmIVZ1emolhDHotVW32NW0xo44tbPXzRT1H1jCZtkaoGkp73fNQyCuaetHnh2rKWX3KCVR4I4jEO54kd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4wadc/MHs3KN0xNhltzh/PXbuVBhxJwBG1mmUAORtw=;
 b=gGaWN1DpZWNneH1Rd2jK3Zn6RNKSIYuVbsywlidnb9l/xKNwhtuwPt0JOMFSeWQp9EY8l+qwcubqQDVZvwMzRoJZULgqyY5Dtm6UzIQ/jkhGe/EJxzqLgQolfQbtMG5N3BLX1FwtZJNwFQJseY0UtDWa9tzdn2T0QwlcxPpapSVczAl4rYPRhO070PuXKOgmnLqoGOxVOxUaw/2myvFK18nZ0Im+hnc7bovoL/L6fgW4Iz66yFbOcepmx5ACq5i7QucSY6pO03kR8hZ0heJc4ZfhZgT+JnoptoUnmjir8pPMIhuQlJvuwRb3e26DPTDTsPLkvX6QMH2jD3PgH+Cqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4wadc/MHs3KN0xNhltzh/PXbuVBhxJwBG1mmUAORtw=;
 b=iX589oPbzf9n42DNcctc73suISHdrCyQP+/gu359oFq0NXTmn5EQjQLgJFoPdFEvqO4G3/vpGzMdiq3lxoQCOyVok/mWYqTK9+ttDs0mvRGSZyibyuevPE0uIBpqaGJiFpp7AvCt5BBYsV3YymVJfx4pqfLvNw0i63dVXF2AHmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7212.eurprd04.prod.outlook.com (2603:10a6:102:8c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 15:39:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 15:39:53 +0000
Date: Fri, 1 Mar 2024 10:39:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Message-ID: <ZeH2v9WJsX9sLvXb@lizhi-Precision-Tower-5810>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-2-d4d5935fd3aa@nxp.com>
 <3460ecc8-d7d7-4d1c-ad0c-b32efc3b9049@linaro.org>
 <ZeFTqM8o/eozl+MS@lizhi-Precision-Tower-5810>
 <a1861d70-80e2-4f42-b99a-f2b8c8efe042@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1861d70-80e2-4f42-b99a-f2b8c8efe042@linaro.org>
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: dd09c7b8-e992-4ac0-256b-08dc3a05d6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IQoyp9SRmy2VFJmGxUghg29rnhD90LD8LdiUoxRUYVA4AEfHn4VUvjiK8MrAkxsqBzjaPvIQX64sL4rtuaGsdYO/bRwsRCuX34e9Rg+uCbVyl5yszkNnhwaobuKtK9t3UO3n1/FS2VfTnOaT37X/H4y4c5ICiSWgkFKQjAXmDWIwd/k/HyFg2RaM4xfWmfiKNOqog7U2y6AdQWKAq5Ql+FiN6NJs8XUDyXrn0F90xmmi30q1fZapfyiMjM0exGR6vApzJK0I/ptRq0hcptHm5/FTl9RSKpqsWDYoXsGlJdVQHx4mJiw6wxJL4//SR1/aeVjqTWHKYUwjq4yFdBF4KGtsLwV7bl7MhoPHMfo6E6oZfmPHqr8Gczg0DuEAVcbr+g4xmfSwljaWdKgoQAHJrPzj4ZeTAZVDeOz5hPJ+NMxpHbCtHwRM/etPrXEZ4PfC4YD3XbgWf3Bh4w+8fOQnSUvr458wsKWA8PU6lb9+3r5AEOm4K5HWy2oydK38UBJXInAL6Orni48cjORhsa17M03sqvorIzDp3UXnMfM4B7W0vRbSut3ukIxCEsUPRrj4NJv+f2e41PAOvDrqCohWrStX3COo/Ql2OTFpovdVtZ0prqRmFYHz5M6T5EDAvzDbL4DbeTZSrudYS0kt5JUh8SaMejlgSJGzzm2MvbuHe9R8osAg+RunN+rWC3Zvg41bdlzeCw4E4mojrv+7ZShy20WtJ5tD/zWa+C83r2GWWL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4gNfpS4H1yAK92y+WsJyVbF45Kbs0+lAILByy9o009Ecm7Du7naCVjAT9GIh?=
 =?us-ascii?Q?TzxXRQeIlyAnIC+PZErIQfttAhz24IkybE3T0cYbb7cmlFtjHNFFfYKCnVy3?=
 =?us-ascii?Q?nKM4Jj0GRlu8KO3XpnvuP9XRxCWouoolQEBXG7sT3vswXSwFiktfSah3/trH?=
 =?us-ascii?Q?bhX05rJRqUFIyCbPZDh3vdGuYOTWJ5M0NVx2oSoLMkbteOkYz8N9RtlWCktd?=
 =?us-ascii?Q?dobkfE83i+NB8497CXbvLajQlADVqynVYiqBWEduUWvsLJyszwc9qumzJKv1?=
 =?us-ascii?Q?cmSYGuwSWHadsv6NbnrRTB7MevMgJGb0D6g7pzPgETH7qgy3IAEFCvWDRh7+?=
 =?us-ascii?Q?ITHkwmfUWpUKxKiHpXWCvadKTpKqVC5rfs4helldq/28GoBO1O1ja584n1Ui?=
 =?us-ascii?Q?6KLV6jL1w8SWTlhrEL7zAYl7XWdFcpsE3vDIhTWzIDsg/1KxvRn7Mi6F+Ad9?=
 =?us-ascii?Q?zMey1SHnPh5ekfFN/fx7bj2l/XZYEE+tNeXndHoTjddc0uiXCOaGYt2LngXh?=
 =?us-ascii?Q?TU/o9h96WxAngDAtH1JhzKedkIiYZ90JEhxZDWWN+IGxYTnKsup1SqytrkJ0?=
 =?us-ascii?Q?JtA032/VagLu8clSs2j3rmW9Z7n0CB4SFa68YiDJtcKRnlorlshAm1lpeZaL?=
 =?us-ascii?Q?qgvv5ILpmr/h7tcfiCsa+ZddYm5sJL57xjdp9Hbebd0Fi1naYrJszjRbvw3m?=
 =?us-ascii?Q?h3div+yW3YLIZgCOZ1cUoM8EHOX7YiuhznbucknzD1gj61EdnZeeOMm1SHRa?=
 =?us-ascii?Q?jSTNGXjsNw/rM3xI2QOI7GyxqWMeCy0RMd1Vn2Xpcfi1da5A4n6RvpUDJT3L?=
 =?us-ascii?Q?Om2jdU7h6qsErGht9V47uH9xdy4xAv9LVy6I+zK33ajWpb4bxyNs9qWC7TZ9?=
 =?us-ascii?Q?vqng42i0d4PwMX7kCcrE4WLV7L2CLJDzj3Es3Yi6xulThiZEoCvX4EraxMxn?=
 =?us-ascii?Q?75nKNXVob51+Yi91+SoBu4+B/l4ZWy1DbVKZSAShz/qW+FslFyhn8xsSVcKE?=
 =?us-ascii?Q?D/sFtQO4JdnWqst8WyjyLTdBEFdoLTQ83q7USr4wSVFTgq2F79O9/jKGVPXT?=
 =?us-ascii?Q?yIFfjw2adJ9y5I5emRUfSDP6JpeNWOrKaqPcp/gM7B8Qqd0FneCRS9qqyLuN?=
 =?us-ascii?Q?ri4pOmBCNQhJH5VyexalBIthZ068z/rfuh7s8nLCqCy4pBHCdGPSP2mMWZcm?=
 =?us-ascii?Q?SF0fOzIYy3SQaE4KAtN/o4NcoA4CMcu3VHy8IPHoX3pXjjb/Xs0TStDoH3h3?=
 =?us-ascii?Q?Y+bMmANWbqXgC1C7PPokoRMhLRjWtfsq4uDY3DeMCGg3rQpVh4cwaWt1F5xd?=
 =?us-ascii?Q?RloQCAokcEEU4MpytO/UqIBO+Vo7N69DZSyFYhUgQU0wfQbTyen1DrQ8nErD?=
 =?us-ascii?Q?JfovRKyAg4PtYlIltzYk2T8cDQPuVMkK41PMsON1qh8OR0+jp7eMFV5Wlm+G?=
 =?us-ascii?Q?AfQu15w6zTz3NVrB2aPucOE2adw5c/7Jx4U6MdFBjnsGCb5ecF1nHg5TbU/N?=
 =?us-ascii?Q?qzF43TaRUHwxA4Sf5ySJ08kAM5GL11zHomiPZFS0PYX/WCDZNxoaCFZZErgz?=
 =?us-ascii?Q?v9yLMgWZxyr4aPaytYA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd09c7b8-e992-4ac0-256b-08dc3a05d6f4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:39:53.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vy/3E+PgHtLHaYoi2U1W8osDpJQfb06bLawCEXSq9uTcBb9UsBhPX6zL+jQSPu26eHjxywAc7suOyS+OUy7xRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7212

On Fri, Mar 01, 2024 at 07:30:45AM +0100, Krzysztof Kozlowski wrote:
> On 01/03/2024 05:03, Frank Li wrote:
> > On Thu, Feb 29, 2024 at 10:44:42AM +0100, Krzysztof Kozlowski wrote:
> >> On 28/02/2024 20:14, Frank Li wrote:
> >>> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
> >>> have 1 interrupt.
> >>>
> >>> Increase max interrupt number to 2 and add restriction for platforms except
> >>> i.MX8QXP and i.MX8QM.
> >>>
> >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>>  .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
> >>>  1 file changed, 19 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> >>> index 82430f1d5e5a2..785f7997eea82 100644
> >>> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> >>> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> >>> @@ -31,7 +31,8 @@ properties:
> >>>      maxItems: 1
> >>>  
> >>>    interrupts:
> >>> -    maxItems: 1
> >>> +    minItems: 1
> >>> +    maxItems: 2
> >>>  
> >>>    dmas:
> >>>      items:
> >>> @@ -100,6 +101,23 @@ required:
> >>>  
> >>>  additionalProperties: false
> >>>  
> >>> +allOf:
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          enum:
> >>> +            - fsl,imx35-spdif
> >>> +            - fsl,vf610-spdif
> >>> +            - fsl,imx6sx-spdif
> >>> +            - fsl,imx8mq-spdif
> >>> +            - fsl,imx8mm-spdif
> >>> +            - fsl,imx8mn-spdif
> >>> +            - fsl,imx8ulp-spdif
> >>> +    then:
> >>> +      properties:
> >>> +        interrupts:
> >>> +          maxItems: 1
> >>
> >> else:
> >> minItems: 2
> > 
> > I think needn't 'else' here. Top have set to maxItems is 2. 
> 
> So explain why one item is correct here.

Top interrupt: maxItems: 2. That's means all compatible string (include
imx8qxp, and imx8qm) required interrrupt number less than 2.

other compatible string (except imx8qxp and imx8qm) already listed in
'enum', have additional requirement <= 1, which match original requirement.

simple said:

set[all] <=2
set[fsl,imx35-spdif...] <= 1

So it is the same as

set [all] <= 2
set [fsl,imx35-spdif..] <=1
set [qxp, qm] <= 2

> 
> 
> Best regards,
> Krzysztof
> 

