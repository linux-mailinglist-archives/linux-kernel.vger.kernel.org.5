Return-Path: <linux-kernel+bounces-37462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C647183B062
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769DC2854E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D76212BF14;
	Wed, 24 Jan 2024 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J8Z3DOmk"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0E129A75;
	Wed, 24 Jan 2024 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118448; cv=fail; b=nGZ48EZWW6U4vJYJfXgpCYL+CCGSWmn3mQuoPYDutrNWF0ixoXi0SsD5u551LrNQzcUa89GutyvtuB+w7njGYyX3ESNI+H/oDJILh1Z72ltssqLTW4wAa/i1KWTh0MDCansy0kYjOr4htTxJt3NipVcXYPowYh+MJW56pE3xUFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118448; c=relaxed/simple;
	bh=CecXqqUQNUztXbgS/sQnGwa1/ONJnh+EFDVoYaKv9Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KRrdyjFLmn6xJWeGKQzmDkMheRojSxiSMMUgqNnu6Z6NBSJLeTpWBr3CVYC4Ozuqipe5MbYxNXkswdItpfWQZmiMZWjn9PGTACRLX+picK9TDJmikcZYfTAfOTf36mZl4dJU29ekiHjp101dcQyCKunp3QCJZIQPDqlVJLlXhlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J8Z3DOmk; arc=fail smtp.client-ip=40.107.6.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz5GrN13zvvZa8wJn1hH5Ma3b4ldDJSwMRVRv3DJX+1DZY2DvMRzOvPr/DP1wyCaJuWjsuCrUjTcdTWsgyIeBML85jBqNSjgnwMRLiTpgWnjvEFiWTvoZD04WxjChvDIsm2Pw7NGlZSEyQZ/aJAAtiFoLUDoku8tuFstqezOiDFCmfYwyHTAhTOT5OQPI4yyMcKwokPHmI0yGw0t7jvPqeWis8lHbWDWHTfNy0vi7wHri2v/oG6/v8awtC4B2wBRonBP+E29jl0QPHjzdwERfG3XNn3claacVtAeezsMH9/1kK0KAB8D/wowdj4a+PhM4CJuhz9BJmCW1ganWgnHEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4z8tJ3R9qttqMdfJs0s9kQTDnXv5kOfYx6SDR7F8gY=;
 b=XgP5p5q0MtdggjPsoc5b3wQoEB5QhWTEwUX6Pge6k9wIgNQ477rchb5tzNUZGARAOgiPax0EoFgYxp/Tg9TzcdF4ovxQiXqOLQ8k7H0icnhbslY7Oe52HmIyv2RNfbT30VAEgivUNrsd4GoeyVgD/oe8LBJRKCyVciIAw/Dj/UUmgxDeCedwP9I2d+qxPr0bF0bTsB8S3A4oO9hEG2/rfj7/H935PZHV1rDRSl07atyzqomApzqhvLQ8YS3nmglCMTnT3JSXSOSF3lFOHJUXA/mJB86a/i4Te2tC8IK4vFWWl3gTk2GojC42YfrRXgzBX5HiVeuq76Qb9uyUPvgJkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4z8tJ3R9qttqMdfJs0s9kQTDnXv5kOfYx6SDR7F8gY=;
 b=J8Z3DOmke2cPSUaM5CgQn0kj8lIt1/7mAbrAu06UxUc90u+GDhqVIkroHkxfeeg8AOhD8r7I6HxhsNwLtsMBLnvkVmiZtyFkU1Yo5fGv1m0Giwx5kpV/uT6ksLBejNHzXY/fmyv0w3f3M51cdHC/CMBdiISB32OCEQ4gfoFP7Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Wed, 24 Jan
 2024 17:47:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 17:47:23 +0000
Date: Wed, 24 Jan 2024 12:47:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: ran.wang_1@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, mark.rutland@arm.com,
	pku.leo@gmail.com, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Message-ID: <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124-unclothed-dodgy-c78b1fffa752@spud>
X-ClientProxiedBy: BYAPR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: bba188a5-e27d-4d4e-15ab-08dc1d0484f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0TBqwmJiOKbIjPTLueNmnPcgRlFptYaILIk97sVQvruI9gjsQz2EM1GpWimHfdHfe237gfu9FwMa3h5Zp3CM+evDIRMWb29edtFEoHdmCXGFSQD0VA8T9EBYTlylujbDX4Bmvs+FOqxH851ro1qj5hRrsPpy82sSOQ9lYyHWPgpmuu7rV8o7qgOg7wzs+63RDHqXzOkppG/dwqfhivKCn/c/KhfajzUZuXvhmQWI0ebEwoSUG+mcOunvg+Zyij5PwdcWT+ZFPraNZJe60wjlEx1rL/0cXBhH+JG/PMDSGti+sTkWcsPKU0i+VwASR+bd8N+KIQc35cjv+CcK0rW3BhWgsboEcTHkGwENk2LMq+WOptgw+rSKC77Ayfx0cMQ0ZD6l2eW6fGGGKOJ9FFgAWFQV/nNGO50y8WY4FpLpapxrRN/wZvXVhysRk9VFMZBRBphrL+7AB6g3OAPqtpoMLLuLiClLZoeCFR2m+DCrz/D/PL60jpc9K13m7JfIgGM9vhT4DX89dDNfEbWWDzAI3XuQP3yHPJv62xg+SRqDh8kLbT7rawM69FcXQnRY3cs/GPIWj5I4ynUStncC9QlboE1p7jCq+pjZLrgqqpkw+2flKLPOs2O7SmA8c4dpMFholZAsAHinN+K8W1PmoSThQksMRf0Nd+0VeqjwFzXwv3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(86362001)(38350700005)(41300700001)(8676002)(33716001)(52116002)(38100700002)(6512007)(4326008)(26005)(9686003)(6506007)(6666004)(316002)(6916009)(66946007)(66556008)(54906003)(2906002)(7416002)(5660300002)(66476007)(478600001)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BlMF7gC2WhEpXpwPydN2yea4KxtsXkDCFcIl/ZQH4KhZ3de5NJka6OvAzbnh?=
 =?us-ascii?Q?OFWTgxQlIePqhHSOqRVoYD3R7WKOAjLu95SpF592bLXueqmapCD6fdXjvfzd?=
 =?us-ascii?Q?GUpOSLjU2wnh1XohLfYx1uKPxlU0NpPLJ5WAHMOwWceg0GAbkrs3Nr44NhVq?=
 =?us-ascii?Q?UxVzNCNaxhrxZCTevG1FdMcSKL+VjFwlHq3gr2WJOwYK6QI0GjfvyJqF5QEh?=
 =?us-ascii?Q?uPg1BtXZR0Mp3KAcCbWqdAuv1cO5i0OkuqjkVG5uAQNRW1Qh5CauMvqpBRqW?=
 =?us-ascii?Q?aa2Z2l/S5h77KxBld7QmlQ0LtpIuEKJVF6NrcjHyHm/tUviyDeIBhYSsVoId?=
 =?us-ascii?Q?inGrh553VTZgrLLxO9rWaPOpIPYkDyf1U3dMDkiaZmM2DnAGU679acEarttC?=
 =?us-ascii?Q?Fv69LO0Gi1ul2xqU2VfFhTMXwRVns/xOZm0FutO9l2jL9roZTByfpZwjytcG?=
 =?us-ascii?Q?z+vpGHq6r9pO67tCqBXey4YBgaYs8UWjaVCDEHMdaikWbn92NfrIEFug9Wbd?=
 =?us-ascii?Q?vw4gYSo+KgMZkat8LGxGfLTzc06sK+/nTmWzrvHn+Bnh+9CNuN51kQyCiPHC?=
 =?us-ascii?Q?e9Z++37akXsBHddaaXVDb2+9N67HKdYn6eUrUAVhJF7BDD+SqsUoNE0CZkF5?=
 =?us-ascii?Q?tv6gcoIx9XtQHDgEp7klqhn1y7qQQ/UoH72c7r8TIHVhnmbMeKehOdmrdEQT?=
 =?us-ascii?Q?v/i+KiuHrH7zFhROpnlVMon+kSeXLK5t03QoVknw6giZnTkGE9ixVAFnCXdz?=
 =?us-ascii?Q?jYcd8isr7w7tycXGxwUE41tPhGp3Mqhrtlu9kmx3KKv2MIAm0fZauG44M+me?=
 =?us-ascii?Q?801NoJJ6f5m8iGR7krPIfENDVwC5BVgkO0o8OI4jXYV/BWy890BvbUL76EOS?=
 =?us-ascii?Q?JIt+pbBRgm3si5WlEghs+Ec6xbFdcbIN9QNVYku4XqV2lC7sb96/b2/gbXBd?=
 =?us-ascii?Q?hazGgtu6l/7N1oAHhgtiSyLohs6rSAn2SFjFwz3cbRodMBfXiA1X7DK2SNKu?=
 =?us-ascii?Q?RkDvp1YP2gdkaa8dkclkR+zTJlxSq1AFpuMANTweTWYA8adR0he0jj7KYG4y?=
 =?us-ascii?Q?LaBMoO9S6QjEew0bS1ng+sV4wxDR4tAuKODo3UwVXcghm52d2EG14BZPyiJC?=
 =?us-ascii?Q?JvHl38aV1sCzj3VpL8O0O3kf6YKmAHcZIEgZ23WXZJnFopuv308ajVUoJgfx?=
 =?us-ascii?Q?cnJErOk6yQPHrtA9+mjPz+lzOeAuxGAedUsBWehpss71MCR9CPopcIz8kEoS?=
 =?us-ascii?Q?ZRw8W9raGJAtyEocPMFdxuoay1P35OWzNkHeAw4sH+pXvsm3SDgiXL3/KUKt?=
 =?us-ascii?Q?OpLnGcrIqhb4PbeLaujmE4TlCSbLKqfakDSfYUWC2jnoN5R9dvItUj6D4DE2?=
 =?us-ascii?Q?akoyGXf0iI9gKhu5kBLH+DO7YNUrWLGt7DfK2FtSVFEjH3hBLPrDEKSkwXBA?=
 =?us-ascii?Q?lgEho3sZ6ZwGxtK07x3nnCgdXumIoiiNgSZRNk168um83rRFGjnqq3nZ6hxh?=
 =?us-ascii?Q?iAQ0FBKMu/JKRRvlKPqGOJM+Z18f1uEdvGO9vyxLtnsd2N6mWiPg4BtS02rr?=
 =?us-ascii?Q?ErHHIha1L2+9U95Rc6Z79Kf7OeRL09PUIRAfiQcm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba188a5-e27d-4d4e-15ab-08dc1d0484f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:47:22.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3LXhktswaGu7+MHocOKvGV4Y/pypSpcY2uUwrAaY0EKThScOXlsbO8f6tp0oV1r9VxkqiFKDZXLKxb/ItrKLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367

On Wed, Jan 24, 2024 at 05:36:42PM +0000, Conor Dooley wrote:
> On Fri, Jan 19, 2024 at 04:31:28PM -0500, Frank Li wrote:
> > From: Ran Wang <ran.wang_1@nxp.com>
> > 
> > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > (or its control signal) will turn on immediately on related Root Hub
> > ports. Then the VBUS will be de-asserted for a little while during xhci
> > reset (conducted by xhci driver) for a little while and back to normal.
> > 
> > This VBUS glitch might cause some USB devices emuration fail if kernel
> > boot with them connected. One SW workaround which can fix this is to
> > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > host mode in DWC3 driver(per signal measurement result, it will be too
> > late to do it in xhci-plat.c or xhci.c).
> > 
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > Reviewed-by: Peter Chen <peter.chen@nxp.com>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > index 203a1eb66691f..dbf272b76e0b5 100644
> > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > @@ -273,6 +273,13 @@ properties:
> >        with an external supply.
> >      type: boolean
> >  
> > +  snps,host-vbus-glitches:
> > +    description:
> > +      When set, power off all Root Hub ports immediately after
> > +      setting host mode to avoid vbus (negative) glitch happen in later
> > +      xhci reset. And the vbus will back to 5V automatically when reset done.
> > +    type: boolean
> 
> Why do we want to have a property for this at all? The commit message
> seems to describe a problem that's limited to specific configurations
> and appears to be somethng the driver should do unconditionally.
> 
> Could you explain why this cannot be done unconditionally please?

It depends on board design, not all system vbus can be controller by root
hub port. If it is always on, it will not trigger this issue.

Frank

> 
> Thanks,
> Conor.
> 
> > +
> >    snps,is-utmi-l1-suspend:
> >      description:
> >        True when DWC3 asserts output signal utmi_l1_suspend_n, false when
> > -- 
> > 2.34.1
> > 



