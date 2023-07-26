Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB357762929
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGZDPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGZDP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:15:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2091.outbound.protection.outlook.com [40.107.223.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A63E51
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 20:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaCJfHbOEeZIjD4Zl1adcDMjkhoDKOKwRfXB043J5Jd8AllZXSaNkaaXq4lK5FGEKNIH/SmTLdgHJ9Is30xyvxJutWeTFdThS6D4TssJYoIuo7hwYX6UhOFu8pF05fYi/XjKkB8yHI/ampsE+kAj0UHXjgH4UW25y4l2aj5RozPriWOBoomjJr/GEq59Kl7nDOrG3HkR/Zl9bFK+j1IAOCUYqnzf3C4Fg0RDyo7OSKVypLkS4dcOOHWFUUCzO9kqvKqVVScMo+PloZlIGn2UVjr1kvNgUeNV+D58ZdMTZWPZGotH8Vhloy8J2lo2DCapOBH+4sTmENjyS13xUNx5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V08GuV28c1Mfg3VdHK623tM0dzZk2edSiU7MnJsJ2rE=;
 b=B23jrRXfPN24MPRno74o2pXRhjJ+91S7c2MO0TCJSYgaS2Y3/wBZeoaMcrOF2gA7BRNovPZMKM+RNzPof3nkTZYTZghr4njVRd4lUYfzsHnpd813qf+bvxcZ38fe+wRLrU2myac5o4f3jB1D4OgYDriqKgYaTNAH9AKqTVH2BearWYR59aUqocxEUlxR8Uh9hpVCU2kd2MES6e0IpXF9IH4Pv+Ab/SgcdI4ko6mhnI0Gl+h2wP89lTtcVf8f7n+Krcpooyx9i/64uNA++0aVCoE8uijR4ziUqSwXvGB18wkGVBA97yn+gOIp5W/9f/SMPsXFLoCx2X6msQ5vAWFX4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V08GuV28c1Mfg3VdHK623tM0dzZk2edSiU7MnJsJ2rE=;
 b=fPaTUBE2mxeRIm3zFhCEIKvHaeuV7FnmzORU0Ii6qbnS7uS7wynpSOGUJYcjg6FD7RJw0+QPRVmkoknFmtpj2drWpeS3KQw9bB5Mwb7yyJk/oBYWRhdq4gXbkGE9rwYwkmJQdZBWRgSAl7FURJA2JWuYs9xBOVW+6Sz608FWyL0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by LV2PR21MB3350.namprd21.prod.outlook.com (2603:10b6:408:14e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.8; Wed, 26 Jul
 2023 03:15:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 26 Jul 2023
 03:15:21 +0000
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
Thread-Index: AQHZmF1U2k/rcGuWwEuDTjMXS84AEa+qcB1ggAQXoICAAi1GAIAAcfsAgAbUPPCAEd6fgIABDalQgACCv4CAAD8Q8A==
Date:   Wed, 26 Jul 2023 03:15:21 +0000
Message-ID: <BYAPR21MB16882905045F0FE4DD32D853D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
 <BYAPR21MB16888FB226E2829E3B5C517BD737A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230724231927.pah3dt6gszwtsu45@box.shutemov.name>
 <SN6PR2101MB169365BD0B7C2A6ADEC798A4D703A@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <20230725231233.mu2yarso3tcamimu@box.shutemov.name>
In-Reply-To: <20230725231233.mu2yarso3tcamimu@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=06cfb2d4-fcfd-4aab-bf50-f8ccb83c1783;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T02:58:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|LV2PR21MB3350:EE_
x-ms-office365-filtering-correlation-id: c90f9cdd-cd9d-48ea-9c57-08db8d868bb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Erp4GjwppHTR6dw6i3/YzylpHC9wzF3EzGJJKpe8x+MwAQh7dpfgYVKxUckUslc57ABOlh9l0U4g0EPCPagVqEJt9nwuaM4x3OFn0RdR8F3InM+EwDkPCq8SNhrQxswnU0eQcolvh0o+7OG9Jbu6Kg+2auKb2bjK5hF8x+oZXrJIDBZYcFtnPX/+5LpJNsnQhB6NY3KzuDFfv85ixW/OoLBsa5B2znOeHzF7VNuvqGLEmF2HOyTuYdO1M0k9TJnnMBwnPVh+WZKOZrnmI+Pmzf44seJtnbWzPkVpgifWxwx7J41VkNhS5/bHt5ZGx3BTwMqUchBgURoqtgtExRSEUWni8RU3iPXJPu7H42n3LMZ58PUP11YVEUAgnQuMievoPZhGs51DMCOmM0qAvlA7PcIOBkzirXBnN3FHDvPi/wa0mdfz5EYacCN4KgFB0gOEKKMaVJwW6iKuVG5zEgFG2HQedJbi14qvoDi3j4UwRDWmYhBhr248uy1Yih36AyzqetIqNOkYCj/nUfY4ElApEsQpUk1baeg0Qot+fHAZuRD2NiUEmCsrKEcJxxlmsE3z1/FXvht+CyfYxPGNFcLL9kDGUsMcrVtsbP5IfMy1E2cVjSK3ebu6e5gP5VIJ9aGxdDEYGiLKtyzcAOJHIQqGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(2906002)(26005)(6506007)(186003)(966005)(82950400001)(55016003)(9686003)(7416002)(41300700001)(8936002)(5660300002)(8676002)(83380400001)(8990500004)(52536014)(82960400001)(64756008)(66476007)(316002)(7696005)(122000001)(66556008)(66446008)(38100700002)(10290500003)(38070700005)(4326008)(76116006)(6916009)(71200400001)(86362001)(54906003)(66946007)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RA1n+JwJeW5IxNxSjqv8o9+bDFpCS9jST73eZKMgFcoo9hR/yDFNNxG9/QrM?=
 =?us-ascii?Q?Rm6TTmQaFFdL62NuZYKtEASFtqIWwvstUEFXeC/5B1gXGgT40hTNJT3ziRX8?=
 =?us-ascii?Q?jbqMedw3bl/2SafmWh//eKsK9hF0n9THcYC7Hw9YXKvLvsBWdym1kax27+su?=
 =?us-ascii?Q?hlmpPhVV6+/DSHDlI3uu7MsXojoOtH44HctRB04Qae4PTL+Mkg6DUhAS7U8f?=
 =?us-ascii?Q?II7xwY+3KUHWZ8ok3o/inLtc09xBHVn+cuju9p5SCAuCho+WCob8d7b6bu94?=
 =?us-ascii?Q?GX05KXwn6TQRbKUvI2pDxVMcp1WcmZ2HYvn5hbmNuS0brNT6fPTKGtTrFBDp?=
 =?us-ascii?Q?4xaGd3gjcYUu3PKADBCohIp+xPb8oQH68yriwerafilmldnXnO0gon3DIMm6?=
 =?us-ascii?Q?AvFVa9JNaN1ELh7vIOKanXRswt8M+PN1PqR/xm1CUAj6W6/BD7GduhMVGKeK?=
 =?us-ascii?Q?p0sRw2k3OpbvqjeRV4ubiBtKC+hrrF2K7tH6dcEox2uAdFVvzJl9xyIYtH5g?=
 =?us-ascii?Q?UXa0LqPEnjtefTzmFL2wAREmI2swyTbMJVAsF7YFIlSkb1qkg6FNJAVc7bCg?=
 =?us-ascii?Q?cmu47xqE0BJy3tPgBfbc8O352RmCo3X5n6NWCgC+gtYg8p4+c02VmGtaG0Qj?=
 =?us-ascii?Q?d+m7of55IKsQ5VbynRAeV1casnDwu4zEOzmNzb8AyMEn0sYbeUeLnCOkfpxo?=
 =?us-ascii?Q?yRNKd1nvayYD7dq7gtxBSRcyMeARROcbq6eggIzw0WwxpgsrpxMFWF4uQ7ef?=
 =?us-ascii?Q?U81+r6ww+uXfW+Nd01cdtU2Euy7PoD0S+6QiYi6SCQnIl4rvW+XwTOiXa7YD?=
 =?us-ascii?Q?JWiIsUsgSwXBJZjSGFsWkLf6zmZxupX6i9t8kys4aBDfStCDfP50HtCu/VdX?=
 =?us-ascii?Q?hgYZmdumC8xbDIGPLKbn+eqoBGxu7laesAOZ6L8pyuGzWE97QoxDuN3Ihkgn?=
 =?us-ascii?Q?RQbgJQc8ZOcqk6MNM3iKzadEgoBAzq+Bh5UBRiXPZDgTUJ+NfQbiljHalFrN?=
 =?us-ascii?Q?/kospM8BopqwhC5nUshR29WaRqX7KKJEnh7JWI2gRUIfWNyUiTc7a33+gS8s?=
 =?us-ascii?Q?H6GObnsP6KLkFlJo8urJcMV3wgqhI5Ak2T3PpcFiYZ0WUpSZXhMxKc5e7cXA?=
 =?us-ascii?Q?qfSCjEeNVuoUCwWZIcxdMtmMaTOw2hVhgssIJVBKsT0ZM0sFSma5jF6P7FPA?=
 =?us-ascii?Q?JkZZMO81W80B1Xlko8eBPr9hwfBUl6trvYx4GP5EVzf1CGr+qkQjdSmsW/Ek?=
 =?us-ascii?Q?l1CN7q88NKK0fC453TfdecIthbeTeC2I3dIjHDm0M253yu2KKLqHaRMHxPaf?=
 =?us-ascii?Q?I1uILO2K8juhLBCC26klid73FR6I9udbSu4Sh7StaLph6q6cpX+5h4rkQZW3?=
 =?us-ascii?Q?omKqxSN/oxUX3jJUEuCbAbCwkBZQFG3U3ON6E69QOrhTT7GF7caCFihGtoHd?=
 =?us-ascii?Q?KbPZrA+XlW/YQE1rZgQiYWwBVGW/z0CBxzjroaVdRkEeAS+BwiZdHDu1EfC8?=
 =?us-ascii?Q?29rDBjYP5Ce4Sv2zEafdFfXExGw6u5Dn9Vi/7+7RTPqKXO7eAAPyIWkzDuAv?=
 =?us-ascii?Q?csca6Om4JrTO3rwKuSW/QpesX7eJ/I4AEUPks2YmKkan07bjKCMNFGJP4dPv?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c90f9cdd-cd9d-48ea-9c57-08db8d868bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:15:21.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJDLGjektt5/ryJ2+xypdRVn2Y8VxSZuWjrEu+gHGhqnp+6Nms0oDIYom3qm2ev1rPFteap9qwzqPS4KblN1RSDw56ECwtajJekyDtNMx1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3350
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, J=
uly 25, 2023 4:13 PM
>=20
> On Tue, Jul 25, 2023 at 03:51:24PM +0000, Michael Kelley (LINUX) wrote:
> > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Monday=
, July 24,
> 2023 4:19 PM
> > >
> > > On Thu, Jul 13, 2023 at 02:43:39PM +0000, Michael Kelley (LINUX) wrot=
e:
> > > > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Saturday, Jul=
y 8, 2023
> 11:09 PM
> > > > >
> > > > > On Sat, Jul 08, 2023 at 11:53:08PM +0000, Michael Kelley (LINUX) =
wrote:
> > > > > > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, J=
uly 7, 2023
> 7:07 AM
> > > > > > >
> > > > > > > On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LIN=
UX) wrote:
> > > > > > > > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> =
Sent: Tuesday,
> June 6, 2023 2:56 AM
> > > > > >
> > > > > > [snip]
> > > > > >
> > > > > > >
> > > > > > > It only addresses the problem that happens on transition, but
> > > > > > > load_unaligned_zeropad() is still a problem for the shared ma=
ppings in
> > > > > > > general, after transition is complete. Like if load_unaligned=
_zeropad()
> > > > > > > steps from private to shared mapping and shared mapping trigg=
ers #VE,
> > > > > > > kernel should be able to handle it.
> > > > > >
> > > > > > I'm showing my ignorance of TDX architectural details, but what=
's the
> > > > > > situation where shared mappings in general can trigger a #VE?  =
How
> > > > > > do such situations get handled for references that aren't from
> > > > > > load_unaligned_zeropad()?
> > > > > >
> > > > >
> > > > > Shared mappings are under host/VMM control. It can just not map t=
he page
> > > > > in shared-ept and trigger ept-violation #VE.
> > > >
> > > > I know you are out on vacation, but let me follow up now for furthe=
r
> > > > discussion when you are back.
> > > >
> > > > Isn't the scenario you are describing a malfunctioning or malicious
> > > > host/VMM?  Would what you are describing be done as part of normal
> > > > operation?   Kernel code must have switched the page from private t=
o
> > > > shared for some purpose.  As soon as that code (which presumably
> > > > does not have any entry in the exception table) touches the page, i=
t
> > > > would take the #VE and the enter the die path because there's no fi=
xup.
> > > > So is there value in having load_unaligned_zeropad() handle the #VE=
 and
> > > > succeed where a normal reference would fail?
> > >
> > > #VE on shared memory is legitimately used for MMIO. But MMIO region i=
s
> > > usually separate from the real memory in physical address space.
> > >
> > > But we also have DMA.
> > >
> > > DMA pages allocated from common pool of memory and they can be next t=
o
> > > dentry cache that kernel accesses with load_unaligned_zeropad(). DMA =
pages
> > > are shared, but they usually backed by memory and not cause #VE. Howe=
ver
> > > shared memory is under full control from VMM and VMM can remove page =
at
> > > any point which would make platform to deliver #VE to the guest. This=
 is
> > > pathological scenario, but I think it still worth handling gracefully=
.
> >
> > Yep, pages targeted by DMA have been transitioned to shared, and could
> > be scattered anywhere in the guest physical address space.  Such a page
> > could be touched by load_unaligned_zeropad().  But could you elaborate
> > more on the "pathological scenario" where the guest physical page isn't
> > backed by memory?
> >
> > Sure, the VMM can remove the page at any point, but why would it do
> > so?  Is doing so a legitimate part of the host/guest contract that the =
guest
> > must handle cleanly?  More importantly, what is the guest expected to
> > do in such a case?  I would expect that at some point such a DMA page
> > is accessed by a guest vCPU with an explicit reference that is not
> > load_unaligned_zeropad().  Then the guest would take a #VE that
> > goes down the #GP path and invokes die().
> >
> > I don't object to make the load_unaligned_zeropad() fixup path work
> > correctly in response to a #VE, as it seems like general goodness.  I'm
> > just trying to make sure I understand the nuances of "why".  :-)
>=20
> We actually triggered the issue during internal testing. I wrote initial
> patch after that. But looking back on the report I don't have an answer
> why the page triggered #VE. Maybe VMM or virtual BIOS screwed up and put
> MMIO next to normal memory, I donno.
>=20
> > > > I'd still like to see the private <-> shared transition code mark t=
he pages
> > > > as invalid during the transition, and avoid the possibility of #VE =
and
> > > > similar cases with SEV-SNP.  Such approach reduces (eliminates?)
> > > > entanglement between CoCo-specific exceptions and
> > > > load_unaligned_zeropad().  It also greatly simplifies TD Partition =
cases
> > > > and SEV-SNP cases where a paravisor is used.
> > >
> > > I doesn't eliminates issue for TDX as the scenario above is not trans=
ient.
> > > It can happen after memory is converted to shared.
> >
> > Notwithstanding, do you have any objections to the private <-> shared
> > transition code being changed so it won't be the cause of #VE, and
> > similar on SEV-SNP?
>=20
> I am not yet convinced it is needed. But let's see the code.
>=20

Fair enough.  But similarly, I'm not convinced that we have
load_unaligned_zeropad() cases outside of private <-> shared transitions
that *must* be fixed up cleanly. :-)  =20

Here's the RFC patch, and it includes a couple of open questions:

https://lore.kernel.org/lkml/1688661719-60329-1-git-send-email-mikelley@mic=
rosoft.com/

In TD Partitioning configurations, I'm hoping we can eliminate #VE EPT
violations needing to be handled in the L2 guest.  The L1 guest will handle
things like MMIO.  But the L1 guest can't easily detect that a #VE with EPT
violation is due load_unaligned_zeropad() in the L2.  And trying to reflect
the #VE from the L1 guest to the L2 guest wades into a bunch of problems
that I want to avoid.

The same problems arise in SEV-SNP with a paravisor running at VMPL 0.
Changing the private <-> shared transition code prevents the problems
there as well.

Michael

