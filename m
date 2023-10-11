Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F947C5426
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjJKMjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbjJKMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:39:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF886A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvclB0Wgd22IjeFNO01rg1Xmd0E5NfL81sGECmayujJ09KC4toQeJ+RRW3gD9VMuN5feodJBhfDQJuKtsETaUPPXiltXx0hyskJHaMYhJGoFv7lCtxqdOIRsvZkUTn6mcmz8+pRG74wrCvi/HyvF4w8jbHO/hkG8xPL8RvG08M9wqR3xLVXpHtzBd2DJaAZjueIlIbFp8gRHbWCqqLv+uFWey0YpF4ylNYJMoz1M3VNfRKvA+C3FvTu7jSLpSAUAHWBEVnmRHYaGa++t5OqFfhk075OVKgakEDruAnkdvjS7gKZXXOXciM9aYKENW7tVcv3sTvx7Dzjqq+kJ+k/hOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oflGDO8jqLP9GRifYqcqkmK4tp3EjzApoCByGavTI5A=;
 b=dmGSbDWn5Ix7v5BUAswu+TjLGv6Ryfc2V1tZ9ZYk1EtfmPkhTs9g3hfYCujj9fxTiiwcFq7XuFWvtuMY/WonBA49y03cbKX8i4Fi4hPfGVsGVvx5c4GNCJ5RBqV/FabSLfrLYWzdyly2gdU3QFzTIm8urRbt4HkxgjGaDGI3Pffy5GgJpxCe6ozbAOy1zfRXS5baidqLccANd8Cf3QgygnL8LsQDxNQNq3rbCFqwrXg/CAS0HYd64gho3Xadvu6vP+ixEVzntlUm7zbu83w81kmuIY3aJqdmiBCkCY11BLvVn8d/2JiJ19MXV7kK5xU3nXEnHECwHQLc1edg/Q3VJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oflGDO8jqLP9GRifYqcqkmK4tp3EjzApoCByGavTI5A=;
 b=h+dDdJDvO4bYPWpwhKvibWZKlrOUHheyAvgwIDL+GUetxyUyHahuCU3/tuTHE4QKpbmMKefPbTANq8+l8Hqawf21gPZt3r/7zyCUeO/Rbb5A9e+oeB13OSVtPZTVsPE6YYJ+egmlw5ufnMkZj/TP2Ph9bjDi6x1UEKfdeH1SkQURS8pCPEy3W8Gl0wZHx4+oeA+1LHlNM0UI0ZkjPQGeMY16GS/WLgSL9eapKg1zDk6k1tqfxoB1buh265pMXyd7nhMm56FlrDEdOQmE+cycB7e/d1uNCwWigAWuCvq4Tizl0Fdq56SL9sUhazntH/LSPIDTYeLj+w5SESxd6vFonQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 12:39:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 12:39:11 +0000
Date:   Wed, 11 Oct 2023 09:39:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tina Zhang <tina.zhang@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [v6 PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20231011123910.GD55194@ziepe.ca>
References: <20231011065132.102676-1-tina.zhang@intel.com>
 <20231011065132.102676-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011065132.102676-5-tina.zhang@intel.com>
X-ClientProxiedBy: BLAPR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:208:329::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: fe727fbe-0636-4485-4768-08dbca5711d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ue+YFLgt60W41WUnrc19xfls6Zg2jys1TEPx+TcvVcqpwu5pB2k1RG/FuRHqKyEw9Ojzj7p0sD/LA6pCebuAxtuuhbT5o3C5KULCz9nlyOPWS8iawwcKBXe/mS4G4Tz64XxDhbaoKb5KUymdejW+lch8zJrJKeG7iu2iW4ox6bX5j6uGXi8HeSV0ybazlQSeNZWbc0lNSVtb/qf+4m+mtg3kEsPSlUvORxFaGtgUhDrhMSvUmvtx5NL2gO1bWR+cDk1GB9A3bw7a2T8dj9mK4iVDC1HfDYoPenpLbfu3+YF94o7wQkMwJDOButVrn278n5vxXfCwHRHkxN0fobxb//gEhFksFNh3BWCBU8bvXvuQHM8a2+kH96qer6nEk6z5vF8TqYOsMSmZVJ3vBobpHjPpTBI69A3/9+MaEj2bTY1enlUKjglPhr9gwjEhnxETqNttchnZfwpU9aKNrwZrOF6M1QOs7djzItboKarM7Xiic1K6RpBZbls8dEVDDUtRgHVeFfhOL5m6/Y5oYASR2IQgp1M8IQ6ROZyaZSDG06McxkhW0XpnSmbrlGwASg+R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(9686003)(6512007)(478600001)(33656002)(6486002)(86362001)(36756003)(6506007)(8676002)(8936002)(4326008)(38100700002)(5660300002)(316002)(54906003)(6636002)(66476007)(66556008)(110136005)(66946007)(2906002)(41300700001)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wYhbpIT4K+IvgbnITapVm6OKH5aKcYPFkPKGugzjYfvQFAlhg1yCg8AeY+QI?=
 =?us-ascii?Q?vcUJ6ok5kD1vuQD/Qa1pQRLV3gxJ1k2OkeG8zdAB23TZZd4328AlM7FGEnt5?=
 =?us-ascii?Q?H3h2cvkdtDlPTJ+0ctxEZrCR2naYw9ovfXGK5z1VxU+jW0c+liuKHI+3dpMH?=
 =?us-ascii?Q?kh7rh0tl4NfvS9KoRYvQM2AB15jv9lxfoPlPNxvzUonh5DstrLORRprNxcrB?=
 =?us-ascii?Q?LXLp8iDAaFoLOZ5xc4+choDncwS+QWu8ceCgkl0Fnv4PFPFe2LemAwRxB5L6?=
 =?us-ascii?Q?FTU1Kw9By/2+067wIhcTlmW/aSNmHqI7zWHCZJs0swDny7H242xanKaqMLl6?=
 =?us-ascii?Q?KVriClileIGyOrL0VXWP3MbIkVvQpZ+WEO5qZpYB4XJfqvh+UlAxW0n/kOCD?=
 =?us-ascii?Q?raTSihhjIZLQ718s/LcMtnPbZ2cvoPOIBwcY95x/rietZoOKcf5WBUzM9Je5?=
 =?us-ascii?Q?lRmbPhZ56QWxigpQ3C1OwxXyygwIonWPr3MEDSbQUkFO329t4271gqYlI7AZ?=
 =?us-ascii?Q?9fRQAsSEHTPy9875A7hn9UZOPHFGeMiV36oeEL4T6m/S0KPilaof8weps9Q2?=
 =?us-ascii?Q?u7Eng4E/tKhqqJzKcBIFJMyhssVdNERb3bWluhPX4nbknV9o/OJ+mazgIOgZ?=
 =?us-ascii?Q?2qHZkcy5ITPNG8/RuHRX4l10fIDCs4nfZ8cKBQqPxw9T/uty6CumMgAsdsRE?=
 =?us-ascii?Q?J93rnrsqHq+mNc2tnlf3onABG4W6ApcLY2yEnAYVWVTkTA6ydh9kaCSjKkDV?=
 =?us-ascii?Q?ozaaQeLLPcy2+4WOOlfCRUdfTOCiUHdjVieTLouNHs6MfGrJjcDzcevSuW+5?=
 =?us-ascii?Q?WxMws2kTfdSB3jiR+QOdbjLaO5ADc1y5/uOkj34fVf0wlxueSVOqiUwuXa27?=
 =?us-ascii?Q?XvtFVTW07Wrx3n3Ix62LjNBVd0YfFQlSYUfSw6DANFY9lFMdYDgXF3fHVN40?=
 =?us-ascii?Q?mqNGoL5RbUE86soFf1FL+UOn2ULnki9Bp/69xxfMP+QavBur2zJG26tPRaTz?=
 =?us-ascii?Q?Cva/6lF1vilVod8QYgw/vb67wrFqCXcdLV3H1oBFJTwV5T28c4KZQLb5dUfe?=
 =?us-ascii?Q?4Lhx2u6jR8qw0DtwesogwvihCo0NYNIZlex+6eAtLTw20sO1PpmoLjZlJUwo?=
 =?us-ascii?Q?nuZuWIi2qT8DeFETkvvieQ1jDUO/jWecG2Ye1muIqbhZdU+P5uIpWw86QsMQ?=
 =?us-ascii?Q?+gNRpijEtmhbPEu24s5Wj8mjYDr4O/MCzGFxbSE2lXRryrKOToBKUOc4FKuA?=
 =?us-ascii?Q?5rKiFMG6xiPj+klFbQypow6c+I8LeOrhJbJ5jH3FeqIWlxD1ID+LZonYRS2R?=
 =?us-ascii?Q?JWk0gsECFwEx7I/f5CraXDforadAufGqaC5f3LqMUu7WqOOZJVb1QyAvqH/N?=
 =?us-ascii?Q?MtKpZDzHqqxpkcJcMXfNKQ0t8+x5vg9hA4Xv5dwb3d1lnCn8p/EbjCG/1oC5?=
 =?us-ascii?Q?iHX19GAmA0O/ud7JWSau9MSl/9M+nt2OtBlw8USBn3TPgsX0lwrsvWxRIVLi?=
 =?us-ascii?Q?rHKqApQanEiKxvUteIwNgi8sQZUfVoJk+7pvXG9pqi2RA8eC6RazQt1BJ/eh?=
 =?us-ascii?Q?sRu2fUOkG8jomZJmSqAaoenOTBaprVMVL1MXReT2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe727fbe-0636-4485-4768-08dbca5711d3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 12:39:11.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDQ5TkywiuvZ7ogDBUxLFr/8Aum/KjuXM5bYHxeUBIwHp8C1QFv5V7rqMctvGJmm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:51:31PM +0800, Tina Zhang wrote:

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3b6d20dfb9a8..985403a7a747 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1277,7 +1277,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm_init_cpumask(mm);
>  	mm_init_aio(mm);
>  	mm_init_owner(mm, p);
> -	mm_pasid_init(mm);
>  	RCU_INIT_POINTER(mm->exe_file, NULL);
>  	mmu_notifier_subscriptions_init(mm);
>  	init_tlb_flush_pending(mm);

Nicolin debugged his crash report last night and sent me the details.

This hunk is the cause of the bug that Nicolin reported.

The dup_mm() flow does:

static struct mm_struct *dup_mm(struct task_struct *tsk,
				struct mm_struct *oldmm)
{
	struct mm_struct *mm;
	int err;

	mm = allocate_mm();
	if (!mm)
		goto fail_nomem;

	memcpy(mm, oldmm, sizeof(*mm));

	if (!mm_init(mm, tsk, mm->user_ns))
		goto fail_nomem;

It is essential that mm_pasid_init() zero the new pointer otherwise,
due to the memcpy, after a fork two mm structs will point to the same
thing and one will UAF/doube free.

Keep mm_pasid_init() and add zeroing the new pointer to it.

Jason
