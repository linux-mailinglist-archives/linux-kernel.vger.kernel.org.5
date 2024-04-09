Return-Path: <linux-kernel+bounces-136447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566DD89D425
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB32836BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33767F7D0;
	Tue,  9 Apr 2024 08:22:39 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531527F47F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650959; cv=none; b=oK+/E1/4gaGtUHuXHQl2RD39ei9YJVY95HnOLZguiOyMcpYCKB1hkKx5eZrgDUk/bmOXHlKzEBhuucxH2hcj0wlIJksUvQVICMn6InX1aHpeVLP/fMPtr07tcsyFTjVQcQ+U7kkULK+VCmNx+hZCdXJt8MtkJDE8y2+7b2kGWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650959; c=relaxed/simple;
	bh=SUoI8McijZOxUJEg9/4QqPKg5BzvNcK8n4BqBHSGiPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSPCU5tOG8c1XlYuP2Qn+g0boStJYdWPjYtutM07YxjfCQgunRD9/5zZRMUKKYu6ms9PWpWsgecdCUIIxhS+oDsuHSa1QFH5937qIvJSzy9Fkta5bnUBXeRe6o3bpGKGdBhWf8SvDJGy/3v8UUClKWmI25Hmy71GUH/llFLKyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CC1AD40E02A5;
	Tue,  9 Apr 2024 08:22:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B6aPMA0sLNB4; Tue,  9 Apr 2024 08:22:29 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97C0640E00B2;
	Tue,  9 Apr 2024 08:22:24 +0000 (UTC)
Date: Tue, 9 Apr 2024 10:22:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to
 struct cpuinfo_x86
Message-ID: <20240409082217.GAZhT6uW7aELQCHOwL@fat_crate.local>
References: <20240328163746.243023-2-tony.luck@intel.com>
 <20240328164811.GDZgWfSzAWZXO7dUky@fat_crate.local>
 <20240328165251.GEZgWgY1Clb9z4t3VX@fat_crate.local>
 <SJ1PR11MB6083AADC97E50462C1137D71FC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240328171204.GGZgWk5JNOzQzoaEql@fat_crate.local>
 <SJ1PR11MB6083D8BB65748452B204ED8AFC3B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240329114007.GAZgaolwSFtjHStiuL@fat_crate.local>
 <Zgr6kT8oULbnmEXx@agluck-desk3>
 <20240407105407.GAZhJ7T0fEhzow2MN2@fat_crate.local>
 <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60837E437DFA0595DF5B25D0FC002@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Apr 08, 2024 at 04:20:36PM +0000, Luck, Tony wrote:
> So are parts 1-3 ready for TIP? If they get added I can start collecting
> reviews for parts 4-72.

I'd like for tglx to have a look at this first too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

