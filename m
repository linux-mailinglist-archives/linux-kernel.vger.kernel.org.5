Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA176EDEA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjHCPT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbjHCPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:19:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBF74210
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm91p+AtHO9/4Ms9qpKtLbz+tTj4X+EwU6qe+sWkGFtN1QpPbgZVW0yvZKnVXent5r2pkh5Vpmu6mTwbch7FGkFdhe+mlhyg3xVxw/fS6i22U4Wqxo8M2pQsmiciYtEPPZuZ/IK0W6CwxBQPz4RLrZLl7Tlgda+ElZRyaicxsCBguTwZLTvEiQOy5TeCeNGVCGIAL8jNEUbo6Ek9x/x/hmPGtPmnzoKl0d3cZyMqsuC+QZyP59zOgzE12HsJnMmJ5eD0o3JW2T5ERRf4VFyILAvIoVAe3C+KJDK/v0AvnrjcyCO7JsqEhf+MTbkKAU35gUetm+t+oExjer/Wsx/W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JienIALvIKJXp67xm1iJ9/stXGIZwHBSAxticLg4iXM=;
 b=hDiYK/mMZw8VBBaN20wRaoLfhyA/kqeGZr8vZpy1suL/e47Gagy8dM5jZokj+RDkfnlS871fLxDMqZMkFGXkn2y1W7+kFgfIq4m4lChVWAfLgmDlvfvmcnkeZwHiKY0HqnV5hEgzCPSMkrCooLwPZkT6E9tQi2uFOdp9p6wRExesmFljMQmBg46td7P2EFIrYyQCQxTvAnYiEt7anoWal09Xjin7K5+ZVwPbGqcGM8T5DNsVQFUVFpO8gO60WCPKNywUpm3h6JeaCN6TVuEKDlY8TlEtAv5zk4vE3CQ8qrQAEKeSYTK9yAMrfpd+3tV9AxLlAoWVL0uyHn+D8EzpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JienIALvIKJXp67xm1iJ9/stXGIZwHBSAxticLg4iXM=;
 b=RFwwYlR8G+2BNXQVtZnYOx7lWuAAf85TUTsYMO0Xz2mIWiH3CZYW+IxLcvi5RhIr0hCXTkcueKJvKC7CUcsvtBjv33YGBx0zKyaqNyH73K+aM8sm+tZNwzw6NHH+ktMYxNoMSvVHPl2sL0EDx91d2zIra08nuLQFzDtXKI7aYae+JNvXrJFNDw23LvO82Y9St3V7dZa1OB51wSK3dZMldAr0HAaWkNZKaj4woPmrp8sJ6ZlrW09tvmAxORX5DCn+/SR0AwB9qpAUyXKaNnpz6THRXnKYYB+Dm4wPHHAnEfLDBno6W45SMQkN/lWUamOhp2tsw/pOtNdwuyblHeV71Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 15:19:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 15:19:06 +0000
Date:   Thu, 3 Aug 2023 12:19:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com
Subject: Re: [PATCH v5 6/6] iommu/arm-smmu-v3: Cleanup
 arm_smmu_domain_finalise
Message-ID: <ZMvFZ3O7q3k0skuu@nvidia.com>
References: <20230803101351.1561031-1-mshavit@google.com>
 <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803181225.v5.6.Iff18df41564b9df82bf40b3ec7af26b87f08ef6e@changeid>
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: b11fe08b-91a0-486a-edf9-08db9434fa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ7TmEgMDRVdEnknD/tRNhunmQArAD9Njop1KcAPmGMBiOfEMVEFkbmmBYzjS3Li7ZQ8+YuTAmNEmXrf+YZJxBix9caRWAiHhF/nsBtnCCU1UHfXPj6W0W3fRy1rt+AktHasapqlYQ5a1aUhLXTc1TpnnLR3aokZRTttTC7X+x9jgDYiMZcJZoRhTGCdwc45CKmuNbqLUCp5vIi6lneC5IV1RaZl8H4ds9yiZj41gHyuN86ZFW+ZOGouC6FYGRKZBUP4sU2Va4YhHLVTdy15E6dwo/QMyyw0hUPzanLDsCx3Mf8CnWvYoa7uo08NlkuYqqwYRl7LQAjqml/90q5myUHVOGPtv8WvjB9xRI+2NT3f14GrjiDJossQmPAEtBdgRf94PSTjIxk5cLptRl3S822VCu3F2vzzcGMFv4X9QyaEfrNi75qF692aW+G71vDXT9B7OgVZJUSMTu4CcC8zDxDQ4Xr4rqHxc78qHNSeZ/3fY9xFnvgH9+xch/6UbjcnObb575GprDBjy+DaP0+A5i7D8Hw9PhBvru8ULcKVNqi5yTankTlpOaiV0NecCiVO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(107886003)(6506007)(83380400001)(186003)(26005)(8676002)(4744005)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(66476007)(41300700001)(8936002)(6486002)(6666004)(6512007)(478600001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tGIUmQJxd9FTMgsYSwjlTHpM8+9B5G19QvN9se2f5g7VouPDZlTkaXzBo9rH?=
 =?us-ascii?Q?4g/1A+i2yhcm2/0pdPjc0SsoMHvx03lZ2FinaxAfm+8+B4ha6/AUFKX9LXbx?=
 =?us-ascii?Q?UzEyg5PyaHIPfX2E+1264g+AB+Dcl0P+ArBhG662RMrFrggriyjIYqnhlxIP?=
 =?us-ascii?Q?LBwHlMDgfAEi+YjQKcLjtsEKRRyIda+8nna3/+xPAFKictTSdd/b9AxsrRkw?=
 =?us-ascii?Q?TInHrYnle4hPHwPPkKCsqcddtkE5JIYNS/OFUjk1Us9+F7HspPYlP7J6FmC9?=
 =?us-ascii?Q?PIeYWFeJypIXR8sw7cAn5lU7bk98eQeU+3+Sxl096PBbInMMr7PvP0EA7Rif?=
 =?us-ascii?Q?NQm3AoRo4ba/6S6ryDS2+zeCi13dAVaFuTfjLKuXp0cgNYSYu7BxBYbbQUiR?=
 =?us-ascii?Q?MUTK0zABrNNvze2wwsvd7RO6rNcrHCsm5jUM0OD74lKUand7pG6OSlNdLgVA?=
 =?us-ascii?Q?NAYHYhtUZavvFPvMhNmeOTWm/vsBdO+VcX0vtQP9sACTSyGg3mfJQI0zhsRi?=
 =?us-ascii?Q?oGQCCnrmTTKkK/MuW11+b3juuZYT/dgCbL5heYTyFoE4wENRQ3+OObiKlKs8?=
 =?us-ascii?Q?QVmUjCuO8IOdXuwMFy3zylXzlS5JfAWlVccOGOk3bLy8szGxoPZf4QKeUAaE?=
 =?us-ascii?Q?dZ2nTerAb1gylXbWJF3hBeKEBeWT9ohI9HXytW5cggiIsML+hCajNrvzyWaB?=
 =?us-ascii?Q?H5dAuL37jSlHK8SOGn0uTlKmhyvIkURIzsNPATOKVEda3Zyvy9rXIXj/PtIu?=
 =?us-ascii?Q?RBbwNns0ca2sd+qe2/YIc4900z2YSXIKYTfexta6NWscDd03q/us89MWD3VR?=
 =?us-ascii?Q?jevUFYt7nupdMxLCrdFhgmEuFpwU78/dT+6e0iVmI1Q7zKIFYJwiy+z8anPM?=
 =?us-ascii?Q?gOssflcResl8Dx7W9FOlMrrObHdsiKpSFB9xGjkIlXMWPZGM3TGqIHRqIu1B?=
 =?us-ascii?Q?XyLPxrrRRjolDWkcIkn4/UFWuxINxF0FYtTbi1tBcWTp+bYhmxsYzluB/Cc5?=
 =?us-ascii?Q?ugyDNsrMBEOC0gOO8eofI2deIrQYjBhLhB0Fv8b1PzeL3a0pHHSPYaF1a6Gj?=
 =?us-ascii?Q?O+gL3Ppcbj6XfO63oNqzLfMXjC8hTnfFSwXB/qQl45D3BRgNBQ8YLHJZsAb3?=
 =?us-ascii?Q?2rbHQuFpFT7mU1jcmk+jONKaE40WS3Ocs6tviDyjRXj89KWKanYD3wd/WjIO?=
 =?us-ascii?Q?HRhEgxBJKZE5sXahlpwyxg2+N0EKoANoFJ7FLFDhyJsNI3VY56sQUfloq3t4?=
 =?us-ascii?Q?GRib4teQ5a09PjfHM511y5GKGExDE35hLEtT0woE53O1XYy6n4d4XhzCLaqA?=
 =?us-ascii?Q?QLmerGQDmQRUfDAUB+DPqz2PPOjUlWPy62D8ieZYXOxd8rsdZ6IGTHYB63gn?=
 =?us-ascii?Q?bQaHFawVdbSWZShrsmOTykLA+9JQ//9Pc5qUiZJVIa8sn5v4DQnnYyVsk6ON?=
 =?us-ascii?Q?ZeQFC+9lo+uqWsPrPrakTrL1ZGKbPQ3DdR4X4OdwWuCimQN4sddiVz5O6ESS?=
 =?us-ascii?Q?z2o4axYEYLFePJOlevLHCymvGcHggKIW+myXw/ErbpNSFvKwyOFuBYv9Dz+f?=
 =?us-ascii?Q?cYui3OUkJKn6+uzO0zwxw0SAhG3lpOZZQCLxSDtN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11fe08b-91a0-486a-edf9-08db9434fa13
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 15:19:05.9687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNs1ilOKcsm34Wc1qHZBXi78SfzxcKyc3Zh7l75BVtleVpfYw7S4xcCuVPhCfqbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:12:26PM +0800, Michael Shavit wrote:
> Remove unused master parameter now that the CD table is allocated
> elsewhere.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> (no changes since v1)
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Agree with moving the commit

Jason
