Return-Path: <linux-kernel+bounces-147351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7FB8A72CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74622845A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAA51353F5;
	Tue, 16 Apr 2024 18:08:15 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866401369B2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290895; cv=none; b=ZhAGSKPiEBtyOIW3jtubgr/F1ywlY5XBBl03fyC8wSFosg5TK76ULyDmzjxllht71eijDGxBjSoDopbjJmqvsYJHP4WqdeZG3U5JyabKF+yNqeTMuIu57ThLqKLYswQ/vl7naSBiuWfJ1mratkspogCHY341tzxPz6+LPVNPYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290895; c=relaxed/simple;
	bh=6S9Xirfhco5ND1Ab4f17pk/ZoYdlT3pybm4P7bukBMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBuImLB1Covs6/QKxOM/wPZn3LN4xnF/V6S6YaWBdMuSD/BCyT6+WCQZIfGiTxhknxKOqYksQT9QSVmUcad17dLZk6vSP9x3wd3ZCCwiMfP+GJ3uThilfIfZ1EBYo6SZa17FDj1EtQKAUhqj7x32F9TxVsyZz0PVCepoYCRivH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1428540E02A5;
	Tue, 16 Apr 2024 18:08:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id etacZ0GjaNw6; Tue, 16 Apr 2024 18:08:02 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26E8A40E00B2;
	Tue, 16 Apr 2024 18:07:54 +0000 (UTC)
Date: Tue, 16 Apr 2024 20:07:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
Message-ID: <20240416180746.GFZh6-cmZqCF6KX5tt@fat_crate.local>
References: <20240412234058.1106744-1-xin@zytor.com>
 <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
 <1AE9FA53-A130-4F95-8408-C1990DD031AA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1AE9FA53-A130-4F95-8408-C1990DD031AA@zytor.com>

On Tue, Apr 16, 2024 at 11:05:09AM -0700, H. Peter Anvin wrote:
> The question was if you wanted a quick fix for x86/urgent. It's pretty
> obvious that a FRED fork of the int80 code is called for.

Yeah, I'm thinking the FRED fork would be even easier to send to Linus
now since no existing hw will break.

Btw, I presume that patch needs to have

Fixes: 55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

