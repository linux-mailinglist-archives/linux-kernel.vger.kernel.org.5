Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6157377FC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353786AbjHQQ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352958AbjHQQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:59:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE72D72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH62pqkolvGotqjrMrfVQ8+vrJy36/LIraRpKj8ZYNYaQZ8iNX+ugNaVKvoQkKjt5+3zRUUebRRTpE15dy8MotHINiVqRi2Nu0aAcP0r8SRC6DQMyPgGrtWsc8hWEmP9KsPY+nCioxaSMc8PnF8jobLWuL+z4p4GdIOmJnZqAvm1VAJ2VQXBcFAurHGF/Nmie1UAsswRRVRg/4E3hw7JhaqqBwIUbRYERXCYIwqtjp8t2uruAJrjQ25Xhg8Hrrv44oROs1hEkW2JaVEUCh2lvWW6b3FjmXN789KlgVJ+5Y4oLergngjqm77ZG8kprdMF4IC1N8+a51GZgAsf0bjsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feZ4cB5LkndOhYDuGf8hzHBus2tt5LRnLatQ979U3ZI=;
 b=Hit8+PlgmiiXXq/omQY6ExqV5uitx0Jvq+15QkukkuWrGhzJ8sKbEuW6GVooBHSs/RoLGSezSMe/NHZqrqjtdyc87Mctn0Pf5mrGh9VgitgV1uGp1YEcn0cl48LI5mGFz115RC5lRNYl3Lp17sgs8Vhma7HvdT2x7oqsEkg9iz/v+VanhLJ/tTiX+i0hx1YeXAlvz1ALLCE1TN85z4CFZz/55yDk1AO/le84X2wVt7SEviMG/8psZJok4W0DJxbSSpz/tA31kqThcJxjR59pMX+yWspHxCT/UYXNU8qEZQH4COhqVjr8jRgjkRTOwrEc+Jp4pE7iNG1+Giug9DCURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feZ4cB5LkndOhYDuGf8hzHBus2tt5LRnLatQ979U3ZI=;
 b=d/bBRJRanS58B5kptL7aKGiFoIPzyFSsHU4yCwYmPrkriiBm7Hp09YwfSY5v7cDQIrIhnR6irGsg802H2jf6Zy0+4aAGECuVZ5kV/Dl/0YdIm2IB0c0cmsJkTfjtq8WI7kI3e+aD+qZTLwR6JluQsw0GJ6b0wUXJm2B+riAbt/yC05jEmw2qKVrd7ezFOYnsuXDOiBq63ZD9WSX7IoEXbIKwYobZgrXCalbpYau4Pd+2aitIidWoy9Uo40WivijSw81Lb0T8dXXTZWDVd5oFmeWeBlWW64lzaNViOGf0OMsTnxmJjfwUjW+mB4T47cA11Phku/Ad2J9ssQGUGhIwkw==
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 16:59:07 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::73) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 17 Aug 2023 16:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 16:59:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 09:58:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 17 Aug 2023 09:58:56 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 09:58:56 -0700
Date:   Thu, 17 Aug 2023 09:58:54 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <joro@8bytes.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Allow default substream bypass
 with a pasid support
Message-ID: <ZN5RzvGhwRvVKUDy@Asurada-Nvidia>
References: <20230817042135.32822-1-nicolinc@nvidia.com>
 <ZN46upjIBFcI4mL+@nvidia.com>
 <9ba29982-ae96-bf53-f021-21cb1b22643a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ba29982-ae96-bf53-f021-21cb1b22643a@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b21332c-94e9-4cf3-2e5e-08db9f43450a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quoh3X50ZpLORmW4NpetisFKh6JQTlX19mdtl5JX/CRKCxMIFsn4LEQbNiXeovMhZdYuy9N+62Q54ieClJkqAMZnaQs/fbkFbgYBfLdMdRpMTuLLgFBMQHODBxQ/TwEZprvp4pyX7Bi6f3CoKkFlszh7nXjTIqLHObxkqwYr9OObViWILtCZIcOLzn5l7+st9Yb76y7f5e0NMvUOGTHgRK0GBwE+bcTxGFRwMF399a9RPktqhr8LbNU0Ug2+NRXgdNjvPx9TQJ2xBsc4qwsYazvJ3k7zCzSn+1/AW6L2qyjLYWF2aAHyhMTmhAOnhBll9m+nuvX4IhSIRGJ65dM9HVJ2tClTXOA/gel7En2jSCj+2El0ibeOE61qBQIWCdwgZ+UW2HB3dzzSiMnNirfstKe7q010da4e7pbnM+QSAx8kLIt76oIuBHZdTJsXXox78mjBscpk9mEcPN3LgoIALMANynZMpJ9pObJYx/7X9FAsfK8jrWlhSVR1qwEc+O4V1lS5n/z5CDpgMcEt191QohJ+YjNNe/lQD6j8v3Qpn/BYOkRXdgCb7FbjNZ17j8lmkyl8VL8dUcEU6m8iREOISmacu8/pc6B17xG690VgVQBcr3JrKIo8HF0COwgKm6cXfJRgQjns643ksOCiDSV8dqv2/O0idVO+Vy3gBAOrL4UcRrh/jDm5Z6zidyHr3Pjc5P+nEQe18MAlJKtg46Z6gWxS9taHQ5HL+mAS/CwsW8D+OFpvVCYWl1wsUc1EgH4zuPsbs4kEmwH2d8yS+hOUC4oH1sbf+MSX6qPIFz/pkdEOJ06TajD6Kj4JZIw854FRpe5ozRriMTjeLwbpraYxczAutPbDKCptS+WNBDtmmVi+Sp0wJ42g30lHJ/NkEs6M
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(55016003)(40480700001)(40460700003)(47076005)(426003)(83380400001)(2906002)(336012)(36860700001)(70586007)(478600001)(70206006)(54906003)(316002)(966005)(110136005)(5660300002)(8936002)(41300700001)(4326008)(8676002)(9686003)(26005)(86362001)(82740400003)(33716001)(356005)(7636003)(414714003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 16:59:07.1727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b21332c-94e9-4cf3-2e5e-08db9f43450a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you both for the reviews!

On Thu, Aug 17, 2023 at 05:24:51PM +0100, Robin Murphy wrote:

> > > Changelog
> > > v2:
> > >   * Rebased on top of Michael's series reworking CD table ownership:
> > >     https://lore.kernel.org/all/20230816131925.2521220-1-mshavit@google.com/
> > >   * Added a new ARM_SMMU_DOMAIN_BYPASS_S1DSS stage to tag the use case
> > > v1: https://lore.kernel.org/all/20230627033326.5236-1-nicolinc@nvidia.com/
> > 
> > After rebasing there really shouldn't be a
> > ARM_SMMU_DOMAIN_BYPASS_S1DSS. I want to get to a model where the
> > identity domain is a global static, so it can't be changing depending
> > on how it is attched.
> > 
> > I continue to think that the right way to think about this is to have
> > the CD table code generate the STE it wants and when doing so it will
> > inspect what SSID0 is. If it is the IDENTITY domain then it fills
> > s1dss / etc
> 
> Indeed, that's what I was getting at with "generalisation of
> ARM_SMMU_DOMAIN_BYPASS based on s1cdmax" - just one type all the way
> down to the bowels of arm_smmu_write_strtab_ent(), which then decides
> whether it means touching S1DSS or Config in the given STE.

Ack. Let me retry with that.

> > > @@ -1290,6 +1291,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> > > 
> > >      if (smmu_domain) {
> > >              switch (smmu_domain->stage) {
> > > +            case ARM_SMMU_DOMAIN_BYPASS_S1DSS:
> > > +                    s1dss = STRTAB_STE_1_S1DSS_BYPASS;
> > > +                    fallthrough;
> > >              case ARM_SMMU_DOMAIN_S1:
> > >                      cd_table = &master->cd_table;
> > >                      break;
> > 
> > Eg, I think the code looks much nicer if the logic here is more like:
> > 
> > if (master->cd_table.cdtab)
> >     arm_smmu_cd_table_get_ste(master->cd_table, &ste)

So, this means that cd_table is present, indicating either "S1
translated" or "S1 enabled but S1DSS"...

> > else if (master->domain)
> >     arm_smmu_domain_get_ste(master->domain, &ste);

... and this means that cd_table isn't present, indicating S1
bypass or S2....

> > else
> >     ste = not attached
> > 
> > And you'd check in arm_smmu_cd_table_get_ste() to learn the CD
> > parameters and also what SSID=0 is. If SSID=0 is IDENTITY then
> > arm_smmu_cd_table_get_ste would return with S1DSS set.
> > 
> > arm_smmu_domain_get_ste() would multiplex based on the domain type.

... it then means we need arm_smmu_write_ctx_desc() also when
attaching an IDENTITY domain.

Will try with that. Thanks for the guidance!

> > > @@ -2435,6 +2440,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >      } else if (smmu_domain->smmu != smmu)
> > >              ret = -EINVAL;
> > > 
> > > +    /*
> > > +     * When attaching an IDENTITY domain to a master with pasid capability,
> > > +     * the master can still enable SVA feature by allocating a multi-entry
> > > +     * CD table and attaching the IDENTITY domain to its default substream
> > > +     * that alone can be byassed using the S1DSS field of the STE.
> > > +     */
> > > +    if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS && master->ssid_bits &&
> > > +        smmu->features & ARM_SMMU_FEAT_TRANS_S1)
> > > +            smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS_S1DSS;
> > 
> > Then you don't technically need to do this.

Yea, wasn't so confident about it either. Will drop.

> > > @@ -2456,7 +2471,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >      list_add(&master->domain_head, &smmu_domain->devices);
> > >      spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > > 
> > > -    if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > > +    if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ||
> > > +        smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS_S1DSS) {
> > >              if (!master->cd_table.cdtab) {
> > >                      ret = arm_smmu_alloc_cd_tables(master);
> > >                      if (ret) {
> > 
> > So more like:
> > 
> >   if (smmu_domain == IDENTIY && arm_smmu_support_ssid(dev))
> >       arm_smmu_alloc_cd_tables()

OK. ARM_SMMU_DOMAIN_S1 with ssid=0 still needs a cd_table though.

Thanks!
Nic
