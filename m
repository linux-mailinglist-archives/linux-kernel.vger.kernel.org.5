Return-Path: <linux-kernel+bounces-123308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7C890658
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C947D1C30AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA52B9C5;
	Thu, 28 Mar 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AXgyMlRc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B8BA53
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644782; cv=none; b=BpejlWC0vgbgWE0oYPpXeCc17DMIuLIV2UAFzgg2H5txW1ibnxnz6aer/LyuV95eHx7Ijh2d007Lwk0gGDKQ5JCjxBiZ1Qbyi691S6jp17307xnlW7Y2e0Nf6hgXoikKwpvPztE74yPhP/IpXgYv0Rr3oIw0/Mw+lHMScOryhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644782; c=relaxed/simple;
	bh=etv6yKFumyy5iQLZpAkhMvD76t/Nfc3D73t7VekdT6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmN7QeXwVDCPidQaFwDIbDkT9N80IOo+IM/O9alnsOCAmHnsH4FEUhEOGXuhLCIIJo1YUHvxrt4iucveKhUOqd2FDw3FNXxmpU/sAXAPQqWeJ6OI472vC1G/kHrLiuejQHOYKE4/N+HLlTs3GnkUT92lonwD0FcHs0bhygQJnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AXgyMlRc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EAD5A40E024C;
	Thu, 28 Mar 2024 16:52:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IRVAOuVOnFlK; Thu, 28 Mar 2024 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711644775; bh=hjRzpKf/97lQo2QX+OoARQ9cMuHfEGa9DXxXws2ZSrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXgyMlRc9uLZ1qUlTqO1udny1BnyRNmfcBvu4lUxhCWPp5ov4AS9RvcC7OHOBOVvA
	 GD8+oNYe/1KiHIPmZWL1qwRDn5qwyisKR3t35l0nh8aoK5dzg/RhJrhRt39pHQRxT/
	 2oBz+ID9C56Iom3XDsReL3+e33+lr6yfDf17wDqTEkVdh4akN+4R8QtNMsiYCBj+Jh
	 FER2yZnU/3jdwoZ5megZsfjDJ8h2h0sVZDiGKkduy2iuKILlmq7pE7nYRugkWlkkHC
	 CJLRuEhwSXi8R5goa9DKCkepm0QMI/t/TzXOjPnWQqJobt6yt1a4OiLLe6hEsnK+bA
	 DCiqB6w2LdthBWA7M9wQqFJ6YQEId+lEy8okRJtxG21K4J/kXbtTu7R88eWPVjYHpx
	 JTy8ie3OuBCgBlBdKLj5IWa6yCJ7+JFIIsZzwakikOeWYpf2kd4SpQkCs6uch1rmt7
	 XQCg4cSecLzFVhT9N8yyfJ7OlRqym6fw3NTSuhEGyuO3YCNJaVFBJdyFxCHEUQTxZO
	 MDu2ouY44kjJEAGFlDkOVxMyqeEdRAc2uwJ6bkhg2oDV+kc7C7tKuEM3IF6TePC/U7
	 LuNQB17xt7ecFgUS64p5IpbOhSqg185v6z83ofd+23qM4cppqjRgIpJzIWFlwv98eO
	 En7iow05FU05qJnj5urSPWyA=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23BFE40E00B2;
	Thu, 28 Mar 2024 16:52:52 +0000 (UTC)
Date: Thu, 28 Mar 2024 17:52:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
References: <20240328163746.243023-1-tony.luck@intel.com>
 <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>

On Thu, Mar 28, 2024 at 05:48:11PM +0100, Borislav Petkov wrote:
> > +		struct {
> > +			__u8	x86_vendor;	/* CPU vendor */

Looking at this more - you don't really need the vendor to be part of
this as the CPUID leaf ranges should *actually* be disjunct. Actually...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

