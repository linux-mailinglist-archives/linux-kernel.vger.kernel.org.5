Return-Path: <linux-kernel+bounces-137430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4749C89E1FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D931C211F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25472156878;
	Tue,  9 Apr 2024 17:58:12 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04E131732
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685491; cv=none; b=p/uMmM87igDIsgz9hRZcUbVLEGI+ZrKwEgoXqIAfmjecTCD1b2PJ+NzTLh56KxJcjS5sPNqPtUQvUKpGmfxqoYWUNQhnlcGo4eSmCZQ61Vz3bVe3d/zkkg1RHT2Q+9sZrYyXF+PLwgj8Af98WRBgOHkAg3CyYYY91t4utPmYucY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685491; c=relaxed/simple;
	bh=K41sP0ZETOeyv4cbfS9ddqUr9tmWzEZdyvMpN+HRH6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pam68GQ3RsrrTYaxaW+ry+Zjnt7mv3xUG/HpsExzM3LwEkFvmJt+fLhzomHBrf7BVYKlMKdhsk0FJTu7ui8e5kMQ5kJydeDRRhpdLF5FJOmlu8K0ZoV1Owgr9iW+Oufkz88jSTqeGoPO7cq4BiL6/DZQWST0loIIpiyzLuw3BaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7148640E01C5;
	Tue,  9 Apr 2024 17:58:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tykDg4uvVSRC; Tue,  9 Apr 2024 17:58:02 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0ED640E0187;
	Tue,  9 Apr 2024 17:57:47 +0000 (UTC)
Date: Tue, 9 Apr 2024 19:57:42 +0200
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
Subject: Re: [PATCH v3 01/14] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
Message-ID: <20240409175742.GEZhWBljxrJ8yGC3wE@fat_crate.local>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <425afa6512994b1ca1bb366eb7abfb24d65175aa.1711405593.git.thomas.lendacky@amd.com>
 <20240409170917.GCZhV2PWPhmzTHhMRO@fat_crate.local>
 <ac044150-ffb1-09b5-1f36-fdd6e259ba59@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac044150-ffb1-09b5-1f36-fdd6e259ba59@amd.com>

On Tue, Apr 09, 2024 at 12:44:13PM -0500, Tom Lendacky wrote:
> When it's not static and has the name snp_init(), then it has to match the
> definition in arch/x86/include/asm/sev.h, which is really intended for the
> snp_init() in arch/x86/kernel/sev.c when called from
> arch/x86/mm/mem_encrypt_identity.c.
> 
> So, yes, changing the name would be enough except then it remains not a
> static and you can get a compiler warning about not having a prototype for
> it if the -Wmissing-prototypes option is ever applied to that file (I don't
> believe it is today because it is in the decompressor code, but that can
> change). And since nothing calls the snp_init() in
> arch/x86/boot/compressed/sev.c from outside of that file, making it static
> was appropriate.

Yes, then please remove all that text about what could potentially
happen from the commit message so that it is not confusing as to what
the situation *currently* is.

The two functions are independent right now. It is enough to say that
you want to differentiate which one is called when, in order to avoid
confusion.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

