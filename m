Return-Path: <linux-kernel+bounces-33069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C58363FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68071F2440A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E83C08D;
	Mon, 22 Jan 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tS/8jFls"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146543A8D5;
	Mon, 22 Jan 2024 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928835; cv=fail; b=artkhgm7Hy3AwvBYl9afTfy/tcUEPcGkIB/3xmOsDYEdkxqlgeGL9FnBBFcvmMIhk/Gv5QPgZoh7czdSS4A4azJV81y4EZF3bObHzxW0fEd8Of5gUPXTDw959msjZvD02zIrofcSoMAeNvQmB2MZxz2Fv0w6RlguxKMeXlM+QQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928835; c=relaxed/simple;
	bh=uiXVM3ARHyqJNz1vmQ+k+UOaHqrBp17MTmRzdLEheu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hu2RWqs/XoYgwciae/KQgChSyzpNmsVdV6jM1L5h3GEQtn3IH6IaFPu8kQSUp6I3cWlRa7Fm7XhAZloRznuarft2MGmjZykrnW7SCMDrnjIBZwvT4X4pItWSNGe33GscvAr0CeTDI9PCnMfSb8Kn5kgygQAid+hyt6CDOFlg2go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tS/8jFls; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gei83/bG53KxonfcZEv25dlFAY8TTzOC5oZ7e2RTfNj8aW3vlIQtiXLRe/BlTjspm07T7nTTMbuWCzL6GcDA/mzxRIF2NlrSnQM/VwiVHsD9PIS5Dh4YjZ8VS3KBmBKAbI7xtN7DJce+CYbZyjujQuybSEr7o17xcqe0zTkSEheslp5/Y94NylKjScXWwrbRgLToWjj+WLjp9ONmGM5NJTGxptTjL562DSGZf4ZmjbcIzuwEO2PqhzF2liiak3QKejjTJrW5aetTgHMgsOu+duWPuTpg0A/XVgm+fRa4a9qK64GWfS/k+dV/X/RjdiSSyjRJvxnQg/zi7gAApRyvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WoEXoja+KtHu6SK5FmjCXt0vwVEbJQgtVI8H9KUjsk=;
 b=hSHChmJ5a0g24AwnQxWlVPqeszB2j035zwZ5fyzUd/apxEcHZ01biyp1J2LHvkPLFx/YA4dHGS05QORlptFA/XUVBTKhBz42CLNYUG9FFG3b3/7eNAPoPAB77BZBfe7ymt6LX5WGcU7e2lKULrI9FVqrA3CDUVBcvAP4fCJ28fE2BapoFhXsC9Llstmacbo/vQxCBNSGFZeh2Kh9G8DEnbEpF8Bm85XmzmNXH3HgvzDp4BHACmXNK1sADwVqeGSwC/xjOMIPUvn/hHPZbrB9jA3aOXaLudKKsqpHoJy+9ReHFb5SrQxr3blUiNLyzVOb/Bo01YyA9jUFd4nO0jIJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WoEXoja+KtHu6SK5FmjCXt0vwVEbJQgtVI8H9KUjsk=;
 b=tS/8jFlsI6lhnWMrP2VgEyLOjQiGlIMPMULA50hGOckaxiEhEaK0NmNb8gDXhijUc7GlzWCDxyXFI+0Xv7x5NtPk0/YELeT5DUfGOpfMnmALL52251XSsUQMTsimAjiPfLANBca0bMqqctWGbwUNjWZQDscyTNbqyf++pVhrOnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 13:07:10 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 13:07:09 +0000
Message-ID: <c29b8e40-8493-4aa5-93ed-2e3695409ef2@amd.com>
Date: Mon, 22 Jan 2024 14:06:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] dt-bindings: xilinx: Add missing firmware child
 nodes
Content-Language: en-US
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mark Brown <broonie@kernel.org>,
 Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
 Parth Gajjar <parth.gajjar@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
 kishore Manne <nava.kishore.manne@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1703161663.git.michal.simek@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1703161663.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0170.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::27) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4253490f-52e6-4785-38be-08dc1b4b0ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dEVSjimxGPxW2SpXPasfqmCmfhxqKZSTWo/jFVZjYw74VFmX8GKaE0RxTVgO71Q7M2hfPIJgtYPFXPg80CZXsni6nOWssYct+lVK2yGJXilMVJbUK3o67Dxv3pA5vmufgTC6jij0HzK9kTyb0fr7HkIm5AFKjUBJi4toEfUMvRavcZE5c8wwDRvbemK3yugPKBSrcmgHeQVNr6vdoaZzG4GtcTwoCLP195rX3amsxqILFIESfchd+1fX3q6Wk9VMoJ+n97kauqGDX2IvecBz1jDJPjRc3GDa16zjSuHmoJe+fxjvgEbZUJjcUu012XFCx0kKNv7FO6jn5sbgkY9LiR/WUbI4133diCAtFU+tC+0RiV996lRH2JjaM4vnUvHMe2M7cpB8Xiplwj3TWclBRqIMItftGoCqGJEGwaNsQ1OEZdSmLUbccPsD543wyiisqLD8vv7gouP66I/BXFj//O78njvHSiNjD9XuDU67Cl5c2MCZH1XRqBap6Nw7gPJMCGVRWT6GnFqaPUhgiATmjCYpvx1C5oZLNAWuDViSZn+E1k5k6ahMRljMR8o6VwtUnERblr2lS8v3ZtSMuJHGcJrZrD/xFZadAVe6EixnyN13p7og2cGSv7pUdtVx9Pox
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(36756003)(31696002)(86362001)(38100700002)(31686004)(26005)(2616005)(83380400001)(6512007)(6666004)(54906003)(316002)(478600001)(8676002)(8936002)(53546011)(66556008)(6506007)(66946007)(966005)(66476007)(6486002)(44832011)(5660300002)(2906002)(7416002)(4326008)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUpNdHB3WG41YVNnVDJLR2JIcG9MNWkzcDJSQXpnb1pOKzEvbFpQa1ZXaVJH?=
 =?utf-8?B?a1NjTGNzKzZnQXhja2lvTDF0SHFaMUMybW9haXR2ZUloYnR5em1XRnVXemdP?=
 =?utf-8?B?c2xOV0hVSWhPMUpteW5QUDMvdkhnaWpPekdHcjFpSzMrNWp0T3FZNnRTNU8r?=
 =?utf-8?B?YUd0SDczWVpjV0NCKzZLTEcxS1RoTC9zbVJpZ0hVclNDbDBleExDd0hGbEt5?=
 =?utf-8?B?SVJWN1hmOHRJK1E2WXZpQ2xQQWNuUGxwL2thMDBPc3dDcjJER2F5WHNnZWo2?=
 =?utf-8?B?ZndYeWZmMkZzL3BOOWdsQmM3bW9xNWVCRTd6MTRnODNvZFpRb2JLVTBwWFdk?=
 =?utf-8?B?aVpUMHFZTEdZc09wMFZVSS9NZlBhcmlWY3orMjJ6d29BNGxwakI1L282WHcy?=
 =?utf-8?B?VVNLTGYvUVZwamtSckcreFFQNzBENTMxOVFCOWdGQW9EZHgwK2pqTXlOSjFY?=
 =?utf-8?B?RHdkVVR0eVNlTzcxUncyeHphZzJjSUJTd3BzelFJNW1zMERYeDRTa0p3VW9V?=
 =?utf-8?B?NzJ4ZHN4dFluanB6VWorclZ3WWEwME1OeFBHR3lBTU9qQStkN1lQWVRwYUlW?=
 =?utf-8?B?MUhnakpqK2lVaWpXQ0dxek96aUlXdXRUM1Zlb1YrUEdzdUlRSU5hb2JMNHFC?=
 =?utf-8?B?bXlnellJZmtxTHFZT1dvUDF6cWduYVI2T3N3azM5NFRnWXhvTVZBSVp4UkdR?=
 =?utf-8?B?N0hnS3NaNVVpRFBDb2NQSTRBUi9ZQnJ4VytCZkUzanVXN0plWkc1WEN2SkRB?=
 =?utf-8?B?QjFZUzgrczlhU0ZSaXpUNEF1Q0dxWjc4cUh6Znh0TVB3MEVJT3FJVTJvc1Va?=
 =?utf-8?B?ekJ6N0wzd3dBbjZqRHNCamNOSmNycTRvV0Vmc2FPWlN3akhHMlFXN1ljYnVz?=
 =?utf-8?B?eEFwalF2eW5vZ3Q4dElWcVI4aFAyMjJMTzNBVHNpMjI4YnVENHp3dk9UVk5l?=
 =?utf-8?B?eDdwbTExZUtINjBYVzlKR0tIWThIbGg1UHg1dXpMd1EzUVhnd2RwcC9sQjdM?=
 =?utf-8?B?WXFWZk1BeXlVci9lVEFveFYvTlZPK1p5ZVd6SjBPc1ZGeGEwRkgvTk1zaEY2?=
 =?utf-8?B?QktuWGVrU1Q3Y3FHazByT1E2ZFgyMklvS0x2ZFBwa2dRclIwc2hMSVhNSXgv?=
 =?utf-8?B?WFVQMmVma05vVmk4VmwwTU5HVk5aOGdvMElFRlh1ZkVDcERRRGo1SnBZbEls?=
 =?utf-8?B?dUZxa1gwcVROUFZld3VVRzVJWWYzQzJJL3JGNnhUQVNERjFBdnJLaTdHSzEv?=
 =?utf-8?B?aGZ1WEJIQ3FYcCtBRTRrdXdQSXhLbHNXd0czYXN6YnM1NHNaQWZDMzNseVI0?=
 =?utf-8?B?Tm53M1lsbHhMcTRoS1ZNVVNhbTdaL0FmK283a2tvQ2pIMm0zWDY3cXlTd0hG?=
 =?utf-8?B?TXZ0N0ZlM0hvd2xqNC95dy9tSGU4UXh0dGNwOFluSE9TN2pJNk9ZNXVnajFG?=
 =?utf-8?B?ODVHblgwR1J5RkpEMFhqV0ludXgwOFpBVGlFZ1U1aVlJcmYxSHNvbXcrQXNC?=
 =?utf-8?B?YzhNQjFQcTU4c2djam04S3JTYklOcjg0QXhHSUUrOWo4Lzl5U0JGREtuWHhm?=
 =?utf-8?B?MDBRdzkxaHByMHBSaTk2cW1GcFl2S0Ezb0pLVDRKZzIxOTRzSDl5NW9kTTFO?=
 =?utf-8?B?Z3IxR2pybHlXT1R3YXlQQXk0UUZsTVRVTnFDS29wYlNQOENkbXo2ejQzSmd4?=
 =?utf-8?B?VG91WWdJTGRTWEpwT0J4VUl3bTJUbUFUUDVVL3AzQzF3VlhmVi9CaStFT2Rx?=
 =?utf-8?B?OTJjd3ZLOFNrZW9sM213Y0pHNGYzaGh0em9Yb0lJWE9ZK2ZjMTZEMXlvRXBr?=
 =?utf-8?B?Rk05dmJjV3c2MXNhYldycmxtUFlFRDhTVkwwblBOZVJpdW5pejBSeTdkTmk0?=
 =?utf-8?B?d25iNjZ4dlFrMk9VWENmSUZuR1F4RnhoeityNUg0Ym1uaS9zUHZZa2tzMU9K?=
 =?utf-8?B?SFltVkxUZjJOYThpVXRab0k0akl6WkJzMi8rMUlOVSt0b214aDVkQi9sN2U0?=
 =?utf-8?B?ME1acUdqa3o5cGgyendQdXZnZU9sdklMS1RKRnFWMCtHVkgwRUdWVmJTM015?=
 =?utf-8?B?ZDY4WllKSU10c1RrMEdPbmUvMmo1WkFxR3ZZbFZSVStidER5L1NESjIwZGc3?=
 =?utf-8?Q?cOfALRa3fjRPS/fUUH2XsWjad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4253490f-52e6-4785-38be-08dc1b4b0ab3
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:07:09.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c341gfO6AMc2KRkExCevcQXCy/nar1Kk9svM6iI3yRri1WqooDxNRPHV7YiRg/a+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551



On 12/21/23 13:27, Michal Simek wrote:
> Hi,
> 
> series is converting missing descriptions for child nodes and also
> synchronizing name for power-management discussed with Krzysztof in v1
> version available here.
> https://lore.kernel.org/r/fc7863a2-d3c5-47c8-9484-ef9cd6d7dd5d@linaro.org
> 
> Thanks,
> Michal
> 
> Changes in v3:
> - s/power-controller/power-management/g
> - extend example
> - s/power-controller/power-management/g
> - align commit message
> - s/power-controller/power-management/g
> - update subject and commit message to match sed above
> 
> Changes in v2:
> - Sort nodes by name
> - Rename zynqmp-power to power-controller
> - Keep only single patch for easier handling as done in v1
> - New patch in series
> - New patch is series
> - New patch is series
> 
> Michal Simek (4):
>    dt-bindings: firmware: xilinx: Describe missing child nodes
>    dt-bindings: firmware: xilinx: Sort node names (clock-controller)
>    dt-bindings: power: reset: xilinx: Rename node names in examples
>    arm64: zynqmp: Rename zynqmp-power node to power-management
> 
>   .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 68 ++++++++++++++++---
>   .../power/reset/xlnx,zynqmp-power.yaml        |  4 +-
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  2 +-
>   3 files changed, 62 insertions(+), 12 deletions(-)
> 

Applied 1,2 and 4.

3 has been applied to v6.8-rc1 already by Sebastian as
97b9b383976e ("dt-bindings: power: reset: xilinx: Rename node names in examples")

Thanks,
Michal

