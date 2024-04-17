Return-Path: <linux-kernel+bounces-148422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533D8A8251
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48C1285896
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572E13CF92;
	Wed, 17 Apr 2024 11:47:32 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B213CAB6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354452; cv=none; b=N0XEgCh9ETBZVmUeg7EGPmHcDLsh/Os1EEAYqaA+CCQYw+wmuIU563oMS0iiVsiwN326NwyaduG+u6MsLiUk2YrjxYauSIc93REjaVuFF3CLLF/tA985rhiLqaVG4QjcyGA9Cl9rvX3lDwG0Zvm69j/Im5KvQw961tAtp6SI68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354452; c=relaxed/simple;
	bh=PPo4aohrvo5cp4bNxxT51j+BNmKzqYid8FPg/5pdwAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtFi9mHjMVqI9+SMNdGdNMU+GvxB0tzBZrW17Ns8Bejc4/lwukYo53YQRfmSIRu4R6h2D8/pSSTOOK/ITzOeESMEppGHTzoT7SAzODjf2cZRWN94r9iMospA8FGk5sRwiLTIDSN0KX3ntPwhNYHKFSLezjztH9mNih2OilGVlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2DAFC40E0028;
	Wed, 17 Apr 2024 11:47:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zH2k3AwB9QQg; Wed, 17 Apr 2024 11:47:22 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3F4740E0187;
	Wed, 17 Apr 2024 11:47:07 +0000 (UTC)
Date: Wed, 17 Apr 2024 13:46:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 02/14] x86/sev: Make the VMPL0 checking function more
 generic
Message-ID: <20240417114658.GHZh-2sk47TZgCp4Mb@fat_crate.local>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>

On Mon, Mar 25, 2024 at 05:26:21PM -0500, Tom Lendacky wrote:
> -static void enforce_vmpl0(void)
> +static bool running_at_vmpl0(void *va)

Not too crazy about it: you're turning it into a function which runs in
boolean context but takes a void *?!

And the boolean result is only a side-effect or what it does to the
argument - modify its permissions. Which is weird and not really
obvious.

I'd prefer it if you made it into

static void vmpl0_modify_permissions(void *va)

which basically says, modify the permissions of @va in vmpl0, which is
a lot closer to what the function does.

And then do

#define running_at_vmpl0(va)	vmpl0_modify_permissions((va))

because then through the indirection is at least clear how that "am
I running at VMPL0?" check is being done.

And later, if we need other VMPLs, we can extend
vmpl0_modify_permissions() and even do a more generic

vmpl_modify_permissions(unsigned int vmpl_level, void *va)

and so on and kill the silly macro.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

