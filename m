Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0576A2A2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjGaV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:27:33 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947041710;
        Mon, 31 Jul 2023 14:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI9aTDwm/0mc80CV5DNjU7ZDlVGN8NreL2JU0FYv4QgzQxlIKiBNd/nc+7fXU/EcnaOtd1wNEPLkKBaZGK1rxUkPyADDACeHWyVmtGPNjKkGz2DgHjul0nGBTDc4S+PZ0IxCH2GC7gtcKCnDhZpGcvNwZQLlWhDZ4FNoXCSvspWMmIXg1FWiKOq45fKK4+GKFJ+ICvjXzp5KT2pr2IQjL7Wk4qTsV5uKqzVcS89YhNGhP9gf8y5vUxgQKWNrtL8vxirYGq1TGxNpsImrATtFrHrjc/sXpyPRjwjW7kbCejZuPGpCDBNdK8ouPIgH7g0YCFXTQJOzm3wjI9K8fkQOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMwde+NDnF74LNDha5Itf9pc8ZrTZaLaRMvXaaZAWV4=;
 b=hpc3Rf51qcqgcw+NP4I6lOLF5sNzIjOBqFsJkC+gFV0Pa4ff4Uhirs8FR8fh65xEs5QPdELodeZcvejsXMgdArg60VuDUvYmV5kGt7FzLIStTmbr80WcLnXY70MK1jKOar0rQVvdv4zFcLXKdpML2bMT+pwip1C6xXG2YuBVWeDA/VjIPa5qOiltORW0DDjmAXa4GND6Aw9AGgOimqhiL5BzsD28HbTwx1NYAPKX2AzsXjNs7rP+zC2ZShjSLDndflqkJ2S+MvdlF7G6Fl8kgmEg11msL1F7sRX8UIWZNAE/Goenb6ADWSlRf0gEixWwj7MsstzvNl4sBtRNlzK9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMwde+NDnF74LNDha5Itf9pc8ZrTZaLaRMvXaaZAWV4=;
 b=M7EALcDiofiPnyUGu00cPaStOtpyXwMQSeh3OZBtZ3zI/T7rUzAlDI95jF1B18+1Hz1vR9PhqK6MQUL5hAZum28r+opXE1zRZ4QnbvKN25D/dmgd1OxseM3XPeZLVSb3cKnNvu7iF2VIPJZOnMr3cf8xvVdH/D3IEDexbm/JMFs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA0PR21MB1961.namprd21.prod.outlook.com (2603:10b6:806:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Mon, 31 Jul
 2023 21:27:24 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Mon, 31 Jul 2023
 21:27:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: RE: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Topic: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Thread-Index: AQHZwU0WNJnrG48S4EOlGyY6cNlaEa/TN7UQgACcb4CAAA6xAIAAJKKAgAAGaoCAAFBRAIAABtHQ
Date:   Mon, 31 Jul 2023 21:27:24 +0000
Message-ID: <BYAPR21MB1688CE738E6DB857031B829DD705A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
 <BYAPR21MB16889FD224344B1B28BE22A1D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <871qgop8dc.ffs@tglx>
 <20230731132714.GH29590@hirez.programming.kicks-ass.net>
 <87sf94nlaq.ffs@tglx>
 <BYAPR21MB16885EA9B2A7F382D2F9C5A2D705A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87fs53n6xd.ffs@tglx>
In-Reply-To: <87fs53n6xd.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=32b3ff0d-64b2-4c47-935e-818bd8b241cc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-31T21:13:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA0PR21MB1961:EE_
x-ms-office365-filtering-correlation-id: 2f74b364-9b8f-41c8-c0bb-08db920ceeb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfEak3fu8uzdRvYSRXozGGzDL2IZlLmh6m1rUGWTGT8U8fAFa5FeoI0vxnmO6shszuKYiyPVcssrv4hIPehVOd4bD8cOsht51CC6PVxNYjZF/S2HzIcRql543BvxeK9u13zCpGxucfLr/rrLGIi8zi6op71iuBG3E2FLrzQBd2yOQ0ql+y9ttkOUH/93kFxdWz4q/7OscULi1u8x7z8TxY2+S5JQaRxIi1BFCdm7bFEoVgOPWJQvzvVzzNPR3++JyBpTJPQF5L320diGZBt+MjkZZlfsq7GQhK1mGlUps8wKwEZ8g+JlAzZyeD6qgPK0VT1dZBRIOpkuAKLQk9+WrFdOZSFVPsuiIk+pYwSpfEupmLTOxPaD9Y5SFBAIYbxweaz2QBVAXbPRtZj9lx4F3YzcYjB7tcsYCRbO09GbkZZkt6zw5tQ5OiKnwJwzZdSGZ9d7dnX/Azkj9CAIIyMMAOzuU6Ck5z9/ptqvlIlZqUCTWpl2aFUCVPas+K+5YROGe+zGc33hM9kyi2MUB3okQQc0sfPXmCY+DrmLOZcbNBCEZeEBaGhFj4cmUr1Qf5wrD3+jucB6iUYqZbIDFh2Zv1x15gvsvTgVhxqswVp20wz8lAP33TiGHjVB9gn/8dLRzG3NinF4nGbeNs0UegisJ42c+YXu1dC1naO7+hxzQFI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(10290500003)(8676002)(66946007)(41300700001)(6506007)(26005)(8936002)(2906002)(64756008)(30864003)(9686003)(7416002)(186003)(66446008)(316002)(66476007)(52536014)(5660300002)(8990500004)(7696005)(71200400001)(76116006)(4326008)(54906003)(19627235002)(33656002)(110136005)(478600001)(82960400001)(786003)(55016003)(66556008)(38070700005)(122000001)(38100700002)(86362001)(82950400001)(83380400001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QNWPJRo97YUNI04jJssiwc3If6aWPAkVBdLZ8Z07puS4htCVrpih6TA4Kawy?=
 =?us-ascii?Q?Wsis/emHvHfphlDQX1/6cVC9GArnEWzydzUzu+VhR2zs/cIXsn9TMd7zab41?=
 =?us-ascii?Q?U3tfZPVakkQRRuglyztVPumMSzrvphOm+uZgRBZRZKkxpQUWoJbP3RL0fx5D?=
 =?us-ascii?Q?LTLXKPhrga01BFe113ANNjwxdax/WdFVkriJ3EiC5CfVe0vSAJ/18Oaa7BAO?=
 =?us-ascii?Q?wroO4Qs8vCMRE37xVue+ShsEzjv/KGN6EywlRZRDtM0boE53OqSlkq1RQIKJ?=
 =?us-ascii?Q?efw0Suq1WDEXx7uc61hWCl4dd44kw+JVBXjKx1KSoJLU833atMkJO6tQUdQi?=
 =?us-ascii?Q?tR8HPXNA5zN1LL8ohyoaIZfb/ktwO00FFjt8+6TyyOS/n/W9DSqOeRP32FOs?=
 =?us-ascii?Q?WIrqDCnJ0Yduqxmoov/tUUi4q5omf0aUxj6j/E4XK4jTDABvHLLyAEbrg2Dx?=
 =?us-ascii?Q?1EJqcypEAYcZtaxo4aIeIcLPuQRsqbbtWcBcyxH/fh32W2TXtZo/yajSGBH5?=
 =?us-ascii?Q?ueYxqgjxPJnsgd9xoRWH3kmPSzszRQEL9rDF4Gqd6TAqhv5g6jYDoM5txje5?=
 =?us-ascii?Q?dNM6rQJcibaHCf40BOcud3EYael+cQgJD5rmuu+SkGgY4Xw1IzkK6JFPSawq?=
 =?us-ascii?Q?s5K6qcDQuLEateqzPp79X9CtV8rJDzJfIqN/P/h+XCyC5WdHownBh/8xJDW6?=
 =?us-ascii?Q?kJyf0NqfM4JiVO52fUHOzLIVFvW3AHmH3Fo4SP4Jfjkjym30M1DY3ZlhQ+PQ?=
 =?us-ascii?Q?3+IWDtjSNHpASCr2owCEImJHw4xjM/yqdx64OfPsRTS1x1+5O9hvTNsaO08i?=
 =?us-ascii?Q?/XyHwvEyaDp5xmFK9xT5cCmLUdnrbE29BCsupGY/232eakqC0jUvHfe00TaI?=
 =?us-ascii?Q?pVq2ZhV+10auVb35/g6hKiJhBZJ1+kenwYCFwMZaOTjAJOY8Zs+q9thYCuld?=
 =?us-ascii?Q?blMO4jM8If2gEBHz1HPie9U2S720vQbqP/RWKJ1GppAAUELqCpMi7uYrydd5?=
 =?us-ascii?Q?7T/btHv/Zs87qlWIAAYmdm1Y9WtGT+tvO4k7KnJn9IvDxH5dyHhy8aI8mSTa?=
 =?us-ascii?Q?SayTvHeM2TXvCNZn/J2JESAXRVaqiSzMMi4zMLJ94yVBHrhz66dWqEdgO5SE?=
 =?us-ascii?Q?hRleX58XZ5NkXnnh4in87N/gARB8tCrDKKe1l+qWhLP+8ThxfY8Zs3VCuXSt?=
 =?us-ascii?Q?5YBP9vcOx/I3129ZkUJzNBi+/zhywbzKo+svNf4A9N+kLGbgCXOVbrXUBnmt?=
 =?us-ascii?Q?FcsBwfaQPaje3NWH9nErrC/niDyfCTXql9NkBlgVOixdd3FGdhuDm69s5psU?=
 =?us-ascii?Q?lnmXfWwRvb6rnA+DnPYXC1cb18+as2/sP9r4S1RGhgucazlUdLldKB0oy8Dh?=
 =?us-ascii?Q?JBqNa9WTmZ/OOcYhlRY8I080kgZkMy9EsD6g+2gBWPK24R1u/Y6rZ2bF5xwu?=
 =?us-ascii?Q?WPlIMPQ6pD/5aDDbX4vcvNUlcZszw2m8H5IhWPb5gfuDnu9TDsEawzsTvaAU?=
 =?us-ascii?Q?zEwITJ8IE15lAwuANTQ+c7dVb0FufI7JWGy2jUdRNwTlNlOzHPT3jfO43tIR?=
 =?us-ascii?Q?mKYgl6FIt067ZUV5lwRaipoWqXBtNy16IRG4nJu4QUpURtjigeqJ/51uyRAv?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f74b364-9b8f-41c8-c0bb-08db920ceeb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 21:27:24.4868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0Ydwj/PKM8/0AU4VrUU1ulga7+Dopq6iFkMTXYieyGs0DP/oDyWz0Yq9Abux/69IY+TtCtl/3srcuUAMY12g+KoDyd9i4P3TeI5jxzbw0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1961
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, July 31, 2023 1:49=
 PM
>=20
> On Mon, Jul 31 2023 at 16:10, Michael Kelley wrote:
> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Monday, July 31, 2023 =
8:38 AM
> > The VM is an F72s_v2 in Azure running your patch set.  The VM has
> > 72 vCPUs in two NUMA nodes across two physical Intel processors, with
> > 36 vCPUs in each NUMA node.
> >
> > The output is from /sys/kernel/debug/x86/topo/cpus, so the initial_apic=
id
> > is from CPUID, while the apicid is from read_apic_id() and matches the
> > MADT.  As expected, the two values match for the first 36 vCPUs, but di=
ffer
> > by 28 (decimal) for the remaining 36.
> >
> > initial_apicid:      0 apicid:              0
> ...
> > initial_apicid:      23 apicid:              23
>=20
> > initial_apicid:      40 apicid:              24
> ...
> > initial_apicid:      63 apicid:              47
>=20
> Is there any indication in some other CPUID leaf which lets us deduce thi=
s
> wreckage?

You can detect being a Hyper-V guest with leaf 0x40000000.  See Linux
kernel function ms_hyperv_platform().  But I'm not aware of anything
to indicate that a specific Hyper-V VM has the APIC numbering problem
vs. doesn't have the problem.

>=20
> I don't think the hypervisor space (0x40000xx) has anything helpful, but
> staring at the architectural ones provided by hyper-V to the guest might
> give us an hint. Can you provide a cpuid dump for the boot CPU please?
>=20

I'm not sure if you want the raw or decoded output.  Here's both.

Michael

# taskset -c 0 cpuid -r -1
CPU:
   0x00000000 0x00: eax=3D0x00000015 ebx=3D0x756e6547 ecx=3D0x6c65746e edx=
=3D0x49656e69
   0x00000001 0x00: eax=3D0x000606a6 ebx=3D0x00400800 ecx=3D0xfeda3223 edx=
=3D0x1f8bfbff
   0x00000002 0x00: eax=3D0x00feff01 ebx=3D0x000000f0 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000003 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000004 0x00: eax=3D0x7c004121 ebx=3D0x02c0003f ecx=3D0x0000003f edx=
=3D0x00000000
   0x00000004 0x01: eax=3D0x7c004122 ebx=3D0x01c0003f ecx=3D0x0000003f edx=
=3D0x00000000
   0x00000004 0x02: eax=3D0x7c004143 ebx=3D0x04c0003f ecx=3D0x000003ff edx=
=3D0x00000000
   0x00000004 0x03: eax=3D0x7c0fc163 ebx=3D0x02c0003f ecx=3D0x0000ffff edx=
=3D0x00000000
   0x00000005 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000006 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000007 0x00: eax=3D0x00000000 ebx=3D0xd09f2fb9 ecx=3D0x00000000 edx=
=3D0x00000400
   0x00000008 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000009 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000a 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000b 0x00: eax=3D0x00000001 ebx=3D0x00000002 ecx=3D0x00000100 edx=
=3D0x00000000
   0x0000000b 0x01: eax=3D0x00000006 ebx=3D0x00000040 ecx=3D0x00000201 edx=
=3D0x00000000
   0x0000000c 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x00: eax=3D0x000000e7 ebx=3D0x00000a80 ecx=3D0x00000a80 edx=
=3D0x00000000
   0x0000000d 0x01: eax=3D0x0000000b ebx=3D0x00000980 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x02: eax=3D0x00000100 ebx=3D0x00000240 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x05: eax=3D0x00000040 ebx=3D0x00000440 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x06: eax=3D0x00000200 ebx=3D0x00000480 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000d 0x07: eax=3D0x00000400 ebx=3D0x00000680 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000e 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x0000000f 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000010 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000011 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000012 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000013 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000014 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x00000015 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000000 0x00: eax=3D0x4000000a ebx=3D0x7263694d ecx=3D0x666f736f edx=
=3D0x76482074
   0x40000001 0x00: eax=3D0x31237648 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000002 0x00: eax=3D0x00004f7c ebx=3D0x000a0000 ecx=3D0x00000001 edx=
=3D0x000005b6
   0x40000003 0x00: eax=3D0x00002e7f ebx=3D0x003b8030 ecx=3D0x00000002 edx=
=3D0x000ed7b2
   0x40000004 0x00: eax=3D0x00064e24 ebx=3D0x00000fff ecx=3D0x0000002e edx=
=3D0x00000000
   0x40000005 0x00: eax=3D0x000000f0 ebx=3D0x00000400 ecx=3D0x00005d00 edx=
=3D0x00000000
   0x40000006 0x00: eax=3D0x0000000f ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000007 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000008 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x40000009 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x4000000a 0x00: eax=3D0x000e0101 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x20000000 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000000 0x00: eax=3D0x80000008 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000001 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000121 edx=
=3D0x2c100800
   0x80000002 0x00: eax=3D0x65746e49 ebx=3D0x2952286c ecx=3D0x6f655820 edx=
=3D0x2952286e
   0x80000003 0x00: eax=3D0x616c5020 ebx=3D0x756e6974 ecx=3D0x3338206d edx=
=3D0x20433037
   0x80000004 0x00: eax=3D0x20555043 ebx=3D0x2e322040 ecx=3D0x48473038 edx=
=3D0x0000007a
   0x80000005 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000006 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x01006040 edx=
=3D0x00000000
   0x80000007 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80000008 0x00: eax=3D0x0000302e ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0x80860000 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   0xc0000000 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000

CPU:
   vendor_id =3D "GenuineIntel"
   version information (1/eax):
      processor type  =3D primary processor (0)
      family          =3D 0x6 (6)
      model           =3D 0xa (10)
      stepping id     =3D 0x6 (6)
      extended family =3D 0x0 (0)
      extended model  =3D 0x6 (6)
      (family synth)  =3D 0x6 (6)
      (model synth)   =3D 0x6a (106)
      (simple synth)  =3D Intel Core (Ice Lake) [Sunny Cove] {Sunny Cove}, =
10nm
   miscellaneous (1/ebx):
      process local APIC physical ID =3D 0x0 (0)
      cpu count                      =3D 0x40 (64)
      CLFLUSH line size              =3D 0x8 (8)
      brand index                    =3D 0x0 (0)
   brand id =3D 0x00 (0): unknown
   feature information (1/edx):
      x87 FPU on chip                        =3D true
      VME: virtual-8086 mode enhancement     =3D true
      DE: debugging extensions               =3D true
      PSE: page size extensions              =3D true
      TSC: time stamp counter                =3D true
      RDMSR and WRMSR support                =3D true
      PAE: physical address extensions       =3D true
      MCE: machine check exception           =3D true
      CMPXCHG8B inst.                        =3D true
      APIC on chip                           =3D true
      SYSENTER and SYSEXIT                   =3D true
      MTRR: memory type range registers      =3D true
      PTE global bit                         =3D true
      MCA: machine check architecture        =3D true
      CMOV: conditional move/compare instr   =3D true
      PAT: page attribute table              =3D true
      PSE-36: page size extension            =3D true
      PSN: processor serial number           =3D false
      CLFLUSH instruction                    =3D true
      DS: debug store                        =3D false
      ACPI: thermal monitor and clock ctrl   =3D false
      MMX Technology                         =3D true
      FXSAVE/FXRSTOR                         =3D true
      SSE extensions                         =3D true
      SSE2 extensions                        =3D true
      SS: self snoop                         =3D true
      hyper-threading / multi-core supported =3D true
      TM: therm. monitor                     =3D false
      IA64                                   =3D false
      PBE: pending break event               =3D false
   feature information (1/ecx):
      PNI/SSE3: Prescott New Instructions     =3D true
      PCLMULDQ instruction                    =3D true
      DTES64: 64-bit debug store              =3D false
      MONITOR/MWAIT                           =3D false
      CPL-qualified debug store               =3D false
      VMX: virtual machine extensions         =3D true
      SMX: safer mode extensions              =3D false
      Enhanced Intel SpeedStep Technology     =3D false
      TM2: thermal monitor 2                  =3D false
      SSSE3 extensions                        =3D true
      context ID: adaptive or shared L1 data  =3D false
      SDBG: IA32_DEBUG_INTERFACE              =3D false
      FMA instruction                         =3D true
      CMPXCHG16B instruction                  =3D true
      xTPR disable                            =3D false
      PDCM: perfmon and debug                 =3D false
      PCID: process context identifiers       =3D true
      DCA: direct cache access                =3D false
      SSE4.1 extensions                       =3D true
      SSE4.2 extensions                       =3D true
      x2APIC: extended xAPIC support          =3D false
      MOVBE instruction                       =3D true
      POPCNT instruction                      =3D true
      time stamp counter deadline             =3D false
      AES instruction                         =3D true
      XSAVE/XSTOR states                      =3D true
      OS-enabled XSAVE/XSTOR                  =3D true
      AVX: advanced vector extensions         =3D true
      F16C half-precision convert instruction =3D true
      RDRAND instruction                      =3D true
      hypervisor guest status                 =3D true
   cache and TLB information (2):
      0xff: cache data is in CPUID leaf 4
      0xfe: TLB data is in CPUID leaf 0x18
      0xf0: 64 byte prefetching
   processor serial number =3D 0006-06A6-0000-0000-0000-0000
   deterministic cache parameters (4):
      --- cache 0 ---
      cache type                           =3D data cache (1)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1f (31)
      system coherency line size           =3D 0x40 (64)
      physical line partitions             =3D 0x1 (1)
      ways of associativity                =3D 0xc (12)
      number of sets                       =3D 0x40 (64)
      WBINVD/INVD acts on lower caches     =3D false
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets (s)                   =3D 64
      (size synth)                         =3D 49152 (48 KB)
      --- cache 1 ---
      cache type                           =3D instruction cache (2)
      cache level                          =3D 0x1 (1)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1f (31)
      system coherency line size           =3D 0x40 (64)
      physical line partitions             =3D 0x1 (1)
      ways of associativity                =3D 0x8 (8)
      number of sets                       =3D 0x40 (64)
      WBINVD/INVD acts on lower caches     =3D false
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets (s)                   =3D 64
      (size synth)                         =3D 32768 (32 KB)
      --- cache 2 ---
      cache type                           =3D unified cache (3)
      cache level                          =3D 0x2 (2)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x1 (1)
      extra processor cores on this die    =3D 0x1f (31)
      system coherency line size           =3D 0x40 (64)
      physical line partitions             =3D 0x1 (1)
      ways of associativity                =3D 0x14 (20)
      number of sets                       =3D 0x400 (1024)
      WBINVD/INVD acts on lower caches     =3D false
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets (s)                   =3D 1024
      (size synth)                         =3D 1310720 (1.2 MB)
      --- cache 3 ---
      cache type                           =3D unified cache (3)
      cache level                          =3D 0x3 (3)
      self-initializing cache level        =3D true
      fully associative cache              =3D false
      extra threads sharing this cache     =3D 0x3f (63)
      extra processor cores on this die    =3D 0x1f (31)
      system coherency line size           =3D 0x40 (64)
      physical line partitions             =3D 0x1 (1)
      ways of associativity                =3D 0xc (12)
      number of sets                       =3D 0x10000 (65536)
      WBINVD/INVD acts on lower caches     =3D false
      inclusive to lower caches            =3D false
      complex cache indexing               =3D false
      number of sets (s)                   =3D 65536
      (size synth)                         =3D 50331648 (48 MB)
   MONITOR/MWAIT (5):
      smallest monitor-line size (bytes)       =3D 0x0 (0)
      largest monitor-line size (bytes)        =3D 0x0 (0)
      enum of Monitor-MWAIT exts supported     =3D false
      supports intrs as break-event for MWAIT  =3D false
      number of C0 sub C-states using MWAIT    =3D 0x0 (0)
      number of C1 sub C-states using MWAIT    =3D 0x0 (0)
      number of C2 sub C-states using MWAIT    =3D 0x0 (0)
      number of C3 sub C-states using MWAIT    =3D 0x0 (0)
      number of C4 sub C-states using MWAIT    =3D 0x0 (0)
      number of C5 sub C-states using MWAIT    =3D 0x0 (0)
      number of C6 sub C-states using MWAIT    =3D 0x0 (0)
      number of C7 sub C-states using MWAIT    =3D 0x0 (0)
   Thermal and Power Management Features (6):
      digital thermometer                     =3D false
      Intel Turbo Boost Technology            =3D false
      ARAT always running APIC timer          =3D false
      PLN power limit notification            =3D false
      ECMD extended clock modulation duty     =3D false
      PTM package thermal management          =3D false
      HWP base registers                      =3D false
      HWP notification                        =3D false
      HWP activity window                     =3D false
      HWP energy performance preference       =3D false
      HWP package level request               =3D false
      HDC base registers                      =3D false
      Intel Turbo Boost Max Technology 3.0    =3D false
      HWP capabilities                        =3D false
      HWP PECI override                       =3D false
      flexible HWP                            =3D false
      IA32_HWP_REQUEST MSR fast access mode   =3D false
      HW_FEEDBACK                             =3D false
      ignoring idle logical processor HWP req =3D false
      digital thermometer thresholds          =3D 0x0 (0)
      hardware coordination feedback          =3D false
      ACNT2 available                         =3D false
      performance-energy bias capability      =3D false
      performance capability reporting        =3D false
      energy efficiency capability reporting  =3D false
      size of feedback struct (4KB pages)     =3D 0x0 (0)
      index of CPU's row in feedback struct   =3D 0x0 (0)
   extended feature flags (7):
      FSGSBASE instructions                    =3D true
      IA32_TSC_ADJUST MSR supported            =3D false
      SGX: Software Guard Extensions supported =3D false
      BMI1 instructions                        =3D true
      HLE hardware lock elision                =3D true
      AVX2: advanced vector extensions 2       =3D true
      FDP_EXCPTN_ONLY                          =3D false
      SMEP supervisor mode exec protection     =3D true
      BMI2 instructions                        =3D true
      enhanced REP MOVSB/STOSB                 =3D true
      INVPCID instruction                      =3D true
      RTM: restricted transactional memory     =3D true
      RDT-CMT/PQoS cache monitoring            =3D false
      deprecated FPU CS/DS                     =3D true
      MPX: intel memory protection extensions  =3D false
      RDT-CAT/PQE cache allocation             =3D false
      AVX512F: AVX-512 foundation instructions =3D true
      AVX512DQ: double & quadword instructions =3D true
      RDSEED instruction                       =3D true
      ADX instructions                         =3D true
      SMAP: supervisor mode access prevention  =3D true
      AVX512IFMA: fused multiply add           =3D false
      PCOMMIT instruction                      =3D false
      CLFLUSHOPT instruction                   =3D true
      CLWB instruction                         =3D false
      Intel processor trace                    =3D false
      AVX512PF: prefetch instructions          =3D false
      AVX512ER: exponent & reciprocal instrs   =3D false
      AVX512CD: conflict detection instrs      =3D true
      SHA instructions                         =3D false
      AVX512BW: byte & word instructions       =3D true
      AVX512VL: vector length                  =3D true
      PREFETCHWT1                              =3D false
      AVX512VBMI: vector byte manipulation     =3D false
      UMIP: user-mode instruction prevention   =3D false
      PKU protection keys for user-mode        =3D false
      OSPKE CR4.PKE and RDPKRU/WRPKRU          =3D false
      WAITPKG instructions                     =3D false
      AVX512_VBMI2: byte VPCOMPRESS, VPEXPAND  =3D false
      CET_SS: CET shadow stack                 =3D false
      GFNI: Galois Field New Instructions      =3D false
      VAES instructions                        =3D false
      VPCLMULQDQ instruction                   =3D false
      AVX512_VNNI: neural network instructions =3D false
      AVX512_BITALG: bit count/shiffle         =3D false
      TME: Total Memory Encryption             =3D false
      AVX512: VPOPCNTDQ instruction            =3D false
      5-level paging                           =3D false
      BNDLDX/BNDSTX MAWAU value in 64-bit mode =3D 0x0 (0)
      RDPID: read processor D supported        =3D false
      CLDEMOTE supports cache line demote      =3D false
      MOVDIRI instruction                      =3D false
      MOVDIR64B instruction                    =3D false
      ENQCMD instruction                       =3D false
      SGX_LC: SGX launch config supported      =3D false
      AVX512_4VNNIW: neural network instrs     =3D false
      AVX512_4FMAPS: multiply acc single prec  =3D false
      fast short REP MOV                       =3D false
      AVX512_VP2INTERSECT: intersect mask regs =3D false
      VERW md-clear microcode support          =3D true
      hybrid part                              =3D false
      PCONFIG instruction                      =3D false
      CET_IBT: CET indirect branch tracking    =3D false
      IBRS/IBPB: indirect branch restrictions  =3D false
      STIBP: 1 thr indirect branch predictor   =3D false
      L1D_FLUSH: IA32_FLUSH_CMD MSR            =3D false
      IA32_ARCH_CAPABILITIES MSR               =3D false
      IA32_CORE_CAPABILITIES MSR               =3D false
      SSBD: speculative store bypass disable   =3D false
   Direct Cache Access Parameters (9):
      PLATFORM_DCA_CAP MSR bits =3D 0
   Architecture Performance Monitoring Features (0xa/eax):
      version ID                               =3D 0x0 (0)
      number of counters per logical processor =3D 0x0 (0)
      bit width of counter                     =3D 0x0 (0)
      length of EBX bit vector                 =3D 0x0 (0)
   Architecture Performance Monitoring Features (0xa/ebx):
      core cycle event not available           =3D false
      instruction retired event not available  =3D false
      reference cycles event not available     =3D false
      last-level cache ref event not available =3D false
      last-level cache miss event not avail    =3D false
      branch inst retired event not available  =3D false
      branch mispred retired event not avail   =3D false
   Architecture Performance Monitoring Features (0xa/edx):
      number of fixed counters    =3D 0x0 (0)
      bit width of fixed counters =3D 0x0 (0)
      anythread deprecation       =3D false
   x2APIC features / processor topology (0xb):
      extended APIC ID                      =3D 0
      --- level 0 ---
      level number                          =3D 0x0 (0)
      level type                            =3D thread (1)
      bit width of level                    =3D 0x1 (1)
      number of logical processors at level =3D 0x2 (2)
      --- level 1 ---
      level number                          =3D 0x1 (1)
      level type                            =3D core (2)
      bit width of level                    =3D 0x6 (6)
      number of logical processors at level =3D 0x40 (64)
   XSAVE features (0xd/0):
      XCR0 lower 32 bits valid bit field mask =3D 0x000000e7
      XCR0 upper 32 bits valid bit field mask =3D 0x00000000
         XCR0 supported: x87 state            =3D true
         XCR0 supported: SSE state            =3D true
         XCR0 supported: AVX state            =3D true
         XCR0 supported: MPX BNDREGS          =3D false
         XCR0 supported: MPX BNDCSR           =3D false
         XCR0 supported: AVX-512 opmask       =3D true
         XCR0 supported: AVX-512 ZMM_Hi256    =3D true
         XCR0 supported: AVX-512 Hi16_ZMM     =3D true
         IA32_XSS supported: PT state         =3D false
         XCR0 supported: PKRU state           =3D false
         XCR0 supported: CET_U state          =3D false
         XCR0 supported: CET_S state          =3D false
         IA32_XSS supported: HDC state        =3D false
      bytes required by fields in XCR0        =3D 0x00000a80 (2688)
      bytes required by XSAVE/XRSTOR area     =3D 0x00000a80 (2688)
   XSAVE features (0xd/1):
      XSAVEOPT instruction                        =3D true
      XSAVEC instruction                          =3D true
      XGETBV instruction                          =3D false
      XSAVES/XRSTORS instructions                 =3D true
      SAVE area size in bytes                     =3D 0x00000980 (2432)
      IA32_XSS lower 32 bits valid bit field mask =3D 0x00000000
      IA32_XSS upper 32 bits valid bit field mask =3D 0x00000000
   AVX/YMM features (0xd/2):
      AVX/YMM save state byte size             =3D 0x00000100 (256)
      AVX/YMM save state byte offset           =3D 0x00000240 (576)
      supported in IA32_XSS or XCR0            =3D XCR0 (user state)
      64-byte alignment in compacted XSAVE     =3D false
   AVX-512 opmask features (0xd/5):
      AVX-512 opmask save state byte size      =3D 0x00000040 (64)
      AVX-512 opmask save state byte offset    =3D 0x00000440 (1088)
      supported in IA32_XSS or XCR0            =3D XCR0 (user state)
      64-byte alignment in compacted XSAVE     =3D false
   AVX-512 ZMM_Hi256 features (0xd/6):
      AVX-512 ZMM_Hi256 save state byte size   =3D 0x00000200 (512)
      AVX-512 ZMM_Hi256 save state byte offset =3D 0x00000480 (1152)
      supported in IA32_XSS or XCR0            =3D XCR0 (user state)
      64-byte alignment in compacted XSAVE     =3D false
   AVX-512 Hi16_ZMM features (0xd/7):
      AVX-512 Hi16_ZMM save state byte size    =3D 0x00000400 (1024)
      AVX-512 Hi16_ZMM save state byte offset  =3D 0x00000680 (1664)
      supported in IA32_XSS or XCR0            =3D XCR0 (user state)
      64-byte alignment in compacted XSAVE     =3D false
   Quality of Service Monitoring Resource Type (0xf/0):
      Maximum range of RMID =3D 0
      supports L3 cache QoS monitoring =3D false
   Resource Director Technology Allocation (0x10/0):
      L3 cache allocation technology supported =3D false
      L2 cache allocation technology supported =3D false
      memory bandwidth allocation supported    =3D false
   0x00000011 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   Software Guard Extensions (SGX) capability (0x12/0):
      SGX1 supported                         =3D false
      SGX2 supported                         =3D false
      SGX ENCLV E*VIRTCHILD, ESETCONTEXT     =3D false
      SGX ENCLS ETRACKC, ERDINFO, ELDBC, ELDUC =3D false
      MISCSELECT.EXINFO supported: #PF & #GP =3D false
      MISCSELECT.CPINFO supported: #CP       =3D false
      MaxEnclaveSize_Not64 (log2)            =3D 0x0 (0)
      MaxEnclaveSize_64 (log2)               =3D 0x0 (0)
   0x00000013 0x00: eax=3D0x00000000 ebx=3D0x00000000 ecx=3D0x00000000 edx=
=3D0x00000000
   Intel Processor Trace (0x14):
      IA32_RTIT_CR3_MATCH is accessible      =3D false
      configurable PSB & cycle-accurate      =3D false
      IP & TraceStop filtering; PT preserve  =3D false
      MTC timing packet; suppress COFI-based =3D false
      PTWRITE support                        =3D false
      power event trace support              =3D false
      ToPA output scheme support         =3D false
      ToPA can hold many output entries  =3D false
      single-range output scheme support =3D false
      output to trace transport          =3D false
      IP payloads have LIP values & CS   =3D false
   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio =3D 0/0
      nominal core crystal clock =3D 0 Hz
   hypervisor_id =3D "Microsoft Hv"
   hypervisor interface identification (0x40000001/eax):
      version =3D "Hv#1"
   hypervisor system identity (0x40000002):
      build          =3D 20348
      version        =3D 10.0
      service pack   =3D 1
      service branch =3D 0
      service number =3D 1462
   hypervisor feature identification (0x40000003/eax):
      VP run time                      =3D true
      partition reference counter      =3D true
      basic synIC MSRs                 =3D true
      synthetic timer MSRs             =3D true
      APIC access MSRs                 =3D true
      hypercall MSRs                   =3D true
      access virtual process index MSR =3D true
      virtual system reset MSR         =3D false
      map/unmap statistics pages MSR   =3D false
      reference TSC access             =3D true
      guest idle state MSR             =3D true
      TSC/APIC frequency MSRs          =3D true
      guest debugging MSRs             =3D false
   hypervisor partition creation flags (0x40000003/ebx):
      CreatePartitions         =3D false
      AccessPartitionId        =3D false
      AccessMemoryPool         =3D false
      AdjustMessageBuffers     =3D false
      PostMessages             =3D true
      SignalEvents             =3D true
      CreatePort               =3D false
      ConnectPort              =3D false
      AccessStats              =3D false
      Debugging                =3D false
      CPUManagement            =3D false
      ConfigureProfiler        =3D false
      AccessVSM                =3D true
      AccessVpRegisters        =3D true
      EnableExtendedHypercalls =3D true
      StartVirtualProcessor    =3D true
   hypervisor power management features (0x40000003/ecx):
      maximum process power state =3D 0x2 (2)
   hypervisor feature identification (0x40000003/edx):
      MWAIT available                          =3D false
      guest debugging support available        =3D true
      performance monitor support available    =3D false
      CPU dynamic partitioning events avail    =3D false
      hypercall XMM input parameters available =3D true
      virtual guest idle state available       =3D true
      hypervisor sleep state available         =3D false
      query NUMA distance available            =3D true
      determine timer frequency available      =3D true
      inject synthetic machine check available =3D true
      guest crash MSRs available               =3D true
      debug MSRs available                     =3D false
      NPIEP available                          =3D true
      disable hypervisor available             =3D false
      extended gva ranges for flush virt addrs =3D true
      hypercall XMM register return available  =3D true
      sint polling mode available              =3D true
      hypercall MSR lock available             =3D true
      use direct synthetic timers              =3D true
   hypervisor recommendations (0x40000004/eax):
      use hypercalls for AS switches        =3D false
      use hypercalls for local TLB flushes  =3D false
      use hypercalls for remote TLB flushes =3D true
      use MSRs to access EOI, ICR, TPR      =3D false
      use MSRs to initiate system RESET     =3D false
      use relaxed timing                    =3D true
      use DMA remapping                     =3D false
      use interrupt remapping               =3D false
      use x2APIC MSRs                       =3D false
      deprecate AutoEOI                     =3D true
      use SyntheticClusterIpi hypercall     =3D true
      use ExProcessorMasks                  =3D true
      hypervisor is nested with Hyper-V     =3D false
      use INT for MBEC system calls         =3D false
      use enlightened VMCS interface        =3D true
      maximum number of spinlock retry attempts =3D 0xfff (4095)
   hypervisor implementation limits (0x40000005):
      maximum number of virtual processors                       =3D 0xf0 (=
240)
      maximum number of logical processors                       =3D 0x400 =
(1024)
      maximum number of physical interrupt vectors for remapping =3D 0x5d00=
 (23808)
   hypervisor hardware features used (0x40000006/eax):
      APIC overlay assist              =3D true
      MSR bitmaps                      =3D true
      performance counters             =3D true
      second-level address translation =3D true
      DMA remapping                    =3D false
      interrupt remapping              =3D false
      memory patrol scrubber           =3D false
      DMA protection                   =3D false
      HPET requested                   =3D false
      synthetic timers are volatile    =3D false
   hypervisor root partition enlightenments (0x40000007):
      StartLogicalProcessor      =3D false
      CreateRootvirtualProcessor =3D false
      ProcessorPowerManagement =3D false
      MwaitIdleStates          =3D false
      LogicalProcessorIdling   =3D false
   hypervisor shared virtual memory (0x40000008):
      SvmSupported            =3D false
      MaxPasidSpacePasidCount =3D 0x0 (0)
   hypervisor nested hypervisor features (0x40000009):
      AccessSynicRegs               =3D false
      AccessIntrCtrlRegs            =3D false
      AccessHypercallMsrs           =3D false
      AccessVpIndex                 =3D false
      AccessReenlightenmentControls =3D false
      XmmRegistersForFastHypercallAvailable =3D false
      FastHypercallOutputAvailable          =3D false
      SintPoillingModeAvailable             =3D false
   hypervisor nested virtualization features (0x4000000a):
      enlightened VMCS version (low)          =3D 0x1 (1)
      enlightened VMCS version (high)         =3D 0x1 (1)
      direct virtual flush hypercalls support =3D true
      HvFlushGuestPhysicalAddress* hypercalls =3D true
      enlightened MSR bitmap support          =3D true
   extended feature flags (0x80000001/edx):
      SYSCALL and SYSRET instructions        =3D true
      execution disable                      =3D true
      1-GB large page support                =3D true
      RDTSCP                                 =3D true
      64-bit extensions technology available =3D true
   Intel feature flags (0x80000001/ecx):
      LAHF/SAHF supported in 64-bit mode     =3D true
      LZCNT advanced bit manipulation        =3D true
      3DNow! PREFETCH/PREFETCHW instructions =3D true
   brand =3D "Intel(R) Xeon(R) Platinum 8370C CPU @ 2.80GHz"
   L1 TLB/cache information: 2M/4M pages & L1 TLB (0x80000005/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 TLB/cache information: 4K pages & L1 TLB (0x80000005/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D 0x0 (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D 0x0 (0)
   L1 data cache information (0x80000005/ecx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (KB)         =3D 0x0 (0)
   L1 instruction cache information (0x80000005/edx):
      line size (bytes) =3D 0x0 (0)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 0x0 (0)
      size (KB)         =3D 0x0 (0)
   L2 TLB/cache information: 2M/4M pages & L2 TLB (0x80000006/eax):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 TLB/cache information: 4K pages & L2 TLB (0x80000006/ebx):
      instruction # entries     =3D 0x0 (0)
      instruction associativity =3D L2 off (0)
      data # entries            =3D 0x0 (0)
      data associativity        =3D L2 off (0)
   L2 unified cache information (0x80000006/ecx):
      line size (bytes) =3D 0x40 (64)
      lines per tag     =3D 0x0 (0)
      associativity     =3D 8-way (6)
      size (KB)         =3D 0x100 (256)
   L3 cache information (0x80000006/edx):
      line size (bytes)     =3D 0x0 (0)
      lines per tag         =3D 0x0 (0)
      associativity         =3D L2 off (0)
      size (in 512KB units) =3D 0x0 (0)
   RAS Capability (0x80000007/ebx):
      MCA overflow recovery support =3D false
      SUCCOR support                =3D false
      HWA: hardware assert support  =3D false
      scalable MCA support          =3D false
   Advanced Power Management Features (0x80000007/ecx):
      CmpUnitPwrSampleTimeRatio =3D 0x0 (0)
   Advanced Power Management Features (0x80000007/edx):
      TS: temperature sensing diode           =3D false
      FID: frequency ID control               =3D false
      VID: voltage ID control                 =3D false
      TTP: thermal trip                       =3D false
      TM: thermal monitor                     =3D false
      STC: software thermal control           =3D false
      100 MHz multiplier control              =3D false
      hardware P-State control                =3D false
      TscInvariant                            =3D false
      CPB: core performance boost             =3D false
      read-only effective frequency interface =3D false
      processor feedback interface            =3D false
      APM power reporting                     =3D false
      connected standby                       =3D false
      RAPL: running average power limit       =3D false
   Physical Address and Linear Address Size (0x80000008/eax):
      maximum physical address bits         =3D 0x2e (46)
      maximum linear (virtual) address bits =3D 0x30 (48)
      maximum guest physical address bits   =3D 0x0 (0)
   Extended Feature Extensions ID (0x80000008/ebx):
      CLZERO instruction                       =3D false
      instructions retired count support       =3D false
      always save/restore error pointers       =3D false
      RDPRU instruction                        =3D false
      memory bandwidth enforcement             =3D false
      WBNOINVD instruction                     =3D false
      IBPB: indirect branch prediction barrier =3D false
      IBRS: indirect branch restr speculation  =3D false
      STIBP: 1 thr indirect branch predictor   =3D false
      STIBP always on preferred mode           =3D false
      ppin processor id number supported       =3D false
      SSBD: speculative store bypass disable   =3D false
      virtualized SSBD                         =3D false
      SSBD fixed in hardware                   =3D false
   Size Identifiers (0x80000008/ecx):
      number of CPU cores                 =3D 0x1 (1)
      ApicIdCoreIdSize                    =3D 0x0 (0)
      performance time-stamp counter size =3D 0x0 (0)
   Feature Extended Size (0x80000008/edx):
      RDPRU instruction max input support =3D 0x0 (0)
   (multi-processing synth) =3D multi-core (c=3D32), hyper-threaded (t=3D2)
   (multi-processing method) =3D Intel leaf 0xb
   (APIC widths synth): CORE_width=3D6 SMT_width=3D1
   (APIC synth): PKG_ID=3D0 CORE_ID=3D0 SMT_ID=3D0
   (uarch synth) =3D Intel Sunny Cove {Sunny Cove}, 10nm
   (synth) =3D Intel Core (Ice Lake) [Sunny Cove] {Sunny Cove}, 10nm
