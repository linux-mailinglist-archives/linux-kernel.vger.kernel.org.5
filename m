Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2F77FD61
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354163AbjHQR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354230AbjHQR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:58:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C688E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:58:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0h3NsY44b9Upn9m/N1Pl7yS2i2KFWl4dYUma7GVYcPd59p5ufI8zeJUcfkv8BaCPMv8wX5QLsMjWow6ojqIsMrQMME6r39UReYkPDv9uxQRPXGQsv+PHvCRD6wyYTP7GdUv0PlBhRKwi3HpQ6gukFAXHavU47/OouuRZhrTvRTDmsKh8piPD6ItvOoFYJMXyvis6rvKYpqmQEctunWVI1ggcLykqewpmm0XAO+4qAA3NM0x+1Mb107mcYsrfeJypVdxcO9yPUKM0ZBo6WFn1QpDhVDZ1s8Vi1yQ9tZitcXZSiQ+NHnGWZ358YOozkNsP5d+3txB78NXL0tA8mIa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49O2Y0pgqj2Ea0yfMcJ6RVSscsmRO16GDX7NA1f/pdY=;
 b=An0RaBCEEceweFWpHfZ0qCBLZkLOj53Re+gurkrQDkuwovctqTVUk12+NMfRd7RXmaIVUaXS0WPjGpPIz8cbZmZqyfhjQ68UA780LrTrMibpu1nvar+SMoA9k3J+etMuJWr8ZEiC6iLSaX7DBNk+9KymqP+eq9DOHhsUvwn4DxRec2pWSFH34rHMWVrMggy8gtBeQkG6+cfSFk/JX0NyYi6PCSB8WiyJ2Iu4PHigxQKArk93wyVhHn3Yqpom4GqxBJqwjNHtUVgJ+i+XuKYh206HAdQNjl/es7ZifmIEzd2OFhLD51lh1gQOBOtTgoksZwphZwNijimdfz8QnCspIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49O2Y0pgqj2Ea0yfMcJ6RVSscsmRO16GDX7NA1f/pdY=;
 b=rkBeiV9XxR4GvUiUpNFRk2y6/9Y5wqzCer3BlRiu8xiqz+MdTj/jCeNZhlITyfud8wS5VVdLqCZtndul4qwAbvrLqBsRaFC3TlLzqA573vqwNDSwv3Ez3VpO9XSmsK73YxUwUEB21bi9agK7Q0+A3pvt+g4REm1Mpe95dyQzEp7mm1xUEvSrbkqxLEpDLA5H95eaOkZUsYIImBVZgmv9s7at/J4+BCuIy94cD+1yIhGm7wY74VBe90HxGiRNbRzAD+RoHV7dh0Za1jszkGghUTQFhuo3aqCF1k0EyrdscIiDisTiAfysZcZtyHOtK0C2vUsM7AiMqmG8FOacsQHiTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 17:57:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 17:57:59 +0000
Date:   Thu, 17 Aug 2023 14:57:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        joro@8bytes.org, mshavit@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZN5fpi1SDp2uqQnn@nvidia.com>
References: <20230817042135.32822-1-nicolinc@nvidia.com>
 <ZN46upjIBFcI4mL+@nvidia.com>
 <9ba29982-ae96-bf53-f021-21cb1b22643a@arm.com>
 <ZN5RzvGhwRvVKUDy@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN5RzvGhwRvVKUDy@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR1501CA0019.namprd15.prod.outlook.com
 (2603:10b6:207:17::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d865d79-b47f-4644-d28b-08db9f4b7e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UV0qHzleO/RbT9TdxSEKNdLX4CMyy6fZRHBbqzEhK4h2xoTzb5PeSlIAK9FRsetx0Eo6gWiYsZ85vKgUoP+6fGf2OT50i5J64jbViPNpKwIXNyOO6GJF6fFYDgjMAfoKcuAclNnpS733tSorPkr1XdtLM/ar5iSgoCY6rGDyeTeCuf2k4j3gE5s0fI1JOTOpVOQzjlXredRtnjCliQvwncM3WHgIbkK8sHDnIJAzd1vSEiehwG0iPpEFZO4n7dEZiwN1f7PQNDJFyUbbGjtIS057bo0NcV1UoiL9pM4RecdjFkC4j649RuuVRGLy0LFSitJ6Te/DacjYGO9mVRmie1WVIyyoYl7VCqtftPx7xU1vPar2VRCUP8/Z/W5JSK/oeLCr0Tu3PUoRo5LjAIxhP0U3tCSBQKYAPjr4taNQeR5PSv6nDYND8DiUUpO8DilA+bLqjPh8WwMNHEMATD89ywotlBn0Rrsf5pxZAKoqDOJ/QFCyJBxpIyGsCxx3cLnwoNFCwzGT5cINP476cZdKUQhe5DcTpLkLFDlGJgFgRbiUAp2bKUFsVBqyv/GtebeK1EhFz6bW1SsrScyKWd/MfVqu2UPwsEgLTYrdg3wzY9TjKQSsadGvOEKI2ZbnJMX/WjMN6kb4yPsWMTCm4uGpBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(186009)(1800799009)(451199024)(2906002)(83380400001)(478600001)(37006003)(66946007)(66556008)(66476007)(6506007)(6636002)(316002)(6486002)(5660300002)(2616005)(26005)(6512007)(8936002)(8676002)(41300700001)(4326008)(6862004)(86362001)(36756003)(38100700002)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2DBdqnn087mtMoqb/yiTaTpIA+1gbSIqLDLVIWKjivWJzkzi7+mePCrdZGcF?=
 =?us-ascii?Q?CUb4Ab9dxCEo5vGlkNITa2VFbPn3pklwa+fWiO6cff6Z+/99ATZ+jX4NXtu4?=
 =?us-ascii?Q?LpXs7A5Qf5Uj056Bcvt4rVZk0347U+9wdT0Iev4VofKbYGanUOGqY0AjWI/f?=
 =?us-ascii?Q?oe/+32D1LZyooSPDyhYdwMDZceye233vRqr9a2RRfV0AH/gXlRyYSVOQ8rom?=
 =?us-ascii?Q?cInLrFkTa1OXyDepBYLr+/gBAjHXD1755G2FSsuSqRdAuO/0M2Kh8fqTHEGC?=
 =?us-ascii?Q?3zsHBwn5gppgYezrjTdOxCYlKl/LXAyRHSkAGQXqAL2mvY43q6iAbYPd4s/U?=
 =?us-ascii?Q?K7togXwFXcUqltB+WIXCrkloQ2Fo7M4wsBnMQB5ANWEDOvGQNmYDY6hGaYF8?=
 =?us-ascii?Q?b9bTBlaS0XmStI5RWT/A+ZeMuCPgPPxLCH3cvzk/YoXXNb2AILemO83z1veM?=
 =?us-ascii?Q?BFuAab2GHvOOktY00TcpANQgvmXsiS+mYWlD3o/0BkyicrGRApGVzru6K6Lz?=
 =?us-ascii?Q?f41zGm8sMCXjv0xLRyot80mczCSETKvQI0/cJ8ofmPMZ7N0S57+m9/PYZ1Mx?=
 =?us-ascii?Q?RZfNPvQWNSy7POUV9r0jBnKPdCbwXU9z9Ej1L06R4sQc1CbnQyCj2iAGAoW5?=
 =?us-ascii?Q?7rQoRhCchDPPqiXqaOEU5po+BY7bH9ukfz4kRMYjb++aVnx0t9tDSVPUZ7WT?=
 =?us-ascii?Q?P4Q3hfvdJk3GC+Fd7JAnFZ5QLjFRgVwNYoFTl2oXdD9phC3Sz7EKhyexYOZ0?=
 =?us-ascii?Q?1ftohLr3GcmIb2zvBXKjLOwkT153bJvPy2A4/SbcukuBZa7WMyJI9Mw2iqsI?=
 =?us-ascii?Q?sD4QRuoGs9lCdb+BUjdt/MwCsIDtdVwdGUjZIVCwYNku0Sk/ERN6P5OfHJ8u?=
 =?us-ascii?Q?ckZofhVj9IgDoVwiU3iKw/geXpl5rIFQjMZjEtp7f/ZaMT9kMog2eH1vWrMs?=
 =?us-ascii?Q?7WFnmxgilDELvbQtj8n4GiJCamyMfZTU9uTBZ/+BKHVw4sTCLD3J8l4hBI0J?=
 =?us-ascii?Q?tDS1oCsYwQmHKT8za3u+zCOnQ/LaWDH8a0sy71YfYXYm1K52U+UrJV+HGCdx?=
 =?us-ascii?Q?BZWX6rBGSZskciugG51WSo4uRFXWkCfKAYuXLzuBrOzcQYp2tcpd9LKLkUEP?=
 =?us-ascii?Q?bM4pMFLLUxl8jav6GfeUaBLqUWNieJrhln4l8aTNJ3n96Hx6XdZ9PqgWt7r/?=
 =?us-ascii?Q?xnVwHjwmEwuhUn3OjBywX+otA+ShwtIOXnPX+VdgDpF6yPxHk055uGY6AcNP?=
 =?us-ascii?Q?Lz9k2rV7IAPhisygtnDf7NAOH4QXStL+PgKAAJpE8wDiADvxNilG7b4rbUTs?=
 =?us-ascii?Q?0z89EST25i4sqMFD/8sGShVAyeE5kSKyrTUixk0DspvdlXMtC8wxe5zN3rPL?=
 =?us-ascii?Q?qkykpqkNPSSS0hGG3MFkRLA3SqBPUcpOGFM/uubTT8JOcysG4XTB7iUk9DcN?=
 =?us-ascii?Q?kUxazr+Fn7+43h52/gyMmG2BqSfj9dZzedw6C1lFfwXnD/Gf+oLbX+Wck30z?=
 =?us-ascii?Q?/017TolnK4BKfwb+SacASFgMxEJzmUX2ixXUMzZ/1J+SxEEI82lLKkUnVb5i?=
 =?us-ascii?Q?E840C18ust4+RDY0GaQSVlCpQ0nl8qF8jahGxK2n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d865d79-b47f-4644-d28b-08db9f4b7e3c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:57:59.3852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M0yuE3cz1ePgJI5GEXlQnt+QdGPfA7730AM95P0Lhl4UdnjlE/wRgCwdntcUkE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 09:58:54AM -0700, Nicolin Chen wrote:
> > > > @@ -1290,6 +1291,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> > > > 
> > > >      if (smmu_domain) {
> > > >              switch (smmu_domain->stage) {
> > > > +            case ARM_SMMU_DOMAIN_BYPASS_S1DSS:
> > > > +                    s1dss = STRTAB_STE_1_S1DSS_BYPASS;
> > > > +                    fallthrough;
> > > >              case ARM_SMMU_DOMAIN_S1:
> > > >                      cd_table = &master->cd_table;
> > > >                      break;
> > > 
> > > Eg, I think the code looks much nicer if the logic here is more like:
> > > 
> > > if (master->cd_table.cdtab)
> > >     arm_smmu_cd_table_get_ste(master->cd_table, &ste)
> 
> So, this means that cd_table is present, indicating either "S1
> translated" or "S1 enabled but S1DSS"...

Yes, if cd table is present then cd table always provides the STE.
So this is S1 page tables on any SSID or SSID=0 IDENTITY

> > > else if (master->domain)
> > >     arm_smmu_domain_get_ste(master->domain, &ste);
> 
> ... and this means that cd_table isn't present, indicating S1
> bypass or S2....

Meaning S2 page table on the RID or IDENTITY.

> > > And you'd check in arm_smmu_cd_table_get_ste() to learn the CD
> > > parameters and also what SSID=0 is. If SSID=0 is IDENTITY then
> > > arm_smmu_cd_table_get_ste would return with S1DSS set.
> > > 
> > > arm_smmu_domain_get_ste() would multiplex based on the domain type.
> 
> ... it then means we need arm_smmu_write_ctx_desc() also when
> attaching an IDENTITY domain.

Yes, if a cd_table is present then it would be good to always write a
consistent CD table entry meaning IDENTITY for SSID. Even if all this
does is zero out the CD table entry.

> > > > @@ -2456,7 +2471,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > > >      list_add(&master->domain_head, &smmu_domain->devices);
> > > >      spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > > > 
> > > > -    if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > > > +    if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
> > > > +        smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS_S1DSS) {
> > > >              if (!master->cd_table.cdtab) {
> > > >                      ret = arm_smmu_alloc_cd_tables(master);
> > > >                      if (ret) {
> > > 
> > > So more like:
> > > 
> > >   if (smmu_domain == IDENTIY && arm_smmu_support_ssid(dev))
> > >       arm_smmu_alloc_cd_tables()
> 
> OK. ARM_SMMU_DOMAIN_S1 with ssid=0 still needs a cd_table though.

Yes, but the atomic ste update is a bit nicer, though it can be
something to do separately as it is just saving a bit of cache.

Jason
