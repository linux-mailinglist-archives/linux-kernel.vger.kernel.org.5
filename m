Return-Path: <linux-kernel+bounces-60829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B888509FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE241C20BD1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B9E5B693;
	Sun, 11 Feb 2024 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jz4eSga1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D6C5A102;
	Sun, 11 Feb 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664573; cv=fail; b=dvo8GGSbyb1tVQWRglUDuwnaYdK3zNdESGVUpDinip7AQFBWUaXjWmB32J3OsRO4gPs/+xvjWyiOqa535+UsYsryPBIb9SNjYqfIPw3Nf8PsXUHXGYzCCKxfPbA8qulh9du027YyeSM3NsZBrpFb/Yn4qjC+AK0OCBc0aXrf7NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664573; c=relaxed/simple;
	bh=asrln4JpnlgR8nA7cVBaLkQl0NS+krdUtNTtXifvRdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A/PY3aNpcrP08YunzLjtdxc46RTyztr1RsQaISBSF8lNXMj6uFp3FPWWTgtACjwB+wf9s4mooTjiEVyc5SpEjML/LACA8nwfuIV/Xa1UowmbFy48W9C69ekg1RB1VvvSpjVLKEv6xAIGb1Ww9h9o3YmedybDlNz5+kDM/8/tTFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jz4eSga1; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkKWv2tS3gpWo12R5hffKxyg094ELqFyx3LWw5ufBvscBikj0/3S7I4HJxh+Fv/XcpO/QjJa3G40psvGSGpTe83/9eOHOBfeCH4gujgej9UaSMS9Y6pztzZvQTw0UNrgyMylXEKoagZ/fI5Iq8RQDUJoecs3ITwmJv8LVKhlDzWuwVPqc8uyCf/pGhPGhAwtiuRhLEx1nH2BJ77BuzOXCuWKAhgEvloM/1LG4v+PpyzfgBwu2vv+d2TLqVytWAOBeOA2K8PNNAmAhBPqM+rhXNiLzvp4+DbFnyZM94w6plw8Kz02Q80tBFbUHoq1h3v73jJBjdaByDTfLX5qESWSOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVXpO3Ep+KeDx0QGFumYtd/+Xi94x/5NFG3md/xFPkY=;
 b=eN4Bu8LE6PaPXy2bhZWPxNlrNjDFG6h8Ottiakve4fO66m9GfYroLMW+CqYRCw1o+sRI/n8b/2sOuFTrPeOu6bxK7w3ltpOvYGo7O3ggOUlFBAd1JDqQyxZQS/4CDTiPm3W4HCctF3wsuM9PZO1+95THf8aVYvyjot1EOUpN3cEMebzP/ltMcbeArrTLhr+i82/kj9sTjI6cR/Jj54d42xWcCxMfRqugjHL5AlmuENoQTt6JX+hrRVzfx5R5m9XPRbMgLs3CMSjchk+E6zf0coYzgNfz3c7djhddZr8EFhhw8nm0nZeOvQ4LrJkLmBy41zm65vLemhiSXTTLcKAe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVXpO3Ep+KeDx0QGFumYtd/+Xi94x/5NFG3md/xFPkY=;
 b=Jz4eSga1ITyhreg873TwKPRZIkq/NHIsc1yxMfvbs9sANUH2Qiv7TqzK7fc4zsn6h7DmWKuB2U9eiyzP0PrAZx6jBDwfMyMIntkW9PfaOHPXgNM2lY8Jn8E8to5tMTarz4DZ7NiwVKoFTQjbpqLZiuUXqIQXoL3D4hQLvpuWANcpyYZEIYGSn8TggIXwaqYP8P0LVr6FdEBBN/0+yK/uHgvlVFn3WHvwY1Ntoh2LbTma8/NXX0/PM0mAZNfUSc2bPhG/lgPyMaNxdLFQ0O2p+DIWQQsmaM99dEu90V9vBAEKCuAj/IJ7WXFuYTYK88/UYqY7ALF2tjCs1c8b6rV3Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Sun, 11 Feb
 2024 15:16:06 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d2ef:be54:ae98:9b8a]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::d2ef:be54:ae98:9b8a%7]) with mapi id 15.20.7292.012; Sun, 11 Feb 2024
 15:16:05 +0000
Date: Sun, 11 Feb 2024 17:16:01 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
	Petr Machata <petrm@nvidia.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: Re: [PATCH v1 5/9] mlxsw: core_thermal: Set
 THERMAL_TRIP_WRITABLE_TEMP directly
Message-ID: <ZcjksY_r-5cC0blY@shredder>
References: <3232442.5fSG56mABF@kreacher>
 <2206820.Mh6RI2rZIc@kreacher>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2206820.Mh6RI2rZIc@kreacher>
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|BL0PR12MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 291265dc-4003-43a6-322c-08dc2b145df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L9sTilLfEp4Ls5pLW8OXs8x29FNfVj0025M2p+5+jXQy20y1Tm9l1kQN+dc2XBPCAwLjpozVepX+1cBRNAC+k2X294GfwoWPEJdTUI1Ez4/j4+j9KW4tQ3Fc3xCRFAAM00B3iydS4PucltAeLK5sIRB8szMAwmTfz/15BYyKQKAStg7sfjHQUEhClM2ww4StbqWk83iBYwA84zdCcsDZDJPIFO/wJo1BSNBOPvW4g6mePfGIxHd7ocG2lAnV5P7Pa8SM1u9H9G7zNP7T2EeEQdFbF+sFwfiRdVjjBeVHiPqd+12NSqfFtET/n/uvFPruQP7Gj3fvfTRjJ4ELAIRCCCPEfiC+gT7PnfIX2W6Ymo55p0QnoQjV4sbnPq5DOImdFcJVhwC+NWLHafCH72kSkdAVHqoEMQK5/UgATFSR6aVPmLfJPtB71rnvdTlTFHg5mbVf91WoyvQDCqjTrB0BMmqHjhfCYd/zp94W36h/k638Kn5c0/DIyVtNnUkh2wNRG5Ka4S7ZINkXsfkfbsBXBifoc5b0NOyA3SL1SjQ3WnsJA6krbf6cpZSFxCvWpVYk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(39850400004)(396003)(376002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(2906002)(4744005)(7416002)(5660300002)(33716001)(86362001)(26005)(6666004)(9686003)(6512007)(6506007)(66556008)(316002)(8676002)(54906003)(6916009)(66946007)(4326008)(66476007)(478600001)(8936002)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?98Qte6FGpvPz4OC6nFYRmldfsQq3vLTB0lhefHWhENlE9CZj5m2sfrarOaUT?=
 =?us-ascii?Q?0mpfjT66dQ8jpi5f8cnrFuIouumvCvRktqDfAgavGv4jiWkMydkMnFd6y5Ru?=
 =?us-ascii?Q?ocy9rj3Kyb+c4e94ezv1BF08MTq5kE+r7s+1vcEtaMKgP+oWz5iG7Cw63z4e?=
 =?us-ascii?Q?2TJVs7bdXZmT+vg8OQZGHF8RytqIIIY7zrqc+7WKfHVN47eE/23yoeSzXfqY?=
 =?us-ascii?Q?t7dto+yKXzMUSV+GE0jlb54hzm1zdOnRw9Tg5+KmHPMuLTFoQbszHJfblmmn?=
 =?us-ascii?Q?WUNn8XuFO95YPwTo2Q7OMOnnqHc1qcPhU3la5KxEvoU5Fi1sle1/O2dGxg2b?=
 =?us-ascii?Q?Ih2UJm/e5Xgj7itimUQzRa/CcwYgzUbtALfiWi/cGRkEqJXXec28elJ/dXF3?=
 =?us-ascii?Q?ESonUrcy1kUVDmfwef0/d3hDAP2oP+zdzA6kJ+e3S9w4bgCgzzwr6rlyB6XW?=
 =?us-ascii?Q?x+rq62h8T2xmUltrpKflHEk/ylzPz3KZTpr2QRgMnHfZtOqR0KRSQsudNrsa?=
 =?us-ascii?Q?7+Gb/97vOs8AYbt5XxRZkzuU7YPS+YvSPs8xqaRVRa9fTebgQ59IQ5w+QoCO?=
 =?us-ascii?Q?il9+QPB4hu8FPNg3xGEY4IR1K/36sw93ZIryzO+a2U/b4C4SI0EqkS/6ObFc?=
 =?us-ascii?Q?8ABhvLNZWBpwbPQyAfM+T3M+dkdybyigYX1omyv6FaZX3CCZi3mhBW8eOL7u?=
 =?us-ascii?Q?4DInja7IF8lNon9BS8CRgQkfdod6U/+EzxJCNBcC1oDkuZGCOXKZoRqeN1AO?=
 =?us-ascii?Q?7B09utVjDCi8pYivnSzT5KMkz6zVj3+zVXBiE8Pb6LilCXDRqms4WLBMdiZq?=
 =?us-ascii?Q?wO947trFnR2I1NYEYy05BOJuv8MOLFEFsnF8PE3ZfaV9zdtyAaiZeKkj0xLD?=
 =?us-ascii?Q?9kHIR3UtZAFZJj69vOa17zGXr0ZoNUE/ym7ZxgM3w4Pbb9liL0mVVHo+UXx8?=
 =?us-ascii?Q?0OvpiHUNnqNqZ4yFxTXBvC+VjJXd03zwyLjB7KVB0Raa5rOczUIeKxnqOmJd?=
 =?us-ascii?Q?652QVi675ltLmHTyg/sM6a+7xSjlL69J8t0agjhKldAm5rC22Hg6B95+Nknc?=
 =?us-ascii?Q?IqGHZMLpVnXF6mdonZpKATcF/2xiCBQj3Eu2yAdnw+XChb7cKeAK8HGzhgUD?=
 =?us-ascii?Q?c8qW011g+01o+MInebEOx/3kFrukfP4cS3EAcuOjEDfaH/+t+zd7HLBcAJD1?=
 =?us-ascii?Q?W3QbcMmlqKaze71xIgClJ9HWVDouIy65srA67MYZ2q81Jcej+GvbMCxfZ4C2?=
 =?us-ascii?Q?xPy4C+hVlILKKqUep4OaghapmRn6oTUJai/IwfrggLZ6yTYCCzMeWMpgeYKg?=
 =?us-ascii?Q?lwVh2vuF6oNaxyoqMXQDk16t5RtP9kR6AhNs9l1y5IW8n3IsWKsleSHn5s3n?=
 =?us-ascii?Q?8nbnJYhKEEWAvIF1iOvuM1e2bVjluVk1uW/BPvezFVP842+hM7U9TOoXsdlL?=
 =?us-ascii?Q?j6dfdb+BTYDJjarE/p4FFd9oIdDBpXXBjSoPsJfigAX6vzcA6/dT6HOENVXj?=
 =?us-ascii?Q?h4ftV3RO6NNkC4c46iq/MDdeLSMi94nOayqyFF1+dlLCjrueFDl/tnfd99PE?=
 =?us-ascii?Q?TUyt3t85AOkch4+q2Eu5LkWWvUenPOvSIC+NiqvY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291265dc-4003-43a6-322c-08dc2b145df9
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 15:16:05.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6eMQNHD41wPioXWInfh2vvtth3dSDdyYgAK6PkdyB+z0cxj7OBc2P9P4KyjpUST1uElI4RqcYWys5ILfGQvaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993

On Fri, Feb 09, 2024 at 03:08:43PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the mlxsw code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

