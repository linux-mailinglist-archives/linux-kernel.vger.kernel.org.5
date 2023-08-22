Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1CC7843BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjHVOQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbjHVOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:16:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4E310C3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4muA5W+PbOKopoqhF7ZR0zEeBxYmL48C9dTfdPH/sC2TwprzITeCwea8P5gnGmQO1uwRkvkmB1iAco+/+B1O03bfh8gxKybvgyO1tcAMP8msWwuZxXARBiyX67b03q9Kbz2XrascFMutDMsunhpgetE2z71YRsz2U9ajpF0GB2GupoqsFPfJZOoGhFjtzAzsRCfvzk32JTv/CWhWvKabM9Kr9Z+bQeD6rO+cN9PCfEqRh9FNolvNafmOA9/+rHsvnTkUTb1ZtKRrmzMD60JZwKtdMAO/mfZTTnyecZY4GR8P1h0w1psVuqgBr5MHbB4sFlMgFWcODQmg4tcgCjWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIS++3HrxCY2T1Oo5Cse5G/GMi5s9iMS7xTs0G28BkM=;
 b=iZf65SrtlW/o71BJ4uGJF2V3iWMq9LLqGkYIdCKewrWuhRDyN1KKi85JAr40HPkvX7TaH7T8YjQOoyfU3hrPHC28Xs/BSqo7KEeLZWQzH/5VZ+4FkNppzf1dWTUzkKoum92tlbRV5b/dCDPe8hBMtAvjUdAA2qe1b/pR0AZj/MDZX9cbrqbA4uGQd9ZENl9E6md9v7Lv7O+QZioti+pwFB/Piwev8gF+maglDImVDvL5qQbe6hW9h9pDyT/SFgGUqvKjCfg8QflKIwyz5LVjTkt+DWZhnQkFeQVqYJQBFiL9TOZWCyPUyWYizPBIG0t/EV5nfaZhjH8ZN41ArrAPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIS++3HrxCY2T1Oo5Cse5G/GMi5s9iMS7xTs0G28BkM=;
 b=iNNzv4GVJyfi6HqfzbZY3SVOG2gWMtaGTG+AHBFNpJoko7DJXx6/S/8rZPGJ9d9zXwwlKIiu7N8jhd/Yn6HPqKfkbu9qPUvlov3mo2chnm4lgPWnkJTByAixuHucdRp2p448OxxoJk2jlN+I2luyKOC83SiSIlkGcbj19SYK7BnYkoQkp70PyubTS+66AUtzrVaAicb6mXw0wVcErfcck9kTwkWqq1Aoo/SwSuISXswLhbWjZ0ke7f/g7G02QabsbeKNZhuDHesZbTROXHSL6z2CaF/ZnUPWMTNIcc9b+mjYPZ1/Wb5qnOzodfuviSQ95cLEntDUfRixa7/0m99hfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 14:15:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 14:15:46 +0000
Date:   Tue, 22 Aug 2023 11:15:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org
Subject: Re: [RFC PATCH v1 2/8] iommu/arm-smmu-v3: Perform invalidations over
 installed_smmus
Message-ID: <ZOTDEUm1gYLmcNK3@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.2.I782000a264a60e00ecad1bee06fd1413685f9253@changeid>
 <ZN5y4N8ffSoiR/sm@nvidia.com>
 <05f69a1a-97c9-ebca-5e01-c0b00699c93e@arm.com>
 <CAKHBV27suc5nDoH7gMHebjYBONTNqsugWvxbo2E-fRjRGs288w@mail.gmail.com>
 <ZN93TO9mRIrX1grw@nvidia.com>
 <CAKHBV24L7pTajkStWCRiW7976+B8VtDHRDpo+Emta0RshkvRhQ@mail.gmail.com>
 <ZONRRubvUK7GXO4i@nvidia.com>
 <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26knnw7WjUP-6kw1v0T9=196d3cJa5zO1tQa4kjteO-fg@mail.gmail.com>
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a661427-e573-44eb-7010-08dba31a4771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lexqRL3ZWdcElKu5b0UH9M7hRC04tI0g1bfi7/Wfi05xmeCjaKc5r+NefUsmC2P7h2siURXRi5VUimj15lgihwXfo6MnCYZ5365BPk4MzDLV4sBlddJpwD51iiQoIo5ICtXvyWow3VSiQdRbmewYj7RIRpDIzcFBimFktm397AfXLXdXH5+FQmkjTtTRQKzRanQP5VEIGGwYrxY1eepDjJhbcqV/aEMJR8T6oHqn/gxP3Ea9vo2vfHElImhgz43IhhEC81QvCT+d/hQymo7EN2kWCrZiS52PNzu6uXoS+gV9wXLMZqIrICI8+67aHlFFHpAIoJsjRKTNkM6JQOK8Xue85ca6b6/T5w98MFGkOFK9Mn57U/l8odWqh4pC7u5kpk2z21I4jsE7WWtws/KwAPciUqL7QezxIST43/LjnTXDDfsl0WAmOc5BuDtU11RS/E1SBLF3w53h+EyNcMNRva6o4W+BtzHaiNkGbmPA22wXXLSIfQob1USrwtXNYUozibULLQYegbzEoILoPwVdGAC6P5aGLKBpvnwzzLUw9Y5ZWNmRTNth5GjN4TU56XZd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTQ5OVpPSmUvNnhFekNraU1NZTdYUm53ZUpNcXFKY01GRy9oY0FJOHlESDRQ?=
 =?utf-8?B?cmlJUHRJaG5GV2h0d2w5SFhwN1FzWWFuZjlnK2dwNnBFYXBrZjJYbjhWM3VU?=
 =?utf-8?B?cC8yOU9McXRSd3kyL3RGN2ZLMmc0cGJSRVYwTkw4cDdaVERnS1B4OE9TeEI2?=
 =?utf-8?B?NjZZQXVYWnJnSXBFUCtaMVRvN21SWDJwSGx5WGZHTUpPY21jMUU1RUk1TGRB?=
 =?utf-8?B?a0szTkZEeGNKdC9IOWxPRTRyQmZFU1E0a3NjZXZURTRJcm1WSE5GM1o2Umk3?=
 =?utf-8?B?YWlUQkhzVFpEdlpDdkNlUER4K2lrWHdGRWltdnB2TGNhU0tETWorV01pdllR?=
 =?utf-8?B?Wm5heEwxN0h5bHczcmwwNVQxOUZsU3JzU3lON29YQW5FYmx3M1A5WFA0SE1P?=
 =?utf-8?B?a0RibGRaeENLcWwvSTA3dDg3TWQ2ck1mZE12K1Z4RlpiNU5ncEFXK0hGWGpH?=
 =?utf-8?B?Z3dVcjJvUU8xeVBKMGdvUzNqR05VUHFMTlNSZVRFQUhFdUsyVlp0OCtJMUE2?=
 =?utf-8?B?bHFIaXorTjBzcitqNk1kM3hvb2pZSEtJYU9iZytuMmNGRkpKS2hrYnpCaDAr?=
 =?utf-8?B?L3R2R3NLYnhVRFdNeVk1YzBGUE5MR1FzbGYwTks1OUl1emtuRko2VnVHdUxT?=
 =?utf-8?B?aWg4WG84M3JSM2Z2eS9qc3ZkVHM5aEtmRVNsMFEwQXcwS0JWWjJ0dUtLMzYz?=
 =?utf-8?B?ZUFwRDVUa3JxY21abmoxT2lRNnEzUDROUHptZkN1QkpmUjdDZzZXNXFUSjcw?=
 =?utf-8?B?TG1TR0V2U2tWM0d5czBpSEg2eEFNdTVIRWgvdVhZSlRuUDlmT1RiaDU5N1k3?=
 =?utf-8?B?VS9NR012R2J5NE1ndTgrVW1lK2dLUURSMkNpQmZCYllFT2ZMTFYxNG9ORjZW?=
 =?utf-8?B?VFd3NkZVajlBa2Q0QXc5c0xBM1hNM0tKK0JNdXd6MHRXVmFZWEduVVNSWWpz?=
 =?utf-8?B?UjAwZEhGb0xTbmhlRXhNNlRyQkh6Z3lNMU5xQU5HUzZZNVZoRXRyNEhWckxY?=
 =?utf-8?B?Y3lrL3ZzK0NUZVpxdG9vLzd1UXVKbXY1aHp0b0VwZTYzR2RoMVlSNnc1VFMx?=
 =?utf-8?B?WWtwbWFrZy9DQ1NIelNxSHY1V1RvTk96SzFIY1EwZWFleHZCUm1oTHd4NnBa?=
 =?utf-8?B?c1ArRzZ2WXJSQU1ackdVWUJXR3BNUXRGcTdEdTlPYnVHMEJmdUEvaENlbzhQ?=
 =?utf-8?B?OVBEVDRSeTFJaVkybmxvRTk4MWRIRlRCcWc4VllDT1A4aEpYZXprRjFDdzNw?=
 =?utf-8?B?a25iOFhydURPRmwzNyt6V2xJZm11SFRBQXpDVTlLckFRUkM3WU1ISHYxNnAy?=
 =?utf-8?B?Z0RlZkp4QjczMG43dWtvdTlOaDkrSm1aN09oMVRWWVJBM3lPbXg0dUt6cm1v?=
 =?utf-8?B?Q2Z6UXhYejZ0REhJck4rWVdnbWFhVVBlTzhyeE5NelFINGlIaG4xZXlmb3pV?=
 =?utf-8?B?N3hhS0lxQnNvQU03UENSbFY1MUpmbUhRZjRITUljV3c4cWtyYU5JVFU1N3Va?=
 =?utf-8?B?R1ppRlE5MjRGTnloNE9aZU0yeU4zTzgzdHV4Z2VCQ292dk1oRmh0dnhWemZh?=
 =?utf-8?B?WGR1VVFFYnZTV0YvQkNOejY2alB6ZGNDNEtLSDI0aEdkWC8zeldFeXM5V1Qw?=
 =?utf-8?B?SGpxWjJ0RHVYWnkyRW1MQndKcXZwempGSWVFTitKck0vR3Z0aGJ6YVZ2UWQv?=
 =?utf-8?B?anJCc2taREc4VXJUc0FGQWp2WmFhalJLNmFGTWZGaGU4ZUlQZ1Yzbm9LUW9T?=
 =?utf-8?B?cjRVZmVSY2V0ZW5qcGdLL0c5QjYwbnN3bE1VOFhHZGE1azdXclBOOGpsZHda?=
 =?utf-8?B?RDNwZW1lV2g5b2RuRnIzWkI5SjBsMzZuSWhLRFV3c2VUQ0dIL1V5YXdjRTVQ?=
 =?utf-8?B?ZVN2N3cyQVZWQ2dyUThybWVYRXp0SmF2eGtCbEFRakVVTzZjR1F6U0VURTRT?=
 =?utf-8?B?aGJ2ZXNSeDEvWlR1dC9NOGVPZEN4emYranJhWHFMdXh0Rm03QmRCZnEwRGtV?=
 =?utf-8?B?aitEcDRYaWdLa2RMbnhxbFBiOU5tUS84c2MwdUJCeTJLQnhtN3pzSHBFbFpz?=
 =?utf-8?B?TVc0T2ErbFE1eEorUWwybWh5UmtHZ0NzVUk4c3V6Zkc3RjlueERscjZuSjBQ?=
 =?utf-8?Q?PDuDGSoY/ldMjxSn4NNPEcRFz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a661427-e573-44eb-7010-08dba31a4771
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:15:46.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFqOrqOsTF//tExDg5uIogA9bmZ1JohZIkP09roDHr/JNh/N0m4a83HYvwEvV1Kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 04:17:31PM +0800, Michael Shavit wrote:
> On Mon, Aug 21, 2023 at 7:58 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > > Since there's now a loop over a series of SMMUs inside
> > > arm_smmu_tlb_inv_range_asid, it makes sense to move the check into
> > > that loop. This technically works because only SVA is calling
> > > arm_smmu_tlb_inv_range_asid but can (IMO) risk introducing bugs in
> > > the future since it's not obvious from the function name.
> >
> > Well, I would remove the duplication and add an argument if you intend
> > to share the function that loops
> 
> What do you think about this as a final stage:
> Once the set_dev_pasid and sva refactor lands, SVA could call a common
> arm_smmu_inv_range_domain implementation which would:
> 1. Skip the TLB invalidation on a per-smmu basis if it detects that
> the domain type is SVA, or based on a passed-in parameter that is only
> set True by SVA.
> 2. Issue ATC invalidations with SSIDs found in the arm_smmu_domain.
> This common function would be used for all use-cases: invalidations of
> domains attached on RIDs, on PASIDs (SVA and non SVA).

That seems like a good place to aim for

Jason
