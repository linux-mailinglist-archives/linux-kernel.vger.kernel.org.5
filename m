Return-Path: <linux-kernel+bounces-160276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CCD8B3B47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E5128AE55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CFE14901F;
	Fri, 26 Apr 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lFVxfzoV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EBC148FE1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144987; cv=none; b=G9S3h84GUt0VUAO0EXNyPfp1FBVR8E+KRsZbKdbxfYYwm09ldUhuS1j/oGUbRzJyyISuoZrofNd2k06rmNIAeqwydEKpUaCOMiLEk+0R4cCIgHv1N5x9twh73G2WkR8+fTdVqKW3AZqGH2E9ka0BtNqjfDuaH6QdnMCzRCIgFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144987; c=relaxed/simple;
	bh=jzHuytPGPWNvxd85dNGHz9Ks6fmKxW+5cuRlpRiJD9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCo29KpYsXh48fJh4wwgOLd4IkkfZVwPzrPnkOnT7P/2ON2NGk2B0DcfR6v7cAs0k3iLstj0KlCMv5/y/BWJyzccXBEUfu/C7HKJts0UA92Rh5EZsJtuyCuh81Bb63PgsO8BxdlrpBuZhEibXx//x6pijrn9GCITEVtaq/qF5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lFVxfzoV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B82DB40E0247;
	Fri, 26 Apr 2024 15:22:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ILr26VA550-F; Fri, 26 Apr 2024 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714144973; bh=3mhDgo/tsyN7YQ5kOgWo3bYKeZgEWZQZ5JsoONAwiNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFVxfzoVn1whzS3o16EW0SSDPGSm0ye6xQPwH9YMEZBQtXgyi6CmxpOnaaQ+eROYU
	 B4tdGhJtT1F0g1610rBTdxiHayujuPNP4+3yGum9Z6cyoOBSaFzfil/xPMEO6Q0wPY
	 rzBgJDlwplt5E/kNKTu1AXY5C0OLt8e1BdSYKrVhIBAxMfi3c+OsOCwJx4ZZ5lASL+
	 ZZAGjvEiWJ2LKW1WEMET8qdxNVq4Ou10EmhYxPpO/1AAHQkcjOG99lGk0ZV7wrEV4c
	 f2J39ceZh4u3S2lAZnrjGOl12s588Z7coJaqVr7DDP70egbs32Pi5lzu++VAZiWWpE
	 WuVw1KEEuYhYKN2iZ15l0sAI9QwY6Ev2MfoI2n34G2zKX8uUmgqB4Xa3zr4jzbbmvB
	 7DifnQkv/CEypkPozdB9MDhscHNbhbdR40d8kSypNYXHSwzQak/GTGBZgv777cVWTl
	 U63DP0+ENo1vvyDwSF/B3ThYk1fJ/36jMvkSDbPLmRSeMK/xCYZTfaH5Nibr56nl6Q
	 hwu6QW5maWkOlRpm4+YOaHz/Ylla+EQJfP8vNNwvhH5oMSiniP8vG38iCNozyQaH4z
	 SzDPLQbWl5g3ih0iFKltOXmrTC9SsiBfioWfOslsxmSTuq/GJdQm4wE5JmWB6WS8BS
	 wCObVmXzckUjx794BkPh5B/I=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AEB140E0177;
	Fri, 26 Apr 2024 15:22:27 +0000 (UTC)
Date: Fri, 26 Apr 2024 17:22:21 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Message-ID: <20240426152221.GFZivGrY86svE0RZ00@fat_crate.local>
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
 <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>

On Fri, Apr 26, 2024 at 09:47:02AM -0500, Kalra, Ashish wrote:
> I should have mentioned *chained* guest kexec above instead of nested guest
> kexec.

What is a "chained guest kexec" now?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

