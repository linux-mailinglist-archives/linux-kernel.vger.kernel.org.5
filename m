Return-Path: <linux-kernel+bounces-42969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC064840968
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230991F23DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CE60DEF;
	Mon, 29 Jan 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="okOBRCOC"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463B1534F9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541147; cv=fail; b=NFd0wr4Mym3ALT9AhrazgDlwJa64FKXpIP3eRpraGUMvKnl66f3CM9wZTJPTknNd/7zzYEvZ5i9ycj4/Vi/3yCMqlOHaqetJ8bqubo1j/RJ2CVHy4PcuPXrobb0nHGgTPzE7xehoEcLGIjaKcxefmdaBE31fexnA1se7oUH/mmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541147; c=relaxed/simple;
	bh=GYLqyMOwcA6xNjWeh/tK7eIDpf4HSd+0S0oTg7gQITg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uGguGxZq4dSSfaTb/SeSVoH0AyKbbsMW3B7y58uneN2LYYHRTIfdTbgiMhL1wuyd6wyeGPuhim480pNUv8sAQnIK1c+/8D/tTeCfYhprdKQeei6ObBcP+lYEl1a6MhrbJpQ/Q1MmYy880QJV6TsAU6pXWpPsjEPeLiS79uZyVl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=okOBRCOC; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M87BrS7reSM0Tp5p7clR+SxMFZRMKHqSB9+LwC4TeFytHYUtuLwed74nMRGTQiEpsSRSKCQC3vrKsIq3AIiiEBuoLhXKf5G9IjZi+KLJCJs+sLi/wFHdaZ0MtXuzhGT5kOjKyR9i7xoDVFJyZlekU19jdGUE2y9a4LubHFT3FkBGDoTnfENeEGzx9oy4sQ5hLwSgaCNSNHsGKt2XbD6lNGBtBI4tN1Mf70F74FKlXJn0lfgRc8XzRY8FZ4dmkFStt/2LmCob6P4ApugfgrJBdSyKqR5h0I4niLPNNI1JjQkpnWYAE3B7dcwETsOSpg9eIpgcmbTCvF3SdzmOR7QxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MigQLDOxUzTAcDVGgq8Rou5+qEkO1d9D79H160UAXKY=;
 b=TucwWBnxY89JHvEci7MRtRQsxdDzEsTrB7PMMj5xC3REtoXcpJhTk/WxjhD7q5aXYm+mfymz+XCSwXXB4Q5mNU8OdHpcWH8xm1T+EKJEIixJjF7le3mNDm+V7w3zBPRNYwh14vDO6nNIka4qfzytGgBMmMnE8UUU/sE6cMe2ZsmAo4aElf7cQ0iAvOrfhuw4OHQzlvVg/P9hNhjymYpLy6c3PKx1mc2j+pHhJXFdozO5f7paupRnmiLKTs2UnWftWRSYPfew5Omk3d1gTL2ZNQNa5qZ+A1kEITXamrSFkZpHjf8cpXjNY5IIGMbGbD8KkgDfaLtOHSWGkydvnlv0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MigQLDOxUzTAcDVGgq8Rou5+qEkO1d9D79H160UAXKY=;
 b=okOBRCOCcEj7iNnstMriulI/FkfgVbep6wJ1ksKUDP1hUc9V9Ge/qN1VPs6CF/SnaHAs+m4t1YLBN7ESjHlM2IRltdrPVAv2792IFaUl/NBRto1eFqLypjT5oPG78dhQAw9UQE6LcuzrtDEa3rxun24d2HLm1FjdcTN4TQ04RSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW3PR17MB4154.namprd17.prod.outlook.com (2603:10b6:303:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 15:12:23 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7a04:dc86:2799:2f15%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:12:23 +0000
Date: Mon, 29 Jan 2024 10:12:16 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mempolicy: check home_node is in the nodes of policy
Message-ID: <ZbfAUEx0+2d76KWz@memverge.com>
References: <20240126132240.24518-1-luochunsheng@ustc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126132240.24518-1-luochunsheng@ustc.edu>
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW3PR17MB4154:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5b2062-42b3-48ca-aca1-08dc20dcb22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	obCqHMLYKm4D4hW5EU7BKPRRvWB/QSZICWhz2IZxC/x82xknZ3hie7fEfDlROshdyZTnN1Clc08cMHTChlegGEqso0QS314T+Bfxxcur2Jm0ldIV2YvX46HLui2WMbL6DWDNg9qGNl+GufKmzRM8hla4OKuc6TNzjvyIahrlpjDror5WTe9rpF+p5TITNKJLjj/h7uYZ/GWcgFo/mdVs5CgjBuw5YbfatlLj+FK5BVOjPd3H3X4A9IrCJSVY1Mkah6gSWKkm79z85v5X7aDX4MGOBBw1ifTB0iU19bm6N/zyo3DtcHcZqcFa8cCw+cGK1x5G+o8Yl4PsN65AosgTfptRC6iziQOC5WBwDL8/Fc1kIi8FyzabI3L7m5MCERMiINBqHPq4F3wnOaG1sMVhtRP4GtHK2dn76Z2Clc1fRmzpeTWDy///E+BQk2ArNg993zTBuIE2q+tstRk//WNzWHuIvuRZOEJqlFT4Fkwf3VLVOl2E3/VDuzfaaZOTZyBk/sHZ89yuWSbHErPS6SDyMSgH6eVzxfroh4m7w3NyqPmoWwP5f80ogX0D0BBTeBZ96cIRNlYWv69BnTauwvHQBogo74OUzsr6zfGd2BPqyvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39840400004)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(86362001)(36756003)(2616005)(6512007)(26005)(38100700002)(44832011)(6486002)(66556008)(6916009)(6506007)(2906002)(316002)(66946007)(66476007)(41300700001)(6666004)(4326008)(478600001)(8676002)(5660300002)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AvFefetvGoBPGPcN/797VscDIcCb1KkP+NZadj4bisCKsZZfulYolo6MZ0Po?=
 =?us-ascii?Q?ry4RkMfcpT9an7Mlm3TfpDmF2VKvyK1eetzaT0jon53Bx84kP2U1/Ki+DFG5?=
 =?us-ascii?Q?mJNihsBRB0r9ntd5Y7EOSW6TjvJ+pozvbXb7nWpg1IAKk7dwab1ktGXaB+71?=
 =?us-ascii?Q?fACHGBi20l7cXAvrbL8qxHh4F0u04LmlZj2VwwM0PzPvQ8Aplr7YNKptj6GX?=
 =?us-ascii?Q?XFaX2WBlWSJcoftcmDs1Z7ePX9XdnTQi3bGRFG5jHvEzCLS16Y1HriHqzA4v?=
 =?us-ascii?Q?RntGNj4vRD+0ynVEKINbts4DuKxWFwG2f905i6BWe3k7QO/m52Z2sKetupxc?=
 =?us-ascii?Q?KjVyxYD7zWCSMAF+MLX92UEkhTEitsJyqSGm0h8sUjd6VKavJupsxgtdO3n3?=
 =?us-ascii?Q?Ydtb5+2/mH2bwhDiH89nvQUYSgJeyAEF4YX4zcFPeDF57UlH+hTAoglMBdEQ?=
 =?us-ascii?Q?rXSC9AGt6gTgt3HKiYI4LMJPIPNGMtYs49LOXU+wxcqairmJYLFtzbf5PGKT?=
 =?us-ascii?Q?2cK3sy2pz8NCNBsqct2A1juh3s6cKLx5Fou3HQLGCJ9rOW4gK2NBhYMz6jB+?=
 =?us-ascii?Q?hpaHQmqEV6lta+tZ7YXgEsrqLpg/MOAZwLNOeET86AgSmqHhxV/fEjxlpIkf?=
 =?us-ascii?Q?z435waGkQkITMtYrlR3/fgtLZAbbrcHIL5ADqpvpakU/DC/qpL5LpDtu9VwE?=
 =?us-ascii?Q?OGZmZupcw3EKbDl6FSyo4/oLdu4KTS8iVd5Jdk0GG9ReaYqshNEBfIpt6sCU?=
 =?us-ascii?Q?bFixcPum8V6dL4zMrYF8Q9EHLUHWgo3AHb5/FygVDzJ2Wki5c7LKjuU8YuEe?=
 =?us-ascii?Q?hEyofPTwlFmtv4iFonDhoUakizf/+ZGrhUCh7lyCupZKvNFzm9rdq1+BSfAL?=
 =?us-ascii?Q?OHljpGzOuDdKJ8VatazG66/5r2nkCx1iMf1B1eOMP31/D7PWMez8JhZwjh6N?=
 =?us-ascii?Q?ShgVcin1WFh2yJ5q+K1XD0ky9QbwrQGQxDlN4IrweAOS3TTzqoYIA6e2P4n7?=
 =?us-ascii?Q?8+UE9bJ+LQWJRpBOGR74sICn756sH4eh1oKhGCCO+WLz7rfXEC7dKkpHKic6?=
 =?us-ascii?Q?nLqBer0xdfUzuP08yNKXIXnGqDB3yQGfc/EYpoRf4m82vR7IZtO4CDBzGIWB?=
 =?us-ascii?Q?kcTy87Xq1EY95A6YO9jnN/5HyCuhFE0K3MJ2XRaO130JszjaY+cOTH4DB+C4?=
 =?us-ascii?Q?DbhIXbu3Ufl1VxKCMsbrO43YkOCWdrkrbemwtMYabkoXVCmmm1Y2fh30T7+S?=
 =?us-ascii?Q?zDjOGYMxHvA70y/4byPSTMM6dhwLXavtvhwd0raQTSzQ+1jC42zcmHZOLKCh?=
 =?us-ascii?Q?DrjE66+R+WWNO0AMGMzGZKDDw3f7zVib+U5/TrrWV1Ipg41+3fFFypaxafy0?=
 =?us-ascii?Q?yIkioLUg6E6NzWutIyg6DUWn3FGzDfH9mI79mkmrnMSRsmllkR0vWPX6XlrP?=
 =?us-ascii?Q?aDnUCDZKDjzSVxncvWRyGvpbg0EUafZdCZZH+W9SrisEmtJY7BOTuMQ08Rv+?=
 =?us-ascii?Q?hgjnRGnQaOPOW+r3O52Xvj4FYGIx1EwKtusYtjImM1t3TQIf8fhL9g6mqQuw?=
 =?us-ascii?Q?VgZlgH+7EfwliuPUpSBgvEJfS6XYPS/dvCUKxD/pScr1pNNY6bZCNKSIiQWa?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5b2062-42b3-48ca-aca1-08dc20dcb22a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:12:23.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRkRBHeNITMZNXvM8TU5ayQnkE8/yRm+MmU6gfp1nYEzw2EDrgCF1cNwkzQBW9Wj3bhRa6ILEKaSiQils273jZL7TbgpPD+xehRa/Z3LQQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR17MB4154

On Fri, Jan 26, 2024 at 08:22:40AM -0500, Chunsheng Luo wrote:
> set_mempolicy_home_node should be used after setting the memory
> policy. If the home_node isn't in the nodes of policy, we should
> return failure to avoid misunderstanding.
> 
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  mm/mempolicy.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Since it's not possible to add/remove a node to a mask without also
erasing the home node, this seems reasonable.

e.g. this is what happens presently
mbind(0-2)    :   mask(0,1,2),   home_node(NUMA_NO_NODE)
home_node(3)  :   mask(0,1,2),   home_node(3)
mbind(0-3)    :   mask(0,1,2,3), home_node(NUMA_NO_NODE)

However, it is possible for a cgroup migration or a change to
cpusets.mems_allowed to change a nodemask without somping the home_node.

e.g.:
mbind(2-3)    :   mask(2-3),  home_node(NUMA_NO_NODE)
home_node(3)  :   mask(2-3),  home_node(3)
cpusets(0-1)  :   mask(0-1),  home_node(3)

Should the rebind code also shift the home-node or un-set it accordingly
to keep the mask/home_node behavior consistent with the syscalls?

(see mpol_rebind_nodemask)


> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590ee1c89..9282be2ae18e 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1536,6 +1536,12 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
>  			err = -EOPNOTSUPP;
>  			break;
>  		}
> +
> +		if (!node_isset(home_node, old->nodes)) {
> +			err = -EINVAL;
> +			break;
> +		}
> +
>  		new = mpol_dup(old);
>  		if (IS_ERR(new)) {
>  			err = PTR_ERR(new);
> -- 
> 2.43.0
> 
> 

