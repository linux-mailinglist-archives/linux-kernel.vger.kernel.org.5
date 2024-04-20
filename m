Return-Path: <linux-kernel+bounces-152239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC258ABB42
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B8B1F21385
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1688429402;
	Sat, 20 Apr 2024 11:09:00 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576F23778
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611339; cv=none; b=hu2G+ArfmNncbzPEbhPMM0WjsCxzPONoSNY7fDbsl5Gj5gFhmp3wgYhlhBc1WZtcKxJ9ulMtVof6X7zLHQua/AlHHznrjCr+q2wgwqJA2dI21UtajZre/NcNQv5qsgHNj8JU2c/gPCebDzqZdbRsNyM/YbjyRcA9miDXl+W2GLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611339; c=relaxed/simple;
	bh=AGRBDb449gGpaYUhpohdXAOTNbnkf24CKApPLQ0xoCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJIYODSNR21bBIrD8xE/lTXPwV6iyI4aTxDris730cH/wy2LNgL67wkePqXhNnziCRFU3Ouo26Zsiu72COepEC7pOG0Ed3pDuvXwyOVqZ5H3xeG+bgDl4cSSWjydNnfpqb0RrQAYw4DI8RPzTWemS37U3aJnSzuRr5XwuLiF1Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 14DC140E0187;
	Sat, 20 Apr 2024 11:08:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pHlnwX_HrWs5; Sat, 20 Apr 2024 11:08:50 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42CBD40E016C;
	Sat, 20 Apr 2024 11:08:44 +0000 (UTC)
Date: Sat, 20 Apr 2024 13:08:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: thomas.lendacky@amd.com, michael.roth@amd.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Apply RMP table fixups for kexec.
Message-ID: <20240420110812.GLZiOiHNP4Q6YmWOLl@fat_crate.local>
References: <cover.1713212104.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1713212104.git.ashish.kalra@amd.com>

Drop linux-tip-commits@vger.kernel.org from Cc.

On Mon, Apr 15, 2024 at 09:08:56PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Handle cases where the RMP table placement in the BIOS is
> not 2M aligned and then the kexec kernel could try to allocate
> from within that chunk and that causes a fatal RMP fault.

Is this something that happens on existing systems currently so that it
needs to be fixed upstream?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

