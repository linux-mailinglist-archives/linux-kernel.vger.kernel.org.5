Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579237AD96F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjIYNpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIYNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:45:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF8AFF;
        Mon, 25 Sep 2023 06:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrLm28Yn95jaPqoWTL5Bagg6RvjPzADyqnKQW+bP7eY4SoTvMLrqyZQeWVDG+aPBLqAknL3JakDOcu3AxmwDKWNa9uAOD/vIXQRILxkzN6LnQs4TjtfMCU9V2oAlpT8Aa+XegXL+Wx4ldH8Y5iPC33TEIYbFLBOKJ2zTeauAZoDlUHlQKbJwNBKAJfgsG6w4ZXi+1HRaawuYiLSMLEuxNcQldvaamNGSyXeefWZDHm7+Q0NwynubeoOm9jyLxi+i+b8ppoJ0sxHyfCfATWB/ojgPK467q6zRvusY/cziDhR0AQcdtL5c/InBQnGCrep9MbiWXtOLkS31M+ubSaqAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzPQoo/0VlR0x6uLvjqvRhqMnoKObmItvI/gfm6Fgww=;
 b=CRlSJYvF/oEXyLlgME6PW7l6YF3d6+XbQZJchZdvFEG7hico4F6tXIsdyQQGoe/Ww/qHUGU6fxjuMVsAr+5aRf1CKpFSy2Vhcr9+4lI9emQtPV2Cd7mXvR6Ds4k6Xr+LYarLZgvIwkNRa94J5Y/2bZj2DAV4aV+40+GNaDw3BXK6KseXdjwk2EPK6h1p95BsY/zsJFEWrf/+MUViBH/BiuFyV2P0YJAru4UWxPuw0yowvWOdv+TeRuAlVJ+29a69yJw7aSr7Pa5MX+OzM7navSLdl7DuhnMH8wecIf+UDYy07TFr2ybXU3AgRdkj08IyRqu+z5JejFTu1nyvnOWNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzPQoo/0VlR0x6uLvjqvRhqMnoKObmItvI/gfm6Fgww=;
 b=lUT+tSSEEEUsOC1bGAnbLOmMj+uYy3rkL2408EvI7g1h9lvYV0BGF8YNMBkk0ighBTs4QvgYrxoB3flVfIQhA02pXwpRdfk4WBTziGCW/tx8EcmG4PxJsL9K1XdZyLkAAm6N2Ntsq65ts7pP/DALV3h3nXtaBj2AJehhbe8Sihw4Yr/n/fIC3NIZNZEBEsAgkmhkD4amLrnOjbq4Dy9Xm1dyiH97bSCYu0Q44RkUPe9amL9ofcfZKgREZcbPWGgpOh9vUyPJTR5twPtgNNQieZpcm52nSnJeOLXzXa6vUqjEqtVRirC6G7LE3dHbZ7AG+CbHfpYhIfnnWzkzDKDa0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 13:45:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 13:45:07 +0000
Date:   Mon, 25 Sep 2023 10:45:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 4/7] vdpa: change the map/unmap process to support iommufd
Message-ID: <20230925134506.GB13733@nvidia.com>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20230923170540.1447301-5-lulu@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923170540.1447301-5-lulu@redhat.com>
X-ClientProxiedBy: MN2PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:208:a8::36) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: cc512647-686b-4073-6728-08dbbdcda150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQ+ZUCOfxleYkuo9/TELDhkq7HK1tZBCLJCBiuXT9o/O2yq90kG7YE5TyclGGkMUp6VOgVtydMehy/WxowQgoNUOVMrAJgoq5mRDq/mzG+UksIPTjCzP8GDKsjmQixU+Wdc4Esup+QYbw3ly3LcYR8HklEKj8jqR4yWPyqOeyxqbHCaF4L+312nLIFrRFKDoS9Y46WhRAuiepzYr4UD0YzH5sv+QbdKYuKOgNAFklro17d8IAMr5pikqtR8///HjkKZ3Vl/YgHpM9GsXLEfb3XBnwhOaCXBubgN4wI4v4FcKh92OYARAIY3Jwo/Z5X3txevpzbWU8lz8UNNGz8IqOcK39rXHllPXtpnZrtmW+/g1i2eqmxae3YpHE2Br8U/vliIg/iAhMU1MeKPXcrV4eT47pnar1MV9HmG6C0tE9/t3zWzGheSJqxsGV2Nnh2kqEmr9Ua6+8JB3+vNgmrJs5s8k/YnNmrJ8fr+UtFjjUTBlcAh/d7YJu2CIgcdrq454vKwpiTgBu4FcZAwDjDfQ6lyAczxnbyqp57bVQ4wQmGr+ILvbVwTqcV/L1nsJ+90v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799009)(6506007)(6486002)(478600001)(86362001)(38100700002)(33656002)(2616005)(36756003)(26005)(4744005)(1076003)(66476007)(5660300002)(2906002)(66556008)(8936002)(4326008)(66946007)(6512007)(8676002)(41300700001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/UlSPqBbn/curdEhKKgsc9wIaChh3/7sZEMKE9HCg9zGxTDSafMwrW43/Sxo?=
 =?us-ascii?Q?3KEDNw7OqyJsISf0n1HuM++JA7hYQ3yby2mKbbc8OK+5khwPalIPkE6qSFXd?=
 =?us-ascii?Q?wpJJHaKZwHN6Qj2zHYdyECz/8tci2O06l0w8tqC8ZHBmTsdeiqfmQ8TRfd3C?=
 =?us-ascii?Q?m+ZWd6bPdVpw6cHMttSdczcBYB4jYkgWOqh67JEhnEsEKR+XQ7agT2gRhgXA?=
 =?us-ascii?Q?sBPpg7LVjas0sl7sJ2kV+z/fchowkIJvQN0xFt2p5KmDY7eThyrsXimVnZd2?=
 =?us-ascii?Q?mJLuGYOV76OKIV1k/w6oNxr8rYeqva3dlWpvOEMvNwkkMUyvjDGC+th6EUwe?=
 =?us-ascii?Q?uKuQbnaEJsJuXvPVO2o78EjSQ+PEI5hTPwZUSXVqXczu+yfkhV43fsq4/cNs?=
 =?us-ascii?Q?4g1piJvnhGp2JCa3TrBXf3rSeZx+edxI8PbK6q0EH+NaJs7eFvydk1CSNRs0?=
 =?us-ascii?Q?dd36FouVvcJV1PPxkk0zXApNftjO0EV4TZ2gkpI81TC+9V+PM0sJoRBvNwdf?=
 =?us-ascii?Q?oWsG0HoLepRsEVxxkOTxvXOHrJ6G9MmyPalgcMXqK5GWJBe3IxNfpIBfS16p?=
 =?us-ascii?Q?m7AywV4g1WFnzydjC3pD5QtO2CUPvcRPZ+RZNINQrgq83GAfcojBviHg26wB?=
 =?us-ascii?Q?OksBrmavHLdkwdwOM3dyWy8SbAILsBjPOZg8z5I3jskgNd2NsXfhHxl+7rmW?=
 =?us-ascii?Q?xvfJ0rzNGPNqkhR7a4QWx0+qYYR5j90vUswAzuoFvXxtOeDn4RFzEY7GAKmS?=
 =?us-ascii?Q?+RV2oLlPuWgEf05oUBBRUeecEOcSRU0DNCtbU52SxTr1ef8BNlDAI20IW3RV?=
 =?us-ascii?Q?ohLemLZZs1y7b36OTQGz1iAjg1n4JPdCx+N6flcN1nHCdRDA35sAOC5uWDdw?=
 =?us-ascii?Q?icc1mJiRy4eQn+f7V9b4mVfhGck5EXfk3Ku2BqOt4e6JRHLKvi/0n7+vABAx?=
 =?us-ascii?Q?M74Wgrpn0+uBLB1xXpKoGq1y9n2upK7hSi2g/3hhXLJ9QcnK96tDqnngRRVn?=
 =?us-ascii?Q?pBc/ziCQ3BJPDXM+Yf37sSrvJs+yvnmB67rVtinuVcJd9xhKQRpLbfNtm8EI?=
 =?us-ascii?Q?ujwjLjmvcHvzU8S4yD9vNro73l9meSJkgUU5Gw2wlgPC3q+l3qI/SQM8xFOG?=
 =?us-ascii?Q?cVE/k58SsoNagExtF0NYvD1zhVrTsjmQXpvrQW/+Cg7A7lZ8psE00C2nGB5x?=
 =?us-ascii?Q?sReUDjbcz3jrxOkJbv58t3lgQEL247pEwGVKrnmpvLZzSYYXaxeyO7f98OEP?=
 =?us-ascii?Q?UcirzZli/mI4kN8T5M7jXeCIZsz7J4oeWSqLFcNiZudAfFsst1KSf+shFvy4?=
 =?us-ascii?Q?azti0u/Hgk3Lmae6HAATqa25wDl5BP6bmj0m5yx45vc0vjm1BSwkgIZmZxOg?=
 =?us-ascii?Q?ehM801RW35SRUseQ53+yloTrz6Fh5djqEpOF2l100JUFc3gIv+2Jlx1myWSW?=
 =?us-ascii?Q?WZ5J3lhQCmV+I5do5JiTr6qjDczPDxm3W0d3lc5bRk0C6FUj3H3IZpYoKDeY?=
 =?us-ascii?Q?JMN565d4z0eUNohEhmKkq4IBDEltXawhixy0MswmiOIW18xQ3AdnY8qtYFkn?=
 =?us-ascii?Q?Y4xVP5+UYSV6wmdnpz8x0deoozsr9ElLCqqz9uLj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc512647-686b-4073-6728-08dbbdcda150
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 13:45:07.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz6m9ZWLoS6LXBLL6qkFgOzJce6FzIJwYuXQX8tzuLUPcirn90/lGHD5ZGNOnAXB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 01:05:37AM +0800, Cindy Lu wrote:
> Add the check for iommufd_ictx,If vdpa don't have the iommufd_ictx
> then will use the Legacy iommu domain pathway
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vdpa.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 91da012084e9..8d1ad89d4671 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -981,6 +981,10 @@ static int vhost_vdpa_map(struct vhost_vdpa *v, struct vhost_iotlb *iotlb,
>  	} else if (ops->set_map) {
>  		if (!v->in_batch)
>  			r = ops->set_map(vdpa, asid, iotlb);
> +	} else if (!vdpa->iommufd_ictx) {
> +		/* Legacy iommu domain pathway without IOMMUFD */
> +		r = iommu_map(v->domain, iova, pa, size,
> +			      perm_to_iommu_flags(perm));
>  	} else {
>  		r = iommu_map(v->domain, iova, pa, size,
>  			      perm_to_iommu_flags(perm));

Um, why is the 2nd else the same as the new one?

Jason
