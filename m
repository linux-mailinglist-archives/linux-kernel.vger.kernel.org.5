Return-Path: <linux-kernel+bounces-152244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0138ABB4F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8F71F21335
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B299C29422;
	Sat, 20 Apr 2024 11:21:03 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB6179A8;
	Sat, 20 Apr 2024 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612063; cv=none; b=jUaWhQ7sk9BDq6rt4ObnwMrF/CkwQZrX5z6WCdggkjw3Gfgr0nUZS+L35yZFG6dRcvWb3dC35s3RUj8nAucEuRS2IDnZRYDwuSGIdPK7l/eZdGVddLq8eeLw4NnMwiS52bohL8TgvCtdYSbWNnK2dDYHjpXSbI/WL9L/36XzxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612063; c=relaxed/simple;
	bh=YYJYeIgGcTt5hjQzW0nNz8cFsId94kh4P0NQ5RLRpjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgi2nkgjbf2PMhaTHNiCPFOZrWR7Kqij+RExCRcO4nDiaOio/py3aiboik9rPJzXy1dJaZ21cGGZ78noHal+DVmH4qRxmVeVeqFqgy/TXwQwUeVM8inIyfOAsW2wG0LXyVu++eluDEmbMLXnXPc0TJbUBzUT/HN88npxfEJxQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E5F1040E02A7;
	Sat, 20 Apr 2024 11:20:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sofCnBTMsFht; Sat, 20 Apr 2024 11:20:54 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6FA1040E00B2;
	Sat, 20 Apr 2024 11:20:48 +0000 (UTC)
Date: Sat, 20 Apr 2024 13:20:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: linux-tip-commits@vger.kernel.org, thomas.lendacky@amd.com,
	michael.roth@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/e820: Expose API to update e820 kexec and
 firmware tables externally.
Message-ID: <20240420112042.GMZiOlCoAguq_MHDdx@fat_crate.local>
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <511fcdca720d26a977a427bd21c5f2d668313f65.1713212104.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <511fcdca720d26a977a427bd21c5f2d668313f65.1713212104.git.ashish.kalra@amd.com>

On Mon, Apr 15, 2024 at 09:09:10PM +0000, Ashish Kalra wrote:
> -static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
> +u64 __init e820__range_update_firmware(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
> +{
> +	return __e820__range_update(e820_table_firmware, start, size, old_type, new_type);
> +}
> +
> +u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)

Yah, no point in defining silly wrappers _kexec() and _firmware() if the
actual e820 tables are already exported in asm/e820/api.h

You need a single

e820__range_update_table(struct e820_table *t, ..)

helper and move all current and future users to it while leaving
e820__range_update() alone which works on the e820_table.

As a future cleanup, e820__range_update() should be changed to use the
new e820__range_update_table() helper and then perhaps all code should
be converted back to a new

e820__range_update()

which takes a table as a first argument.

But the cleanup can go in later, after the current issue has been
resolved.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

