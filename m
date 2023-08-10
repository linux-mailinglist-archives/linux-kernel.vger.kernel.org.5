Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3BC777C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjHJPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjHJPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:39:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8F2703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eezg06eKcwzcliuVM2mjsFhE0H10Ly9QylBqEF/U/rUW0Kb0UBS24784FIrcav7REPKwWSX3J4hNpQM/LmJzJllogPW2AjJAs05R86Rdhv8yEdYXyNy7D9DCM2DX2rsXkzBDYtN+NFZhyo8OSUIhMSaMBJYRzmz4/oK/82Vgpl7PnpfE5pImxN6ZftcJNW2vU3vlaRZQ6JApMFYgsElmt2jMwHUjJn5pN+oBKpng12mMG+o3oYppLH69wqFOpt9S5P7wiLBX4dXTGGloYpZ3WkNTlo+jMzoABGwMDPch5ehkwlu7qyWumcyo/1RLxu2/PgdGo0/ys7PvxfS3wXzwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNTE6cuWtl6tk9i1gsrucSY/df6iT7GozWYbNv7GATw=;
 b=VRJogDB1pB02losk+VoR3RviSu16cw/tn3lB2fsseS1aJZA9+JERemvvBttqAmwaYVziQya7ah5uviWTXmUdSLiyPz+/Eb054oSd/S1SHEmcorCKpOJXpW8LNQMZXEaaxaeZB10Z+s2IPyKp5nKz7tHUhvigXm2fkUDRa1dbcbbFlQeHnB7A0cUkYJcKHnpcYQ2thOzs5ioLAb3RkfNIDxUlvzcy9HVmTs56Ehcr9cQ2llScIisgsvcU84UOwS8hqNQbHOF1SPcFGF0wY4dftyR5u8/YXl1k8Jk0Nk69+aG8q2Ql60ITBRYgKeBDTwCpuWemHXBwMrKYG7BHUdmqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNTE6cuWtl6tk9i1gsrucSY/df6iT7GozWYbNv7GATw=;
 b=PF7ygrg0/kFyKu8iGvvJdcy5QHj9BcOihZIb9xtbch6qmy+jIEUI0D8PI4ZE7FvDlmQzRCcIS7HptDDS2h8RGabWc1Zpuon2ggaFCxVgVCkQpvB3TfFmEeuwP83LTvV3VOIqDwr9U8ciySQjHuFqb4vLSkruYIy3zpq2XaC66uP0v0WNeobHtlQ5QJ5qMOhg00Xa1WzPF0tl/+adswnlbajKDe7Xy/NsGMr5K2DT7OMH5O6oZ95dj4VOpB79jDu+V9EEiA48ozTnEHexfAurF4ZKdWxt7w6xJaMX6TenX/myYFSmOtqx0CrtYq1H6bqYFpOcBfsJ+/0OSC8MhtBxIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:39:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:39:39 +0000
Date:   Thu, 10 Aug 2023 12:39:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZNUEuIlPmrckwMyn@nvidia.com>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810144051.GD5795@willie-the-truck>
X-ClientProxiedBy: BYAPR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:a03:60::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bd3b58-7b97-4be5-4550-08db99b801df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8Saj8371eoUCLU+wAtM59jKtmBY3qvk97vLQEkuzY20/ZY/kTudyhLNnJH12ZT7maHM5fC+yP7mOYFt1SI0uOMUO6s45k9I+DookSDjFALZ360BySXM6TSwOm4rvhTgrQOufAMuQEUbiO/el00XPIt5j7joghboCudqJH6aY65d0K6x7ZH6OY0gn+dw0Uwey4Qm51qts7ii/ckxz0ohwFO4R3jKX7vqw+bMMdmNDwP8lvlAE0SIC13WJrLMkJq/isTwTZ6mpIXZL9nlIfKQws3CIJ+Eaz4frRrvdlz2Ig1UesopzCgLnFTUxHNS2gvkxqP989f2BFZlZ8Cc5/qde6bCUvfhK8EA+K0U97SW3ZEIrmRiQcxZdzAENKoK0t5+kZlkMBNfvsbXzKETbMJ70r5lBxtfpip/AFIZmFeTAW5ntm2EQIaiFYemrMh6g0dKImuPqcGXA5xXqo8a2+3W8bmPB0tDV/Vi0bERsyjUWNpzyZFpxPwpCSASUTL2yzehChWFrOYWORniwaHFJB2bCuWOjdpyy1xeemG97z8+/pDJRYT1VvOT2/+LG9lPtPAa5BhvaYmCmM5Jq+Z2V5c/w05ElnzUydkWs49Kvj14ckM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(6916009)(66556008)(66476007)(6486002)(6506007)(26005)(53546011)(966005)(6512007)(4326008)(2906002)(41300700001)(316002)(8676002)(5660300002)(38100700002)(8936002)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnB2WGJJUEc2a29XbTBNMTlPMG5uMEY4bHRxTjRWdStlOTFwTU5ZUjMwbVJH?=
 =?utf-8?B?UkR5YUphS1VKeHRYTFFscnlSWVlaVWNWVlY3cEFrV1lLUFRBLzhydlpvSjdr?=
 =?utf-8?B?bmpZL1JkR3AybE4yYXRGOHMreXliakQyemVlVHhXb1VPSkJoSk1LVHZCSG5H?=
 =?utf-8?B?T2RadjNpZkZxL24rWmV0ZmsrWnQ5bUo4dk5Hd2NnZGxnR3RwMVJrelVwaWd1?=
 =?utf-8?B?Ri9rYWtoZ1BxRC9DRmRDTG8zQ21KcGk5Nm9Pcy93WVdZY2FMQ2lTTmdKVEVs?=
 =?utf-8?B?VXJpdHNCOVp4SXNDV0hpODZ5NHBOMHJuNmprektKNzZVelVrWThMVjUxZ0Vr?=
 =?utf-8?B?YlcyaXAvVmdteHJ1MDJJVW1DZGJqT1R0ejB0dlhrMjNxa2RnS2s5TXQyT2Jp?=
 =?utf-8?B?TmE5YmRHMllhZWZRaHgrYVFEQ3JsRklrZ3dzY1o4b3NnYTF5OXVEa1hUSGls?=
 =?utf-8?B?V0YrMFJzcFdZR25xOG5RdnFwQ01mSVNzcXEzWjZDbU5CUW82VGRFK2RzTGFI?=
 =?utf-8?B?Qkhua010amdHRk1vUFRoUUNsaEYzQkdXbFFMaFhIbmFzWXdMaEJycWpCOEZL?=
 =?utf-8?B?RS8vMVY2UHdBNDVUTEh1MXlHVWRhOHk2U1JkWXhEaUVNN1lsSXZhT3VxTUpo?=
 =?utf-8?B?MDlUd25QRkhFRmxKc3dnd1BTSGkzUUlLdUhoMGpmZVBZR1dlZW9sUllNV3By?=
 =?utf-8?B?SlRxMEFzUnFRYlhXOG5IcHFReUtxUUFUVkUvdEFxaW83dGZmLzZxQUhBNFdo?=
 =?utf-8?B?Yzd3MEJEc3lBWTQ2U2p2dHZOMGE3V1JUSm9VM1I1MFVlRDcrTFZwSHZ4YlJz?=
 =?utf-8?B?T3hYWjM2elpUeWRQc2l0dmtaaUxzelNPM1NkMTBydTRZeDVBWDFyc21aVXJa?=
 =?utf-8?B?VEFNQVRnNjIrTTVYdEp0L1FrdFVoRGllbldTd2RLL0JuNE9LbzdMNjBLOVor?=
 =?utf-8?B?OGsrVHE0Vk10RFV0RmxoT3RYdjRwaThUajBBenhZNmtRV2Y4L1hyRHlKcFRz?=
 =?utf-8?B?Qm4yZmFkYWsvK3MzaUNRZHp5ZEZnaitVcEJzbnUwTU8yMG5tOEh3cmF4WFJI?=
 =?utf-8?B?Qzl6alZMVEk1dXA5WTVtVGI2U2VLWWtrQUgrdStMQzJmZVhzN3R5Z0tpenIz?=
 =?utf-8?B?MDl4akZ6dUdZUHE4UWc4cnNyQ3FGTEROZ0pBZEQ4cnFoLzBwQnBnV2hEa1VB?=
 =?utf-8?B?T2VQdTN2TGVWbEtuc2FLSG0vU0VrN1IxdDdvQnJPaWVPb3VORHlxL1NqbnM3?=
 =?utf-8?B?enlxQ2puTW5xWDBlY1J1UmtWOVlRQ2NrM21jVEtmbS9adUtvVVhLZEx1a3F0?=
 =?utf-8?B?QndHVjJFMCt5dmk0dkV4NExmUTVIVnA5QjI0eVVLemR2OWdWQ1NaUHNZQkpH?=
 =?utf-8?B?bUQyd1JNdllSckRCaTVmSm11NURQSVlkOXV1bkgrd3pRc1dFbWg1a2xLZFYx?=
 =?utf-8?B?WXdJNzFaQnU0MS9sVUtvVFVpampOREtKa0VjaWVDc1UyejZVVHFHTFpRaUdu?=
 =?utf-8?B?eWhVRFVnNm42TkpOU25LWkpnVTRyRFhjT2I5UXlWZlJ1WXgyWnhEZmVCZEdV?=
 =?utf-8?B?UDZPWjFCVW5MVzlWV1RNSDhqYVM0eUdZSk1GOHVScnNFTjc4dHIzazF0QUUx?=
 =?utf-8?B?b2NoM2I1cllwc2JCcTdzMUMyeGxzUnowRWl4YjJKR09ZK1hjanl4RXRobWk0?=
 =?utf-8?B?U3V5b1l4NjFBYXhhUkJKcDRjOHJZRkxuOEdSdENoM0J2ZVQveXhlQ1RPcDRl?=
 =?utf-8?B?Mnd4c1QwSWpIM0lYK0VMYlR0cERWSHBuSy9xOFJseE40V3k1WFd2OW1xQ1RZ?=
 =?utf-8?B?MG04aWRFeFVBMmtFNGNwbjhvYUNoY1ZENnpEYWRRKzVPY2FYQ1dvek95cGY3?=
 =?utf-8?B?b2pkV3dhR0QrdGIxK1FoZGxKaXpwVk9YTXNMc3lEUE1KTEh2K1liamFKRldz?=
 =?utf-8?B?VkRXVUFTNkxhWGU5c0pMOVhMRGJabFJlVllFcnNLdGZzTWo2WjEraGMxNkFY?=
 =?utf-8?B?emt0MnVwSG43QU9GL0ZxWXJVa2tJMEJUSmF1ZVZjY2NpcnRhMzg5clRQMzdH?=
 =?utf-8?B?Tm52OEh0SHRjZjdBbmZUZUk2T0pvSzJKTTJVYnJYcnZDRC9YNlM5YkJCRlh3?=
 =?utf-8?Q?/qJyp6TpDIQpJcsU1q7dayGOe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bd3b58-7b97-4be5-4550-08db99b801df
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:39:38.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDGPIRnOJVEHBeySenCqzLKsrQkoeGRGdCbkPm9bgfl7WScEevIj4eYUZRfNYIgB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 03:40:52PM +0100, Will Deacon wrote:
> On Thu, Aug 10, 2023 at 05:15:50PM +0800, Michael Shavit wrote:
> > On Wed, Aug 9, 2023 at 9:50 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > > -     ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> > > > -     if (ret)
> > > > +     ret = arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, cd);
> > > > +     if (ret) {
> > > > +             arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
> > >
> > > Why is it safe to drop the lock between these two calls?
> > 
> > Hmmm this is a tricky question.
> > Tracing through the SVA flow, it seems like there's a scenario where
> > multiple masters (with the same upstream SMMU device) can be attached
> > to the same primary/non-sva domain, in which case calling
> > iommu_attach_device_pasid on one device will write the CD entry for
> > both masters. This is still the case even with this patch series, and
> > changing this behavior will be the subject of a separate follow-up.
> > This is weird, especially since the second master need not even have
> > the sva_enabled bit set. This also means that the list of attached
> > masters can indeed change between these two calls if that second
> > master (not the one used on the iommu_attach_device_pasid call leading
> > to this code) is detached/attached at the same time. It's hard for me
> > to reason about whether this is safe or not, since this is already
> > weird behavior...
> 
> I really think the writing of the context descriptors should look atomic;
> dropping the lock half way through a failed update and then coming back
> to NULL them out definitely isn't correct. So I think you've probably pushed
> the locking too far down the stack.

Urk, the issue is that progressive refactorings have left this kind of
wrong. 

Basically we always have a singular master we are supposed to be
installing the SVA domain into a PASID for, we just need to load the
CD table entry into that master's existing CD table.

Actually, I don't think this even works as nothing on the PASID path
adds to the list that arm_smmu_write_ctx_desc_devices() iterates over ??

Then the remaining two calls:

arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
        arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
	
	This is OK only if the sketchy assumption that the CD
	we extracted for a conflicting ASID is not asigned to a PASID.

static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
        arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);

	This doesn't work because we didn't add the master to the list
	during __arm_smmu_sva_bind and this path is expressly working
	on the PASID binds, not the RID binds.

This is all far too complicated. We really need to get this series:

https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/

And rip out all this crazy code in the drivers trying to de-duplicate
the SVA domains. The core code will do it, the driver can assume it
has exactly one SVA domain per mm and do sane and simple things. :(

Maybe for now we just accept that quiet_cd doesn't work, it is a minor
issue and your next series fixes it, right?

Anyhow, something like this will fix what Will pointed to, probably as
an additional prep patch:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e3992a0c163779..8e751ba91e810a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -297,12 +297,6 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, cd);
-	if (ret) {
-		arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
-		goto err_put_notifier;
-	}
-
 	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
 	return smmu_mn;
 
@@ -325,8 +319,6 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 
 	list_del(&smmu_mn->list);
 
-	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
-
 	/*
 	 * If we went through clear(), we've already invalidated, and no
 	 * new TLB entry can have been formed.
@@ -342,7 +334,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 }
 
 static struct iommu_sva *
-__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
+__arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, ioasid_t ssid)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -375,9 +367,15 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 		goto err_free_bond;
 	}
 
+	ret = arm_smmu_write_ctx_desc(master, ssid, bond->smmu_mn->cd);
+	if (ret)
+		goto err_put_notifier;
+
 	list_add(&bond->list, &master->bonds);
 	return &bond->sva;
 
+err_put_notifier:
+	arm_smmu_mmu_notifier_put(bond->smmu_mn);
 err_free_bond:
 	kfree(bond);
 	return ERR_PTR(ret);
@@ -548,6 +546,7 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 
 	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
 		list_del(&bond->list);
+		arm_smmu_write_ctx_desc(master, id, NULL);
 		arm_smmu_mmu_notifier_put(bond->smmu_mn);
 		kfree(bond);
 	}
@@ -562,7 +561,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	struct mm_struct *mm = domain->mm;
 
 	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
+	handle = __arm_smmu_sva_bind(dev, mm, id);
 	if (IS_ERR(handle))
 		ret = PTR_ERR(handle);
 	mutex_unlock(&sva_lock);
