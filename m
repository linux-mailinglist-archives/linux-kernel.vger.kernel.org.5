Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B060976F0E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjHCRwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjHCRwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:52:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8191A4200
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8osPQfYbsEyx514rU4bLMQGPC8UfHASziln6I8A8UICdCSt1eO2DdK0jgUfn3r+joGxNYgeXwPagv0ho/hNiYfNDyb15cir7LzCktws1Cwe1dbY48DIHi/o1oNyVWdnY+wTflwn/hlvG9J/wQyOoPGE8O7vX07YcPj/BDJ/4vgX1f6nwhis4ZWd7HMh0h7VcCxRNRdL1ZXS4e2/WuzZ/rxkzUDcejiDm2O8rZKvly61nEgX1VecidYPLtdZtMdo+OFCwfNIJ7A/9RVeTxfzBdODG+2qzrRCFrkGFFCJq8W1O6lWHd0SSlV0Cmgp0AL1TK9ai1MDM0vqvyjZciTE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NY4HH5qZtkOsZErENMrROpid8h3aPWicXbqyrv+Ckg=;
 b=EdQDPXd5Whif0P1nv7WiO29ECtB9tm4AQi+6x0uR1tDLYLwwnel+DR/0Y0l6z05jSOoasJ+0rmos8iao7i4hRh1RvZBnxoj6LeW0GzVFs34DgQxHbppnpaYPJVaV5Mp5zs5ViIU5cmD3CV5XKTzhGpuMPNO6r98w4nB9MDSgvlvGqmaONkQNTVYivItlHKNOIL1i9m7eeBZTr+hGYp2UA4qBTOVylMayX6p/YDMP3uUulQi9C98uEvFHBfFb3X7MGqum4oiEOEhhaLiVEroEl1KSy5Ey9Lugz6y9iWXwkO2e1jdl5zRK1NZrzK8lEpgoD65TbKwDvdHTOrbOJVxgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NY4HH5qZtkOsZErENMrROpid8h3aPWicXbqyrv+Ckg=;
 b=pSgHHC6hqbwSDzVZGlo794adoHV22phGBj22c0CaaBoBWeGgJvsRpv7jHQrOt5jLQRDSumqLhG5XEN4hlX8TWt7UKBAXSqBIZYLquSvFAjGtp9Il9Jj0vYon/00geOTiQGPlmAVBJHY6m+VxVE1GwWzqPJCApUqgzHMTLggXZZ//99tjJdOIu5pihMsX+xhkSJxdKALsADmwpQWQ3oTfcPtTPg+SHh0w0OnA4XF29xCPj8kyZah9J/LA76jWmU9z6JoGDrGPYkom5k6KjMJ9+YW9DpnqIS4GFyvcFq7hrTPKr2+ks+WfG2OI5QqEDlCsUqXC9avQhTxkPuYF6pNXrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 17:52:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 17:52:26 +0000
Date:   Thu, 3 Aug 2023 14:52:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com
Subject: Re: [PATCH v5 4/6] iommu/arm-smmu-v3: Implement set_dev_pasid
Message-ID: <ZMvpWoslIZNiLNQp@nvidia.com>
References: <20230803101351.1561031-1-mshavit@google.com>
 <20230803181225.v5.4.I4ba46c0f7d599f43094d6ba1113c0b4fe49bd908@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803181225.v5.4.I4ba46c0f7d599f43094d6ba1113c0b4fe49bd908@changeid>
X-ClientProxiedBy: BLAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:32b::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: e51d1fb9-483b-4572-1f8e-08db944a6641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HKuFXy6YGJCZSGJ572DvWeWnoKfnDnj/RoR7OS4M5Cz+oD9dTkcK96B/MARq4tqBS7AfY2bbK9Zs1DXFzYV+eeC7D2VmVTXzDCdRVPAfbxdBZOjoRkVzni3AgC9SC4nI1qSvlPwRj/4t8g9Kf0Cni7WHarWOQHRas/Z4dfud6/cO+YxlbFXjMCWbS/EbcDZmMYWqgJkM26ijME3yY5Wnuqk1krli6dqgGdXv+SDqX+cigS7Rp5mq1B+dI2Nbq1jh+ZiwYRp1qtfdN4AmRBqnEj/fc7/lCdRKEzKw4DhhTa26CXVcm8oQKZTcysXQ9bubpNR0+qhRHDyHIaY71CJdqvUKyjGo9iBnYPuYFLVQr6Zqh+vi0Vr3hbnrrwnKUXHIcKAOGLr9N4Cj9M+uxbWM8NFc1v3m2SlXUZCii/CM6538IW5e2j/KA+sUuey40TB3QOXYWURWQ7ATxDzkFr8tumiM01AF9vfNEk44W/sapvp76PHV+ztS0+yrZeYOY1uJXltCcjDd9gWsJ0irKDruB/3KWosYYOp3jQRFW7rSqMxWwTVyFPg5qStzV3mZZEKJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(2616005)(107886003)(83380400001)(6506007)(26005)(186003)(41300700001)(8936002)(2906002)(4326008)(66946007)(5660300002)(6916009)(316002)(66476007)(66556008)(8676002)(6486002)(6512007)(478600001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EaEUzlh5SKZpqRaebMmavCPHQMWoRMvQ79j0XPM38aS4NT8UhBDaT382c1d?=
 =?us-ascii?Q?Ebf+I2KE/qi365thd+DygWs/8aiH/QLP7vagYiuMQh2V0wLwa2uuHpkQlIWa?=
 =?us-ascii?Q?3/7m1oDH3tRMKJaeVz9+PEF1EYujppDPKQkNRUvPefcFj4U4BdlOYRA+dEYR?=
 =?us-ascii?Q?qQ1jiwgpFYieBHzJuy1aWi8MDC8Xctu9yLPkk/Ha6T4IqsnzdqiHGYRqf1Xi?=
 =?us-ascii?Q?2eSax6bndvVay9bhYbw1LDbYvZ4SP1aBY9lBIeKmMQraOJdYWdfZELsmGZBT?=
 =?us-ascii?Q?r4kxqJlxcLZGyzqRm+TErHJDA8T1vmzshLU/NtzdJARSjLPqntYz/C9GEOHv?=
 =?us-ascii?Q?KUVL6KK7wYViQVybWAKo+xe5sfIOsyVUxwwUWjIt/zs/n18Af9URopeuc0kQ?=
 =?us-ascii?Q?gIfTseyokUaevxHcZJd43bPI+u1RPlPSJSiGe+bPW9SWxjhgDFidlE6kRkhM?=
 =?us-ascii?Q?poPt3iEXzEOPDtXhaqI9pgUJJlTa+bs+XmnD+Rj5Qrl09B6AydrIoWjo9c6X?=
 =?us-ascii?Q?VijeRliuWLMGpU4KFExamHON+JQnbBHVHFy7A18TdtKfrPuxNMl3aCUWu6TI?=
 =?us-ascii?Q?jo1r5bUq+QD0N9j5pZeN9eFJmRLy+nfQXqvCyROSW40t5OWAtchn5BkpZi2p?=
 =?us-ascii?Q?9kgNtHM6ybO358BLOjQ9iwaI9Hp/+823l8sir28ZRZ/OcLzZnYSMrZ9OHn8M?=
 =?us-ascii?Q?UhG1FBjNB5V3OnalVUR9efrPE7PktXSAsH8TcyRZzx7egVibUMglhrenS0VD?=
 =?us-ascii?Q?An4YFAkvyM2BSy1bZpMEVhBVzbL36qJud87KovWl5iCWVVEQsuwM4NCgEx3J?=
 =?us-ascii?Q?7RRxYAkAExyCaioLGGdSS8WvQlHbY7AeUVOUf5aO1sonQS7EVBq8HU2mugCJ?=
 =?us-ascii?Q?VHnIwLAAd/EHjCqjefDBiQqpRuVtbir16caCWIayme4PpW2pzWVKemtpGYk6?=
 =?us-ascii?Q?+nVsz7NgcJuqVEjELylAExF/7XrF1UsJXUVMXR4n/Iab40j5Wo+Oy6zs1k/0?=
 =?us-ascii?Q?Wn9qqjAeGov/hduoDQd/vRXRs5sR9UO0jkd9ydRqDj/HqaAY4E7pxvVQO9+t?=
 =?us-ascii?Q?b1RHiwkwoyJan+woZwgAkbah/k1RQh2NRmMeWCK+tBDzIJra5h6DrdKADO8y?=
 =?us-ascii?Q?Rt2imTwo3SfA+ChSIbX9Lf3681dM2UXC7WP6wEe67yOoVALJnglcpoTSRmR0?=
 =?us-ascii?Q?hXLGKRjs4GlWTv9GTCZmMp2tZroI+I48odts06K+KidchABHk4zSp3HmO2bA?=
 =?us-ascii?Q?DXsnQcW42rVGrcs0ba/JxQNtMqThHNte4zXb3hTz27iM+MMjb6/tPSMNIxrS?=
 =?us-ascii?Q?Z0REl7L4M/zBcoLjyzV4yv+REKnzqw6LzbC5pS+FphW9ZsXE06nRgoBEbU8J?=
 =?us-ascii?Q?0/fFH8ngfbS53xy3hs+7nOq2LkH40ZeIHbbCfMs6lhQ2vgFVJaUowCdWFjWF?=
 =?us-ascii?Q?BsrNOIGH+PBIlLsn2a4rpgDgY9K5BmXe1BulA7OmLbeVBirS5XC6C2gLw/xf?=
 =?us-ascii?Q?VMiVlKDcYSdDqKrVaF8XnkHZnfyVrskJoBquq1R7O9naOtPc7NZ0ZvbTVTkc?=
 =?us-ascii?Q?f6tCisvm3cyGFeHOv9poWHpn6CnCJ4FH2a4v+VEC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51d1fb9-483b-4572-1f8e-08db944a6641
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 17:52:26.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3o8nYLDrv+vPuDvqkkaVUEL6EUbKtAqjCyovNXBsRT+02/leJhg2Pg2d6X63AHEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 06:12:24PM +0800, Michael Shavit wrote:

> @@ -2448,21 +2476,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  		return -EBUSY;
>  	}
>  
> -	arm_smmu_detach_dev(master);
> -
> -	mutex_lock(&smmu_domain->init_mutex);
> -
> -	if (!smmu_domain->smmu) {
> -		smmu_domain->smmu = smmu;
> -		ret = arm_smmu_domain_finalise(domain, master);
> -		if (ret)
> -			smmu_domain->smmu = NULL;
> -	} else if (smmu_domain->smmu != smmu)
> -		ret = -EINVAL;
> +	/*
> +	 * Attaching a bypass or stage 2 domain would break any domains attached
> +	 * with pasid. Attaching an S1 domain should be feasible but requires
> +	 * more complicated logic to handle.
> +	 */
> +	if (arm_smmu_master_has_pasid_domains(master)) {
> +		dev_err(dev, "cannot attach - domain attached with pasid\n");
> +		return -EBUSY;
> +	}

Basically don't you just call set_dev_pased(pasid = 0) and it will do
that logic?

> +static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t pasid)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_attached_domain *attached_domain;
> +	struct arm_smmu_master *master;
> +
> +	if (!fwspec)
> +		return -ENOENT;

fwspec drivers always have fwspecs, they don't need to check this.

> +
> +	master = dev_iommu_priv_get(dev);
> +	smmu = master->smmu;
> +
> +	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain, master);
> +	if (ret)
> +		return ret;
> +
> +	if (pasid == 0) {
> +		dev_err(dev, "pasid 0 is reserved for the device's primary domain\n");
> +		return -ENODEV;
> +	}
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1) {
> +		dev_err(dev, "set_dev_pasid only supports stage 1 domains\n");

don't print messages, iommufd can trigger these paths from userspace.

> @@ -2738,6 +2828,15 @@ static void arm_smmu_release_device(struct device *dev)
>  
>  	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
>  		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> +	if (WARN_ON(master->nr_attached_pasid_domains != 0)) {
> +		/*
> +		 * TODO: Do we need to handle this case?
> +		 * This requires a mechanism to obtain all the pasid domains
> +		 * that this master is attached to so that we can clean up the
> +		 * domain's attached_domain list.
> +		 */
> +	}

Unnecessary, the core code should handle this, add a patch that does this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5b5cf74edc7e53..57cac1ffba1cfe 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -438,9 +438,16 @@ static void iommu_deinit_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *{pasid_domain;
+	unsigned long pasid;
 
 	lockdep_assert_held(&group->mutex);
 
+	xa_for_each(&group->pasid_array, pasid, pasid_domain) {
+		__iommu_remove_group_pasid(pasid);
+		xa_erase(&group->pasid_array, pasid);
+	}
+
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
 	/*


> @@ -2874,12 +2973,36 @@ static int arm_smmu_def_domain_type(struct device *dev)
>  static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  {
>  	struct iommu_domain *domain;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_domain *smmu_domain;
> +	struct arm_smmu_attached_domain *attached_domain;
> +	unsigned long flags;
>  
> -	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
> +	if (!master || pasid == 0)
> +		return;
> +
> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>  	if (WARN_ON(IS_ERR(domain)) || !domain)
>  		return;

I feel like we have made a mistake here to not pass in the current
domain from the core code, it already knows what the domain was..

> +	if (domain->type == IOMMU_DOMAIN_SVA)
> +		return arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);

Yuk.

Jason
