Return-Path: <linux-kernel+bounces-153721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB778AD212
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C332822CC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1150153BE5;
	Mon, 22 Apr 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hk5FF6rk"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1246A039;
	Mon, 22 Apr 2024 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803904; cv=fail; b=GmMHMtD1Bg+RFiGxFeGmlLBWbF2uAGFt606o3K2OXWn2TiLwGE/1+uoPewXeF6AJe+xu7h8yx9eEeRzbEM006FbSES1cv9BAcRDM+0MdzvDwijAfNVlSAMJog3t24eWuvMN9Fw2zBfIpg1CiDNAvA9tvTkaBDKtAnbNngIlt7gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803904; c=relaxed/simple;
	bh=P2esAXPYOWl++TH+UQnFXNHPrl+PTqKKQ2Tu66v0xHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kx5OjWL+G6sg1WvYZoW7KWhKyiVmcx9Bk6RjGf+0Xpz7y4iA0SeGtrColmlCRxLn6MQ4zwL2U+hCUBdsNR/Csvnil6oUcmn2B2SMtppUcXwv0dayjASSO5yBa4IESZFYhKg268+gNrrH6RW13R0kGPMfQQLGH/Nn50JZT1sTvpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hk5FF6rk; arc=fail smtp.client-ip=40.107.247.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm4sast0I1wdHIzHsRdk20gJwsGNifaMIaNqQsDShk+gi+b6Vl7PHbucN4fL9ctE+hOYqxubVH+DsFRzOIdxcV6adZAM4C34yHlj4y0vNZu2wzlSlMG/d1cH+hbm4fPxbSifXJCPm+6n9NBAJQ55UDXdtDzt1Gq7F2/QDtZdbK1ZbQcZm8gfPzCAZdu8keIjtPs/cTaQyJ2oWyPueRrev9csbFzGx3SnFG6tQ9JWu6UwlTUKRdNVKft2Pq9PaMoOHNPAMWKNpFDvRE0GoABAwxWAJnpUd/H31vxeBiOIgSAXUBt+9zl0meqSQAXb4zdCO2kE2Irqyh1s+Lvq7hdLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/CM+/yQ5uHP99ZcwZPWGH2FUmEjqJK23ACTd2HjkJo=;
 b=GDXQ4CcOQua7uMdBQkc3ULS2hh7Lsanmb61MQdZuvV1/fVhRajNjk5IWdFaHtmQaMfk28L6AvbQpvc2QH082HDIT5AamR5kY3xSkxoyYFIt2pIO2O/YLVd4tCYTtk0FCGd/xqpdlMNZ4Ti/ch9yNN31dBHccDhWOfWShBxxZxSfwjY9eM1tXCjXWyR1bs77yEvqj3/HAm7WDbvd1kdtJ178bswcgfTcmrtkO2TEjPSg/idzJhg0XgZlEO9NxxHGdB4giREektvhpJismLNr8zwVntoAyBFsckV8lw//NewNKT7RDreO7jKjwHhwjfWldX9IsWM2C8uVTIqkBc/AClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/CM+/yQ5uHP99ZcwZPWGH2FUmEjqJK23ACTd2HjkJo=;
 b=hk5FF6rkseAQVurG4lk43TRMDwg48ptBrJFbF2zymVckNoIULTEgkNBrIoyTZkGUr6k0I//y9uv3Di5nLgvN+fGAjPbC0oZvHzQ+TocwiFApd5lh1x4y3zoeER/C4LatrsO53K7chercVbeIwrPgA9u4Dk5mzyuqZAU0Bb5qdcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 16:38:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 16:38:18 +0000
Date: Mon, 22 Apr 2024 12:38:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: interrupt-controller: fsl,irqsteer:
 Add imx8qxp support
Message-ID: <ZiaScfP5Ep81cPXJ@lizhi-Precision-Tower-5810>
References: <20240422064949.70778-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422064949.70778-1-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7de62c-44de-4d1d-e36e-08dc62ea9d73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n1OqpqNYK9+n9Kkd4WCpSYyQdEYhlrNcxLJlNj6y955HkNIsbceirnR/gHbN?=
 =?us-ascii?Q?5HJohXdOtjThm8hujn797T4EIhNmcnhq1lr8A4uIT23yyOKVm6q+s0tV3h4N?=
 =?us-ascii?Q?aouxDN0woz8ufCXn2Mb9X1vsGYr8HnYOdFB4gezCSqCRDc6lMsTEpw32dqP3?=
 =?us-ascii?Q?zvqan3HglR1W+iTU8mT8TnaWcu4NOGYiJgO4tTfjP6TioIbyb8TJ72m+Vck/?=
 =?us-ascii?Q?J/NcEIfxElGQT9WFrDvYabN9YnPH7ZcNeHZpM+Y6r9lKiCxn5sWZcDqEX8L5?=
 =?us-ascii?Q?EI1Mbpr+D2pKuEen7qAIcP2XCc358ZTRHRLDMIMS6feOF0FHvsZkEbFRwGaZ?=
 =?us-ascii?Q?Z44NVHPlxsaLt7g+6D/UTH91j51Ws57z5CQs2z7WxU6TwqOxtvk7WdQ9LUcB?=
 =?us-ascii?Q?lERJ5+EDLjxyzJ50Hkf8Y3gN9RqwdvWvwx8lAV3MhtgUFC2jL5pElIYwc6yw?=
 =?us-ascii?Q?jC5q60twdKeA9ogaQWhLGEEksuEZ3+zz/mqJ3gvMS5mLnaFy1YZ4d9wB7bey?=
 =?us-ascii?Q?llpr1gLUe7tbrUozhpX+m58u0k7IaLXfS9uiCT1O0o9E7iq7UPquUhn2LI79?=
 =?us-ascii?Q?ZRsyyadqfI0OKX97qfwVFuOHxCg86Zb1awula2QpWAEQJYrpA7DdHSSID0wF?=
 =?us-ascii?Q?f5Oi1SVItlB0Jhgi7NJcMcA9Ly3aW9JxI2uRQm4bUgNbZawvMMyJOVfgOcLN?=
 =?us-ascii?Q?FGa+4p69/J87ze1ZcY9H4eppXD/hoGKcZNiUcJFPCacD0yUVI5Rrm6N5cWX/?=
 =?us-ascii?Q?bSpPKh8vpR3qdXvadmjCJ3FxkhawaTnxYqyx2svMre8p7zLcYUbrcHK1P6o+?=
 =?us-ascii?Q?AuLL3z5/R/L7UKlboE8a4bFOVJkx14eLYKVwv0EBtw7EcE0aYDXy5v3xKP/E?=
 =?us-ascii?Q?HfLaw7xIvyg8kJm8uj8jKqozyLXbzaPWzb+vt05iLUmwtb+ZW/eovfR92yry?=
 =?us-ascii?Q?c+KCWsDLR3h1nZzySKmfMXSQvSYYSpkgto6EMSy2nKPcOQBpbKEEmzUieUwB?=
 =?us-ascii?Q?fhP7HSa0EoUEcIQmvjwVH41l7Q6X13iMxoexpxpb72EUMkvdR6LtCf78agrd?=
 =?us-ascii?Q?YYoAUaMGZnXliZdDIA0ozS/OMpbYj53c98dwHk9V0x+6oKU3/EJu4NSZyc/s?=
 =?us-ascii?Q?tDFcoJSe4h44hVpEPREFbMbASJvEFZGy6evSw8ymLQKNfg8NMSAFcgHoc5kb?=
 =?us-ascii?Q?59Pg4B8fjMI1vMa/DPe5qXD8inv27dzAN6DsbHN9atwaIf8Hzs39PvZlaNOp?=
 =?us-ascii?Q?L9lqymMDNDN9t2Pn/Emw/Nl7Ln/5MZB8/GpI3HVB8ENyTky8BN+vxUlG4f8i?=
 =?us-ascii?Q?9qfuiehd5xUAI0S4LhhIVdUymlSd5zAI6hjdf0cW6z2WEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vw+m49O8I7lBYUCZzFjGcotq0Wz6xJBlLoZ12Qnps2o6O58a13JkA2yKXZeM?=
 =?us-ascii?Q?vXWtg0f6SSNpLO5BBuM/mthKbHts4A/fcKmT2GLYS+PtEf5j1HmRoobxZhX6?=
 =?us-ascii?Q?+kx+V1KJab0EWWtjxBG8xSmzuB0atFVhYa8Yj5jPd3fa91v7pa5MKhqRYCdq?=
 =?us-ascii?Q?l84FKmqaw4bAEcdnjP8r0pZusp96kQD47u5UueHosrHssxfWtrcOyXYuFOP/?=
 =?us-ascii?Q?zLNdkiDo6/gyBkaJWuU+pKdrXzwmRU2wcxtGagN/5Sw/KepijUrcI2j/S5yq?=
 =?us-ascii?Q?q4/2r5riyh9Dh+iXmr8OtwlPIUL8CVHM3xlKMX7Rb7iB70wMoqI07Jv56A3u?=
 =?us-ascii?Q?inuUBNKAOAIQLOsm3BrdbnVLJYy8/r1HBoNKgFj7iMPhTuqesZSsLGT20owU?=
 =?us-ascii?Q?qrMetPnwc/Bn1MZ89cNaRfJmJTa7ZW9ccB0B753N1B1UAwnjlg1hALEwkpvK?=
 =?us-ascii?Q?NMBOFd1fynJ4eabxj5T8uI9wakjN0nMj8dmygakBdhbHgGAawg/YKJHo2R0b?=
 =?us-ascii?Q?0N7BDBugrvv63bjAwBMPojhBXFzuaHwNm4DNwcd07cHP3MAFxSnhhkY6O606?=
 =?us-ascii?Q?RCNhp18ckidkS1YNfJGkyctdzKaoWGIbgbaI6Q+m6vy5lgdLSEcpvuP6zkZg?=
 =?us-ascii?Q?yTHxCdqAqTKujOZjIIMDhZrD3J1ube7CTIr2Pjp83GuMjuEy9VQ7qWPNSY0E?=
 =?us-ascii?Q?23W2Ojz9PIkTzcQhrJhUpwRFpJwoWXs3NTiedaCX8ahG03l3Q4KdvjqlxJTB?=
 =?us-ascii?Q?eSBmL/tSlUqIQkS2ePR5YfbGdBUrisl12MKjOB5xg6+I+BxXq58jpoKbZqfp?=
 =?us-ascii?Q?IAmAV/aeeDcgHKKjWEnvppSN1PLPla84f715DhT3d9AFitfRU1gbO7TyPjYd?=
 =?us-ascii?Q?EzIooa07Z1oWrK3tevsScfsoEYr9xlzKzW21ceKUJvuYpQwf2wVMRqIUEofI?=
 =?us-ascii?Q?xDUeYB6BfVxJAwF5tjaRm4fVGXspbxduTUwDq33y8Glp00NQ1RReKdK7wBMA?=
 =?us-ascii?Q?HTMwrQ9uWlgymw1T0Mh52enUWo79lMVXLDmdlQGIDDj6AAkGkmhRgR4YEpxE?=
 =?us-ascii?Q?jIbHNr0dL7JjvbYjT8YwmC9GNwNX0dPxL/GBlbM1m1Td6l2V14g9wOOmj3gh?=
 =?us-ascii?Q?muC6rp0N6rGbc98zNKnKTQ+2sCGbSJGJmcsgYBNM/HyuhN2YQLBj7aZM6Y+K?=
 =?us-ascii?Q?l4QphDVtIuAA0TdtZTCd/PzQLs6n7hMWnAz3wSJ0kejCz+8hFzu8C47pkIq3?=
 =?us-ascii?Q?uOr5poq6PRUbhBBSjKW2C9Op7t0URCZ9JZAO7AmLEw8ce6mQ8nawA2+IBI3B?=
 =?us-ascii?Q?ROlzpzcQ/FO8BFl9epSy2JwvwZ6C2J2h2g0xIx/gCIcVju+TiHI7ebdvJBHQ?=
 =?us-ascii?Q?Wy3NY5eQgb2K4Gw1ZaKHKGLnRyl0PC4pgJ08LvCPmk4gzfZJs6XD+sfPDuR7?=
 =?us-ascii?Q?UQhiw1RI5LfrsHllDPEqXl5Ttu4Nr29kxXHWvlwz0oIKKIqt7YLCOUlGa91A?=
 =?us-ascii?Q?DKCkyeID3DHy3zsdGto+fUjf8ukRK/qXKhJ5rlaVYnSss/PzPpJk4PRg9EN6?=
 =?us-ascii?Q?uT80E7ZF6T1owqKbHb8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7de62c-44de-4d1d-e36e-08dc62ea9d73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 16:38:18.5130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BExBymzA7V5TWBwq6NUmpf5k2EnEczOd6quHFifjHhSPtS6Gw+ugYIWzEc0aFnrXScdv6IthaFOQaMuVurmbsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885

On Mon, Apr 22, 2024 at 08:49:49AM +0200, Alexander Stein wrote:
> Some SoC like i.MX8QXP use a power-domain for this IP. Add a SoC-specific
> compatible, which also requires a power-domain.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Next time, please cc imx@lists.linux.dev

Frank

> Thanks for the feedback.
> 
> Changes in v3:
> * Move 'allOf' before 'additionalProperties'
> * Remove superfluous 'minItems: 1'
> 
>  .../interrupt-controller/fsl,irqsteer.yaml      | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
> index 20ad4ad82ad64..3d33b75d6ecfa 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
> @@ -14,7 +14,9 @@ properties:
>      oneOf:
>        - const: fsl,imx-irqsteer
>        - items:
> -          - const: fsl,imx8m-irqsteer
> +          - enum:
> +              - fsl,imx8m-irqsteer
> +              - fsl,imx8qxp-irqsteer
>            - const: fsl,imx-irqsteer
>  
>    reg:
> @@ -42,6 +44,9 @@ properties:
>    clock-names:
>      const: ipg
>  
> +  power-domains:
> +    maxItems: 1
> +
>    interrupt-controller: true
>  
>    "#interrupt-cells":
> @@ -70,6 +75,16 @@ required:
>    - fsl,channel
>    - fsl,num-irqs
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,imx8qxp-irqsteer
> +    then:
> +      required:
> +        - power-domains
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

