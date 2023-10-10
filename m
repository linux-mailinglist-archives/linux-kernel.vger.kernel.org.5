Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98107C423E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjJJVTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjJJVTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:19:22 -0400
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEA892
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=wAGgoqHHqbCyDpKG+uIxflelClRhvj/LX6OUp4VbLDY=;
        b=izQSodZ1PwUkTKLSnSOO6ANWq/ceg0oHaHKtSfwDnKlqqFxrzI2gstA8jgNkMX2eaQEfO1zthSCfOg4ru1g+9CF9zsUnABupnJGK/wqs97EJumzL/yc1z2GjBRucpkjejAn9HrzBOgg+SAb2jCdxcLh6m4G0YH7+d7wKFyJCNz8=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1qqK8v-0007iW-7p; Tue, 10 Oct 2023 21:19:53 +0000
Received: from dynamic-046-114-176-240.46.114.pool.telefonica.de ([46.114.176.240] helo=smtpclient.apple)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1qqKA6-0007Ob-85; Tue, 10 Oct 2023 21:21:06 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [RFC] AMD Zen4 CPU bug? Spurious SMT Sibling Invalid Opcode
 Speculation
From:   =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
In-Reply-To: <20231010083956.GEZSUN3OKuYSyU182V@fat_crate.local>
Date:   Tue, 10 Oct 2023 23:18:57 +0200
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AD7373A-7FAF-4823-9D8F-1EDF60EEAB6D@exactcode.com>
References: <D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com>
 <20231004222511.GHZR3mR/oNFZuJGB9P@fat_crate.local>
 <797F7A00-541E-4333-B653-1120DF5C56B1@exactcode.com>
 <20231006093244.GAZR/UPJidkn7GIGeL@fat_crate.local>
 <20231010083956.GEZSUN3OKuYSyU182V@fat_crate.local>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Score: -3.1 (---)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,


> On 10. Oct 2023, at 10:39, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Fri, Oct 06, 2023 at 11:32:44AM +0200, Borislav Petkov wrote:
>> I'm still working on it and I'll have something soon.
>=20
> Ok, try this below and see whether it fixes your reproducer.

On the first day the patch so far appears to have prevented
the spurious #UD exception to appear again.

Tested-by: Ren=C3=A9 Rebe <rene@exactcode.de>

> Thx.
>=20
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Sat, 7 Oct 2023 12:57:02 +0200
> Subject: [PATCH] x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs
>=20
> Fix erratum #1485 on Zen4 parts where running with STIBP disabled can
> cause an #UD exception. The performance impact of the fix is =
negligible.
>=20
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: <stable@kernel.org>
> ---
> arch/x86/include/asm/msr-index.h | 9 +++++++--
> arch/x86/kernel/cpu/amd.c        | 8 ++++++++
> 2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/msr-index.h =
b/arch/x86/include/asm/msr-index.h
> index 1d111350197f..b37abb55e948 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -637,12 +637,17 @@
> /* AMD Last Branch Record MSRs */
> #define MSR_AMD64_LBR_SELECT 0xc000010e
>=20
> -/* Fam 17h MSRs */
> -#define MSR_F17H_IRPERF 0xc00000e9
> +/* Zen4 */
> +#define MSR_ZEN4_BP_CFG 0xc001102e
> +#define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
>=20
> +/* Zen 2 */
> #define MSR_ZEN2_SPECTRAL_CHICKEN 0xc00110e3
> #define MSR_ZEN2_SPECTRAL_CHICKEN_BIT BIT_ULL(1)
>=20
> +/* Fam 17h MSRs */
> +#define MSR_F17H_IRPERF 0xc00000e9
> +
> /* Fam 16h MSRs */
> #define MSR_F16H_L2I_PERF_CTL 0xc0010230
> #define MSR_F16H_L2I_PERF_CTR 0xc0010231
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 03ef962a6992..ece2b5b7b0fe 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -80,6 +80,10 @@ static const int amd_div0[] =3D
> AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
>  AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
>=20
> +static const int amd_erratum_1485[] =3D
> + AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
> +   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
> +
> static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int =
*erratum)
> {
> int osvw_id =3D *erratum++;
> @@ -1149,6 +1153,10 @@ static void init_amd(struct cpuinfo_x86 *c)
> pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full =
protection.\n");
> setup_force_cpu_bug(X86_BUG_DIV0);
> }
> +
> + if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
> +     cpu_has_amd_erratum(c, amd_erratum_1485))
> + msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
> }
>=20
> #ifdef CONFIG_X86_32
> --=20
> 2.42.0.rc0.25.ga82fb66fed25
>=20
> --=20
> Regards/Gruss,
>   Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette

--
ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com

