Return-Path: <linux-kernel+bounces-149179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726A08A8CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8DA1C20F02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B038F9C;
	Wed, 17 Apr 2024 20:29:07 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868138DF9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713385746; cv=none; b=JDTHvsxRaLfn+tpIWS2FwsVVI2kxiHDu65l/A99gnhhvCT6KaBSJRlpEzDcXjAsf7I/DJNyXnFrq9/mvtIwWGEOsENdj4NafGDE4C2oa2fzwaPIHs6947ThThVaOVUQ2TmpMfz/6DS+U20hU6zW+uhtLLgtMS5zDA1IJFk93/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713385746; c=relaxed/simple;
	bh=S6pxlb+30bR0uLnyzgiSK01E1nt/IzC4MIC2ueahwV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDIBS2dl1y7MU0BtFcqI3I4h08rEpt7usIXF3iwwIw+qTjKAgehMX08BQsBq1SxRLGSMmR/iXxUV6HTrOO1eAT9j8noVcXJJ3TD1jLJMt/wRyQJRcmGQx90PW5j5X0EeUv1j30XJyiic4DtDbucxxkFc5dgj21A1KygzNcO47uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 49D4740E0177;
	Wed, 17 Apr 2024 20:29:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C2i_xOoBOGOz; Wed, 17 Apr 2024 20:28:58 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 523CC40E024C;
	Wed, 17 Apr 2024 20:28:49 +0000 (UTC)
Date: Wed, 17 Apr 2024 22:28:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH v3 1/1] x86/fred: Fix INT80 emulation for FRED
Message-ID: <20240417202842.GGZiAw-h6iKQ8efsVM@fat_crate.local>
References: <20240417063001.3773507-1-xin@zytor.com>
 <20240417093813.GBZh-YhSQCXgy3OxFI@fat_crate.local>
 <5dd74948-a951-4a7a-84ac-7e75cc26bb46@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5dd74948-a951-4a7a-84ac-7e75cc26bb46@zytor.com>

On Wed, Apr 17, 2024 at 07:59:25AM -0700, H. Peter Anvin wrote:
> FRED has separate entry flows depending on if the event came from user space
> or kernel space:
> 
> asm_fred_entrypoint_user -> fred_entry_from_user
> 
> asm_fred_entrypoint_kernel -> fred_entry_from_kernel
> 
> fred_entry_from_kernel does not invoke fred_intx() if the event type is
> EVENT_TYPE_SWINT, instead it falls through to fred_bad_type(). Perhaps
> fred_intx() should be renamed fred_intx_user() for additional clarity.

Sure.

> (It might also we worth noting in that function that the reason int $0x03
> and int $0x04 are dispatched as INT3 and INTO is to be fully user space
> compatible with legacy IDT, which behaves similarly.)

Also yes.

> Thus, the int $0x80 code is simply not reachable from kernel space; if
> kernel code were to invoke int $0x80 or any other INT instruction it will
> error out before getting to this code.

Yah, that explanation is a lot better, thanks. I'll use it. :)

> I suggested putting it into a comment for future reference. Obviously
> no need to duplicate it in the commit message :)

Yap, that makes more sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

