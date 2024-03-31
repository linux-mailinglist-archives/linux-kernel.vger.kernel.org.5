Return-Path: <linux-kernel+bounces-126369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7785E8935C1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E851BB21163
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08833147C69;
	Sun, 31 Mar 2024 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aqOE4yi+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35456FCC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711916927; cv=none; b=Ef5/p3GtNi5z+shFhj3fHq4PgTFrzwWRXj91AnBbEkwUjQyrcPWZycu42Lw+JuWtD49rVeh9pErfoskVWB5/aVJeYjjVPWUeHRlhOMoSqEzsH1fIg4w91+wJbyOz0xQ+JEqxJe5jbFwhhlYz9o55+CIa7MZnhC18Vr1EHgjsFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711916927; c=relaxed/simple;
	bh=JXHF2UrjddLcEUkh48JjNvXBmlYM1uzXSUPbnZWLg/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQg0aSrYY266uwJxsGHOSeg1Aycg8hFjqMf6trgspt2mDz0mupD5KIcW+PTCApgUoakJcjAng3ka7qxB1lLCNb7KxPyu0rThcCbfPNnqtBkTZ23IA6/P1Y54mAMH8Gc6ueri+m9svLlg/IsNxOHAYeUMumgAp7/Q5WYM9RVi/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aqOE4yi+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4DE1B40E0202;
	Sun, 31 Mar 2024 20:28:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nDzCCmrfCUUd; Sun, 31 Mar 2024 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711916918; bh=CejcC+b2qUd6NHakJxncHVdk/JUy9N/bIPGbXnysvp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqOE4yi+U49wzXU7YaiF5yXc+U3rzCPQ/9dRdYNOKBMxjqaNsKmJXsl9h50VDeU3I
	 +WeMvEmu238BTeoWjHaCFPXFRqeSwIhII6+TVr+5GFND2EVzgUHq/Kh79T34BezBBO
	 MJqryGMLMEjj1X8/45bnJFTMfRN7PVgEXdFLt4jstrUC3B32H7l48+kHAYIGb8czWr
	 KBavgjfU7zjKnouxPcro7qXc/PG1tMs2/StkSqRzUW0S88CvmadoD1KwX0sg6vj1st
	 ZO3K3MlS0G83uZuDkwzMcUPwUAeATIydbWXai6LdNm07NUa2KCMAWfc/bRR6qn1kQq
	 hJ7i/ik5ODcJZfn0zRLhMMua1ZbZhhzMzAbWFEXrY7wVP48y6ChlAJCIGvgJMXUhuz
	 weSEJvk1qWZTt7bDeU+aRpL2wwtJ9qHGIv9P3fRu/XP6Ywiy7RxVNOJJKqVEuACFPX
	 n1jIg4Dfq1EO8mfm+yJmaBUAdHfdzxkDlNJg2oP6cAgE71Xks5A3gecdInI7wpXdyr
	 8s9eZ/nCUFX9q25rOTVWc4iPm1HL5q3Hz38bAddbPor1wwWXyP98xcy8W4yJY3KHSw
	 hCoUL3Sg/0ZPpszWpv4v2hhTyGRBkjfRNVUq5C9te7GTEc6/yutSb7YJwfhylReafP
	 ZRVt62ZkR3cTDGgc+eFA9vsQ=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 12AF340E016B;
	Sun, 31 Mar 2024 20:28:34 +0000 (UTC)
Date: Sun, 31 Mar 2024 22:28:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mahmoud Younes <m.younesbadr@gmail.com>
Cc: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	luto@kernel.org
Subject: Re: [PATCH] kaslr: x86: fixes log message nokaslr
Message-ID: <20240331202827.GAZgnHayn794X_Ubs4@fat_crate.local>
References: <20240331200546.869343-1-m.younesbadr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240331200546.869343-1-m.younesbadr@gmail.com>

On Sun, Mar 31, 2024 at 10:05:46PM +0200, Mahmoud Younes wrote:
> Unknown kernel command line parameters nokaslr message will be printed
> to kernel log buffer if nokaslr option exists in boot command line.
> nokaslr gets consumed earlier and this message becomes confusing.
> impact is that user gets confused whether kaslr is enabled or not.

Well, my dmesg has here:

---
..
trampoline_32bit: 0x0000000000000000


KASLR disabled: 'nokaslr' on cmdline.


Decompressing Linux... Parsing ELF... No relocation needed... done.
..
---

so the notification for the user is there.

> Signed-off-by: Mahmoud Younes <m.younesbadr@gmail.com>
> ---
>  arch/x86/mm/kaslr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 37db264866b6..a62cb0675e22 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -179,3 +179,9 @@ void __meminit init_trampoline_kaslr(void)
>  			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
>  	}
>  }
> +
> +static int __init parse_nokaslr(char *_)
> +{
> +	return 0;
> +}
> +early_param("nokaslr", parse_nokaslr);

This piece of code without any comments explaining why it is there is
not less confusing to whoever stares at it.

I'd prefer if print_unknown_bootoptions() would filter out those options
which are parsed earlier and not warn about them instead of having such
dummy stubs.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

