Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CE376DF1C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHCDob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHCDo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:44:29 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA8272A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBft6fMaKAPL5TvhcFZX5Ao0DTz8S/mUCj9aFvxFeRrlSEr82JfRJxqwjU1Lc3G97TLyDJvylN0T2q1XH+KfTY3aWhVrVVm3GHCD8z85LGxslKdSzFF36VnSEhZYgJH0UcVHo1R1urKq8ziNHVH5nC7wq00ISXFdReMYIyWCx1xqVcjh+1j5N9YsOIsYeI20HZ2x9TiaNs0MB+4l6RfPNRtOBso79yfF93s37LiD7KED6IANUA6dA4N93AavpVlUXXV6sDQPZEr1sRrQ0DMJpK2rH57zQm/sCHBStJDFICZqir2jGoPdtQmDytSDMI68bd26gdNFBhHPXsWXA9mcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6SucAvAAyXAniX6DRKhMDDK/AvcjaX/qpG1GFf/ktg=;
 b=MJuhzmoNEjZTmwOf2KkG3H5RzIgiPYTx5h06Ourj4TVukahnXTrTRPdF7vQj0oCohI++8PdEyMu+xxm2nxPAtexDAmpbLSIe14hWPqUEVFeBBzEmmMq9RFSoEi+8vkvhh4ACydRPAoT9i+7kLp9g/fcIBFGfH6i2E4CuW+oDwCM29qjCm5KKYewydW8sJcTrMrh+XTnJ6v+Gb4DNdfW3OFghCwz2uXIX1I0b2p4RHC3kGX2+uGdTFuAKB6y2D/vMHNy9z8dv5fQ4g7l36yQzcqsETVoj38b9QDJSJusCSjCw/vZAYagLJwr5kjmh5EjxtDnFjspgKEUpRwP31J7PEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6SucAvAAyXAniX6DRKhMDDK/AvcjaX/qpG1GFf/ktg=;
 b=Fxz59HsQdoAh3X1E0L2NX8s/KlxHyoWZaPHTORXQ9d163sWZr8UAWUcJ3Y3RXzYJ/T48umZsUFbmf9mXu1CizMIreZoYMkJyOLhTqRkJqLvzKXuI8Ei0H0EsdDFeRrtB9ITJi9h9FaNh5SbRzGAo3zDyShX2YQtXgfTLK7h1y+A=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3425.namprd21.prod.outlook.com (2603:10b6:208:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Thu, 3 Aug
 2023 03:44:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Thu, 3 Aug 2023
 03:44:20 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: RE: [patch V3 00/40] x86/cpu: Rework the topology evaluation
Thread-Topic: [patch V3 00/40] x86/cpu: Rework the topology evaluation
Thread-Index: AQHZxSsK8jaIgs5CLEOe4BzvC0ABka/X7WHg
Date:   Thu, 3 Aug 2023 03:44:20 +0000
Message-ID: <BYAPR21MB16884A9AE4AF581B0B1CDB25D708A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230802101635.459108805@linutronix.de>
In-Reply-To: <20230802101635.459108805@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=08d24e9c-534a-48ec-bbce-e0a5e8d70d02;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-03T03:37:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3425:EE_
x-ms-office365-filtering-correlation-id: 3e43daf1-3b77-4132-0816-08db93d3ebb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TD8OG5Er/7Gvfa/JnufYaNSKNlKMta9qwBneBdqvD9WRx/OUhN89fIS2DEEKjEt/c9BZgYlx9pOH+cmJm73czfwQDE1Np6ge81RV59/V54N1FR3IzOgMy4Il7U2pRT5eu0aIOXEKd9YUCuN7Z4nBbhlWhRTKJgLVjwLGhWBgUAJZDKjWRswkXbymksXtZ+gsqut1NCbqliA9uGFytEyVQRsHrfyXtY1cQi7z3kKNeIZKKg07yUdiAWHOYETwfRe5Ty3vBSukWCHoywdpeaH0uU/7fBaV3KvBwkjk1FR5huh+zA7Vftq0y+rG/Ain7N5RDqyXdW5nMzzvgPXSEzs5G19HRcKOp7lzYNwbvf8A0fajZheJam8cHXQ4STxfgGZdlVlH9bcrQN/1nF2IE67OyFCORUDtgbqWO66Hepb3hkbDy1UwyzvXGjSNjKzh5yMufEu4lzKQ4Um2iGPtIpL5WPl6V4EyH2ITEQ0ba+yiYr3imq+/wMG7MoH3ULJ4AIvM9T8bIIqriCnJTGEUAUpLoK2n4aWpwY/fmzo/NqLWmgc4UseFElhH+vkPj7D1CyBU0ihduK62kuOuCA9rJyAfMq2+AKNqLteNJ30v60xPXFuc3+tvS2cjNME9cxfg5uHQy81Dvvlq6Yywsp/jeEA+fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(86362001)(66476007)(8936002)(8990500004)(2906002)(7416002)(52536014)(5660300002)(41300700001)(66946007)(786003)(76116006)(66556008)(54906003)(64756008)(316002)(66446008)(4326008)(33656002)(110136005)(10290500003)(478600001)(71200400001)(7696005)(9686003)(966005)(26005)(6506007)(186003)(83380400001)(38070700005)(8676002)(122000001)(38100700002)(82950400001)(82960400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?41JxWHhHZe+GcfpxfMppTCrjOQWuOB4t6HHi/Vp4J/GmgMZMeZCm/N1dIHeM?=
 =?us-ascii?Q?AuW3VVhxj5RtzQV1I1CdNz0xxGkUrPSjD8mLL5WCmc8j0oBxgQk0h1laq0LZ?=
 =?us-ascii?Q?X25hfmcLKVO+Xg328HYWzH0zCHa1d9ZIBYR5xQoJEXAucoAuvaAgZI405L1O?=
 =?us-ascii?Q?DjuDtlulJdZua1TMPpqI3V1mFUWL30L3oXYsO62K3E8L+9Cm5Fbzc4k9spYV?=
 =?us-ascii?Q?lZP8vhzEkKZyTEHEqaBzcb79cOi5edGoGAwE7nE8Gmw1Vr+gRDkwGyoTHGKX?=
 =?us-ascii?Q?KRgbp45mclFy7kgN9SgbZ/z1mWrQNT0b3Kx442Xf8UnfsE20F03Jv3E3IZGh?=
 =?us-ascii?Q?r9V1DaB/oS2/Cqw2kL6k2a5hDbv8QOPRKrAk0NPpBLSNLDAd7iwSblgUaLbg?=
 =?us-ascii?Q?SOUHGtroU7s+VJkw7Q1cIzIkqN0zlLSUoI4GUbdxzkdBgh8OFhxOmWNsh7dW?=
 =?us-ascii?Q?2k6zJ2knR9wqJzdM9UVB5CSCOGYIHwrLod96ZG5HWjoxgFFYeyeK/oyjgmaw?=
 =?us-ascii?Q?Y0AYiAy7rjRuv7OM90DkOpsdrfcRqB1zB1qRQR3Rr538ZOSVtFJB/azXyQm9?=
 =?us-ascii?Q?NQGWOSqdAxn7JdRbOwII9Dumb9ZD3F1shDRHxGY0EUvtTVJS6SwaYWa6Fag2?=
 =?us-ascii?Q?CBHiqSexvQH0XLPlO3+k6SkhEtlZw8oBCWm+emWkalyuq6DKSU9mCntVF7V6?=
 =?us-ascii?Q?8xIN3W4T8JQ6TW2f8SNH6DK1hsCaq/Eh+BA8IoLWnHzcka66wum508ojWrcu?=
 =?us-ascii?Q?CuzOFmf55pYtK6ue2pYw8ntfiDdByVQ459hMVbrtux296PZ7lSTtJmuxP+DP?=
 =?us-ascii?Q?kulnbhABMBbPggJMK3LE0remSFvocu0XnGIDO1Xs68iDWzqLSgr5D+kH0xSx?=
 =?us-ascii?Q?K6B6rjrT8hg27YqjJzG0vj0ex+c0KqxNgfP2zEB9cyqfFZ3AChpaN67HCSSz?=
 =?us-ascii?Q?/YlLQltdaixrl399fYVGC2XgbCFhY9LCjpVA1cGzVk6udUj8aT7/bVygI1iC?=
 =?us-ascii?Q?RZA2iSScZOiGJMyyAY9BAUsyO+vuZORDa30uhyODknYcSXF3LLv1Xasfz2eD?=
 =?us-ascii?Q?Af1VM+l7B0zoAyu0RamRZkcdVZ6TIucXgih5E0Cr9Umc5QvW9MNK/3Pn3IKU?=
 =?us-ascii?Q?vx8IY9wP7Qw5Zv/s+xl+PylSHnQlJqxt/c02OVmo7dIfP9EphHbCCqVwBM2N?=
 =?us-ascii?Q?rW3gT1fiybfD+qEpjGR3OHCgu5pyzDRItd7zNGd+8T8YetIzFp3jWg/bFLLt?=
 =?us-ascii?Q?zchdhr3dQmqYzlSBJu3MjbrR2BUnuIoIi03L1jwmzwjYUyVqlEcI8uOMtdmu?=
 =?us-ascii?Q?oZQoZTj9gE/78w8Kmv/M/m+8sIdfwmv1iZoyL4IyZq/e+Vse9lK5PXEM/PKH?=
 =?us-ascii?Q?hej8lg97O/hxgMAjWith0im+WVWUt24k8uE+yBrm5cUkvWfnExosPkO9Wvw/?=
 =?us-ascii?Q?C5AGAwyGFeqhgNtEFyP/Q9ZtIZm8wCnKZeUIDmgriSpcX/eXZrX4Qv9wu/PF?=
 =?us-ascii?Q?pCWZ+LhSazkr0j7X9JFSAApWHxRGO0SZQrae+BI66tAOtu5wQVIqto778Xa8?=
 =?us-ascii?Q?Cyk43OizX5SweeE5TKtfmenCXmlG682uh4slR4VdYWb8iu0tX3aOxY1OdBvs?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e43daf1-3b77-4132-0816-08db93d3ebb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:44:20.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttH1z/+AqJf8MPlXEUbX1zDWbLeiepKvKPlcf7c4N37PFaFACT34jMiQ6q3PZXWN6fUvLqRdF3Tq9hcWz2K8xhEGZB3I10zK/lPTv9RT9Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3425
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Wednesday, August 2, 2023 =
3:21 AM

>=20
> Hi!
>=20
> This is the follow up to V2:
>=20
>=20
> https://lore.kernel.org/lkml/20230728105650.565799744@linutronix.de/
>=20
> which addresses the review feedback and some fallout reported on and
> off-list.
>=20
> TLDR:
>=20
> This reworks the way how topology information is evaluated via CPUID
> in preparation for a larger topology management overhaul to address
> shortcomings of the current code vs. hybrid systems and systems which mak=
e
> use of the extended topology domains in leaf 0x1f. Aside of that it's an
> overdue spring cleaning to get rid of accumulated layers of duct tape and
> haywire.
>=20
> What changed vs. V2:
>=20
>   - Decoded and fixed the fallout vs. XEN/PV reported by Juergen. Thanks =
to
>     Juergen for the remote hand debugging sessions!
>=20
>     That's addressed in the first two new patches in this series. Summary=
:
>     XEN/PV booted by pure chance since the addition of SMT control 5 year=
s
>     ago.
>=20
>   - Fixed the off by one in the AMD parser which was debugged by Michael
>=20
>   - Addressed review comments from various people
>=20
> As discussed in:
>=20
>=20
> https://lore.kernel.org/lkml/BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR=
21MB1688.namprd21.prod.outlook.com/
>   ....
>=20
> https://lore.kernel.org/lkml/87r0omjt8c.ffs@tglx/
>=20
> this series unfortunately brings the Hyper-V BIOS inconsistency into
> effect, which results in a slight performance impact. The L3 association
> which "worked" so far by exploiting the inconsistency of the Linux topolo=
gy
> code is not longer supportable as we really need to get the actual short
> comings of our topology management addressed in a consistent way.
>=20
> The series is based on V3 of the APIC cleanup series:
>=20
>=20
> https://lore.kernel.org/lkml/20230801103042.936020332@linutronix.de/
>=20
> and also available on top of that from git:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-=
v3
>=20
> Thanks,
>=20
> 	tglx
> ---
>  arch/x86/kernel/cpu/topology.c              |  168 -------------------
>  b/Documentation/arch/x86/topology.rst       |   12 -
>  b/arch/x86/events/amd/core.c                |    2
>  b/arch/x86/events/amd/uncore.c              |    2
>  b/arch/x86/events/intel/uncore.c            |    2
>  b/arch/x86/hyperv/hv_vtl.c                  |    2
>  b/arch/x86/include/asm/apic.h               |   32 +--
>  b/arch/x86/include/asm/cacheinfo.h          |    3
>  b/arch/x86/include/asm/cpuid.h              |   36 ++++
>  b/arch/x86/include/asm/mpspec.h             |    2
>  b/arch/x86/include/asm/processor.h          |   60 ++++---
>  b/arch/x86/include/asm/smp.h                |    4
>  b/arch/x86/include/asm/topology.h           |   51 +++++
>  b/arch/x86/include/asm/x86_init.h           |    2
>  b/arch/x86/kernel/acpi/boot.c               |    4
>  b/arch/x86/kernel/amd_nb.c                  |    8
>  b/arch/x86/kernel/apic/apic.c               |   25 +-
>  b/arch/x86/kernel/apic/apic_common.c        |    4
>  b/arch/x86/kernel/apic/apic_flat_64.c       |   13 -
>  b/arch/x86/kernel/apic/apic_noop.c          |    9 -
>  b/arch/x86/kernel/apic/apic_numachip.c      |   21 --
>  b/arch/x86/kernel/apic/bigsmp_32.c          |   10 -
>  b/arch/x86/kernel/apic/local.h              |    6
>  b/arch/x86/kernel/apic/probe_32.c           |   10 -
>  b/arch/x86/kernel/apic/x2apic_cluster.c     |    1
>  b/arch/x86/kernel/apic/x2apic_phys.c        |   10 -
>  b/arch/x86/kernel/apic/x2apic_uv_x.c        |   67 +------
>  b/arch/x86/kernel/cpu/Makefile              |    5
>  b/arch/x86/kernel/cpu/amd.c                 |  156 ------------------
>  b/arch/x86/kernel/cpu/cacheinfo.c           |   51 ++---
>  b/arch/x86/kernel/cpu/centaur.c             |    4
>  b/arch/x86/kernel/cpu/common.c              |  111 +-----------
>  b/arch/x86/kernel/cpu/cpu.h                 |   14 +
>  b/arch/x86/kernel/cpu/debugfs.c             |   97 +++++++++++
>  b/arch/x86/kernel/cpu/hygon.c               |  133 ---------------
>  b/arch/x86/kernel/cpu/intel.c               |   38 ----
>  b/arch/x86/kernel/cpu/mce/amd.c             |    4
>  b/arch/x86/kernel/cpu/mce/apei.c            |    4
>  b/arch/x86/kernel/cpu/mce/core.c            |    4
>  b/arch/x86/kernel/cpu/mce/inject.c          |    7
>  b/arch/x86/kernel/cpu/proc.c                |    8
>  b/arch/x86/kernel/cpu/topology.h            |   51 +++++
>  b/arch/x86/kernel/cpu/topology_amd.c        |  179 ++++++++++++++++++++
>  b/arch/x86/kernel/cpu/topology_common.c     |  240 +++++++++++++++++++++=
+++++++
>  b/arch/x86/kernel/cpu/topology_ext.c        |  136 +++++++++++++++
>  b/arch/x86/kernel/cpu/zhaoxin.c             |   18 --
>  b/arch/x86/kernel/kvm.c                     |    6
>  b/arch/x86/kernel/sev.c                     |    2
>  b/arch/x86/kernel/smpboot.c                 |   97 ++++++-----
>  b/arch/x86/kernel/vsmp_64.c                 |   13 -
>  b/arch/x86/mm/amdtopology.c                 |   35 +---
>  b/arch/x86/mm/numa.c                        |    4
>  b/arch/x86/xen/apic.c                       |   14 -
>  b/arch/x86/xen/smp_pv.c                     |    3
>  b/drivers/edac/amd64_edac.c                 |    4
>  b/drivers/edac/mce_amd.c                    |    4
>  b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c |    2
>  b/drivers/hwmon/fam15h_power.c              |    7
>  b/drivers/scsi/lpfc/lpfc_init.c             |    8
>  b/drivers/virt/acrn/hsm.c                   |    2
>  b/kernel/cpu.c                              |    6
>  61 files changed, 1077 insertions(+), 956 deletions(-)
>=20

Tested a variety of Hyper-V guest sizes running on Intel and AMD
processors of various generations.  Tested guests configured with
hyper-threading and with no hyper-threading, single NUMA node
and multi-NUMA node, etc.  Also tested a hyper-threaded VM with
the 'nosmt' option.=20

All topologies look good, modulo the identified Hyper-V issue
with mis-matched APIC IDs that must be fixed by Hyper-V.

Tested-by: Michael Kelley <mikelley@microsoft.com>
