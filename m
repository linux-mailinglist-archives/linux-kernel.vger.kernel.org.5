Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2652F7AE2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjIZAMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIZAMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:12:35 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6B116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etRT5TW0CPRVMn4biavPXXZi+/cciJkeAqI6Y7G3TlQhJ64j6WiKVHhCEKzPsAV1JDYnb2fbin6fHqNeudNDtXu9YNarrJ0qDAW83l81f6CX+dLSDXysc+RrjU2Q9mJ9RhRxxGuQeGlPiBvWZskApqnah1YDkA31WuC+KFbZCRnApGhl6Sq/37ccqr/cw5qzLfe63ua3uMuXY7tkAb1RgYPfddoE1io+zconvZ8kwi1WMhgsWU3o0MYOb2Lcihx3Fn45F3naXR0/cXKTedIoaWYOmp8wiBLz8FDGOCx28pTktnU9Q0Y9Ln8LClJRXUqlbCFCqxhXDahkn9Qq3McNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGIBFUwzXQAWnu1NMdjoCVwJtGI9LTFKutdqDmL6mD8=;
 b=kBxUCZI7MfOJ8IGX3PTgMQEca6nVhSPtZSVmuL4D8fG1vsDipDHvuwW49YHT2ddg7ZBUTvJf91Kv/NDqbcibSbeDkculSsY8AbIEU4itin28FidnDRml+ENg9rx0PbA5OpikF/7znhazmXxUJx8jZSTr5FSsm2WtyTe1l4zXyGmg4NP/XXb5B4TFb4tjNzgHgHiPQwzRLUkzY+INYfjd2G3Rk2OBUC6MGBf5DVkS5cq/PD+Y5cEDjXvcbsYsjdr4npBHbvQNqSWM/Kt2jCY/y5Ih9FUiu+oa8x6mFteIX20I6SzpIRXWHbbZzInN7QpZ/wqPq0q8lkNJ7y7QVn9bYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGIBFUwzXQAWnu1NMdjoCVwJtGI9LTFKutdqDmL6mD8=;
 b=gbFMWwHjHLa+1iswL+MkY1aDVLG4R7UrkMkbK5f3kk3pSxw+bvy5eHSqYbGMx+Qu8iMGEUNzB5WZipKDXpKgHtvcJF7XtjhE6we1D9sQydKVX+DRTab9sNWHQdsKcesLMQm8XSseIPZwSA6yyz03fVKDQpu4uBB4s3z5Q9F0ovL28JezTHMygOyt+q2lqhPZDE5gWkypE+v1HaiFT1RRM08gvu/V/kErpqprkML0gmMRwoaD+mugeioTr59ocQqlz1muVQP+PeoyOH+IPRKtQYrE4PixRsmvFSh3xduHq5ytisjQcJ3VEUy9YFn1n7wvEW8Mi5xM5QZplfyXWtUJ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 00:12:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 00:12:22 +0000
Date:   Mon, 25 Sep 2023 21:12:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        jean-philippe@linaro.org, mshavit@google.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Refactor
 arm_smmu_write_strtab_ent()
Message-ID: <20230926001220.GL13733@nvidia.com>
References: <cover.1695242337.git.nicolinc@nvidia.com>
 <6e1fdea8ab43ea28e7e3c79eb6605dea71548c53.1695242337.git.nicolinc@nvidia.com>
 <20230925183523.GJ13733@nvidia.com>
 <ZRHnfq6mzDz5zTLC@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRHnfq6mzDz5zTLC@Asurada-Nvidia>
X-ClientProxiedBy: YQZPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c707d24-730e-49eb-77b6-08dbbe25418b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ycXLCj8nZWzr/dtvb2OsClco/dwUfmdmOer+bkhQLLOBvtM04k5Mmo0BQNDWV2Nou5K/kmYqO/u021H9IClqNXqSXkACN1PijFigEyOPTlIGKig8SU6qpw9r4+rLvgyvsWBKG+wTYqowl0uAoE4Q7pVhCqc0Impupd0T4STJZkq1CWPQWvzmjFTW9Wx+Ik8B/aUkN+pLe592k+/QaCMMc7B9Bee6sf7YBZ9PYWXRm/9RZ1xIco8gcPWf/afMI2Lt1zi3YVlfQfBSWZ2YCUEUvh4ZXw7TaqW6uTXujL6AMduOmEuV/okUCIL7BHjisEfJEb1SbYKdDBN15OOoKYT8BcfXvMldPE7bwJ/NYd0FVEfpoEGKo4W1p5y+CZ+D/a+gQUxT9y63e0QU5tALRPXnQnZ7EE0mABkXebvPsUS0etPAPfmPdITvothr/BJS7FlnwBz8A18OJ3V+HndZdIF1DAC8rN3W9uGrq5f13fypbTg8QPIZjPPlojgazWevYWdk3/3MRyBKa+KietjYEEwKBlfOIUhX0qoUICS5EugsbxWa7VmMIeADxi0IhXCBwzB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(6506007)(26005)(6512007)(1076003)(86362001)(66946007)(66556008)(66476007)(6486002)(33656002)(478600001)(38100700002)(2616005)(83380400001)(2906002)(37006003)(36756003)(8936002)(8676002)(6862004)(4326008)(6636002)(316002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MyJJVae2S/K8jkIkZi5jy5wdxSJoyC5YzDP5dhehjOYHR1RO+9IbLnkxxDds?=
 =?us-ascii?Q?0O2Vnoo3v3ILlg9O3vV5bp2Y7oJetVnSaXLSueS7D09MFyLhbc76+awzMyem?=
 =?us-ascii?Q?ITWjwnmcGK8Vnx4o7DTULC3XoPuAwVEXbqCGMy/hXNnAKfN55qDAfhPT0BAz?=
 =?us-ascii?Q?RgIFWIkOs2fuGoY5QpNfXPT1kMMidfz5ta27IYzrVoU4U4FGdoECelbkgNwL?=
 =?us-ascii?Q?xrIwJaPb/Mm1geURsUB8C1vuhhwxHHSk+cTBg65DdZcX/0c+9NVfPWBeO2WL?=
 =?us-ascii?Q?3os9sjb9VEO2i39fk6HF1TWFiSUIUW4Gqacw0HpFxLWAc1sYqSMMNedK1VYv?=
 =?us-ascii?Q?jmWZPtj6I8DMBbJ76dslYcaIU4VV3LDz6IqrvMEZgfHUkTGXotHfB+JIWCQz?=
 =?us-ascii?Q?Fw2F6LL7fgvTO/mnLRkAgiEgYZ/7ozR0gpAFyLVUnBVQbBJ4q3TQhPiDF+0u?=
 =?us-ascii?Q?+kFYa5gJQM9XLqacYCil5eAqffD0GMroujtmHgR3+dsHEI6zF7qeakw0XuMC?=
 =?us-ascii?Q?hAXscwgN8PaXLntRkaXmBvlSKSkdGbC9xwffsddaw1ovqaYh30Yc46hmk4iz?=
 =?us-ascii?Q?J94jbzOdI+mXTssYlcLJLTuNjl8BOCEj0mDpm/T9JLpUm3UhH5+EhpDeeo64?=
 =?us-ascii?Q?P8RKvFXo2i0KqkPgqcL3GXfVr8QbQjFLd57nZaRGIxzBRK4U25USI8gptD/J?=
 =?us-ascii?Q?oVkgVgl02vZ++PPxggqSRn31Qmd1C6C9g3sJTTg5U+/cfIBZz45KVmDYiIBe?=
 =?us-ascii?Q?enQKKAF1Lzsf3r0Z3WCCAKuMBXqYuIjZeEFmsnkWYsjdc96tIoUsKtbv6noS?=
 =?us-ascii?Q?iYsnEgbCrJYITmeHl4pBhbQvKk2at9CCFXXiI0Kzmz7Unop0rj7K8kprShC6?=
 =?us-ascii?Q?P4Y4JG+P2tA3BSJuIfyBqK72sob9DNT5ldM7oVl2JXM2a6kANPS42iVYulR2?=
 =?us-ascii?Q?LvE1gBBPMxDhd/UW/+jMuXand5ozBsDgXKgFiOHvISL1sS6ATKQ73EAUgDJW?=
 =?us-ascii?Q?ifEzlgSMwhieBvLQOMWtzvmjP7G6913mYkM+6sACSjTbi8y5G38dXLwww+vH?=
 =?us-ascii?Q?DjKh4RqFqfsmV5qTLaUZudrCT4g6vXo++LLHXYX1C9URlaVc5M9aAxnDqh2d?=
 =?us-ascii?Q?070aEXMEGqWJDM3VpHW9nQsldv7tGaXNKeBXdsl5W/y3bxwUfm/R34sGdwBh?=
 =?us-ascii?Q?nM76mY/7imH02fLK/qSleQ6yAMkWEzlSm7boixIxvQZVg42AD/rmmblJIbzQ?=
 =?us-ascii?Q?lxdVVvgtcRlmVaq95VRi/aLN/OgorXUxQAqxxuQhpO1bUcuAJWttetpQjD5g?=
 =?us-ascii?Q?a5bm9r4YlIuQv3wxjVJodkbfON+YcbzLJc3QhBD+fYAPoeM/lxQ9+FwJNA+6?=
 =?us-ascii?Q?lclTmYnCimqcuTv9aJQPXVr5jaC7NHLXDeKeymAyqy6nMEbQV6vnGOntV37k?=
 =?us-ascii?Q?ZH55zyzhwLbIL27fCVexDP5AfI7NT0utKrpAszFgu8ZnhLX7byyLpkdvtSTU?=
 =?us-ascii?Q?QH44QNPbvOYDQucmvI32oy0QAUm49s+6rp1iKrZ8vYTAU8tbVAVpDO9NLzEd?=
 =?us-ascii?Q?3/SPhz2TCazRh09nCol8LaqMPrgI4BP/gHa2ZSsF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c707d24-730e-49eb-77b6-08dbbe25418b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 00:12:22.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHPbofnJ9fYAf6670Q94qLn2QbusCtcowld3/MpyPvnd+uwvvL5r6KqBGBhKKGYB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:03:10PM -0700, Nicolin Chen wrote:
> On Mon, Sep 25, 2023 at 03:35:23PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 20, 2023 at 01:52:04PM -0700, Nicolin Chen wrote:
> > >  
> > > +static void arm_smmu_ste_stage2_translate(struct arm_smmu_master *master,
> > > +					  u64 *ste)
> > > +{
> > > +	struct arm_smmu_domain *smmu_domain = master->domain;
> > > +	struct arm_smmu_device *smmu = master->smmu;
> > > +	struct arm_smmu_s2_cfg *s2_cfg;
> > > +
> > > +	switch (smmu_domain->stage) {
> > > +	case ARM_SMMU_DOMAIN_NESTED:
> > > +	case ARM_SMMU_DOMAIN_S2:
> > > +		s2_cfg = &smmu_domain->s2_cfg;
> > > +		break;
> > > +	default:
> > > +		WARN_ON(1);
> > > +		return;
> > > +	}
> > > +
> > > +	ste[0] |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
> > > +
> > > +	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
> > > +		ste[1] |= STRTAB_STE_1_S1STALLD;
> > > +
> > > +	if (master->ats_enabled)
> > > +		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
> > 
> > These master bits probably belong in their own function 'setup ste for master'
> > 
> > The s1 and s2 cases are duplicating these things.
> 
> OK. I thought that writing these helpers in form of STE.Config
> field configurations could be more straightforward despite some
> duplications.

Ah, well, if you take that approach then maybe (and the names too) but
I'm not sure that is the best way..

The approach I had in mind was to go down a path depending on the
configuration of the master. eg if you have a type of domain or a cd
or whatever. That would imply a config, but not necessarily be
organized by config..

> > static void arm_smmu_clear_strtab_ent(struct arm_smmu_master *master,
> > 				      __le64 *dst)
> > {
> > 	u64 ste[4] = {};
> > 
> > 	ste[0] = STRTAB_STE_0_V;
> > 	if (disable_bypass)
> > 		arm_smmu_ste_abort(ste);
> > 	else
> > 		arm_smmu_ste_bypass(ste);
> > 	arm_smmu_store_ste(master, dst, &ste);
> > }
> > 
> > And use clear_strtab_ent from detach ??
> 
> We still need bypass() in arm_smmu_write_strtab_ent(). But this
> removes the abort() call and its confusing if-condition, I see.

Well, it sort of starts to set things up to not be domain sensitive in
this path.. Maybe it is a diversion on the path to just removing that
part of attach.
 
> > (but then I wonder why not set V=0 instead of STE.Config = abort?)
> 
> It seems that the difference is whether there would be or not a
> C_BAD_STE event, i.e. "STE.Config = abort" is a silent way for
> a disabled/disconnected device.

Makes sense

> > > +	for (i = 1; i < 4; i++) {
> > > +		if (dst[i] == cpu_to_le64(ste[i]))
> > > +			continue;
> > > +		dst[i] = cpu_to_le64(ste[i]);
> > > +		ste_sync_all = true;
> > > +	}
> > 
> > This isn't going to work if the transition is from a fully valid STE
> > to an invalid one, it will corrupt the still in-use bytes.
> 
> The driver currently doesn't have a case of unsetting STE_0_V?

Sorry, I didn't mean invalid, I ment different but valid.

 > > Though current code does this:
> > 
> > 		dst[0] = cpu_to_le64(val);
> > 		dst[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
> > 						STRTAB_STE_1_SHCFG_INCOMING));
> > 		dst[2] = 0; /* Nuke the VMID */
> > 
> > Which I don't really understand either? Why is it OK to wipe the VMID
> > out of order with the STE.Config change?
> > 
> > Be sure to read the part of the SMMU spec talking about how to update
> > these things, 3.21.3.1 Configuration structure update procedure and
> > nearby.
> > 
> > Regardless there are clearly two orders in the existing code
> > 
> > Write 0,1,2,flush (translation -> bypass/fault)
> > 
> > Write 3,2,1,flush,0,flush (bypass/fault -> translation)
> > 
> > You still have to preserve both behaviors.
> > 
> > (interestingly neither seem to follow the guidance of the ARM manual,
> > so huh)
> 
> Again, it is probably because the driver never reverts the V
> bit back to 0? While chapter 3.21.3.1 is about V=0 <=> V=1.

No, the driver is using the config in a similar way to V. From what I
can tell it is making a bunch of assumptions that allow this to be OK,
but you have to follow the ordering it already has..


> > The bigger question is does this have to be more generic to handle
> > S1DSS which is it's original design goal?
> 
> It feels an overkill. Maybe "Refactor arm_smmu_write_strtab_ent()"
> is just a too big topic for my goal...

Maybe, it depends if it is necessary
 
> Overall, this version doesn't really dramatically change any STE
> configuration flow compared to what the current driver does, but
> only adds the S1DSS bypass setting. I'd prefer keeping this in a
> smaller scope..

Well, no, this stuff does seem to change the allowed state transitions
that this routine will encounter, or at the very least it sets the
stage for new state transitions that it cannot handle (eg under
iommufd control w/PASID we have problems)

However.. if you imagine staying within the existing kernel driver
behavior maybe just setting S1DSS does work out. It feels very
fragile, it depends on alot of other stuff also being just so.

So, at least for this series you might get buy without, but do check
all the different combinations of attachment's that are possible and
see that the STE doesn't become incorrect.

If it is OK then this patch can be its own series, it needs doing
anyhow.

Jason
