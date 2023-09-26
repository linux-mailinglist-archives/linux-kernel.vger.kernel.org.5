Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26357AE37B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjIZBxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjIZBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:52:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A725911F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGQ42IZlbW4lf0YIIQNAs5wiUNH5xzPfUglj8eSjVCAEBYlmXEOETr1RBx5euHFq8wODULEZHaVNQ2aA7QApLjz6shEGYp3ZPApx5yUQ78AZW8nkBisXfe4kO+QbHjEew4vsJxOpK7TpdLEtbweVNZRZ3IuHFibITrakvs6qKXivmgie9GRCgdiCbV6tXgtRoLxu/e451n+nbkBNyuH5FcZwUse55BqkeAhAVYxMEssivZZ+fqm3EqAGxnq0ZhhujNAh5hzi7Qohe5P/Uu+Mp9Jp93peX8eQH+Ns10NCTvWVbJO52uDv28H+NM0ITXauoGsYlWSGWFAuMsAi8JAacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEklgWbRkAlJXhPMMRSMd2IA+pl/yg8r/seigLOTL2w=;
 b=OmdsApAy2RVPhFAqK930AOt0iTxRRuIiqZGUQN7xnnSO0MXD8pBRurJ4elH7+JuOkDvyA45q13eni5UesVL/UNqFwVWc7k+AOU72vyiI04I8R2HOi32HDh2T0SyKujfSQ/oddvZ9V/ZkeVHWQAwl13OA1aXmeuUQZJM4D+PGqveHMnLqAl8Is1CBLOgZoCeYVbup3HV0u75HE7uVZZgkwOkQATBhbOL6cUNuYn2ck686KvSfZufYojIXoewkPdEKP7e/Br8vrT56KGB1tGxhCWCcSNvMnRwIR0DJ6L4oKYRJAondPI4INo5DGpaXWaTgfDBF7E9Zubdc7igV+Tghzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEklgWbRkAlJXhPMMRSMd2IA+pl/yg8r/seigLOTL2w=;
 b=Buv2Q+QD1Sace/lveAVTcFr5mmNtWGM37zbZtEIUwLb7uffQW0K2WcAzd5mP+QFHxj4a6VHp94ezbJ42slQFU9vnj8r4dov8ZHt+7GCBGz1W9tCDGui1O9xWW9OT4KFOI47u3cOesOoLEvQMMweCTaMBnT511iOm6+CZj8DaEIKud93cU1QQeUdD/ZryBiDSPpZlDebIyZJHFTKm91xgiVY60Vp/6jdofYVFHa8SAQ/zKBjRTBz8Kr4GBeuI4mHGNG1TqKfdPaRkcm6rk2OeF/Yt6WbJc0P6qH98CJZr3R9pYv9zwIcvG/cgEh2G+8RTh9lfoPH3pxDhEwiF+z9Y7Q==
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 01:52:47 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::fa) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Tue, 26 Sep 2023 01:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 01:52:46 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 18:52:39 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 18:52:38 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 25 Sep 2023 18:52:37 -0700
Date:   Mon, 25 Sep 2023 18:52:36 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jean-philippe@linaro.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Refactor
 arm_smmu_write_strtab_ent()
Message-ID: <ZRI5ZNQMi3GYtS3I@Asurada-Nvidia>
References: <cover.1695242337.git.nicolinc@nvidia.com>
 <6e1fdea8ab43ea28e7e3c79eb6605dea71548c53.1695242337.git.nicolinc@nvidia.com>
 <20230925183523.GJ13733@nvidia.com>
 <ZRHnfq6mzDz5zTLC@Asurada-Nvidia>
 <20230926001220.GL13733@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926001220.GL13733@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c25bc1-9260-47b9-d912-08dbbe33484e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6HQCa2aTGtVbHo99addK/kgqZbu5tI36PqrYLjnTZFTD9aBKDBKjiMBx1JUggP6jyoKKwSfdTLq2rxB7MoH+HVo8dIks9MLF21wirrlzGfezPScGZkAJd+lxCAv3IBkm9x/qSyMDvV2qXY3N5QbhZfO6899opPdHWM9yHuRTDEgZmW1eVaFryKZP0g0euU2zgdBAeL54dlHu0iaPevoJD3DYUCSYQHjR1nt2EOqeiD2d0WKG+cUEIPbnfm9jON6nZAh3mkKE3cz62abJ7kh26htrWqsGgOKf1RxmFWWf9NdYDABpPEN6luhqU0/xzVpYU2Jh6a4KrACcf50kMhPr/eWiLHWTZhdrW/ozq29qcWBIyqJe7MDgUKHF+GRGyFw5SqEtI02dwQ8qsM4dL09+fA+buPCQH8sPwNlwjzhIg7COkJh1P+t84DGi6AtwHrDj5ccNTLMwemzZ1Vwlurh830n9I0kq3Mq2Js29E1tsPTC1a1x1VbQaePK8qzWclShxTQVgbjdRWkid58us15aDXgtgU6XbpQSfTn5mjbrHWLYlIKsS7F6TGR/y1EOpmjo0dUXaRaMlPg0Yih/X4kgDW+JSlogzJif6K+kXwyTIEF9yJWNO9frwj8+qvAIRKfb4oJt1YAPOFJbKS2v0DlFyOvBqocqM6X0ru8RpQbJF+TaqCAGDWT2rYQUtJVI4LF/2KdP+2XkXk/bBF0swSBXtSgzvlyUYzY7ocaltBuuwK8NTguXmk+mHpPlTMTdoBVO
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(36860700001)(55016003)(40480700001)(40460700003)(26005)(7636003)(356005)(82740400003)(86362001)(5660300002)(9686003)(2906002)(336012)(6862004)(54906003)(6636002)(47076005)(8676002)(83380400001)(70586007)(4326008)(33716001)(478600001)(8936002)(41300700001)(316002)(70206006)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 01:52:46.7387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c25bc1-9260-47b9-d912-08dbbe33484e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:12:20PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 25, 2023 at 01:03:10PM -0700, Nicolin Chen wrote:
> > On Mon, Sep 25, 2023 at 03:35:23PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 20, 2023 at 01:52:04PM -0700, Nicolin Chen wrote:
> > > >  
> > > > +static void arm_smmu_ste_stage2_translate(struct arm_smmu_master *master,
> > > > +					  u64 *ste)
> > > > +{
> > > > +	struct arm_smmu_domain *smmu_domain = master->domain;
> > > > +	struct arm_smmu_device *smmu = master->smmu;
> > > > +	struct arm_smmu_s2_cfg *s2_cfg;
> > > > +
> > > > +	switch (smmu_domain->stage) {
> > > > +	case ARM_SMMU_DOMAIN_NESTED:
> > > > +	case ARM_SMMU_DOMAIN_S2:
> > > > +		s2_cfg = &smmu_domain->s2_cfg;
> > > > +		break;
> > > > +	default:
> > > > +		WARN_ON(1);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	ste[0] |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
> > > > +
> > > > +	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
> > > > +		ste[1] |= STRTAB_STE_1_S1STALLD;
> > > > +
> > > > +	if (master->ats_enabled)
> > > > +		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
> > > 
> > > These master bits probably belong in their own function 'setup ste for master'
> > > 
> > > The s1 and s2 cases are duplicating these things.
> > 
> > OK. I thought that writing these helpers in form of STE.Config
> > field configurations could be more straightforward despite some
> > duplications.
> 
> Ah, well, if you take that approach then maybe (and the names too) but
> I'm not sure that is the best way..
> 
> The approach I had in mind was to go down a path depending on the
> configuration of the master. eg if you have a type of domain or a cd
> or whatever. That would imply a config, but not necessarily be
> organized by config..

This sounds pretty much like what arm_smmu_write_strtab_ent() is
already doing, but you just want some tidy reorganizations?

So, by separating domain=NULL case to clear_ste(), we could do:

if (cdtab)
	setup_ste_by_cdtab(cdtab, domain); // still needs domain :-/
else if (master->domain->stage == S2)
	setup_ste_by_domain(domain); // literally "by s2_cfg"
else
	setup_ste_bypass();

setup_ste_by_master(); // include this in by_cdtab/by_domain?

> > > > +	for (i = 1; i < 4; i++) {
> > > > +		if (dst[i] == cpu_to_le64(ste[i]))
> > > > +			continue;
> > > > +		dst[i] = cpu_to_le64(ste[i]);
> > > > +		ste_sync_all = true;
> > > > +	}
> > > 
> > > This isn't going to work if the transition is from a fully valid STE
> > > to an invalid one, it will corrupt the still in-use bytes.
> > 
> > The driver currently doesn't have a case of unsetting STE_0_V?
> 
> Sorry, I didn't mean invalid, I ment different but valid.

Then you meant a translation from valid to another valid will
be corrupted? Though that's how the driver currently switches
between valid STE configurations by staging the STE to bypass
or abort mode via detach_dev()?

>  > > Though current code does this:
> > > 
> > > 		dst[0] = cpu_to_le64(val);
> > > 		dst[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
> > > 						STRTAB_STE_1_SHCFG_INCOMING));
> > > 		dst[2] = 0; /* Nuke the VMID */
> > > 
> > > Which I don't really understand either? Why is it OK to wipe the VMID
> > > out of order with the STE.Config change?
> > > 
> > > Be sure to read the part of the SMMU spec talking about how to update
> > > these things, 3.21.3.1 Configuration structure update procedure and
> > > nearby.
> > > 
> > > Regardless there are clearly two orders in the existing code
> > > 
> > > Write 0,1,2,flush (translation -> bypass/fault)
> > > 
> > > Write 3,2,1,flush,0,flush (bypass/fault -> translation)
> > > 
> > > You still have to preserve both behaviors.
> > > 
> > > (interestingly neither seem to follow the guidance of the ARM manual,
> > > so huh)
> > 
> > Again, it is probably because the driver never reverts the V
> > bit back to 0? While chapter 3.21.3.1 is about V=0 <=> V=1.
> 
> No, the driver is using the config in a similar way to V. From what I
> can tell it is making a bunch of assumptions that allow this to be OK,
> but you have to follow the ordering it already has..

The "ordering" in the driver or spec?

I found Robin previous remarks around this topic"
"Strictly I think we are safe to do that - fill in all the S1* fields
 while Config[0] is still 0 and they're ignored, sync, then set
 Config[0]. Adding a CD table under a translation domain should be
 achievable as well, since S1CDMax, S1ContextPtr and S1Fmt can all be
 updated together atomically (although it's still the kind of switcheroo
 where I'd be scared of a massive boulder suddenly rolling out of the
 ceiling...)"

I think this answers most of the questions above?

> > > The bigger question is does this have to be more generic to handle
> > > S1DSS which is it's original design goal?
> > 
> > It feels an overkill. Maybe "Refactor arm_smmu_write_strtab_ent()"
> > is just a too big topic for my goal...
> 
> Maybe, it depends if it is necessary
>  
> > Overall, this version doesn't really dramatically change any STE
> > configuration flow compared to what the current driver does, but
> > only adds the S1DSS bypass setting. I'd prefer keeping this in a
> > smaller scope..
> 
> Well, no, this stuff does seem to change the allowed state transitions
> that this routine will encounter, or at the very least it sets the
> stage for new state transitions that it cannot handle (eg under
> iommufd control w/PASID we have problems)
> 
> However.. if you imagine staying within the existing kernel driver
> behavior maybe just setting S1DSS does work out. It feels very
> fragile, it depends on alot of other stuff also being just so.
> 
> So, at least for this series you might get buy without, but do check
> all the different combinations of attachment's that are possible and
> see that the STE doesn't become incorrect.
> 
> If it is OK then this patch can be its own series, it needs doing
> anyhow.

Fine.. I can try that then. It looks that we have quite a thing
to do before I can respin the vSMMU series. 

Thanks!
Nic
