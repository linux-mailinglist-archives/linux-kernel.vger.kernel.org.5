Return-Path: <linux-kernel+bounces-141258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250BD8A1CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC47FB2F5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5412FB0D;
	Thu, 11 Apr 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="jlCOKxsF"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36012FF67;
	Thu, 11 Apr 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851371; cv=fail; b=PS/3drB2G94RqD89Jy5h/3eLmZPTDV+v4fLzt5cxHQEeZl1ioMeeuYWXcFqckh09Elzsm0/A2YDlkx3kRs4Nz6senog5YiVWt2jGfrxg3pkLcof91lg1kiS9848vrKPBJzsgX38zCHbHTYt/OlDRnV4fGwwMCBzCRtCFlORZ6/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851371; c=relaxed/simple;
	bh=1xL649U31VOtmeiS/61m4WLQs0zSEqZ5s+ShuovjfUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I8+knzc9tSDKw44RoHVeZK5RlO7JbvhJiI7Zfd7fnrM7hZ2896BvRYGAysqw2PrOJDXNbTqxxk0v7Z+f/88+kp/PXUiGSRGtr1mTRhgNauhW5mdu+7+V7rqpN55OZ1Ct0cXSEHMIYWdDwN9BUdI4U3Q0u9ej4EJANp5KCmvfYXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=jlCOKxsF; arc=fail smtp.client-ip=40.107.243.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbglsisoX8OyoXEmej02P69e8l5oIipO+ktiBWd1eCnetboejL+E79clTgCahCzUez6OWsruG6jWEtFiz2kz5GWNuN/SrWpqP3FG82sRL+3tGuTFF44bC1bNaIoKvvZ0NXQizwb0j3wgsQq/LVDQ+u0fDWvYMyeUQJspGF6GgAoJ+yq08Y9pmZHZrBQyZoPaOyEIy7aHdtP7I8Jo+Ql7altkoz/B48zMh0GN4ZG+0TD2cBDWEwashSGkkb3RYGClZGvLtdCzYiBXP7cnd3vT3aV6kiNZjmfUG57LXTSIxVBmqGBDDM2oeZM2SGcekaBCT0S2fYO1UmRcXoKNsSjN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+xf3dZGJuDqG53oJ/04GCwB6JY13dA0SPYb7qsRhro=;
 b=mQbueO1Kb0bZnIJ3ZmHwkfxX+V6kCduTe5tDR98Km3cwTS7sYbMK+pm5/C91/in+zcFvHq6NrsRbfZNdmhAC4CyibSDmvbZdHXivo2SCI4Lur346u7+U5ln9fqpw5yBS8ezSdT100jrnbQmNURt8rostLG1YfJT6Ooq6f7p81n9uQbWiUXvv+E/Dg6WoOmVI/az9ixmDrUYznVn0B88XZSdX7/l+K1mS6GIQiG8s2QcEhzIujT/P9U823ZxzUdo3DsBCjCmjFC+6lP5Xqmw/F2X65QXxDbLSZeGzPH3Lpi1JW4VH5MgXBP/Pvitn/mJNAHDBrsojyQKrQKSGdxYMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+xf3dZGJuDqG53oJ/04GCwB6JY13dA0SPYb7qsRhro=;
 b=jlCOKxsFbTRWTwyecrgKvPjstSE+wUpXn3R3xxy2WLUUik0W7ak/NO9welfgEJGvHQmhUWH34AM8FW0KzZg5iihkyEl7SwGOLI/0k2OPDOpQcHvhUzyk3Kv9k1DzehwLAO1hr0pbl7Kc1SXRNDRIm3ELOngDTb5MR++l8n085Iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by SJ0PR10MB6421.namprd10.prod.outlook.com (2603:10b6:a03:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 16:02:44 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 16:02:44 +0000
Date: Thu, 11 Apr 2024 11:02:40 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 6.8 SPI Chip Select Regression
Message-ID: <ZhgJoJQcQFSx+dti@colin-ia-desktop>
References: <Zgx5glZznSCheksj@euler>
 <467644bf-85d0-429a-bd11-7155b1cb5fbc@sirena.org.uk>
 <Zgy7llSklu7iU2Om@euler>
 <Zg3JJtzdB5Q3aGsl@surfacebook.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg3JJtzdB5Q3aGsl@surfacebook.localdomain>
X-ClientProxiedBy: MN2PR01CA0035.prod.exchangelabs.com (2603:10b6:208:10c::48)
 To DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|SJ0PR10MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: e07c61ef-0d9a-4855-27f5-08dc5a40d2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7vC/DzwJB79ditah9SIsny9/dzu3mmmdCrpy2m6KYP1IzDcOO3bLi0fEr5VyOXlFKwJvIjssCr1l2AtDhEcVokh0vbaxK3is3K5ILNSrwWk6kkSQ+t4crF0CyxZdoC40SiwnP8ermM8rpwrRft2PAKNl8+H/en/af5zy8uvqFbgFnl/VxOD3mTWgcfXU4nab+XCRVF/4SY6c5x3vpGE1jIsIZFOZjoZ6RvqlW19N/2bP93Q0CybfY+Y3b9qEWNSYY2BWtAFZdLwM4KrEV7fLQo4UbU5UXcDDKOTQ/XlMu3qdFFBsfIx9JuQtJFsvrKf8+gMPftnoaIczxz/AzV+Nihk3U9nMD4qwj4xPS3ucFTd+XLrrGbCEGwlKRBzp/3Gqe493yca+IqWCs2HzRC9uqh+D2wlw/rg6XT5t6lstQNXgdnBedJxN2rYwYOqDNRM0OqqUtFGaKJw/rp+Czy7sO/y9Fjfojab5ztr4vX9iJJ445KBeydtWtMtlrEU3c0IWEPiyOwYzLI9k7KBGxOXV5M7Cjzl1RhbeeKA5MHYcCKZLA3vmDeUQBos7iSZmfck1M/bBZJjE+5YhQX/CWwqyLtsAAf3W61HTH05DYn4Lkd5+f5WzUTgPy7b+jgkFxRfNT2EgKYF4Bh8kSM/WeSjAvv8kZ2GOT9BvMi8En4tUNzk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9s6tzgBOzaO4gP+FD6VlvufPaTNFNFgxlw4BxNIUqAe/PbXqHh3qBTkeJ7kK?=
 =?us-ascii?Q?qPFBMl50GWfsps+mPjA/fe7GJqBT4zSMfAviRY4XsHaDutjqZu2uDj40OIyk?=
 =?us-ascii?Q?tqMGEFBaIehosv4PHoQJwu/SAoxI2hKor8PkNr8FeM2u3zf9vU5srqq74DNw?=
 =?us-ascii?Q?nn8r0BMBK1iSE57p+RMRdeGE+qyLbQQkKLckdRg8kuHjUT3Mf7zlKsP6h5y3?=
 =?us-ascii?Q?Afl75Ob3fllyNANMHa1BD5repMcy+G6DBvtNLI4uAwAWNh0vG/pBTaADR41R?=
 =?us-ascii?Q?qrdEIRTuC9sxxrfH66qJFPlqYKOJGrisq8BSjv9jPCR0i07/jdvXXpJ8KZW0?=
 =?us-ascii?Q?VbdOu1ArtJBPPNvR/VBvtDVfHFmUDi7vtJu9ma7DXzceFXaGMqNu5Sje+/gI?=
 =?us-ascii?Q?h6KenP2+UwdNBsNjPpIkpLna4w+8owGoEhmJSyxqHwPEYvcz5nLnMFSus0wD?=
 =?us-ascii?Q?d5GyuEa7Cgu2U5eY9g/oal0QnF7Tj6KMHM0eaB6sW/eVuKK3YSEL1uWx0f76?=
 =?us-ascii?Q?JKNO3ZpJpIRoeO4FpcBr9dAHcC2LepBJrC/V8RSBxdToogxCIrgji4xXu/Ag?=
 =?us-ascii?Q?UkY7bxPe3GfAs7gchxp3eWDVBWFNCYc3Vx4Bsde6Xc9yPnU0XMZxXHKdXkS3?=
 =?us-ascii?Q?0It400FoxeKvSaMINeKIfse734D33/l+zNM31SeKY5GnqniRyRhTvT6izrzB?=
 =?us-ascii?Q?ZjtlQHAAO0N2adjnZakGYM9UKrO9IjusDyno35sWipwhHeCVaFK6DetUWl7q?=
 =?us-ascii?Q?22PD/CyE2eWPWnTkH9doZks7LIyAHpwEE/jzilPU5tsu7R1tRulUtz7MtHMw?=
 =?us-ascii?Q?F76V04UveKFrxZ7Xn9uL3votytZOV56R3gYIxH2DKyh0h0Qm8IipKenLKyuK?=
 =?us-ascii?Q?bOiGJ3qwmOkZ1T/aPqNivwkZYtHlo7cJBcVbCxw5LCDSS5YX2WMMy4/4sG8g?=
 =?us-ascii?Q?cA3glgF/hKraBNxfViWwgjcUYKLsBy4fg1EBSAFVPt/z+oC5pyw5iWl8mj2i?=
 =?us-ascii?Q?asVg7DQPvKnbvevgNp7JI0Ic0Q8ZVvn4HdR+XfbjDDE7mxjhGc67y9RbxN3W?=
 =?us-ascii?Q?cTdNXWu2rPh0IUNMjf/7mOoDYy/+rdi5yISQAXXKpJas9toCKQD8okRTfjRk?=
 =?us-ascii?Q?zRRCSGLST1G7n64XrpMNXV7+DijKt6wCTYaP7uYfP0qeRr/bmFGyEpII2T2O?=
 =?us-ascii?Q?DKDHCS56oj41sB5vIYog+njoxoDRXFfZ+n4x9u4ZulRnb/pTtYPrbECOpgQd?=
 =?us-ascii?Q?uvmDAKqbG9iYvzKO3K6/YTaIrKUcwjBGpIiJhYF4EFtdLTBwFbtcIFx/TXRv?=
 =?us-ascii?Q?Hjxz0h6YXCs8hioRfHRUv64VkB2jWD3N/pCWyYljerL0xuCjPOVqqzPkM/bq?=
 =?us-ascii?Q?yG5Gvsmkz/ItkjN+rrIddPjFQv10SBsFW05s5kD46owG3LI6x68pBepwIjXQ?=
 =?us-ascii?Q?2vmiyGZO0kELKvatVPn+qv6BAJc7KdulW75rWinS+vlNvuaJu60yzcR0vV8I?=
 =?us-ascii?Q?GAky6Q69le+7NAeDy+ltBKNLkjrRiOZ8vTMKdjLcVPC0YTRnsrBPzlNz5Aee?=
 =?us-ascii?Q?TJb3/tzYkJencXZRHJbPHtDiHuHdwdUS0QTq4TX/C+WpIOe9GxZmbY+MmpcP?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07c61ef-0d9a-4855-27f5-08dc5a40d2c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:02:44.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZW2XGOb9e0peLKM5uj8WMEb7lA6wKC740Toe85KpB/52W3WOk2+OpJrUaszFAdmGneLY+xh2VeZP1ypWtGFq4HHxykGzAZDzOp5zvLnDaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6421

Hi Andy,

On Thu, Apr 04, 2024 at 12:24:54AM +0300, Andy Shevchenko wrote:
> 
> You have
> addr cell = 1
> sz cell = 0
> 
> At the same time you have 
> reg <0 0>
> 
> AFAICT the SPI core behaves correctly. Am I wrong?
> 
> I.o.w. you either want to have reg = <0>, or <0 1> or something which has
> different values.

This email was snagged by my junk filter, so I just saw it.

Indeed, changing to reg = <0> solved the issue. Many, many thanks!

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

