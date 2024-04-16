Return-Path: <linux-kernel+bounces-147378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654658A7328
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972B31C21A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE0137761;
	Tue, 16 Apr 2024 18:23:49 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEB134CD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291829; cv=none; b=m5AGktv21Mi4wbPF2r0GSCWABbZmQNO9rFZMxP5sDiugRQO30/iJ8sEOVLcUpCDoqfnabSnD1R3Ad0M8g65EVekEuFG4PRhLqAR4DPQwvwTanKoieQivTIRmUPgk4+k+DUQwbVYuGVNfE0nMgYYx1y+gzL2NeSwWxiRGNgcw6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291829; c=relaxed/simple;
	bh=U/50sGJFZFrEYup+iTo1SDFRXmgvZO6TYsKiH9MTqpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6MWNQcAQqN/t8/5Qdr4VR3rzn8zBS7QTKBuoz2iGwfoVvK/4Nc3Y7eqe8nBqM8eKQHzKtQzWp+/vIVc2VRe0HbsLvhgXSZMPQAvI6tJKQVSdoT9Duu2kjxYQVZ5LzBtGIE+GXbNPtcbqkAi9yu/WbTVpHPqdB4K0flAOPxZhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7762E40E0187;
	Tue, 16 Apr 2024 18:23:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id muGDUZbOoE1Z; Tue, 16 Apr 2024 18:23:42 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4ECA40E0177;
	Tue, 16 Apr 2024 18:23:37 +0000 (UTC)
Date: Tue, 16 Apr 2024 20:23:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240416182336.GHZh7CKCE7ApJ5OSPC@fat_crate.local>
References: <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
 <Zh7AZY5X8_uyHrjz@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zh7AZY5X8_uyHrjz@agluck-desk3>

On Tue, Apr 16, 2024 at 11:16:05AM -0700, Tony Luck wrote:
> Thomas gave his Reviewed-by for parts 1-3
> 
> Link: https://lore.kernel.org/all/871q7e7lfu.ffs@tglx/
> Link: https://lore.kernel.org/all/87y19m66tu.ffs@tglx/
> Link: https://lore.kernel.org/all/87v84q66sn.ffs@tglx/
> 
> Is there anyone else that needs a quick poke to look at these?

I don't think so.

Aren't you going to send the whole set first though?

Or what is the merge strategy here?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

