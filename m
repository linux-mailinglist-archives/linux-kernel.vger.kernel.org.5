Return-Path: <linux-kernel+bounces-145685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC498A597D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5C41C20E98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D66137757;
	Mon, 15 Apr 2024 17:59:55 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6232F1E877
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713203994; cv=none; b=G3n8UKjdp2Fv3pvFSpyuqQbBFEY5JYz37VWtICH/ADz8OA9KYftT5k6mhnDIEL1nzfryQIdL5jTxn8uXBByhlSZv3AOMG5BchCZAzsuDOiqk4zaI0HGqNTP+yAlv27YhWCsoF3ockrkEyc8gnEohotG4CkH50diaEVDvQwFsh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713203994; c=relaxed/simple;
	bh=n12H2AcXe/G7fDq4Ayn11voWzAaVMt96sN1Ga2WKu5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBeWWfbyfSdoEz+J7Iz57XzsCt8s2TT/WVug0Ivnq5gL5s49PHNhb1HfVYNfL+3oTxdEbo59D5CHpzTAXXUYv3pjYGZLWDzU+ID3hdsh4rfbMUyDvI7PDca+4cgi7YyDevKna/NxvWdQpeKymBtWpVMAcNexZyxxHBtHQppQbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E2DDB40E0187;
	Mon, 15 Apr 2024 17:59:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B2ZEUQpsPhhK; Mon, 15 Apr 2024 17:59:38 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F31040E01C5;
	Mon, 15 Apr 2024 17:59:19 +0000 (UTC)
Date: Mon, 15 Apr 2024 19:59:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
	tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, ashish.kalra@amd.com, chao.gao@intel.com,
	bhe@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com,
	seanjc@google.com
Subject: Re: [PATCH v3 1/5] x86/kexec: do unconditional WBINVD for bare-metal
 in stop_this_cpu()
Message-ID: <20240415175912.GAZh1q8GgpY3tpJj5a@fat_crate.local>
References: <cover.1712493366.git.kai.huang@intel.com>
 <33b985a8f4346f4bcf0944eaf37193a906b11af3.1712493366.git.kai.huang@intel.com>
 <a4o4wlaojm5am4hc5yhr2mpn7clm3sjy5vx3w76ahm52lhxvwr@msdcnkcj3i6k>
 <4875349a-90e5-4a04-8a56-7d172b17e245@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4875349a-90e5-4a04-8a56-7d172b17e245@intel.com>

On Thu, Apr 11, 2024 at 09:54:13AM +1200, Huang, Kai wrote:
> Could you be more specific?
> 
> I was following Boris's suggestion to summerize all the discussion around
> the "unconditional WBINVD" issue.
> 
> https://lore.kernel.org/linux-kernel/20240228110207.GCZd8Sr8mXHA2KTiLz@fat_crate.local/
> 
> I can try to improve if I can know specifically what should be trimmed down.

No, keep it this way. I've yet to see someone complaining from too
verbose commit message while doing git archeology.

If it is too verbose to a reader, then that reader can jump over the
paragraphs.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

