Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301976DF20
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjHCDuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHCDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:50:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2125.outbound.protection.outlook.com [40.107.237.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908842D65
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcuSVoxKA+QdI9zCNekARX7nFQmO2G6EVEVHm/iw4e2xVY6aTTqgoN78kizYQgeeQGozRVOw6hFJFV8wFdgZvswPuBjUCZek89TKLdYZJqWwvhigWRIWSKbKOcD1aLCyeuX20Vguu4bqHNxAJ3jAZewBl6OJ410hBAk56o/Vz2IgHCnKy+Vs5Voovp8n68v3IQaTuq5rWbAzkGPFGG+STNrgjWFoAKIBKYVmpA0HyEXpkXgVubnMQN8fPn+1C1Ll5XHio6W8rWDLO0p6AZlbwAyumrNUvRPcqwJcb5qSgNsMOsRaXHhhttsFKoWCu5/h22uVJ3slxsG9ynw1+oGxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYKawFCrBDqSkSE7yHp+1Ifxz9TYZHElwARyIAbIz0A=;
 b=mmfI7F2j2AHgHmf5YvFx9ZRnA+rcrk+bs877wwY/UdB6bxbNZnJFEX7Vr+koBcshelu9N+spBwcXcxUeJQVpbimzpiVo5aNnzRiAcdXBjJqWodRkytlhEEfjpLtaG6o4rJzBfsfJhe6fOklkqQXr6upLhWekCz+odwoTCuI/TKudBX8lJg8s+6jM4xuSOxIJ5iaOs4TRoe3USIet/dsLeJJEHiWWssO5cFan+S+9piTgvU6DqThglBbS2aiuc/RP5iBs4k/8fZJ0gq36Egl2tpwiO0m5s2oDjZVRWGYQH53dmiPYJvXwckCEtrHP9EbToRj5C+HzEKhyvSLpwxjUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYKawFCrBDqSkSE7yHp+1Ifxz9TYZHElwARyIAbIz0A=;
 b=UScGMniEywmr+JIRuTgBW/lJlxeztdoLmEbUE7j1JEGJNtMWr83DWV3h4KxKCum/oDsT22dswh6L8GwNrDHh1ktUtta2N1xiTEmIWqsCq7FxeiRzcadOG7ldkzGArBHVJnlma4W9NJVa4bpqgiMoSrSDTppQR2s7UNh060ZaQgg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3425.namprd21.prod.outlook.com (2603:10b6:208:3e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Thu, 3 Aug
 2023 03:50:27 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Thu, 3 Aug 2023
 03:50:27 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>
Subject: RE: [patch V3 00/60] x86/apic: Decrapification and static calls
Thread-Topic: [patch V3 00/60] x86/apic: Decrapification and static calls
Thread-Index: AQHZxGV49eyUF/ezwEuz96/Kw6sqkK/X8RoQ
Date:   Thu, 3 Aug 2023 03:50:27 +0000
Message-ID: <BYAPR21MB168880BB447AA37A88D47B89D708A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230801103042.936020332@linutronix.de>
In-Reply-To: <20230801103042.936020332@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5ffb9866-069c-47c9-8a3f-61721969371b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-03T03:45:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3425:EE_
x-ms-office365-filtering-correlation-id: af0cd00e-5145-48a7-b761-08db93d4c676
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cH1u09bhmOwBH/teGCBETCzpKVc69lXu2DBLNVIwkurt9BBm3GFdqm6l3Xg6082DW4Kcs8WBuj0GEDXRD+16yg2wM6ZpvxHJlV2FgkOilTgrj8DWKbe2VVZ+GW0ER2bcB3NQlIOXn7+Xa36sWKPHpVhrA7WaWNcE3PKbeshEZ6fVZp+xq8UrUukTmooJ0lXlKnGk8oGCypDQ2EFyAzDt6ILDxYC39quZB6OCbnb0ynYV62Nw3joG/KBamznDAmCZUpLZCy7wlpq9I7/wajUEeHMmpereUfv6uufM3hWSnPaktF+AX+ubH4+bEva0r0lrHXpCgj/0KrATZVfyIM62x1Yb8MKUF4v3AI3QaHw1XcohwhYC6nH6Yrfzb9/tL25fMumHM1pegwLuJIMYCFBokELX6B13th3E+Xqt7Wwzs4JWJtkIB0ADPzvKwpC4kG2a2rZptN17FJxNQXKcZ2/C8Z+irJnHia/VhnnQGx59WE4tq7jn/WyHA6SyKKu8+G0IxiiGoAfoqMTgp2Xh2lNdQYWh6xiaNcxMR3cH7TZd7B0xZch0527fIB+PSgmj7G7k/NtQ6t/tUmpdMavh57VvnnlafbyNbqsH1JwRilwTY0Tb58FuGFWzF8PL7m83CYVMRWT5tC8a7rcGvmsGtwEX5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(86362001)(66476007)(8936002)(8990500004)(2906002)(7416002)(52536014)(5660300002)(41300700001)(66946007)(786003)(76116006)(66556008)(54906003)(64756008)(316002)(66446008)(4326008)(33656002)(110136005)(10290500003)(478600001)(71200400001)(7696005)(9686003)(966005)(26005)(6506007)(186003)(83380400001)(38070700005)(8676002)(122000001)(38100700002)(82950400001)(82960400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m13zw8wffNxuZ8IR4owUn206vsNqp8NbM1nXY4bgPcjMMxS46eqCB9LPYyRQ?=
 =?us-ascii?Q?eUO3CW8UPBaHeQd+YXLWKJhoshgai+6dFrZNd83UhTKGdzjNKlhsfrHQIOKT?=
 =?us-ascii?Q?n18Q+Foou+rnfdLP7WmyftesNGNd+aOcNj4z/KUEypTKBYEoBunnVB4c3qQl?=
 =?us-ascii?Q?/OIjbDX+ksBMRHwHLlj36G64Go4iWPt6i9E0f5KeJRLf0UHbZM6mZMYn5dc5?=
 =?us-ascii?Q?V0Xyzwp4OZmxbUZ4N6Iq1GakmqWqiY7p8G9ugzHW8hOSti2qqQldg4kroMgB?=
 =?us-ascii?Q?ETW1QEogmfzl113Q7je+omCvcheKJIPq4Hh7802vj6Y8p0cLoya3kk02xYEb?=
 =?us-ascii?Q?kIE9ow/hB6LmKLshNEF8ce72Z1YmNKoAAu0uTT1VVfqLf2By9cyyB9Cg0Ytg?=
 =?us-ascii?Q?P4Le4Ss3E2gkRBDZxUCphWANBxJU9IOwzP3ZuPKDd2yY5kptRYmQQAavSg4Z?=
 =?us-ascii?Q?g9X/xpbVt04nHPGLW5W/NJHWkGbfBsi4vuFUUrRYA7sPMlvSnmrZYSphOA40?=
 =?us-ascii?Q?w172sxaiftwVRyMH7f266UKYwWPTsp8/xlOf1/b+mvksYLNbyvbwuLxF34SU?=
 =?us-ascii?Q?Yria6GjMeHtFM2ZriescmjokejhvlZpTHb0F6KKhlk+ps1SgnhxqajQSnwrH?=
 =?us-ascii?Q?FAqOmuZdWTBbtOv7+k2JFkjJqu3cq2fT4dQO4ltnhPvbfjTUcJyQvhJAWlik?=
 =?us-ascii?Q?UTzj/dxYM+QyZGJm3nknaSICnZp1AUQR1V0E4D5IXln/F8Mpgbwjsw1gCL3q?=
 =?us-ascii?Q?KhYLgseWMi02JEpMnYM2sS2gNVnZQwRSlsOlMjk/swluaaX+QnSvGKTg3E4O?=
 =?us-ascii?Q?IMYyXLGCXFOYllAei8z3IbKsY7iadbOumUff7vv73DHp/dA9ZWSc6vERUfVz?=
 =?us-ascii?Q?WsOJvFLzSJ8+TqWf4k/+KN5pNd8BASJA5hNL5oXN+8wFTuK9NFSr7Jeem1mx?=
 =?us-ascii?Q?4Ub47+Du0TttpUmHL7zcP5OLR8+5DwYpqmF8in0hzXy6jsJAVEY32Pg2WkEt?=
 =?us-ascii?Q?Es3AMsKhX/Slbl2+gAs8sl9HU19N7d8dOtp4YDwSeF0k1N2zUJrHSaKWPtrx?=
 =?us-ascii?Q?aIlxPv5YveJcSSR3RYRWkScksfIEYzUuyO9QW1IOiyHyjrYaciLz6c7a+7br?=
 =?us-ascii?Q?k1OAy7wBHtChueRdD3nI6MLjNHQcT9m8YqkE6c/7JGpNOx7mpqhUfzWtxZRP?=
 =?us-ascii?Q?fG7CSN6KreIzWaDPw2sktXQ9P8t71yZuxuvj3cfFSAR7Kk3HeqUB7F89noL0?=
 =?us-ascii?Q?RBwVz6xVXo+ywUOM3f/IbbKqCK+/hkMlA6MpSAqhrhrCFx3Vuo75XzF3rYW3?=
 =?us-ascii?Q?56+ABnCgVdI+6/7hWMlte6j2ZNfyVXuIesviCZ9vhU5nKNyEmbGsoB+EjtlR?=
 =?us-ascii?Q?8h2oeGItoiT0T/ShGGxXcMnutvSfFYFhkRtsIoqH0Fqp8rzQWcTV/0Vr/zuL?=
 =?us-ascii?Q?MtXgX58gny1j3js7i32xetoLiSoFT9sxGUEZ4eSaFEhfCpybxY69yv4FQi/P?=
 =?us-ascii?Q?Ehw39ksrZIKRFOkkZ4pyVfQjZ2RDjjwYWvwOQ3i25WBLiecx0PPCsGL2raB+?=
 =?us-ascii?Q?iAvlZAgunb09Uso7Cs731V4iYldj4dzyGMarjf3yNenmesX3zffVzBmEL8bx?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0cd00e-5145-48a7-b761-08db93d4c676
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 03:50:27.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qr12XGzdHxSr+QQbzcFEFbxkfy/OKbSBGvaoXbyvAjOfgn3Tj3FNFKOWjFSnLuNZ2IK8uJeQPHfeTP2vAfKK4s7b0lDGaEVJEVbemcBw6P4=
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

From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, August 1, 2023 3:=
47 AM
>=20
> Hi!
>=20
> This is the follow up to:
>=20
>=20
> https://lore.kernel.org/lkml/20230724131206.500814398@linutronix.de/
>=20
> which addresses the XEN PV fallout decoded by Juergen.
>=20
> TLDR: This cleans up accrued and partially unused gunk in order to conver=
t
> the APIC callbacks to static calls.
>=20
> The changes vs. V2:
>=20
>   - Unbreak XEN/PV - Juergen
>=20
>     Resulting delta patch below.
>=20
>   - Rebased to 6.5-rc4 in preparation for the CPUID overhaul on top, whic=
h
>     has some collisions due to the recent mitigation muck.
>=20
> The series is also available from git:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git apic-stati=
c-call-v3
>=20
> Thanks,
>=20
> 	tglx
> ---
> diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
> index 468406f511ff..7ad91225fdf4 100644
> --- a/arch/x86/xen/apic.c
> +++ b/arch/x86/xen/apic.c
> @@ -155,20 +155,9 @@ static struct apic xen_pv_apic __ro_after_init =3D {
>  	.icr_read			=3D xen_apic_icr_read,
>  	.icr_write			=3D xen_apic_icr_write,
>  };
> -
> -static void __init xen_apic_check(void)
> -{
> -	apic_install_driver(&xen_pv_apic);
> -}
> +apic_driver(xen_pv_apic);
>=20
>  void __init xen_init_apic(void)
>  {
>  	x86_apic_ops.io_apic_read =3D xen_io_apic_read;
> -	/* On PV guests the APIC CPUID bit is disabled so none of the
> -	 * routines end up executing. */
> -	if (!xen_initial_domain())
> -		apic_install_driver(&xen_pv_apic);
> -
> -	x86_platform.apic_post_init =3D xen_apic_check;
>  }
> -apic_driver(xen_pv_apic);
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index 93b658248d01..c393c44892ac 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1326,7 +1326,7 @@ asmlinkage __visible void __init xen_start_kernel(s=
truct
> start_info *si)
>=20
>  	x86_init.resources.memory_setup =3D xen_memory_setup;
>  	x86_init.irqs.intr_mode_select	=3D x86_init_noop;
> -	x86_init.irqs.intr_mode_init	=3D x86_init_noop;
> +	x86_init.irqs.intr_mode_init	=3D x86_64_probe_apic;
>  	x86_init.oem.arch_setup =3D xen_arch_setup;
>  	x86_init.oem.banner =3D xen_banner;
>  	x86_init.hyper.init_platform =3D xen_pv_init_platform;
> @@ -1366,12 +1366,10 @@ asmlinkage __visible void __init xen_start_kernel=
(struct
> start_info *si)
>=20
>  	xen_init_capabilities();
>=20
> -#ifdef CONFIG_X86_LOCAL_APIC
>  	/*
>  	 * set up the basic apic ops.
>  	 */
>  	xen_init_apic();
> -#endif
>=20
>  	machine_ops =3D xen_machine_ops;
>=20
> diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
> index c6b42c66c60c..a0f07bbfcd6e 100644
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -182,7 +182,8 @@ static void __init _get_smp_config(unsigned int early=
)
>  	if (subtract)
>  		set_nr_cpu_ids(nr_cpu_ids - subtract);
>  #endif
> -
> +	/* Pretend to be a proper enumerated system */
> +	smp_found_config =3D 1;
>  }
>=20
>  static void __init xen_pv_smp_prepare_boot_cpu(void)
>=20

Entire series tested implicitly on Hyper-V guests as part of
testing the topology series with the scope described here:
https://lore.kernel.org/lkml/BYAPR21MB16884A9AE4AF581B0B1CDB25D708A@BYAPR21=
MB1688.namprd21.prod.outlook.com/T/#mf6ccf50e65e214cd6d8ba3e683873bf4139259=
a1

Tested-by: Michael Kelley <mikelley@microsoft.com>
