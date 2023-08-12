Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5A77A038
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 15:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjHLNwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjHLNwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 09:52:03 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1377211C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 06:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbsWjSEw4ZBK6FBsv72pMGA0VDxrL1P//0kKL8SWYlb0czEPCIVYQeS/Z3vYTk637D0tsVqOehiMnJE2dZdBhPz2sSSDiv0vsJFb5i3BlUNYym7CVBlbYlRvqRENnGq+w7n5NHP/xhygebl52tT04cNOv+oTzTwOkDKIjbYkL7lC5VC6UzmFaiQMClcmTV+JHeIbCyymYrH/AzksKiszMYZUPiKhvJldZUkiX0j5m7G3JMGhBlfb+V0ybRqRrx4kgVAsCFuQekbKyrtykN8Z9Nqrxp4P17yKHe+3nKU452wsKWnxzxOnHcUwhe6Vvyx6G1OyT6+LrRIFDEx6fl8Etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eprSMK5wxXIMIu4rWqcBeu4pR4lpme+EpdXcSEXav3g=;
 b=M0nksEuqYzbi9XVoLu3PeUc1U9Qj/gAUMQ1SwDUIvZUD2TmFVm9N6rJIF4XDDoC4IP92sjEunG8AagFjXPC5Z1ur8e57u/rjwB8ainagpjMR5aovU11vPuwEjPctUNPWc2lM8uPL4XMU7AdsjiXZFRJGFvGjiS1oTwdByuuaMVsDIJcQB4vUmUiL29yPFvbtIIcIwRgAbJg5Aaz6hFjlZkRdl5sNa/p+kzjBDm6Eo9ghrixwxv+EI0oWG4mdWVz+yI+atVI1cFWi3lOlEOGHhEK70JkqzPtTotYm+akdQYC3W6tdFV/OqDTPicvWPnY6/QwEu/+1lU/uSNXMpbhz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eprSMK5wxXIMIu4rWqcBeu4pR4lpme+EpdXcSEXav3g=;
 b=AnouhAYAxlgPW5nF8MBCcCjiGUGmCOGd8UU+T3VhKwcg/ls9rqF65YRHomL7WOsv1KPQEqsTMZ+GOUSGlu+BF45WNsWvOPPRmOADlaVglTrloJ5T/JyxnMbhRXDwblgXfNBPCobrczvgewC6uTqCwPGrk6gRi1wSo6Fb6iVbeBo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS0PR21MB3928.namprd21.prod.outlook.com (2603:10b6:8:12a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Sat, 12 Aug
 2023 13:51:50 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Sat, 12 Aug 2023
 13:51:50 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: RE: [patch 00/53] x86/topology: The final installment
Thread-Topic: [patch 00/53] x86/topology: The final installment
Thread-Index: AQHZyTZ7KFatP8GgFkKMUpmY6+ssOK/ms6Eg
Date:   Sat, 12 Aug 2023 13:51:50 +0000
Message-ID: <BYAPR21MB168885D3FB297CA82AB70C8BD711A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230807130108.853357011@linutronix.de>
In-Reply-To: <20230807130108.853357011@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=234845db-f4d9-42e0-8a5c-413065211d20;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-12T13:43:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS0PR21MB3928:EE_
x-ms-office365-filtering-correlation-id: 8891038a-7d9a-4217-011b-08db9b3b472f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HaxjLeYHGLpTrmEXhfCYtZVjvk4MGB9X2Z3fo6k/uxnjANh55jdpZyb99Zd0zs3CYe1OD/gAul6sKkhx04GhqRal6OWkd4vSiTjF0a1ecstUqQTXovx1cKdZYlzR7JwRYpjFoUD0Tli4J0BcacnOeyyQmgOyBZH5FWSnPh3KlrdmoYjF4Ymcca1BuIEmD6qipoXxGeUJYzMorVyRFaw1UK4bV9zBTK9jc5xcF0GL9DCYAesFqoAUMlti8eZ7b0K25jnW/ZZg4UXdNEtLtYaN40vl6yYGeYB97fzTyzoPiy9w9LaTM0f2fKrsSgbu/efQA0RX+FfyPkoGRX53ykxH8usHxrQOcDrNrbg2l6rzdOP6dDnXgyehPJ90eClBYa1GR8dpHFgFZDeu7wBiB7DkEofg+xOIL93STKooM3zA66vXcNB9A6HFKWSws743eCBOcVzoGT1xPR+As1CE1Lhwps6+ret+Q/2kKSkNmfpLo8OJqBM/jglSDfbHcHeH4AeNCf1bbR+Iu36rNh0xhYGB4PLrEWhoD2pcxJp6pSDbCkK4xXhDfYbr0w6gkHulbaduC1vlRMpQttjT3Bu/33734mnjqZbrI6vHWmgFMDhbfXDbDex7PBdDQ/giR+GSS6DYdXAFuA0ls+a+Iu1NEgKJyUq4s37RjTmOr3lsXjNp2Urns0n3CNQczlBvht9eKRyN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(366004)(39860400002)(346002)(186006)(451199021)(1800799006)(9686003)(6506007)(55016003)(966005)(7416002)(76116006)(122000001)(38100700002)(54906003)(7696005)(110136005)(5660300002)(38070700005)(64756008)(66446008)(71200400001)(4326008)(52536014)(316002)(8936002)(41300700001)(66556008)(8676002)(66946007)(33656002)(86362001)(2906002)(8990500004)(66476007)(10290500003)(82950400001)(82960400001)(478600001)(26005)(83380400001)(12101799016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lepZvLQp+rt3+Ra23vVR6FaQZKHD6GqjoI47yMvR1LaqLT71k2UYwPU4yFZL?=
 =?us-ascii?Q?U97Mpzie9QHFb5S4znf3nak7SyRBsCj/xLBaFp/V/Hm8G1h7Pi0Gr3YeLWbV?=
 =?us-ascii?Q?q8WPnGJ1fFTOWS4QVl6YnGprrJYCwv8biFrjY+6kZOikvdb1NGmBpDBWZh3m?=
 =?us-ascii?Q?fLnT8ITi/0siaugleH2qgGP45z10QijE7jaoTtLMStFm8INuDFtxKGVbEeXN?=
 =?us-ascii?Q?WaRsSX27DUVeiis+pZapDbHJHs0Q7NRMYeFbzn9Ob7NUpjBooYL91tqP102b?=
 =?us-ascii?Q?utga9q+MyBHF/9j/D1vlQh1qu9krcCLtqrcRVneVUh1l+Bj/YVismbpjq2Jz?=
 =?us-ascii?Q?c3qg1MqjwbPbWEM9rm1pkNZyf+y1g0ry7spZY/CSF/z0UgNwZ8C0cGd/Shj7?=
 =?us-ascii?Q?59UD4PNKuZUd4U+OSAxpG3pcBUq+SKNOgGdhVsK12ndmboQP38TykGnrk/53?=
 =?us-ascii?Q?AHmPj0uFJHuAjeXK11J5LCZQixvsb+cmQlrX/7Mlrk6I94yyHPBxn7oA+kTJ?=
 =?us-ascii?Q?uS3JEz/x1Vl9BtERzvbMZWpDP3Jd9heGhvAC7eembD96+8/3TIkoiiIZvtpm?=
 =?us-ascii?Q?NsLcGvwOI2VPKM9o9PErPQkHY5vi4eg1XNBE3qGd1V7etFscIflU/7qdeiZF?=
 =?us-ascii?Q?hiIUQZfNcbYzhNqvoUSNiLQmkRbIIopnWqWm+7e4k+wnrHCcp3h1gt1+3Foc?=
 =?us-ascii?Q?/oYYhaWoZbn+NIJV7Z3O+kvbYiGXYN4wKSLyPRN3Yig4gitj/x9nHoriqoGp?=
 =?us-ascii?Q?rzJ+RmT7ehjD1HyroP/wS52NSRnHGjxInw6ztnMY2QZHgcDyWc4j5O6pEcTS?=
 =?us-ascii?Q?PZ3hKrTr8xp7lp1VRjGE8evDoQYoSmOkRteipbb9t+6KR/ViNVWmiaR9RTPy?=
 =?us-ascii?Q?2aLH6pLtgwuWkAdLF7bzQnXMPPlqdTBR6lbXmSgqEqMK6I4Y5MCv0akhZSl2?=
 =?us-ascii?Q?hySadoNS04Gs8COtSzDeamLS5IyWVN9GAn5fKaOMt5lPYKxFxGTZAOw67AMQ?=
 =?us-ascii?Q?NK6nV0IUi6Ok+jW97VIGpMPPI8k/zF861Dp+i8kQqmGUMDicc5FtyibwJcQX?=
 =?us-ascii?Q?tmHGh/PT1YRzqB29fTp9qDNY8dH5MYIjVc5B55XrqU+B/sunhlFrlI/9ceo2?=
 =?us-ascii?Q?9Q/EzHGkufYNnTj2BxRb9ffQpCp8Q904uhR2EgsYME0qsPVYRSIDiM4SE7oz?=
 =?us-ascii?Q?XHs0MEKi9+2UOCNihdABMqP+CT9EbyEJSigNOOUQa9UJWFeyQWY+5z9NXQu8?=
 =?us-ascii?Q?Uv5smlim+yEHAHAAmNkhXCMa5ifeogjxkkz0yPhCMxSYGLqvY4IyJWbDPOlT?=
 =?us-ascii?Q?zx4CUDJBjCP3dM2r3Vg3SbD313BOmeZP34gQ2by2snU+/6EbDInsZvwKDlYF?=
 =?us-ascii?Q?PbN4d0h5fwK+QdZlLCKxxZGT2Ki0xaIrwBmVT8BFrOR2Rhhtb3CFJfDpPOQB?=
 =?us-ascii?Q?//84/rzxcugAqaA5jiqjFai5PFdbNXxUGKxQrUR3d/nKRNUqfnMq7hHDjyoJ?=
 =?us-ascii?Q?/SRSdCiVchOognII2fmxzYMHT7bhNcMd8QHswivu/76zi/8OIBncJcpBXCpp?=
 =?us-ascii?Q?s8Koi9qkffZ06pcaVl/L7NkBLFMGbgPj6MPvsSGpY+UUCjnj+AkgvZaKqCd7?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8891038a-7d9a-4217-011b-08db9b3b472f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 13:51:50.2182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: efy+4UPDFoByFCGcsrpAZTLsSOcOLAAlPCVuDRw8YhXtP+26k5tG8Uj3LFlyglDupM8XJ4DKPsmTHsb1bNR3Zn/9565CsxwCZvwcTE5YeAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3928
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, August 7, 2023 6:5=
3 AM
>=20
> Hi!
>=20
> This is the (for now) last part of reworking topology enumeration and
> management. It's based on the APIC and CPUID rework series which can be
> found here:
>=20
> https://lore.kernel.org/lkml/20230802101635.459108805@linutronix.de/
>=20
> With these preparatory changes in place, it's now possible to address the
> real issues of the current topology code:
>=20
>   - Wrong core count on hybrid systems
>=20
>   - Heuristics based size information for packages and dies which
>     are failing to work correctly with certain command line parameters.
>=20
>   - Full evaluation fail for a theoretical hybrid system which boots
>     from an E-core
>=20
>   - The complete insanity of manipulating global data from firmware parse=
rs
>     or the XEN/PV fake SMP enumeration. The latter is really a piece of a=
rt.
>=20
> This series addresses this by
>=20
>   - Mopping up some more historical technical debt
>=20
>   - Consolidating all topology relevant functionality into one place
>=20
>   - Providing separate interfaces for boot time and ACPI hotplug operatio=
ns
>=20
>   - A sane ordering of command line options and restrictions
>=20
>   - A sensible way to handle the BSP problem in kdump kernels instead of
>     the unreliable command line option.
>=20
>   - Confinement of topology relevant variables by replacing the XEN/PV SM=
P
>     enumeration fake with something halfways sensible.
>=20
>   - Evaluation of sizes by analysing the topology via the CPUID provided
>     APIC ID segmentation and the actual APIC IDs which are registered at
>     boot time.
>=20
>   - Removal of heuristics and broken size calculations
>=20
> The idea behind this is the following:
>=20
> The APIC IDs describe the system topology in multiple domain levels. The
> CPUID topology parser provides the information which part of the APIC ID =
is
> associated to the individual levels (Intel terminology):
>=20
>    [ROOT][PACKAGE][DIE][TILE][MODULE][CORE][THREAD]
>=20
> The root space contains the package (socket) IDs. Not enumerated levels
> consume 0 bits space, but conceptually they are always represented. If
> e.g. only CORE and THREAD levels are enumerated then the DIE, MODULE and
> TILE have the same physical ID as the PACKAGE.
>=20
> If SMT is not supported, then the THREAD domain is still used. It then
> has the same physical ID as the CORE domain and is the only child of
> the core domain.
>=20
> This allows an unified view on the system independent of the enumerated
> domain levels without requiring any conditionals in the code.
>=20
> AMD does only expose 4 domain levels with obviously different terminology=
,
> but that can be easily mapped into the Intel variant with a trivial looku=
p
> table added to the CPUID parser.
>=20
> The resulting topology information of an ADL hybrid system with 8 P-Cores
> and 8 E-Cores looks like this:
>=20
>  CPU topo: Max. logical packages:   1
>  CPU topo: Max. logical dies:       1
>  CPU topo: Max. dies per package:   1
>  CPU topo: Max. threads per core:   2
>  CPU topo: Num. cores per package:    16
>  CPU topo: Num. threads per package:  24
>  CPU topo: Allowing 24 present CPUs plus 0 hotplug CPUs
>  CPU topo: Thread    :    24
>  CPU topo: Core      :    16
>  CPU topo: Module    :     1
>  CPU topo: Tile      :     1
>  CPU topo: Die       :     1
>  CPU topo: Package   :     1
>=20
> This is happening on the boot CPU before any of the APs is started and
> provides correct size information right from the start.
>=20
> Even the XEN/PV trainwreck makes use of this now. On Dom0 it utilizes the
> MADT and on DomU it provides fake APIC IDs, which combined with the
> provided CPUID information make it at least look halfways realistic inste=
ad
> of claiming to have one CPU per package as the current upstream code does=
.
>=20
> This is solely addressing the core topology issues, but there is a plan f=
or
> further consolidation of other topology related information into one sing=
le
> source of information instead of having a gazillion of localized special
> parsers and representations all over the place. There are quite some othe=
r
> things which can be simplified on top of this, like updating the various
> cpumasks during CPU bringup, but that's all left for later.
>=20
> So another 53 patches later, the resulting diffstat is:
>=20
>    64 files changed, 830 insertions(+), 955 deletions(-)
>=20
> and the combo diffstat of all three series combined:
>=20
>   115 files changed, 2414 insertions(+), 3035 deletions(-)
>=20
> The current series applies on top of
>=20
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpui=
d-v3
>=20
> and is available from git here:
>=20
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full=
-v1
>=20
> Thanks,
>=20
> 	tglx

Tested the full series on Hyper-V VMs on Intel and AMD Zen processors.
Tested with hyper-threading enabled and disabled, and with a variety of
NUMA and L3 cache configurations.  All looks good, modulo the known
issue with Hyper-V providing incorrect APIC IDs in some NUMA configs,
but this patch series did not make that problem any worse.

Tested-by: Michael Kelley <mikelley@microsoft.com>

