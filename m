Return-Path: <linux-kernel+bounces-147361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2058F8A72ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D4B1C21883
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1E1350C0;
	Tue, 16 Apr 2024 18:18:28 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4C13342E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291508; cv=none; b=NrfMgkgB2GcffcPWD3oOf10YyKOcgC+/Zf9UhYXSCrsvHR/aQz5yj7n9vYF56Ct3xcjy34goOczZWQ2LVcut3S+W32aQrEOxOp/0VbVJ8mE2NmDlges9iNI56IUNGv3JPs5EVGX+kdYXFgN+U+R1MPYCmUHPthco5F5JCdfzeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291508; c=relaxed/simple;
	bh=j41BB7tWWuGzcPvptCWX6wnAqe56mddzPgpVGa2/iaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VruZHduy8zEMdNvVHw610PW/FrYcUoUETMt4dZVFupvKEVUYQrbGkPz1uS8HLGMjO9z/bzivB06rR5u/Wez6fgRrCPHkanNvUaIC+J/om+b1jZ2wld3DidlVhMhc48udbC47MN8kKLruNKc2ShKiPM7ZBGBWU7GXrKNFNu5u2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F01E840E0187;
	Tue, 16 Apr 2024 18:18:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0kWuDypYGtIH; Tue, 16 Apr 2024 18:18:21 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04A4040E0177;
	Tue, 16 Apr 2024 18:18:12 +0000 (UTC)
Date: Tue, 16 Apr 2024 20:18:07 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
Message-ID: <20240416181807.GGZh7A30Gtnixbs3M5@fat_crate.local>
References: <20240412234058.1106744-1-xin@zytor.com>
 <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
 <1AE9FA53-A130-4F95-8408-C1990DD031AA@zytor.com>
 <20240416180746.GFZh6-cmZqCF6KX5tt@fat_crate.local>
 <e3fbd500-f6b8-49ea-addb-bbc4803709ce@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3fbd500-f6b8-49ea-addb-bbc4803709ce@zytor.com>

On Tue, Apr 16, 2024 at 11:11:44AM -0700, H. Peter Anvin wrote:
> Yes. My fault, I gave Xin incorrect information w.r.t. Fixes: tags.

No worries, I'll fix that up before applying.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

