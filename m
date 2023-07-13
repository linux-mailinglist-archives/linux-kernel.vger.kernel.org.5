Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409DF752E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjGMXsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGMXsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:48:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8832707
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys7qK4MxXAEiwylknSjOnwla6aSQ/frjFmbbYT2WhvJGWyF0rN5I+gonj9IbIVkgkYPpw8WBn2dmDWuNVty3zQLIsLKLDFwWn4HJHXv0SOGwlzbZbJ31zhlrE6tabIRwkPOY9o97gWw74AbTXXPFTq+cbG6fLVWbfnvvp5fEB9I07284mUlkKTTV2JuqssZYSxxfIxgfIHaOQk1bBViJip3jIktH0GmehrG2VPUb5jn+1FU0cHC2yd+YmmYWgCBbBpuPcX7SlT4Dp2m0yVY5KZuk2qrqDTlrC7MtvXOPJxLOfBG7svR5BKmadi9DFVTirQ0OksgVJAVOKd7JX8CrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3WWQBRpxt3DfdnSMFPhLRDRLCXXBuI8MnlBdsk7dCA=;
 b=R6qPJx1tcKdvAdHuX15RGsiMIECmCKvXlzqItIEz6jrdLwSiwhEmVGKgywimdfmDkU2Jpt5hhbvDjm2uZHmYCJ7WFuY2WG2FsVrLDBWDqcf9iry4sHtH6fBGn4WYch24tNTJzoE7VqQ1ZXwrrXF8o/hUvGIqkE1z2RmYWOXXUXHEDxOk4su1tcLv+F/YhTyWGYQrpTftJ4utd0k2IHmbbKZlMg5fP0dcRi6+0acTJENQOmfr/eSc9UlvFpzpC6HYfWhp7/IXUVxdf5L2S7fodRr53J4/ctsfBHwZ3T8hwV3pcazdawURnHtSvJEH6YdVgJqlgxcdhKLPV3/yeztk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3WWQBRpxt3DfdnSMFPhLRDRLCXXBuI8MnlBdsk7dCA=;
 b=r60YcwJh8rBDGLYEBovp8Zzhd9IPvGnKriNBD0lY29ejl8emk5R9PpctoAeIIBqhm6q1UvFy0h7AnSrK9qnR6Mcexh49RclzS67LO+ZCdcjGxhq1OMSyjW5h5UPqio9NuLtDOlbZxJc6DqN3rvkfUAfynG7qaXS8h+j0G8p6l/GLmXxHIcsMIy9R4uJgUbkioepF2nOW//rcW2yeig9GQRDRX9sUKQVOwiysOdrN5z0+Sc7K2rhwTxVbUQ/cLqOOQw2hUf515Pe3HIa496WSLIZ23TRltVXgmVNaalSMmqEgptApsZAldZDruQZs4xAppPU3CNhkS/JjMciDkCF3BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 23:48:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 23:48:34 +0000
Date:   Thu, 13 Jul 2023 20:48:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLCNUNRsWy/YuHhQ@nvidia.com>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
 <ZLBWh370pPjx2B+z@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLBWh370pPjx2B+z@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0482.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 775c2271-12ef-44f7-f3cc-08db83fbabcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVXC2tKs7fgaCZ5XYglPtc4o9+yq8+jKGscexvcf3ZnWyekgV1jZ0ukWydE1CqlZ6CE6TeXMcMsilLH55XXTHJqqEII6wdmzaifhyoUVPDLdnt9cw4GGLKqW6Z+SuA2NK78u4Drlu7CzuhKuTGyTvPgkfZQnrrnqh+Eqhl5sIxlHKPPl69oqMnGkg55EoQ1mUWzrNALFH7I+NTYH8FGuTqSJ76/CE63syYK9KYIL74yg6/tBCR61zK2udZ+zL4xrKxUIbVUvmwma7Z1CHNqHj1Fx6GccnCXRs/gXTXqR4Jm758S5IcrMJwDpwtVtaSkmLVxw9ethz4jT+Xa0me1fXP515VNf8AmxwSqt1V7d+ux02lCvseZzQiS4lC4fyipuz/giyNI0F31G+bVYOZAOxM0cmIMHYMuqLyyuWxsFDbPMWm60dVJnrdX/6z8u8mGE2HG2RP6aWAM5Xu9vj5oLX9G3RFtUJd2FY5rv6hBpT0azzl2iyeK19zjAsIeyzd88/P8Oa2cVHUoCM4jpYzHRQSWIGUl4FHMxXHEsxGG7gIGJsxcyMc8yEebUAykC3C+vkS4b3X4pUPDGr32t57lJw7Kfn3b1ZYQMxZCNw9z6J7/K400gA9U1jD95UvRCquAU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(8936002)(6862004)(8676002)(83380400001)(2906002)(2616005)(36756003)(38100700002)(6506007)(86362001)(53546011)(26005)(5660300002)(186003)(37006003)(54906003)(66476007)(66556008)(6636002)(4326008)(66946007)(6486002)(6512007)(41300700001)(478600001)(316002)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNNV0V2Z2FBR1AySFE1UFRrQ3hCSGRERURBMzM5Qkl3UE1tb2M3bCtrQ3lJ?=
 =?utf-8?B?TUJHRXl2NWpuSHBoQ2VVNDRaMHdXaGsxcGRsWEhVQWhnMUNjdVVVYkwxZkcy?=
 =?utf-8?B?R3Y2cEI2YzN3QTZ1WWJmcGk3YnJpOGpjUDdxeWRNVXlJeXBLNkVudEpONDVi?=
 =?utf-8?B?b3czZGlIUk8zNHc2U3MxTzNYdFJsR2NNL05KLzdWSEh0RlZtbXphN2txZHB0?=
 =?utf-8?B?Uy9XeDMwT1FKbFFNVU1UZWtRaGFqcDhFbnpjbzNLeUFjclNTMUtoTm9URFB2?=
 =?utf-8?B?MEdQZVFCZURaYnd2MUM1NWl5ak1TY3BXQy9MQVBTLzY1NkQ2em1IRlhmZ254?=
 =?utf-8?B?SkJSSUhsZzg1cllyOVBNRDlndDFjTnlLUlg0elBkeU5ad3Jncm1ramVZKzJE?=
 =?utf-8?B?bFVFcXExTGJiNmU0S0gwcTdkZmVaSjdZYkpBVy9qVTA5dGRpQ0FMNTlHR2Nt?=
 =?utf-8?B?ZEE0b01Ka0x6UHFyQ2VRMUczUWtTcmgwUEJTaENmOTVNUTRyNnVId2w2M3hl?=
 =?utf-8?B?TUV0a2VxZVRMaWo2bUo5ZFpUdzNUMDhIYTJ4ZTRkaFlST05CTWhJczNRdTRt?=
 =?utf-8?B?Q2dqTk9JMjYxcEtHUnBVUm5XcUg4WG9meHZBdy9DeGF3VlR5YXdyYjgyVUN5?=
 =?utf-8?B?bUpUZkhaK0xjL3hDcDdFazdNWU5SZ0pZNEFrRXZSbThOVVFZYXZpYUJuN1Vm?=
 =?utf-8?B?UHRZSlNRcE5LWi8xRXVnd1g3em9Pd1RDYWVVY1lEcXdNckhvUjhtdmpqV09t?=
 =?utf-8?B?VDZlalJMNTRkaFJiWUhLZ1BDemxQUjd1WmRyc0xsWDFkdXZwbC9mSlEremh6?=
 =?utf-8?B?YzJrc2UvMlQzR0RQSkhvZDZsZkpiSjFEMjY3QkVDZUxQaEVHdTE3NzZlUjBG?=
 =?utf-8?B?V3JUenFHeGtxS2dvMlQ5Zytzc1hnUXdRV3BXZzZDT01QYTV6WFlrOWMxK3lI?=
 =?utf-8?B?ODR3T2ZyVlpBUkh1djE4N3BzQk5uZU93MEJNaGMreTZtZWJrdW9sQmliYzVI?=
 =?utf-8?B?RjY0OElZSi82SmZUY1d4MUk2YXlwNUJVYVFLb0xPN3NNYUhmL0ZNSm9MTVVO?=
 =?utf-8?B?d09Fa01LOTNoUUlOd1dUaGJFbXZOR3lVVHlyOXFSa3BaWGd0dDcvMzhiZ2lG?=
 =?utf-8?B?ZmMvTDR5QUx1elRkVTlvWmRsZitDd0pOZVJjODBwcHJBQVpCL3BUeVhCNDBw?=
 =?utf-8?B?NkE3dFZEQXM3WTZvcFFwQTNubUVDSDlyU1QvVWdCOXM2djhMOHpMSXQ0NitB?=
 =?utf-8?B?NDIzT1FvOHVybzNsT3VFSURYUDNSeHBNaE95WWUxYm11QnZpZ25SaFVzSFNx?=
 =?utf-8?B?bVVjT3FtR29velUvU0NuOENXYVFjS1VCTkd4NGV4eGw2YktqK2xsaWs3WUFR?=
 =?utf-8?B?UWw1Q0tzZW0ydi9vNHd6ZUNRUzFlcWxOaisrT0VKdjBzRmowcnVsdk9BMGpI?=
 =?utf-8?B?VG5MZXRjV0wxWERNeHJVbmY3WTlneTFQamJodE1NazlXbnJoNm9TbWpqR3Ni?=
 =?utf-8?B?MHBYOW5JK01mbW5sS1BJWkdKRE1ubHdGUDNwUnhsd0dvdHcxakxtZzFWcjNr?=
 =?utf-8?B?cGRIdGhKeVRMaGtMaXB5a1NDL0EyT29rQzc4RllBaFBielZBd1pyQ1hRM0ky?=
 =?utf-8?B?cFdKNUpIU2VvRUpiMnNCZEdKUW5vY1llN1lKRWE2K0t5VUdqcGFuMDEwaTli?=
 =?utf-8?B?ZkFFaVRVelZYdzd1VjhYUy9lWEtZYjYvU20xVHltb0h6RE1uNHJDNHJycjdz?=
 =?utf-8?B?U2F4aGE4SVc0MFJKY0oyOS9vTmxDM25jSTZyZEpNS3IvUlJhZU8ySHJaNDh4?=
 =?utf-8?B?WlFLVm1mSDZDdTVJZXVXTmwzTFJJTlVEbGh0M0kwQy9KUGx0d0hMVDRWV0tn?=
 =?utf-8?B?U0sxSGV6bzBJZS9XSkhEckZ3WmVMZUJUd0FNNUVVbUtrVHVXMVk1aE1zZm8y?=
 =?utf-8?B?MkI2ZytTNkU4Qk54ZXdyaUQ2R1plaGx3L3FJYVJReHhiL09Ia2liM0lzbXo5?=
 =?utf-8?B?ZWxyWEQzUktreFRmTjB1VHlpYlFnTWpseUNKOERDdHl0RFlDeUJmNnZCeTdn?=
 =?utf-8?B?U2I2WVg3Y2lZNnhPNFM4NG16bTVNcEEwd2pXVmRzZWZqOU5Zb0Yza2lmK3px?=
 =?utf-8?Q?nCM7fZCAOAG6eC1R9ovOiYT7X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775c2271-12ef-44f7-f3cc-08db83fbabcb
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:48:34.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+KOrEml3uYLBi19W85B1ZOUcCqaeDrJsGxpdrir7N3YN0pQPaH5mIsBfkfWyJjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:54:47PM -0700, Nicolin Chen wrote:
> On Thu, Jul 13, 2023 at 01:41:38PM -0300, Jason Gunthorpe wrote:
> > On Fri, Jul 14, 2023 at 12:16:16AM +0800, Michael Shavit wrote:
> > > On Thu, Jul 13, 2023 at 10:29 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > It would make alot more sense if the STE value used by an unmanaged S1
> > > > domain was located in/near the unmanaged domain or called 'unmanaged
> > > > S1 STE' or something if it really has to be in the master. Why does
> > > > this even need to be stored, can't we compute it?
> > > 
> > > struct s1_cfg* and struct s2_cfg* are precisely what is used to
> > > compute an STE. For example, when s1_cfg is set, arm_smmu_write_strtab
> > > will write the s1_cfg's CD table dma_pointer into the STE's
> > > STRTAB_STE_0_CFG field. When neither are set, the STE fields are
> > > written to enable bypass (or abort depending on the config).
> > 
> > I guess I never really understood why these were precomputed and
> > stored at all. Even more confusing is why we need to keep pointers to
> > them anywhere? Compute the STE and CDE directly from the source data
> > when you need it?
> > 
> > eg If I want to install an IDENITY domain into a STE then I compute
> > the STE for identity and go ahead and do it.
> 
> I think it'd be clear if the master stores STE value directly to
> get rid of s1_cfg/s2_cfg in the master struct. We fill in those
> domain-related STE fields when the domain attaches to the master
> and then call arm_smmu_write_strtab().

Right, though master effectively records the STE when it writes it to
the steering table. If we need another copy I don't know.

> For struct arm_smmu_domain, it still has a union of a CD (for an
> S1 domain) or an s2_cfg (for an S2 domain). Or we could select
> a better naming for s2_cfg too, since s1_cfg is gone.

By spec it should be called CD and STE value, but frankly I like CDTE
and STE a little better (context descriptor table entry) as it evokes
a sense of similarity. I don't care for the words 's1_cfg' and
's2_cfg' to represent the CD and STE, that is pretty confusing now
that we have more uses for the CD and STE's than simple s1/s2 IO page
tables.

> I think a master own a CD table in both cases, though the table
> could have a single entry or multiple entries

Yes.

> depending on its ssid_bits/cdmax value. And since a master own the
> CD table, we could preallocate the CD table in
> arm_smmu_probe_device(), like Michael does in this series. And at
> the same time, the s1ctxptr field of the STE could be setup
> too. Then we insert the CD from a domain into the CD table during
> the domain attaching.

We insert the CDTE from the domain into the CD table, and generate a
STE for the CD table and insert it ino the Steering table.

> Yet two cases that would waste the preallocated CD table:
> 1) If a master with ssid_bits=0 gets attached to an IDENITY S1
>    domain, it sets CONFIG=BYPASS in the STE, which wastes the
>    single-entry CD table, unlike currently the driver bypassing
>    the allocation of a CD table at all.
> 2) When enabling nested translation, we should replace all the
>    S1 fields in the STE with guest/user values. So, the kernel-
>    level CD table (either single-entry or multi-entry) in the
>    master struct will not be used. Although this seems to be
>    unchanged since currently the driver wastes this too in the
>    default domain?

As we discussed in another thread dynamic resizing of the CD table
makes some sense. Eg keep it at one entry until PASID mode is enabled
then resize it to the max PASID bits.

But I view that as an improvement beyond here. It seems fine for now
to pre allocate the full CD table and waste the memory. PASID capable
devices are rare.

> With that, I still feel it clear and flexible. And I can simply
> add my use case of attaching an IDENITY domain to the default
> substream when having a multi-entry CD table.

Yes, with the above note about dynamically resizing the CD table, I
think we generally have the idea that programming the CD, eg by
installing an entry, can cause the CD tables's STE to (atomically)
change.

Eg to toggle the S1DSS bit if the PASID 0 is IDENTITY, or to resize
the table if we exceed the PASID space.

Longer term we'd also need a way to setup IDENTITY domains for !0
substreams as well too (eg for SIOV). It is too bad the CDTE doesn't
have a bit for bypass. I suppose it will need dummy 1:1 IO page tables
or something.

Jason
