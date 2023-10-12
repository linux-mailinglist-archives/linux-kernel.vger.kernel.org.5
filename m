Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FA27C76FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442445AbjJLTdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442434AbjJLTcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:48 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011002.outbound.protection.outlook.com [52.101.47.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD9FF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVaPcy50/m3bVfr/iA0KH5+TbEMHobBKQ7mQLx7PRWKfUqLGtDleDRbjGh/W55+in7QUs/uDnfrzfdfp/p45gzcf8jUO5Da+spqyV66lzi+KQqGvl5/yZWymqekF3+FxQUqtOQivKMlVY+0ulN5iJXDdfdLOeNAkY9SGP/629dOcliA+3g8xs7uYDnNk479zd7Gub8Pz0AP0O2qobVyWMu4xlqvs9lMBIujmUUfUsH9SwfST+lq+2cTFC0yt4gq8NUEqHtbaJENo6PE574AsnzxYLCM55YEgQrmjNQygq2TjzFRbTqPHo/vHA7cb1L7obE+575qWDh3iaOuQo2Tf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUx1hJnnmNkqG0KcmLNumEjo40gf6GTL68n5JmtUmYI=;
 b=HlYwqj68RFZhMkJvXTdi1JzKOPSrz3s0aY2Dk+vC8WuK8VnJcFOvOOH2vuXkCv+CunDRDd0UcS4jecXSA1hFNLLXMeN5GAtiKPHjK28+tYc54q4ilUnAIkYpAtZjrdc02OT/RC0ujxw3fwIkJvoT7zqV0Y3x2FwYV2vl+cWqWsXuQk+CP4f3V6bqR5+QXfZUdygPqXeFvetJ29ClsuE0OgP3j0s6J/49uArdE+pLuzeZfW/0f5n+EeIrbIACq+T/7Gw7i23jQiqzH9Z35mw+5E4gIK7lRc2SHUuardd+ff/vpHtsu0ojTDa+ynGTMHrQS/bYCA2ldHJBgENYn89FSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUx1hJnnmNkqG0KcmLNumEjo40gf6GTL68n5JmtUmYI=;
 b=Q9D2M/zgAdurSwWnd59K0xfC18t9MULUTU+OQ2Bdfa3kKk40UxMpoCviuNlAz8Az8ojI27Iy5GnBpgIxL0uu/SMxgx8eV2ru4ZKywrT8qBoLsY/GObcSmjqlDzbj1lsiDji4cGwk18xAkUWh01ExbVesuXQk9wmJnib9A0hsaLs=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by MW4PR05MB8939.namprd05.prod.outlook.com (2603:10b6:303:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 19:32:43 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 19:32:43 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Uros Bizjak <ubizjak@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Topic: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIABRMbugAAl0QA=
Date:   Thu, 12 Oct 2023 19:32:43 +0000
Message-ID: <6EB66FDE-DDE1-40FA-A391-AEFF963CA97E@vmware.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
 <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
 <CAHk-=whNVf+YghEH4JNjp99NzG5+M7CQrLK42VNKnDydBG4ovA@mail.gmail.com>
In-Reply-To: <CAHk-=whNVf+YghEH4JNjp99NzG5+M7CQrLK42VNKnDydBG4ovA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|MW4PR05MB8939:EE_
x-ms-office365-filtering-correlation-id: 6a92bcc2-6f1f-4198-8d9b-08dbcb5a016d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpwIXvFPE0/ij8CS560Vm4138iOY2lOD53idHjnSIVNbqjzzANxpYsxTAwz8kp9rxddZXSxAO1fsRDquNe94uhNxdTABkLe+S8EN/WVuPiHvVMtNmJZsJfqxs6F4wI/vkZapQu/5Jz7woX754k8Pc2y3KBKPB83A0OwDrPi7zIUcKDOIziLq6PBwMykh4Fpi+FJZ+WcUDtzaKnETcE/yv5mVQ0DQp+dK8su00B/BtsMTOXVNcUUNIKf4vLgvJusCx7zCVNMNBlqPzYdDCo3eLMhU55YuNHT5Q/Onv7f4Xhemd6s6L0MVuvC0s9aOj3qkyGhU/Euo+LMPAPD1LernNGM9qlFqAoA1UB5x3XaWa4d+1c7lVzC1dnSU8mEVNQL6k7UGuh2zPLfts/KKJl3VvLTleIaLczSovkXseluopONf8zSisVCXIfNsXRNy3cJ1JCUfZHuhEF771k2hu2EkWD9KAQotnWTX5IqLj61HXxRI6N6w+ZoS2CY0zzW0Pq4KmL6YyYNq48G/WLMNLurAKs6wupx51kvvfK0WYXj3q/A8fg2XeyvuxyeJ4SgfCji4KNFJdpN6nAyvJY+yqOABIYoxJ07So599iHcqHoTIJpY0hyrovqo60jVeXbzWUS8zPjzM9PtNmZfRJepHookB1g4pHvMs2x9ncAARn6llpaw+MYbzGA7hNKvh/r4YtAdsKT88k548GjF4zJ/uUfbRahIMqeD4dEz8Zj+pWkZHqYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(83380400001)(38100700002)(99936003)(122000001)(4326008)(8936002)(8676002)(41300700001)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(6916009)(316002)(91956017)(6486002)(53546011)(6506007)(2616005)(2906002)(6512007)(966005)(478600001)(5660300002)(71200400001)(7416002)(38070700005)(33656002)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWNDZVkwUFMwZit4dEVJM2tpSmYzY2t1dHdEUnFmV3lhTmY3aEVmUGtmaHRV?=
 =?utf-8?B?M0pNMFdMditnTzBBQk40a0FERDBXWVp2Rk5LMmFyYWpoVUVpbmdzTkpoZE44?=
 =?utf-8?B?TDdGK0FtMWFiRkhKOGtBU0hmemFRRHA1OUVDdTFIK0owZWI3ZDdHazMrSU1n?=
 =?utf-8?B?Z29Yak5FdTRhMXB5MjdBK2pOaEV4YlZISFl5U05uWHFGTTkwQTRIQURBSVQ4?=
 =?utf-8?B?bnI0YVpzZ1ZXcy95VUpzdkFwZGF6dTRaNkIxWHVvN2dMdHcrNHZWMVBhQmxI?=
 =?utf-8?B?dzNRdXBMbmhleDZQTUM0Z0wyODBVWDFSWU05KzFrWk9nczZuai9aaXlSM0RZ?=
 =?utf-8?B?b3hpTGtkUTUrNGNEV2hsdWJEQURscCtIRzNycm5HS2VvNUhyaVJYZGxMcWwz?=
 =?utf-8?B?ZFdYRUFSWjIrYlZtT05UVDB3VjJQRzFHaVNWbkJUbk4zTUs4N1lrczgyV0RC?=
 =?utf-8?B?NFFrVUNwZC9ZcCtwVGlhMVRBbVpwUkhzeThnc1NYUkpFODQxRjFacDZZTDhS?=
 =?utf-8?B?UEVXR0x1S1QwUGN2ajlRbFYwZ0kxU1lDMklNVU1VUVY2a3dJT2tYeXkzTGlu?=
 =?utf-8?B?WERMM1NTNFlESDc1c3NUVEtrb1pGWUQ4WGtoNGY2WmdJYUVFV09uU0c3REQ2?=
 =?utf-8?B?Y1RmNU5EOWVqbjlZOFd3aWhUYnAwaXl0bkFodW94dW1Ud2RSVXBrV3ZZY1dZ?=
 =?utf-8?B?VHlWZnk3NGd4dUF4bGs0S041U3pGeVVMQnRPVWVCQmhpVVViNVZMcktlUGpy?=
 =?utf-8?B?bXlGaTB0aGRySERPRlByemNWRStSYVF4VDhNMkdSUFI3alV3TnpyZm81ZmlW?=
 =?utf-8?B?Z0dPWnFlZnh2R0lDWnQyRjNidHJHMkRnYXdHam1GRDJWUytGNHFwdnV5OXpW?=
 =?utf-8?B?TkdnVC9aejdxUUxLM010R2h3a0FyRWw0enZzTzA2ZzhISjYwVUxyaDd4RFBQ?=
 =?utf-8?B?bzc3RklDTGJZbFdjaXJVRnpNK0V6YVkxN3VTZm14N0F6NUY4eVVVNkxSQmlK?=
 =?utf-8?B?eGhlTU9ETHVkdHZOTjk5SkRwRlRwOENUSXR1Q2lHcGpCYU1FMUpSenN5ZnVw?=
 =?utf-8?B?Zjk4bzFJeXJUQWU3ZlZKKzQzWG9HU1YwRzV5SHF3SStWcCsvQ1BOU09xRDU1?=
 =?utf-8?B?dk9RbjJHVWZYeWJCODArOTV0UEkyQ2N1TlJpYVIxTmlPMVo1Zkp5SlJIdlQr?=
 =?utf-8?B?dzlZcUd5aTR3MnJXUGxRNEdRcmNSeDVxc3BZdUFzOGlpVWgvQXF6SHNKdjFt?=
 =?utf-8?B?TDNkR2hFWTJlMTd1eWpsS1dRd013aXR3TE1YS2htczlvbFlPejFsS3ZPM0VS?=
 =?utf-8?B?NTA4VENGanloRHl3aU1pRWVKcjRyWWZoTmF5aTJ1WEIvek1KempzQ1BQekd5?=
 =?utf-8?B?aDRON0JPa3pxRVl5emxzK2tacXgreWtHbGVhR1BSVk9IdDRSK2wyWmpoWGZV?=
 =?utf-8?B?OVZTajF4bGpiVjdCbThuNFBwZzBKMTlxTXJkc1lVTTNKcHlWRjNSeFM5RzJK?=
 =?utf-8?B?Sk55Y0JMK1J0Rko3V2tZZW0zNUhmUUxsbGl3MTN0dHBsMzJpTlhFaEdFZzdl?=
 =?utf-8?B?V1JlYTFONWFwSThqVGRXZXdlVU9PWFRCa0sxb2lwZXErbzVheG9BSWRHVVRZ?=
 =?utf-8?B?OVIyMkFzZUI0a3RwL2JSQXJVcVVvNE1zdCtjNVRvUThVQ1lKZ09HNXQ4Z1lz?=
 =?utf-8?B?Zmc2akxVT01ObFdPMzRIZ3REVGxTK20ycEZUVlZSVXBxa3kzc2dCTklQaW52?=
 =?utf-8?B?QTUvRHVaZWpCL0tzNUpjd1NMUDMyMi9JQm1zeDI2TjZvRjVQSHAzVElsdFZN?=
 =?utf-8?B?cmRyQXN4b3A0V2s4L05NUGVpQjhLQTZMRFlIcEJ4Qkl2cmJua09IQWVZcVJv?=
 =?utf-8?B?UEx3dUlVSDZvejF3T3hrQm82ank1YmM3Z1lmajRGaWVCRkhjd1FUdW1iQW5Z?=
 =?utf-8?B?cFpFSTl1UFA5QVpkcWs3aCtOUm5FSmhGWkNSUWtmNVJadE9nakFRZUNzV3cy?=
 =?utf-8?B?N0ZSdFZmSzc4ajBzWW01Q0NMK25kaUUzdEJmWkNIU09FUFN3WSt1bGJYQ2l0?=
 =?utf-8?B?UC93THlWQUt4TWhOVEU1VUxCUVBkbUZTZ1pwUmlGVjdqcytuci9NdTc2RmQy?=
 =?utf-8?Q?u1xRbXpe4IedOVzOSFzR85oHx?=
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B1206E59-BE00-41B2-8A98-CFD37E06C773";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a92bcc2-6f1f-4198-8d9b-08dbcb5a016d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 19:32:43.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pH0qQGX+IZ6uYbAcO+xJMaG22clay1F5eQvkN2t0g3XAhsm0d6PNq2/5xEHnmUpm8jH81/sa7U6o2sadE8+tOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_B1206E59-BE00-41B2-8A98-CFD37E06C773
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Oct 12, 2023, at 8:16 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> !! External Email
>=20
> On Thu, 12 Oct 2023 at 08:19, Nadav Amit <namit@vmware.com> wrote:
>>=20
>> +/*
>> + * Hold a constant alias for current_task, which would allow to =
avoid caching of
>> + * current task.
>> + *
>> + * We must mark const_current_task with the segment qualifiers, as =
otherwise gcc
>> + * would do redundant reads of const_current_task.
>> + */
>> +DECLARE_PER_CPU(struct pcpu_hot const __percpu_seg_override, =
const_pcpu_hot);
>=20
> Hmm. The only things I'm not super-happy about with your patch is
>=20
> (a) it looks like this depends on the alias analysis knowing that the
> __seg_gs isn't affected by normal memory ops. That implies that this
> will not work well with compiler versions that don't do that?
>=20
> (b) This declaration doesn't match the other one. So now there are
> two *different* declarations for const_pcpu_hot, which I really don't
> like.
>=20
> That second one would seem to be trivial to just fix (or maybe not,
> and you do it that way for some horrible reason).

If you refer to the difference between DECLARE_PER_CPU_ALIGNED() and
DECLARE_PER_CPU() - that=E2=80=99s just a silly mistake that I made =
porting my
old patch (I also put =E2=80=9Cconst=E2=80=9D in the wrong place of the =
declaration, sorry).

>=20
> The first one sounds bad to me - basically making the *reason* for
> this patch go away - but maybe the compilers that don't support
> address spaces are so rare that we can ignore it.

As far as I understand it has nothing to do with the address spaces, and =
IIRC
the compiler does not regard gs/fs address spaces as independent from =
the main
one. That=E2=80=99s the reason a compiler barrier affects regular loads =
with __seg_gs.

The =E2=80=9Ctrick=E2=80=9D that the patch does is to expose a new =
const_pcpu_hot symbol that has
a =E2=80=9Cconst=E2=80=9D qualifier. For compilation units from which =
the symbol is effectively
constant, we use const_pcpu_hot. The compiler then knows that the value =
would not
change.

Later, when we actually define the const_pcpu_hot, we tell the compiler =
using
__attribute__((alias("pcpu_hot=E2=80=9D)) that this symbol is actually =
an alias to pcpu_hot.

Although it is a bit of a trick that I have never seen elsewhere, I =
don=E2=80=99t see it
violating GCC specifications (=E2=80=9Cexcept for top-level qualifiers =
the alias target
must have the same type as the alias=E2=80=9D [1]), and there is nothing =
that is specific
to the gs address-space. I still have the concern of its interaction =
with LTO
though, and perhaps using =E2=80=9C-fno-lto=E2=80=9D when compiling =
compilation units that
modify current (e.g., arch/x86/kernel/process_64.o) is necessary.

I hope it makes sense.

[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html

--Apple-Mail=_B1206E59-BE00-41B2-8A98-CFD37E06C773
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmUoSc4ACgkQHaAqSaba
D1pAug/8CuPwgn69932A6w9UUeNDae0CXwbovy/Kg89x5+s9HpwlKC1jKAHy6Orv
Dy+hUH7S0kW8ynrBTEnTa5fMAz2qVF7X/SBNzPwHrmHhTDwUd6Vp69ai4300wXau
JH9+8TT50hpWdb0UzbKTRohuAiwxVGBd0W4J32s08sqoIrcs70+yvkmacOZ+KnUP
QmPNub3Jc+lQ7Z+s7faRjdDBgB4Kfkw5H6piRp1sjOejX9xieqfMaO1dYhytkbMo
ajQXHQ13pmeX1GKNbbdGYp7wDxXt97BdJG85Vgub4CYxP1ORDW9YfUCTIGJS2P4W
mbvbET5aI8L3X994SIWy7zT2LVPJhU9gD4PO7pTAkHTkLFw/MRc1qsnZsFhduowk
xl0fDJvZ0nHFiaMrKQL2/TUeVAPMNeGuqeDdKkdTWWz9K7GPdIrC3XUfl+g4GeS3
OuHkPC6f/XCZg5kCA233qt2X6kPKLHOVTZq1/nYhmp6zg2ca3FZeGppRLpn3s4Gq
QZCFTz2xtSJJQiVbigz25jJbN01a4qRTLfx/kXRppOoCZ4CKb1xjYrcf2uGEZ8Mw
p+rc9cxtSwP3nGkoHjpechTsSUYDuhhlp1RYSRhkkE9dPVh3Wy8ILFG2/Jz5zXwe
1SeZR19Wz3d5DJRfOSSg6Q39fCJe/fxCbJCGptCXv3yTeSPdkq8=
=iEZs
-----END PGP SIGNATURE-----

--Apple-Mail=_B1206E59-BE00-41B2-8A98-CFD37E06C773--
