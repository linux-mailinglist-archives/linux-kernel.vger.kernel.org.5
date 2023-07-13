Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA97528F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbjGMQml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjGMQmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:42:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAC82D40
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gd/o5A2HFvVCNY95uDaWu4vdDwiGDWV8Vfh3DD87BwcJxM7DF9hLkVc6ZcBqdrjv7JVp/ZPE5Cjc+OwkathI8SUKNyAKYzOxK5ogPuC1xfies835NY8gTbI6mZhNbx8C6ndGar7uPiNY6drG/G8AqimKLl6LyOWCmNV3d+fdtUhlj8Eh4EAfZsOa+K9ZO/2lNn25AucIJXSy+OQmR3Td0RxRCoNAR+aKYxmlVUQmuNgH1S0gUH8KdSNsM+TIzDzMl1jlD1wezmdPZHlLdEwHWzzfWO5N/KTtm4ehH0Uv1ec3Ve4OyfAiolPtqEZ9LZxnf+FsUpjPHEvzxJYEL9jA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAX1gAMd6RtSGwZVDkd8gTl8FDOGfMZiT73c0ebwRbA=;
 b=FDLw9g+734FXLJzifyt/URgd8lZYU72D+svjMaZqytH11Ui1lxG4RsWNP3DR4hOfu0aalhxkFqpmR9w3Ymsq2R/5bpeYu44+Bbqx3yrdLMUh/Jwcg6GBuTTfo4mNu4s5Y76J5oqObR/CGK8iZ1fwgLRUiTEjNiRsg/QreWHHEwgZPO+j49t65/WbW3Tt/h07KE3vAO9jvBxbLS4pmtuZD4SUw0FDSeOeKFOTME38k0vtdhhyPrFYwmXU/RHFQtLrz8R5w6LoyjYyAVBgpOr3WmOZdXv0N2+1Eef1ELThVObXknHrj4oR3oJ3zBxTZaHo6XTjrypE1tmGq6u//GI6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAX1gAMd6RtSGwZVDkd8gTl8FDOGfMZiT73c0ebwRbA=;
 b=aSkgw1sCoIuREou++6EUh8cnlhpH9kvzOB9h7kMZr8BIWZqGtxckaYGkq/oGJM04OLGNP2rZsD1BL2Q2JtGBBe+/MhUtwtJ2Rx92tFgO43Aoou/5SUkGd2LcusDgGI1OLt1xIzt3gTDBCUo28HSxnNX8aFumYqZQKpE9Vuoj8D/NJLu3MYbRw3FiBSuxEuFOetSURrv6gLpbEggbuETOXGuyPfkdV2uQub4sVuK1CtMnDunx/s7BMw5OB+GMHJPdRy0LzVcyMlaEF+9iQrt0C5nyl+rXASG8uWSYjdAZMgytqHyBj5QV7+p2AGhiS7O4xdXn6wVua9ke18eljyP7lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6290.namprd12.prod.outlook.com (2603:10b6:a03:457::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 16:41:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::69c1:5d87:c73c:cc55%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 16:41:39 +0000
Date:   Thu, 13 Jul 2023 13:41:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLApQjaqoOshT2TJ@nvidia.com>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e484b36-0d94-4abe-3457-08db83c00819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPBNLRPTzBAMQ6y8uAEeHbNcuu1v7YOUZs0dvH1IqUMqKLmVorZIpQ2BraZ1lbt6IFsqMZ9k+9FpjsTGf+3ikc3dh7YDirYg9gh3Xx9jXeDrh3fML96PfAsRR9BUGTG3Q+fxhKHkpzrDRTOVL8NRJ8Txs1dEw71/8Nxxcv8KSQPOu9DsH935KUJWawEB2lkbivBwNTrJimEhLSyCmtMP7GC2FCcTXPFe2WAoVUfUSkCTStVpZjtBLdwjRwzcuXQ3LBoM/Qo1CS/kF4FpiSZajXxuaDAW0aFwYcTlPsu8LFJezTdIi5MJpE6IDCnH0jhPi1acx6+A1jqAQQxZJPbaLW665FKl/Q7KDcp2ugmfLnTbdAzsbZhXLKXYMOImAa2kVwwrtaCI2o+X1v3nCjeUOKT2WSeY3//ZI8+3rvRJRkbqySfGGXpi6UbsbvRJCkGgng65NqThEPXYB3Aui0zH1jfSKSmZC9DYXXt3ivc/FgJhEzun9LZwYskIKHKwa7lwFdlIjM6ZexH1WM5HCCEFBs7QzHxOXqfKLADtm0OJYALY1xiBcEKy2vh3S+LIQLnU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(4326008)(6916009)(66476007)(66946007)(66556008)(316002)(2906002)(41300700001)(478600001)(8676002)(8936002)(5660300002)(54906003)(6486002)(6512007)(6506007)(53546011)(36756003)(186003)(38100700002)(26005)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHlvOXdORk41VTMwQmIwNDhPaUZIRUlVUVJQczVjWHpVVk5IMWc0WVZlRS8v?=
 =?utf-8?B?S0NGR3FlcFY3elVzZ2xibURxSEJmU2gxWFhSKzBpYzUrQjRNT0I1NHVQQXNj?=
 =?utf-8?B?d2dBbVE5RUVNVlJsc1lxeXRFeHdlWHlIeUZnV3Y2UDdFVmNvVG1NRHlIaFBC?=
 =?utf-8?B?MEltWFMzb2MybHVmRmkxMysrTXdIaDVDd0s3MTM2S1g5RTRjYzlYZ1hFMmRq?=
 =?utf-8?B?cEFJNC85YVk4a0tYVUt6TzRNcDh5NlgveHpILzlYQmd0ejU1TGR4RlUyaENH?=
 =?utf-8?B?R0xoRXl0dkh6c1dId0d5cFVRYm1GZkFhRDE5T3Z2S0JSWlk1bTBBRmxBOVZ4?=
 =?utf-8?B?M1VsSUxOdWNBL01ud0NQU1Fhb1NjTG5OUXNib1ovYjNRL3FRcy9BbCtraUtv?=
 =?utf-8?B?UXZFc2gzaXlpb0pkVFRoaDY3SlBLN0owU0RPemM2ZXpnY3JHMWF4S3IyWTN3?=
 =?utf-8?B?VUdwWEcrTTVmM1JrTlpLcFBpb1BoazJBbk16eWJhcGFsUVpBV0t2dys5dEYx?=
 =?utf-8?B?Nzg5aW1iR2FUeXdMYk03SjVuL2F5SHk3RVJoeWQ2bTlSZDFQa2E3eTFLbGV3?=
 =?utf-8?B?ckRNRmExMUZIMDU1L3NITmZKcjRscDV6VlVlNjBGMmNHRURYNExXdG81SzR5?=
 =?utf-8?B?b3pXYm44YlVtTDByeWJZK25rcThDenlmaEhER3puekF2eWVZRXp3RnN3MVRP?=
 =?utf-8?B?bEd6VUZ1RnpqSWwzWisraGhvVDZHL2tPRUY4Zm5sdVY0M0t0ZTFJeHp5d2lw?=
 =?utf-8?B?czk4R2RCM3hkaDk1eTN0a0NxNkxjNjh5L0lyTjdVZHI0Rkt6bW8wVThqdjdL?=
 =?utf-8?B?bFFPZ2lKNGJYUEEwQXFGbTN0TEFsZDZxTXc5VFZZMjYxdHFJK2U2Z1lhZWJF?=
 =?utf-8?B?OW9NeGI5N0cyU1phTlBuT1gxVVUxbEx3aGljWURiNkplSGxlMGZIVE9zZ2xn?=
 =?utf-8?B?M092c2hlWnpoN3JVNEJtS0ZoaWVHcnZYc2dhNTM4Yk9YN3dQaS9ickhVdG5B?=
 =?utf-8?B?cUppc1VKQUhUMjVyN1pkY1N6c2xIU0lIQk5tZVJQQ2ZpcEFTbEs4RDNkSHJ6?=
 =?utf-8?B?aTkwK09LYWVNbEtHNWxrcGMxTGpXcVk4QVpOMlpwdEZwSlZJdkRCQlB1Zzlp?=
 =?utf-8?B?bG5qOUlzS0J2bFhCUThydXNoTzduZEErdThvcy9rckxLbWlKL0lYcDM4T1Rz?=
 =?utf-8?B?d2lDNDNVeFlCRGd2dnZ1Q3NLenJQLzhQTHY1VWdoVXBBMTBGQXpBL0xBNi83?=
 =?utf-8?B?NkVuSVZCSHlmbVo5WGZUTTNhQ0FpM2VqRjhXVFc3VGZ4QjhRZ3htRy9BTDhF?=
 =?utf-8?B?WExOczYyYnRZK3JzMGl1dkhqVlRNL1Zvdm9Id0FjWFN5SGszVEZHdkJZelNC?=
 =?utf-8?B?YTZ0OWtsT3BZNUlhV1ZTVnBvY2UzeGRVc2VQRDBndC9IcnJwNVgvS3hZVDU3?=
 =?utf-8?B?YWxiejNJd2EzQ1RmQTF0NXUrSnVESTF1NWJvZFJuY25FMTMzTWUzV2JDQm9G?=
 =?utf-8?B?OUdpKzFoYy8yNGt4Y3VxRkl4OTJ6d2dRSFB1NHFBelJPVWtpUWlGZzlrUGVB?=
 =?utf-8?B?TUdGRWVZZ3k1S1pJdExnK3YzZWpQUnZ1dmN4SGYvUFBDM0dGTzhDcVRiSHJw?=
 =?utf-8?B?eTRRRnJXcW5jVzVreWNzSGhIT3BpVTlFT2s2Mkk4ZGIwQ0g3UHNYZzJ6d0g1?=
 =?utf-8?B?WS8yZ2sxUmJQU2t0eTNqa2dMcXUxVEYrb3VNc0ZQMng4aUpmME5LTEJWNlRH?=
 =?utf-8?B?bWdZRXUvN2g1QlBmck5LY1RRNzdWQVZHekV6ajJTYXdLazVvRDdTQkR3OG9K?=
 =?utf-8?B?eDNRdmNNRElJd0RiaUFoMmdVZ2Evc3dZM1krVlNZeVdpTDkwd2NPTUsxdndx?=
 =?utf-8?B?UnU5MVdUdGV4Sk00TnZ4SklDUnh1ZWo2K0xtOC9OeWFtNWV1dzRVRHI5MnRI?=
 =?utf-8?B?Q2NoUFJBNE1kS3luNHVydEpxQVI3VEpMbkJHNzJkcFJiSGFHTWNmUGVNNWZ0?=
 =?utf-8?B?bTgyakM0MXBtblBVODRQZjBuVW5SNGlLTitzM1RKOFRCL0k5ZTRhTUljRFp2?=
 =?utf-8?B?QUpnVjdTRklOb3hBdnpiV05XUjJDcjVpZEkyOFl3QytKcTEvTGMwZXhrbWo0?=
 =?utf-8?Q?i0aKty0utyfmzbqgIfeE6HHKy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e484b36-0d94-4abe-3457-08db83c00819
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:41:39.7851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUPDa1J+zO2vbCsebidCUcH1psHBqq9XXpWaQ1zRz56tAYucQv96hfzj0i1cwZ78
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6290
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:16:16AM +0800, Michael Shavit wrote:
> On Thu, Jul 13, 2023 at 10:29 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > It would make alot more sense if the STE value used by an unmanaged S1
> > domain was located in/near the unmanaged domain or called 'unmanaged
> > S1 STE' or something if it really has to be in the master. Why does
> > this even need to be stored, can't we compute it?
> 
> struct s1_cfg* and struct s2_cfg* are precisely what is used to
> compute an STE. For example, when s1_cfg is set, arm_smmu_write_strtab
> will write the s1_cfg's CD table dma_pointer into the STE's
> STRTAB_STE_0_CFG field. When neither are set, the STE fields are
> written to enable bypass (or abort depending on the config).

I guess I never really understood why these were precomputed and
stored at all. Even more confusing is why we need to keep pointers to
them anywhere? Compute the STE and CDE directly from the source data
when you need it?

eg If I want to install an IDENITY domain into a STE then I compute
the STE for identity and go ahead and do it.

> > I'd think the basic mental model should be to extract the STE from the
> > thing you intend to install. Either the default CD table, or from the
> > iommu_domain. ie some 'get STE from iommu_domain' function?
> 
> I don't follow this. When we attach a domain with pasid (whether
> through SVA or the set_dev_pasid API) , we don't want to install an
> entirely new CD table. 

The master object owns an optional CD table. If it is exsists it is
used by every domain that is attached to that master.

In the code flow there are two entry points to attach a domain, attach
to a PASID or attach to a RID.

For attach to PASID the code should always force the master to have a
CD table and then attach the domain to the CD table.

For attach to RID the code should do a bunch of checks and decide if
it should force the master to have a CD table and attach the domain to
that, or directly attach the domain to the STE.

When the master gains a CD table then the CD table object becomes
attached to the STE. In all cases we should be able to point to the
object the STE points at and don't need a cfg or pointer to cfg since
the object itself can provide the cfg.

In all cases when you go to compute a STE you figure out what object
is attached to it (CD or domain), compute the correct STE for that
object, the set it. Same for he CDE, query the correct CDE from the
iommu_domain when you attach it to the table.

There should be no such thing as a "default" STE, and I question if it
makes sense to even precompute the s1/s2_cfg values during finalize at
all..

> We want to write something (page-table pointer) to a common CD
> table. Where should the s1_cfg which owns that common table live? 

I would suggest a 'cd table struct' that as all the stuff related to
the CD table, including an API to cacluate the STE this CD table
requires. If not in actual code with a real struct, then in a logical
sense in that a chunk of the master struct is the "CD table".

> I thought we concluded that it should be owned by the
> arm_smmu_master rather than any domain (to avoid dependencies
> between domains a-la aux-domain). 

Yes, I'm not saying anything against that, just how and where the STE
and CDE values flow around.

Jason
