Return-Path: <linux-kernel+bounces-68779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C990B858022
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556F51F2241B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B802812F399;
	Fri, 16 Feb 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mjpAljld"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA612EBF9;
	Fri, 16 Feb 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095953; cv=fail; b=ZaxBjKJN6TubAvOH16B2RoN2U6VrQog4IFaKkZW8cCICQVQ48oxW8ZTIoBGPqTkmBlkLE2vdh3aTF9kYhxgciQRK1p8CJTfiWhM+kKabWKC0zCVFB700bXDOUVnPeB+njA/QuCBsXS4Yg+/o2jUlog9Z5xzT/0tFPE5BoK+Odfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095953; c=relaxed/simple;
	bh=nPTZR00HxSNJqi19ptaNnq9qzfkAqEVNBnYuXoKqJiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ID9AIW/Mhthmrgq2j4LwtCBqIpgB+B4YzPIhhTd0CGhgOPMZwTYoUkoVzU9hGe1NVKlb9pgkNdQ1yIPVcVQMnqRgL01YgHkOk+NwgDWpCZZMiJqjIRG8//ZV61qS+ZhpTg5t5H++BJSyPzC9wD3l42eSjPykUwCyc9u5RZzuwF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mjpAljld; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmrabtBEw6cYCy+LVp1vuzT2BYvL/U2qUNQ56mgymlg3IDl+lNV89sezRzHGB+xaoZBA7VjMZyWzSJ1xHSAe0aIESdRx4g6G6ReV5b+zk8p0Ohd0PS7VEqAK2qiRXN/WMVE38KjcaHWbmSgFi58/mSPNOnZRM2KvwVojx1wa/MOpdZmA5m8J6KZMYD0xPBpaHN/yPhlVF+6SMIh89C6HGU41wD4RKulnRJ9PLEV51DXS95aTv1nAANFNqsBd7QHaB6joFw7UcX3ql8FkH3qWOjEl/HcJgRIw9wM3j419bFuZVzdbkCXKoohyDP5p33VZKAvBd+jP+lNNQW/7OqKVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp9+K+DlJ4MqoYLe/om6Nl4AIO68COthXe24NqKeoyA=;
 b=AO217vO/RnRgoLkEbZpBvUG/Y2D+T2ZPtOPaj+TLFp3tNPTMP1ohv473OGyyZbzPk+dTWLezIGYEfV7VinUoUcIhkq2Oq+3oBX8kqEP8RJXoSObN394BDSXtA4FWPXPE4Uejega6W8WsmDx/wZwiIYUnLJJM+UPezS5+WJLKI0FYdibPK/SR0ck04FHp6Qrvf93MH9SkZDZb8DN4JVwDti/zaQctac8gencLlCxjW3/KCl2+AFQQLdVG/6eAReH1x8GzQesGyiReawvnPe7gYl0BsoCy+6KXAuO87KOg1kadTscXwmm3e/xYkLRHRJbaEYCFHwuD53bhpKdPx5AS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp9+K+DlJ4MqoYLe/om6Nl4AIO68COthXe24NqKeoyA=;
 b=mjpAljldCeKn0i9GYgM2g4Y9l1yWykKh/gBY2PKymvJIE6bzjdvV3ajprfgK17kKBbx5AEjYrLNwFnQZ1EvaE3CBq28EHwSK1DfzbBH9uoI6gDnfKKaQ4fuQ/0lw/3WJDHYCrEbnrrep+rHXu78uaCQigPUmztIXqnM0tEeoba2VU7ira80Nup20M3gjEZ/OuwDxA+/tQUpnYKNgHdJ8hGb4ke79ZqZwlHFy0ja1sY8BRSDZMtIDTOVlFkCMI+jqpwW503m2uluU2qRVuz9HhgYPd5+VqO6E9/3uKZUjEYJ1ZPOVYnqguUOWnCchaHFWD3eraF+y/34townY+Maojw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Fri, 16 Feb
 2024 15:05:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 15:05:47 +0000
Date: Fri, 16 Feb 2024 11:05:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240216150546.GD13330@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <20240214074832.713ca16a@kernel.org>
 <Zc22mMN2ovCadgRY@infradead.org>
 <20240215170046.58d565ef@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215170046.58d565ef@kernel.org>
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 65155c20-d6c7-4a50-da81-08dc2f00c1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4s17byXx9c20570xd/H46UmlCM5uBzty5kfxk3EqU+62SZgZpV/pS+EitkcvdGNrl09cmkwfIzSTFRiX2RQQ0V+FSAj6jMZmli+/89FleQZEr8yRpJbCnN4ZbFhy5tPaS9DDTlwtZ59r91Sb3J2viRWcYVqOQh7jmPWE/uQmBk35UIZyCR8TTc2sF7LAW4rs7Ax/O4+bYs9kiYo0VNhM+qqGPaugL5LnX5mP/NZizPH4xHWj6B7Ux6KE+rlgbypAHwptPRxF5u2b0koF4qghkn1X6ij3OINUBlmCbtlyoS0rrkG7372xbCfH6IcnfngMWL4778m9iq5Kfo+BwPWWYmQJdjXwCnfQ7MI5D9663/vr39f4pkHkC+4pcB5VzE5H6h2VlmQeEMMq+mtDREu2ExyhUOONGCiuGVP4Ba7+Dm08HQtD4St0qdx2WljQacSBJvq2/ckw4KDtCn+SUTbifXzHhFOjtuom/F42BCcV3XMwXFL42XbEDJfcLqEzLs0C8GRmeOsZOemS2OIJs4neW9fEwuIhWuAkvR/Dj9DX6AtHLsD8ml144wYP6gxdR9fO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66946007)(66556008)(5660300002)(66476007)(316002)(6916009)(2906002)(4326008)(7416002)(8936002)(8676002)(86362001)(478600001)(33656002)(38100700002)(83380400001)(36756003)(6506007)(6512007)(54906003)(6486002)(41300700001)(2616005)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?opR+aDskhQKr62SSuzlC1QdeGBRmBR/Ru8kASTB0/rgEvI+kvHta/clRSsRo?=
 =?us-ascii?Q?Ov7Ogxes72MARp7Ftvlg2v2QlYnlM9Tx5sSxiGCg3R3KzmwS8gZ+ufPHMqUA?=
 =?us-ascii?Q?1TKoNDHlJhL07hwcNdAxp5dMWsHfBPAdfQtp0P4w/Qo8HAULKJ6t6NsqyKCL?=
 =?us-ascii?Q?m/jgu/zBFH14R+AkL2oA2c9KuFfqcCnRzOYb2oR4BzPHSleRsLlkz5Q8yUrZ?=
 =?us-ascii?Q?8RrpS8Fx5Rf8FgWQFFX+Z4SW8GCBtNdCjuU7qSsarTQkxmS8NUJ3ZlPpBTvI?=
 =?us-ascii?Q?ZINxGvRV9szkuAG/riCSfWgHNMGBv6sDsZt0NPoxC7tYvIcqf/4f7FWy+sNc?=
 =?us-ascii?Q?+Yv07fSXPQ0E024z8Ytx38J1MHgyA2+U0WYsKKIVJPFFy2uzy2m0vy4hTEBn?=
 =?us-ascii?Q?nJQ6QMTXT/73KfhFdnnvMoO7gn1CI1A+FSlc8n763KP/ajNDAoSEl+ZLqkxi?=
 =?us-ascii?Q?7+1Kk1mnPZIIhlJEJ595INtbmwalAtVJ+m1VpYAdcMH97qdJBjRy5aosYrTu?=
 =?us-ascii?Q?4x6LreeTNRS8ohEiLkqGct37x3/SGyev/OMui/WpPIcv8qrMXZawsf0A0zVr?=
 =?us-ascii?Q?p1VEyqrw5Cn34LJWwR94xkJsQGa8mkBqXpzJZEBfT+6yl7/4KU1HdBaZkw1M?=
 =?us-ascii?Q?tfb3c0qpVpm3HCPX7Oo4xNsbIji+z1vPnBi3aA3KmzTwnAhMgJ07CG/THNcq?=
 =?us-ascii?Q?eMgHCD42mvj8GuSUukmrtLxlsiwTI+tKdCT0aYu4lVREeewpvTUQzThZxHo7?=
 =?us-ascii?Q?v+Vh+5apfO3PArqHLUaxo9/XJnHImjxygnGmWK8Eh5sGnYomAplfVvhTq/d/?=
 =?us-ascii?Q?g+IwyuJ/Q7rNkItYIrWsopbiNATt3OsvbnHSxPo8MyIqlNcYdQvswQlcHcVc?=
 =?us-ascii?Q?K+TZ+/PuqORiDsrHNdD7cDCyCuyNhjdzDHCvLWKg1G/q9VVkszBjTOQni+vA?=
 =?us-ascii?Q?DY+f0bTQfl/GooietdVgzqIYHH53dmaKwLH2L6x9SX0dcISAhJTxflx2YcBu?=
 =?us-ascii?Q?iNd2VedGT7IUP+j5LGzwAtMchu5KL8Ngbh/PlxcY2WMZWfJUfaQMzF4pFP0i?=
 =?us-ascii?Q?dn5GUyHPymPMPv5y9pEfCaVZgdWYZZAMsmcw9LRH4G5lQN/gBGIetyfvZ6yk?=
 =?us-ascii?Q?CD+FhCd4bvFV24w/KZqauE0QQOo7a7in+kWg2pFuHD02c16idSjF1dhUNr7a?=
 =?us-ascii?Q?ZFLlUdXBdEl+LOYLViPi4fdKOZM9NN9nD4W/1I+dayPuu3xUXrXO1+HVKJDm?=
 =?us-ascii?Q?+gYPGyuY3btBNGq+qQIgghK192t+N9RhyEETlanWJMzF60jLHZvP5+ftAWIJ?=
 =?us-ascii?Q?2y7g3AT9QOvPiYXvOaxsTAG26rGcEFQsH0V5f7mkzevDanl81a4rvlE0gDf7?=
 =?us-ascii?Q?JOGWEzhiLB6LUIWvV3RUr5uL0ewR1INIMX9UfFKh9+ZhlkOcF0Ak9vQkYfIg?=
 =?us-ascii?Q?9Mr+VDe9Sc8sTfDzalSXJZ2uw25164UHufWaKBLe3w5q5Mx8L2XDTGHYrmWT?=
 =?us-ascii?Q?TMkSNpHArty0S2Z2LYHFQhasr/5LLQExynlOBXVagjdoXtZ0hd+0pbAtkWy6?=
 =?us-ascii?Q?18PACk74r88MVd6nxPAlXFVh6WSniCmu5nzP72Wx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65155c20-d6c7-4a50-da81-08dc2f00c1a5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:05:47.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jamKDxHvNmP7I2qpCp9Krw7Dn8HZK3eOZxTZTAZjPRkkmzNBdklC5IxgjADkHelW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On Thu, Feb 15, 2024 at 05:00:46PM -0800, Jakub Kicinski wrote:

> But this is a bit of a vicious cycle, vendors have little incentive 
> to interoperate, and primarily focus on adding secret sauce outside of 
> the standard. In fact you're lucky if the vendor didn't bake some
> extension which requires custom switches into the NICs :(

This may all seem shocking if you come from the netdev world, but this
has been normal for HPC networking for the last 30 years at least.

My counter perspective would be that we are currently in a pretty good
moment for HPC industry because we actually have open source
implementations for most of it. In fact most actual deployments are
running something quite close to the mainline open source stack.

The main hold out right now is Cray/HPE's Slingshot networking family
(based on ethernet apparently), but less open source.

I would say the HPC community has a very different community goal post
that netdev land. Make your thing, whatever it is. Come with an open
kernel driver, a open rdma-core, a open libfabric/ucx and plug into
the open dpdk/nccl/ucx/libfabric layer and demonstrate your thing
works with openmpi/etc applications.

Supporting that open stack is broadly my north star for the kernel
perspective as Mesa is to DRM.

Several points of this chain are open industry standards driven by
technical working group communities.

This is what the standardization and interoperability looks like
here. It is probably totally foreign from a netdev view point, far
less focus on the wire protocol, devices and kernel. Here the focus is
on application and software interoperability. Still, it is open in
a pretty solid way.

Jason

