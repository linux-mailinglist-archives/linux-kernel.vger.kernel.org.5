Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE677CCAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjHOMbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjHOMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:30:58 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5801173F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMDa4FYWbGHIteQiSwXcF+EcySWwtraSqpnNDE0Mflr79/2vAuLHncqjJ/KwMaiKgJdp/NAo2MXlfHr/BUCQyC0ZntTWRfHF0gximETATgID0Z648MCTcrHuGNhA1cVOK132RY5E6SyD1Wq3ZIP6EWWp30MmzVGPiD61RVnTk3ssdGxYRU5A10TJoGQPUIBYcbL6J7kaEjF3E8yz0kgLqQD0a2Ecpra54NBG5lIg3lWOfrj4hu9Lv1PDhX8k+3BFu5JYl00mO6pFiBl30tvPLJzE2lzASenaD2wpmd3ntyjREFHr1ZYBomwxirM2OMzsx8qV/z7pOdd94r2+FpWUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctGlO12/XsLAROApewDezfgeJWnXtNvS9rA5cqH3/Bk=;
 b=ZndnXR0Vp3p0JZgYAk/AcEyewSpubwYW7+8eG53BY3kdPdAbMoJcx2HBu82/j1jx0XdB5hBeNHqmST8ZZ1TzBe4so4xMnCvk64F5Tl5D1oTsnMoJcZ/TbtMnaQf+sD8hWIhzUw4xMLUrRxPbJ/RlDbDduFAtOBZN0Uete/Y5eFMLnI1EjQ7UgADIEvFM98uJmedNS8/cpsZxDKaN7LvcmOMdjyqyKcDvNL3qDi95Il2ysOekOo4ia+WVQ2X3jjEaiJ9GS1oYQmKPkGY21OhbwoVsm2gaoYgwCA2dwJ9MERnR8Fnlo7+h5LlHyxBrITn0RWYA3erBlBWTk5RkfIwDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctGlO12/XsLAROApewDezfgeJWnXtNvS9rA5cqH3/Bk=;
 b=ElhT15AXHvj+d/ZrXmsWqeiAoLaE/uYslXiLjdQduWCoQArNNwVJeGVJ/qd583YLO25qMb2NpnDbhQ/5HOmi4366VPJI4Q97u7EYEiedHtLzELPhhwjuQ3pJEt0XEXv8KVbr/hKxwiVe5G7+TqRVULW+xHEZsdFBatH7MX70/uRfCgsQzBN/nQytr94NXSMu9suiFsPe02AyDYEgBJW3FNLRl5FzxVO8H7p1mUcdAX+46kSyRMdjE6B8l3NI3Lf3rAbozMFlnsE4BZMmvYzeEevcCgcOGGoxXzr22XjRGPB+VIxk91GAj2TagXTTphFoxc7OzAv872v6tMCL1xjNjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 12:30:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 12:30:52 +0000
Date:   Tue, 15 Aug 2023 09:30:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZNtv+vLTOl43mXYv@nvidia.com>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck>
 <ZNUEuIlPmrckwMyn@nvidia.com>
 <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com>
 <ZNtgD3LKwS4eatoe@nvidia.com>
 <CAKHBV25YKMGnAs2L0a5EwdaXrpwb9RPJqBcJjO6ahD7UMgEd2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25YKMGnAs2L0a5EwdaXrpwb9RPJqBcJjO6ahD7UMgEd2Q@mail.gmail.com>
X-ClientProxiedBy: CH0PR13CA0041.namprd13.prod.outlook.com
 (2603:10b6:610:b2::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 1800da34-cf70-44b6-50f7-08db9d8b76ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lEE+LzEBY9iGIIi0Dkd52+FV2bqTk2xKr370nEhoNgmEoWsVujn+A86NBeQnKcUMugD8MpOvhVF6AIpa5BPeuVvEztTdGvNfnJJHAgSm0Mr4nQxoIKEhr/3hH0ud2DFKO8Ux/jTtKPbDN94HZqGd2Ee/hyJKuX8RbDshfCPewJdyjtK2YX4dO7HRjaj1zBXdaHyHCpo0zmL8HCQFE5kFnigLRHBOmvd9YWIiN3Z9+/MQ1vGsL6PSI4HLfvlDRRhPzsdPg80Dvnjd37jmtGYBSP9cqo+ooNdcEt6fCgdmIz+DarwUfBwpDM7L2jp9OQyCm/FLKA8rImc/m5pf7CcUmSKE3e/KvERHYHQ6Tc6Mn+xbEimaYDaZyO8Jh9kcGeUz77dWulUxH26kR2qpDA5ap0uMtpfrn2U3c5jVzMJGtk9UVxWCSH6sSZ60gvIP4pExwKph7QkafLjjwcTD48s7i+N5jmIU1Z1AJ2sS2fNSEJtivTgavNemAfYTO0qmctDds0c0kHwWC3XMmqzGun65Un4tjNN01wvvKErMXAPslBrC/+4+k28CLrl6DJEFbucD9LazklsVqUwMEp6sZ95wAN+oJ5EikuFpIyxKSndwXJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199024)(1800799009)(186009)(478600001)(6486002)(38100700002)(86362001)(36756003)(2616005)(6506007)(66476007)(66556008)(66946007)(6916009)(316002)(5660300002)(41300700001)(26005)(53546011)(83380400001)(6512007)(4326008)(2906002)(8676002)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytnNmZyaWFacjdwQjNkdW02ZGd0a215WGJFZ01kc200VjNES1RqbnQrNWIw?=
 =?utf-8?B?MVU0U3VNU2E2ek52bk1FSU5zc2ZEdmNpbVZzcVZ5L21kVXhpdFlkd0p0MGFT?=
 =?utf-8?B?RE9rS08yUWdyNGQ1RUprbXpjWVUwVDR6MTQ3dkxWUHI0ZFZDbWF0QkpPMVN6?=
 =?utf-8?B?YzVuaWFEZjZPcDIrQThORmFzeFJiSjVBNnFvVUVGVXp4UVBkWHd6bVZwK3Jr?=
 =?utf-8?B?TGpWbDZScURibmxDb3d5RWF0aGhvRnV1aVFLTTZLVWtaK2xyd3lCY3MzWkdT?=
 =?utf-8?B?RXZORnRFV1p2Yms3dkZ1UUZMTS9Ib0tIVnVpQ3VscXVqcHN0NW1ERmt1bEFE?=
 =?utf-8?B?UTVlclZpQXJOaHRxaUc2OTNFMXVxVUR2dlhxVkpQcUxWdUxWOGdxK1BFSVgz?=
 =?utf-8?B?TVJ2L0J2SE1jWGlKSEtkeW1XVUg0NWg3b2F6ZGgxb1IyOUdLN2h1Qk0zbzNM?=
 =?utf-8?B?b3E0a3V5NFZ4cGRrbGVTOTFUWUVpMEptN2Fna2E0VXMwbVFIeU1UUmdDaDVD?=
 =?utf-8?B?a0pqOGhrZSt1aC9mQlI4bWcxbXZlZTdwaW5XNGY0Mk1kMFlRNnNYd1NJaVVB?=
 =?utf-8?B?SFhwbExWcmRCU2Q5NEdwelRwQTkrK2JGT2RWMXkyWjVEY3h0b0VHVXYxTUxt?=
 =?utf-8?B?aTk0UitzNXlGL29kb0t2aG1hdUE1TjcvbElZNHpDYnZpUnhGdGcrQkRpY2M5?=
 =?utf-8?B?RVJzWk54eHRmTzlOYzQyMnNndm1GN2k0ajNUZlBNUC8vbFlEdjExTjN4b01V?=
 =?utf-8?B?QjZ3ZWxwWkdBWkszTXZrQjB0Vzk1VHc3a2lOYld6UjhqTWtkWEswYmNTTnhP?=
 =?utf-8?B?YXdjaDQ2UkhtMFg5L3UrT2ozZGJqUzgweXlNcUMzYVJYSm9TcFE2RlUra1U0?=
 =?utf-8?B?RTRLMWRjQTlIUUV1M3ltd1hRNWwxVXlieXFGQTBrOEJLYnFERG1veXZ5K1Bw?=
 =?utf-8?B?N3MwKzdQRWVaSnFTTThsNkhIaWV1dlI4ZDJEQ015QWNYV3JqOG1peXVjQ1J5?=
 =?utf-8?B?VVdJZzRVTUlIMHcrblMxK3RNWEc0Z3p4VU9lT0NHYTRvYzc3bGNpNE1JS1pp?=
 =?utf-8?B?UFF6N1M3b3UwZ1ZnVUgrZWhWakVSQzJ1V1l5YjJXUU56VXUybUU0VGlDOEVo?=
 =?utf-8?B?anp5TGNZajdiemNBM0E4eHpVRzVrVlpBcmxybHB6V0hheEdjTm44UU5vY2NF?=
 =?utf-8?B?Q2cvUDg1SE41WTBTMlR6WWQ3QWVNcmNqbnZBTUtZeDg4OTNaYzZSQ3lYMjJo?=
 =?utf-8?B?djFVL2dNT3ZpaE1waWQrQmMvZ1BoZ2RxeDBXa3BWT1NWeFQ3R0p1ZTBYcEls?=
 =?utf-8?B?ZzV0RlRhY0JWTmV3ZWkyV2F2VG1wYitTblBvbTNBRFo0N3BacERqRmR6eGJn?=
 =?utf-8?B?NFB6QUFLNkZBSHBQSGtYZk9pMWhjaGFoQXQ3OGtlNzRTNTZHV1RLRjNMaUgr?=
 =?utf-8?B?ZVFNbU9OQ0FLWWJvdG1OdjRFNWg4YnE3VDZqdU14UEZyVitYU1Z3UzlnMFdq?=
 =?utf-8?B?SGFJeUZsaU1PWVhRWW5wWUd6bk9sUzk2bkhWdUpHT05sZ0lqNDJDaFFGTllE?=
 =?utf-8?B?cExJVkg1cWw1UGFOWkVlOGJTNzZTdWR6SUZuamdlcit0Zy9Kd1lDNG5jVXM3?=
 =?utf-8?B?WlQxZ2tTTEh4a2xyYjNXeXo1Q0tzNFlLaWoyd3hXb1VINDJySVFoQXNyWmx2?=
 =?utf-8?B?NktiRElvNzFKZHZmVlV4NWN4clVzQm91bEl1dUNEd01BQW5QS3Q5a2JEeVRj?=
 =?utf-8?B?MjNOYm9kMEN1aWplYzJZYzQybTJ3SUtBSllROHhZekdhUW1uamtGSTYrREhq?=
 =?utf-8?B?U09lSmN3Q0laTER2LzVGQnZYcnFmRFlVdHRPSkhRb3krYlNtekIwcFh2VW5w?=
 =?utf-8?B?aUk5Tk9xc2ZqUThKY1FQc0t1KzhPczlNL1J1UnpkWnFGWWtoSTB4ckEvSlRa?=
 =?utf-8?B?dVFZOWVtKzRVTlhEck96bk51eVRTa0tqSlQ5TWJvZGpQQTB4eVVDWjVaaW84?=
 =?utf-8?B?cUtIYnBSMXZEaExqSWhBcnp4SjBMbFNuUjNqMlZybGRHOEpVTFB0bFA3M3R5?=
 =?utf-8?B?ZnpYY3VZOGJNUTU5TUFkSUZVbkFZU08vUkFQTUpwa1d3QmtUZmMzTU1PWlhR?=
 =?utf-8?Q?BhwQmo0HOPLT/75cmstZa106T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1800da34-cf70-44b6-50f7-08db9d8b76ad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 12:30:52.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTiIqpyChUYOr13fm3Ih1mGpxT+GU7mKp6Rp9Qf1I54Oq+oyQLPkiGVhuSBMd2jx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:03:40PM +0800, Michael Shavit wrote:
> On Tue, Aug 15, 2023 at 7:38 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Aug 15, 2023 at 01:20:04PM +0800, Michael Shavit wrote:
> > > On Thu, Aug 10, 2023 at 11:39 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > Actually, I don't think this even works as nothing on the PASID path
> > > > adds to the list that arm_smmu_write_ctx_desc_devices() iterates over ??
> > > >
> > > > Then the remaining two calls:
> > > >
> > > > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> > > >         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
> > > >
> > > >         This is OK only if the sketchy assumption that the CD
> > > >         we extracted for a conflicting ASID is not asigned to a PASID.
> > > >
> > > > static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> > > >         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
> > > >
> > > >         This doesn't work because we didn't add the master to the list
> > > >         during __arm_smmu_sva_bind and this path is expressly working
> > > >         on the PASID binds, not the RID binds.
> > >
> > > Actually it is working on the RID attached domain (as returned by
> > > iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
> > > here...
> >
> > That can't be right, the purpose of that call and arm_smmu_mm_release is to
> > disable the PASID that is about the UAF the mm's page table.
> >
> > Jason
> 
> For the sake of this message, let's call "primary domain" whatever RID
> domain was attached to a master at the time set_dev_pasid() was called
> on that master. That RID domain is locked in while SVA is enabled and
> cannot be detached.
> 
> The arm-smmu-v3-sva.c implementation creates a mapping between an SVA
> domain and this primary domain (through the sva domain's mm). In
> arm_smmu_mm_release, the primary domain is looked up and
> arm_smmu_write_ctx_desc() is called on all masters that this domain is
> attached to.

My question is still the same - how does arm_smmu_mm_release update the
Contex descriptor table entry for the *PASID*

The RID on PASID 0 hasn't change and doesn't need updating.

Jason
