Return-Path: <linux-kernel+bounces-159998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD18B3777
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665BC284830
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9677146A84;
	Fri, 26 Apr 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F0PBQD5Q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307ED146D6E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135804; cv=none; b=QDvChoXWl2Ro32QnHPDfaKedNXFdJJ9gtwZFXhz86mPY0wrNd4dbapGEf0PAtIqfVdy1rMpyKxhNeUDG1BrXt+ztETCU/EhjjkVT/OVMO9x2kRPK/BlfgyJ8cyYt/hd4CkBa+CncMj3dOEc1Cxfcz3CTQfufrnPmJujPYi7zbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135804; c=relaxed/simple;
	bh=PHGATYEBLYbA+WbozEKa4kJ3KxnIU9rKtfDXNDUS3AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HchfZX5lsY+zRqlyPOT7VHpojnUcHs3y5xIHn6FG7oc5J4rPUOR3ct41FvGnRGdmh4jxwh6FdZTM/4fG4F9pHJyLJWwVlKhO3QiXl3qe7EPWafB1VfbHKsZs2t4LEOtDr98K2hBHZOu59LKZikDZX4+p+gJkg3DH/RIQVl9uHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F0PBQD5Q; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B7B7140E01A1;
	Fri, 26 Apr 2024 12:49:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I0Uikzg47n9m; Fri, 26 Apr 2024 12:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714135793; bh=qOtmbp3APfOxDRsPvdgSYkbmj3ZiCNd/UFPaUI+VCBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0PBQD5QNFiPDRNvfyTQz/oJ2XwWasb+zGuecWbbUHEfzQ1hxugyqaEx+sSw7SpZU
	 URa4kjnoSxD9qfoTPEs44dq9sjdwmNmMmYZNYRKFw9mggoMODkEvoRrl/1+7LfxGcB
	 t1qcmGKjAteb/X5fvAYyGsBWIgj4TYbzXPBCw0gEV9DBUxr6TlS6/1y4MIKsu8ru9S
	 cxGBA25JXyb8p44vkFgcjsJZQ/CDWN6PQV2G+/PoxSbGu7ahHpQBnlsVJvSbVpBZS6
	 i54F5wSZF5wjnrlaIEfyF0QLUuIrj2Ap3jtADDbI9VIS6XdGwG8Hq3kfK+38G2WXhy
	 oa78iSwyHZ8PFJM6yqwrK8CWDaGbpEdeaSTGHS9LQkY4ntPNVEPZbYd7RTD1fXS9NL
	 dUkJY0iq6LRoPfp/K/3ZZD8Wzz5q6nbiL8caG9IMXdXAQ4W16r975WjK5Bbd6cMI21
	 bwI+GPqmUU4oOjflfAtoWZF0hZBcRpdtKC+aluTYbp7pXHZz/Wi89EB+aZbrmXekW+
	 Vq5G11qU8YJP6aWbNa5hBXEIY1EYibHFRe6Q0rvUAPNeW97ZMnX8flfi2JvQ07a7vo
	 JWWYOju5/qNqB2D68FINKe0gVrPf9InSS/NW2knf35zUsgofRXPvFqHu7ZfTwFO565
	 alJfCrog2MGqdtthVdzdNxJM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A42A40E0192;
	Fri, 26 Apr 2024 12:49:48 +0000 (UTC)
Date: Fri, 26 Apr 2024 14:49:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: thomas.lendacky@amd.com, michael.roth@amd.com, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Apply RMP table fixups for kexec.
Message-ID: <20240426124943.GCZiui5z6Y3zOTxTic@fat_crate.local>
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <20240420110812.GLZiOiHNP4Q6YmWOLl@fat_crate.local>
 <c94d14e6-439d-4126-a44a-10a62ebf7d23@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c94d14e6-439d-4126-a44a-10a62ebf7d23@amd.com>

On Wed, Apr 24, 2024 at 02:10:03PM -0500, Kalra, Ashish wrote:
> Patch 2/2 - includes the following Fixes tag, do i need to include the Fixes
> tag in the cover letter too ?
> 
> Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")

People slap Fixes tags on pretty much every patch nowadays. I'd prefer
it if you spell it out in the future what the problem is you're
encountering so that I can make a decision where to route the patches
through.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

