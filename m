Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42797D7992
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjJZAgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjJZAgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:36:00 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83975181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL8yRxr61eD5p0Sok3cG0c997Z+e7Sc+OBD5sXx4N8sKLLN0vqF11GR2wa+nWEyA52BYBSiNNEXOpnlsugHvUKtrfwreZUz50ClIG37YhcMO43KOQ2HUIZ9/Up3WBqg2O3d+is6JSzsBwiG0U+RFEbskF3fODaPpVOH5B/DO7DHRef2M0NcMUowtd0vHmdQjukaC23QvWxBfVYyd41MfSnl3LyITrJRBkT2V0IVEJKVrlpfF0YuyXX6zS68NyyVBP+Cyg9E1Jp19NVaTyfhQmRYmuNUrbv0p3Nz0gyxrqf9edQDZMnTvUC3ghT4IZuMWGkT5XGRND/r5t1EJHPd7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ngkcwu1T57hp5v9kZECEQ1ft37iZnGshgJa90bMSakE=;
 b=XdnUURoRYqVn+XF56Yf6vf2/CmvS8kjpD70snJ1AcM0gu4TfKUaWn6oPYP5F0vy/DwXwpFbPuLW7kfbcIfeM+C8OJcgHLsMg65XSHj+G1ZmvNA+5VGAnA8tqZwKO63dc/PY+BysqLiS/AdWzWj/swGtFYy6PYCLyRNIMuEuPtPQMa7vsdkQ1OALAJadqxFA+ixeJQpkRHKpnFbAk+UeBgjkUfD6jjarOsPbUpI5j/kenXi/TPjufENqsgJ3SUTBpks13V3LyagVLGRHkjgDdZovS5Fw1i0fLy/MivjeIjlVZma4z3yKo0XHFuq+UbGOVtBRl5LF3c4aVz3k8EwXUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ngkcwu1T57hp5v9kZECEQ1ft37iZnGshgJa90bMSakE=;
 b=L7xqR+6TXXZEsxtBkg1uf7qgWrgwCnNFgeqbVlKuEGqY152YUjyIB/T4Lc6tUkdxMgcIHJDgUku9zqv/N0giYAGC0Fly7+8YwVMAI/aMESimHQUKllov/J4VGaCDB3Q/tLTolAARd4Ry2u8addnuin16zz5dX2EIsWPHgnBqjwM=
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 (2603:10b6:805:55::19) by PH7PR21MB3311.namprd21.prod.outlook.com
 (2603:10b6:510:1dc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Thu, 26 Oct
 2023 00:35:53 +0000
Received: from SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::9ec1:1d74:55ab:f67a]) by SN6PR2101MB1693.namprd21.prod.outlook.com
 ([fe80::9ec1:1d74:55ab:f67a%4]) with mapi id 15.20.6933.011; Thu, 26 Oct 2023
 00:35:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        Dexuan Cui <decui@microsoft.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaBtSo1KeOz02diUCTmiNYqoVgMbBbLUcg
Date:   Thu, 26 Oct 2023 00:35:53 +0000
Message-ID: <SN6PR2101MB169309ACB83862DA6E572A89D7DDA@SN6PR2101MB1693.namprd21.prod.outlook.com>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3281e19f-a75c-4ec8-a574-4e5d5268d252;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-25T23:46:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR2101MB1693:EE_|PH7PR21MB3311:EE_
x-ms-office365-filtering-correlation-id: 3bf8bd0b-3cf0-4b99-ce9a-08dbd5bb82ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fcvjg3V0WY9QlTBo9xCuCxfiELMdU2HgC+PoNCFq6ep2KMm3c3H+bzo/gDaAbYc8tjKzI+GeGdA/9ULGyPEzlQlnkIatko5A3OWxoyrXMZIIPveLRhtvmqGBMXPIcITfGlSGyPjU6SjKU49S6HSW2jAlHf/RdY0xQpPRp/0mJ85YHGiRxM9G5g7B3s8BWYbFFoT97WX5DHYbAFfVcwlv/ZxWXSR1Io0YS/3fJaNczzYuFnw36WgX22XMuxgRd1asi0jU+kvpV7MbTvr0sElV707FuNvKROOjHhzhye4vSk45rtq8lKSxrp/8vA6dIOsvZRZ3llQWgmiFrFTiFdjmD2ZyOzXAYs4i5TRwBVyH3u9ToWSgvRc63SrDqUSBlZ9IOMKkBWbDv5W+w135oE8vru+NYNb4oE8mUa5ieORfrw6LeQ+AttbEBn9HoaUxJDY40L2hB2IpU9COncj+AzfpXKGfPsYtws3iLUrTAhu4bpijQy2SHfBvtPsKLd7gqHQrYhyALHlZAQL2W38Xgl8G/5BtATm5TaQugNYekSyQVUf6tZYtWNmNNPiSWyNuHN85DEJ18bbYIqpdRmSwfUYD/rIhxoqaptmOzFTpeE7XHk5yfDadSAhPyfTmRVAHZhxN/znc/cX3EvB9W0zpODCgCQu8gjElg1NGnGPVarrH11I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1693.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(52536014)(2906002)(41300700001)(8990500004)(83380400001)(478600001)(10290500003)(966005)(8936002)(8676002)(76116006)(110136005)(5660300002)(33656002)(7416002)(86362001)(66946007)(316002)(66556008)(64756008)(66446008)(66476007)(71200400001)(66899024)(82950400001)(9686003)(82960400001)(38100700002)(7696005)(6506007)(122000001)(921008)(26005)(55016003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l8Sm9JAGKL4KU2OMsghpSoIL8BDp0WX796ggW/J5vHulEULFdJsix/ast5LP?=
 =?us-ascii?Q?3cj7VT3pLD2KtLtTPXWZtTUOgYcBV0GQLivANNDteBq0ZJusdzY1WRP3IYvt?=
 =?us-ascii?Q?PUcrJH++VRlRBlNp0MzohKo+Sqsf+z0TChNEXUf7LztjUivLRUFsminHJxDJ?=
 =?us-ascii?Q?KIVsI/4rgH7uCSYVHJ24ksC75ytuQK0JjZKeIjwBj2DD06f38cQh/v2dDQ5m?=
 =?us-ascii?Q?rq3PZviy9mRPV8Wt9HyzKvsexLVWqpWgtbfm8X5ft77BzQlVAYR3Ka3xgKDD?=
 =?us-ascii?Q?YvTlEcLGMwFQ601s0MM9RcDx3dILjSfZ86NXKCXpc0yRl7TbsuZxRfig7VR7?=
 =?us-ascii?Q?56+IJtYE0bAGZQ1pfzZixDJ/4T8u+VTdFpuYvsgKiMb8SmoSHixISaVFXpUh?=
 =?us-ascii?Q?aVLAImkARugA3C2yxAjsEgb3nWDs4VgPrZKWtMOriXqEnCi/wSD6VZGVPnMf?=
 =?us-ascii?Q?xLQKwsvd0UA4uB3Zmf2hCURpbS5JQ0vHuREtsDNdkb3BB96rRKPIEXrV3wZN?=
 =?us-ascii?Q?rkX7xue+SjGUpUf6iDYW5PxBhOaD08LaG1SdnuLhslERIUH3K6JKGuk4F1kl?=
 =?us-ascii?Q?CgHxnyncwe+Dc07O44+fkigf9VthW1Bk+XPV3GsKokl6XPoFHoKNa9JVP5uu?=
 =?us-ascii?Q?tT59GNvRtGRFTlGlr8Blh9yH9+nesWrW/wDBxCFs6n6gTNHrynYu1e+YZBOZ?=
 =?us-ascii?Q?7Gut2I6Yfop2JleyXrKy6bP+O8z2gGzpmTYTkx1lvi97IJbt950O36UjGWfF?=
 =?us-ascii?Q?WnAy2kMycFuKG4D52ZQCVG0k6GrwJUHZ2wRGKvqgc384Bw47+5UsQW07MN/n?=
 =?us-ascii?Q?IipC7PexCxL56D2LcLVejeJhNZwxmGlMOD2VZWndf+9coBbM28bfctdbhOS8?=
 =?us-ascii?Q?QYClz/IUF8Dui72UR2DMsdO6EFEgdPkY1wLpzt9dv71CoFjIj/Ikc4wgQ0aw?=
 =?us-ascii?Q?hMSXoclW0ZTpzaafa1hZey1bbmC3DymA8BWSo+OG5YD58/wGxsdU/1bCWUya?=
 =?us-ascii?Q?QISiVbIe7mm4ZXrELHROGj6HK0W5FyG8vRkwFPzRjbppU/Mzq5V2lo77b0ux?=
 =?us-ascii?Q?5ndlYN6l9M3l8KBpLCEmFCCxMYT9VqmFjKcO4WPIxFm1eTc1HrKNU93+2y6s?=
 =?us-ascii?Q?Dthyb2zUyAZjPUe2p4NYjdhNThviLkhyMsebLII2dZwPGkVtNAMWfrgxoN15?=
 =?us-ascii?Q?XjP2YmDpNv+Fbko4S/2JR6iEw3pynZsvFOkhhWs8o7/H307MZ/3ek+Fvebse?=
 =?us-ascii?Q?67mxUfq5txUxaI0ccwFcziOKwmI9e0ggQv6wb5JgTYOyxcKciljM1OFB42tF?=
 =?us-ascii?Q?hR983jEjoE5PF1pwq9Py/VFsnVY0x6KL1SH5QYKcf2e8J1oGk4rYEYuoAcJe?=
 =?us-ascii?Q?+7q0zdAMpbnlwKzVGOIFWz/sSZD+yovarOdHoKgY/qmMy5mBekQ/pVoxIyIP?=
 =?us-ascii?Q?KdF4AZDUNNOJ4bO7N1FUVdRKIrILruWeBvsP83YyfqLKuX9OFMv6nbkfpN7o?=
 =?us-ascii?Q?sG/CcdL+DGf7tX8R4gGEZtuzpL29pWRAE+G0tyijq6FXNxTsi1zM3VaSPloR?=
 =?us-ascii?Q?HFQvxSWhM0hMdQFujofMkNxTw6SKHFdFXCI4C/GBIn/cOQLdfWe/6kcVgMFV?=
 =?us-ascii?Q?Mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1693.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf8bd0b-3cf0-4b99-ce9a-08dbd5bb82ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 00:35:53.0648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /bCarJykZH5KE+8Qaeetp6gAfQWKzceKCIADrTbCi+GvrUGPIAKrlKpdPfGGzNtx3EAVtvaYJtk3Zyq30iu7tQYlkxsOPOZP9h+ZFy1ZHas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3311
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com> Sent: Tuesday, October 24=
, 2023 4:48 PM
>=20
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared.  Callers need to ta=
ke
> care to handle these errors to avoid returning decrypted (shared) memory =
to
> the page allocator, which could lead to functional or security issues.

I think you mean "shared" as indicated by the guest page tables (vs. "share=
d"
as the state of the page from the host standpoint).  Some precision on
that distinction seems useful here and in follow-on patches to make callers=
'
error handling be correct.   As I understand it, the premise is that if the
guest is accessing a page as private, and the host/VMM has messed
around with the page private/shared status, the confidentiality of the
VM is protected.  The risk of leakage occurs when the guest is accessing
a page as shared, so kernel code must guard against putting memory
on the free list if the guest page tables are marked shared.

>=20
> Such errors may herald future system instability, but are temporarily
> survivable with proper handling in the caller. The kernel traditionally
> makes every effort to keep running, but it is expected that some coco
> guests may prefer to play it safe security-wise, and panic in this case.
> To accommodate both cases, warn when the arch breakouts for converting
> memory at the VMM layer return an error to CPA. Security focused users
> can rely on panic_on_warn to defend against bugs in the callers.

To me, this sentence doesn't fully characterize why panic_on_warn
would be used.  You describe one reason, which is a caller that fails to
properly handle an error and incorrectly puts memory with a "shared"
guest PTE on the free list.  But getting an error back also implies that
something unknown has gone wrong with the CoCo mechanism for
managing private vs. shared pages.  Security focused users would not
take the risk of continuing to operate with that kind of unknown error
in the core mechanism of a CoCo VM.

>=20
> Since the arch breakouts host the logic for handling coco implementation
> specific errors, an error returned from them means that the set_memory()
> call is out of options for handling the error internally. Make this the
> condition to warn about.
>=20
> It is possible that very rarely these functions could fail due to guest
> memory pressure (in the case of failing to allocate a huge page when
> splitting a page table). Don't warn in this case because it is a lot less
> likely to indicate an attack by the host and it is not clear which
> set_memory() calls should get the same treatment. That corner should be
> addressed by future work that considers the more general problem and not
> just papers over a single set_memory() variant.
>=20
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> This is a followup to the "Handle set_memory_XXcrypted() errors"
> series[0].
>=20
> Previously[1] I attempted to create a useful helper to both simplify the
> callers and provide an official example of how to handle conversion
> errors. Dave pointed out that there wasn't actually any code savings in
> the callers using it. It also required a whole additional patch to make
> set_memory_XXcrypted() more robust.
>=20
> I tried to create some more sensible helper, but in the end gave up. My
> current plan is to just add a warning for VMM failures around this. And
> then shortly after, pursue open coded fixes for the callers that are
> problems for TDX. There are some SEV and SME specifics callers, that I am
> not sure on. But I'm under the impression that as long as that side
> terminates the guest on error, they should be harmless.
>=20
> [0] https://lore.kernel.org/lkml/20231017202505.340906-1-rick.p.edgecombe=
@intel.com/
> [1] https://lore.kernel.org/lkml/20231017202505.340906-2-rick.p.edgecombe=
@intel.com/
> ---
>  arch/x86/mm/pat/set_memory.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bda9f129835e..dade281f449b 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned long a=
ddr,
> int numpages, bool enc)
>=20
>  	/* Notify hypervisor that we are about to set/clr encryption attribute.=
 */
>  	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> -		return -EIO;
> +		goto vmm_fail;
>=20
>  	ret =3D __change_page_attr_set_clr(&cpa, 1);
>=20
> @@ -2167,12 +2167,20 @@ static int __set_memory_enc_pgtable(unsigned long=
 addr, int numpages, bool enc)
>  	cpa_flush(&cpa, 0);
>=20
>  	/* Notify hypervisor that we have successfully set/clr encryption attri=
bute. */
> -	if (!ret) {
> -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> -			ret =3D -EIO;
> -	}
> +	if (ret)
> +		goto out;
>=20
> +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +		goto vmm_fail;
> +
> +out:
>  	return ret;
> +
> +vmm_fail:
> +	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=3D%p, numpages=3D=
%d) to %s.\n",
> +		  (void *)addr, numpages, enc ? "private" : "shared");

I'm not sure about outputting the "addr" value.  It could be
useful, but the %p format specifier hashes the value unless the
kernel is booted with "no_hash_pointers".   Should %px be used
so the address is output unmodified?

> +
> +	return -EIO;
>  }
>=20
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool e=
nc)
> --
> 2.34.1

My comments notwithstanding, I'm good with this overall change and
the additional level of protection it offers to CoCo VM users.

Michael
