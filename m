Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CB8764AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjG0IL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjG0IK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:10:29 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544251BC1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABQCfNLPeYpOXzu/RlEDMKxNijV/cYTR8RftVnhZmFcgPFAkyVJ7+pRvCO6Louies655ECAT7pU71BapjTc7t8bZP250uJnL2H5pypNzwrUBvPLn1SLMscYCfNBptiQalDL9j2dpWdiyCkIokBESJeUubF34g44mLK9NIZlobWAP37hf93Ic3Th4IAjgZlCFB7JqLIBa+FlY43cnPAfOYELwsxebQ+SSQ72iQfVocSM3rg6QKAv4Xt1OyX2AR2yTxeXU9nw1q+L44ILXtT0PIbpmKE70fMQbvqXLvZFbOlowtP9uPWMbQL0HPMxol2EimJ5qfMJQ5LUfKTMeNajkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZI1D0EBpGslw1eR949R1MaRJuZyQgRu6beUNtfX8PI=;
 b=cweF/n14kK8fyYrZaukBg1EkHPNET37F92SUrTl1hMBIUgk3TrakdMyxjla169tN+tQAcsEB2pS71h7MC+/z0TITysW5AofNPB0UJpRfU3GDJC3KUoQ4tY0MEh/cgfFIBOiSdg5r22Hn4lJybVhsNLRCVsucKfgezf1cxP4ui6+QymN24NAatEmmOgIKTsqJEoLWh8PS476tJL/r7SMTtlGuq0y+fC+piMXpaot9FQjOQNLecSJhZfMw1cpjWMKiOVyukyY7Yp1M0Y4UL71RQAQ8DeFClhMrwV9tLX1cSNQlx3JVaMXQIrtRwEKICRrhi3UegrJJhs3O1BMGXmVedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZI1D0EBpGslw1eR949R1MaRJuZyQgRu6beUNtfX8PI=;
 b=Wx9mC1d5nONo1AZvQFgkNxxawvjDCasglymYHxL9I+aaJsazg+WwkaVJ2P4yMYIWamJP/qDmiht6qh71yWqxkBSpW/alr72j5+ghVEG9U7bqxeb9CsUvyRRw4UU3dfcbwu0Ld2dno2JQZs/7nM00rV9SeU4hdZN5Qw4iLWOvdfA=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 SEZP153MB0632.APCP153.PROD.OUTLOOK.COM (2603:1096:101:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.5; Thu, 27 Jul 2023 08:06:28 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f%4]) with mapi id 15.20.6652.004; Thu, 27 Jul 2023
 08:06:28 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharath George John <sgeorgejohn@microsoft.com>
Subject: RE: [PATCH] x86/numa: Add Devicetree support
Thread-Topic: [PATCH] x86/numa: Add Devicetree support
Thread-Index: AQHZqMj18wvdpynsiE6phwVwKFX+GK+13yuAgBeRfuA=
Date:   Thu, 27 Jul 2023 08:06:27 +0000
Message-ID: <PUZP153MB0635F77C9D0441CC4F1453C4BE01A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
 <PUZP153MB07491ED0C0688FF9104F72CDBE36A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB07491ED0C0688FF9104F72CDBE36A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=090d9506-94f6-4c96-8b2d-f91f2dba147e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-12T08:10:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|SEZP153MB0632:EE_
x-ms-office365-filtering-correlation-id: 943ff59f-83cd-4cae-6e24-08db8e786119
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5z1sGT+QlHg10Ob7qNsbfdAiksDmdUrnqBq8fDRI7Pav0kDiUHyB4I/C29lFzqXPmi0YtVM89RdeH/gLD/jjsAAi31b6Z6pGip/DgUExF/b5iYqdV8EmTDdtwU8Kce6S5ver28IU6PNvAsmqnMvEU8kHbXMahO+IKJ7+GrfSq24xx3YuZeRbQ47pbtYuqSqfcBFd8En+OkQK+adhASkaNHZBZP6Xm+DaztjgWPJJwPjwUFlmCkq/3IXRzQN0UPQCF83rnOjT5gWwPyjQ6vkx1OBawCpYmR4V1pcRaP+o6BbSUz3FZo3Fhu/m8yPuyKQ5CjN9x7IJ2jBjHWaYMEWbhGLOfiGUMDnRLAkDMD/e7YIFjrT5NHQpGFq6AHdmjz5aUvXefmVoKBWvWGLVsomaNDEmsJ7eJvU+pM9xRcjg/a6Lcu6lxrjvsqpv1T2/6qLG7TCh72NBMdBsBnaNip+5Vqfj7YFva9M+DIm7oWfxePbZtL45XG/yH2LjYMbY9IjTt9pr5xIBnndyXSqyC/f/0hc4UCYqf0Ai5gCLin3f2JRVLpRYR5SEUfaq1FJR/UE1Vg/Iz/6pq4D25H8Acxwzsx4mKayNy8v9DAEFtCrP1T72kILdkcz5ID86Q9RSwNXXOHPl2ZHyxQJE2QbC9r1K0jqfYFPDVLXSA5mC+OYZiTvI1w54d+OadjfbVOPUHLF+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(38070700005)(86362001)(33656002)(55016003)(5660300002)(53546011)(6506007)(186003)(8676002)(41300700001)(9686003)(8936002)(52536014)(8990500004)(2906002)(83380400001)(6636002)(110136005)(76116006)(10290500003)(71200400001)(478600001)(316002)(66446008)(66556008)(7696005)(66946007)(64756008)(66476007)(82950400001)(82960400001)(38100700002)(122000001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OoDdt4WQaVXCdYRugdFesOPNhcwavNK2pignNuWbOkVasN0IEcMJ2UXj7bP7?=
 =?us-ascii?Q?8LBfxxWX2OtqU4/Tad/PI5q36Apz8MKYTpiw4+RDiTQt/zCLM0Mt8qHS0W0y?=
 =?us-ascii?Q?wWe8MyPA9g9etvr+xpmjDyAl871JhHbdnAHHhXbd0D99ut84ZviK5SgSS3A4?=
 =?us-ascii?Q?VQjN5xISyQTKbF/Sb3mGjODWR7XDBMj4i3f8lJRBrCEONzrdpeMpS/7Gtxeb?=
 =?us-ascii?Q?JqZ2NK8PU0PPbmMbsUApirMscczfAF/MWz9/emeKLl6zQ39+pBR/i+eAvhFM?=
 =?us-ascii?Q?fFQmFQP2V2MEhEVMpIYECULIQz4bmEIxGdtncJxVlyu9NWWaMH4GkLRWTihS?=
 =?us-ascii?Q?mOyijIsRV1lF4+fqJI9JKnZpXerzIYrep5PhbVG9ii57peYzUWB5O0owAOl1?=
 =?us-ascii?Q?QuEFDVLmQqk9YfiZ8a2BzHVlllydFrzgCvOfJeS8mtwUA49TSR4zNP+WrEXG?=
 =?us-ascii?Q?sqkluufT0BAkBTSK4VB6qg+f3HIEBeeGNR2XFdmSE3KZwNrHhrrAh8mE29ny?=
 =?us-ascii?Q?NkXBvFPP4B1jeDE6GIOTq1fBmdvNFKd80DOC+NLRaERVYPKSPDs9iS6XVdf3?=
 =?us-ascii?Q?5HvAUKW7NOUt98+n72aP/1TW+vFouT1dYWwB2QhJv/h/+vA89kQOPF/wOpKt?=
 =?us-ascii?Q?vEM2g2eVRsg2G2l801VKVrsP0lT+8PpmVKJrEMFsi5+FqicWVRxJwdcWBZGP?=
 =?us-ascii?Q?bBVRTZEBTgpaLNjoGlKq+xZxpX0WLBgD9hNbZJBe8t2CovlVgNENoQfuNerZ?=
 =?us-ascii?Q?LrJcJfsIyzIwsIrkTobOhyRU1vT1GIltJtjar3NiEkrem9X1AfXUbpKomNqr?=
 =?us-ascii?Q?ZWFnmgROL351dXQavO1Jtxv2J4f29LvG4ccNbgWKYTQOe10aYIgg31xzqBkA?=
 =?us-ascii?Q?Kn90IEqYczC1hZMv3RHe5WVshkYMtDZspDcUvzo0p0fbGiHB0DPiom5gc1K0?=
 =?us-ascii?Q?wFSNUmTyg6ThRxLQr/I7gzn8NOeXqM2ObsfSBuJPWlj0Nm60s3QbIPkGoxrE?=
 =?us-ascii?Q?jY+pFadmKSZVgNoJx/a4KpTPlTpDYjppA3qlHs+TApUTxvbNfWxNGKgpon5m?=
 =?us-ascii?Q?vGtoDrBYJjw0k99lUqGZLJqXfzrqLss5mdv7z/sFcVgyfwxaEdxQJeNwgUI8?=
 =?us-ascii?Q?PMKqUd8CIVvRjcWcU6PjcNTaewd/41D/P0htftUZH/OPZlrIJkUq/5384AZa?=
 =?us-ascii?Q?nhoN5UbVoBPIq5k7E3MJRf/d1Jpoqs+9b9aMmuZbV/fI0JdaAI3wXMgyNylv?=
 =?us-ascii?Q?VwlcOujD3n3nnoQ0zVWsQkPQYp7glChWIpEQUigUSO++1AXpr3knzhXovgiC?=
 =?us-ascii?Q?O6CVcFjIDAzt+q3ijbYhHCXa+KejFLtigXypKrm1hciwHtkfESQb3/gEJ8HN?=
 =?us-ascii?Q?VxMLxPOPWWz6KsxEwWNsUZYdUX9dadrIn4UN6AR1r0yx9bkc2jc0KEpnpbcB?=
 =?us-ascii?Q?6DdBTHaK4lJFClMd7EM1ixoLi4BolPR10WeH9ucS2FCCIUKE574Q1Lxg+PgA?=
 =?us-ascii?Q?LuCaII7E2KtWFIxqGdlDMDg9xfYAYVACEKJp+yeJp06wyhiROVmalVxOD45C?=
 =?us-ascii?Q?UXcGWxXbcF4J+nsFoQ5VYkI8/ZCG4F+WXTo4kE9Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 943ff59f-83cd-4cae-6e24-08db8e786119
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 08:06:27.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cx73KnVgZJBCgBPFilxtcvXvP6mSza941OoNyxaoKRVYREVSnHmR7vSIXsvjge7Eftef1s3tPMMyEZQC0o65Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZP153MB0632
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Saurabh Singh Sengar <ssengar@microsoft.com>
> Sent: Wednesday, July 12, 2023 1:42 PM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> x86@kernel.org; hpa@zytor.com; luto@kernel.org; peterz@infradead.org;
> Michael Kelley (LINUX) <mikelley@microsoft.com>; linux-
> kernel@vger.kernel.org; Sharath George John <sgeorgejohn@microsoft.com>
> Subject: [EXTERNAL] RE: [PATCH] x86/numa: Add Devicetree support
>=20
>=20
>=20
> > -----Original Message-----
> > From: Saurabh Sengar <ssengar@linux.microsoft.com>
> > Sent: Tuesday, June 27, 2023 12:58 PM
> > To: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> > dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> > luto@kernel.org; peterz@infradead.org; Michael Kelley (LINUX)
> > <mikelley@microsoft.com>; linux-kernel@vger.kernel.org
> > Cc: ssengar@linux.microsoft.com
> > Subject: [PATCH] x86/numa: Add Devicetree support
> >
> > Hyper-V has usecases where it need to fetch NUMA information from
> > Devicetree. Currently, it is not possible to extract the NUMA
> > information from Devicetree for x86 arch.
> >
> > Add support for Devicetree in the x86_numa_init function, allowing the
> > retrieval of NUMA node information from the Devicetree.
> >
> > Additionally, relocate the x86_dtb_init function before initmem_init
> > to ensure the Devicetree initialization prior to its utilization in
> > x86_numa_init.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/Kconfig        | 1 +
> >  arch/x86/kernel/setup.c | 2 +-
> >  arch/x86/mm/numa.c      | 3 +++
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> > c531b16ee0bf..a2ada193b2d8 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1567,6 +1567,7 @@ config NUMA
> >  	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
> >  	default y if X86_BIGSMP
> >  	select USE_PERCPU_NUMA_NODE_ID
> > +	select OF_NUMA if OF
> >  	help
> >  	  Enable NUMA (Non-Uniform Memory Access) support.
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c index
> > fd975a4a5200..940c92a6a5e9 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1220,6 +1220,7 @@ void __init setup_arch(char **cmdline_p)
> >
> >  	early_acpi_boot_init();
> >
> > +	x86_dtb_init();
> >  	initmem_init();
> >  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
> >
> > @@ -1261,7 +1262,6 @@ void __init setup_arch(char **cmdline_p)
> >  	 * Read APIC and some other early information from ACPI tables.
> >  	 */
> >  	acpi_boot_init();
> > -	x86_dtb_init();
> >
> >  	/*
> >  	 * get boot-time SMP configuration:
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c index
> > 2aadb2019b4f..a6d3d331fda2 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/nodemask.h>
> >  #include <linux/sched.h>
> >  #include <linux/topology.h>
> > +#include <linux/of.h>
> >
> >  #include <asm/e820/api.h>
> >  #include <asm/proto.h>
> > @@ -733,6 +734,8 @@ void __init x86_numa_init(void)
> >  		if (!numa_init(amd_numa_init))
> >  			return;
> >  #endif
> > +		if (acpi_disabled && !numa_init(of_numa_init))
> > +			return;
> >  	}
> >
> >  	numa_init(dummy_numa_init);
> > --
> > 2.34.1
>=20
> Hi x86 Maintainers,
>=20
> May I get your feedback on this patch.
>=20
> Regards,
> Saurabh

Kind reminder to review this patch.

- Saurabh

