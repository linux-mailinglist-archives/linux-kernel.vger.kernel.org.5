Return-Path: <linux-kernel+bounces-152456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C86998ABEB5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 09:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A56C2810F4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 07:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8391DD53E;
	Sun, 21 Apr 2024 07:12:46 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CA4437
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 07:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713683566; cv=none; b=ughIO/t7J/bEUY3kBwRQ/YuuBrcelTgxfa8JOVCtie6zLaPHjODdw8eof4tyl6Rwr6t7Nl5YpfNwdPGQO8zSZj2YECgeyjf1uIpkC/+1vKK6w/AmsylUORVAopc3r2ayb5GWvtgkFVAU86kggKLliHkDymzlKKNup8sut/bsnWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713683566; c=relaxed/simple;
	bh=nWWxXOfco+rjROpQCpzO0Q5BfhYTwDjKeSNYYJlrPC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd0P7xwew+PADfNFmFMoH9+EJVTJxcfNEpHDhRYR3dRxGwpj4Q3GERzk09ppRABS9ezlsqmkCfcJX5Jh9HGjq6tXr+bUAWZVrToT6TUxEe7CIu5XRqkPRnCONVApDyWRThrhiRs1W+jPI58lczge8vucMGg0MQ7o8r9GHBYzU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EEE2C40E0187;
	Sun, 21 Apr 2024 07:12:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id u6V1THR8SB5r; Sun, 21 Apr 2024 07:12:37 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25EA040E0028;
	Sun, 21 Apr 2024 07:12:23 +0000 (UTC)
Date: Sun, 21 Apr 2024 09:12:22 +0200
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
Message-ID: <20240421071126.GAZiS8HoAn5sFLShnf@fat_crate.local>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>
 <20240417114658.GHZh-2sk47TZgCp4Mb@fat_crate.local>
 <505dcf34-93ff-643c-b149-8ef9ce90c023@amd.com>
 <20240417205048.GHZiA2KGbFFTQFyTAM@fat_crate.local>
 <36453f2f-3a2f-ae8b-215f-da9972f14d6d@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36453f2f-3a2f-ae8b-215f-da9972f14d6d@amd.com>

On Thu, Apr 18, 2024 at 01:38:49PM -0500, Tom Lendacky wrote:
> I think I'll just eliminate the function then and call rmpadjust directly,
> that should make it clear.

Your call.

However, if we're anticipating more uses around RMPADJUST like that we
might as well design the interface properly from the very beginning.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

