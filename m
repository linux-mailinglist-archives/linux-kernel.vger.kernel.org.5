Return-Path: <linux-kernel+bounces-135707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1089CA06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39391C2442D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45A14291D;
	Mon,  8 Apr 2024 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uNCbksfu"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2122.outbound.protection.outlook.com [40.107.93.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B11E4AF;
	Mon,  8 Apr 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594757; cv=fail; b=nyf6TfES8Eom1edZpkksc0f9z627Da33On8vl9cp5FGZDbz1fj8CC6mr7x6pKd2LMUk69PKp3Tq6vMhMFQrsutgraiy4TId2gQ9CWtmVPYI+YJ/n9YwTLbihdu9CziRF1+ygrTDcoz2DT8g5uUKhu8fQOpk0sIv/GDhBE5yJ3ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594757; c=relaxed/simple;
	bh=RZ/ueJxTkVDTmh8NmDquDPCiiNqP/H14fl3M9L7DoUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BK0+aMtog+0dlJcaGzx1xy5KVIYnn+0y2HNqqJh4azjEcsp69aQO5naw2Sn1tsRvnQtS/js6CVu6RdDREkcK5mI7kPZKA9ZjwoyCcft85IGr5a4impBJtca7T0V3Rx6N4l/hdMk1nXt5NY4Q06sGH2t1s6QVOEFS4NsSEIbGSYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uNCbksfu; arc=fail smtp.client-ip=40.107.93.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrmsQodySDf0++3xR0tNAlDGKBGDYhDIONRxCp+WG5ESRR+i14FTgYxw8hYsC1tz2RvlxQAWUES5WzUdTknZyRUe5UIjMi4zO4cw5rMMH8CWJuu57iHzqATt8XJ6IqkDVLTRVEEZ9A5X3p2ffx41M7GSaci1mgJR5tAaAg2t1t0TYuWl5HxV+hQ1a1C+qDJnOKp9Ybw5dVi7jd1ZTESaAzAdYk6lOaty3+ZoJFzDOJ8yhFXG0bSXxDsaxDyi8LxbtRAX3cxjRI12TE8PYZLtEGXdASjlYvlwwvXxAxSq5wOHX/wecW54LC0jh054ACDi/FMgrrDrGLoBa7Vp2dOwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZ/ueJxTkVDTmh8NmDquDPCiiNqP/H14fl3M9L7DoUA=;
 b=jc4lrJtbV5p+SjojS78evXhZGWfttqCvqsX3yL+iSXyDEtZHwC9KaWudBSMFmd+wGK/ati84Q9ftNpNCKAnXIpLTngYdMfSzbL7aLDrIFUSl65Ub8Ju8S5GVTvWc7K1++cuvDlWXL3Njo1h/us+tACY+/XLPOVaQa+qzdPMiWalekRUTPhBw7rOAJIG9m+OP5rWdDrKXsfi0ouBXNfomxRvyO+MjhPLLHtBB6qnM+PGTvdNG1ka9vLvtLsgM30Hv9CHoGlfa201Se4QjhsP6mdz0aR4J0H0k1AMCDIqAmJjS3nxN7NeVfBzNW6hsLicxndwhaqR59mcLgLcA2Vyyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZ/ueJxTkVDTmh8NmDquDPCiiNqP/H14fl3M9L7DoUA=;
 b=uNCbksfuzaCgFy0x1ZhYS6fYUYcFdBW56EOhChb1apQ1KRQVCF2OloeU86R6461dD1WujNml/z394KDVbcGhC78q8p9qeYB7vfPytYOnLUlq67etWlTNYikDPEJF6cf1MtJAokzal4qgXyhGNhvD3QdZzuoF4EabougMaJEoQ3uZ2hNJHQo0fCtQRvUZIgCoh1P3Wd3i7ra7ymWXn9RjLuTDXDYMbhKwRcJOIS9v4d1PM1vtFSUmGXv47YlARqfL1bBq8DbNU/ksgmSKuZ7tRxhWtXWjOb4AET3HBGb3wn2iMAbv03LBXT49Sw5r8WN/DDn8y9MCWWu4iWNkhR37og==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 16:45:52 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 16:45:52 +0000
Date: Mon, 8 Apr 2024 13:45:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>, David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240408164551.GQ5383@nvidia.com>
References: <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <20240404183305.GM1723999@nvidia.com>
 <20240404125339.14695f27@kernel.org>
 <20240404204454.GO1723999@nvidia.com>
 <20240404143407.64b44a88@kernel.org>
 <20240405111306.GB5383@nvidia.com>
 <20240405083827.78cc1b20@kernel.org>
 <20240405104829.2ba1a3b1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405104829.2ba1a3b1@kernel.org>
X-ClientProxiedBy: BL1PR13CA0420.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB8185:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TGyNIzmbHR2cmQnZ0uJP7k3ynSWTTEC+rFSPA/g79h583QJyGlrpIobYpTXNayfdQCRlkimL8NuoBGPCnz5B6P9i8cRwXUEBycLHU8NvBpGS8ccusGgvRVesrPanVbQwpB5XdD7KTJhIBJlSbxD5N/KSexKH8mP7FmMDrvrTe80nXqTlYgLIkeSABnwIcdhmgO9PzMbXA2cYO83mh0l7K3LbVoP4GShWz1Rsr1rFlz75CnVtBS4wu1b2V88RQEFkTfqdQfn6DcO4JqOXH2qFvXrFCrc5d+tUayFF+GjbsaDw9nhY0nei8YqbAEUD9Xe7jkNJ5C4f8+rswW+lZC05PzWqFtrQ0PlK/p8JyrO+HIgYrF77AZDaBTh+QI3iFN2mLTUB2AMhv31K5SeEla/lxI6WQ38Ag9erAWi86Yj9FwfzzO8RxFLENudQa9dV06qlhHG03hbD0slAFpE45lS9hh6LX2TViF3nAI04X0iW1XEaGMGzTy7oIoMfOJ0a8lo7JqqfDBDy3goNZ4Wvf7j33B2EboXnJP8X7xbJ4zPUAY3jGSDrRGGWpRk0UMKkrBu7cndmuBB96fSrU+Q01DjKWY0vFJm/gMBs0yKzRvVlVALYUib5FNwGsK56SNYj96kloI7nKR1cxk/OPlV9nqF4rd36FltjFSB/BCKnIjYLvbU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ew/emZbaTE95nRUzilBFhj9swuj6FuuW6zXFTyxnQemcx8EgQ9umNYgzteuV?=
 =?us-ascii?Q?d65MX5p2T9t8LOUizIfn8I9Pb9CyK3sxxdrbnWbatu0KQ+Dy3KjVbnW5lBwk?=
 =?us-ascii?Q?uMy5MIG0wv1wMjDWuvhQoiKPSjkSSzZqw/+8+Cn0+qI9aT1PxdEVh3nyZLWM?=
 =?us-ascii?Q?3paoUwaP5gspTYBc/WK/p4VDUuyq/ZSilxFU3fQRTFL60I52uYh/y7B+NIwJ?=
 =?us-ascii?Q?hsfOKmGhAaBMfv25nif4yBAx8PdXPxTVs5NZ0piQrg9fddP2833bCzLgI9R8?=
 =?us-ascii?Q?+nxIdxqbI4fIJbsFDF/e7nDvl3LIPDyDu8fHrmE2jz10nBNGCRHdwb1vJYiy?=
 =?us-ascii?Q?LhB6QGgcW4gfHbQyA5bZNV/uLtOd9iY+5mx+giziVDWCqph6ATWo02SQF+4j?=
 =?us-ascii?Q?BeIHbtKcLUgApkS+7/tGMpms9zyeemLpxqBM768btd5vAfrpbchC/sn9YTXg?=
 =?us-ascii?Q?1KbCVuhMLgQcV1R5+kbjfcNzMSnKT1ocpIUYaO7BCNPaW4NOCIrJV6m9yZwD?=
 =?us-ascii?Q?qM9S75NmXo+C3BOksJlVWSy0X4NPPkVO5+TuXjT5y8P5/oucy/7k4pLUNHEA?=
 =?us-ascii?Q?z04rQ4IpNioqjArh+Qs7hf8j3E4HY7xXYasNaZqOHYQLsgyUz/RyZjI+kN6R?=
 =?us-ascii?Q?pEZdnwaXCEWU24kUWgrQZV1Do9u6xtimBaFHZSSWZErGA5FugPI+Oz8n/D0N?=
 =?us-ascii?Q?acKMlmbsRRrda06uxTV00H9f2mDBs9RHSWEL3UJGk/G7bBp2n58EWaWo2m13?=
 =?us-ascii?Q?TWwz9h0NEN3WiYbOPgGCtnKHFiWl0+rc869KtKCJ9EDN/OsO5oRynr8y7M6N?=
 =?us-ascii?Q?MIcpLSTeWmXNQJ5j7B2/KFebgikI4TstaqZze3iXdgwnAGToDgcWMd+M37PD?=
 =?us-ascii?Q?z90d1/GyWWKitj4Wwd3+RD9IQO6JxEHzEb5aMUnmYn/PJo8kVIXRvhE4dpbc?=
 =?us-ascii?Q?ZxjLVykzVoA231/u5I7bGHJoDQYstNes0RPosnKH4VU5eMXLaarVNq7kL/ej?=
 =?us-ascii?Q?W3l+azWnhuzJ/AR41W5m4oayqtuIN7d8duYJijZHydcBxU6WV865RLOxuBeW?=
 =?us-ascii?Q?fnlsuhv8dekXM+uDYCn1+O4WhpCvA5Al5zciN1gITv0n/62DKpB2FpZZeGlK?=
 =?us-ascii?Q?HZKGJQD+3iIPDObKIk+9OEQGNtj9Y86DnQSn0V9oQpLxQMRHwACbmEN8n+85?=
 =?us-ascii?Q?AQf+Zp4wqAx19WkkNXVMPFRCWVFIOblNiAUhVELV5pMFeGpHhyy7tEugRkO7?=
 =?us-ascii?Q?gHyCvAr84Ir3qIZxM2xV665GbifAneUgF1u4pHFY4zDBFjT8wKydp6J4VgtP?=
 =?us-ascii?Q?jcMWoVSuoXvfXT9SbWrbusKS+a3XKrEiATFIShTvR1m31xvqbw0+V79Z1OE7?=
 =?us-ascii?Q?NXE90ioDcN9pSEK/QroY4n7cZtFc9VAE2Bzk7Rvl7FSNxVLCdzSMxYC8PIss?=
 =?us-ascii?Q?tIk+HWIGY5alHE6K8qfywlLA3GoZhJmu0fZ9e6wY5tZrgZUPKjasmznB1Vwg?=
 =?us-ascii?Q?j5prnj8wjrOrHIPiGsNNVcFbuO8TDH0bli4y/w7rxsA0Fg0kNxI0o4byPznj?=
 =?us-ascii?Q?lZXZsauaC8METygsMGUQyUHmBEOyQiD7n0d9l4WT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69ea96-c0bc-4bca-c8f2-08dc57eb5a6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:45:52.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77mSj8/GO/epp6LdRWi1lLSeLZM3UffmerkaUDllLp2C5TBwInrwcGUxLQhXJOqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185

On Fri, Apr 05, 2024 at 10:48:29AM -0700, Jakub Kicinski wrote:

> I wish I could support that out by referring to the OCP NIC SW spec,
> by it's stuck in "legal review" of one of the vendors for months.
> I'd like to ask that vendor not to pull up the ladder and let everyone
> else enjoy access to NIC requirements and recommendations from Meta
> and Google.

Heh. Building standards is hard. It is a delicate game of politics to
convince everyone that they are getting some kind of win-win-win,
especially when IP and competitive concerns becomes involved. Many
attempts fail while still immature, it is why there is so much value
in the successful ones.

Jason

