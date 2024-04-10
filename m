Return-Path: <linux-kernel+bounces-139215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1930A89FFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DA81F22BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0A815920B;
	Wed, 10 Apr 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ODFUV5qd"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2130.outbound.protection.outlook.com [40.107.20.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F515CB;
	Wed, 10 Apr 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712774595; cv=fail; b=FT+WuG5CS6OejxgJDMiCVh2G0Zaa4Y5ujrjtreO46MlCXEVvQuD1lR5w7fBz77A9EEajaGc2M+CryoiwxEZ7tPMlr4VGxEI7mADPsj7aH/0eOZQdga92XEGh0Cq+eKDTsT/2RQsxd8xrxaKlol0gr6LV4E5lnbeegvQSlMzHFMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712774595; c=relaxed/simple;
	bh=d1wnGKAdCsO3tyYJYU9wsMHOxRDXUWTUFYICq0z+4N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qDKJB9JbdNDAcX74zAFLa/ftVFZoyb5tZE2rrqAxzTaeeACgFc2aAkM++56SGK1weGufgyTlAcOdrMsUeHqyCcYqhat08WJqcC/uwm+jWU+OQu1T551GYwgGcu4gT8rG8rSQF/O82HRilWUivkmpsMFFdPz/MwERF9EbeaUqzjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ODFUV5qd; arc=fail smtp.client-ip=40.107.20.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1KHG//M3FroNNZDXiIVbeBADsfvq6b7k37Nw9gnXXrjZpqeidqQoDb6qeLEZH02r0zLvLDw5SEYEeF+6QjzAPO8ew+leFWyDL2VK6ZeTf0f/eGHblPA5cu/E3m8T4t2cY9ValftYhrZE8sHVqVY3eBsCy6hJmJ9f3RDKcSEQKhrXC9S1YwofLlyLOS1K0DEIAvdRcbBt3kBOz0Hkqe2/SCfv2cRFXMtSPnTnDtZ0qKdeqJJxRuNAxgDrB4LZkxExBKU+muh+lsvoJw2W/KABCcOAPy8wtozMIEfq0lIliEItshUjT74gk41p6s/Uvt9Hf+UemrCnc6hIAnsAYIY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=923HJYSvLxHureIlzeabzsjwjMP0D7YhLoEzrCh8y4c=;
 b=PAQjmBhgIVhnbMevIXwS3KCnE28OEg28dYLwagIF9KzxX0ydpeb2YvhR99T4xud1ILDOJLogD4eEHsbxKWnRd34RpFkm62g5tCBsKGjGQq6l4FgBgiV9SpkTcQxWshaDVZXr3sudz2f3D2Y7SzH/Vpft+X9g3lHVd3w41QCHvAPNLWYFc+zBKYFF4zL7us6e1wVjujj1rkn5+ZHHspvPijpPkZoK1ExrWk6Pqimrd9Ud3uwzIj3CjstRvGU9XZdic2AtqAvVWXksuZqtV/ysQqCjsCWwqOeOQHD70+5F59uT5jX8X06Mmrp4VEH/gSGXqqs6hKHGBj0WkreQ2oD8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=923HJYSvLxHureIlzeabzsjwjMP0D7YhLoEzrCh8y4c=;
 b=ODFUV5qd5vOhQnzeBBoDSeVn5N01H005yFH8XRKBmcs7NiI/k+Qiz411KGUe1OZfnMJEY3TMfy6H+7IW7fsWkfL6W0rxtXLXG4rV0w1rsPaVO/ui0TmgKbKX1xkN91sepuQCdCcTK7hozxkpyALbLJQIJ8jKowdx7FaeUBpLfuY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10026.eurprd04.prod.outlook.com (2603:10a6:800:1df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 18:43:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 18:43:10 +0000
Date: Wed, 10 Apr 2024 14:43:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt
 to yaml
Message-ID: <ZhbdtT3JoXf8GOmZ@lizhi-Precision-Tower-5810>
References: <20240322145406.2613256-1-Frank.Li@nxp.com>
 <CAL_JsqLJDhJd_uoL05Z=s3Mc7PRkcJWsQGGjdG0Q0GFp0zA8xw@mail.gmail.com>
 <ZhWP+Cxy9yMAYXJC@lizhi-Precision-Tower-5810>
 <CAOMZO5C=AQOBkOwMBjkgn9TbQ8242Wj0AEHRJ0j_1=N8WfWYRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5C=AQOBkOwMBjkgn9TbQ8242Wj0AEHRJ0j_1=N8WfWYRw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10026:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	etUQXkykboFLnWfLikY+CG9SFEGbRinL1p1xywXiRtMyEkZQT22hsoT24ZGeNA3DBSe2HSXH521QlXlImZwk9wvv1dN3utq7/R3mpz+Oj5WZrK5MTV4xMva9o7wil75DU4r/HbQ5P5MA6otPm2rY9GRWI8vafONl3ge0SUetdSmDVxK0V5CASc9pKbAye0h+znqUOVrY+W3ez5K+iq5iMJz2TZZbPc7aJ6FSkQGmrWUMKS/23tiDlTGze4UadORFtvpchty+vxlHDfET8PljpqyMUlUG6l51d+DFw1DhObqOSsNyQoq7NNnmWZoEVoLjEsjSGt6IhV2wllncafEEgvbD+Y8HzeCMp4wZFR+fcutQfYW4doehlQTDVvdI/pDryOSBMrD3pm7CXdyJtg9IOmeDCxRt1IKHsXHStgqf4EOh+st1VM37RBLL3JbHKlU7IC0OM5XrOpN4bihArnYWfIW8SsHhsB589+8YdFMbdR3KG/RyjQHi5pJcEBOxf1ohP17QntWLIfL+8jbi4MiQsbyeEuiqc6TXhVC0D5bjKGW5Sv+PL2mpdLV9F4FlWZZYN+/B8awPZ9sKq796noIH4sOWKE/b48iW1yz3Pp3DwA2UUFK2iD42E5mf8p2JCy8m25eJcwFVAuU9nibrgOcpIitEW7ynBrtJYHlcJhRetoQ4bC0a2U5rPdaLb+5f2Sw9s9bfuv0hCjKAHfoxz1s5HA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXpnc0FsODBqS0NMMzJwRHUwbmV4eVVqNkw3b3FkNEg5TStlc0liQ2lxU1JS?=
 =?utf-8?B?cEQ4UjlQN3phdFZ2b3RPYUQ0WG9xOTVyRzVQRytYWHo5YUIvTzAvZUY4eDFj?=
 =?utf-8?B?L2dxSXY5NUVLTnlVRytIZVM1SDdySktud0ErVVd1dGRhU2cxbzA1SnZiNUly?=
 =?utf-8?B?UndBMlk1VmROdks3cXhkMlBnS3JhWHVMSlZOY2IyZy8yYXNTeC9WWHBTT1Vv?=
 =?utf-8?B?L3VUZnFYc3B0OXNKMHgzTEN4d0h2RWh3VGhwbWhacGJqN0NGRWxTS1ZnNnZ3?=
 =?utf-8?B?dC9VMWsxd1pUeFdjS3ErWXdqSzBnb1ZaQVBCNExybkxLZVFobEJ0Um5qanV3?=
 =?utf-8?B?Y1EvYmJiekZJaVBFTC9NUy9ieUc1NGVaaEd1WU8vdFNNRHlmRml5YmNvUkt0?=
 =?utf-8?B?bmp3YmNXT2ZsMC9id3U5QWlYbkhxMkZiRlB0U21kTnJVQ2hraGZUM0xPNmxM?=
 =?utf-8?B?TzdzY2FqZks3eHN4b1NTN0t1UVlGRERlaGw1NHZMNGdxWThvODlnVnN3MlYx?=
 =?utf-8?B?d1ZEM2R5Y05hRE1YMHd3Z1RxeWFEelIxUGplZmdmZFl3WHhpYyt6MmpqTGJH?=
 =?utf-8?B?ckZtNktuVVNXbTFsQk5vcW9aWjYrcWRPTTNUK1RDb2t6VlZBQlFrMWZVV2g2?=
 =?utf-8?B?eWN3U0Fpam1WT0tqWGV1WFY4ZWxTdSsybmVuWGMwMXpjTEh1WEZwamc4clVY?=
 =?utf-8?B?MTNjV0ZTTEFDSWZrQ1J2dmlVMk1xL0pZVkdUUzhNdXlEMVQ5aWxXaVYyTUNp?=
 =?utf-8?B?SURXK093VGpPYjJKQ205MkRGNkN1WmVHYWVzZjJ0aVhQQ2ZleDQzdnJnRHFU?=
 =?utf-8?B?c1JXRUxlMkZJdTljZEs3eEF5NS9jTUE5VVRKSkRYcWhQb09PNzVmeHRNbDky?=
 =?utf-8?B?Rmp2NE1EcGpkSHRmSjY1N3dSNURrQ1AxUW1lcTVpcHRwclhhMjNrVm5ock9i?=
 =?utf-8?B?UWhPOVhNRUd4THhhMzZPbnZ6aTBhbVVWOGFnNjZtRk1yUElZaE1HR2FvU2V6?=
 =?utf-8?B?SUUxa0QrRVJ0NVJhRC96bERBbyswVFd6M1RpZDhnc0pjZ2J3UVczUVhpb2Fv?=
 =?utf-8?B?TlR5Z2t1aVlSUkliSWU2MkFSRW9QcnZQMGdzZkpQelhoeHhVV1FXSkNKSmJS?=
 =?utf-8?B?d3VWdHRqdlV1YWtLaDJvbllQYVNya08rMXpHNW40TVJqNzlzRTFGa2FRdHN1?=
 =?utf-8?B?U1ZvVi9qcXd6QkduTXgzWkIySUlUOWRYaXJyc0FJUkhMNmJoT3lKMGZRQ2tr?=
 =?utf-8?B?dEZxbUJNeWFTN2xOczZ2RmdkYnJIbVlLOWgzS3NOM3dveGpvdzVSRlNpV0Yx?=
 =?utf-8?B?Ynk4bGExT1l5dVVwZ1ZraTZpTDlYWWgwTllmOWNDRmFXRzYweTdzY3VseXVN?=
 =?utf-8?B?ZXkzNW1IM25kTDNaLzVjV1JNZFh2cDVaSmFPTlRyVTFTMGlwajhBVkcvOCtP?=
 =?utf-8?B?UjE1VlcxYlVDNG40SHc5OHkyZGM5dnprTnNzd2N5RTJUZmFhd3B5TUtlMDZB?=
 =?utf-8?B?V1NCQVhvMk9vczZjR1VkdUxFbi8rbVhkZ0RiNjNnZzYzdm5HMkNPNXozM09N?=
 =?utf-8?B?em9jQytteWdBZzhtbHhTL1RMQ1VIamY2Sjk3Q1BUbHk2aXc1WkFKZXQzb1Ew?=
 =?utf-8?B?UG9FekNnNUhha0sycDVRYUZLMGh2cEhCQ0JEWStXbDZJb1BtRm5yTENRYnQ1?=
 =?utf-8?B?NVA3RFZxM0EwdCtZYkdrWm9kN2FEaUdBU0xlMkl0ajdMbnFBdEtEbTRkR0h3?=
 =?utf-8?B?K3VmMVNhcVhHWjFQZVpQZDByUmg5c3Vqc1NJUlRpV3FDZTFxRFN6S096b0JY?=
 =?utf-8?B?RnJjOUtqVzBjRlRCQ0lkc3FqdXd2bXlRbFJJelFxaTRuTDlSMURDMDJFd2xM?=
 =?utf-8?B?cytQdi84VW1UMkRrVjBSNXFJSTR6WHo4dm5wTlhsYUJ6dysvWDJzeG9QRzk0?=
 =?utf-8?B?ZWFwTUF1bWd4cGRlamJXWVpwQzhnOThPYXRrWjcwYzdSN3dZUzNDOFpYWXVC?=
 =?utf-8?B?dlpzeDVmMkdsQ1FIWnNYNlpnUGd6NUJyYzFOVGc5MmVRV0JCMWNwenR1bXhw?=
 =?utf-8?B?elMyZDZDZDE3K2N1aXlaZFFZdzlLUTBlWmFxRHNuWVN6bDhoSzhJVkRkeEtV?=
 =?utf-8?Q?/t1Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae76c94-3bad-48e1-423b-08dc598e11f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 18:43:10.2373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ+EOnolxCl9DJ0mhri0910vZzF3SnVdCalDlC2FESq07ytBBBs9QcutXRxC9VVI2b+JPuKltu5GzGQgxhGbKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10026

On Tue, Apr 09, 2024 at 04:02:26PM -0300, Fabio Estevam wrote:
> On Tue, Apr 9, 2024 at 3:59 PM Frank Li <Frank.li@nxp.com> wrote:
> 
> > Yes, I run dtb_check for one platform. Which dtb report this warning?
> 
> Try imx_v6_v7_defconfig.

It is because imx6dl.dtsi use a undocumented clock-name 'mem'. According
to driver code,  clock-names 'mem' never be used. but I need double check
with driver owner before send out fix patch.

Frank 

