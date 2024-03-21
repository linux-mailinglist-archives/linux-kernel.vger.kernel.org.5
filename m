Return-Path: <linux-kernel+bounces-110505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47D0885FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58961C21E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586012DD96;
	Thu, 21 Mar 2024 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sOZqKU0A"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DF028E7;
	Thu, 21 Mar 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042571; cv=fail; b=F3DCtJAAzhclnIS5QJULywXGAEwCZFkK1p5cpGwUW5SAYH8OfCPI5hHI4Nab0h9+E2BdjfTGEerOlsLjDtSegUtprxNXB8V+e7m8G8cI5FtgSfxutGhF2Edzl4n01UTbldMSup3Sgk9tsD50Lb1IyWzWhTO21/kDssx3MKZsXg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042571; c=relaxed/simple;
	bh=GZ03iMJOKtczPotzpGGMpHdCKMibnI1LbOqksyKnbkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZO5TwIaD4ew5Mf2x5Hc2CjmmW6/+uI5CA2spyvAr3PlP266N+vCkZYGAMWgZ5FcKGyq1/BJo9tJPHAXm1MIP11ZZDCUCdKYKLZTSO+Sb5DW+a0EeDI6PY75DEwXsf+Gvjv3WxzFzy9otCsWTrdQA6OHVeMcHPx55Han8+uYppvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sOZqKU0A; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNd7/7NPjdAmwNGWpWW9+AvCZiPw5AbHZyyirrs5lxAlo6vworhif/4dS5Lo+Z/Z3CQ/q0NtmJu7V0lfTI1uSnicbzy6VmD8a4EyUAglWDpJTAYSly0LlOYTY+B/ncvBKpBSnb/K1xnqLcA5TJpsS15LxJjBmfD2VTXczva/+MoUA0KaCJ4xdANGqmiL7QEv2hAjBuOtmO3iui54/F0TIA8wYv7lDn7JJFjJR+ByV1I5RyvnI4dQbg3+DJwBPCsjDrISX60D1VvDVp2JU1iU04WGpMIwghiFzpidoTkBECr/qlUnolGjQY+e7VPczoemwyVmJbtekRwrAulCyCQeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDTqASoMgTCAN3yP9e8ROFurv/x00sqsksjT4uTHZ9M=;
 b=PQ+1GS7ZuX2W9uWVALTDRPMn2FpYPKZmNRct1RnJImDaqpgfloYTrRw9j/iFDf9s1qCs+3a8rAGcE9xq4RDgvSk0ei7VEgm1aYXjdahzEehuEUXu22HUjxTj5u6vEIE3mp5atQdgAzs4LhjNwvuX5ECEDhFJ43pdVeu8rcU5yOCn6hn9V265/q+B8mTbu9/DH+tuBOVk6oQFeJC5agEKSrYKpWcOVHK5sTv6206TdW7HSUZ8ThUxQJEJ9qdyZ6zVa3Sh+9AHueqiEra7gYfnp8IQReTdOqusahgQkG0Z1Ucbt4YURHeReEa7/q5M0xMipqoBOL64dd7DBa1UUw7dTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDTqASoMgTCAN3yP9e8ROFurv/x00sqsksjT4uTHZ9M=;
 b=sOZqKU0ATIOtuDQvYx0f79F6Bc6sMgCS1cAy943YoyqvsBc3uVBAhpW4I545pFZYM+E5hCp5SSuqpmSiFp1oKptFbzMh054IJgggC0SIDLF+YaYLb10sSjd1r/XWLbtCMKQGClY47lozNIppYBIjKgle4xpDFiW6UO+NwVMGp+4lCPQakZzQ7OYETnDZrs1UXWh6ERBXFMU6nZ2Zlqx18d2C/7eOga/GLTCJOkkU88ItoZgdv6kPvoS/tX/1RTJKwxbFk+hWWDXhX38ZhvW4KG3U6MLk6mp77wNZ5Zua0gl1OPSZISPL1lxM62rRNIjRbeivIqePlI7egJ2uDohwJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 17:36:07 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 17:36:07 +0000
Date: Thu, 21 Mar 2024 19:36:02 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>, Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Message-ID: <ZfxwAnaajoljBDai@shredder>
References: <f08ac289-d57f-4a1a-830f-cf9a0563cb9c@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08ac289-d57f-4a1a-830f-cf9a0563cb9c@moroto.mountain>
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d72560-9c4e-47f0-c03b-08dc49cd63b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LnqFziNRBtGKArhHOmy/FLDRpL6p8Np8yLk+8IYe29CdepF830890r6bxnO3k2ov6HP17H61qdplxGpGvFXS7/AbU7LPW9Eer7CzDP3LNifTUOdPYJ5hpwxFHjIkYxgRjr3ZEb8tB4a64nowk6IMVnanEmz1u8vzObkudlYrBY7ufEcy3yhqh3TinJ2uog6/9ScKHyCgOdukUjg8omgbbiy93DGps1+D6a9ss0YjPPGRBr/pukQhcb3HtjQ0wDmXWg1js7m7kfqiY/Rr+vwv4Nu85jQ14YPtTLvonsWPeYefOohEXeghuZ59ZOyhqp7jZYKAHOYPlVwDO+Vs8pQgQKMRxBJ72jbI0pb9g4rDOwjXZpttSprxrMe8V2xAGm5LxlBQwE2t/0HARLddu5De071j/r0ca4CLLLpNgz5wduOXnnmmpeSTSn+6i3Tg/IAm/3lOSpJ5mC01uJCFnL/gZ4VCLtLtJV6ZA14OwFgTu5P+vOiuOBeVwUrp32S9dF5q55bdnvhTG6TY4w3o3DJ7uYSlI6An1cZn8qEFNp1pDiyXpvWGNCShSZ6TKpGFbFAL17nmd9QB61c7B1KuNp5FB2Tdxut8qsv9ydguB6Qk5OKDxE6JugTvhhxh0yjY+j1uwOciaC5uqm8FTgs3WMKPaLzqnzm7mA98/4lS5tGcHmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wf0m4V1ZDlljc9PSmSXfoQng3dO4VQoafO4+FMakaA3FNLPCHHkUBukDyd7U?=
 =?us-ascii?Q?ul9AGRTUriSzctjXwYumba8vEAiRjcLEG9Mhh1g3Wi91oXn10oR+sT/HDzEM?=
 =?us-ascii?Q?/H2d3JoIG41a2bOC0WwuryD8JnFqVrEwJ9hyOwXXrHMYWo/nlxH3+6+4VqX+?=
 =?us-ascii?Q?kL247VeX2Dvph/Uvhaf65cnUx75/AK6BOS8Y8Jn+0la4LlBTauL8v9taN3sg?=
 =?us-ascii?Q?uvgG2X2qSbhKidD33jSgt7cI629S0wYBelhvupF3+PV2hRFPk4mMtqNUh1WY?=
 =?us-ascii?Q?nYv56wjkljX9eqYeJuzenwOxI5BRdMN79jAJKzA8OLQgCzJmJEsTogc6UpMO?=
 =?us-ascii?Q?+mKF3NqB5HdCq84cHHAIOZXdDfxF3FUAww0Jm73q8pV35ygcFHo7+A7TOyu2?=
 =?us-ascii?Q?H8Th3NrG/IFqyLvqQGv+LOifB9URV4kBO4h9qOXYCRYGxOusHxM2FhZztc8y?=
 =?us-ascii?Q?SBt3rrbMnQtDYqAK2o6JnrWzgyeA1dZR2vQwQuVk/25UT/tQRVJeaRBI2T7T?=
 =?us-ascii?Q?kibDqzYCLLmR/lWTSJoBA0Kmim9zTesWFTb5a/NEHvvvO0HFNEb3El7sbsta?=
 =?us-ascii?Q?ncUSUDhsNoftr7IyELlTDN0oT+4tRP2kENcG6jj6U4PmtbzQr2eS9NaLO0fZ?=
 =?us-ascii?Q?J2qcQQk9vjn3UPClgZDpnuNar7dKe2gNzhhqOv9d4fXGAzmi3YLnrSalIY91?=
 =?us-ascii?Q?2FA7fBjKHwsKEgUrUsrEQSz38X+CpTDo69Zxr2eUJOVkUvMZEXtbSrH18IHY?=
 =?us-ascii?Q?xp34g8gFFbknrh2yGjncqF6oTOuEqpdhFo3a1BhGX1iOQ+vtE2HHG5OtQLDQ?=
 =?us-ascii?Q?/NKU472Mkt6CaGi2mo2ec2O33JnfCYLm6D5gKCJaT2j3D3KqiYcNJ+pgMbm4?=
 =?us-ascii?Q?GOgQF94XKiE6x5lPrr18ZyFYeYIz4iMDDB9zcWjidQiwtvEXwJUw4ee1gds9?=
 =?us-ascii?Q?ydjAUJzL7LDvbURu9RAb0czcotKo/45MG9ggLOzw6D3kedrfscvaeKm8H9jJ?=
 =?us-ascii?Q?gqxHUpe6Qt+rR3z+UzDDGZXkELlRbQ647T0dUHVXWGo8NxD/8qKo23f65Jra?=
 =?us-ascii?Q?mZL4IbhpNcCalUJ45eiQvlyV6x/ii69qFR/7eqjGJyppk9mKxbdZ7ksQiS24?=
 =?us-ascii?Q?i0sJ+hT6yngCkR4ELNI1AUCUTOSR2uW/oudXeG/7UzrLNdJsBCiGJMavoA28?=
 =?us-ascii?Q?uCFAr6YvsFb+TepeG8N/DrEPJf+535cpTIi1VcjcD/sRXRYuhLWNsuIqu1rn?=
 =?us-ascii?Q?SCO5hRVlX0UWHq6T5LD1yWdf4aPqum8s47yAsliuydBoxyPYuc0OfkqWPzGm?=
 =?us-ascii?Q?gI4Z/PqSjUNWwim0Ij5g30xkTSRsDVbSJ82Gq8OW4u3wTvgU6Ad8fQVdAFVD?=
 =?us-ascii?Q?pdIebfdqRxaQIZFja4qOvFJBDvqgqj8eE4Q3h5ZeaCQNrRPgNm7AJyUN0wgo?=
 =?us-ascii?Q?2+9+Ny8E2BPlTgWbIBvIznwoHnoRK2R1KOwf5TFYHDtfs/oXOUf+b2MtP5Bc?=
 =?us-ascii?Q?40OwM4WxD9jpGWQuT+4v9nwVD5c64D/IYjE20X5dIH4IklEyIMeeZgEhiS+a?=
 =?us-ascii?Q?ywf9cWx6QtAOGRiW3TXUloltMWxW04ntUsQQquVs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d72560-9c4e-47f0-c03b-08dc49cd63b8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 17:36:07.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OCzl/KJEqhMhTzpBgDiJDersYT2v9oCp+QkOC3rimaWzkTuOo+H7R2oJhHCTquHZ9348MQCur3IztUG9n3qTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968

On Thu, Mar 21, 2024 at 05:42:18PM +0300, Dan Carpenter wrote:
> The "*hw_stats_used" value needs to be set on the success paths to prevent
> an uninitialized variable bug in the caller, nla_put_nh_group_stats().
> 
> Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

