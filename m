Return-Path: <linux-kernel+bounces-147383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFAD8A7334
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB141F21988
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190A136647;
	Tue, 16 Apr 2024 18:28:19 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5110A14
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292099; cv=none; b=Ww47f/SySL9/IMopmSWTKjJiXHvGdJiWE5IyPLhjivdJz8XXj0zvtxAQyP6CaENzZFICZfCjKuFFTZuS6UPBDDf6HjRF/z8faORMFxRYhmsGfcpUZSdi0q6DS6nbk2qvzd4oLfmOAhCjjqII/W4FvDrqYTaTsxuVthlFIGOXtf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292099; c=relaxed/simple;
	bh=DpOIL9VVFpGRMgCQIGA0RxK2sa4UYb5bFvqDxaX5ZuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX/7EM3XDJ2v/k8INPmsOjyfcMqeNSptb+JenptrlNKJOGaxMVrsB+j1H/pjTmFcVTvf6L3FRiD3yUurWLeeQ7Kcx7MVeUB7pJLLgPLcRU7fmuQypP3RzLfqoi6CrbK8IJ8YBF2su1osmST9j7wC9SZwBA/C6qwRR8sfUtP6KPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4903D40E0187;
	Tue, 16 Apr 2024 18:28:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XDGfqRSM1Pap; Tue, 16 Apr 2024 18:28:12 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E0A640E016C;
	Tue, 16 Apr 2024 18:28:04 +0000 (UTC)
Date: Tue, 16 Apr 2024 20:28:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
	luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH v2 1/1] x86/fred: Fix INT80 emulation for FRED
Message-ID: <20240416182803.GIZh7DMyPNHphpa9JA@fat_crate.local>
References: <20240416175804.3328999-1-xin@zytor.com>
 <ece31eca-37bc-4b39-9fc9-7e6fda741729@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ece31eca-37bc-4b39-9fc9-7e6fda741729@zytor.com>

On Tue, Apr 16, 2024 at 11:23:24AM -0700, H. Peter Anvin wrote:
> (I think there is actually less than half the code left. This could be
> further cleaned up by inlining the common code,

Yeah, was just thinking about that too. I'd say, though, let's let the
FRED code settle, we start using it and then we can always unify common
stuff later if it turns out that it won't diverge anymore.

> but if I were still maintainer I would not want that for x86/urgent.
> This patch has the very nice property for x86/urgent purposes that it
> doesn't touch non-FRED code at all.)

Right.

I'd let Xin work in all those comments and then I'll pick it up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

