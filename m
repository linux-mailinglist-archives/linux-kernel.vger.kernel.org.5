Return-Path: <linux-kernel+bounces-75006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420285E164
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6B7285AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFD8063D;
	Wed, 21 Feb 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Te5ZEZOq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AB7F47A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529859; cv=none; b=TJkOBjLgCDhW3R2Y7BEOmVMDyR4rgwUzpwnLfSOTV19+EE7lwAip5XBUH4peNIzA84SvX7EpMWcPsjM4mFVKui9dIDIc2kjoes1nVRp8gi5e99BL8x15jqKwcLz1MrTSIH9A8g7eeorzJVEobalLW40GT6eYPbIGYqkSDThnTqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529859; c=relaxed/simple;
	bh=EoeICkB3hFDxSwcp464+mUrp0AXFd54m6bE/NoDVnvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSnQKAtj+zWr5amTTH/I3+wfn+qeTAunxTuH5GQaG9Nw/0RXNFpRNTixTP8Uw6cvffKPx3eQEM8QBCvm29Yc3F/qQIw8nQIVl3jk0Jn0hxGMjTDUeM+8UEMRnhzL0LVThdNwVNDZvxGdQYhqDLC75mnwNVqLyqj0ZcQILk3w3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Te5ZEZOq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708529857; x=1740065857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EoeICkB3hFDxSwcp464+mUrp0AXFd54m6bE/NoDVnvo=;
  b=Te5ZEZOqZHHvDsCfaql1V7449h/C+9OGUYWcBXN1ikfOLzqpFezcHwvx
   Kiq2SiqK9HgeYnrg21H2A3OsSSIncHgJDMrQlbCvUvAgCF9ZC+BB2IeUQ
   fzHAang252f2rXxVFpYKaeUsmoV3kEiGDL3Tl1ZG4OSnFwoeYd14yqyUe
   jOHsw2XJ7zR+xppulmbW0PQyhCCI/HzE2euKlX6HaRGJogcIRgYyJuvAg
   /AYRXNA41b9+gN2YYQvZSaV/jT4TZFAnrks8TQQ4amC7nNcYo7kV37vOg
   3qTW5RfiySxCphfOxTmrULz3mLIVntYEm38UWxg5+lXlTb1ksLFIKmMm7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25158282"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="25158282"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 07:37:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936660356"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="936660356"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 07:37:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2C3822A0; Wed, 21 Feb 2024 17:37:32 +0200 (EET)
Date: Wed, 21 Feb 2024 17:37:32 +0200
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Message-ID: <ja7dptjwhshsjjcgwxivq4tmfs52owlueqexz2ubnnir6mbflh@bjooemgy7ml2>
References: <20240221123248.25570-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221123248.25570-1-Jason@zx2c4.com>

On Wed, Feb 21, 2024 at 01:32:40PM +0100, Jason A. Donenfeld wrote:
> There are few uses of CoCo that don't rely on working cryptography and
> hence a working RNG. Unfortunately, the CoCo threat model means that the
> VM host cannot be trusted and may actively work against guests to
> extract secrets or manipulate computation. Since a malicious host can
> modify or observe nearly all inputs to guests, the only remaining source
> of entropy for CoCo guests is RDRAND.
> 
> If RDRAND is broken -- due to CPU hardware fault -- the RNG as a whole
> is meant to gracefully continue on gathering entropy from other sources,
> but since there aren't other sources on CoCo, this is catastrophic.
> This is mostly a concern at boot time when initially seeding the RNG, as
> after that the consequences of a broken RDRAND are much more
> theoretical.
> 
> So, try at boot to seed the RNG using 256 bits of RDRAND output. If this
> fails, panic(). This will also trigger if the system is booted without
> RDRAND, as RDRAND is essential for a safe CoCo boot.
> 
> This patch is deliberately written to be "just a CoCo x86 driver
> feature" and not part of the RNG itself. Many device drivers and
> platforms have some desire to contribute something to the RNG, and
> add_device_randomness() is specifically meant for this purpose. Any
> driver can call this with seed data of any quality, or even garbage
> quality, and it can only possibly make the quality of the RNG better or
> have no effect, but can never make it worse. Rather than trying to
> build something into the core of the RNG, this patch interprets the
> particular CoCo issue as just a CoCo issue, and therefore separates this
> all out into driver (well, arch/platform) code.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

