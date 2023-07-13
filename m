Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893C752566
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjGMOns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGMOno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:43:44 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85C32705
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqiG+oBVI5vKhcQusZhVrlc3RIALkab6q1e0taVtTK43+PHhcb5Qov6SUhaUfwf2RF8ew6BuMJGTz28VSnmPb60Adpe7+u4X5gJH5Lu5L1IYAqLYZJBCbIRSAfQWtLuxeqvM5YKJdFOt10L2RJi9tZo3wMLvB6v6nHcM1NoKzN68UctHaVgLKGFD3zA88akvBLjxeAkJ56I6tAiX7JncrKzVOXMopZM1ADA2P5W/1l/KF4kR3KpnIp9Kx8o9NOiVLAl3PhtQ2C6XsOzvClfnOObTeemjPOwu8nmzqUSHNCIUlGY4Q1syiL1eAK6iHBtCjiEyucDO4pWu9c4DtZNF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNo8hPsmHpurKNBXxQn/KDHmMY0E4gdzItn8E9Gv+ww=;
 b=Qpjoj00OzbiEkGLrHqdKS9JMmFIvF3txYNkP+681BplCpO8o+vUSvbWKm7xnJjPkM1q5L+eFRCtU2xwFmq1mF0l3HKYOyUIeQN7lDze0ZG8U86lQGcYPzLMa7H2Suq5zLVu2DLRu35wU1J5XI2kvcr9gzlE51XuVPOn5ixj8ZRIJWkZOaPY9HgGKqP/CxvZpEIN6UZK9UjWH0m4OG+xXTX3XtciVebLYp/ReB6PfDqUfQ/mDCe1zAuyLsh+McuQUbJtZlYYqKp5F+WR23XjxNI0HduXlnqJXjrxQmg2CiKnh1bUbv+qxGVsK/oS2mXQDvPV3+jOghIKXppbKMNe3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNo8hPsmHpurKNBXxQn/KDHmMY0E4gdzItn8E9Gv+ww=;
 b=SuLao5Y43AmwDaRucAS3uzwF7dh0jH5qT8pwWjbsu0iH69u+QMsaFiuLI2vp/ZbuEgVO2ul2Qh4DKjVvikvE7tUEtFVDgMrGn5leiB42z0doVD/o068ffl5v96lzgonM40gPy+kf6JTIr9gPcMdeQ0aRg16oH0cLnXMGEiuAdOg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY8PR21MB3803.namprd21.prod.outlook.com (2603:10b6:930:52::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.7; Thu, 13 Jul
 2023 14:43:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::275c:198b:4685:accd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::275c:198b:4685:accd%5]) with mapi id 15.20.6609.011; Thu, 13 Jul 2023
 14:43:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Thread-Index: AQHZmF1U2k/rcGuWwEuDTjMXS84AEa+qcB1ggAQXoICAAi1GAIAAcfsAgAbUPPA=
Date:   Thu, 13 Jul 2023 14:43:39 +0000
Message-ID: <BYAPR21MB16888FB226E2829E3B5C517BD737A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
In-Reply-To: <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=043e9e78-c55d-4f11-9f08-2d2cdb867ea7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-13T14:26:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY8PR21MB3803:EE_
x-ms-office365-filtering-correlation-id: 7734d6bc-c10a-4ef3-c01c-08db83af8bcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grEuHhL7zNB5cVyq7E87QzKjz29r5t2ZfohEi0hk4bvPYWZ5VXYio4oucqF0Mz4SuNy3fKU8GRpfLxM+u6W0qSPXhSRKq8tA8dN6nFM606HjgbR6Ua3YDh4t93M8nY1TOOm1McoL/qqLLJbX4aDL2CITqfl8IrgWJJT4gOUKQrpPeDO0rEbZVXcLGSVD55XVEPWRYGqNTlWeiME9Lqn22NNs1sDYgpvw4NcWmP50fgvqURSXGygxvy+tSeHiR8w/z8TrgDIwQP+C3GaWiqGwN8PvtzXDTeoOXz+SLfibV17iux+tzEN5bveejcH16Yjogd067H88zESGNZCF1MMRAXFU3imOlkCmVFbbvJM0xA4Q1IjxhC2HQOefk1Acp0hP9vue3NuwewdwDYtCdxcMOIWQxz/aJKr4wq77ZpWn7YsMfmC1Aij5W0JgjrCsG/ImU+quDRB/XfDS8csstqlM7xIXhIilshfU4oQZ65hUZETUdp0hfM784Js2gxxTBnUcsgXoOW5Pqqs54YIU+8Sijxpayylg8/q1eeUvdYSWfi3g76jsDyOByRaCp/ZkPg8vSavT2dLa9r9wtWlN6Uo25X+aT/xJ2FjZ2FDYgl3J13vU6BqpnF0hJAamCLKPviVkdYlPd1q4MexB77K3W5FAcurzKkWijdTLCvRS6QsI5hc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(6506007)(26005)(9686003)(186003)(7696005)(478600001)(71200400001)(82950400001)(82960400001)(4326008)(38100700002)(2906002)(76116006)(66946007)(10290500003)(122000001)(83380400001)(8990500004)(8676002)(8936002)(33656002)(5660300002)(52536014)(86362001)(7416002)(54906003)(64756008)(66476007)(66556008)(41300700001)(316002)(55016003)(66446008)(6916009)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m2eoE0eYjjUNoOsdHqEekl4EbcMlHtP0HY6xB7VgEd8KjLHvTUaJTgVyEZjK?=
 =?us-ascii?Q?oF/mgDDHnY0iJpZDxaKcGnjje1BqJubxmxnzU/Qxmmid7iEeD7TImP1555fy?=
 =?us-ascii?Q?N6B5CgYBS2rlfFxdDcci/Nh2DneNJWtcWr300dJ/gNzIFXGF95Mu5D/S3lyu?=
 =?us-ascii?Q?W4O05xkjoPVgy8KuGd9ebuvrzoSAWy2JbGce27Vc29lQ0/Qfy9rhGuhj1HlI?=
 =?us-ascii?Q?d7+QvUdZsOJOknjmhn1GHxAU07AfgccFyHNN2g9R2HIQdQAzu5nbrEOJnP0n?=
 =?us-ascii?Q?ib1bu0esnIEKjEn1k4t3Whx+blZAJLl0NOdDbR49GsZOX0hQwBxLh/T2vQ6e?=
 =?us-ascii?Q?n3ZxaHKIlQNn3BUodj4gSo29aKr/7I5eipQ7pU4r1WSPVq8yKrklmc8ZRSmr?=
 =?us-ascii?Q?o9xwnVicuNXnN+12Nil7d+FX9wd5atbbYqtJjLXvPqR6BYl2jvxwClFI0Yxp?=
 =?us-ascii?Q?R9Y1aM2150vhEolrAMTsgroli7sOjAgD8fqliTmzK8GgnKBv/VwKuu4dIjKw?=
 =?us-ascii?Q?X/VzF0W9T+BxOWsImL/YLzlY1TZiDASTQvipOlE5C9J7nSWrI/KYaGt802bD?=
 =?us-ascii?Q?ZnE53TBa+63xK9yj28Qzqfcs/wz1qAb1UnW6gM2FBB+tFQ12o/mm3A0ZZYuH?=
 =?us-ascii?Q?/bud2gwLbqrjCXMZ8gFIgmB1vcE4r+yC7wqqTO5ivalzBKSx0OKHRYByf65s?=
 =?us-ascii?Q?Ejl++h2nxlnUJk2XEv30Pq1rbv1UST38PU9o7wbiqGQUZQXoFNojC3fHdn3x?=
 =?us-ascii?Q?Dh09DmMnUGoeUVtOd5Ovmn0yhI75jRJBh7kmDcD/pIahWpOzKQqw2J1NWAo5?=
 =?us-ascii?Q?MCvzMXmwZWhPFEUdmZZX8CzFOWQ/3KKEi/sAbSVarqFlq+Lbq1xNdC2w2pix?=
 =?us-ascii?Q?H7WD4N3SLlUCIn7f/0RabCN49ZDFsuZIZOmLNgFQuuqNNQQOqUfht3sBCJvn?=
 =?us-ascii?Q?JjnVTAnd506u1GDEJOersf141hojc3zUH+ObJ5kVGaLThHkbrhmW8jLyKw0+?=
 =?us-ascii?Q?yckEJN1zS2TyI2vw+m/jnnFBGvIWxEum93E7+p661tXvaa0icfB+/gqLUwZ+?=
 =?us-ascii?Q?2FUG5CX8tGZNvEF8GS95GCsC/uYG2pKhZ3bBzrj/c4RKoypv6a8mJIQ/5vrv?=
 =?us-ascii?Q?rs/0dxSlV8hmOqggOO9nDbZhnBKgbtPAva9Gxql+MVOH1XgWHz6s6ifGCR5J?=
 =?us-ascii?Q?5T8XbmdoTxw3ywLyNxP5EO2nTIHLvfIbZwXWtqG+RJV9m5BIvMQGE+vxDPD7?=
 =?us-ascii?Q?nxZkosz0xBIxEjWuxlVl30dxpA5B1n95iEyU9yaOZC9QTeIuunruJRwxmxGN?=
 =?us-ascii?Q?JwUPYUkNCbmCjZurwQ2BTLIbZX84+EWkn0G+JgYvRji+GrCEZTB8OjezMHGR?=
 =?us-ascii?Q?xPczEQ24aGKqJdcUrN9JXllpYT91rJ0WdGe9LOEOA8ikTf97jBrbAx+0Llef?=
 =?us-ascii?Q?emf+6AbkJwQZDybCFCEGgyYaWR8iCtG1aNV7NUnkZYpsFQfZfHRAObNi23yN?=
 =?us-ascii?Q?gb57xz8uUhN/5l+Tdj00+7Yn1Jaux9Cw6IQ8wttY67mFHduNdKdrkO/0Esrv?=
 =?us-ascii?Q?HzaUWs+8WwAX1T57Z5DdnuZOSDQKnC+wA3yYBOHrzSqX88jLL4mgq385KbtI?=
 =?us-ascii?Q?xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7734d6bc-c10a-4ef3-c01c-08db83af8bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 14:43:39.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RtBNSCmbiBBRsTTvUljvghJKNWGk4zu/VPJFfGqmtPP1A8ZtFIsiTO3EPKPDjONll/F5slQsW5SrwfWBgyIUXFQ9T00e5dLBsl2hAFkLFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3803
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Saturday, July 8, 202=
3 11:09 PM
>=20
> On Sat, Jul 08, 2023 at 11:53:08PM +0000, Michael Kelley (LINUX) wrote:
> > From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, July 7, 2=
023 7:07 AM
> > >
> > > On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) wrot=
e:
> > > > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tu=
esday, June 6,
> 2023 2:56 AM
> >
> > [snip]
> >
> > >
> > > It only addresses the problem that happens on transition, but
> > > load_unaligned_zeropad() is still a problem for the shared mappings i=
n
> > > general, after transition is complete. Like if load_unaligned_zeropad=
()
> > > steps from private to shared mapping and shared mapping triggers #VE,
> > > kernel should be able to handle it.
> >
> > I'm showing my ignorance of TDX architectural details, but what's the
> > situation where shared mappings in general can trigger a #VE?  How
> > do such situations get handled for references that aren't from
> > load_unaligned_zeropad()?
> >
>=20
> Shared mappings are under host/VMM control. It can just not map the page
> in shared-ept and trigger ept-violation #VE.

I know you are out on vacation, but let me follow up now for further
discussion when you are back.

Isn't the scenario you are describing a malfunctioning or malicious
host/VMM?  Would what you are describing be done as part of normal
operation?   Kernel code must have switched the page from private to
shared for some purpose.  As soon as that code (which presumably
does not have any entry in the exception table) touches the page, it
would take the #VE and the enter the die path because there's no fixup.
So is there value in having load_unaligned_zeropad() handle the #VE and
succeed where a normal reference would fail?

I'd still like to see the private <-> shared transition code mark the pages
as invalid during the transition, and avoid the possibility of #VE and
similar cases with SEV-SNP.  Such approach reduces (eliminates?)
entanglement between CoCo-specific exceptions and
load_unaligned_zeropad().  It also greatly simplifies TD Partition cases
and SEV-SNP cases where a paravisor is used.

But maybe I'm still missing a case where code must handle the #VE
for load_unaligned_zeropad() outside of private <-> shared transitions.

Michael

>=20
> > > Any comments?
> >
> > This looks good to me.  I applied the diff to a TDX VM running on
> > Hyper-V.  When a  load_unaligned_zeropad() occurs on a page that is
> > transitioning between private and shared, the zeropad fixup is now
> > done correctly via the #VE handler.  (This is *without* my RFC patch to
> > mark the pages invalid during a transition.)
>=20
> Great.
>=20
> I am at vacation for the next two weeks. I will prepare a proper patch
> when I am back. Feel free to make patch yourself if you feel it is urgent=
.
>=20
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
