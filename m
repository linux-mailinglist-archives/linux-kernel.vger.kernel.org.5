Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5423770C19
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjHDWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:46:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7A4C04
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NseBxk+fIitAZjfzzoMqC1vsoCPH+mhTbuTqmjmJqZbzKBsIJh08KHuFlkbQIrO0nhIpRjdCEV0s77H2Ofu0ugzzAQkmYtIeyaSPoeaeavp+wZjJUkRuJJ+sebj++Uv3gvgGJz1FAxVU3anZAwRbJ5RCb+B4auoxE0NnsNRAmtHKcT+z4YN4krnco6LAHemsSvWpW4MAYrzLDYis3ohKrcImAVOUPWqV5viX7A2x5zRlwkuzI7XU0SGZCzWVNiQfH12uvcBppUrBhcQbGNasyMeOo/+xj1bHiA/aH69WzcsjxjmWJecdDDwoAaa6DtiZN50bp4GH0qpjOfp9egVjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SfBiyIdz0NGJevWBG7OnpdgnCir55sPR1Dm3i6rH2o=;
 b=glTQkCOixKNbmNuZqmHpT/ogCeTCruJW92eQqAC//5nj/+JRuIwBE1V5qOTih5CLb2AbMdJa7YA5H0tafP0BympW9gWH6Hn6wuBUOSd171Ag/byrK9LBQ2Sz8C6UM99IbbPzcRSzQubekGXJF82Kess+OERn9iKEtRC+ehrySzIrCMjrxo9ady7w6Nck0dlvRRoR9IvEmuAjrOjYUPrBY2ska8GxD+Ov8PMp4z2hiNQvjr4w4DoTx0EUbjKeMHZei8CIFVjyF17VVY9Hg4dIlNZwmCjrE3biVp06nL6vbjO86fjfcsp3KTYBH251zsnwxHo+PGDASuMH4fJDrLc3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SfBiyIdz0NGJevWBG7OnpdgnCir55sPR1Dm3i6rH2o=;
 b=JgtowYxTNRDE+aFFK38mpYEhIS4AC1bBORYSV9mAx5Mudrb1Cz/1vNCxi+2XfVwnfwrDb/Q2VBDIuGHGPBFoakF/9mC9a6cyRlionHYEJEGfTNj3XwqIGzv5mcSKCBgDZp7L8XBzQ7uyItP1DH5+Kpt+YVR6mTcE16MEr9cJS/fcp0HLB3XVoq+ChDMmSzJlGgte4uI/XQMjtwCVd/c0FXK4NErZ3o3nIkrsFJif1eFfhwYffdNiYlJIXLHKpbuahOb7160BVgg5JMnRn6WqJCjx4pki9D+hig3GOm8CY+WkCuPcnSzinoHvky3eFt6U6zH82h8y0yEPJmB60dHqCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 22:46:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 22:46:23 +0000
Date:   Fri, 4 Aug 2023 19:46:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZM1/vx0bgNZXYcY6@nvidia.com>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <ZM165+0WUNsIZ3Sn@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM165+0WUNsIZ3Sn@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3b2e22-730d-41be-d946-08db953ca114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1f6LkOHDoPoWQv2/bUYzIseNd1IpT04FwSouo0J9SVSLYHDQkFY6CgFsqfChfdsKkCJPnGkUDZbR2UFeT3hxaFsAC5Z3X0UnKhGOAJkw+WQE+88RQ0pFkv5K1MbXJHcevJt8Hy9FA5BRPyvIGyNTPWJm0GGe7OFZMfgSdLQdgZWby5bEloDNee3ZsImItcKVXSAhEvda+5aPfHHx7pkLpRMQUedf6TaqaM+7i4K29FNfoBfqyPJ53UmhIKwXtTVy8ONJZRt9CY8DYWBXXdzOTe35Cx625XPhdTzImnnaiZYdb3FICIoJkySbC+n6mw51vEBAgZF4zFHkdmP/LmWuPHsPoAsm0cA2q/ft7rGCPgAWV6+K+mM9omw1rGP6Je6dfnHFAbR0iBEUz6JNouEUYwoGo4CkoFnfumcK8Ftj2TnvQrYS/UX5xtGMYI8526Xa8HmzUiTR6j2ajQqlflkBkWk1jqWoRuLsgoXJ3/IrACcL9XGV8RVGoYvmznwJ6lV+IUVPCAAb6qa+Pf81+dk6/PSiU3fCKZDtSEGCmh9sFJG+0Cl2dDo0/MTHZgLld7b0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(186006)(451199021)(1800799003)(26005)(37006003)(6506007)(478600001)(6512007)(6486002)(36756003)(2616005)(66476007)(6636002)(8936002)(8676002)(316002)(66946007)(6862004)(41300700001)(4326008)(66556008)(83380400001)(5660300002)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RKaYS4eCTJYfe9QYg9uLRCgJCeH8Xf+Y+GSLbinQ4i1ZGcDf2jKAmZnHhTFq?=
 =?us-ascii?Q?g8jhq7XaTNf1P2RKLOmz5eIpm/hE7hoUp11RG/yq1cxUIhhm/h/27Cc6jza2?=
 =?us-ascii?Q?yhWXmlNlVU7Go8RZnAeo4X9g8v62yqm3p4r/0ZdNIzlI0+ZL5vGtUccLfCQG?=
 =?us-ascii?Q?uIsqkYHfTYmFydLnXwhSj2orAngR/3zB8BvXKHe0nfZnn5iUgfCCZMSMXYJR?=
 =?us-ascii?Q?LRpzDsReAAS3bTvCfvt9f6GBsM/NMLdejcheVIGzaFcOTJBv4Tt42Scseze3?=
 =?us-ascii?Q?JB2n7hlMF+HqH5R5F3T3+6n7ZlVYaPu+SSEZ6+RW8B9V1dmkLPFSjYPEsogl?=
 =?us-ascii?Q?K9D2bacSFv9IClRBAK2cagpy6D098rCwx906fgoHdqhqUYCLpv2nySBo9vRV?=
 =?us-ascii?Q?u37Eoq4B48ptZZpbumE3uuDD5vlYmyRcvpJsRiMTuDSinZCiz/Ll5tSFeQPl?=
 =?us-ascii?Q?flUP+8dAmFsSgeHupomo/RPsMRkIhYomVFO1GHjpZscjVP3Cu/0z7sHswn1R?=
 =?us-ascii?Q?OUkQa80bYLrJjK2ojnVGgcHgmio999iy8TwT+s4HHDr40eGJ81F7Nue6aQzS?=
 =?us-ascii?Q?2Eo+ZcSvm5sOm0hPsxoA8GsI3OJ8GIX2eG8PnCv/7Vl/NJzaeiV7CREDwXz/?=
 =?us-ascii?Q?3qV69q3XPjjW1zSnnSViqTc+A9BqZqI63V2hR79XFz02Q6KrgX3Pt0X9smpx?=
 =?us-ascii?Q?3A97xQS+rvpY5TfLRs3ogeDf2ASEctOoAIqfLYxjLX8Z6kXb8sNs2rl+kMz8?=
 =?us-ascii?Q?L8C5GLcx52MQ7YAwnwzLB3IximheprItCFcyOBanmsQYCbzqd5u1AFX+2Uag?=
 =?us-ascii?Q?RZc5ViGxujWcRmGNFQohW01OdZsKMiGmXvVCOSny5KHwJhCU8PeQuBDPoUFK?=
 =?us-ascii?Q?Sg5cH0ET4wgKUt28PbDcd2abEhufg8Wz/9MspuuZujQm3c+UXy5R/J9sw9nm?=
 =?us-ascii?Q?QlY0KdpuLrH1eaE4JaqCcVSrWfy/q06PmzS/wz4c0rN8s7HTwIVeeXQYbcQ0?=
 =?us-ascii?Q?QPB4Ee0z7z1ovH/Zf526isiB3mk0XH0SpjS7+SbzNG6r3ZhZ98rQadP65RhE?=
 =?us-ascii?Q?Mtt1I+q638s9F9ExDj+lMTlBkl/8V1KLv9My9h+vK34CrFp8bngdVyjX36SF?=
 =?us-ascii?Q?9i5QQqGkzudllTrG75vu3AD5izHhD7nL4KUSz3f10alnAt2UNPKf1xBSRM3J?=
 =?us-ascii?Q?UmwgdficC9H8YWDSBho1dW3aanejQZL+AnPp9ko/EdBsgmdsnl0zMf8u9HoE?=
 =?us-ascii?Q?b913WpV8NoF+4tV4NZ4SkDhCOM4JN08Lajje88lshE+U/Es9WUrNVkhRhVdF?=
 =?us-ascii?Q?LPRTa0kgptA6lfkjekRgst+HrQAmMzTIEEjkBNgFFzc8gFI8r4V1HvayxYdm?=
 =?us-ascii?Q?FCiCekhEN4xDWGzE+UQ5GOiXwIR0bIJfBuM+GpWUf1Fs1HNI4bjP31FjsZPJ?=
 =?us-ascii?Q?i1o61nOaZXd6tNS7RdorlMteXGXi2wy5VrOwK5nQ7tVaeo/m0Lw/UfiWoe7B?=
 =?us-ascii?Q?iC4DLttvvrMXHV/NDYaKPRSRhlME+hPok0ipP1WONI27T1DaMy61CYJLRO+a?=
 =?us-ascii?Q?IqOg9elG2hs8vz2dV0nn1q36VR3f2eCNRwDMwlZX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3b2e22-730d-41be-d946-08db953ca114
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 22:46:23.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbrouPnJjDaxYwXTveWWTiWOA9dtULxb9hl2ZCVs2sOkL2/vcQ3hUlgJEk1HzwJD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:25:43PM -0700, Nicolin Chen wrote:
> > @@ -2436,22 +2419,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >         if (!smmu_domain->smmu) {
> >                 smmu_domain->smmu = smmu;
> >                 ret = arm_smmu_domain_finalise(domain, master);
> > -               if (ret) {
> > +               if (ret)
> >                         smmu_domain->smmu = NULL;
> > -                       goto out_unlock;
> > -               }
> > -       } else if (smmu_domain->smmu != smmu) {
> > +       } else if (smmu_domain->smmu != smmu)
> >                 ret = -EINVAL;
> > -               goto out_unlock;
> > -       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > -                  master->ssid_bits != smmu_domain->cd_table.max_cds_bits) {
> > -               ret = -EINVAL;
> > -               goto out_unlock;
> > -       } else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
> > -                  smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
> > -               ret = -EINVAL;
> > -               goto out_unlock;
> > -       }
> 
> ... then we remove this stall_enabled sanity also.
> 
> This means a shared domain (holding a shared CD) being inserted
> to two CD tables from two masters would have two different CDTE
> configurations at the stall bit.

I looked through the spec for a while and I thought this was fine..

Stall is basically a master specific behavior on how to operate page
faulting. It makes sense that it follows the master and the IOPTEs in
the domain can be used with both the faulting and non-faulting page
faulting path.

I would expect the page faulting path to figure out what to (if there
is anything special to do) do based on the master that triggered the
fault, not based on the domain that received it.

Jason
