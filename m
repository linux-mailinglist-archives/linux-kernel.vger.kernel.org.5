Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4457784AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHKAxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHKAxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:53:07 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01A72700;
        Thu, 10 Aug 2023 17:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgRqnb+tuqkoVQ4eL5SFfkVz1384zNgd73xTfL3hfuKzhE22z8IOg3OlReyPR8gTLvB/zPcY4G6FLOOw5UB/syrWi5iH4TIePsDcXyvWNbUcAusAzBbMsKq1+hI8IvndiRXt+zJQaf3l0N8lIIkbVkaGHy1LILMAzJjRUZjnAy8Tfqwb+zLMyvC7TAYoKDekqj75+XlOeD0dW63lvQhE+3haqEEZSH3g7i8z58OECnKMZvFK2a5P4koWX9jy2nWByU04HcSOOFX9MQ/CuttHYo+dAz0HCSwvLSWufM3wvQWiPlQHnpaikjwTc+DjN9V7423naaq0NHYMQLHYpdGSrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KT6/9Ns66qKh/6+0oD0h1lIe/0AO1nOeHx6ZQGHmSQ=;
 b=jrr2DwLuF5b2Q/rM+S92EV6saJijCSumXFLxmcMnxr5OSx7JKqsJ3F6qZWESRRhDJk+wK3gs/GQJHOGcfDwuF8DoiltZNQC9/FLuA5igQ1kwuG9kId7PjtiE+gGNzVGuVqnJcQqLGbQGVRgJ2xQxp+3kbptVY8fZ7uPfqXSNbCLUJCoohxg4x4IW9pFfCsRILIbn+E2gUhZkglI7cWpK4HmX5WQBM4Dd6OiGgqfzRRJo35h+VgZIG8UZ3vXm2R2U23uzZgYY7X1WMka3hNOzRKy7iCfbysE/gYU5dDj6NmaSI530JSDIg4OIfAF6iswsOqd6TF/4efLZsHTKPlsndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KT6/9Ns66qKh/6+0oD0h1lIe/0AO1nOeHx6ZQGHmSQ=;
 b=jGYCv76p9qTmmiZ51douqiieWbQYmyPVTHeR6xdiX64TiqbDGl2uc/x2QxfMgZlLM0Lo4wsKlrbY5IYCLOuNngyMw73u0ptJ4h4E2tCFCDy4bz14ZjxBUvin5EWHw6yQtNrRudnrkhaifjE7e3A3icJZX264A4OJvFBTpyFNWzkqArnpH/ovcG/t/xAxsl93BoRh/5776zy1K9jnX6U2EmdV//rm4UW2gUwXa/iJ0VkyxKnY2CTg/cvwfvxGWJEMwfx+uqiq+RD8yaDn0yMfjaJftfPtjjBuSl1IougOdjnPy76gBLgN7MFM1t8Zt3NIKtPZy04iVM7ya++1fqhtKg==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Fri, 11 Aug
 2023 00:53:03 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9e01:4d19:224d:219]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9e01:4d19:224d:219%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 00:53:03 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Will Deacon <will@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>
CC:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
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
Subject: RE: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Thread-Topic: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Thread-Index: AQHZry4xzcjbD21RhUuAD3F0nYoHCq/PTrKAgBUtS8A=
Date:   Fri, 11 Aug 2023 00:53:03 +0000
Message-ID: <SJ0PR12MB56767F8C7F85008559EB4986A010A@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230705104745.52255-1-bwicaksono@nvidia.com>
 <20230728132216.GA21394@willie-the-truck>
In-Reply-To: <20230728132216.GA21394@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|PH7PR12MB8155:EE_
x-ms-office365-filtering-correlation-id: fb87a7c8-2a9b-461f-5cd0-08db9a055139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ir2YxPfmz1/oeI+hhZnh+heAfd+PVJlxqLYYH9harOAOszvzti34z08ZXJDk6DETwg97a867n9UjkMv72sn8LnuvmjQuXPJdi/F/t7ZyhqPO/135b6e2ghyeC96HHUakdHyVfZNuZYKibSY6LopfxWbtmSXBGRDoVAiAVmIY/2TLABm6xn09HstIKtalPEfP4/Cs2Nj77gcgRagn1kfwPEfj5j7SD3Z7wfxnkhCwCKTmFcVSDlAyimeh1tZ63hlOd6x0psp1XYYJdpWWmnZFkJt8Ey4v+N5Gzfv515xvJ32qFK+4+7gPUM4hf4F0m8oFCB/sqorEAzaUUFzRwUkpb+DB7CWBtysSApf+GKIv3yFaur0wJ9nT6fBqtb3Pxd5Rr816PWibpIEThY3Nu0woXr5rNdNj/Ng4V1hU/ZO4MOa37p++VQoMmyCUH4h85HPOLY13M77p4lxL7AECq1CoPig5XytH/FBBuhSKdvL8T3fjDsFtYT7rYYhRNliQe1lA9EZAUAuJcelijN7MWNZoKMg6l6kHKM+NQyXIe7osd5xSDBdNUaUvovOGCN7S96dRumiIQDyW/S5hFZxsVe9ABHfRNTLK7+OsCMm5fCeEmkTBeUJHMlXxjxc4hXx5tPbIUgi2zb9/HoKVx26VlLGpp/EnkyAO54RULbB4dEM5/rA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(1800799006)(186006)(451199021)(33656002)(7696005)(9686003)(478600001)(966005)(54906003)(38070700005)(5660300002)(86362001)(2906002)(8936002)(8676002)(52536014)(6506007)(38100700002)(41300700001)(122000001)(66476007)(76116006)(66556008)(66946007)(107886003)(26005)(71200400001)(64756008)(53546011)(83380400001)(4326008)(66446008)(55016003)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PW0+Iha5UYcPDl8xWFXdGxBKmSai1N74zdrqfSb6Xvn5TahmGAL2JWGQlDlX?=
 =?us-ascii?Q?sKyfnKAlguKz4i162rF0hW0+O4UF1IZuw3/BUbx+evw8YQWkae7CbAq0CbzR?=
 =?us-ascii?Q?sQU338aqJ0zZcc2DBPH/hieGX/XcsgAp00QFFlBf4uPSEAcA9h6PKQliDa/F?=
 =?us-ascii?Q?JnI8Z9OntelYWXESJ7lokUO3Gso2Yz2V4cW0vo+SHPAFmBZWwm4FosEteUaY?=
 =?us-ascii?Q?Ni9buNO4fcpzbl2S9VFf22NLQyJMPfQBZwggmiEX+rP+3o+OTtPoENF7FHkC?=
 =?us-ascii?Q?ybAVj6bnib3R5ZopAp0uNTyD/Kr6wOOXZkdcouhxUaf7tqyczotCNGh03SDO?=
 =?us-ascii?Q?KuYD4W4ouHK9V2m5DyIM4B+RQmtfL5miBDXoeHo1MfiA/KwjxXFqw/rGO+XO?=
 =?us-ascii?Q?uZ5upZlTbSKCH31XWq9TzYvO3Iyx/3OdM89g4INT80WXVVbowWczOmD/WrOv?=
 =?us-ascii?Q?g2aIHAMQuO5xgfWPUGXEhvLHFIRBt9W2Y6D6mM4Ek/ci41NLfi3qnlRcd7ML?=
 =?us-ascii?Q?BY4kDWGMbVsdaSA8gLtPGrHTZ0IfNWZyZkmBtePZfRgWVuvBL9EySe1cXz40?=
 =?us-ascii?Q?sPqDEKr628yPcx80/vReZEzgj9/MH0mcL5II8ubi8gtZQSkRtEXXkF98XqN/?=
 =?us-ascii?Q?Nxr3cCOODvyvyP6C/9h9YokZYkdbpE76Tqg/E4KRbUZ676P5Pqi3CRSmDfFg?=
 =?us-ascii?Q?jP3oLJ1yRGNLVrIwoAsJ1rKEA9RpZtPrMWw7W0UvcsT1KvBCm/RfAOAqtD5q?=
 =?us-ascii?Q?qucDNcpFMD3JPBFNe+qy/EO5IrDGMsKg3zthVwO3K/gD2MWu/POpVLRS+Aa8?=
 =?us-ascii?Q?kVEQyNiglpKQ4IRgrXqNoNfo9poNVxoTnn4H7m57cggxdqfw1WodcL5vreSA?=
 =?us-ascii?Q?dKfq9FXhw5seXhmQlRNg3vMJIGs6O2NSNRForW7946f9skw9vhbgNOw6LWG1?=
 =?us-ascii?Q?Ze2w0hpQD8q4VXFG7uDmHkLAdZtwCZfE8Od4+/hiE62DeU1dhM/q1R0Av9YE?=
 =?us-ascii?Q?lrZaydHPAMxRR03WvsKVliAUo5ZgFQgP1/Os93eZlXxj5EZRAoPZBoy5wNah?=
 =?us-ascii?Q?Jnr3K97UjPvgf3vDHnn3vPn7IuwmPj/nEzld3q7jW7qns0iEBw3bXrxZcPRJ?=
 =?us-ascii?Q?u3xcnwo/QV3PxqDzP+3pmOQsnLK4iFgXBMLwt9Hz1xsVh5IP/v1bvX1ZbaX1?=
 =?us-ascii?Q?YIlI7G/cAs1kvBNPgGGNPU1ZYB7EJyZoVhEoq9fLiC/QQ63uzBILAoqMvQm/?=
 =?us-ascii?Q?OlGjFaaFPgbZy6tSVYNNsyE9lA65oZdpdk3nZppNB/6Ri6zD/3IzaXJs5hL1?=
 =?us-ascii?Q?68H5ffTA01y7wKXcvmT+P6VEeYN9v3wp0SWOMEwpXCmdJ80mTpeYqbVmvCxE?=
 =?us-ascii?Q?ur1qYe+h+KjDUCtcF28eiaJlA9fp5IEbZ/Up4y/qD6Qr2B3mKh6AYzfDYJYG?=
 =?us-ascii?Q?+NevbBYO+fmEfh0KiWF3z+rOrOHr6F9f8/or8pdNIaq5oV4Xr0ZglAs8Gtas?=
 =?us-ascii?Q?UVq9evPLQn1NM0Dd5JZPrzHQFOUGm0rhTVYzNPUcwtZFCcbR3XNLcUezC+2M?=
 =?us-ascii?Q?INMBnQ7GdQJL4/o/NJvp6izDofSsFxp9ZaGgzbNf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb87a7c8-2a9b-461f-5cd0-08db9a055139
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 00:53:03.1225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmCPTeG/DF0V+p9KAnJ7C668VntDHTrtATaEFhTH6th+WRGrAS1k2lDSN0yyV8jR/Rqha39nx5VvM/rbeT1zQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Please see my reply inline.

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Friday, July 28, 2023 8:22 AM
> To: Besar Wicaksono <bwicaksono@nvidia.com>; suzuki.poulose@arm.com
> Cc: robin.murphy@arm.com; ilkka@os.amperecomputing.com;
> catalin.marinas@arm.com; mark.rutland@arm.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> tegra@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jonathan
> Hunter <jonathanh@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Richard
> Wiley <rwiley@nvidia.com>; Eric Funsten <efunsten@nvidia.com>
> Subject: Re: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Wed, Jul 05, 2023 at 05:47:45AM -0500, Besar Wicaksono wrote:
> > Arm Coresight PMU driver consists of main standard code and
> > vendor backend code. Both are currently built as a single module.
> > This patch adds vendor registration API to separate the two to
> > keep things modular. The main driver requests each known backend
> > module during initialization and defer device binding process.
> > The backend module then registers an init callback to the main
> > driver and continue the device driver binding process.
> >
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > ---
> >
> > Changes from v4:
> >  * Fix warning reported by kernel test robot
> > v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-
> bwicaksono@nvidia.com/T/#u
>=20
> One minor comment below, but this mostly looks good to me. I'd like Suzuk=
i's
> Ack before I queue it, though.
>=20
> > +     /* Load implementer module and initialize the callbacks. */
> > +     if (match) {
> > +             mutex_lock(&arm_cspmu_lock);
> > +
> > +             if (match->impl_init_ops) {
> > +                     if (try_module_get(match->module)) {
> > +                             cspmu->impl.match =3D match;
> > +                             ret =3D match->impl_init_ops(cspmu);
> > +                             module_put(match->module);
>=20
> Why is it safe to drop the module reference here? If I'm understanding th=
e
> flow correctly, ->impl_init_ops() will populate more function pointers
> in the cspmu->impl.ops structure, and we don't appear to take a module
> reference when calling those.
>=20
> What happens if the backend module is unloaded while the core module
> is executed those functions?
>=20

We also update the call to perf_pmu_register and provide the backend module=
 handle.
The core perf kernel will acquire the reference on the backend module prior=
 to calling the
functions in cspmu->imp.ops. Please see the change below

+static inline struct module *arm_cspmu_get_module(struct arm_cspmu *cspmu)
+{
+	return (cspmu->impl.match) ? cspmu->impl.match->module : THIS_MODULE;
+}
+
 static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 {
 	int ret, capabilities;
@@ -1149,7 +1173,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *c=
spmu)
=20
 	cspmu->pmu =3D (struct pmu){
 		.task_ctx_nr	=3D perf_invalid_context,
-		.module		=3D THIS_MODULE,
+		.module		=3D arm_cspmu_get_module(cspmu),
 		.pmu_enable	=3D arm_cspmu_enable,
 		.pmu_disable	=3D arm_cspmu_disable,
 		.event_init	=3D arm_cspmu_event_init,

Regards,
Besar
