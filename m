Return-Path: <linux-kernel+bounces-167947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545708BB177
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41DF1F23866
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7831157E94;
	Fri,  3 May 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTssvv9R"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966015749A;
	Fri,  3 May 2024 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756138; cv=fail; b=QZeXXXA8mzRY1NGmCfzELscXRe1Zlx/yaV7idhbiqe2UYId8lrthSRqXV0k6MrTjV9IDgxA0qeCj5eu+Hf2dvXWRg9LK4ofivhXQ9bCKmdZngsWvhD/TdvQyT4hxHc8Ik2mTdo3hvriq/NBIEF6jAOn2GPVjDIQwWkZSwbMgtYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756138; c=relaxed/simple;
	bh=jEdW2LbDBIrIUz/NKjIT/UwqIiAz4jyjgVwsajkIcng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o5BVYXY+tspQfciXvjOkERIQpoE6nePAxFo9Bzi51FH8dOwS6CeaFrWstcPI/4nVy1Yl8nzK1x46uZ0lCNiCn6UQQ6xMqD5FAd9uEpoSZCFWCS/i/2TDF42GolAIbUHtoFmrewzc9T44h/EbjryxKw8QF/NwFtYt9BYugS4w/0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTssvv9R; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipj6quTl4tDZZDyQ87UB++2R7QswHube3aLSiTcsNMxYda+0lcqIYs29xTKFr8iO5/r7gW3DUpBxcwCgbNFaiZp5GfTnoBJqUN3UGP/0CccLLx37pD+GG25xqZEOZkfJoH0h6y9btIC4Is0rPGz5ntHnjRrPYoJBpYZNQ0pvagEt5EihMbcB6MGfy9wjieG3iUUL8r4MNabKiZtOEQRd4co2s/GZALE5k+kf+yoLjcwUbVamx9ElDPk5FhMWzFKjiZNWFbrMybmL1OxfjAmF4wioLNkBfzNEL80M2W6/peJlbdjaF1qspMk8lnaUoYRgIHQUIucis4QL/Ms7RihU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEdW2LbDBIrIUz/NKjIT/UwqIiAz4jyjgVwsajkIcng=;
 b=S8qwUKmRpe661stC6+QgtvHSOhxlt4sM3NN3R7/ELls8RiIC/pXCzJOgq+kHHRUb2gE7O1C5BiujCVOn2tsnS4dgU9S262z3jfxAxj7S1rHQvjl7pc41mItL9ndsTXoYAXFiD1YRoWH9x/LPxuXNrdMwtLnr82wfVVBnujDA4xNS6FGJ48wYWhqcrZBQ965l1RawyljuKnbzVmh5CbddKBSwQwTUxblF9upch3reDKpDkCIUagRzzM4Hnx0TDoFte3AsnHDOGAVM43cQ+oEJJfxdiqcvWs51VZBUFPrqS40UKxoYPQulQxlp+h71UV3xppn4wH+WnxQiPBG75ALwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEdW2LbDBIrIUz/NKjIT/UwqIiAz4jyjgVwsajkIcng=;
 b=BTssvv9R1Xx6OjOAV+vFUulUA/UfisdnpLT/bPTAAcJMJa8Pjg22hXJ9a0Om3TawaxkRI0vL6YCBRN8c3Jsovw+t/ie6SPfcRhi5JYHFiapiveKOlo4aqpaqno136DG4zQkc28HMwohLzu/gpftfYaoNSU/41Cf6tSwlML7jr9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 17:08:54 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7298:510:d37d:fa92%4]) with mapi id 15.20.7544.023; Fri, 3 May 2024
 17:08:54 +0000
Date: Fri, 3 May 2024 12:08:45 -0500
From: John Allen <john.allen@amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, bp@alien8.de,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/ATL: Translate normalized to system physical
 addresses using PRM
Message-ID: <ZjUaHSr1mkueKEBQ@AUS-L1-JOHALLEN.amd.com>
References: <20240326212640.96920-1-john.allen@amd.com>
 <20240326212640.96920-3-john.allen@amd.com>
 <f7e50ef5-44f1-4b39-8d60-9e271b294ea0@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e50ef5-44f1-4b39-8d60-9e271b294ea0@amd.com>
X-ClientProxiedBy: SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::25) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c994f5-6773-4c3d-81d0-08dc6b93b624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?erS6vhJrqms2xzAId2EtQSwOVr0m8bBchbNaG6+W3mzvSgphiG2AvdVU5aNU?=
 =?us-ascii?Q?5EJGyCTHWr442z+Ip2z3ojbbKTBAV9j90NMW+1i9x/o4a1l5Eus3v5Lt3YCn?=
 =?us-ascii?Q?K/5q8Bi14atd+gZxGSnEx0XyS3KYrTHUtND3Y1bYlZmwGuV6QlSt8X9m/Ay2?=
 =?us-ascii?Q?7mKYl1e5RXzLPsoLuvK5/holMyYTeXdITbtSaCR5qrUSx5993mGVFh9+1u2q?=
 =?us-ascii?Q?trkGQ3QWl10STj4RoNIYmreFRP4HQxoUNX/kMCpRNGBQ2Xmr/tORkBE0Ka7c?=
 =?us-ascii?Q?OxtysYmrJ/CTpemPRGSt20zVhOx8MO7V19drZTy/x4tgB6/BqnYaNq02y/Ye?=
 =?us-ascii?Q?4d8FjhSIE9LwEJxjEmtcCzi7NH+1npJFGx5fZrV2bbxZlEIb9jU2IL1FQak4?=
 =?us-ascii?Q?qLu+AmbxPtUK/iTaoDDRlkh07WhTyFKIMvsQC8dVYCjxE0oDq9F7EWEblhGz?=
 =?us-ascii?Q?fS6gHIZSvlncBJaTVH6//O0hR1xhz64isTQyX9nhtH5sGlPXOVxUx0ndnXqB?=
 =?us-ascii?Q?8+X1M7DWC5C7wfwseYLgLFn+zEktQ0dwv0tGNAtDDFuFuU8wFi5r3uaYYseh?=
 =?us-ascii?Q?/hnHqfjSdwvv+ISwMJ4sLgRAZ9HvzseJG+vQjvSbxuwu9TzIm+i+JbCQWt9h?=
 =?us-ascii?Q?7iV/7TlLl14AXt282Kk1R0XjdNLRUnGHD7wJHBWqZuNknepDguHfxdXNUNHY?=
 =?us-ascii?Q?frWpNSn1rjAeNv89hTJAvQK8ibTTOyXQYyex4Q63Wg57yDc3RZ8Rscn6mFHt?=
 =?us-ascii?Q?J8LCWofdv4ch0eo70ked/yqxkhl8DGmopOD3rfm0qddUzn0CGfgUthaFrsih?=
 =?us-ascii?Q?3iVXEwAysb7IbwmyIET6ltBSEOJQEhwNgfuifFY8zskn6IBGcdzSUsmNLSOG?=
 =?us-ascii?Q?CAUB0Zuw7ObrVzv400nhY5RsOm1wzZQNwRBfqUHHyIyvGsXNvloRnQeju+7p?=
 =?us-ascii?Q?mJSrTJZkAi8RkPtF9Xd//Isia48mCghmJubXXKipAjKmN1JB5wKvYTYAa3BT?=
 =?us-ascii?Q?Jfe8St1iibvwpaf11m5pc+BorJpS/sEegeLRdvIC9X3yE3afz+CqYLqZNJb3?=
 =?us-ascii?Q?Rb3o4URRLQVI7Yo9/q678mpzo6y3O1GLVylafzrEpFlf45eq221O88OZuRDr?=
 =?us-ascii?Q?emwhp2P8zhXURdxT4tR1Amj9z0uSZBufcQn2ukMXMjou91wWl6u7kgJZx9r4?=
 =?us-ascii?Q?7fH5G+qxg7gJ72BMnq0oCuUP4Yx9eqUMY3oq1OzMlRYxDyC3S9/sk7vXXB9b?=
 =?us-ascii?Q?roI6duB7GDYAQ/tLUTUVMtdTBbzwxzyHegN2wat0Ag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d/z89ijH/aLtZWkpAkACZrYLbIlt26X+zteRJmOryzIJm99AwWkWnJ5Bcidl?=
 =?us-ascii?Q?QstKJpGVRP8LLzci4bY9XRW933ZG9fL3G+cgXHD6f3nAnIT1pxu0mbJPfggx?=
 =?us-ascii?Q?MqPGUv6Ix1durH8uIVPNexHGDXrbLHmO55XLeAelMIK4raHshSrSU0h0edsn?=
 =?us-ascii?Q?flLu6leT98U2jczhRw44pq98KJoxKaPnVmxM+YjU9d4XQGnlOpehbQKM29XO?=
 =?us-ascii?Q?AC9YbHcZs13EYgb+us464ofK7yGuqhw4+BblW8dLv4aJTqO1oSY+ujNF+73Z?=
 =?us-ascii?Q?eoE/edH26bzks3+z2d3Hc+lb1xAdeyBlU646Vs3UaJhGWVNMv2tRougt4oNr?=
 =?us-ascii?Q?n/RybNX0WcHDds1oNdfKy41QKDX3lwtmZvB9zw1bjs5ceIq/0/szolRwtQV5?=
 =?us-ascii?Q?1JVQW/7QuIMGmMuqtZ/Dima90Q76ErWYlwuaqmai+Ckp9fWKeobS9uUSVQE7?=
 =?us-ascii?Q?dSAZHhgEg37t5ShZajCDuupJr14Fc3hfNULuWjJjf6b7TzqitcRTdgulk0Ux?=
 =?us-ascii?Q?VynHjg9z/LfCbu0pFE//YWduAoQIvtsLbTBekDO9Dnv9OONt0ox2VwU+wvby?=
 =?us-ascii?Q?tCzRK9uasu+Pc//9a/XMOKnzTKe5Dl4zHETepxLVBr12ZPbBRhLYQax4TFfR?=
 =?us-ascii?Q?JJOSbqrmPy0zlDwdLbhiAbUzwh0lBQ1+/g7kgUNdOz17GHa98BpeY4S+rklv?=
 =?us-ascii?Q?cCJDWP/yMZpA2IcYV2Og/GGZ05fta5GhkKCVp6bvHaMwUI72/0oo7RYumpZ1?=
 =?us-ascii?Q?NuyUZ55uLwKKYqcQMYJOS/shOjfAkV4EG6TS6Bedxf1jwpi0n1xqjFBO07ke?=
 =?us-ascii?Q?0rWJFKoI0+Avy8cvHxSQXUDCklPBYEeSYK4z5rXlXzFxVUCksFRjb62QpJPV?=
 =?us-ascii?Q?VvlMX6t1nlfR5QlKnHp29igHI2ikysSXYNw17ab+7NsvFPkxCsdKa0DGWEuQ?=
 =?us-ascii?Q?5cPEEhnIG/GddqGrN3BjV8gZH4uFoYJ2uMNzUcbdTQuqVUbm7YV9P9MOvY93?=
 =?us-ascii?Q?8pUvtEI3ZRa6kJTq1nSNH3TwDcDOfSuQFh7DorfuLqi587AdLnXJe8lociZs?=
 =?us-ascii?Q?o3njmf777EoA0sKGrr3mzj3ZYqG3EhSp1X39JOr6aDhIf2oZGPXxVt8rU8rP?=
 =?us-ascii?Q?QIIC2fGzAE7JVUD96NWibCSRdLBC5M+H1Vb7OKpIowgwNYOnqS0V2wHIetUx?=
 =?us-ascii?Q?/lsAgmg/MzNclEB8QruzGgbfK28QKlsG23LXIyJzuq5FYrwxcZ8X5KhjVmRb?=
 =?us-ascii?Q?XJC2w8vsaGhGgq73lI3EmIoXsEVBfeuH40PxRK7PHW9EJKFtadTzS7Nck+pe?=
 =?us-ascii?Q?q9gX6k7JXUAFkln8FPSev1CpKOSclJi9xzxhhq6b2uQbJgKDE058zjn3KUV8?=
 =?us-ascii?Q?kWmp1KwXUwX2WEHkHeyE8LAteAD6CeceaDlCye6cZxKdpV1H99ZXj2ZsczyI?=
 =?us-ascii?Q?zHkYaKRRxIr8E2Bj5lLYjauM/CGh4Wr6OmSMbi8PRF8l4BOqrMBA/BrYkoU0?=
 =?us-ascii?Q?BVs4fn1EJ/dxkPwe9hnv6R3Yb4QRXNjqh1E3e6a5RuYOwFJ0qWaVkeFn6Wmx?=
 =?us-ascii?Q?mg/VO5FOkFXO7XMGWxdlY6g42Bvu3h/tMsoxbmMI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c994f5-6773-4c3d-81d0-08dc6b93b624
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 17:08:54.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c2qC1Qh2psUtdosornbO/VooNFWYqUC02jqIYdhx8ZfMxKYaNyLegdg7LHZMmphpshf/0RBbQU/MfoJVP13gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

On Sun, Apr 07, 2024 at 10:17:26AM -0400, Yazen Ghannam wrote:
> Aside: is the runtime update option implemented?

AFAICS, no. I haven't looked at this flow in detail. Is that something
we would want to try and tackle with this series?

Thanks,
John

