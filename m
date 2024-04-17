Return-Path: <linux-kernel+bounces-148713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 316128A8683
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD32FB269F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C381422CB;
	Wed, 17 Apr 2024 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="T/dEk2l8"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AA13D2B5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365066; cv=none; b=rUQdrO+9ISzGAogLTs9NSqiUfHKSRbdpp3c7yQrpbTfe6YpNyhEXv+exawXwh21RiZlc2xBvOX5VxOyIxQfcC5SCmQd9gzGrPjU0AUU6WG9kH6jQX629Kd9jQgi4uaqq+FEdgTBVna8dkvUe1FKSjztr+4RBiKAzI0h2YWJzW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365066; c=relaxed/simple;
	bh=DO5hWxuQ0GbzElIwWkxs6zhU7QcjyGG9CNkERGbvers=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KLffQuHGNHTfZddGfbPmS1C5j56+/YLMXoH0yBSRvVCf+ICrZg4OwYBPIcBCRt2Wh8VbuogXIjwYpUtiGvjcrldy66ugi+bsQ3KEE3dcGznITmencfw48l+H2tfFnu4m3Cyv+Y0NUsmi2YrTd7QYIbWhbEUXP06hxMB14ZM02sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=T/dEk2l8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43HEhkos4055394
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 17 Apr 2024 07:43:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43HEhkos4055394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713365027;
	bh=1gpCGc5aOm1j6Gk/Ux1ENMnwJdIrAl6jDNkLNuPQ19w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=T/dEk2l8BqoVwUdckq7jtoOTOiwsv/69ncrAKiYLtqiEIk3Ja+cfysXaTPqCEQfkM
	 RhlCTvh4TvUOP0M2LCE0QSmP7Le4IxjYXcELPxGcTy6Com/+hFGBbknrD7Pv9cAAgo
	 4YwnOzuzaPqg57U4XbAqFNuIO/vqlwfj3PHbuoNSELGy/MjIm8Hcc0X9NzQj1tzOgG
	 HE1oxg4xNNWl9d3EZBFwTHZeP4IooPTUZJYEZQOFkNVlpu8m3MWRjvFdhddKmzNrH3
	 O/yUBmlCBtcjZZgYVUT6Xeg1WMJxQ1lSPXl/EBF34jjWHm6XJ5THoVmkPP9wuiB6cK
	 sqCsLqjxKmKfQ==
Date: Wed, 17 Apr 2024 07:43:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
CC: Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/fred=3A_Fix_incorrect_e?=
 =?US-ASCII?Q?rror_code_printout_in_fred=5Fbad=5Ftype=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b2a8f0a41449d25240e314a2ddfbf6549511fb04.1713353612.git.houwenlong.hwl@antgroup.com>
References: <b2a8f0a41449d25240e314a2ddfbf6549511fb04.1713353612.git.houwenlong.hwl@antgroup.com>
Message-ID: <B04B2A1C-8FB7-4D8F-A67E-1666B6DA4E14@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 17, 2024 4:34:25 AM PDT, Hou Wenlong <houwenlong=2Ehwl@antgroup=2E=
com> wrote:
>The 'regs->orig_ax' has been invalidated to '-1' in the entry, so in the
>printout, fred_bad_type() should use the passed parameter 'error_code'=2E
>
>Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
>Signed-off-by: Hou Wenlong <houwenlong=2Ehwl@antgroup=2Ecom>
>---
> arch/x86/entry/entry_fred=2Ec | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/x86/entry/entry_fred=2Ec b/arch/x86/entry/entry_fred=2E=
c
>index ac120cbdaaf2=2E=2E099697ba6e58 100644
>--- a/arch/x86/entry/entry_fred=2Ec
>+++ b/arch/x86/entry/entry_fred=2Ec
>@@ -28,9 +28,9 @@ static noinstr void fred_bad_type(struct pt_regs *regs,=
 unsigned long error_code
> 	if (regs->fred_cs=2Esl > 0) {
> 		pr_emerg("PANIC: invalid or fatal FRED event; event type %u "
> 			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
>-			 regs->fred_ss=2Etype, regs->fred_ss=2Evector, regs->orig_ax,
>+			 regs->fred_ss=2Etype, regs->fred_ss=2Evector, error_code,
> 			 fred_event_data(regs), regs->cs, regs->ip);
>-		die("invalid or fatal FRED event", regs, regs->orig_ax);
>+		die("invalid or fatal FRED event", regs, error_code);
> 		panic("invalid or fatal FRED event");
> 	} else {
> 		unsigned long flags =3D oops_begin();
>@@ -38,10 +38,10 @@ static noinstr void fred_bad_type(struct pt_regs *reg=
s, unsigned long error_code
>=20
> 		pr_alert("BUG: invalid or fatal FRED event; event type %u "
> 			 "vector %u error 0x%lx aux 0x%lx at %04x:%016lx\n",
>-			 regs->fred_ss=2Etype, regs->fred_ss=2Evector, regs->orig_ax,
>+			 regs->fred_ss=2Etype, regs->fred_ss=2Evector, error_code,
> 			 fred_event_data(regs), regs->cs, regs->ip);
>=20
>-		if (__die("Invalid or fatal FRED event", regs, regs->orig_ax))
>+		if (__die("Invalid or fatal FRED event", regs, error_code))
> 			sig =3D 0;
>=20
> 		oops_end(flags, regs, sig);

Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>

