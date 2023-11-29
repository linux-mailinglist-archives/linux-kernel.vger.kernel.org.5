Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664E77FE0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjK2U2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjK2U2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:28:49 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB3D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:28:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3KJqrlYFpuIvO2xdeWgBgak2JggwK3sQJWqhvBP0hSVLAxa0lHZzvDc0d6YMq8kVGQEnPoZgNBXVt3ai4xAKJqYOgcPd9Gqz4951CViF8dsoS0eeAt2bUeeTm5vUq1HiXQ4IjvPnzWsq6+/NnoEDIOh9cYxhIc4T9EoBKYIUetFx90E5cWUnOhuzNpsvGKxBa17RXr0yqVdPCrW+lSasGmGnrw2ihP6NKMyFIaA6nbucdw3+C5Z9/+utO19pnfcAv44zI2DcWaShZWKHVwwThLe6dyPGexQ+5ZFsfasd2d/hjg0MX0ITUtzFZQgqQfF/fW+GYFJ8P2ZzAXm5nchaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arfC5HOCyr9RCk5j/wf2IJQF2IhmzSKw7EojVsax6qM=;
 b=PXpKh1kIRsx8BAokOzNKdPiY+6rRMOhNwA+Ks/jUc+qw2iy5khx+yUZqTELVQYjbJKNPIzXLjvBJ3gF3jWKL9iT1SksTxR0cEuW9Bd9Qvacn3scmLmLsc4fQaaAwy1tCdL+B+IBQKbQzYTDmTUVnQfNG4S+SGL3p78vV3sl8ndOqi+ax1c1FomrOnZBkOKY4BM4NA74PhwM/sOokVfuy/H2aXeBjci4gTsBqom5leHKlnLHpLVixC4gXFQ/f4zypNuS+j6FbwMKo9DFWB90l4Uy3Rkd2j/qPtYUNne+b38uKyFylOpeH39VdSZGQIXy71HOy9iPn+ecs7E8mIkDHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arfC5HOCyr9RCk5j/wf2IJQF2IhmzSKw7EojVsax6qM=;
 b=UkzfligbpfuWfWH2Cmt0rjvIi6D4tP3OwpiNnh/rnJjYk0CpIdZ+hDiNF9Q4cR8NcP2tvJiigT2attM4EyepfGjMTHqb4Un4fXkIyGfQZR3zauNeuW/oh2kBYlotetadzB5TqKMeagodrX0ndCZgVHn/udMjtW7WcjlrPl4b8y2icU+0/oihIy7fTRcEi7tKegLnM7zceK0ejG1yS33qGc/t8MzzGs1UESC4nqfBr4KtEXUb66RufuemoLSbyLXcn0dxsxZNJdYkajgU+VYVbyZJD847Xb3LMJC0Ki0MRGkfQKlKBLQ7ZueSieRPTxAaZN2Tg6gFzUaq8+rpZd23Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 20:28:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 20:28:53 +0000
Date:   Wed, 29 Nov 2023 16:28:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Add support for static identity domain
Message-ID: <20231129202851.GG436702@nvidia.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
 <20231120112944.142741-5-baolu.lu@linux.intel.com>
 <20231129202615.GN1312390@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129202615.GN1312390@ziepe.ca>
X-ClientProxiedBy: SA0PR11CA0176.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0a2993-f3be-4fb9-6432-08dbf119cda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRzVLtKacyaLM18uWY1jaepo28ZCZqIbuHMLmDS+BwhJnr45FE5uCj6W4YZso/3rIHXFiy9BXXyrWpGZgFuTIeQPyASGv2/jmq98cJsvC+SRqk1cjsGT2K+QS+YJHTFBA9WSwdMs0uo27N35LLTcZ0iCjP0QgmnB1qhqNvjp7CvygQakpwXDPcyilMGY7dZenNEaYIVnr/czT1KdrTdJRjl8DPinVNXv3hnUe8TXrvTp//arxAHfUSOwx6qGNK8+LRwRtbZaM+r6QmOIJRm4nPMVGmkGvf0lotWZ9X8RwMBrPL8+4e5/BXspwTBQOj+yU9y5i0ny1029DIoLV/bhTWnM2UjOKRz3kn1Pi6TapEgA3V4fdkad7iLFhoeXCL+jianI1vt2qT0sLgfLil3DJqpJAtAoIilwAIFD75M2UhFANWAW9WL19dPdJQWe4m4dWdH/iBR+YTqKvotpt7UFuE0F8nqfDs+Ue6XpUj90d4Oo0/CYTwLBL+p3Rl/28qGhM+z/zL9t7mP7bzEWVWH+31zGtmrmEBoJspID/n6yhkvtVLEHVN9YWvIp+zqXF9xUYwDfpikwWqx2KeoufLhFJgmBhUCbS6+f8CyjRPzMSCMP6DcytDLQJScMoZV4Z2sRY7R2E7Cn4Z4Cy52CBY2RZMQQ8IuZw0C6lL6+vvxDbsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6916009)(66946007)(66556008)(54906003)(66476007)(316002)(8936002)(8676002)(4326008)(478600001)(6486002)(36756003)(41300700001)(5660300002)(4744005)(86362001)(2906002)(33656002)(38100700002)(2616005)(1076003)(6506007)(26005)(83380400001)(6512007)(202311291699003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koLiAOgpS/jjU57/H6hSuOOe8JB8FQKed3i3uSJP1mboeDPppxfRqC8hCy4B?=
 =?us-ascii?Q?GQc7HQD74xFAckYeCqqh/cgRxX+Ws4ekHS5Xs9Hi6/bwWaPfOWHGdg27pKDL?=
 =?us-ascii?Q?juYAVpy1o3d0bIwUehhFIUQ88i2EBgt95sh8ST0HSuaYoijqw+nHVF7xkvzz?=
 =?us-ascii?Q?somCHrpJEf4IouU4MItlbVlLOcbSFYZC7EzVy4CVk52QFpJr1fAVB3c9STp3?=
 =?us-ascii?Q?UOhZphKzwDDnPuHnciuazOdb0CZohf25kxZ9sFz3GgN1hnHhMmkBX4U3Zmzl?=
 =?us-ascii?Q?Zc6cQIrTfhChr7hq99UHDrQn+HyWAahMyN4x3v0Oo1xcJ0p7pnDi4rLjG7dJ?=
 =?us-ascii?Q?WLnB7kyRlh8tUOdbtGzRkSQyEV/kWDHCy0SMzpacmw41Ffe2TINLTebm5xgJ?=
 =?us-ascii?Q?wqE5ivFvc+22Xr3KnBiAxYw+8+tkxGjRF6vYNyt9nQIrNbDJQ5PoNhlBNeqU?=
 =?us-ascii?Q?Xp0JK5VW4o/uJww2vKGZZGQh1B4ReDinF3Ohzg+I4izSNv/nOqPskHA5VMmv?=
 =?us-ascii?Q?hR+2KZBmo7dNPZSM6J1v+r5+G4kjt0ULNPcKu3Zkco6L+PcwGMLr2xTZB7tg?=
 =?us-ascii?Q?5d9w/pXRvBvVknp1lZCITUWmpSt44lKdoxDh+aCTsARQt5KdJCnOWF4cBb8U?=
 =?us-ascii?Q?fUeWtpTbVD4d6i1lh2iGrQEdTGMOh6rTe3ye02Oc39X0U4ArWyIwfTnMyLcI?=
 =?us-ascii?Q?9/JsmDvFB6Nh/fmecr2x0F6MJQid/zXgVp173SQNxXRctvVm/BzRdeG8RPj3?=
 =?us-ascii?Q?11T9Bmuj1r2QsX1FYw/XW6K/WRriYt2yVgExVeL8KgdzmEorCuDO4zBhNo1H?=
 =?us-ascii?Q?VtGvFaF1MoYiEMJJQ8fKy77FVhv8vOvVhWDkGMLmEKx8IOYIKT2+ulrhCiJZ?=
 =?us-ascii?Q?ovgSm6NVp/Zd0+I+n9aOktG0WE4wsP7urvJ34p2Fu3wK5Tm6wUTUcHBR602j?=
 =?us-ascii?Q?+enpPgaAYjALRa7yqSAoDBHF4CA4swM7nE2eauhIkMqeGAULzYzI7vcycIEs?=
 =?us-ascii?Q?iPgPAzR0n7eX3PzRf9nIVC+3owOSPT29g/noDlJ3i4dpCQE/4DJOnb0RGPop?=
 =?us-ascii?Q?GZWip/nv+QL+3ACw4US+UqFYW05jRfB38Qg2Wiw5XAUsxBLRmxnjcobVmRzh?=
 =?us-ascii?Q?mFjDq8iyQGAEcfdjUjrIO4lFYZTRt7VluVPGhNuWwUyU4n9mDE42ZQLL+XTE?=
 =?us-ascii?Q?pJVBal/Hl0aw7rIcvCf1MRuT8lvHHhUgJ6zEQ4KLSAPXoZ2V62vgh4QXrfYp?=
 =?us-ascii?Q?Z+GLeIUQ4Y0f1fr3qEdEWA5yasg/YeUETX/9FsjKRH87XopxfXiBCXRUU1SQ?=
 =?us-ascii?Q?kowsouQdURZ1dP02GRZq3LmqU0pYN0ySkQrsKDAuNb/cTE8Jij1y0w/h8UsD?=
 =?us-ascii?Q?WG/z9lHD/PLE44TFbbALBTOdHZBb/vf4pPK5KiogfEuGoCcZTwcq1rakIPAq?=
 =?us-ascii?Q?bfIDwV6U1OyP9P4gOGDfNpIXqNtOoq/dxqPmQNPteps8b5+AYHGVD+0vZ201?=
 =?us-ascii?Q?NvsIaIfu/aOiYKGZLQwE0Z85nwLkX7g16VeUmBtXRBWooU7CAAEGo9KFjt/K?=
 =?us-ascii?Q?3pD/5+WAoYi7V0a7dF/LKcCfwN+6CMDkSOfYSA5r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0a2993-f3be-4fb9-6432-08dbf119cda2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 20:28:53.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwROXKCyqbaWWeJYBLgXId+7VpuW1Y+iLLcRUMxqdT2ReWAKoQmShkUpxuXKjx6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:26:15PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 20, 2023 at 07:29:43PM +0800, Lu Baolu wrote:
> 
> > @@ -2311,6 +2316,13 @@ static int device_def_domain_type(struct device *dev)
> >  			return IOMMU_DOMAIN_IDENTITY;
> >  	}
> >  
> > +	/*
> > +	 * Hardware does not support the passthrough translation mode.
> > +	 * Always use a dynamaic mapping domain.
> > +	 */
> > +	if (!ecap_pass_through(iommu->ecap))
> > +		return IOMMU_DOMAIN_DMA;
> > +
> 
> Doesn't this return from def_domain_type completely prevent using an
> identity domain?
> 
> I thought the point of this was to allow the identity domain but have
> it be translating?

I suppose the answer is the next patch deletes that stuff.

I would probably have structured this in the other order, first add
this hunk and say that old HW is being de-supported. Remove all the
now-dead code creating the 1:1 page table, then refactor the remainder
to create the global static.

Jason
