Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF30E7C6126
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 01:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjJKXe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 19:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKXe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 19:34:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E25D9E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 16:34:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lo4n6aBl803xCTzxUu1/yK0hpvABJ7Ot8b7UTqUx7+Hl9i+YjWEU2Eh1aCy8Pf164O1c6nsHfXHpMXdG6lbb/9neJy11XZmnF79NGwmMAz8JQCEL4dO6looDXftmHLA9ZEwH1rt1hfhfsezChUQ+Bm7Kuq6t0bVQ+EPGo8jBWEeUI2ULsGg8kw8DG5aH1jxyDXkm0ZpRtTwkipRJ/NF3i2trzjJ8drXybP43ELL42SGS4ewC1Pu6M3jpRFa1fkMtvbYK5SYNgdMtANfExDKLtptvF0ZMbq2X8PzOYwI6iFD1RGiF94Yfih0qxnoel3oJriBlq86OiwgHLFk54lDNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voav+qQ7CH/tHo3nWNDIK5CXXwY/mZvNu3tYx39l3+w=;
 b=cVzbnasCV7iGIsitU00SqV5DxSAkNHnffg18OjY6DuJFT2dPRJM2CZ6sx590asnyt6Z9fNJp+ojtm8vtUzZaxDxuUAIZnCcCi4bIn+rRoLr5o83oLVF4bAWqYmUCKqoUZ591HYFvjbhWsulirTvsyxOFgom2XeFdkqsMPA1AZc3QCGPcsKfKaKYjUj+LR0lmcJGk555epM5wVebFP6kbhjUiRboesYcsBS0e0gTPfn8QPcIKyzeUzVoqXkUmUTWhTtR0C+W5aHv/aNccDLcbJxQvVIeQ3sI5zdTU0SkTmyGxOoIHDDziXBQaPHWJtFP1eNiV2v5JM8GdUowMiS8pzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voav+qQ7CH/tHo3nWNDIK5CXXwY/mZvNu3tYx39l3+w=;
 b=CuXwFpYhIltaKCkcN78uDSZkVSEOVubufWlLGJThNJShKmIsd+XYSmHe417GtDCG7fOuWZnExE6D4SOO6nZqqd1tX2eLLzMdPUpoayrytrWHcWzOeUo1+cMnSdF+bSfUG9wAAJPvRYR6gyem2cs0wfzdZQMr3P+DQCxfS1fhNRkv9Ev4iU5xZivY0eggSKYVUd8O9VVtUHlPSlsOnvwCFZb8Mlyhtm6cC1/b+2LZgihuv/9vzGLXcN7rWOEWOjccorkeOKMxjOY9TvHEigiWxrfXjZE29I4quuixdDHmJRb4f9y/ViaUAiKz0noABcEK2zKDP4NUvDbw1AayFS0Hpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 23:34:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 23:34:53 +0000
Date:   Wed, 11 Oct 2023 20:34:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] iommu: Factor out some helpers
Message-ID: <20231011233452.GD3952@nvidia.com>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <72c599ef84ac29c9759c7f0ecc7bd69fa9aaf5c1.1697047261.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c599ef84ac29c9759c7f0ecc7bd69fa9aaf5c1.1697047261.git.robin.murphy@arm.com>
X-ClientProxiedBy: BL1PR13CA0377.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: cea029b1-1def-460f-2721-08dbcab2aba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tG4k8p04WgfCfZPJZsO3I6gZ2abQgvqL9rkdZkUBVFkTou3vRqXZ/6/7vXZbl78j2gTk1RZ1AoU2hV+0z1hRWge9OImv2tC+fyxfuEnQWb8gcLd3VeeFfoKXNlC8Hqhzb9vRLG9f9ohcKYtHFaCr4RrFERMUd2I6PT2N4mN3XxlxGxoB7uoaNwA+2udGB1T/EldgOw/VcWt7aqic4twllBqAyBB6xTwnp1fSNKMuPl1JdTyeJuVbCGtVpjkAwGKS+veIiOmWD+HZV2reQ4Y9ZD23khGUlLroc4H/3cqUhhyz0yXu8EJ1ikQhXxv6xQkmoBniolG3trB82Ljlx+udkQG+88jhwFJvQd5X+IMGeip28xcsT7ZfKkT6iaf9vSlOTtDdLcZRfkibQQJR0+ttaK5DcmmgO1OUhh1j7/yddvIDq0lJM4VEb5nhamXr5aNJCwcXkn+ulsbfdBVt4wFhk5oku4haWpVBkQR+yUwNJjgCJGuzcCZ3p90REeI6uWuFRCe/Wskc0QIIe6qD8a0h/adUqeaczCLSmTajevkdJy9rbM+YYheSCG3TCz1LTTYG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(36756003)(478600001)(26005)(6512007)(6506007)(86362001)(2616005)(33656002)(1076003)(2906002)(83380400001)(6486002)(38100700002)(66946007)(5660300002)(41300700001)(66556008)(316002)(6916009)(8676002)(66476007)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p+6G9YiQR2+to4ZA/nMdH03CQFBgSbZCKI0wMu3OYfyyTaZK2t3c+OoZAncR?=
 =?us-ascii?Q?OkdV8pJ2gdbCuu4/y9zLFbbxn3xsMedHQDm4WS+8bs/MFf0q5kECR9kp9+KK?=
 =?us-ascii?Q?Wq9UQBPZsa9UgCx09MErA1/wzX7YwUW3fXWCZ3PP6Fkg76BCHRF3f9L0/tEH?=
 =?us-ascii?Q?krbkTrHrgXz6IJn6/FHHgoed5+1V0m7LxELli6YDrNQuMTkjhjh8DVw1RrwE?=
 =?us-ascii?Q?9QB05y9zUomqJJ/dt8lVmPcRnnYy+drTFN7/WVEcNWVnQV3tep+/+XmabG1R?=
 =?us-ascii?Q?PIfSHruBtCXSpqkZCt2PrwY6UTVGxPBanL+DN3BdauYqUXDu32I4IkHY4znJ?=
 =?us-ascii?Q?IOhzCELdpyWcZMJkSV+3n+yA5jI1EsBnxsgUCt/upcTLpQ+fI1QqM7vfaXRp?=
 =?us-ascii?Q?b+E27lj2o3zOzzl8q/rE4XP9JUdX+F492FfMxRNb9/AlHe/zz0GZ3YabTfyp?=
 =?us-ascii?Q?pH6ZYEw7D9bOgbLdEBBwtYqHlDHfLYqv3iILU76MnEkIX2PjKDYGbwDWRIhJ?=
 =?us-ascii?Q?RgnDesQ0Ffoe7rMWlauz/VfrBgmc7Bgb3ymd1YrEVp6BJA7QQxVMlFr3dvbu?=
 =?us-ascii?Q?CXwJO3M/XE0Q8KEcbm17aoHd8d7Ybg6PyYnv/k+RsbDGLdrQwnFMDQTzExjr?=
 =?us-ascii?Q?p7rTFcnSb1/4uJYnSrZ4RiN+uzMBNUKqfbg+hF02qolGYMSqQ/4w2DKqHaFD?=
 =?us-ascii?Q?TO8IlP2rliukFciXAleYzMly83lxPslz4XIc+ZpJDSq6j/PMkYXntpoZFobk?=
 =?us-ascii?Q?uAJhxFS1L5BA1a4LmxjWG4BcvBhiRzywsFu462suPN+FLcrlUqWXMqLwXj7P?=
 =?us-ascii?Q?60UOoGY/0YaydQc5uaq83Q5xEuzV3JstiXx4VJkdtU3FalU6fXF4H2lZ+VyU?=
 =?us-ascii?Q?3+ivB43s8y69RVNpd3YFzb2eQPyamIMBpfeIJO4597BVYV+bLpHF5JN8ANhk?=
 =?us-ascii?Q?Dy5Ng776TZMXZr5mD4LQllqd7Jccg2XHaa93r19HqMok3WVCa0H9JXHVtVqo?=
 =?us-ascii?Q?H24G9ADbLZMAMSW+K6/7+gEzDXUaZCSDr9ZTxJdCXawtL9edTRrljXarVtWD?=
 =?us-ascii?Q?G2XT08+VrWbuFrMGFTrgOQQlw/uR9yP04ESZjvOpPrfNcW3SccvnXdlsU16T?=
 =?us-ascii?Q?CfFOqcGljXTnfsE98LJJ3eeHbVHAMMaKYxeBLqBKCq0YhNlymr+h72ZHIacp?=
 =?us-ascii?Q?TQWJl3N7ifGh/6ED7QluaNgikQPTuNxtDmbYbrDMv3A3TND3C/F156nD2wMZ?=
 =?us-ascii?Q?90TUXbOufYuWuIUdp0XyEoTNTpQt4Y/XYbCrUCH801oy7daB9eHTHhy7Zb4j?=
 =?us-ascii?Q?p7iYJWcqrCFt/UmY6BYQWvmqvjluf8kJL4uMsGzlBZE1h4tUmSFQeIpCXdmu?=
 =?us-ascii?Q?c/QyF4DyxeoYtZBpHXEhgTX3r+jOSVQHiyDq+KLpcSwWizyTSPR+DxCD8GNE?=
 =?us-ascii?Q?Wa91AIniVrHY12ZM4rTaHOHEPjHsHBDOQ0/98Wwi7XkaqJHUTFxUHqljxXG/?=
 =?us-ascii?Q?aveyg8sPt1eFOQxAbhKTyC7aGUTxJwN2/JcqmgKge89xA1IEQdy86Zs8K2nX?=
 =?us-ascii?Q?+HDPfl24y9bOGAKkP/VCMA1Ego+1Kz50B3z+pXTU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea029b1-1def-460f-2721-08dbcab2aba8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:34:53.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWjokfUv6HKz7rzytAXAGXBnjrUjSIcNcVnXvtK0vQhppcBhTrjEqaNRXMhchEXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:48PM +0100, Robin Murphy wrote:
> The pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out, which
> also helps hide the iommu_group_dev detail from places that don't need
> to know. Similarly, the safety check for dev_iommu_ops() at certain
> public interfaces starts looking a bit repetitive, and might not be
> completely obvious at first glance, so let's factor that out for clarity
> as well, in preparation for more uses of both.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Rename dev_iommu_ops_valid() to reflect what it's actually checking,
>     rather than an implied consequence.
> v4: Rebase, also catch the sneaky one in iommu_get_group_resv_regions()
>     which wasn't the full pattern (but really should be since it guards
>     the dev_iommu_ops() invocation in iommu_get_resv_regions()).
> ---
>  drivers/iommu/iommu.c | 56 ++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 30 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
