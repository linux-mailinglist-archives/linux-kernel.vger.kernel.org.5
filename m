Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E675BD2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 06:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGUESG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 00:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjGUESB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:18:01 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A561FED
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+GD42vlP0LegJ6wt/97N6x2R2Fp1mK1rABv4JAenXD0QieEQZddNiGP32tEu8F4NU+irVchcR1U+KmEE3v9jC0iucct6J+Xnr0crI8vsTInQGEoQnYAXkyCFNOO+6X2GcxFTc01msje8uKKBZViCoJjaJHsnfvd/SmtjJ/Uppx3JYa1PK8CL0rKiGBFo2fBIbZ/Oy0kXHWhLXxJRxuhVRaYmV3g3Y++/Aq2NTm2eVsjLlzIFMs7SsBGt28VhxNd5crr5Dka6heVi9DKej2OS4SOQRoAPUG7vSLTDVjmBqVmm04n+kncHm17kPVKnA9UPoNiL9N6Dn4+pKbFrLR1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnb/W/FTSbJjOdYpeT++Gspl++E6Q7DXxuwRZ+Xpf7M=;
 b=U0E3SHWNq5zrKFb1XZZjC1HVG79rveT8an6AsuGtAwDaP4Nq0BRawG+AUBSG9/qpGJeHmiu7ki6EZl7tzyPA1rkywCne1grFhmHp3sJVBY5X7klw7ILAI/tcLjEnH9i5BsSVT/woYrKH9hUEkS9/LrDoy/m/2pw8ioXBesGT+ZUj3IkScGuDDstuTDzJKrgzhprCn0f+O+PhaJLKdemGTlHzQkQFdRxs6ilij00xtKm4tHsSZ7UN/cq8lzi5c/qOyNoea9ZRvoPNRYhxlVtaeUqVP93NwJDwnTYLg5INPV28C/AmKkS1uPLaSbfn8Wuq/WuBEmeGIOQyYZ5gYPN5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnb/W/FTSbJjOdYpeT++Gspl++E6Q7DXxuwRZ+Xpf7M=;
 b=Ad73dEeZvI6xYDzTtJmIULj/hdx6pSYU6x+mOEt4Ct3bdBVtdPJMnQUuiZyWJmT5s35nsR//VfA8PuCMmWdLOVPphOMHNyx0aSdUXe1+9y6aQV047mxCAMl9EVITmKoINC3HRJsUIWkypxAEHIQw5hFJKW83bHma5PW7eNuPpF8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA3PR21MB3914.namprd21.prod.outlook.com (2603:10b6:806:301::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8; Fri, 21 Jul
 2023 04:17:56 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::c164:97f6:174e:4136%4]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 04:17:57 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: [patch 19/58] x86/apic: Get rid of apic_phys
Thread-Topic: [patch 19/58] x86/apic: Get rid of apic_phys
Thread-Index: AQHZuQS0jOAaAu5OoE2Fx4d6ljj3Ga+/gMIAgAKNfOCAAEEEAIABUh5A
Date:   Fri, 21 Jul 2023 04:17:56 +0000
Message-ID: <BYAPR21MB1688FEC2C98E74FA8EFDDDC3D73FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223224.207131427@linutronix.de> <87edl5xt2n.ffs@tglx>
 <BYAPR21MB1688E1BDE9B6D1225E590FF1D73EA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <874jlz3t87.ffs@tglx>
In-Reply-To: <874jlz3t87.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bf664af2-00b9-4254-92f6-5174a4a91954;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T04:13:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA3PR21MB3914:EE_
x-ms-office365-filtering-correlation-id: cbdab0b5-dbba-4506-8de2-08db89a17606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZnUa1jtPxqEzXCMfbej8bDI9STu+zWD3pbM3ckTdEWUccphlPu0TJPAcN1d7ySQd5aFh+wcal0tPR0igF/rB7qtYOPAAWFmAl84P7lCAbYO+iATGqs1A9zqEDS3Ragj5Xo6tLN3mKKtPUmr7/7ZQcv7umICTEQ1SV9ch2NrGWysfsjqW05qSFSCVUw6XClHhIEsjv0FXFnunRuy7anlg/cjK08FqbzhDyoEcF+7EoxXqutaCaFUQtlUDoJyOBh5pinjyfCiptu2fHl7A2JJHmvWvl5PsvKa9UqMmMTmaGwOmsilBPvJWjEjGbMbDuuDwyzUO6hY+wu+1xDw6a9Hzb7sM1LIS2wBxJP2rWHBo/B49/RsmUz9YtfXvSZ15rBEmMuGBPaUtByO/15MKcGIWOE8vkz9T7JudJCeDRxATptTftnPcNz2k09Q/DoT7pBqZuTWac4LEquh55K499jlTWNFC1M26ULhykGx4mR6sCP9vs4dXHwDhMPjsd574GSDSkFLQ30/Gegvx/vyOTgZjc7Uy70uS7hCtq/RyshK19isVCiZJeeGMwOekhd9BM1lnVajoRA3soQl3hrJTBzG5YuR4b1tGJp+e5AS1pRAXPeVao/IG4DAMIlosAs6PLW+Gl7/cZRleeRp/srFvwh7NDVUivAdYDX7yxOjwpOQg41Nz0rEcji0kQYxi0FDK/st
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(76116006)(66556008)(66476007)(66446008)(66946007)(64756008)(83380400001)(316002)(71200400001)(38100700002)(9686003)(55016003)(54906003)(10290500003)(478600001)(6506007)(186003)(26005)(4326008)(82950400001)(122000001)(7696005)(110136005)(82960400001)(5660300002)(86362001)(38070700005)(8676002)(41300700001)(8990500004)(8936002)(2906002)(33656002)(52536014)(7416002)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqS3emWxOeCkG4eJoXDfn2Zv364wEmj92SVv940PQpXi3BImNsEL+fUyjhjZ?=
 =?us-ascii?Q?CSmZT28aNUMTiuNMbsZhEnA+seCRnQESCc0UGbsJxagyRXDOMvaRsoRjMKXB?=
 =?us-ascii?Q?9G/FANybpsjlTmOzopdiUw7E6T5GruIzg6AsumzexU726IsLEB/dPuWtymv2?=
 =?us-ascii?Q?kUwjEfwaWvgSaQjehJ0/QWWSrWLQL9BUY/A9CEU+Hp0zlwZSBfBn8T2FjBSX?=
 =?us-ascii?Q?F2PfJeJvDJ21qY57Nv71saUN21kFKH3EApHEf7wCaQFZOd3xspFlj+tyytJo?=
 =?us-ascii?Q?cFAi2km/tlKPpb1jAkCpOgHLjdKvfF6Ru0SC8L/pyX+ImjLJ1AODZE0iszKk?=
 =?us-ascii?Q?iV23D3HMFkArtN5GGYNHzTmq5BKAHpeGxFbSFZ1CvLCoOa/14YnpWnngmYdf?=
 =?us-ascii?Q?PP4kdkKb40o6+ukVZwIVuPkmNIeXgFrVLjhGXV8HZ1u78001axg4ghOVXoku?=
 =?us-ascii?Q?yseB95jL1CvL4prD2AAUK0AT8F1SdlKFx4uK+S+ta/5xnR1mbgrsAG8+hSFd?=
 =?us-ascii?Q?wNze+aRQBpASZGPSN6jQQjr3TTKIU6rh8p6PHffhmuzWgAkyei/3pxMonXEh?=
 =?us-ascii?Q?J29pYGef4QV7WB7a9tmer9vVbEVuHAvkAeryBJKRW1guPTxJ7UWTdift8hEJ?=
 =?us-ascii?Q?OPt2RsTMhWBf5LWc14i5IDBQVgRmkmELfmrmABa0E3nQvPdMpDdXj2VQbPFX?=
 =?us-ascii?Q?NT21+ySu4w+UU9O9oWW4RC0PM9Sh8YEgO46g4Sh9NV543jGpJ3HHe+YYdH7C?=
 =?us-ascii?Q?epOSYAplZKPTijTmWDq9yslPEpNuRH62qNiHcHADT/oE9ChS8UVp45c7Fs5e?=
 =?us-ascii?Q?6sH0N4A7ypywwhZYWc/sindNfDBAoTXTpfNM3yY492vVZZ/d+5od4l4zd24N?=
 =?us-ascii?Q?3Eel7SsoDTuXFG1n5hTHbZlAIGy+ptZ1ryILGu3+WXoS9DQu+43JhaC3fi4o?=
 =?us-ascii?Q?2m6hoWIHrnymMOt3JDe6/mm8TtmX+DThFjtM/qek4d1zb+pRDbDXZgY1Y5ee?=
 =?us-ascii?Q?EQlylbNlMPlHQtmxcmjQ/JkDAMa+7Ig0M+IwSwEMLTBvwkXoolP8AYS+rfJ+?=
 =?us-ascii?Q?FfRlH4wONLAU9SAilTE2K6EB69ywpmkmIOL7zfDQYEcVuZ1u9D8ZPYUvQ5bi?=
 =?us-ascii?Q?kn8IahQNyLncDrgRs7ZosEBF2v+6rqKhqyEEOJRZDE27wTEIqNiYT9bgWr4C?=
 =?us-ascii?Q?xKiqyvdNS9kv/o74UBc9IEPDspcQ6sy9TjyQJEuz38ZWXN0JeOnv6CutJq4t?=
 =?us-ascii?Q?32J7zVbUseqxp7ZuUGWk/8vXpGXmpUpWH9Tq1SeOp05v8CKm+YqCDBF8nHc6?=
 =?us-ascii?Q?j7iutRn4CNiNQ/LDQUMcdORYIPgL0q+DzzzErr3tpgg2r4tyAqVdiYP5Hdz2?=
 =?us-ascii?Q?WWpJR2l0iAyopaf8j9QARGXcsRgM00h9siwy5K65gnTBumDH+o6zhpdrzZDi?=
 =?us-ascii?Q?eBUluUpdhOHVl5z3VU8MT+0bovXsFcTkkyd9YVB7Te/EMcgqhCh6eLTZbBSf?=
 =?us-ascii?Q?OV+5/6D+5P7AvAQJbU719zZ8he2kbPRiebUV+SVNGPyRPjdKy3Cp5uMJMRsp?=
 =?us-ascii?Q?xXj6Z1dx9YZH6/dcKQzZMEsnaN1eGjGLGp6MO+QtETw4yZs831DqVaP0214s?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdab0b5-dbba-4506-8de2-08db89a17606
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 04:17:56.5471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fuVAFFkJ6LYMXzlo5VLO9CjO2Y5i0D62mSuHPVdZj19JPpAhApq8zIld4pqy9oWA71lDPWn/1D2WrkUIKrD9zBL3W0vbUJz20vqSbbEMnIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3914
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, July 20, 2023 1:=
03 AM
>=20
> On Thu, Jul 20 2023 at 04:18, Michael Kelley wrote:
>=20
> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Tuesday, July 18, 2023=
 6:12 AM
> >>
> >> On Tue, Jul 18 2023 at 01:15, Thomas Gleixner wrote:
> >> > @@ -1921,7 +1922,6 @@ static __init void try_to_enable_x2apic(
> >> >  		 * be addressed must not be brought online.
> >> >  		 */
> >> >  		x2apic_set_max_apicid(apic_limit);
> >> > -		x2apic_phys =3D 1;
>=20
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ This hunk _IS_ wrong and needs to be
> reverted obvioulsy.
>=20
> >> >  	}
> >> >  	x2apic_enable();
> >> >  }
> >>
> >> This hunk is obviously bogus. I just noticed on a VM which takes this
> >> code path...
> >
> > I'm testing guests on Hyper-V.  The case where the x2apic is enabled
> > in the BIOS works, but when the x2apic must be enabled by Linux,
> > the VMbus drivers never get initialized and things go downhill from
> > there. Your comment above is somewhat cryptic (as I haven't studied
> > the patches in detail), but I'm guessing it explains the failure I'm se=
eing.
> >
> > Let me know if I should debug the failure I'm seeing.  Otherwise
> > I'll wait for a new version and try again.
>=20
> Can you add that line back and retest?
>=20

Everything is looking good now -- my VMbus driver problem was actually
an unrelated config problem.   All combinations of Hyper-V VMs that
I've tried with xapic and x2apic, and on Intel and AMD processors,
are working.   There are couple more old configs that I want to try
tomorrow or over the weekend.

Michael

Michael
