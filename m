Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2C752B43
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjGMTzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGMTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:55:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC82272C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE/lZeLZSyOuw/OEeS9iw72FEclX94RwAs6fFASKXYKJBqDQUVGACuRsuXgfr36fnwmATmQGPMK2oqW48qXHnB23/LV4q4/0vPz6e9Vq2EDPGTRzgf0kqtwk8i9uZfwl6x8PX9j01lV8CMMAGYqvCXHuU3o98/ZYmuP9jsKVvxM2kfiAuj3jRCRn8in1+gkdecnGwDav1RpIY4bAYgH1bRLqQjVIsfySdJcIFVv9ndivP3Y1sfWLPlCZJXVaE8/qNTaHescJt8nuD1BJKq8E9/TBZ8SqlXB/iItKTEAv/ZHner26dfuLGm4GmXitMd3ahqBNqwQDbdgavfSkqwUZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtCpFx1PrUROG4F2IG89coStMlut9aSPJED3sV0CTDA=;
 b=KL0nr+aQATwClgzZA8tCZSoxxWvk5iu6A+74T57dw04C2xWTIP+WxzxubgBLkI6Le7c8bwkP+fcMnPNkgg9Uo+uc7m68gwgWrL/8shpMS+oNI49jOVwy4BFXcXbaIL7/1Z5akPp3tLs7x/hxjeBg2T0LfUKrbNBGlmO1UMRFSzOHn9vpyT81Zfy+uBEwhzE2Ya8ftAl554BXdJTvlwUlEkPP7jyT134hxkMPZ6Z+e/GUY+AG2TT3WWct5359JrOdnvYDUWXhXU3UbgqAnfwoLBEz4tYg419intrK49DtaznZXxoelIeWkDLadYIygpuMwLDngdu1q7t35OzVM4i0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtCpFx1PrUROG4F2IG89coStMlut9aSPJED3sV0CTDA=;
 b=YTFQ1owesE7O/GEYOwdIAbEXVDYNb/TrDbQ5ZktbEzMgJAeXYmxLMM4wgwKSdqHp8WkeXX6lPfzPWzQKeDmFnxkz490biJSQ1u1XW+nKLTSCNfQVaeHOoSY4ETNkQ619ZVRXKoIkI7k0KSZXkPEQeb35XkPNmhgEqhMdbkBLbGTbwQGLKihltSg55g5z2O/Z7ivavsQ13RYxR6w5JAoDYHLbBJyIAKu0URoIEI78bw/28YPRLa6Mr+/oZjHB3P5FavzPE8fwziKRJ0G0Z3b09RHyU5rOw8jm+HWsq+poopwslv5DHPg0tSFmZdYAMsbs4ubja5L+ZmHD1lutEsNcrw==
Received: from BN9PR03CA0353.namprd03.prod.outlook.com (2603:10b6:408:f6::28)
 by CH3PR12MB7497.namprd12.prod.outlook.com (2603:10b6:610:153::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 19:55:04 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::32) by BN9PR03CA0353.outlook.office365.com
 (2603:10b6:408:f6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 19:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 19:55:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 12:54:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 12:54:49 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 13 Jul 2023 12:54:48 -0700
Date:   Thu, 13 Jul 2023 12:54:47 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Michael Shavit <mshavit@google.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to
 smmu_master
Message-ID: <ZLBWh370pPjx2B+z@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia>
 <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
 <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLApQjaqoOshT2TJ@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT017:EE_|CH3PR12MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccb5c79-ce57-4d36-d6fd-08db83db0d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDQnHVr3hRjyuAkXbR8Uceo8ZtKwzAKEWcyzrcequ7bmASKWRyl3qQBf3fPPpaSG/UNSSaUckxJ0oY9WRD5wODyY/rhWWoPjc5bnoq63xW9cLq+FjtyeTXo2vF7k4ab+tNjw9qoPA6MsOza+ap5wxvELQGqciXD8BvGGs4ERW2feKNSI4bUBDU47cyTj5kmr88DOG/rql27SX6r7qESCmy3YlBSlK9Kl7LeoHgjO1YxnPMK8bQelTtknesZVJuhXMCKVQ1tH132L7R0dCfuQkOR708asCNZ+aAjDJswKRSWzREJ2bdxopdo4H6DIO+7nI6ejyrj+PTmW9KLyp2+NNk/yHUdVevhOUvV0EAwbr0tNDi1JhqAgO9Uc5QGTqQ4qsr5MK7AJQTbJQ78GSgN0x7a1EtGNQAydGRqjQ3yXYU3yaIpATaKUIlu5mvrDQE7hQcZUmEK2b7sUV5hL7WH1jqgp4T+1DZDDiZQIdmGrofLzlksDpM7PD7dEKMD3TtH2M6YQ+vz1xBx/E4Jy5/bRLLi5kvyk6jyM9gNlGonrqIBNwu13ks7q46vuc37mta2oCKZTEShRXqmqfrktGGmSdclgxxpsaQVcxCh/KxHD/u9lQPaaEde49my3dZSIVIgE6Qm0kWXHFSwVzGUR7QKHHvAlrkYuaJV+lf6MFk79jELsDvaNFRMRcLi4P6NA0Gogkevdy1KEKdOJXktLuUXa62YdenVKOIzzI1cwMa0zg+ZtXAzoOcPL+KupIslrKr+ReAcHbwxvXtvLT5YSTf3XGdouqdv6WmfI6nfwX6bqKOg=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(47076005)(36860700001)(186003)(336012)(426003)(33716001)(82310400005)(7636003)(86362001)(356005)(82740400003)(26005)(53546011)(9686003)(40480700001)(55016003)(70586007)(70206006)(6636002)(4326008)(54906003)(41300700001)(5660300002)(6862004)(316002)(8676002)(8936002)(2906002)(478600001)(67856001)(414714003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:55:04.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccb5c79-ce57-4d36-d6fd-08db83db0d37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7497
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:41:38PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 14, 2023 at 12:16:16AM +0800, Michael Shavit wrote:
> > On Thu, Jul 13, 2023 at 10:29 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > It would make alot more sense if the STE value used by an unmanaged S1
> > > domain was located in/near the unmanaged domain or called 'unmanaged
> > > S1 STE' or something if it really has to be in the master. Why does
> > > this even need to be stored, can't we compute it?
> > 
> > struct s1_cfg* and struct s2_cfg* are precisely what is used to
> > compute an STE. For example, when s1_cfg is set, arm_smmu_write_strtab
> > will write the s1_cfg's CD table dma_pointer into the STE's
> > STRTAB_STE_0_CFG field. When neither are set, the STE fields are
> > written to enable bypass (or abort depending on the config).
> 
> I guess I never really understood why these were precomputed and
> stored at all. Even more confusing is why we need to keep pointers to
> them anywhere? Compute the STE and CDE directly from the source data
> when you need it?
> 
> eg If I want to install an IDENITY domain into a STE then I compute
> the STE for identity and go ahead and do it.

I think it'd be clear if the master stores STE value directly to
get rid of s1_cfg/s2_cfg in the master struct. We fill in those
domain-related STE fields when the domain attaches to the master
and then call arm_smmu_write_strtab().

For struct arm_smmu_domain, it still has a union of a CD (for an
S1 domain) or an s2_cfg (for an S2 domain). Or we could select
a better naming for s2_cfg too, since s1_cfg is gone.

Does this match with your expectation?

> > > I'd think the basic mental model should be to extract the STE from the
> > > thing you intend to install. Either the default CD table, or from the
> > > iommu_domain. ie some 'get STE from iommu_domain' function?
> > 
> > I don't follow this. When we attach a domain with pasid (whether
> > through SVA or the set_dev_pasid API) , we don't want to install an
> > entirely new CD table. 
> 
> The master object owns an optional CD table. If it is exsists it is
> used by every domain that is attached to that master.
>
> In the code flow there are two entry points to attach a domain, attach
> to a PASID or attach to a RID.
> 
> For attach to PASID the code should always force the master to have a
> CD table and then attach the domain to the CD table.
> 
> For attach to RID the code should do a bunch of checks and decide if
> it should force the master to have a CD table and attach the domain to
> that, or directly attach the domain to the STE.

I think a master own a CD table in both cases, though the table
could have a single entry or multiple entries, depending on its
ssid_bits/cdmax value. And since a master own the CD table, we
could preallocate the CD table in arm_smmu_probe_device(), like
Michael does in this series. And at the same time, the s1ctxptr
field of the STE could be setup too. Then we insert the CD from
a domain into the CD table during the domain attaching.

Yet two cases that would waste the preallocated CD table:
1) If a master with ssid_bits=0 gets attached to an IDENITY S1
   domain, it sets CONFIG=BYPASS in the STE, which wastes the
   single-entry CD table, unlike currently the driver bypassing
   the allocation of a CD table at all.
2) When enabling nested translation, we should replace all the
   S1 fields in the STE with guest/user values. So, the kernel-
   level CD table (either single-entry or multi-entry) in the
   master struct will not be used. Although this seems to be
   unchanged since currently the driver wastes this too in the
   default domain?

With that, I still feel it clear and flexible. And I can simply
add my use case of attaching an IDENITY domain to the default
substream when having a multi-entry CD table.

Thanks
Nicolin
