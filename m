Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50976A80A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHAEwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAEws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:52:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40A10F0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlmVQ2N3YwDlM1IgTQDiTFzP+heR4VJYPvGhjm1R8g/zYN6mlCsN7lDeqvlpBNjuSy11sBK9YrebdJPbyOf92YzOGBnk/B/igbxc3NS3yKRUNrq03e3usIIwgN+nyzm7yd5DwC0Td6FhrweZSW9UV09qFKIPFpAmSQKIrEoaifL5MYSsaYW0NYXX6IZi/r470ZjEY7fr8EHT+0KqopYQc0WqeQsi0qPUryQ4Jso2/N7Uq3q0p4TLNtCWGR4Ff81rllQ3m+B78b4/PrMihM/WrM7wJBSBLfgQcUK8LqQo7ZdrLDelbbrAhfDnhpSzm+nCYOBy148FNEjSxleZDKkNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7SiEFRWqBfm3TOEO4B66AOEfiknhs7Z2KPFWEAPAeo=;
 b=DPwuhvgzyQAC6GMyoZFXBtlFCDSH++tysOlPg2+7DOzLvHEBmNReS8W+mCNn7bNBk06pUTJUvAb2g0wFbdNYJVgPgd4vvcg1gGsiQceWyo/3k3QUljVVpOrblfz7iUTZMEGeVR8mYOkXe/YgDySWnmwYTy/IopD9U8Ze67iJvPBBTh3Zl/8SWiz4ryyv/5JImWiUJMavUGXuKXGK785vKY7gChrkiMN6iJ8/VcxXv/+NgP1pTTGYSsDaTO0PUGlOQx3HqDPCI3Nwc6sqcm/8ulcnWIgfolsCFDnZtK7cZeSs6AhiMCjhPEUkZm+AKIR2eqIdeqTrPrT12TrGwOAOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7SiEFRWqBfm3TOEO4B66AOEfiknhs7Z2KPFWEAPAeo=;
 b=A6TTP7HrS2m9fNMqKuoNChJWKs/wW2iNZsJfk0iXv1U9a/Q/X81oFihk2t3VkXGim0MR++Yam34ozeo1Z7TOOPGqS543ZeYgIEjEAJK4CPLFHQJhANz9EoxF6LNnXV0nPwpclxuparDcY4mZzuas26LpoXG80eoh66jJ0HZb/1U2DNwgs+pjX8cOJrnjIQws9h+0XKZRmD6cYCY0KumA9zXsFzi12t+tMe+P8R6sZx3Cr8kaucZEaoMES4Fzne+yHGeLkPNcbk4D66j0SKiO4Fvlc3BayNw8PSK6XUpCn0jBXQl4MXcYvom3Ut1SIU8iy9BLAxkT1jXHFPdMEKwsTw==
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by SN7PR12MB7274.namprd12.prod.outlook.com (2603:10b6:806:2ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 04:52:44 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ed) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 04:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44 via Frontend Transport; Tue, 1 Aug 2023 04:52:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 21:52:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 21:52:31 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 31 Jul 2023 21:52:30 -0700
Date:   Mon, 31 Jul 2023 21:52:29 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 4/8] iommu/arm-smmu-v3: move stall_enabled to the cd
 table
Message-ID: <ZMiPjRtch1c06F5Y@Asurada-Nvidia>
References: <20230731104833.800114-1-mshavit@google.com>
 <20230731184817.v2.4.I5aa89c849228794a64146cfe86df21fb71629384@changeid>
 <ZMiJ9Cg5wfbxMZ+W@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMiJ9Cg5wfbxMZ+W@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|SN7PR12MB7274:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abaa34d-366b-43c6-434b-08db924b24c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUk/yFnMGKTXUrp9+zJkysq7j98qvEdc6jPagQuZyL9tD/u2MN5r3yp5cg5J9gzuUddNzfP5lS68tSKDJqv9tkCBNxr338AdseiiPVq71xgnaau/U3jTPu5A18MXTFLFLdoRIkA8MaxgQb0xbipi0sBoNyyf1ghd46lg8QtGA9hTIrVXZ2FBSbYRp5UxgqihTova6R8puBWstd873JxFj3bRGa5fyI8adtKgfsK+QzbN+JEnthMf8tV8z2F7f1wKKw+TgQoTvU++7GMlOsKnWyTjB2Rgxl7EutdK4UjJl5dm5J/vG9Sv1GuKtyEzLfiX7i1UzPa9uf48USeGGID/c2eBfFrluMO5wyRZEuXfmpyLHfsZPdNZwdh+ftZeh5WUz/9N5ItMBQgzojyRBe7kOxLOEUgefNQJiVu+rf9qq8siNtl74yLO4A2Oicqrs1ww+3KyBnhsPog0GM9f2+sgySq56QoC0iM9oTraOfybAJ5EjNZuWGltObh7l/pSVIQCVpXitJqdLgsgVywOY2a/zRh0Q9RCLkA7B/z422n4xXqUwQ2C1koy76ZO3pblEkTZy4MbOhIZSgApsVJLgQTPvSvcGExCC3LABPtBXcTVkEmQ1IHHoDlaVxUtT0KZ5XlssALlyDOlWk9NGWYvZKRVvaxqHVP2rp/dor7MsuEnsRAyswk98Hz6MhklUCrE0Qg5/LPGeXo3fXwtLJHL2bq9bdvN55pM8VExmyWJEOF9B8Y6xRVK0YjEQn6h905h4BgO
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(9686003)(47076005)(36860700001)(55016003)(40460700003)(40480700001)(26005)(83380400001)(336012)(186003)(426003)(70206006)(7636003)(70586007)(54906003)(356005)(33716001)(82740400003)(41300700001)(86362001)(316002)(5660300002)(6916009)(4326008)(8676002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 04:52:43.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abaa34d-366b-43c6-434b-08db924b24c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7274
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:28:40PM -0700, Nicolin Chen wrote:
> On Mon, Jul 31, 2023 at 06:48:14PM +0800, Michael Shavit wrote:
> > This controls whether CD entries will have the stall bit set when
> > writing entries into the table.
> > 
> > Signed-off-by: Michael Shavit <mshavit@google.com>
> > ---
> > 
> > Changes in v2:
> > - Use a bitfield instead of a bool for stall_enabled
> > 
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 ++-
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 8a286e3838d70..654acf6002bf3 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1114,7 +1114,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> >                         FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> >                         CTXDESC_CD_0_V;
> > 
> > -               if (smmu_domain->stall_enabled)
> > +               if (smmu_domain->cd_table.stall_enabled)
> >                         val |= CTXDESC_CD_0_S;
> 
> This cd_table->stall_enabled comes from master->stall_enabled, and
> cd_table will be in master structure. Also, struct arm_smmu_master
> pointer will be passed in to arm_smmu_write_ctx_desc(). So, there
> seems to be no need of master->cd_table.stall_enabled in the end;
> just use master->stall_enabled directly?

Actually the stall_enabled might still need to be per-CD/domain.
If a domain is attached by two masters. The domain->stall_enabled
is initialized with the first master->stall_enabled. Then, the
second master->stall_enabled would be required to match with the
domain->stall_enabled. arm_smmu_attach_dev() has such a sanity.

So, I think we might not need this patch.

Nicolin
