Return-Path: <linux-kernel+bounces-131541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBE8898954
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA2A1F2253A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B71292F2;
	Thu,  4 Apr 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QiHpgWtE"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2094.outbound.protection.outlook.com [40.107.103.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58C128830;
	Thu,  4 Apr 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238896; cv=fail; b=rHcKPKK8iXX6hNJa80kphqnVs16vStseokSZw7nt3dp+Mz9FdlZchRT1AEqvxZ+eCvupc5irj13ZYy4jf21mdTl/Y5/aHNbiWDIiPyWIOgp+GaOGk07pWYOTMdcSbXJELCLhWmY44Aj6GpyQTkWC1c1EwbHRo0Gf1ulSfBZVVnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238896; c=relaxed/simple;
	bh=CQHSOeFW9ClE84V7FuoO011bDx6xpQ2Jv5OlCVLGr0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OgKvwoAQMMmnckAtXaRSo1ALJVuKSqtF5UxfoWDSpklt8JCsHkI2bEG5WO6KY0DMpfszRiZ3TFnQQ3GB6/KTBfDHqFCvH7qwqfpNXwjoRPiyG3402dbg5LbLADl4QC8DQha7WAq5gnx5MYCPbf2Hoj1cJ0xtqcJftL3xvI572aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QiHpgWtE; arc=fail smtp.client-ip=40.107.103.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdzxCLErrFQl2hGQO/cxnd0yTw/OpPGG0y5WYXeQkjLUKW4bfdxESGGpwtvqsGnMVSZAK6rYqd9PCQ2VGCPaXXeoQy9PfyucT/xFVDkw2KAP3DkmWf4ElIyT2jyctOb2TwcrYkfZ9Cupq23ZVpWS2vTu2GjfAmXVDS/ZBWR/Y+jD7hx10AVnpMcc0uflhlaZnLcW5R1AxUSPYfWa77WA2kCJF7LT3rfvCZrx4hTdyriBOHULxmIAtm6f2qHXyf7aaGozbF8MpTvSVFTR518yiyA62+RZoXTES0yd+xfyaBdt36PVm7SPLn3bVj+ES9OYwwNSoCtbTrMVfEVrE8V7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1O4B8tRQhG9ej7pk4ZWHbQDGftm00ZDJfKtFl2elmo=;
 b=ELL4rKeJL38am0Wj7sZY9QRrOG3+poNx3zllllYQEaJJ6Xd51QWaHfz70TiE5BNYQQxD7wAssU+QsUHg6nf+sgOvDRIFcU1wtf77BDvDYKeNYUWKQxp2nEXofiSozm7y/pn8v4YKpevAVEtZuao1Jg1JjzDkpb51DDbiPeSdDilAUpS5sHRcifSefdMrwC/+IzdOBU+s7n9YqJQ3UMP+0qAPfzQ+lswnmAsOXPfclKVC8TAwCNUWsBwL1UAUZq0htngv+PrBkMdKRCjt6dK0ojqQr3v9Jqnw2G1JyQksThk+UWob5zIkvIuEk7aWV6KP5CTFNT4AMjk67YqA2R7kzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1O4B8tRQhG9ej7pk4ZWHbQDGftm00ZDJfKtFl2elmo=;
 b=QiHpgWtEZZL67HDO7EuxBvb8VQHlHFoArL8mslbwsbbAIMUDp/p/DLFsSPmrg+Vg/eDM2EOA292VTMXslEhPTiPd9sFfjdu4tzQQ4ZlIs4PEQlMlKzILdHL6/XYDEnh4ZDBSupcmGqtkqGP1GakHH3yncLU+uWSjzt0Ix+a5rkg=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 13:54:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 13:54:50 +0000
Date: Thu, 4 Apr 2024 09:54:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER" <imx@lists.linux.dev>,
	"open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER" <linux-media@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: media: imx-jpeg: add
 clocks,clock-names,slot to fix warning
Message-ID: <Zg6xIjIQysjIVNzw@lizhi-Precision-Tower-5810>
References: <20240404035205.59492-1-Frank.Li@nxp.com>
 <af602862-5120-4717-adb6-694ada09e8d8@linaro.org>
 <f5fa1872-0bae-4f04-aa94-27db937516e9@linaro.org>
 <CAOMZO5Dtd_p02YeX6tcWMGzujZ-GwLQMQBPBOx9xLmEgs6VVNg@mail.gmail.com>
 <e78c8c2e-1c83-4492-9db9-08f06856a414@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e78c8c2e-1c83-4492-9db9-08f06856a414@linaro.org>
X-ClientProxiedBy: BYAPR07CA0034.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9959:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l4JoTQZga9rVNdx3FA4X3hG9HsQnpXHEzXeM2JsZbF5XvcyISMnJhKWjPCH6Gs9Okd/e1STZVTPMNylpvMYddBwS3mu3HoeLernCJioqBLpq4bzAXeL/4ICw+EtoQZpTeW8/gCkf++xjOPtv6OzLL6FcAtMOgcnbR7tLiXy7JaTqD6RGkouUdU8wAHit98QoldM09wp9KxPATSuMdTJfBjIRjI6746f9l6C/+99vr2oNoW2716SXEBcAL0GbG6sDuIlK9FRR7SZr7y0Je7VXpijmbhlFtVOfIHJK9AB1g/9/9k0MOI4xmaWhEoRZe42kCiWUx63hs/cWeCicz5qE5V506cMcHSAOptCaDtUfzCSoLG2XvqPWgS1amd3/m4a6rhP67DZWaeNMDe67bJhPl4hH1/DfUJpp426NJWFu9x+t9JfcOeqElfk9GfK4HaEwsHvVcQQtDz889Btkpur6LSWjNdwtvy4tvLodUXeyY8j4VdTNo02kqoCrKuOJUBGzxVcAmH1fKI8NTWr6Clz3UTULNr5GwPfnIqzUmeQaCX8BQa4WwhDfBz6mpi+hoPfx3JljyYIsmdD/Po7AWOXPqzDNprsyR+uXBAH773PH+ymRD0kasZb/GPnfr47ArZc/6GmoZCNN3uzyp1DOfYnk0CjoiIG/U8IihEwdPjvBF3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FWRXd2UGM3cXA3c2NwRzNsb0U3Skdva094MXQySXdCbjZCUFpybnV5OXhv?=
 =?utf-8?B?MDV4cjBkOElDbUU4UUoyNHpIUFowSDQzZ0x0emlxSWttVVcxcFBCMFZrTjVn?=
 =?utf-8?B?SVQ5bVlLUWliUU9OMEI3WVZXNkhleDVST3V2V1hNZm1Dd0pQTzBZQnF1M1Z4?=
 =?utf-8?B?Q052K1JRR2lOVmw5c0dJV1AxT3RkeUx1VTBLR3BtOEVmcFVzcEdrcUNiZVVx?=
 =?utf-8?B?TnU3L3BybEJRWGVZRC9kOUJuVUJoYm1wa3MxL00zM0pVYTRrME0rdmVuQjhQ?=
 =?utf-8?B?eHNyVnpGM1NHVXZCenQ0eVZyU0VvUGduczB4TkU1eFZWbUdTSzgvZkVseG8v?=
 =?utf-8?B?dmdMRlZwY0ZGL3FWUHhsQUl3OTVUWnlSSUl4N3gwZ0FZL0hHTjBDTDJCTjk1?=
 =?utf-8?B?bGZ4c1ZIU3prbzkrNVFzTkFEQm1UaVk2VTVhS2E3bHprRWhZOFFPVCtIUzZj?=
 =?utf-8?B?NTMxYUpmbXF3eHVlMmtkNEFycVBuYjNSS2EwZGRMS0VhMk1oNVJzbUdvU1ph?=
 =?utf-8?B?NXlDMmtaSkNlaHVOdVZLVGY4cGVrb0ZmeWNmUjNwaHhtZXZrdFBwTnNQQkNu?=
 =?utf-8?B?SzFkOE8zNnVzVHN2VVZKeGtxRWFudTdCbFJ0ZDZMMlFUaUg1L0paa1dyb3BR?=
 =?utf-8?B?WEJmUk13K1RWazlSSnpPR1pQcXdvOENwVEFpaDBJTGo4UnNTV3J0SU5FN3I4?=
 =?utf-8?B?R1VlTklsbXZlWGtkZU9DQUJyYVlDZkd1emFWSjJMeXZ1NDhYc3MwbjlmYmNF?=
 =?utf-8?B?WHVrdWdHMXZyNGhWTll0cTF6cXR2MjNzMDVjL2YvWGwwaGkzVUVoNW5rMlc4?=
 =?utf-8?B?V1dQWEZXRis5cGxpT08vZkYvVnpkOEUwdVhzZ2Zzb2hZZHBVcnBiZkQwbU9v?=
 =?utf-8?B?R2tqUU5Ld2o3TENyd3RHOGdpRHdSd2ZacXFISFZyMUJNN0pQQmV3VG5TMjJy?=
 =?utf-8?B?ZmxPdm4xNU9LZUo2S0pWSGlYeGgzMUNHdzJmZXNjYTlwM1BzMlJRdEgvYThx?=
 =?utf-8?B?NGFtN0J4Mmo0U0R4V1d4b3h4VTNPZWhNWVl5V0VPVGFtWHMyMGV5ZU1MdzVK?=
 =?utf-8?B?UFgyeTd6MzdBRm1NckovZVAvbkMxNjYrVmJ4WjlvRDlIUU0xaWhHQWZjM2Vq?=
 =?utf-8?B?RGhvQXFQYTJOcm84a0xieHk1ZU9SdlE2aUJwSFZ1ZXZWem5TeDZHdE0rWmtM?=
 =?utf-8?B?aFI2c05OSzBpOGZNSjBUVUtPeWFFS0p4em5BUkFjRWlqOWJlZzdLSjBKUnk4?=
 =?utf-8?B?Z0ptd1VBaVFlcVM1bjdBaFZrdFBKa3I5SjhpUVBLS0lFTGlRdlJ6U2dYa2pJ?=
 =?utf-8?B?NDBrNWNUSTFQVlJ4N2lCTlFodGI5enhYaWh3eXRRNythdW85VklKNXRYOWQ2?=
 =?utf-8?B?c0UzeStuUGtoSGVncWVEQnFaODkrN0p3eXNzeW5INTJrZ05KVUQvVzZUcHdu?=
 =?utf-8?B?Nlp5UEtKNUFYYUg1ZEJqYkVCRnBxZkM0N1c5V0VneTZaTWJNcEZGVUh1eGR2?=
 =?utf-8?B?VURvdWxqbWJWMnBBQmpLZWk3WXptRzc4QjgvOWFRYjIvZzEwUC8raHpFTUdv?=
 =?utf-8?B?RHhGNlhEalJaZ0lBVmIveDU2azRKUXBtS1JEalF1WTRFM0FxNXY3MlJLMCtI?=
 =?utf-8?B?VlFMS21nZDk1emJ4VFQzbURXWDlLajAySVlLUy9OQW1xNThEK1lxRkFXVGY1?=
 =?utf-8?B?QitKS3F4MGRZOGVTSUVYaEsxWWZhaHIySVNIanZMQytLemNpY3lTN0dKZ3ZE?=
 =?utf-8?B?WS9HRkg2dE5lWnZ3WEkzQ0lHUDFGODlDQ2JJald3ZkNpSUF5ZXo1UWJVdG4x?=
 =?utf-8?B?NTQyNzBDMjlHeWR5TDNkdEpraW52bFZkOVlLTW5tRmp0M1NOMnNUVmN2N3hR?=
 =?utf-8?B?Ymk4WVVuZDZqemhQeGJaWlRKbUVGMFh6aGF0a0hXQ29mSWJDek13VjJvVjM5?=
 =?utf-8?B?S1BWeU9aRmZFa0Zlei9WU0xTUGQxT0RBdG9FLzdZdDlvOWhWK09RRkFLNFI1?=
 =?utf-8?B?d1VTR2VLdnlDc2ZaSXB1MlZEL0hnanZEM2xtSHNMMjg1aGJ0NlBBejBSNkYy?=
 =?utf-8?B?amxNUjYyallDSXM4ME5NdGR0NWErY1JXRm9yenpBM01kT2JTNkpsZnV1SVJ6?=
 =?utf-8?Q?ZiEMaVNP8XQr4DmLrCijlH2pR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c263bda-720a-4967-27ed-08dc54aecc1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 13:54:50.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/gre/7zkyqYzQUwhBV6J6nbk3iZQBcPYB4oNmbPlXicbUtX0f8LmGW3YyB6bF3LsOelP49yRqveXhhsAOGuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959

On Thu, Apr 04, 2024 at 01:59:57PM +0200, Krzysztof Kozlowski wrote:
> On 04/04/2024 13:03, Fabio Estevam wrote:
> > On Thu, Apr 4, 2024 at 3:54 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > 
> >> And for the clocks, instead pick up this patch:
> >> https://lore.kernel.org/all/20230721111020.1234278-3-alexander.stein@ew.tq-group.com/
> > 
> > Or maybe this one:
> > https://lore.kernel.org/linux-devicetree/DB9PR04MB923493D0DA82C9EC4386BC2A8FF1A@DB9PR04MB9234.eurprd04.prod.outlook.com/
> 
> 
> Three people were fixing same clocks issue... and three or more people
> were trying to fix the slot property.
> 
> This is really bad binding maintenance and driver upstreaming, NXP.

Thanks everyone help make imx dts and binding better. I should google
before send. 

Patchwork for imx already was created.
https://patchwork.kernel.org/project/imx/list/?series=&submitter=150701&state=&q=&archive=&delegate=

I hope to patchwork help reduce duplicate work.

Frank

> 
> Best regards,
> Krzysztof
> 

