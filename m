Return-Path: <linux-kernel+bounces-60943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F48850B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65C1282C24
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F15EE96;
	Sun, 11 Feb 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="daMsuEFD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A55D485
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682730; cv=none; b=gYev51zJ/QIEKeHqLKfGlTJp0Yj1O488JYSXjO31IK8qxKzCFNv4MgFtaBKM1TNnq7PwtsqY9DWCv4Rf/bQ7CU8q7zYHJZ9Bzr1Y8pL28SWx98Aaj7VWqou+XvbSBQ5swUWxdkeE202fCewWxWE0vonRiVcWpOb0I0gMrgqvmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682730; c=relaxed/simple;
	bh=I2G8lgubEspsN9N7NyufAQUMTBlL8rTZjbtU4LbtuR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdYXFbrXuHEOtlE5uXsPAr6x7fd9g46FK88Q3c5N/ixt6t7s9UfrfSJ/3ywIV/VqQFu+k3m4jURJ4kuQyy3A9cXUngkxStSlN2x/vzaj8SYiF2bbx3gnO/zDbmpOI2gNQX9KvxGNq+HmqJL5858N9zSPAnlbprlpT/0RBVumuR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=daMsuEFD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9407440E01BB;
	Sun, 11 Feb 2024 20:18:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xH10vrJzwQ_9; Sun, 11 Feb 2024 20:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707682722; bh=kZ2MQOdF7SF61XpuHJajoXSOsW/qod1LGTZCg746/Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daMsuEFDjKgkhh32czeQDmisXC7xafDzk94NxsBpv/Jx0RdOckP226o3bKy6B333w
	 6kX6y8nZsfgzkfZYU84bA7CUUb2ZMhoP24eEBl7gmDxLvsobViKLCobqt1hPOdWKxw
	 kXfUTDaBAWh2diUD8JAPJJQYaldyDdEE+H5TYUEFXHRDHMaRy9DtPPJp0NmJSNGWLL
	 BcS+nXssAOFo0R4ucw3znaxoLbweVOaAv5ukwIynPfbq3l39TMOfedoMnncTkdxe6S
	 7fBHduCrTEFFjpM3MwjgTZ7P5UHVWFlEpx5oRje3zGJNoqXcvMTFHHvPM8uDh17Mon
	 tWAmVrXR8phrjciNQsFLv19BQQYIh0hL6eP0phNG1N9QjRTV7BJm/zb1o7kgdtiGdJ
	 TLrwNdB98ZPIMoFhxO3JJtEubMzrCN8vHruk+oZ+GyLgWLE0pcFzxvHgfHiH5L0Ma8
	 /wtXb+juWAnRPRJo1a0jDAM+DAU1umIrsOJTJC9uys1qLhfb6a7PCC6jNr/DWHky+k
	 YkP7AwTUT4apqJiJ73wqw2/zrn2mPY9fgPRj/eUICHKBqU0u5TH5NctWXc0y/Fnj8A
	 6GEPsaNaYPeU6GWyMRcXfKUcZQjISnnksm42JLr39HxhuqQm4M1tL6pFKLdbPSRTKD
	 spHqxvZWqHPmNWhEkjZRkku0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 217C340E01B5;
	Sun, 11 Feb 2024 20:18:38 +0000 (UTC)
Date: Sun, 11 Feb 2024 21:18:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccp - Have it depend on AMD_IOMMU
Message-ID: <20240211201831.GBZckrl84xVo-ILnOJ@fat_crate.local>
References: <20240207204721.6189-1-bp@alien8.de>
 <5e4670e5-acc8-adf3-2a3d-eb02db7ed990@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e4670e5-acc8-adf3-2a3d-eb02db7ed990@amd.com>

On Fri, Feb 09, 2024 at 11:51:37AM -0600, Tom Lendacky wrote:
> Or should the ifdef around amd_iommu_snp_disable() in
> include/linux/amd-iommu.h instead be:
> 
> #if defined(CONFIG_AMD_IOMMU) && defined(CONFIG_KVM_AMD_SEV)

Pretty much, except the thunk should say that it is the thunk that gets
called:

#if defined(CONFIG_AMD_IOMMU) && defined(CONFIG_KVM_AMD_SEV)
int amd_iommu_snp_disable(void);
#else
static inline int amd_iommu_snp_disable(void) { return -ENODEV; }
#endif

and return -ENODEV to denote that so that the caller doesn't wonder
what's going on.

> I think this would be better in case these should be referenced
> elsewhere in the future.

However, looking at all that code, its design still looks iffy to me.

iommu_page_make_shared() and amd_iommu_snp_disable() is functionality
which the *IOMMU* provides in order to deal with SEV* guests. So that
functionality should be behind

CONFIG_AMD_IOMMU_SEV

or so, on which all its users depend or select. I'd prefer depend tho.

Putting IOMMU facilities around a KVM Kconfig symbol CONFIG_KVM_AMD_SEV
is simply bad design. There are providers of functionality which is
behind Kconfig symbols and users which depend on those. The current
thing is a hack IMNSVHO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

