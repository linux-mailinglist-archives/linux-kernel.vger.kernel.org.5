Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1452A761DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjGYPvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGYPva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:51:30 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538591FFF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JF44qfzJhu8u4Tj6j9j4qmzPEcibrGiQCtP1l69/WBORDTSbcW0nFsMB1Y+3FI4qiElxtybEQ59bVBtP/oHALYNIG3P9gBnhxnWlWkguvng/8khIwKWeLxWWE59i0zevT5o7drGKZvdto8eLe402DtGvbPppkNnrt1sCm1XSTYFTh83XaW2B3XstpygaG2GmyPsv43H/9DLO4rDpzd6V/FQKmmh5pbvEmdRFxH7Hd8y9PfxAb4ng2u79H7noHNwUyfesVViFsQ8RhTzx2wWEHntZw7bLBfiNI+93Ki/AGpZO4tNtxyoiieVgfCtLaoFn81cvIPi56HSdSccYnkdkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tw6Ndh7S6Z0ubXfnC+gjeUTmJuFWnR2a5MIYwcauXC4=;
 b=LkEfvMjPEjFX2DlhQRTIVpNO3uVkTI6gFOCVegvTzUtNe4ftHoUVuGL+Nk6zSDQke2marzk9rxBvca3YnXY+SJZKRrdlaJUQIHeMecFX0QvsfO4K47Chn0AQq6ADZ8BE1VyQmezSI7NywHr+bE30yaJ9bw9u57iEJ2mlK2bMRUucN/f3EMqS1R6TqbILee+6PCoCdL5+deQyyzQyzFqwUttUiUWfIHADVWCHKiXJqW47dD76jeRO2xo62lwiFNp0WKkrcJvPPuylnn5OTKEp93X3H6M+oUrYE342sbcrxNA6FDE43+AxKn/wpOQYk9O6thmvU7WUDSdJEH3i+vuCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tw6Ndh7S6Z0ubXfnC+gjeUTmJuFWnR2a5MIYwcauXC4=;
 b=IUYsbcW4gaqpEWYfVRVLS1HcjCsHA2xx7BQzlp75HSRRAF2f+v15ZaxO2lzU+ZZKLVcnPIJyjJSvhBoarQyuzsyMb4w8bTlMBI4eQn4uHtT67EwTOZfdDcg+p73m9FxsLBUR/Bq6siZj5sDilHlAgmLzGxWS1td0c03/JFUHs2k=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.3; Tue, 25 Jul
 2023 15:51:25 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::ac96:bb0:9cd:f4a1]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::ac96:bb0:9cd:f4a1%4]) with mapi id 15.20.6652.000; Tue, 25 Jul 2023
 15:51:24 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Topic: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Index: AQHZmF1U2k/rcGuWwEuDTjMXS84AEa+qcB1ggAQXoICAAi1GAIAAcfsAgAbUPPCAEd6fgIABDalQ
Date:   Tue, 25 Jul 2023 15:51:24 +0000
Message-ID: <SN6PR2101MB169365BD0B7C2A6ADEC798A4D703A@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
 <BYAPR21MB16888FB226E2829E3B5C517BD737A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230724231927.pah3dt6gszwtsu45@box.shutemov.name>
In-Reply-To: <20230724231927.pah3dt6gszwtsu45@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d83b5669-6b78-46f6-865a-795e33dbd631;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-25T15:24:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|MWH0PFEDFF6182D:EE_
x-ms-office365-filtering-correlation-id: 9508b64b-ce5b-4aff-d0ea-08db8d26fff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nqlv4VvBJbJ/oeSE3iNwRk2DkmW2HLChFhCG/0rKd9HxqnYvUxljsuFdlh70hmbYUq8bOFY/UyElfHGGLs7e81A2e9SJD4qvnGnfKAHC1nCjA5J8MUjcCBtUJ/lbUjGslpXv3gbrRzjz1xPxmCReKZlgdSsar/65e7B2b7YcsvX7nprxggixQGoYfN1bbWHWAKJ4lqSuhxmqK698qeK++y6Baw/6OyDtAF/QJ0N9Hx+0tQDysX8t/N6X4ZnFNXZuLPv9M7gs/IZa8+I6yXMw45cV+zdkdgCgqb7uLPFAPe2JGUME33+QgQ3oQtuiVDv3l0iX/HLbpcsQhjoGDwexIXHjdivOWs1aLUHnu2qyVAYPpMzAPYmxS0beF0onK41/hKb/L3RzRcimULWKU4rZPtKNTadtiuQkzyjBIWy2hgKatM1BDgOtkt8nLFehmnc85WsKObNBHPiHqqcTdYIX1uRDcAHBWLzvoHcElW2/Hxkk1yu7asmEdaoDywJ87xEVDFClLKXkjb8T57kG9AqgSlQjXH0bBGgGIzleNkCwZZjFURgrh+rwAbt13a6yi7bFiL2NV1lUxYmvujVE8UqecyQxBsPvNljdHaX5okutyN/aQrSKayddlZdGudh+neeQUDNNptFMCttpi1kP7P9ivWFtBCzJjfM2wZjihAJkZko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199021)(5660300002)(83380400001)(38100700002)(52536014)(8936002)(7416002)(8676002)(26005)(86362001)(71200400001)(82950400001)(82960400001)(55016003)(186003)(41300700001)(2906002)(8990500004)(6506007)(122000001)(54906003)(66556008)(76116006)(66446008)(66946007)(64756008)(66476007)(478600001)(33656002)(10290500003)(4326008)(9686003)(38070700005)(7696005)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?khMQriAOwOCBP9aiDZ8Amxb2zkkt98adM8E+6TTGE8yPyrbFBxFdMQond6MV?=
 =?us-ascii?Q?15W+98MkgCpGWyzNt3249PUsPCldUynh2NRNSz+Xu9J56g9trhIkjxInciLM?=
 =?us-ascii?Q?RX8X+xTve98jPA+8lTJh340MhYs/w+Vs3eSZjFf8AXd2bxjgWGqBce7wOfCt?=
 =?us-ascii?Q?ZCXqiGmi81/H8/Ndq2UOUI97YSPI8h+3l31NXDmfP9pceeRvRTRifx0ObE0x?=
 =?us-ascii?Q?noym2lYBlX/ArhMIyQLVAn4LZc3Zi8n2V/Ye1J/zytWE9+ZT5uDUavZ1zjRb?=
 =?us-ascii?Q?fv+SDgDrbnAA70Z04a6s4coBMbAN61afEfczjbUJwh94+mRCcTyhPkT5U3iY?=
 =?us-ascii?Q?X9AJEkrWu1ER0yonzDOqYMqKhY0OPjnjyTLcdkP2leWfQyE+h/hx/jdAUhzZ?=
 =?us-ascii?Q?VvQMuwPJOIu75fUFlprPOnI+1WqxhB0S2vSJHW1k/8cdOvoq4KZgeiEJLE5V?=
 =?us-ascii?Q?mHODIgqe4OdKUfnQUStsbKiLVig/QbHyF9L7biRX9DhkvxWNME9dRLsYUeMW?=
 =?us-ascii?Q?d6fL83cjms96DXYNGax85d1eDEmqwipFnbbw2LSZBP1O46QKhAvNNzL3ZD4R?=
 =?us-ascii?Q?9ifpMVPMmE5aTvNKJKxouAL4jbo+OoiAZHeOper15RJzhrA06ynZi+l77304?=
 =?us-ascii?Q?ZYkNiFP+sK/GAJ64TM+3sMiwbLWMn5TWUxiA0mONkw6M7SfzNt9KY1nJBCRN?=
 =?us-ascii?Q?6Qq5B+hwfDlaCtwfv+pMS7db14PgC7C9h5NXzIEFrSNY8vtAtRcy6bYJQP31?=
 =?us-ascii?Q?nNOwzxuoC7f/xhZrzgZonstmiy04Bvh62Gq8PKEh7ItlMu2QFaVXL8JtGFg2?=
 =?us-ascii?Q?BG9+mb3YqNVi93y56vADmuqbFx8PpblVJjvdE5mG+y3bqRlPwR6ghqIvSa04?=
 =?us-ascii?Q?xKZETSDynh58yC3tFDNgLk2Ir+WP/S+QiIUgp8bzJCjqp9etmtaPv9Tk8t5K?=
 =?us-ascii?Q?BocYiyud3v+bYNnMJeLFqVNQUHV7yX9RZVuE0UhwPMujHZELs06UeiVzVUPC?=
 =?us-ascii?Q?+1Om7xE0wS8sbNreXo3H1dA3WVFreijx2MruXfPosY3v7caDavlTp7EUw+xs?=
 =?us-ascii?Q?bVJ8fudbh/57U5gEeh5GvlZ98nUBHd7Y2CpCMzePCH4t4S+ngQ9IiMgcQCu3?=
 =?us-ascii?Q?U4qNGAjnCnl8k3qvyLeMXytG+4np1tJka5ZL4VXKxzCZUIcvWFOHNj3JUcGa?=
 =?us-ascii?Q?88xzlBQex6TEL23ZdrFptsPh3y485o/Dt4Xw2RBf785KoIzdEyRAS0RceySS?=
 =?us-ascii?Q?mtRgssiQLw4OH7rlpsgQEn6YK54xjJu9sebMmIONS5bNnvae+Juf0uif5zwY?=
 =?us-ascii?Q?BtEiiv6le8syHwW71SAllPXiop0oIshpiqpBZCesCmPy1zrePiHyXhRNSxM6?=
 =?us-ascii?Q?ZfvJwT5d7GQeeGJV1+ExOazURFLGB4iunDMBr5lOWSY46Nl0cReK60bLf30H?=
 =?us-ascii?Q?SuOmLLgrCsd09+tK5wIc1FuZtaOmKy3cWhQhXDWyhMpb1MamAuGQ9JBpe474?=
 =?us-ascii?Q?qox4P3cNm1qkjiGdcJCjn3DaF2V1P1ZRkybJ2cBexZjrQwaW9fiP/UeDr8G+?=
 =?us-ascii?Q?FOBu906Kxaa7WdXoFJxfGNPiY3SSD5siUCY5lepixWkc9Y6MGDg98HP32qVC?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9508b64b-ce5b-4aff-d0ea-08db8d26fff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 15:51:24.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Al4TBD0A3dPWu2k7nb1SNYka1AY7ffm5J09VrjZKHRcHK8TZEbsbNDY3xCzBuLh3vywwoqkJ6XNhzXZkE0hlCwCHj4Yak2ZSpvE2NPkJ9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Monday, Ju=
ly 24, 2023 4:19 PM
>=20
> On Thu, Jul 13, 2023 at 02:43:39PM +0000, Michael Kelley (LINUX) wrote:
> > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Saturday, July 8,=
 2023 11:09 PM
> > >
> > > On Sat, Jul 08, 2023 at 11:53:08PM +0000, Michael Kelley (LINUX) wrot=
e:
> > > > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, July =
7, 2023 7:07 AM
> > > > >
> > > > > On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) =
wrote:
> > > > > > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent=
: Tuesday, June 6, 2023 2:56 AM
> > > >
> > > > [snip]
> > > >
> > > > >
> > > > > It only addresses the problem that happens on transition, but
> > > > > load_unaligned_zeropad() is still a problem for the shared mappin=
gs in
> > > > > general, after transition is complete. Like if load_unaligned_zer=
opad()
> > > > > steps from private to shared mapping and shared mapping triggers =
#VE,
> > > > > kernel should be able to handle it.
> > > >
> > > > I'm showing my ignorance of TDX architectural details, but what's t=
he
> > > > situation where shared mappings in general can trigger a #VE?  How
> > > > do such situations get handled for references that aren't from
> > > > load_unaligned_zeropad()?
> > > >
> > >
> > > Shared mappings are under host/VMM control. It can just not map the p=
age
> > > in shared-ept and trigger ept-violation #VE.
> >
> > I know you are out on vacation, but let me follow up now for further
> > discussion when you are back.
> >
> > Isn't the scenario you are describing a malfunctioning or malicious
> > host/VMM?  Would what you are describing be done as part of normal
> > operation?   Kernel code must have switched the page from private to
> > shared for some purpose.  As soon as that code (which presumably
> > does not have any entry in the exception table) touches the page, it
> > would take the #VE and the enter the die path because there's no fixup.
> > So is there value in having load_unaligned_zeropad() handle the #VE and
> > succeed where a normal reference would fail?
>=20
> #VE on shared memory is legitimately used for MMIO. But MMIO region is
> usually separate from the real memory in physical address space.
>=20
> But we also have DMA.
>=20
> DMA pages allocated from common pool of memory and they can be next to
> dentry cache that kernel accesses with load_unaligned_zeropad(). DMA page=
s
> are shared, but they usually backed by memory and not cause #VE. However
> shared memory is under full control from VMM and VMM can remove page at
> any point which would make platform to deliver #VE to the guest. This is
> pathological scenario, but I think it still worth handling gracefully.

Yep, pages targeted by DMA have been transitioned to shared, and could
be scattered anywhere in the guest physical address space.  Such a page
could be touched by load_unaligned_zeropad().  But could you elaborate
more on the "pathological scenario" where the guest physical page isn't
backed by memory?

Sure, the VMM can remove the page at any point, but why would it do
so?  Is doing so a legitimate part of the host/guest contract that the gues=
t
must handle cleanly?  More importantly, what is the guest expected to
do in such a case?  I would expect that at some point such a DMA page
is accessed by a guest vCPU with an explicit reference that is not
load_unaligned_zeropad().  Then the guest would take a #VE that
goes down the #GP path and invokes die().

I don't object to make the load_unaligned_zeropad() fixup path work
correctly in response to a #VE, as it seems like general goodness.  I'm
just trying to make sure I understand the nuances of "why".  :-)

>=20
> > I'd still like to see the private <-> shared transition code mark the p=
ages
> > as invalid during the transition, and avoid the possibility of #VE and
> > similar cases with SEV-SNP.  Such approach reduces (eliminates?)
> > entanglement between CoCo-specific exceptions and
> > load_unaligned_zeropad().  It also greatly simplifies TD Partition case=
s
> > and SEV-SNP cases where a paravisor is used.
>=20
> I doesn't eliminates issue for TDX as the scenario above is not transient=
.
> It can happen after memory is converted to shared.

Notwithstanding, do you have any objections to the private <-> shared
transition code being changed so it won't be the cause of #VE, and
similar on SEV-SNP?

Michael
