Return-Path: <linux-kernel+bounces-166465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C066E8B9B08
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E716FB2195D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497C80045;
	Thu,  2 May 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XnNXNUHA"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2062171;
	Thu,  2 May 2024 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653672; cv=fail; b=jFel/pllcufEgILi8VpThXKUmfeb8fU/zxMOZwmztp1vyeAbzwC4LJjd3wfb6/Ar9a35bKcjJxVdnIwk2y0WaVshq3jZ+gI+0QLALGgwf+MQNRNOluqoaNXfc0gDy/haPBRoCiQA1Xfw1LdHik9qTgy6nJTWhxHXtYu9pq5o3KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653672; c=relaxed/simple;
	bh=VtY19T6MiaeMlVqXhFhraqN2XKdXspB6Jl0fpVG7HOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4xd03hiRfg2LOuJiQnFUyibSUjsx843Luijc4yXWGJTLBRP4TCCg7F2/DAlfVbykCBVQtF2A+qlWDy4Vx/PvOAbRmUBcjtXsQtQx43EiSItvWuaDZvSGqOMuJ1HZGIbWU4p0dCeJDOrW3jsg2Uh6167ykzOQoAfT728harSvX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XnNXNUHA; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXmXDiflWZ37cTgdybzGlsDHA3Q2TuQdLDKRuFbjkWUpdOyvfsxDeB/Ke86VcsLEBcMyzUFVp2Jm/mNOyAHNnAK9DWTt3FBTxEsxv+9AOtc2h+qbZqkmxPfq+8KEh8Ysx9jmtH06KeYRbUKBnVUOM7SAS+VqOS5SrndpZpscK2TmGvOl7BbDM6zWO87H2hhvy/y5G51VZH3zZAcBcre7fLRgNBqFndJ7DR3xCzF8mkxDthPYbNNqN6wmsmvIEGNnXSIcpkEks2vFmgD7QoHP/Z6KqWeSsaXk75WW9hbS3OYjhgrL7wYLGNbZu3xV47N2AGxZ8UlKTXALRq79lnqG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGBW06E1bK66d7SVTEMDUBfUy5xHLPWst8EsMNKip4I=;
 b=Y5Ai5reTIK4x+IG8fXCct+YG3IvMhXKpRKBSrfWU555d85+bm0aT5KcwZpNc4b6ZVZdiv+IeVqGHYk9PZEGhA/BCrfbWuJ4b1eykwJ9q0BA2BfI8G+xcdTY+dsuIMD6l2xbOKAnVGFFCHqaCXvFRJ/rF4O7VfINGYKkq70U/DUDsgNaxU3+nVKRArGodqwBrwgKozcuj4fNmVoH9ieXJdJTuyKTN3jF8XIv6xF2UdVf3i6kx+6DnzANdIYvPi3zBR2OS3b+2X6c1ArW7BjXMaSNeAsXsqSIp+Uz72i7VZVSTFYzsmehdkXo2vxrT8u0mpdH2y+Eey9fV3xQUXed4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGBW06E1bK66d7SVTEMDUBfUy5xHLPWst8EsMNKip4I=;
 b=XnNXNUHAOn/25QcNz2eOW8oBzmQTIx0oZFzPEb1Mr6/iBjQFm5klj841F5wPyHT61oAxpu8gzBLu3oHrXxuvQHSn1vxHwqbzQizXYqbUxEwLCnVCf+jCfK9/3ZRPnpA1G9eyjgGNUUjHgiWCl5NjYZVNmhfSAotGjPMaAoaE8NXxjKtZZHJZbkx+PnJ2pESfC8NWaTib1ZcozqlZiGnLQ4GgTeN2oE063TY4mL1dQWNJUJs+ubFhyqxqKBhqalv62tWqj+qf0ZQGONY0zZnZH1Fyqy5AwuD9CQfIoJcnUJ8r3QzESdKcNGHWY2GBOhKPyoGfw40iyElomuZvzanT9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 12:41:06 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 12:41:05 +0000
Date: Thu, 2 May 2024 09:41:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240502124103.GA3341011@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
 <20240430163545.GS941030@nvidia.com>
 <ZjEztwhd5AN1FTCk@Asurada-Nvidia>
 <20240501130042.GC941030@nvidia.com>
 <ZjJ/S1bawYkfs1I4@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjJ/S1bawYkfs1I4@Asurada-Nvidia>
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: b45d34d5-e3ed-4c78-3708-08dc6aa52250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+7USZU7Hye6SWmTNB84ga/tJX4Kc5M9UBk6OwAZ2SnuV2tgjdWWzIoBa7DW?=
 =?us-ascii?Q?Yn32JahkH+7VNJG811OoyqiCceS2pZghOGTZjQUKn8jcuxxFUTQoh61CP+UR?=
 =?us-ascii?Q?8iOoxkJqVFowcjOtf5YlM6OjKqGjqlc6a0EVF2wjogDHkH9jA8Zz7x4s4PP9?=
 =?us-ascii?Q?eVOsnYYmItKScFyJQAe08N7UxwO44Ov3Yxec8KXEaw9LcPi947zMafhBGJxx?=
 =?us-ascii?Q?6B1FNGYJaIFpfmz9LymkU/uYxvIqHK6B8e6oE52OuIYO85W/hIpmW6hqksMj?=
 =?us-ascii?Q?mlNSyew7mURq1MeLiAovjJEEDXRBrYwPk7vJdrkByQ9KlwUtCC+CklhUMtXY?=
 =?us-ascii?Q?yvw5I6ft3FYXUTAu3/regLWJwpJiJodcOZ6JB63lIdGuZWA4wbj9akXkjTI/?=
 =?us-ascii?Q?gRcuK0j1nY3dl4WRyuvZKn52yRWbuaIa9RlRFqreRE5iGl32KxYUuJfLgatj?=
 =?us-ascii?Q?wrFspW6NY0KGLz+wM0Bg3f/ZNpPGYqoKifBKh2T76GfRuo0Hf7unEi4wX9SK?=
 =?us-ascii?Q?iLIgOKVb1IX+ztyu6FYTARJ+C03VcvePrIrrEarMf8d9DtXbiw12RUZvxPDm?=
 =?us-ascii?Q?ii+D5oOkhpV6C1j1kgUPR7D2zNsl8dDk9zVoYAznmKc+C7Q0PeyyXMYSFaZy?=
 =?us-ascii?Q?yTKRntNm3i4k7eaLDIEzVLdBySprooTxURYzxisbDrIKNRObbijcRpqNh+eg?=
 =?us-ascii?Q?wOM1zQMSdFRzuxZDsIa2xPtyoASGR6g2XU6tNthFcjog2xiSR8MR1bSBiOpP?=
 =?us-ascii?Q?DW8UAM3hJH2qQYvTg0y33QVoVGJ1GPWCBBwMpYHdoREqUoPi/yXFJhq+LFiO?=
 =?us-ascii?Q?wM2YKCgEeeo3ycDRdzXg492a+RqgqsD03QS0jRhqKuZVuCWDvbavxSFb1vmE?=
 =?us-ascii?Q?8bHQe6W/Q4LdhrE4V/RpKFgovAm/pKyB7yijVnpwiKC2q/LSYY9ib3E+T4Ef?=
 =?us-ascii?Q?t7gSl0jYghsc7vQN3OiauBctVnptws82p0KGxCm9aYeNRkRfrw36uSo32PBE?=
 =?us-ascii?Q?2Jf+l/wtcAN9O26oL+Ge2ENIGNndHe2DlMRoPWWFPkIZJXuiZ4hgUqR162TP?=
 =?us-ascii?Q?x4xughiC6WT8AOA0RiFq1zytugBulD9bpxpFo2pK8sLPBL94ZSSKkStWSCFM?=
 =?us-ascii?Q?y9j7jft3wE6gJ/FWIku4CSgBXiVwg/gGssAeozTYofIaHffdTBcyDGP7/T6H?=
 =?us-ascii?Q?WsTzFAP6tFsnTd2SwwNbrsbSmID3mfZKMQmYPCpQgCfltjKE2DX0GlhyG8jo?=
 =?us-ascii?Q?tqkDan5zy6yApALf9nF56PAsf/v+Wq5v1XLAN9KFcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlqlVI9emcXs+wZivqymU4KrLicfyR43lnMuv79Vud0gO+DJbW7TUxLP1NoR?=
 =?us-ascii?Q?prTfwq7a+o5BO1iJA5jKB5klDpM9NrPECJKh7pvkDG4bhFMrtZx5XlnlfJC2?=
 =?us-ascii?Q?U1fz6ZgdzevfCdYdfCvuQV+YG2eJVJswGBLpd1+mepxDpoV2sLeGXxAByxYA?=
 =?us-ascii?Q?68kS5HKmCgCQfv7BFEZfhQllNyS21osb3h4B9Bn8kIqfeAXTKQ2ixe+6xDN9?=
 =?us-ascii?Q?KTh6ABVIAhPI5VgvJMsMseQfpypEtAVpl2cji9nsaCI1Xf7Sr11v823+no+F?=
 =?us-ascii?Q?lfHH/ppt2+NrwpGfzyFzH9JqeX79iRCVyj92rekC7hY69F8ChX48ZU3OIo9l?=
 =?us-ascii?Q?wKr8ej89jtglzDnmzZn32Z6KfxfEHl/J3Z+sL6KDg/icKNkeEOCNELLiPBlZ?=
 =?us-ascii?Q?3SPDtRncL7JGBy+H2vHxmDCtittI24e5XLrH4wGwEnpDTc0hdv5juAY/sNAf?=
 =?us-ascii?Q?Up9YUQ5y2PPzQAW3jdXquA3/IVV4GRwn3Z4o74BifUEapd1YNba9056UZC7j?=
 =?us-ascii?Q?ZddeQ96oIhhVfb9n9BeqzYGBnXqVzOHkcL9rEPXXBMnumShlOd1fRPFfnT++?=
 =?us-ascii?Q?w73t6IFBeONSgTGTYFz7vMVXLztGbdXw7i+vu95ZnM4Ts6VF0QI8m9skgmJd?=
 =?us-ascii?Q?5A+rERmVjrMOB5dpZRV55vVWFfECZYLXZE3totxi8h6HxrlzSsarXklJCM/L?=
 =?us-ascii?Q?nUMLTZ9xGATGmi1nxuixJ2CASDlqGWbgpZIwAd3HBPSGWyHqy0QgUV+DxCVZ?=
 =?us-ascii?Q?M2J2KS6PliBwZHQHFEFkyPA/Z54S5prayBct4zhmt4urj4C4mvnopdh+ptH2?=
 =?us-ascii?Q?OOwjLJZ3flyAxilzBvkBDzX1BPLLkomy55pM7RaFBwF7XqzWVrcJnpSJWZCA?=
 =?us-ascii?Q?bPPKDfSTIco6WxxbiTvHjJRkF1t57yjrEZjJ9g1/hgknEJtobsKSogLzGzMm?=
 =?us-ascii?Q?0faU4eBLlp4iHYXqvKMIQaVvFoiW7N6lTWOf6cN1yGyGBI0qrImzRlnOddkv?=
 =?us-ascii?Q?9jIPrURJ2n3QWSGBHwHondI3fFOJuGQ4LQqPKbor93p3vmrYDfvW4ZXfw/EN?=
 =?us-ascii?Q?lJjO1Rv8GLcwcPjOSWfwIXS2Kdu83Bhz6xhdDenQBff9bmL8m4uH4qdEp2dU?=
 =?us-ascii?Q?fcu7OUwMifBdUEVoIDhN6yJfb8jQVlO6BJRhZggyHZl8Zm5tx4WeOQlrNWwP?=
 =?us-ascii?Q?uU6XBePSwzMcPQzJyU26iw/KyZ2wNHfvdsYNWQEQ2/oBnhFRuhWlpQcPX6vq?=
 =?us-ascii?Q?QmcWlllcHwWmQRWRUphIqEnX/6/FYDw3QJDkYsEc/YCp3fTG0FEMinS8Z/Ip?=
 =?us-ascii?Q?i3ctb0QV5CrWchKmLufDEI9VHcXLSgfPizJJXQbnqY0BNuxpUv+c3S019DRi?=
 =?us-ascii?Q?/26hDb1Fl9YaYyxBnW1kq+rqH8jGaULtuwZI6OcWoQitzqypNQuLCS709AsT?=
 =?us-ascii?Q?WIuwDFPZOXVoiPKgSRYyomAWKu5yPl/5X1/fCb0I6d0YSu/wHISfKeJrECaU?=
 =?us-ascii?Q?+U+dm+f+yX38nElnvIIzEmtXkEtcanpaZe+KZ3rkj1oSoJzjyibrXjkmdSoa?=
 =?us-ascii?Q?KebM20sbZmb2E8CScZQXDzyka3tF9IhCNufMvdHC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d34d5-e3ed-4c78-3708-08dc6aa52250
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:41:05.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjxqldUZ3yhYAttK4WE8WRXb7yxC2kJvjZFJ6aQqMHFHbKaQw7rboEJ6DtF+B+yN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485

On Wed, May 01, 2024 at 10:43:39AM -0700, Nicolin Chen wrote:
> > It doesn't fix any real race, I'm not sure what this is supposed to be
> > doing. The cmdq becomes broken and you get an ISR, so before the ISR
> > it will still post but get stuck, during the ISR it will avoid
> > posting, and after it will go back to posting?
> > 
> > Why? Just always post to the Q and let the ISR fix it?
> 
> Yes, we could do so. I was thinking of the worst case by giving
> the guest OS a chance to continue (though in a slower mode), if
> something unrecoverable happens to the VINTF/VCMDQ part.

Does that happn? The stuck vcmdq will have stuck entries on it no
matter what, can we actually fully recover from that? Ie re-issue the
commands on another queue?

> > So just don't use it. There is no value if the places where it should
> > work automatically are not functioning.
> 
> I thought devm could work when rmmod too, not only when the probe
> fails..

It is limited to cases when the probing driver of the passed struct
device unbinds, including probe failure.

Jason

