Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBDB78F209
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242148AbjHaRjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHaRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:39:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B0CFF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 10:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT7kG1kchtBgH7bH9EJ3NilLSI7Kzv/+/bWAvvQaKcUHmzrdL9WYiF2GE2pCGVOEnI+wnK0OWD0pGcHY3eD2vvIGP+0GTfDRRm375eswUbpiKBTeN8X6OxQvDNNdi4b5V7Td2A2j/6W93a43uQYc9wT2v4qxE6Rgh93nPLqllhYWtDTn81b8u+/1Ql2qtxWH0J33SQ9O/B53KwRk4V/ZMVO5mU84bV/wtA/mJfI+H2y+2kZh24xeW5cP5uk5wcz4XbNBvNyYImGJUQsah+F4z0vp/o30yRV2yptg4UL81OYGGpEFu8Lpsc+PZQK5XGsWhKYFmqE73e2hutyefJcAYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tf/BqpjbQ75zpGxYGsfi32uCo5GYZ2Lcd6BZOBiwEo0=;
 b=Zfxc6XKcPMsdsGL72oAgw6iWK6NIXaB7kHich9/to0Zo5SNXwPCTFt/eh8OLTx5cxLh0vz5zBXiRDg5AXFuf/gDfsuUb1ri4G6Vr6oJ1uvbjGUZ0u8tAMKQRu9zZShXdeIR6qNpI+EY703V1//8pENriSOt3lXZIn4nR04UNu/AKMN+r3ZRaxyIRohMUJJRcQfWrOcU7jYuES/CUjvIdhPND/742wN9BQGbEJP8rXoHeCJH77761y2Dmcmjk5AtuoFr30T4RVbXuQbSkFESfT5bh4bu4cU4cNBIWiV0ZT3QP5+jbZoxQwLM1AXg8lF5l1P+V3cKlLuxeA07KV+3oYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tf/BqpjbQ75zpGxYGsfi32uCo5GYZ2Lcd6BZOBiwEo0=;
 b=j3/Hc+8TyYSIXEJd5gw5ccOAc3snoxXKYt4wdk1/m56X+zvR7uw8rjD8jDGVp9J91KLf8YrPjtr7VPneT7eATCYXPRyWaaoW7tjID3pVTApz67bi83zlKaXKRYxyrlgVhx37vcgyOS9qz5bIk+4SlF9gMhFEZ5dso8biD3ubMMDWEexSfDbIGrr8AZXC7/Zyi8hw9k7mEiHiDe3sTnM3rLKTqxCmxqedb3yCiaE9Ob381A4u/0c+Ikl5oeAW9gmlw0F9u6t9PjHDTuSZhdHTQUz/yxDnugvb7N5ew6wW6ktpXvLS79lCunV1zVOX/Om4kv0qUd2FMog4tjsdLVIXWw==
Received: from SA0PR11CA0039.namprd11.prod.outlook.com (2603:10b6:806:d0::14)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Thu, 31 Aug
 2023 17:39:26 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::50) by SA0PR11CA0039.outlook.office365.com
 (2603:10b6:806:d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 17:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 17:39:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 31 Aug 2023
 10:39:13 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 31 Aug
 2023 10:39:12 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 31 Aug 2023 10:39:12 -0700
Date:   Thu, 31 Aug 2023 10:39:10 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <ZPDQPs9UL2sksblM@Asurada-Nvidia>
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
 <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZO5uGKzGsaliQ1fF@Asurada-Nvidia>
 <20230830214958.GA30121@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830214958.GA30121@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f7a39f-65c3-479a-8233-08dbaa493866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aK7ontBVh+JqQ1ZgAzN4ABVE4wgiZovomsrAAxTyPjXVhWvmPVKGMut5J3pH6FDzoqmi5SUp98H9/QtEP5uRywmSsxKH03Wp5nRUiliwrR93+FJpw/A5zYl1OBDNGx4/05K9PFXyBEdFLFLTcGT+8SPQERygN7C39bZumuUM0abmfGKuzMD1V+Hg510V/uHtxJZb1nwv4RogGNiKQile2xpC31kJ2idA9YKgRm4p8yRwD3BZSYGarqZGMO3b+BC9dRfROuojrHdmPSqx0w0IHe6lFtOA8+kb+VNdEh+a2GCtKsn8giVftAXbggq5ytrkAr8kTGXc3djsInirrfB/3+7m5dp4uQsjfpvzAHj8ETdbWL0beTW0COzGmcLIQbd+/1rPrWR8gGGvfhSkWUA8tryn20LQf/OAISKurURfG/hLE15qa5Y579exsJ1Zi4YqC4jaqPwEle6QyKLI1jb0pjIIBPBLuVCUU/Qq8wnnQ03b+/oQWMA0Dif8f1atMr3Ozi8YSJG8X97Fhf+BcstNMOANl+3JfWQ++RSSas6sORseXOTzHUHXyq09Vcn4cPj+QGMG6i3C4LpBAGdQehAtqWDVSJyhugr5aNQGnaBslhB1HX6HonaS2DbkXbJZ9a2RXIC57SToJcNXeE8/urjYP4RCVnZJkoEvay3bLg00VJs85wP1oopJgymXoP3nENhdIL4M5nVz6DRYwl5R2uVy5axZf3D3aP2xi2pmIZPPjngXr5J0eIFALFzdNe63eKhG
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(46966006)(40470700004)(4326008)(8936002)(8676002)(2906002)(316002)(54906003)(70206006)(70586007)(5660300002)(6916009)(41300700001)(40460700003)(55016003)(26005)(9686003)(426003)(336012)(40480700001)(356005)(82740400003)(478600001)(36860700001)(47076005)(33716001)(83380400001)(86362001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 17:39:25.7071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f7a39f-65c3-479a-8233-08dbaa493866
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:49:59PM +0100, Will Deacon wrote:
 
> On Tue, Aug 29, 2023 at 03:15:52PM -0700, Nicolin Chen wrote:
> > Meanwhile, by re-looking at Will's commit log:
> >     arm64: tlbi: Set MAX_TLBI_OPS to PTRS_PER_PTE
> >
> >     In order to reduce the possibility of soft lock-ups, we bound the
> >     maximum number of TLBI operations performed by a single call to
> >     flush_tlb_range() to an arbitrary constant of 1024.
> >
> >     Whilst this does the job of avoiding lock-ups, we can actually be a bit
> >     smarter by defining this as PTRS_PER_PTE. Due to the structure of our
> >     page tables, using PTRS_PER_PTE means that an outer loop calling
> >     flush_tlb_range() for entire table entries will end up performing just a
> >     single TLBI operation for each entry. As an example, mremap()ing a 1GB
> >     range mapped using 4k pages now requires only 512 TLBI operations when
> >     moving the page tables as opposed to 262144 operations (512*512) when
> >     using the current threshold of 1024.
> >
> > I found that I am actually not quite getting the calculation at the
> > end for the comparison between 512 and 262144.
> >
> > For a 4K pgsize setup, MAX_TLBI_OPS is set to 512, calculated from
> > 4096 / 8. Then, any VA range >= 2MB will trigger a flush_tlb_all().
> > By setting the threshold to 1024, the 2MB size bumps up to 4MB, i.e.
> > the condition becomes range >= 4MB.
> >
> > So, it seems to me that requesting a 1GB invalidation will trigger
> > a flush_tlb_all() in either case of having a 2MB or a 4MB threshold?
> >
> > I can get that the 262144 is the number of pages in a 1GB size, so
> > the number of per-page invalidations will be 262144 operations if
> > there was no threshold to replace with a full-as invalidation. Yet,
> > that wasn't the case since we had a 4MB threshold with an arbitrary
> > 1024 for MAX_TLBI_OPS?
> 
> I think this is because you can't always batch up the entire range as
> you'd like due to things like locking concerns. For example,
> move_page_tables() can end up invalidating 2MiB at a time, which is
> too low to trigger the old threshold and so you end up doing ever single
> pte individually.

Thanks for elaborating! So, I see now that it was about the worst
case when 1GB breaks down to 512 pieces of 2MB range invalidation
ops, i.e. 512 flush_tlb_all ops v.s. 262144 flush_tlb_range ops.

Though I have not dig enough, I assume that this worst case could
happen to SVA too, since the IOTLB invalidation is from MMU code.
But the same worst case might not happen to non-SVA pathway, i.e.
TLBI ops for IO Page Table doesn't really benefit from this?

With that being questioned, I got Robin's remarks that it wouldn't
be easy to decide the arbitrary number, so we could just take the
worst case from SVA pathway as the common threshold.

Then, SVA uses the CPU page table, so perhaps we should highlight
that SMMU sets the threshold directly reusing the MAX_TLBI_OPS of
CPU page table rather than calculating from IO page table, though
both of them are in the same format?

Thank you
Nicolin
