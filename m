Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E322D77CD06
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjHOM5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjHOM4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:56:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55601E63
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/3xihgaWDOElOMSw4sLnj0V9EC1rTQ0DXXYt6Xi7mExaJKhzaKZiKFfNxHfH+F1xLL6z99FmxJT/0pKfFRcWWqWJckjkbO33x5Bl0t8phcQCEQRB08gAzG8Z+UTmldnwsACKvMVKgFrFBmHqTI/NjWi3JVcTYYX1hU2SqItXAr1yKy3VTDkRUSMtqreg9WBaZGPkJ+ztA2vjw7GKRXQVeNZB+8WBfgu3t+Q2IU4lDm6SRWRgwHy88LFPBd8AeCHmjDrBjG0eDJeJri/e/LxJN+3Ml8dBLqD3I1ztW4UFT9rnTpxUxKsZK5bdBQv09WMAQnd4gRQVGVi3EaV1zTOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUNH6uUIV66gKpuscdNVHrlWNHgjiJrnWvVbP7w1mj8=;
 b=UOBI6kvVN7Vodi5eYXRmcYn2pu14weca9/JwzxkWJGjHxKbNvuVP8cGgUx3ZsQ/9QalnXCCVbfQOjOC31mORK4pCXgupQDXKmKcuuxLQw2y8t7hzNQ9NtkApJOgDloZqIqvSXi9KU2Sb5jCJHuy8pIBC7c6cloELU8Bw8hMNKwRo7MaFpO+dDDNBGeLdawXRcKKV5mcPwVJQoOsBOgbYLLruLIqCkG9Vh+UfU5XyEvpNtZkAEw0DXc6CknS8XY4J70oypBqH81lOGKZ9BrdYYZkB7V23KwCFLiUIPK3I05J7MZP3rx2EfitmxjlkCG9V6lYBOYYsLHWRKoShgTtacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUNH6uUIV66gKpuscdNVHrlWNHgjiJrnWvVbP7w1mj8=;
 b=VcbYGv5yQ/7UGewxhBZ9NQUf9v91xai3hx1e/4Q45nsKr3InjVOUp2GNPyC/3oDsBLc4xnf20hDoM/vmRM43TlKSMrgm3y0NoQEY1EYmmkp/fEYEIbKlAMggJfJPsdCmi1enJxfaYCR84MNPL5o12AeRQ2uB5zPmor5thFP2jT8JzZk07BdOL4kQxlg2BmYiSHZps/TLmIeBulhl9Cgab4ZRAM2gCSNNX2xDZbAcYbtfkXWI9Xm8r9MXjRxTsHDbRdR4xOdQeApLo6q+bmyuPlmgweCFSJ1BNM7oomVo7IAiBJzS1IFGF8QbopGBHkWa9WOdrHsGf7iBurSYYA1mbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 12:56:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 12:56:26 +0000
Date:   Tue, 15 Aug 2023 09:56:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
Message-ID: <ZNt19yHTdPOhk4Hy@nvidia.com>
References: <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
 <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <20230810144051.GD5795@willie-the-truck>
 <ZNUEuIlPmrckwMyn@nvidia.com>
 <CAKHBV24SLBNw-yWn3m6BtvvHUgD0h1e1QkEb1LrUcWSwpR85Yg@mail.gmail.com>
 <ZNtgD3LKwS4eatoe@nvidia.com>
 <CAKHBV25YKMGnAs2L0a5EwdaXrpwb9RPJqBcJjO6ahD7UMgEd2Q@mail.gmail.com>
 <ZNtv+vLTOl43mXYv@nvidia.com>
 <CAKHBV25wD2sU-pVWsNBrJRdhDvmt41hWST7sr91qrVbmtkSZdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25wD2sU-pVWsNBrJRdhDvmt41hWST7sr91qrVbmtkSZdg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: f856c477-984a-4850-f1ee-08db9d8f095e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm1rFqV7K2JHovMqpf3A4xWDzvHTrpo8LrPzH5ejpQ7blhae7G9MXX2GMbVQAx+MO4iRFBXLD4HsJHYdHg9Wofh65KDKPpvGAtP+juBSXDo5SBOMHjvBOOOdq7pENy8vJ03bL7r75Wrl2NLcJtt4/quQIa9Zmw9EKG+hhP6ii0R9J+dpaLV3LUYnWrjjzi+jOhPLCkzAHEYy18qW5o4BGfY/uQCQO7UPu363wj927yr6rzdIj0DUoSHmeW9jVdyKU1DzSQ7s3AdS1Pv9cb3XdiiuNFGOyUVQil8+Ky+O6vQjdL1bIJ+lB7ei6dPI81UCzYN/GGxL/GGlhGlEwfHziM175qDQv3iWTsyKEluh/kiLkwEPAhUuT+xI+lud0gwyCcsh3ZBBlZkXVMwofytnz6DASWjLyspYhs3639cdE3k5oH8eV5bHpwH2pqFBcfbxSuDwiWMijrLk0pyEpeny9T9/+7WGArc91vku4cR2keiG09dDNdVobJtcTu8XjkMtMELQNA+lBX4r4xO5taL7/qHFXdsCwfRaXqebNh596LBu2Wi5WIEGn3R0s68IrzFM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(26005)(6486002)(6666004)(38100700002)(53546011)(6506007)(316002)(66946007)(5660300002)(86362001)(36756003)(478600001)(8676002)(4326008)(8936002)(83380400001)(6916009)(41300700001)(66476007)(66556008)(2906002)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRBU1V5eWluWHZXVWtjMS8rQlI5aTJzMW5RbFhsTG8zZHdWWm9LWm1Telox?=
 =?utf-8?B?a0JmbWcwTld4R0J3RDFPa0d3Y3M2ZUpJa2lJa3NLekhVeXQ3S2pXakxEazlP?=
 =?utf-8?B?S1FucDlPK0x0OVUrVWwrWStYTTV6OUJZa0ZKZWhMdUdZVWVIWFlGTURLT0V6?=
 =?utf-8?B?TGp3Rm1EaFhMNnNkODNDMU1neVVxZ1NNay9IaVZ0MVZFbVNjNDdIbUtEOWt3?=
 =?utf-8?B?Y1Y0b0JEN0ZmeUo0ZGd0ZmJ3RTViY3lGYWFPcGQ0OGNOV2RPZ2ZzQXIwN0NS?=
 =?utf-8?B?bHBHSVN5UTdmNEdueG9iR2l3dHhmRFJBY2oxYS9hWmxiUHpXWHltbUZ2SWFt?=
 =?utf-8?B?cnFFVWsxYkxQcVkzWHUxOUN1cWJhUG1NTXZQMnk1b0tBbkEzVzFCcWVlSFVI?=
 =?utf-8?B?a3FObEI4OG1qa2tNVk1GTVV0RlpvVDlWTElEZjBZRzlaTUtWVWJhN2MrNWFT?=
 =?utf-8?B?Y1BscWxiaU1WK0pMcE5UYytVMUxuR01ES0xQR1pldittS285RFZGYWlJVklS?=
 =?utf-8?B?cnRnMUJNNVl6cFkrOXhiK0NZN1BXOVp1Z29RdXF5K3RhOXhNYzZFQkhqaU14?=
 =?utf-8?B?YUVZRjdHeXJXNThlYzhsdzg3Q1d5TStNU011bllqSnVFWGdkSFdYeUlYRS9Y?=
 =?utf-8?B?LytuTnNMMmY0SW8xTlhOYWV6WklhdWNOVGJ6eCs4NDZmNFdQT3pCYU82WkJl?=
 =?utf-8?B?azlmQ2NNQlpNMUcwekJTTFROUkswYm5WekxrR25mU2FYV2R5TTl2eE9raWxw?=
 =?utf-8?B?UThGZWxjZkN6ZkJac3dCdWdDSWttS1dwSDh6TVpZamRpRG5zdlBMdTF5YVdJ?=
 =?utf-8?B?UGgrcFZtdVp4ekZWNzJ1MHRTSEZhMzFvaWxFMk9Kc2ErN1ZQSjE5TExkUXp0?=
 =?utf-8?B?SkRGblhEOENhUVd1VURJb0dnWmlZaWI5VUh0WDZLeXRuVmgvUEJ0UzdqRVFz?=
 =?utf-8?B?dnJjZXA5K2Uyckx2UDFiVUdXWXU5YUQ2Mm9ORm5jUFN5RFJJT09kY2xVRnU4?=
 =?utf-8?B?d28vUTFvdUF1S2gwNzk2Rk8xYkVtTFJlalBranIyRHhqdnZkNUhHNnFCbjZt?=
 =?utf-8?B?TEJVWWZFTHRuYnh2aWRyUitSWU1vaitONFY3ekF2d3NEd0ZKVGhQNWcyN3BW?=
 =?utf-8?B?ZUg2cmRkbllDUTdKWkFHdC9RcWpyd2FDU3NMSkR0QXpPYW91R2xWM3pmUlpa?=
 =?utf-8?B?UVdsZnlXZUYzT1RFRldKVURnTFBCamNWL1ZxVWNwamR1MWU5OTV5aE1lL0kx?=
 =?utf-8?B?dWRuTVVIbFJDKytiUGxFSUl3OHJNQkYyaExYc1ZJd0Y5V3JJVmxYd2ZRT2hk?=
 =?utf-8?B?d1JPbjBlOE85UDJJMlVsOEhIRGZSRE9NZlpXdGEwMG5FVlZRVFR1empsMXJF?=
 =?utf-8?B?TEdxSVRhajdtd3pPWDBqV0Ivd0U0QWx0bEhTTXlMdEtEbitHcTN0eUpnbTRE?=
 =?utf-8?B?YVZmMFgwQU82UjFQZDZRWUZVZGFSbnhPQW0vdFZJR2pxSFJ1THpVM3ltdlBo?=
 =?utf-8?B?aTVmN2xUMDRrcXBTckliT2tnM2cvT0dkUm9PZUpwdmVXbnRwemE1VmZzTlVX?=
 =?utf-8?B?eWdLYXp3ZlA1Qm1PODUwSDJJSHB3RU5lOWVnNzh1R2hvdXl3dStMR3N0eFF1?=
 =?utf-8?B?OVdCRUdXRHdvRk1wZUVnZmxlVkV6Yit5RW1idVNlNlQ3YTV5T0tHYnBuTlRZ?=
 =?utf-8?B?eUZHVVdhUkNrZjhyVCtIWUtCRDBmM1d0dUpFVmZnSXYzbVFCa0R5RHN3V0hF?=
 =?utf-8?B?QTgrSHNMeW1xSGQxTUNzWjk5T0w3czdqWlptT3VMR2xLOGpwQU02UGZOcndy?=
 =?utf-8?B?RnpzdnFrWXYxYnhUMWJVeVJGcVg1bGk4OU1vU3ErV0MvZjhRRWdCd3huOFBC?=
 =?utf-8?B?MkVHeDVMZzZsL2ZSc3JyenBNQVExajNkVnlZeEMxeHQrWC9RVVQwK3Y0WWVC?=
 =?utf-8?B?NFVrR29OQUVwOXFkUlhyMnF6bDFQZjBvQStRcTNTUVZwa3Yrdk5PblZPaWtk?=
 =?utf-8?B?Zmh6ejNyMmYzZXZaeEFDTHdrTXZRZE5pQ3l4WVFHQXhZYURaaXF6M1VzeUkx?=
 =?utf-8?B?djJuK09uN3NRQTJCUUZzTWFSdE5abUQ1VWdDYi93TXlrMU5ueXFRanNWeVYx?=
 =?utf-8?Q?XjxEBnQzWO8WhX1IPU+64WOOi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f856c477-984a-4850-f1ee-08db9d8f095e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 12:56:26.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 740tJwG/FW2yS+LP7H4/tFm9ezztxia1Xg77e+pRopX/Tst0nYy+C+wyUktMQfga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:36:55PM +0800, Michael Shavit wrote:
> On Tue, Aug 15, 2023 at 8:30 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Aug 15, 2023 at 08:03:40PM +0800, Michael Shavit wrote:
> > > On Tue, Aug 15, 2023 at 7:38 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > On Tue, Aug 15, 2023 at 01:20:04PM +0800, Michael Shavit wrote:
> > > > > On Thu, Aug 10, 2023 at 11:39 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > > >
> > > > > > Actually, I don't think this even works as nothing on the PASID path
> > > > > > adds to the list that arm_smmu_write_ctx_desc_devices() iterates over ??
> > > > > >
> > > > > > Then the remaining two calls:
> > > > > >
> > > > > > arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
> > > > > >         arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
> > > > > >
> > > > > >         This is OK only if the sketchy assumption that the CD
> > > > > >         we extracted for a conflicting ASID is not asigned to a PASID.
> > > > > >
> > > > > > static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> > > > > >         arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
> > > > > >
> > > > > >         This doesn't work because we didn't add the master to the list
> > > > > >         during __arm_smmu_sva_bind and this path is expressly working
> > > > > >         on the PASID binds, not the RID binds.
> > > > >
> > > > > Actually it is working on the RID attached domain (as returned by
> > > > > iommu_get_domain_for_dev() at sva_bind time) not the SVA domain
> > > > > here...
> > > >
> > > > That can't be right, the purpose of that call and arm_smmu_mm_release is to
> > > > disable the PASID that is about the UAF the mm's page table.
> > > >
> > > > Jason
> > >
> > > For the sake of this message, let's call "primary domain" whatever RID
> > > domain was attached to a master at the time set_dev_pasid() was called
> > > on that master. That RID domain is locked in while SVA is enabled and
> > > cannot be detached.
> > >
> > > The arm-smmu-v3-sva.c implementation creates a mapping between an SVA
> > > domain and this primary domain (through the sva domain's mm). In
> > > arm_smmu_mm_release, the primary domain is looked up and
> > > arm_smmu_write_ctx_desc() is called on all masters that this domain is
> > > attached to.
> >
> > My question is still the same - how does arm_smmu_mm_release update the
> > Contex descriptor table entry for the *PASID*
> >
> > The RID on PASID 0 hasn't change and doesn't need updating.
> >
> > Jason
> 
> arm_smmu_mm_release looks-up the CD table(s) to write using the
> primary domain's device list, and finds the index into those CD
> table(s) to write to using mm->pasid.

Oh.. I don't think I caught that detail that at this point the
arm_smmu_write_ctx_desc_devices() argument must always be the rid
domain. Maybe add a comment to describe that? And lets try to undo
that later :(

Thanks,
Jason
