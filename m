Return-Path: <linux-kernel+bounces-41350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6652F83EF62
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB52EB227CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459FF2D60B;
	Sat, 27 Jan 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="MyzLaFMw"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812182C856
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379339; cv=none; b=E0r02Uf3OI5z/XmYm+H7PPAZ+kkzlFW7ZLVhnLCi2Bm1QcTl3BYcAoFYyGeEUke+tfexzqNJ8nauJKm9rKN5he6Rdyq5sp1EuQKjYHMXMgy/ShGZBo+bamLbCGU0N2VRzs88IIb0o1sysRMdnkvVTSg/LyjWHjEX/0Z5S9513kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379339; c=relaxed/simple;
	bh=hl/rgpECuXCd1igP0dUEXE7gQ1RilRAuxGBuCz0Ul7g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Um6FLuY0OELAm5XDtNPM5fHmzDe4BcvJiWy2vLffiftVlbSoBo2LQ1e7k1WI9y6h2qTnw+QACRH7cCXJwxoUCb7GcpgV1gF0RzhHnBSCngDDKkEFOqJfy3fXAwUmWd9kIB/J0Sd2Tp4u/EenXxXfCVqBmfqKacNFb4OYCLv8UwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=MyzLaFMw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40RIEa321251574
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 27 Jan 2024 10:14:37 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40RIEa321251574
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706379278;
	bh=hrg2JjqGy0gbsjuke/qn66vFb5H+SHeUt5P3Bm7RtXY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MyzLaFMwBKDpKQ2rjD8W3dr0U+9K3A9LzDp4+PVX9vfTGJs+5D3Cp+xTPrssaNC5i
	 Ztv537S4oL4/QkkGhsPuEV+k8UrjNAZB9rJRZR49VABmqhKMU4hkNkjkgBkmucHrBK
	 j0v1wwoKQPe+IaMJibPawt0twg92e+sGPAhY6Sccr8JmcOvpSfnbKNoEI0Nc5mvdFn
	 9TYanIljiTrs9KcbXHCQWmx8H0mEakb9PLudSDyXhPDN9pe4lO3YMWfy8aJMh1OMZO
	 CmUMSFeIJX6VI3DsyeDFDfOIDt+MfK+VoDPeVz8g8GwQas/tWfq+/Ew/VqPcTynDrp
	 ypEWCjLfqusJw==
Date: Sat, 27 Jan 2024 10:14:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
        ravi.v.shankar@intel.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH 1/2] x86/fred: Fix build with clang
User-Agent: K-9 Mail for Android
In-Reply-To: <20240127093728.1323-2-xin3.li@intel.com>
References: <20240127093728.1323-1-xin3.li@intel.com> <20240127093728.1323-2-xin3.li@intel.com>
Message-ID: <49BA730F-E9A0-44AA-AB62-D2F40C5C11DD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 27, 2024 1:37:27 AM PST, Xin Li <xin3=2Eli@intel=2Ecom> wrote:
>As clang doesn't allow =2Efill to refernece a symbol before it's defined,
>use asm_fred_entrypoint_user instead of asm_fred_entrypoint_kernel=2E
>
>Fixes: 5e0636a41485 ("x86/fred: FRED entry/exit and dispatch code")
>Reported-by: Borislav Petkov (AMD) <bp@alien8=2Ede>
>Link: https://lore=2Ekernel=2Eorg/lkml/20240126100050=2EGAZbOC0g3Rlr6otZc=
T@fat_crate=2Elocal/
>Signed-off-by: Xin Li <xin3=2Eli@intel=2Ecom>
>---
> arch/x86/entry/entry_64_fred=2ES | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/arch/x86/entry/entry_64_fred=2ES b/arch/x86/entry/entry_64_f=
red=2ES
>index eedf98de7538=2E=2E5427e0da190d 100644
>--- a/arch/x86/entry/entry_64_fred=2ES
>+++ b/arch/x86/entry/entry_64_fred=2ES
>@@ -43,13 +43,12 @@ SYM_INNER_LABEL(asm_fred_exit_user, SYM_L_GLOBAL)
> 	_ASM_EXTABLE_TYPE(1b, asm_fred_entrypoint_user, EX_TYPE_ERETU)
> SYM_CODE_END(asm_fred_entrypoint_user)
>=20
>-=2Efill asm_fred_entrypoint_kernel - =2E, 1, 0xcc
>-
> /*
>  * The new RIP value that FRED event delivery establishes is
>  * (IA32_FRED_CONFIG & ~FFFH) + 256 for events that occur in
>  * ring 0, i=2Ee=2E, asm_fred_entrypoint_user + 256=2E
>  */
>+	=2Efill asm_fred_entrypoint_user + 256 - =2E, 1, 0xcc
> 	=2Eorg asm_fred_entrypoint_user + 256
> SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
> 	FRED_ENTER

=2Efill and =2Eorg here are redundant; in fact, there two directives mean =
exactly the same thing except that =2Eorg implicitly subtracts the current =
offset=2E

