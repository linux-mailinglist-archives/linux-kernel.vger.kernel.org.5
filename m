Return-Path: <linux-kernel+bounces-135668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97CD89C983
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84BEC283C34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6641422CC;
	Mon,  8 Apr 2024 16:25:39 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C741411EF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593538; cv=none; b=BM2HYnnJo/KpYzhJJaLCcRcsGLSG4cil3UXaOgCw//Gm8eYzgqpIyL9flDf6Q+rzkn2OziJkVeiHsNxxUn2WVo1ShhyHVqAKZUBIJiU/2a2KtxP6fxSmkpvikaSTIQEfKD2zN+6ki02KzkxNwDgnWIoANrKrB7Q47sRCjlqgHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593538; c=relaxed/simple;
	bh=JjYy2NQ8b0ptgkMu03WiMEhetefWtLS1qzlJonIJh6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atwk8Er449F8rp8ChYinknAL3pP5cIitiim1DHIJ183OSrYHcLHiniSXEQNexmAHOM3FeLE3S66SkgdEF0+CYvmi3A2NQBkH8S5hoO6MKRjjbZNfDN8WrlFRb0wqZJaDMbw2CX1zuyD19F4JF+Ce1hS6I4Mbuc2VelHc2Zv90+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9BA4340E024C;
	Mon,  8 Apr 2024 16:25:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aQVXuxdBz4rM; Mon,  8 Apr 2024 16:25:20 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A70A40E0187;
	Mon,  8 Apr 2024 16:25:12 +0000 (UTC)
Date: Mon, 8 Apr 2024 18:25:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, x86@kernel.org, kai.huang@intel.com
Subject: Re: [PATCH 1/4] x86/cpu: Add and use new CPUID region helper
Message-ID: <20240408162505.GAZhQaYYJ7wrPpaPjj@fat_crate.local>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153510.F327603D@davehans-spike.ostc.intel.com>
 <bab18bb7-ef6d-477a-845a-de9b52dd9591@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bab18bb7-ef6d-477a-845a-de9b52dd9591@suse.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 11:04:49AM +0200, J=C3=BCrgen Gro=C3=9F wrote:
> Aren't you missing "width &=3D 0xff;" here? get_cpuid_region_leaf() doe=
sn't
> truncate the returned value, which has the linear address width at bits=
 8-15.

Yeah.

Other than that, the intention looks ok as it documents what that code
magic was.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

