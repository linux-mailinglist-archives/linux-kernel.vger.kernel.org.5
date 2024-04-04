Return-Path: <linux-kernel+bounces-132103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64C898FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E45B1C22373
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4713792B;
	Thu,  4 Apr 2024 20:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EUBSdBB7"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2137.outbound.protection.outlook.com [40.107.223.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E26FE26
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263003; cv=fail; b=E6v3he78Omb1klmXDXS6q+OiNLHusLZKgfgUrT91RFZSKYEOocM6xrIou/5vAABA6FDj3OmrqMAV2rjwgDc7xIMimRYuUI03DHG9fFbNgM0+CwSiwtVB2CXilWwlZPQADi+/CRyY74R2AYc5WAxtptU4RY8aT8ROnFKaHT+5zZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263003; c=relaxed/simple;
	bh=U2NC96H5NYulA5Nr74konbSEr2WWUl3pYaBEsNk926M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=k1KUUT4ZbOWkG+i+cFly7b0uo5l8dr5T5CBueVmlxhPr0g9wVUoBMJXrhAT9u37IdAFW6iUnHdPuZo4igfMuAEt5GvWSPogxQmqN4Y15K/7yvF5znFzFBLFL8QKUYuP8Jjy+SXDvtrw6V7DCABbq1JPkGlTDiPARrgIUgX0VtUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EUBSdBB7; arc=fail smtp.client-ip=40.107.223.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdlO/ZFWtzQlwLuVkJmNPhjl23g0wkYlXIhLO7Q0fB5JLvG6AQJE93o5+4pYlq74NRWMrlFFzhmN0OKa6XPH8963Sr1VAWcuLfeTv2yZWg9iQvOyYq4Zm8ClUuNeFcGnSxpLin1tcz6kbUMSaD8bIljecDLYbrKKk7X7/3xgowD0TXYknHnY/v+DzwkCwFP7OnIW6BB5gzD3sqH0rZuE2+60/jzbeB/WZBzvdExojEuappmqsb3LY7YFhpTKJB2BVt+Lw6mTUUDkmivEClKXT7dZ+GCZDN+S7P5wmZ6yLiUq97fn0m7gHDuZ++WmFxJXajkdQRGCoQKw5waGtz8LGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKzXh+HkJ7DZCBamYTzoYbpoFn/Te1gLmVMaILP4Gmc=;
 b=Rs2aOJw6WMi/KSo8iHirWPHN1YyuDfmmtXkOqSzMMAadqR7iarg60OldGpqQYdZSD9UOR8nmEiyGEBMZqrh9oJ34N6iX4+vpd829lNEy8wUqOEzX+iGUJ7nyMFuaEhe9YeGkl+fllGoS89PCO0FCBPb9AFzj6O8vu5xT4RGwm0WyBeC6LlTh33h1YxNTmik6xB0R3yx0+lBTuVmpYC2ttNfNx6+lZHYQS3zwnciPEf0xIAYiu/ZKbQCriHrROqFLfA/wMkunkl3XN+AvojnS2muBzqin61UHM3NT456HN6eUFp+/4yBSdTrYKRN1++3aI64UCg95JD3bAAROnRlQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKzXh+HkJ7DZCBamYTzoYbpoFn/Te1gLmVMaILP4Gmc=;
 b=EUBSdBB7L26LIBCS7FUxPIp3jNczbeGSTYZPosWGQTgOenL7PGPX7EunPd/EzxFWLkAp7H0eu4kN7g6leZn4PvtrmBuT7znVeo5aqQWB1bQpksJ2KHaxQq238wSQsQwi5N4l3BWnhnQKe3r1fiZmAYAQB+NHIZ+p1yGrrBC4YWM=
Received: from BL0PR01MB4226.prod.exchangelabs.com (2603:10b6:208:49::30) by
 SA3PR01MB8015.prod.exchangelabs.com (2603:10b6:806:313::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 20:36:38 +0000
Received: from BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26]) by BL0PR01MB4226.prod.exchangelabs.com
 ([fe80::12be:916:b914:8b26%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 20:36:35 +0000
Date: Thu, 4 Apr 2024 13:35:36 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
cc: Besar Wicaksono <bwicaksono@nvidia.com>, 
    Robin Murphy <robin.murphy@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Raag Jadav <raag.jadav@intel.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Don't touch interrupt registers if no
 interrupt was assigned
In-Reply-To: <20240307193104.58302-1-ilkka@os.amperecomputing.com>
Message-ID: <e4ffbb51-117d-77d-c145-8ad9c3fad837@os.amperecomputing.com>
References: <20240307193104.58302-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CY8PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:930:49::8) To BL0PR01MB4226.prod.exchangelabs.com
 (2603:10b6:208:49::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4226:EE_|SA3PR01MB8015:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oWr0j7fLegxSjvHRinaZuNWyf4e14ousl0oTmVCfSOruuYpHY8jGp1m9eo8ybzkDwxiPkCJELcH2QZo/lDRxSgaLDRjkjVVpf3hFCSVGurto+tRS2fHfQ2oZgGwl6gLCp/Ihsy0+DQuISq2n/EoSb54aqD1GQBbCy+/RFi13/yfbFf6Y3aYJqX1If3keY44NjtOdaB2sfyhTP/+PRWjBXRUDbqeWLybcHOMf/3xHUdBg6fhTanm7UB3d9qp82Zk5YwnTEFV1J9r+ykMv/zGrAPUcwBLWFjcbFWYUrEUHMFokD7ggM8c1kCFKqUYPbimaDvZrkoD5RWty0GeGDvMyWl4WdIMaf8XJ78UXZf1TGzC6tWJB94Q61LlTON26koCUi39QmB9clyzWFah8yl9WkVhR/xXryt2uhQwVbMizUt5oSMx3Fcqxmr4IzxU2mSDhlFj04BU916Rr+as4YCBcuFaIxPo0ARtJU7XnpaHyn/OCLsVyvxjW51pn1Ya7J42zOunCX1kXUCRvLdBPtEMpzwPtO+6XzTBY8lByZtPerz2ksX0W5OCNIHMY2FrBKZw8Z1XKjgWFr0qbpy9Ewkd5BgD5MyPXsTHLK+A5qvKytpdlltqot4hR5UE2bPtoa5GVgWtWkYCdeobe9nhKN4oftHlSO9QPsVs6siwM1qm3WkvA46We80YEaITc++fw8exeSxK71CfTeQcVqx6U7c/vbgAFamHVYiD/Bxq9jq43LOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4226.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5LQLG7Mo7V+ZABh6hA0gKQJuog/ou/IKI4IaP7QLH01aYB5hEcuWEXDHRX9?=
 =?us-ascii?Q?FOKx/WIszluJEuyNiQpzTHg/28RGHZoaUfh3QNCmkKTsZWlCO6qUMbTKQ15a?=
 =?us-ascii?Q?gFpBg4ElPVc+7qKkpgaZUSpNXLo8/rk+8KF/etBD7lb6lUyIzjfXZRjDQ9K0?=
 =?us-ascii?Q?moxdgkIMjeeVPV6pBTtk/nL01LKCOu+r1wJSX7WeHkkjHlWBsE2Y3nL8pQd3?=
 =?us-ascii?Q?WKD8iZplO5kj1B4cyL4t4me4mnFkHsF2yPESkiAKFbVo5HW3cvjP1xUTe0YT?=
 =?us-ascii?Q?Ztv1LeRddhR/3WhoX6U+UUtxRpp1w7CjVGUgZhluAZPj6XVEHYP0ZHvr7i31?=
 =?us-ascii?Q?+qC2npPIy8P8CoPJwKcsq6HBiJxTvxfwG1oPJ+6HX0zPM0sG6ffg4dCOGGON?=
 =?us-ascii?Q?mc0FeADeER62/juvs0kjrJIlI47LxRScnSHDtSRs7dZANVXarSqXSy/mjpQD?=
 =?us-ascii?Q?/Ba3vdgyO4uShjnNjtey0CRw6SxQiawckgE79QzW5EW7jib0A8dQ+KxIbKVz?=
 =?us-ascii?Q?ws1Twl1X0QQNRZF5J7pPMoz7zuUjH3y3MKzEPIuizlbMnGJc0KE5bTEzIQye?=
 =?us-ascii?Q?aMixp5O1lplKUbB1/dBeHCiAa/VNx0dhi278y9FZF+WfZELgx1GytViFjI5q?=
 =?us-ascii?Q?ZMBswVD9lZRt8tGKB6UOO8tfpWiWFNPFHFpH1NCBZReZS50+Az5uhufanjfO?=
 =?us-ascii?Q?cMz9l0t4RuBn4esdAO22qsH6C82uTNRkUMt3XAPjElbkMD15uJzNXdUB67xg?=
 =?us-ascii?Q?XFDzuwmeNRpJOUEc95XEsZliF/nZZJWsnt699I4EX7ZDACdmb2dHB2DM4SRL?=
 =?us-ascii?Q?oD4ba6/Q9Ytt0xLivid1PBu5JW6I5cO9fvFIEMkHD5iDBdfMgAz5U595KefE?=
 =?us-ascii?Q?s73fG0y54f0P8DKb9JZXfJg5HQ77BsHclr4K8Hi0+9wQmUz0jDcGsBDhedUc?=
 =?us-ascii?Q?pl0Ebgb05Od1pD4/I7W6x47PncATmlHysrOzR7KUwi7XHHpXjUZiLdPqc37d?=
 =?us-ascii?Q?lQPXS+GPquQlnSfWoXW3z56nHQ300yCFHEE+p4oR3WwmO/QmwZ/vdmo4Etju?=
 =?us-ascii?Q?iJR1ZhwxXB6uefqL97l064LuqUB/nSLXhdNM/leefcOfWjQ1LAJh6ZtqbLSc?=
 =?us-ascii?Q?hriHg+KmJntRg6PdVMVzRe4Vhf6Vdy/7p86w0HdueSlEuaACeWqLzzl0uNv3?=
 =?us-ascii?Q?ztzaQhFObpbk5uxxfCk6qUpbav2VngsiH14xDOOTxQB5SPJWfGlfPUmOq4/A?=
 =?us-ascii?Q?uUlpOCLLcWSdV9U9GR023NYHy7lUThoe3lQbQtCOqnGK5QnifmU6e7bPt5Yz?=
 =?us-ascii?Q?g0mz+p2XfNn24Z1fNnEKWTbTXYNfOPdi6l+sY4EfaVKXnZ0JXFBlM1OZB4rg?=
 =?us-ascii?Q?l9xzv2LfjKTgEGoBQ8RoRAvUTe/BltBlykJbDVzU6SmtkvsDf4ACoAbejikd?=
 =?us-ascii?Q?IQGYgzUwkaun2SQgaWPh4EmqYV0wYAT62ESkrFZDPT5fI6sRZokV2hUNuovF?=
 =?us-ascii?Q?AboMqQcD2j7IrrbByiHzuz4Mcrrlq5khgY+5CFZXKzg+XhuqLOf7P4p7pqGM?=
 =?us-ascii?Q?yZ57nsP9WZgF8Wfqhw4KH6zyVw0sQ6aIBaFbQksJjnAYcWT+o+wRwMX17HsF?=
 =?us-ascii?Q?FrRW9jpC60WFqWlrkp8zvfA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f26ecb6-bdc7-4161-0ff4-08dc54e6ea66
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4226.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 20:36:33.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxM6TkhxHwJEDyTTSYSFwAvxKGE41h+CE+AHUlSHxLDeIXgXmyrADUygnv/YKUIhI9d6502v/TXO98pmqWEbfwiQx4zam6DgOhxA5L1/w61hK2yz7y3aTXnC+L3rSzJd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8015


Hi,

Could someone take a look at this patch and give some feedback?

Cheers, Ilkka

On Thu, 7 Mar 2024, Ilkka Koskinen wrote:
> The driver enabled and disabled interrupts even if no interrupt was
> assigned to the device.
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
> drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 50b89b989ce7..2cbdb5dcb6ff 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -795,7 +795,8 @@ static void arm_cspmu_enable_counter(struct arm_cspmu *cspmu, int idx)
> 	inten_off = PMINTENSET + (4 * reg_id);
> 	cnten_off = PMCNTENSET + (4 * reg_id);
>
> -	writel(BIT(reg_bit), cspmu->base0 + inten_off);
> +	if (cspmu->irq)
> +		writel(BIT(reg_bit), cspmu->base0 + inten_off);
> 	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
> }
>
> @@ -810,7 +811,8 @@ static void arm_cspmu_disable_counter(struct arm_cspmu *cspmu, int idx)
> 	cnten_off = PMCNTENCLR + (4 * reg_id);
>
> 	writel(BIT(reg_bit), cspmu->base0 + cnten_off);
> -	writel(BIT(reg_bit), cspmu->base0 + inten_off);
> +	if (cspmu->irq)
> +		writel(BIT(reg_bit), cspmu->base0 + inten_off);
> }
>
> static void arm_cspmu_event_update(struct perf_event *event)
> -- 
> 2.40.1
>
>

