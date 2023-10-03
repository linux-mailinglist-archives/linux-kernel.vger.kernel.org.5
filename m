Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA87B6B40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbjJCOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbjJCOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:20:29 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ECFA3;
        Tue,  3 Oct 2023 07:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaIVo5fmpqy/hY/7JC7A5OADtH36DiDDxIdb7lUSZljKXiBIxlF9MIMvQCEKlHTZ5M1wBS1DmbUEqUMudqJbv5k4xdI2N3OwdTyk7ky2khn7g4jOu/OpZZoIJ2tWn7u4zf+l3mYLdaqOr8HaOWx3jBjHtrTZLmc+pRYLdxIikhpxhDHJSyXBdRTDP5GZwt+l3daMqwr9GrHwjJqfur/VlE0ou5elI2l/l85fDkPgttixmul3947JnXRq9t5s0CUXfXdjzs0A81ZYqi16WlOsJ2TK2HLBuipiQb4A8VlKZ0Vk0QKzEoD49gtbEyD58lXEvXZgOEoFzEt/Ag4bvxC25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t8+jFTeBazUwWier15NcEfLl4iBdzpbbvu31WqWdP8=;
 b=PBtPkLxyIDBidWd8IGcPE6D22s1tr02VIQ4a/jol9/BBSDilNjMrgfMMgAry6syN1WMt/c78r6AQr9YiPTyH+vjpoh20jfjJdeaSLhTeyK2sO0LQPGvnerXYP53pp3p/O35xEA2VysIRayf174qFqcVnTwIiSF1Y5RXtxI+LUB7850EII1WKbKe2JB3+BzZVQVbkjUsvjEdHUTVLZ5f4SA5RfSUkynBMMIYpu8p9NkO1WuWUDilu1E5IhhYwMMAxCR+ehTNO3PaJZCmX3LEeLIw7U/zpqyZDZUC/vy0CeiQR200i+Aqi0QoDEEX6SqI3ceKStELwp6V6gQVHwX8FXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t8+jFTeBazUwWier15NcEfLl4iBdzpbbvu31WqWdP8=;
 b=FZ0iqi5YtW/kE7MVaPZ1al1ZLWTylJvkNoQIPCbWaplYQ9WH3N9LTSsqY9WbmYPHf7BA2gbBqrR2m6pFl2ObmSLj9eqjwPJExwlxHXJGW9+pwU84lxLd9gwLs+tXSiF//6VUGzw+F/fmMp9smzp7EPVM2pYmu9U+BBgmV9dEr7phG1HHUIdPJt+F+wwU7HGw5MSi6ahpBHdPAbJQoVYcpXxD461KNMEc01UFHniBhPaqC5Z8wHUE+YvVtT9EXY5KF1fidj4t5FvsMpY0uWyRZVT6HrXt1Kxn/qefC4WAoiCfDSVpYdq4YZU+KOwreI3rWR3i59NofEkFqhobRotBGA==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 14:20:21 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::b6bd:1fee:8929:c8c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::b6bd:1fee:8929:c8c%6]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 14:20:20 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>,
        Eric Funsten <efunsten@nvidia.com>
Subject: RE: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
Thread-Topic: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
Thread-Index: AQHZ1IWLIn+E4dzUnkasUE8WeMKaq7AaxuoAgB2YpRA=
Date:   Tue, 3 Oct 2023 14:20:19 +0000
Message-ID: <SJ0PR12MB5676E06544970DD8D139F9B5A0C4A@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230821231608.50911-1-bwicaksono@nvidia.com>
 <f3784fae-154e-784b-bbf2-72dc6ecaf9e9@os.amperecomputing.com>
In-Reply-To: <f3784fae-154e-784b-bbf2-72dc6ecaf9e9@os.amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|PH8PR12MB7208:EE_
x-ms-office365-filtering-correlation-id: 66b6505f-fdbb-4877-e146-08dbc41bdfc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1PIZ7VPvqfeqHjvRY5vRhQ7/KsE7zdUFhiBzm9yJbkgnJWicVMLkvZSjTPDCCH1rU5RoRg0KE/7d4Dep3MZlbCAoPLjuZ0dfawxtoyhGhL47eYl5KZW/BNAOZuyblBwAYbEJGDGdcpJeHYoyB6/JVqlpCFe2Wj+6Fw++cn2hiELmK6rlau6RZTuASmJxTrZZ8Xg5IVB04W/HMR3/2sgTVo5O/Yk0mdPG9Uh+A+BNTglgKAUZJ9PsAslv4Sq2mqTiA0xFKBUrXI3Fr1ZSLOOBIxYJ9kw6hPieI4FjPXWW8mu2RR5WU1psPI1M4l7CnU/gZ8elTloolaORAeMGg08tvLs40Si5DYp/O1xVfR88/MtiyQVJ8gp8bjPEBHuJIyXWn/8elnKyqIiiN8vLZIOqOwcFjHNNldQPY4GWbWwHt9x6mC+8ErLVAls0Pk2wk5bNNq4id85lk8FWyp11Qbft4agg5jVqlHDNr6MPyQMsyvdpXu6exflJ2IdijJ4+tkZ0FuOSOBNqxMPsmW7yjrr8679awj9T9d2B0XEqhMBkObHK60umJwcmt/CvbhSJtU9upNf14ISFtjnVimsvFbduzGOOdZRbJKek6e+ye1Vhnb271G5yvKGepaug7wFmbTV4cqWARwxzgXb+gdxyGQYMsxWzgLVMztiRmQACowidefeijRLECUH90KsEpqA2t5uJNDz56fUlp4HGZPEcydo/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(107886003)(52536014)(8936002)(66556008)(66946007)(8676002)(4326008)(5660300002)(41300700001)(54906003)(64756008)(66446008)(316002)(66476007)(478600001)(71200400001)(30864003)(53546011)(2906002)(76116006)(966005)(110136005)(6506007)(7696005)(26005)(9686003)(55016003)(83380400001)(122000001)(38100700002)(86362001)(38070700005)(33656002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P2n1mHBefnhEOOLQPWkeylVG2zHnkN3iNJRzbcbZederyRmj8aCxyFjyU7YG?=
 =?us-ascii?Q?z+/wpgc6+fADqkEU5ysmO23t80qSgJD6TJbgOA6ZvUqROAbHqDaQdJ6pEtLu?=
 =?us-ascii?Q?SwcT/ghDD+gqmhlUQIgYtk/zbQUoEwabD68RQZgqRn6z/KAw2UqQLopmdXJ+?=
 =?us-ascii?Q?VRju0x58+FJjb8DU5bdjq90GRDzKLcbi07uYdV2o0nGwbNu28gJ1HbFUeBh0?=
 =?us-ascii?Q?C1kokeEdBq+v3TxFEZwY55gRqexEsCv0Umq22dgAFD9UkHDp6sE/qv0K0Xo/?=
 =?us-ascii?Q?OWgl6eRNr46CfPbV6ZILfvJmikXndaN0kz9EG0J67l8czudlkvK3BnVUQz9J?=
 =?us-ascii?Q?GLv5ycHxllsUJ5Nrx/wzO92CY6oMhx70GRwb3VkotitsttKRLzjrQZdaiC5T?=
 =?us-ascii?Q?nR5hBqPz/np4dWhJ0rymYdX9fcNiZ/0o3piZvqzCQYhCTwJrPDMHnl57Kre9?=
 =?us-ascii?Q?U3UygX6tEAHHNn50o6bhGda8ViXpmZzZO42e5lUDlf5fMvhfplPRcnoViboJ?=
 =?us-ascii?Q?nH4iExHwGG5sxkIQC4l+07DuazLGsCYf6UT5NgVt+8sVqGO/cYpqxRfV+P+s?=
 =?us-ascii?Q?vvybdFUK9/51gX+alCQlH86WsauoH/mx2olLVMtVrAlfE1ZGfB+ReHbcAF3S?=
 =?us-ascii?Q?ONjfpaFdz1md2BSCeqWYp+R+xgvNznREMhy4jR2+4w8oGAWhEsGpisSUDj5g?=
 =?us-ascii?Q?GywCp3FD07zMHF7sNbFRzRmKCWmZ05hcf6ROu8wgofo3LmkO3xQKh8XmrWU2?=
 =?us-ascii?Q?Yp95qdFQAOD2Gg0oayBLdVwg3rBjje0Nahpy0C3WbjPt9AQgyg96pJiAcbZn?=
 =?us-ascii?Q?4ZCZhio+bd+ou0xl7tkJyv7UvJVuBynRyWSIFf3Q5+DpZcRS7N7GkDS7f2pL?=
 =?us-ascii?Q?X/Id8i7QdZc32gsCGwrvOI6oK0yDebWyi2mbKOskceS91G2gTe22x+Clyrkb?=
 =?us-ascii?Q?cEJKBmer81duK0x4v8h/W6QVHFcrG7eQo4SD+F5TIk0kyd5Lez5dyfXgu1hl?=
 =?us-ascii?Q?E2vBfytT4HlXVQZXJkaEPSekNUNXD095SKX1odQR06iT9tNRsZ7SQyzJbu4V?=
 =?us-ascii?Q?xwf3DRFz9PJ0i5fF/DwkrWgG+eodlpSrEUv34Hyrn7yMPoao29WDVNirdtXH?=
 =?us-ascii?Q?br+JhgTkDH6rUe5Y8YUpmix2PzdFLOGGReJKeL1NsDKizeCnJQcnWO3av3pX?=
 =?us-ascii?Q?6BP3ygSJrxDsaMP/nnFNtmKhxhoWX2y4lvftj26KYJYFnAwWsjeOsfnbC8S6?=
 =?us-ascii?Q?Nw+b3TYcMg8kh09c4raotR9TGeHyDu1fWQHayoVpZh+C/1rdecMKkiEP43jb?=
 =?us-ascii?Q?yIqshjiIxqPvmB+T4SVyZ1dcrwjYQHZhMQsKzKAkWg39GcKimstjLQxxGplV?=
 =?us-ascii?Q?TgSIJ99B4W2n6tK9gilJalILBmivv4uAOmurwr8vsB6rcS5u1e7SosRc7GPS?=
 =?us-ascii?Q?1GM3W6lzOx5G/AIic9ZczCFG+gSIw2CDgxikkIOyXyBvvxUATt16ODO1tAQq?=
 =?us-ascii?Q?80H7vuETeTFsVY9+wqnyEGeY4KmlSml8GltMsuews++lCQg8byPlz0Tmnv3Y?=
 =?us-ascii?Q?osJnHDDhMt4EvQqN2w70iUVs+aS0CCwiG7py4iYg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b6505f-fdbb-4877-e146-08dbc41bdfc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 14:20:20.0378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1FSXBs1ylY/wd562z5tm68+5rivg1uXn+Xbskm5heHNTWNr72ZaEAn6zOSghjiDnFabqT9e1qOWPLlHJkkjvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7208
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ilkka.
Suzuki/Robin, can we have someone from Arm to review this patch ? It's been=
 a while.

Regards,
Besar

> -----Original Message-----
> From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Sent: Thursday, September 14, 2023 1:19 PM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> ilkka@os.amperecomputing.com; catalin.marinas@arm.com; will@kernel.org;
> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; Richard Wiley <rwiley@nvidia.com>; Eric Funste=
n
> <efunsten@nvidia.com>
> Subject: Re: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Besar,
>=20
> On Mon, 21 Aug 2023, Besar Wicaksono wrote:
> > Arm Coresight PMU driver consists of main standard code and
> > vendor backend code. Both are currently built as a single module.
> > This patch adds vendor registration API to separate the two to
> > keep things modular. The main driver requests each known backend
> > module during initialization and defer device binding process.
> > The backend module then registers an init callback to the main
> > driver and continue the device driver binding process.
> >
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
>=20
> I tested the patch with AmpereOne patchset on top of it and it seemed to
> work fine. In addition, the patch looks good to me.
>=20
> Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>=20
>=20
> Cheers, Ilkka
>=20
> > ---
> >
> > Changes from v5:
> > * Incorporate review comments.
> > * Fix arm_cspmu_impl_match_get not returning NULL if no matching impl.
> > * Fix impl_match.module may reset when registering PMU.
> > * Maintain backend module ref count until PMU registration is done.
> > Thanks to Will, Suzuki, and Robin for the feedback.
> > v5: https://lore.kernel.org/linux-arm-kernel/20230705104745.52255-1-
> bwicaksono@nvidia.com/T/#u
> >
> > Changes from v4:
> > * Fix warning reported by kernel test robot
> > v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-
> bwicaksono@nvidia.com/T/#u
> >
> > Changes from v3:
> > * Move impl registration module back to main driver module.
> > * Rebase from will (for-next/perf)
> > Thanks to Robin for the feedback.
> > v3: https://lore.kernel.org/linux-arm-kernel/20230505005956.22837-1-
> bwicaksono@nvidia.com/T/#u
> >
> > Changes from v2:
> > * Move sysfs_event/format_show definition to arm_cspmu.h and move impl
> >   registration API definition to a separate module so main driver and v=
endor
> >   module are independent.
> > * The registration API now just sets the impl_init_ops callback, no rep=
robe.
> > * Add PMIIDR table that maps to the vendor module name. During device
> probe,
> >   main driver requests the vendor module if PMIIDR is matching.
> > * Keeping the name of the main driver module as arm_cspmu_module.
> > Thanks to Robin and Suzuki for the feedback.
> > v2:  https://lore.kernel.org/linux-arm-kernel/20230418062030.45620-1-
> bwicaksono@nvidia.com/T/#u
> >
> > Changes from v1:
> > * Added separate Kconfig entry for nvidia backend
> > * Added lock to protect accesses to the lists
> > * Added support for matching subset devices from a vendor
> > * Added state tracking to avoid reprobe when a device is in use
> > Thanks to Suzuki for the feedback.
> > v1: https://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-
> bwicaksono@nvidia.com/T/#u
> >
> > ---
> > drivers/perf/arm_cspmu/Kconfig        |   9 +-
> > drivers/perf/arm_cspmu/Makefile       |   6 +-
> > drivers/perf/arm_cspmu/arm_cspmu.c    | 168 ++++++++++++++++++++---
> ---
> > drivers/perf/arm_cspmu/arm_cspmu.h    |  25 +++-
> > drivers/perf/arm_cspmu/nvidia_cspmu.c |  34 +++++-
> > drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 ---
> > 6 files changed, 199 insertions(+), 60 deletions(-)
> > delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
> >
> > diff --git a/drivers/perf/arm_cspmu/Kconfig
> b/drivers/perf/arm_cspmu/Kconfig
> > index 25d25ded0983..d5f787d22234 100644
> > --- a/drivers/perf/arm_cspmu/Kconfig
> > +++ b/drivers/perf/arm_cspmu/Kconfig
> > @@ -1,6 +1,6 @@
> > # SPDX-License-Identifier: GPL-2.0
> > #
> > -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> > +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> >
> > config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> >       tristate "ARM Coresight Architecture PMU"
> > @@ -10,3 +10,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> >         based on ARM CoreSight PMU architecture. Note that this PMU
> >         architecture does not have relationship with the ARM CoreSight
> >         Self-Hosted Tracing.
> > +
> > +config NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> > +     tristate "NVIDIA Coresight Architecture PMU"
> > +     depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> > +     help
> > +       Provides NVIDIA specific attributes for performance monitoring =
unit
> > +       (PMU) devices based on ARM CoreSight PMU architecture.
> > diff --git a/drivers/perf/arm_cspmu/Makefile
> b/drivers/perf/arm_cspmu/Makefile
> > index fedb17df982d..0309d2ff264a 100644
> > --- a/drivers/perf/arm_cspmu/Makefile
> > +++ b/drivers/perf/arm_cspmu/Makefile
> > @@ -1,6 +1,8 @@
> > -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> > +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> > #
> > # SPDX-License-Identifier: GPL-2.0
> >
> > obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=3D
> arm_cspmu_module.o
> > -arm_cspmu_module-y :=3D arm_cspmu.o nvidia_cspmu.o
> > +arm_cspmu_module-y :=3D arm_cspmu.o
> > +
> > +obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=3D
> nvidia_cspmu.o
> > diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
> b/drivers/perf/arm_cspmu/arm_cspmu.c
> > index e2b7827c4563..c59f1e5a35a3 100644
> > --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> > +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> > @@ -16,7 +16,7 @@
> >  * The user should refer to the vendor technical documentation to get d=
etails
> >  * about the supported events.
> >  *
> > - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> > + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All right=
s
> reserved.
> >  *
> >  */
> >
> > @@ -26,11 +26,11 @@
> > #include <linux/interrupt.h>
> > #include <linux/io-64-nonatomic-lo-hi.h>
> > #include <linux/module.h>
> > +#include <linux/mutex.h>
> > #include <linux/perf_event.h>
> > #include <linux/platform_device.h>
> >
> > #include "arm_cspmu.h"
> > -#include "nvidia_cspmu.h"
> >
> > #define PMUNAME "arm_cspmu"
> > #define DRVNAME "arm-cs-arch-pmu"
> > @@ -112,11 +112,10 @@
> >  */
> > #define HILOHI_MAX_POLL       1000
> >
> > -/* JEDEC-assigned JEP106 identification code */
> > -#define ARM_CSPMU_IMPL_ID_NVIDIA             0x36B
> > -
> > static unsigned long arm_cspmu_cpuhp_state;
> >
> > +static DEFINE_MUTEX(arm_cspmu_lock);
> > +
> > static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
> > {
> >       return *(struct acpi_apmt_node **)dev_get_platdata(dev);
> > @@ -373,27 +372,37 @@ static struct attribute_group
> arm_cspmu_cpumask_attr_group =3D {
> >       .attrs =3D arm_cspmu_cpumask_attrs,
> > };
> >
> > -struct impl_match {
> > -     u32 pmiidr;
> > -     u32 mask;
> > -     int (*impl_init_ops)(struct arm_cspmu *cspmu);
> > -};
> > -
> > -static const struct impl_match impl_match[] =3D {
> > +static struct arm_cspmu_impl_match impl_match[] =3D {
> >       {
> > -       .pmiidr =3D ARM_CSPMU_IMPL_ID_NVIDIA,
> > -       .mask =3D ARM_CSPMU_PMIIDR_IMPLEMENTER,
> > -       .impl_init_ops =3D nv_cspmu_init_ops
> > +             .module_name    =3D "nvidia_cspmu",
> > +             .pmiidr_val     =3D ARM_CSPMU_IMPL_ID_NVIDIA,
> > +             .pmiidr_mask    =3D ARM_CSPMU_PMIIDR_IMPLEMENTER,
> > +             .module         =3D NULL,
> > +             .impl_init_ops  =3D NULL,
> >       },
> > -     {}
> > +     {0}
> > };
> >
> > +static struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32
> pmiidr)
> > +{
> > +     struct arm_cspmu_impl_match *match =3D impl_match;
> > +
> > +     for (; match->pmiidr_val; match++) {
> > +             u32 mask =3D match->pmiidr_mask;
> > +
> > +             if ((match->pmiidr_val & mask) =3D=3D (pmiidr & mask))
> > +                     return match;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
> > {
> > -     int ret;
> > +     int ret =3D 0;
> >       struct arm_cspmu_impl_ops *impl_ops =3D &cspmu->impl.ops;
> >       struct acpi_apmt_node *apmt_node =3D arm_cspmu_apmt_node(cspmu-
> >dev);
> > -     const struct impl_match *match =3D impl_match;
> > +     struct arm_cspmu_impl_match *match;
> >
> >       /*
> >        * Get PMU implementer and product id from APMT node.
> > @@ -405,17 +414,36 @@ static int arm_cspmu_init_impl_ops(struct
> arm_cspmu *cspmu)
> >                                      readl(cspmu->base0 + PMIIDR);
> >
> >       /* Find implementer specific attribute ops. */
> > -     for (; match->pmiidr; match++) {
> > -             const u32 mask =3D match->mask;
> > +     match =3D arm_cspmu_impl_match_get(cspmu->impl.pmiidr);
> > +
> > +     /* Load implementer module and initialize the callbacks. */
> > +     if (match) {
> > +             mutex_lock(&arm_cspmu_lock);
> > +
> > +             if (match->impl_init_ops) {
> > +                     /* Prevent unload until PMU registration is done.=
 */
> > +                     if (try_module_get(match->module)) {
> > +                             cspmu->impl.module =3D match->module;
> > +                             cspmu->impl.match =3D match;
> > +                             ret =3D match->impl_init_ops(cspmu);
> > +                             if (ret)
> > +                                     module_put(match->module);
> > +                     } else {
> > +                             WARN(1, "arm_cspmu failed to get module: =
%s\n",
> > +                                     match->module_name);
> > +                             ret =3D -EINVAL;
> > +                     }
> > +             } else {
> > +                     request_module_nowait(match->module_name);
> > +                     ret =3D -EPROBE_DEFER;
> > +             }
> >
> > -             if ((match->pmiidr & mask) =3D=3D (cspmu->impl.pmiidr & m=
ask)) {
> > -                     ret =3D match->impl_init_ops(cspmu);
> > -                     if (ret)
> > -                             return ret;
> > +             mutex_unlock(&arm_cspmu_lock);
> >
> > -                     break;
> > -             }
> > -     }
> > +             if (ret)
> > +                     return ret;
> > +     } else
> > +             cspmu->impl.module =3D THIS_MODULE;
> >
> >       /* Use default callbacks if implementer doesn't provide one. */
> >       CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
> > @@ -478,11 +506,6 @@ arm_cspmu_alloc_attr_group(struct arm_cspmu
> *cspmu)
> >       struct attribute_group **attr_groups =3D NULL;
> >       struct device *dev =3D cspmu->dev;
> >       const struct arm_cspmu_impl_ops *impl_ops =3D &cspmu->impl.ops;
> > -     int ret;
> > -
> > -     ret =3D arm_cspmu_init_impl_ops(cspmu);
> > -     if (ret)
> > -             return NULL;
> >
> >       cspmu->identifier =3D impl_ops->get_identifier(cspmu);
> >       cspmu->name =3D impl_ops->get_name(cspmu);
> > @@ -1149,7 +1172,7 @@ static int arm_cspmu_register_pmu(struct
> arm_cspmu *cspmu)
> >
> >       cspmu->pmu =3D (struct pmu){
> >               .task_ctx_nr    =3D perf_invalid_context,
> > -             .module         =3D THIS_MODULE,
> > +             .module         =3D cspmu->impl.module,
> >               .pmu_enable     =3D arm_cspmu_enable,
> >               .pmu_disable    =3D arm_cspmu_disable,
> >               .event_init     =3D arm_cspmu_event_init,
> > @@ -1196,11 +1219,17 @@ static int arm_cspmu_device_probe(struct
> platform_device *pdev)
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D arm_cspmu_register_pmu(cspmu);
> > +     ret =3D arm_cspmu_init_impl_ops(cspmu);
> >       if (ret)
> >               return ret;
> >
> > -     return 0;
> > +     ret =3D arm_cspmu_register_pmu(cspmu);
> > +
> > +     /* Matches arm_cspmu_init_impl_ops() above. */
> > +     if (cspmu->impl.module !=3D THIS_MODULE)
> > +             module_put(cspmu->impl.module);
> > +
> > +     return ret;
> > }
> >
> > static int arm_cspmu_device_remove(struct platform_device *pdev)
> > @@ -1300,6 +1329,75 @@ static void __exit arm_cspmu_exit(void)
> >       cpuhp_remove_multi_state(arm_cspmu_cpuhp_state);
> > }
> >
> > +int arm_cspmu_impl_register(const struct arm_cspmu_impl_match
> *impl_match)
> > +{
> > +     struct arm_cspmu_impl_match *match;
> > +     int ret =3D 0;
> > +
> > +     match =3D arm_cspmu_impl_match_get(impl_match->pmiidr_val);
> > +
> > +     if (match) {
> > +             mutex_lock(&arm_cspmu_lock);
> > +
> > +             if (!match->impl_init_ops) {
> > +                     match->module =3D impl_match->module;
> > +                     match->impl_init_ops =3D impl_match->impl_init_op=
s;
> > +             } else {
> > +                     /* Broken match table may contain non-unique entr=
ies */
> > +                     WARN(1, "arm_cspmu backend already registered for=
 module:
> %s, pmiidr: 0x%x, mask: 0x%x\n",
> > +                             match->module_name,
> > +                             match->pmiidr_val,
> > +                             match->pmiidr_mask);
> > +
> > +                     ret =3D -EINVAL;
> > +             }
> > +
> > +             mutex_unlock(&arm_cspmu_lock);
> > +
> > +             if (!ret)
> > +                     ret =3D driver_attach(&arm_cspmu_driver.driver);
> > +     } else {
> > +             pr_err("arm_cspmu reg failed, unable to find a match for =
pmiidr:
> 0x%x\n",
> > +                     impl_match->pmiidr_val);
> > +
> > +             ret =3D -EINVAL;
> > +     }
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
> > +
> > +static int arm_cspmu_match_device(struct device *dev, const void *matc=
h)
> > +{
> > +     struct arm_cspmu *cspmu =3D
> platform_get_drvdata(to_platform_device(dev));
> > +
> > +     return (cspmu && cspmu->impl.match =3D=3D match) ? 1 : 0;
> > +}
> > +
> > +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match
> *impl_match)
> > +{
> > +     struct device *dev;
> > +     struct arm_cspmu_impl_match *match;
> > +
> > +     match =3D arm_cspmu_impl_match_get(impl_match->pmiidr_val);
> > +
> > +     if (WARN_ON(!match))
> > +             return;
> > +
> > +     /* Unbind the driver from all matching backend devices. */
> > +     while ((dev =3D driver_find_device(&arm_cspmu_driver.driver, NULL=
,
> > +                     match, arm_cspmu_match_device)))
> > +             device_release_driver(dev);
> > +
> > +     mutex_lock(&arm_cspmu_lock);
> > +
> > +     match->module =3D NULL;
> > +     match->impl_init_ops =3D NULL;
> > +
> > +     mutex_unlock(&arm_cspmu_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
> > +
> > module_init(arm_cspmu_init);
> > module_exit(arm_cspmu_exit);
> >
> > diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h
> b/drivers/perf/arm_cspmu/arm_cspmu.h
> > index 83df53d1c132..7936a90ded7f 100644
> > --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> > +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> > @@ -1,7 +1,7 @@
> > /* SPDX-License-Identifier: GPL-2.0
> >  *
> >  * ARM CoreSight Architecture PMU driver.
> > - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> > + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All right=
s
> reserved.
> >  *
> >  */
> >
> > @@ -69,6 +69,9 @@
> > #define ARM_CSPMU_PMIIDR_IMPLEMENTER  GENMASK(11, 0)
> > #define ARM_CSPMU_PMIIDR_PRODUCTID    GENMASK(31, 20)
> >
> > +/* JEDEC-assigned JEP106 identification code */
> > +#define ARM_CSPMU_IMPL_ID_NVIDIA     0x36B
> > +
> > struct arm_cspmu;
> >
> > /* This tracks the events assigned to each counter in the PMU. */
> > @@ -106,9 +109,23 @@ struct arm_cspmu_impl_ops {
> >                                        struct attribute *attr, int unus=
ed);
> > };
> >
> > +/* Vendor/implementer registration parameter. */
> > +struct arm_cspmu_impl_match {
> > +     /* Backend module. */
> > +     struct module *module;
> > +     const char *module_name;
> > +     /* PMIIDR value/mask. */
> > +     u32 pmiidr_val;
> > +     u32 pmiidr_mask;
> > +     /* Callback to vendor backend to init arm_cspmu_impl::ops. */
> > +     int (*impl_init_ops)(struct arm_cspmu *cspmu);
> > +};
> > +
> > /* Vendor/implementer descriptor. */
> > struct arm_cspmu_impl {
> >       u32 pmiidr;
> > +     struct module *module;
> > +     struct arm_cspmu_impl_match *match;
> >       struct arm_cspmu_impl_ops ops;
> >       void *ctx;
> > };
> > @@ -147,4 +164,10 @@ ssize_t arm_cspmu_sysfs_format_show(struct
> device *dev,
> >                                   struct device_attribute *attr,
> >                                   char *buf);
> >
> > +/* Register vendor backend. */
> > +int arm_cspmu_impl_register(const struct arm_cspmu_impl_match
> *impl_match);
> > +
> > +/* Unregister vendor backend. */
> > +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match
> *impl_match);
> > +
> > #endif /* __ARM_CSPMU_H__ */
> > diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> > index 72ef80caa3c8..0382b702f092 100644
> > --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> > +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> > @@ -1,14 +1,15 @@
> > // SPDX-License-Identifier: GPL-2.0
> > /*
> > - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> > + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All right=
s
> reserved.
> >  *
> >  */
> >
> > /* Support for NVIDIA specific attributes. */
> >
> > +#include <linux/module.h>
> > #include <linux/topology.h>
> >
> > -#include "nvidia_cspmu.h"
> > +#include "arm_cspmu.h"
> >
> > #define NV_PCIE_PORT_COUNT           10ULL
> > #define NV_PCIE_FILTER_ID_MASK
> GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
> > @@ -351,7 +352,7 @@ static char *nv_cspmu_format_name(const struct
> arm_cspmu *cspmu,
> >       return name;
> > }
> >
> > -int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> > +static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> > {
> >       u32 prodid;
> >       struct nv_cspmu_ctx *ctx;
> > @@ -395,6 +396,31 @@ int nv_cspmu_init_ops(struct arm_cspmu
> *cspmu)
> >
> >       return 0;
> > }
> > -EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
> > +
> > +/* Match all NVIDIA Coresight PMU devices */
> > +static const struct arm_cspmu_impl_match nv_cspmu_param =3D {
> > +     .pmiidr_val     =3D ARM_CSPMU_IMPL_ID_NVIDIA,
> > +     .module         =3D THIS_MODULE,
> > +     .impl_init_ops  =3D nv_cspmu_init_ops
> > +};
> > +
> > +static int __init nvidia_cspmu_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D arm_cspmu_impl_register(&nv_cspmu_param);
> > +     if (ret)
> > +             pr_err("nvidia_cspmu backend registration error: %d\n", r=
et);
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit nvidia_cspmu_exit(void)
> > +{
> > +     arm_cspmu_impl_unregister(&nv_cspmu_param);
> > +}
> > +
> > +module_init(nvidia_cspmu_init);
> > +module_exit(nvidia_cspmu_exit);
> >
> > MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.h
> b/drivers/perf/arm_cspmu/nvidia_cspmu.h
> > deleted file mode 100644
> > index 71e18f0dc50b..000000000000
> > --- a/drivers/perf/arm_cspmu/nvidia_cspmu.h
> > +++ /dev/null
> > @@ -1,17 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0
> > - *
> > - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
> reserved.
> > - *
> > - */
> > -
> > -/* Support for NVIDIA specific attributes. */
> > -
> > -#ifndef __NVIDIA_CSPMU_H__
> > -#define __NVIDIA_CSPMU_H__
> > -
> > -#include "arm_cspmu.h"
> > -
> > -/* Allocate NVIDIA descriptor. */
> > -int nv_cspmu_init_ops(struct arm_cspmu *cspmu);
> > -
> > -#endif /* __NVIDIA_CSPMU_H__ */
> >
> > base-commit: ea8d1c062a0e876e999e4f347daeb598d5e677ab
> > --
> > 2.17.1
> >
> >
