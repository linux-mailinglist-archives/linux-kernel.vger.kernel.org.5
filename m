Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2277CBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbjHOLjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjHOLiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:38:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C610D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 04:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvhX3MbAWnKjyo16WNKWBPJSciLmcnIWZYMdD4ajKO9IQRIV219mfeebAWgf0Nbgw368Xq0QlJ8G5AvkA6LDuemaNlweAckX4IGgH247pNnW2XSCyUbU1wKMqlM7lV98qyCOXBVs6ntm3TgCsFxqFHJ7f8Kvm7nl8XqVRHNkJRucyBf3OHBY/N4IB2NQw68kFOs5uBMEKYz6yseUB/IR5/ayrHCKnX0e+mzqDiTYS9CbbSctqmCegfzr1DO9VIoPD8+PFFEWk/OgabhniJlVkcKt6AI1NhCZG8CljDAag5DAP0PFZIGfZ01LAtRMocP0PBa6XpGuh3FgoYjlh5hN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgb5wPrcpvWym9Q8CJFsdRRgVf/NITy7l4K8CTNwb1Y=;
 b=HmPv8IdREojiH5GdPu5CpMKeha8yTxAJGlvMSaFoD646vZAcNk9Hhq9V7QMjqi1GAU9KUdGtJFnKv45pTS3AKNM9ncP6ViKVPhKSxmI9AuBoLQ35q5Ilet3Jzoft4lMGKvdS/xdHLReMR+ukDVbwd9kjsHmhZon2EmnV6geiQXjrJr+c+cyz2+uM4OQqjHTguaxUJfvSrl3dKtBrP6KnsJXhQRaglj1K3rnJ4h8tNRL49eOeW3kj5EXyQdJEM0y70NE7Q7QGS7N1YqMmMUzu4Tta6WThc6IVn4IJxB6A+kQMV5kTSM3p611h5h0Xv+sB6CoDPvL1rhMX/I+Guu33Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgb5wPrcpvWym9Q8CJFsdRRgVf/NITy7l4K8CTNwb1Y=;
 b=F4yonXufsGhH1dB+19IPFaAWDttXauc1qXgQGPOJnjZSOB4k2RRR2w2NGpYZ2XPHhGxVX48LvnSK5q+ki8W73RiQL73hb9GcexzOCzCFBL04rumDxadVmwj0sW+HTxo7DeQFY8fImmqR9prAn2+6lDqiX0afbsxMBB1r9d43KYTIzxhXANPk94dHAamuedwcaGhz0HM/jDEIStmEjWdm5ku5SkFtaOPor45G1Cw64EjL1iGnjkLR/9ox1LQQoROsN954rpmqWxFVQ/OImX23kMLK9pPmBxmBo35hH8fKKuz4rAB0rjmXj1uOnYJ6GEatTwf5B0o1dG1ADY5rG792BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 11:38:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 11:38:50 +0000
Date:   Tue, 15 Aug 2023 08:22:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZNtgD3LKwS4eatoe@nvidia.com>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck>
 <ZNUEuIlPmrckwMyn@nvidia.com>
 <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com>
X-ClientProxiedBy: YQXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d33607-8776-4555-6636-08db9d843211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0R2ba8NBEZ6RwI94na6U39uBDqZ8RiFdmUJQI0YY46TzCYb7/nvtqrEUtro8mx0x77h9ZEJvo7Zs7f1MvVrdMKbL08ziKOZ5jrZSWAEKr9wmS74cbB80578GTpTKaj6eDXKQBOomYr5L+mC939sg02xC/QyVv5GhS5oih+aG62opiuNEwVTgcchF8mqBgeGnHcbGo+ius/5511atKn3eV4+HFrNGYJqfSPsl9EbDMT+2IGklba1VSY26pmcPZSK3w4+nJibM1oEjpFqEvvfZEvsSUOd+3v+qbHAsS4vPV9JbKYpjXLJPpDaf7CL7ZB4IAQ4gVvRpiJb9SmIfI84/WM/0DzznAMppSYe23or3Bl6LucHJORXf5lhrlmtgr7/AKKl3mOpFeQqR8yigQEl0IudbbkBAMxPtbLOCjsA+tykiArrvEpQ10OUi9HU1CsUVxjiMNTImLDGLgcSmMM2F8RRP/d2FLMIgGj/XfiaqOUChpuKU8idGqcYtVUFJ2uKPK+9KJ/7DoxMOiuFZjmNobitUKDkKsXOMkw+mGjPN66H2Ht9+EmrcM1A7UUXCW8T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230029)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199022)(1800799007)(186007)(6512007)(2616005)(26005)(478600001)(38100700002)(36756003)(86362001)(5660300002)(8676002)(4326008)(8936002)(316002)(66946007)(6916009)(2906002)(41300700001)(6506007)(53546011)(6486002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBDMWJqTlhoQjUwRklPd1RsRjhXejF3bFRFS3lXNXQwbm1WM0dVdzVTcFZJ?=
 =?utf-8?B?VW1IYUpkTC9HY2M4c0lpelJmODQ1T3pHeEhMSm81a0ljVm0wSkI3ZXR3bm9a?=
 =?utf-8?B?cXZMOEpGazRvcDNZdW9iY1RSYk56dkFVODU3UTJ0RjY0Ym1hSlJUWWJjWlhK?=
 =?utf-8?B?NWFydmlTNjBHNkd4MkpWTzRicjFCbVJXQnVWWDA1b0VmQzlqLzFjV0xDTHll?=
 =?utf-8?B?bGxDL3JvWFZCbFhneEwrcWl1VW5wN0VrcVBwa2ZkTlRBUU5qL3crR3FkYzF0?=
 =?utf-8?B?S1pzOXdhaC8xT0orRGVBSFQrNml2TkpYcWhQY212N1ovbGZxZG5RWVlJQXlu?=
 =?utf-8?B?eVg2RUloL0EyWDV4VlFJQ2RJN0x1TUNvUDd1ZlBxbzZIMW1mdXBaWDE5c2xS?=
 =?utf-8?B?MmJDdFVtSlpsc2QwZFJtekI0NFpmVGpSWGptdGR4SUxSbWc3Z2hlQWlJNTA2?=
 =?utf-8?B?NjAyYzZLQWZSRU9Yd3BkeXBUMmRNVElTNGVHeG5adlM2elIxMmZtTVMrcGkw?=
 =?utf-8?B?SGpZN0VhdVdtYUgwVjZDNnBlaUpuaVdvZnBIOElnVEN5R2g0YnN0Y0tjaVR2?=
 =?utf-8?B?MUcrZGo0TVVmUXFrZUdnNVlGZzNyaWdCNVM4TjhqNE1UR0tqNmRqckhhaURR?=
 =?utf-8?B?dVJ5c3VSeEZpNTl5QitWYzV3eWZwbDRCTDZGYjkwbnVna24zejlJNDd1MkRi?=
 =?utf-8?B?OUtKdlEwN2ZlR1JsSWxTMis4NE9JTXJWU3hjMW02NWN3SmU3Y1Z3dzlZbkNZ?=
 =?utf-8?B?WUpWSlRRNVFrMzhycW01TXVZVmlxb3lSZ2JQam1zV2pnenFBWjlHQ3lwamtT?=
 =?utf-8?B?OEdEbHBOR3Q0aXBNUXU5TEJIVGFFOXhjN2FPY3VDK3AwZDIzSmMyVVdRbWJh?=
 =?utf-8?B?ODY3UUcrWW9BajdWUWlPRTBXcVJXbStUNFM2dEcvRlFvVVJPbzFHLzlraG8z?=
 =?utf-8?B?R1pQM1hBR0hGRTJGcUU3VmxONHpFWFhJWFJMOWYxTCtJWnpnQlRWcFVqQUx1?=
 =?utf-8?B?SkdvZllzc3JRcU9oOHhFSzgxVDZHejdQVElDSktMVWV6ZHNYUHlSb2tzYUxG?=
 =?utf-8?B?VytFbHJ4ODloS05neWwvVFRyRHFvVzNqci9CMm1yam1lTjhoL3FtQndYdkRQ?=
 =?utf-8?B?Tnh5Z24xaUxFVm5sMHlUUmpmbk1yV2pUMXJsU1ZiRVN1bFJYd0QxZU5Pa1BK?=
 =?utf-8?B?Ni9rVGl4U1d6WHJ0VEg4anpZSDBtaDdPc2hYbkRMQlBDNlBPbzJwOUY2MHJH?=
 =?utf-8?B?WE45dU1rUXVnL3NsZWVibE51TjVzeHQ1YWo4N01rZjZVcFhPYjY3MVRmT2Iz?=
 =?utf-8?B?djI5bjdsc05OemNwd0Zvcm9Cd2gzOUJkbDRyelR3cVJaVk5leGxhZGJLKzRh?=
 =?utf-8?B?eVpXSG5ONXFia0ZENmRvbVlUT1Nia2diS2hjRFJaY2c5dC93a0lQa2tWK2dY?=
 =?utf-8?B?eG9IQ2RHSzRNc1NJS0xvWnlKelpTWGJaTWtqYlQvQm5CYUw2U2pnbG1XbTFJ?=
 =?utf-8?B?R0dPTTQ4Uk1IQVhzMFg4R3ZwcXNTdHJ6L1M5QXpwdnJYK1laelJvbXA5ckhV?=
 =?utf-8?B?d1Y0dWRtYk1yeG0xTTZoOHdWK2NYK2R1MU9aSUtVN0YzZTdGSTYzbHh6ZGxY?=
 =?utf-8?B?d3N4ZmZURDhzdzFsWC96YVN4N3BRbDRBWitUT3BBY1pZTlh5S1JMcWxoRHFv?=
 =?utf-8?B?Q1BoMXRQRno4UmwxZGVOQjRGUUxjR3ZFZDVxZW1TUllZVzk3MG1GUXRtdG56?=
 =?utf-8?B?Y1V0NkgyQ0FyL2IvU2FhRjYzWFQzSU1xUXI5am9SYlk2WFlSZzJrOWY5bVhW?=
 =?utf-8?B?c3hNYjc1ejg2TnViVGxLUDZTTVdZckFtTFpMY0ZDNWRuUHo4bDgrb3VQYWNm?=
 =?utf-8?B?R3ZMZ1BhVkM3WTduRHM3L29RQ3lxYU5FWkJhWUIwazNORzYweXA5WGkzekV4?=
 =?utf-8?B?cUQ3Q0N1NVJGRnB5eVZRbFZTZmZsdmo2QTBmQmNqYTREQ2lOd2IvdlRwQ3RX?=
 =?utf-8?B?SHJoRmpabDE5T3FsaHowK0xGMnhJZVl1bzZFRlFSWHRVcjhFcUJ2Q3Bkc2VO?=
 =?utf-8?B?UXpsUEVJdlFwYU1BSFBjV0xhNHkzeFJUcHp5SHFvVnZQTStFbnNQdnNXSXdF?=
 =?utf-8?Q?8Ckzag6PbzwOZJesz2HLFkTKW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d33607-8776-4555-6636-08db9d843211
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:38:50.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uNmvP+h20LD4cw9xgQuk+p9fPIUf9l2Ta4Rjnd1c3JQjZKwOy8ahjhvfk9672TM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 01:20:04PM +0800, Michael Shavit wrote:
> On Thu, Aug 10, 2023 at 11:39 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Actually, I don't think this even works as nothing on the PASID path
> > adds to the list that arm_smmu_write_ctx_desc_devices() iterates over ??
> >
> > Then the remaining two calls:
> >
> > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> >         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
> >
> >         This is OK only if the sketchy assumption that the CD
> >         we extracted for a conflicting ASID is not asigned to a PASID.
> >
> > static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> >         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
> >
> >         This doesn't work because we didn't add the master to the list
> >         during __arm_smmu_sva_bind and this path is expressly working
> >         on the PASID binds, not the RID binds.
> 
> Actually it is working on the RID attached domain (as returned by
> iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
> here...

That can't be right, the purpose of that call and arm_smmu_mm_release is to
disable the PASID that is about the UAF the mm's page table.

Jason
