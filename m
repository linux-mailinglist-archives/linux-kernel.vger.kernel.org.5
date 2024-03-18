Return-Path: <linux-kernel+bounces-106450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92687EECE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCE11F21552
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3C555794;
	Mon, 18 Mar 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d0e2JRYl"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA4655C04;
	Mon, 18 Mar 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782981; cv=fail; b=AZyi7BHiI9smtvrj8xyhUXsO970KrxWmeUbZiUEiTqtV/hM0UP4wsqWEwlIzqSqAMUsTISWW2BADQHQVCH5y05HrqBWevAAlurdDlwUPRdivgOaugyt4WDBzDpOZRUxLPfrepZO7wRnvfe/FEEu0twF6y6UU5kB+a01rsaWyujI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782981; c=relaxed/simple;
	bh=mioly1x9sHuXmvdRFDJIcqAOth1XCNAf7hJ7oDQugbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TOaYOjh16K92vV9hzRcImF3P7FNKWtmcZ/bE2FIZByB5xYitTliv/xWUIDw0MdDfK3ui0A/mnrKRQOkpYM+pFKSZqiv+30xdalo+qg8ElktVjoGCbvkztAsQyrGpYNoFV04S1efv1+mIbiAPZM/fp1mpmdojTfQqyuYskKXqM2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d0e2JRYl; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dadp5JAQoIRwzIN6Qb71l1jAodiPtIqhjfykcXqURULsdp/XHVTyjnCV/wQJOjCrrE+ocgDVQ+RK7ylIIKdPu5Dc3W1vq+lXxaX7+gZpkrTZFwwF/pmi99XVhomoCNh04UCY9mHVD89MSCxJ+++Fdqg/Z82yDVm+G6PC9Wz0gaIzlQRk069secxzW1d08KYHeYcIGNUTCYybFmQCBZn/ke3BU2NNcBmfT8IUx0m93PYWjykdH5w953T+vZh5kZOafZhwiX1wUVF/B7mw/MGGGR3sGauqFNKFq8suU9217YloKDBrzglsCL8Bhpo9GbLFHhrLvFq6rDqxyfgX+Rjb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNs3dCWBTwvbY0N2zixejYIHPcof5M/naR2K5df02Ps=;
 b=dfQgSvAudZvyckvWj8kwcokkAcwVquNY+iyegFtzJaRo5e27QvrafmGHu6l2ja8gzekK12z6SUTQNanbHId6AGeco/lBhMgjPTC8LsUMvXYnid+CV4jre79OFqF3QSuO9bjYb5q942saav9svcZYuPIoPfwXnxylsWA4dlcUk6Y/raly9OkTDVzK927m0uWB44zKYDMobXdhlnUV1+SlBPWIWPeUX1CvMxossYz7tYKh9g8n5Dhvum/sQMKdKg28TGj5PHst6we3uWQdtwCuEbo5ZKaRtRzTVO+CfpTEQ5KvXFwUAPDOQmFl3MwfDhDA2EKgv7RoIadAEVhx8KKiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNs3dCWBTwvbY0N2zixejYIHPcof5M/naR2K5df02Ps=;
 b=d0e2JRYlb2lrn2hxvj+y4cj80ksWYk4XYaQRRSnBnTRobU48pY5LBU1XXzR2ObTdQleFpuwXSPi3Xo4Wlt1OfqUrDCwtdYFgt2wHulSa5SCdMTp8W+o0SlZhA4rRunwjW3kMmaloz+6/h7f8TF2zW21wTUVdiWV6MUeQWD+oTW0wlLIYIc/1pWxr246GVdcTb2i1ihlEivPOhOOj3lJ9G5ZnDqAWP7NJERKyfLkZhNsAOT9vEGqc18gd7La73KjNYxdpthiXDgd2GG+Mu9T9+ADz1GupV9KNm0pJVkyzKOuK5EVmu1cbOaRJtpDA1OlHIFpIGKVQvJe8LJBnBpx01w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 17:29:37 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::b93d:10a3:632:c543%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:29:36 +0000
Date: Mon, 18 Mar 2024 19:29:32 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, Duanqiang Wen <duanqiangwen@net-swift.com>,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	davem@davemloft.net, edumazet@google.com,
	maciej.fijalkowski@intel.com, andrew@lunn.ch,
	wangxiongfeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: txgbe: fix clk_name exceed MAX_DEV_ID limits
Message-ID: <Zfh5_CpMJC8KU_yG@shredder>
References: <20240313080634.459523-1-duanqiangwen@net-swift.com>
 <24a7051fdcd1f156c3704bca39e4b3c41dfc7c4b.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24a7051fdcd1f156c3704bca39e4b3c41dfc7c4b.camel@redhat.com>
X-ClientProxiedBy: LO4P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::11) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 110d0716-6364-42f4-0141-08dc4770fb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iGUOVQAdEy3OvV4ldTvVIRhPNP3WdSltuaocS4vBo5NKhnGeOpOL0Dn1+rKlVkcGW11k/h4FGtfHNNK7CiGLACAT8vYEZqA7xamQxI0W6qiwK9QSW8/rjvtcFRnGsU5onIVotaV7be5fqeKI1sf0Tmm0jTm1R9YBPv5FlMXXwsf8C0kEME9GbVpZZY3uxyfmBXvb2Xopjl2aN4PGa3H1mkyUCTc2g7dI/oxKBZiFL8/SwE7ClaBuXvHNduKJWliOR4zUzFymUACbJeyAUfFC4YmD60rtVZVJqwWY2StISeBXSoDqBaFT/69wRh/WX5zDy7VZeNH8PyMYVMJ64MsffuIOPaWHjlwTcUDXkXKXPgYIL5Uc5+IXUA8XyseNfgPK0y7SjwKm7lNz1JNkA4ZHAEvAs9WN7UUK4QfejFJm2RuUrxss3PXuya9fyPOhiFsCF5JC5uCRe/UmOqKmn/6Mt9m1ozZ4jvYdRtGylkkL3F9BGSXYLwYJeGB0K624Uy3bi8bx/7CKNranAHQz0aH/SDSxOMTcqrzISbv9vWINSBaOzEKB0Mxb++KdpMI0b9x3aRofOleH/xZ5J1XBdqZl1Js0FUMSbxTEUmw/u9UeWep32vb4ynpf/aU3cSPtMLa7A+CMgaPFRfDhaQG+6MZ1hK38LZGwG63iBV8U/CAStjs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdWGtmOmb35+5tlobl/1mhsYtwYaJ0JA6u0A8071QUTQBKRpwOfG3ebIAMrr?=
 =?us-ascii?Q?V2tzs4qmDcfWCWE0R6IbiIBMSu5kBRKYjA23jCpJmiYGmtOyvxYl9ZFFTrxv?=
 =?us-ascii?Q?e3VhlzSA5tVGspvCtfl7ZTr3Ak8YCnZnBqK1GCRfoQXb5bmCWAuoTUg0/RJ0?=
 =?us-ascii?Q?1tOV4zKHnlRSP2o8SyAZH/ltm5tNJ5Jeu1IyOOrXkXT0OiLyKD4qmN9WRGAL?=
 =?us-ascii?Q?DDG+pVw2eBBgoaeZKSgjnc8jdwDxU1Gd5WfZmeeVHPaNK2y88/XxAfPGpOn5?=
 =?us-ascii?Q?mV3STvYZ1KlbdgM9/mzMu0gOCIrfpLamg34CqgHDXw0kV4PV79xxjRTCyQRW?=
 =?us-ascii?Q?vYEvjbtrul7EuJRbXl9SgTn6O6/DhlO5TNvo4Q8lUskT41fDlS/gVfcd9V0+?=
 =?us-ascii?Q?YDUI4gTsNsSq+uEw6vHKIv7vcjFEhxpmt2Vv1v1LgDDw3SNjxBpeots8TjoK?=
 =?us-ascii?Q?zsjA/ib2gJbAWVJDwxuObTzU4JMuDiiwM/UELmx0IftgDP0+SPuMfrKCVMKG?=
 =?us-ascii?Q?BGO4a8xxGslWSMdmj4tu8qw1f3o3MlkP31YQn3gGm565kQnV5fPa8BdIwLsJ?=
 =?us-ascii?Q?3Mj0AM6j+fXTuDUOVQjHYWRpZNC9idn1JRYjNv/kTlLUluL9U3S8kVUWlK+Z?=
 =?us-ascii?Q?B7UkdAHo9FXimFZfVTP7N7yVSE6eeznf8iI23/Yt1wbzp1H5BIWg1e3q/X7D?=
 =?us-ascii?Q?8nu5Jai1hReg5/4SX8mzAOsEgJKitma+BLaYfxy5RpWYDerMeM60t2LGObFU?=
 =?us-ascii?Q?2to+1JY4XVKgvRCiAmzqa3FfVAxJOhfQXSDh2Gmyefq3FuRXmsGW+Jj665W0?=
 =?us-ascii?Q?BeCdSGblBj/lMP0Jw3Txbk2QEg2iGBVQhcZEhn8IkD1P592X9i7Pj+nUMzQL?=
 =?us-ascii?Q?oaNYahDfoe4U5W986oGewgjwX0+4HhD8BXnzjv8goLNyIIS5byPlI/NQ6Xno?=
 =?us-ascii?Q?VRjZbcniAuqVI7NbTjQ+VRSw1vRhapwjpQthVVxWVzmyzYFs3RnRw/nmATDr?=
 =?us-ascii?Q?Egq2yw8U1K1hQ/98+PtjaBLJiKVgETAN9dey9+BvEz1doLq/3cVhTVg4x/z0?=
 =?us-ascii?Q?89OaerU5E5V1Yfyqsu0xauO+4Gqni4j3A4GDTuEXebBJcBuswAqIvob/hvYq?=
 =?us-ascii?Q?FLPCd8qMuNdlFaR+qB3GmITTVLuv44aBUePR5ct82f9TXM72TNEhSrh98h02?=
 =?us-ascii?Q?DjiAq5yt0bs69ey8CIKUKl5xYf3YkJ98VrCtWmGc5Ra0fLNcUnH9s69JdQ3D?=
 =?us-ascii?Q?PDWtoD6xyxv3JbbWfdRyQT/2Gp8tMq137WV+5sqgrF3YowoT6JLeecZ8rUU5?=
 =?us-ascii?Q?53cdpItLRch9RBYqbM3l8zROgmwKSvNJQqOlvT0vVWLj+3WQCImK6Q3rlSAD?=
 =?us-ascii?Q?tYiSL1HFYbKe3YNcSTqJWE6NFAHkeUw/WKbC6xNG2peldJp4H6HSRHfkL9C4?=
 =?us-ascii?Q?mMHJJnJIC3ovR5aaG1Vu+6AegzSz9povZ2t9jZJIe+OdgSZckzsDbPuwdggJ?=
 =?us-ascii?Q?G+CTYxMm9ITHdMAk0Z6KVRzWlWlsUnYOUMb1iEC91EUBqErTNx/lBawiV9uV?=
 =?us-ascii?Q?Aq/cjSQlKqOozV34UvCN1bLrBBhXYjouUglJ6aWO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110d0716-6364-42f4-0141-08dc4770fb99
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 17:29:36.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xx6ohrrwf/ctCasQ18zUIZM3YqeHJGDKDWRWVCcDCKQtgfeZOh+Q9iBXI6TJAWHkLEYziH0L9aulxla3e5kF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322

On Thu, Mar 14, 2024 at 01:46:01PM +0100, Paolo Abeni wrote:
> Unrelated to this patch, but more related to the self-test burst this
> patch landed into: it looks like that since roughly the net-next PR was
> merged back forwarding debug variant of the vxlan-bridge-1q-ipv6-sh and
> vxlan-bridge-1d-port-8472-ipv6-sh tests become less stable.
> 
> IDK if that was due to some glitch in the AWS hosts or what else. Just
> an head-up.

Looked into it. The test is sending 100 pings with an interval of 0.1
seconds and using a timeout of 11 seconds which is borderline,
especially with a debug kernel. Will bump it to 20 seconds for good
measures. It won't prolong the test unless something is actually wrong,
in which case the test will rightfully fail.

