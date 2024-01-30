Return-Path: <linux-kernel+bounces-45321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255CD842E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581951C252B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB01762D4;
	Tue, 30 Jan 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PhEU/CIe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118D6D1D0;
	Tue, 30 Jan 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648988; cv=none; b=k3G9nm8q4RXSn5FNyvL7aP3vcDrXnoWW8pp+hNr539/m3o3dWNnjU/0/wOmyGZJolpSSFXofeI44/MUSkAN5EL9+NX8S36RxnqoWZrTdwUX/ACRMhkDTuT6B8Fcde3fkdqjEYUOtUMaNMgDjd5DuYJhgzDuE04NAvQNfkCDpP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648988; c=relaxed/simple;
	bh=RqXQWzMZk7h9sjW01LAhN2z8E+xcSHPZ2yV6QPz7Cik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMYYb2ZGKUvW9xX8r+2XrS96xrfBCCJ2U/dAJHD9bpg1BhYofI1WL3/VGakWLHiSt6TWBR0MeeSfSPdm8Kwsy0zEfTosRw1UoAoxqgpXVQF/yMgiNKe2TsFmlF+Gja8fkiCRlq6CvKo2SckhjckzL8HAapKkWx09ekVQC+sXp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PhEU/CIe reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 99EC440E016C;
	Tue, 30 Jan 2024 21:09:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9dtgCcRxuuf0; Tue, 30 Jan 2024 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706648980; bh=bJPo8ARfu4bb/8etD558K4kEYcakH1/Jplzb9yO6z2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhEU/CIeFKefePRNCVVfnWgqZ+oQ6NklARokqwCfUE0aHtDUx1IXqr6K7Bju1OxSF
	 gupEOBS3x9s7wgo9mtgVZ8Y2waPTYE25PtuY/mOfjbJ9MBbiyy8N8BbqmbQ/AXbkNu
	 rxI6MJgP2QqKIAQEk3uTF7bVGwwxWkLhBCrq7qf4muFbHbvagYwDGjJUrn5O/gPhSq
	 PFH8NvDstTJMSv4X5tvxqKGqWHq1NkXHyDUIokv1TBAiArHgBpuSRMBr+CETIsJ1d9
	 12MWbc/0jGUX+SBC+tJ8ZG5gCqh2oyF2TAe2kYtvItwUjEGmStCOWP8z5DMyl58xnq
	 zsO+hFeBG6PNAYHoIfwnNWK2/e0GEXJpt0uLL0+Zk0P5lVSkfM0S/QBRkc/we2Xc6h
	 BsNgYiUgRP+p9QuQ3RSRGXxnsnkvWFJCEXTG+2MjSm3YOC1CVFa03z7RjBBiTO3ghn
	 N6OxxrpNth4xe5aYmHV1FNmCbEx9BBZUQvB4Ga+T2STFvdf5aL+2q2ncS++O6Wsh3H
	 abTLvLLlGlLZvYmgyPlEbHYh+g/tEWvNSn2uc8s2rrcssh6/7jEsTsGOAw46RUsBq8
	 PjMnQSUFRhoPLQVMZT7nE5C8LC8n6FvvMocE0EGNowEAp0z7StzlWaTBeaoL3l3ca0
	 Chk1ooHJth0OYnsINGlDovWg=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2C7A40E00C5;
	Tue, 30 Jan 2024 21:09:23 +0000 (UTC)
Date: Tue, 30 Jan 2024 22:09:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	wangkefeng.wang@huawei.com,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 1/3] x86/mce: remove redundant fixup type
 EX_TYPE_COPY
Message-ID: <20240130210918.GFZbllfs4jUcd_QHL2@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-2-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240111135548.3207437-2-tongtiangen@huawei.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 09:55:46PM +0800, Tong Tiangen wrote:
> In commit 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function"),
> rewrited __copy_user_nocache() uses EX_TYPE_UACCESS instead of
> EX_TYPE_COPY=EF=BC=8Cthis change does not broken the MC safe copy for
> __copy_user_nocache(), but as a result, there's no place for EX_TYPE_CO=
PY
> to use. Therefore, we remove the definition of EX_TYPE_COPY.

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

> diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/incl=
ude/asm/extable_fixup_types.h
> index fe6312045042..787916ec1e12 100644
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -36,18 +36,17 @@
>  #define	EX_TYPE_DEFAULT			 1
>  #define	EX_TYPE_FAULT			 2
>  #define	EX_TYPE_UACCESS			 3
> -#define	EX_TYPE_COPY			 4
> -#define	EX_TYPE_CLEAR_FS		 5
> -#define	EX_TYPE_FPU_RESTORE		 6
> -#define	EX_TYPE_BPF			 7
> -#define	EX_TYPE_WRMSR			 8
> -#define	EX_TYPE_RDMSR			 9
> -#define	EX_TYPE_WRMSR_SAFE		10 /* reg :=3D -EIO */
> -#define	EX_TYPE_RDMSR_SAFE		11 /* reg :=3D -EIO */
> -#define	EX_TYPE_WRMSR_IN_MCE		12
> -#define	EX_TYPE_RDMSR_IN_MCE		13
> -#define	EX_TYPE_DEFAULT_MCE_SAFE	14
> -#define	EX_TYPE_FAULT_MCE_SAFE		15
> +#define	EX_TYPE_CLEAR_FS		 4
> +#define	EX_TYPE_FPU_RESTORE		 5
> +#define	EX_TYPE_BPF			 6
> +#define	EX_TYPE_WRMSR			 7
> +#define	EX_TYPE_RDMSR			 8
> +#define	EX_TYPE_WRMSR_SAFE		 9 /* reg :=3D -EIO */
> +#define	EX_TYPE_RDMSR_SAFE		10 /* reg :=3D -EIO */
> +#define	EX_TYPE_WRMSR_IN_MCE		11
> +#define	EX_TYPE_RDMSR_IN_MCE		12
> +#define	EX_TYPE_DEFAULT_MCE_SAFE	13
> +#define	EX_TYPE_FAULT_MCE_SAFE		14

You don't need to renumber them - all you need to do is to comment it
out:

/* unused, was: #define EX_TYPE_COPY 		4 */

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

