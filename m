Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BC77B9694
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbjJDVfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjJDVfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:35:09 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B6C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 14:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktO1/xN3gbiq4nELkHTVwIg7Tezd7Wqhm8xSY3IaB+M6MIA07estFN53QWlRGj+18+gQarj/oABSf5JxSTVmo0l3pYtPhPElsDvwsrjLGq9eMNa0lQ3wXqLU486S6ROmfU2Xz1DcY8XU74JRTUBAa9Xyj4W61nil6R6mEmSZ/xCGSPGT3sotAFAwCH8/d782/tVTX2iNN7TSk+i/DSu7x0nc/cNNPQ3BKBlKEAzuPJv+OVV0aS+oJ2r9w1CbGhltLriarj8uhKcBj/OtxqTphj6alOtuz7JoT0TGB9Mo99qK99lHeunTlBf+L2ILwjSvL5H/KqY0iwLqFxPPcPvOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPrAW3II2I5JAPg4QqIlQ4fwo91Y7Gmup1agI5/zR0k=;
 b=n3uTjaGaFcY6um+0Mic71KfJAmjBX1LeSdE+kC0374oNI3/uNtDNp1oxaIbIRbdQEk4SDip05lfKyWZynhxfWWa3LKfe13lLYrmsblQ/k0tSJ3lY2x800m4mnyzbnr9Pa5uR42ElIwWBGUwDRti/LTUFTd7VT46nEBnW2AJOFn6XN6zdtPang550naSYAdeZnfcpEaejpiOvj0+paK4nFR+xfcQ1SmSMY8WA16N1tdj5By3pLfwcLTjeyjoz7aO3e+owZlbqGMCYtWCWk1vvRBLmdD2wa4RK6PaG9xptlh3z7GLugOOi4D9wGmXg91KEEXrY6bROl6PMzpL8ZrJR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPrAW3II2I5JAPg4QqIlQ4fwo91Y7Gmup1agI5/zR0k=;
 b=jXadJDRwi6Ez2UwONUMwsyweFH0Zw5ZHNJgGko/Vp79oerqwe7kCedd71+VPwbE+oitFoSoS8ulY+56crqS+XZczifftASroghj0xbXeiGbrKUapgLXjk16sA/b++LcXYc4pKIkrpviXpr9r5wVj81QuY/PhYDGyi7qVDMVej+3nPQ2eMq6h1yBP670j/uZuSkbeGEy59cO/Hhx0NXgaOEgDJl3oZ/ws28zvlYeDP8NL47xnNhqtLqB2pboE97w45nveQIeSpefA7Ngvb/szFyX1/34Z14rCakpHKb1B5qYNcyL4Mgjw+CbZzTY1yd5zFkE7ad9SOL2kS/1qUJwRnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.29; Wed, 4 Oct 2023 21:35:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 21:35:03 +0000
Date:   Wed, 4 Oct 2023 18:35:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] iommu: Switch __iommu_domain_alloc() to device ops
Message-ID: <20231004213500.GJ682044@nvidia.com>
References: <cover.1696253096.git.robin.murphy@arm.com>
 <458dd0ed839541693a49da33239b33cf4c48b8ec.1696253096.git.robin.murphy@arm.com>
 <20231002141615.GA650249@nvidia.com>
 <a4078085-4061-2b52-daba-1cd642f0cf9d@arm.com>
 <20231002193609.GB650762@nvidia.com>
 <08de017f-80b1-8374-ab0e-2eaebe037b86@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08de017f-80b1-8374-ab0e-2eaebe037b86@arm.com>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: a36c0474-6e3b-48d2-7d02-08dbc521c4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJtjPHPFDuBt7sFVPmjO6SMZeVuQbgIz9/P634uwanyk9JvSgGhphQuWBQkOq49VZMsbw24w2gJc9RfOm3QJraKaofuu3b5HHF55ZByBPNx2zfpqvgie0FZbkgIc2qRA7ynz740q+ila1IE367QmMJAgL1Pb6XwfCArRC7JDdxA19r4AagJUvLUJV0t55vrQWJABX+oq+JuaJ32M5yJKzNvSlZIvRuMI2Q6PTe8nMeOwSP93PG9sRaFT0lE0mID5QGWrW4esQ7H7infj41h+5ZNcqiK5kd2S7xWkAuCBjeCeDkNNddt0jZwbDSiRTEiODgCi/bxavyHkaejSbkfgIZF3k5tq3XmgzF1dN+Jaxr5s6Ur4FhAWiY6+uTxkhTzy8vf7M5FiBr3zUTyBOv2AulMw1p8gi3qX0bknJ3ACGRf36fLZSEBXZVMuokvrAwxP8IsfZudEV9bjBcRYe087r0SayDJ0o2AgOQsYiiulvu1JmP0MAiolG+kJFU+5KWcVuaVyTMjZWhxspYyzSGh4sEPABtJwRB4l3aUSoL8/WjW0vL2YS8/YDv2SNSvjU0RVzdr3jzUhFMoFQYoyuTrjIlJL9DyE+11Imy51e2we/G/qrmkNqO4MzNK5UyBeOYcj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4326008)(6916009)(66556008)(6512007)(66946007)(8676002)(8936002)(5660300002)(316002)(478600001)(66476007)(2906002)(6506007)(6486002)(41300700001)(1076003)(26005)(83380400001)(38100700002)(36756003)(2616005)(86362001)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ncor7QZNflDjh7g9fYWWVwn4n8MC71vVa7wI9R6L0UWGE7ir5FbWNTYPcdt4?=
 =?us-ascii?Q?hjORsOBeGfflChUb0taA2eVOdTUMYd/6tu0Epl1T2Tt3pVI+I3y36Jlu0MSm?=
 =?us-ascii?Q?CiDCel366jJP2ULMzFev7hX1UaW6uoAsH/hjM/2+NIORJl+XPlBhbqn+HcnT?=
 =?us-ascii?Q?LMmkMqakoRaefCOMwoCiHO0jAZwXStbk8Aqiv4VNE848xXEc3gr5RixpRUA/?=
 =?us-ascii?Q?tqeIlgj3/RRgxqHPWz7kPTumL6E4gyzWUBtYANlRDTXQ1w2IGIhfYFgc2mTb?=
 =?us-ascii?Q?oF/amxSTgB2co9j2mp/mMoQnCb0forMGeuvOexnaC+LSSEP+5QC5JSNQeKku?=
 =?us-ascii?Q?P442N6SLbrqZf5TieoqhelKRosBF5jQPk8W1V0qLp5xHOzvSap7TgJ0Mtm+b?=
 =?us-ascii?Q?OfGRq7YdhlrCaMyDXElNbvOEnlvpm2MXy2fXsoQRiEbxSYoByQ7iqxTDvsTk?=
 =?us-ascii?Q?44qsrocg0eaZvPkpTgz4WjM5IjWy0aFcA+ee3INrs4ORW/OUWP+OP7g82FuL?=
 =?us-ascii?Q?8UDIr8R9JcNu6QCt07A0abvREVF1yr0o9gs2D1Y+vIEyFqe+vSNlkS1RBhdi?=
 =?us-ascii?Q?d7S20ENnDsGLEQ+8Xfl3gfAuqtqbvjObko0M1kewSWA6NYnPmum3nuoF9Jmo?=
 =?us-ascii?Q?ldfDRYLNnegYRwP/LVONG8jtjadMxjNzalM70VLhltgtG1xgmdYJhIIr636H?=
 =?us-ascii?Q?X6GfbYjVHaPCYsAAw1Ql+Y2QNoITGNxzGFzecS7AaZYl9wyveRUu7q7+ZWHK?=
 =?us-ascii?Q?QfXCClQgUQGQF8t6ngNaDA65duToSZlZhekDBh8ioloOT5E1CoetjfcwUlXO?=
 =?us-ascii?Q?sVjp2F92O0wWAWfZDe4IoAuH+ei8MRHO26wMz/mhy8/9isvTSyzeGA2G0k/R?=
 =?us-ascii?Q?vpA5ldnVAwSwyn2m38r0R2vc3e8vxzBzQ7AMtpMwd7E8bU+GaHrRkWOYhA7q?=
 =?us-ascii?Q?gUMbNDuZAQpcx9lZcWtCsf0JMhHtNwF6KYKzaq46qVPynGNyNGk8Y4kPUA2H?=
 =?us-ascii?Q?aTs4Deffyy4MGdDZLz09eGZxx6urAtWaEkW5uiNECehBwhF0pblma49rMsPX?=
 =?us-ascii?Q?ZJ0R0gR0W70ePtwTP48kJ+ODhAs2HfxyuZeH9lb/L+CtAAqlI6jLSs0BHRXL?=
 =?us-ascii?Q?4wBjj0JPgyUv/PPoGIZrrv66FDfARQ9cyW3QC/LGIUIKaZD2pxm41lj5dGOv?=
 =?us-ascii?Q?xRPHtA6fPRBwMJEI4Py5pdiYS9UvGQqcp9+ZZtw16UapufLOHDXSLvkaAfGZ?=
 =?us-ascii?Q?QdlR8wLDhwmsRa6SH+AJVGFaRoD4wE2kM5pJ/kOxAS6IkWfifrLvEZ2AQoiZ?=
 =?us-ascii?Q?aIkgRjcUV/37OCiF9B7cQwKMeXkqM4P394OnfSrJBsSI8j5dgNUQ82qVQmVK?=
 =?us-ascii?Q?wgfucEBP91kVUPaByCPckCkAk6l4zZQW+RzMZ0WeESu85slhguDYR1BO7pTk?=
 =?us-ascii?Q?3FBqy7OlnIJ2pbmaDcQvY5XV49QL3AfWzn5HxqKcBWS8YyZCqJ5lNMSnTg2z?=
 =?us-ascii?Q?kFh/2b0NFK0TZhb5NMaVGluP5Wm4ypF+4W9rZMrfXGAkbf8wgODH3fT0FBP4?=
 =?us-ascii?Q?k7xkmO5s4jKHWo36EFETQIN+nkGCyzXUl8kFaaDl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36c0474-6e3b-48d2-7d02-08dbc521c4fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:35:03.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFi/uAAmx1H6LWabBPC7SC54THlQIWEjIXtmqgLAc7rEKJunDWfTMaXAzglXtEmk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:23:05PM +0100, Robin Murphy wrote:

> Sure, that would then leave two callsites for __iommu_group_domain_alloc(),
> which might in turn justify leaving it factored out, but the endgame is to
> get a device to resolve dev_iommu_ops(), so if we're starting with a
> suitable device in hand then using its group to immediately re-derive a
> device again when we *could* trivially pass the device straight through is
> silly and overcomplicated.

Well, it is the same sort of interface as attaching a domain to a
group. The group stuff is like that.
 
> However it turns out that we can't easily touch the group here at all
> without then needing dependent changes in VFIO, 

Why? VFIO only puts its weird groups on the mdev bus and so they will
never hit this.

> more scope creep at this point I'm going to respin this as a purely sideways
> step that sticks to resolving ops from a bus, and save any further
> device/instance niceties for step 2 when I have to touch all the external
> callers anyway.

One thing that I've recently realized is that this patch will break
everything when combined with the patches I'm sending to start doing
finalize during domain_alloc_paging() ops. It will randomly select a
device on the bus which is proably the wrong smmu for the device we
intend to attach to later.

So, to keep everything together the special bus domain alloc path has
to continue to pass in a NULL dev to domain_alloc_paging.

Tthat is certainly a pretty good reason why the above can't use the
existing group call and then you can make the case it doesn't have
enough users to exist anymore.

> But that's the argument that makes no sense - it happens to be the case in
> the current code that all default domain allocation sites are already buried
> in several layers worth of group-based machinery, but that in itself holds
> no significance to the allocation process. 

Wel yes, but also it is what it is. The group stuff gets everywhere in
undesired ways. The original version of this did write it they way you
suggest and Kevin came with the idea to have a group alloc domain. I
tried it and it was indeed cleaner. One place to do the Quite Strange
thing of randomly choosing a device in a group, and combined with the
get group ops function it allowed all the group centric code stay group
centric until the very fringe.

Keeping it clear that the dev was infact just made up in alot of call
paths is a nice bonus.

> only existed in Jason's head". If you don't want an IOMMU driver to be able
> to think the particular device is important, don't pass a bloody device! If
> the only intended purpose is for the driver to resolve dev->iommu instance
> data, then have the core do that and just pass the dev_iommu or iommu_dev
> directly; ambiguity solved.

Oh, I wanted to do that! I looked at doing that even. It doesn't work
for amd and smmuv3 :( They needs to know if the group has any PASID
capable devices or not to choose a PASID compatible RID domain for the
DMA API use. Can't get that from the iommu_dev alone

> If one is expected to look at subtleties 2 or 3 levels down the callchain of
> an API in order to understand how to implement that API correctly, that is
> *a badly designed API*, and piling on more "correctness theatre" code to
> attempt to highlight the bad design does not address the real problem there.

Oh, I agree, this group stuff is troubled like that. It confuses all
kinds of unrelated things into one bundle.

The group stuff exists at the core layer where everything wants to
operate on groups. We attach devices to groups, we allocate domains
for groups. Then the device level works on devices, not groups, and we
have this confusion.

> If you've noticed, between here and patch #3 I already end up effectively
> enforcing that devices in the same group must have identical device ops -

Doesn't it just fall out of the probe rework? All devices are now
attached to a domain during probe. If the single domain in the group
fails attach because of your patch 4 then the device will not probe.

Unraveling that would require multiple domains per groups, which
seems like a huge undertaking :)

> So AFAICS the problem you're desperate to address is a theoretical
> one of a driver author going out of their way to implement a single
> .domain_alloc_paging implementation badly, in a way which would only
> affect the behaviour of that driver, and should be easy to spot in
> patch review anyway. Any complexity in core code in an attempt to
> make any difference to that seems about as worthwhile as trying to
> hold back the tide.

Well note quite.. There are quite obvious things that can trip up a
driver. The requirement for a special RID IOPTE format to get PASID
support is tricky. The drivers are all functionally OK because we link
PASID support to singleton groups, but even that took a long time to
arrive at.

So, please try a v5, lets see what it looks like with the
domain_alloc_paging and semi-locking fix?

Jason
