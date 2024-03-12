Return-Path: <linux-kernel+bounces-99922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3706D878F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF861F219EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE9F6996F;
	Tue, 12 Mar 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gfuek7bA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E971B657
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229833; cv=none; b=K2Q2Lp4MAz1RSzUU37RtVgLDdrCRSLYmHyBVR8qX5t6KNm47YbyXvyGdAI2FINu1ARZyjKQDBg5+ZwiKol+SAp+AigPr1M1E1Vh/Ld5MXPkJM18/ul8c9HSHrXaXAhilqtkA0HogZ0uh3pUMY2HLzvM4qW9sSaIAJusiDpWQZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229833; c=relaxed/simple;
	bh=NLUmHsYEQv8DOxsFmYDsJDVSVmtMfbpGlF0YJGtG0KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1UtqJqzXaLuVRJsnyPbFIHE350zC89ei1MBWwBrxVn8gCBX1v4klYaaeZq9UQ4DFv4UqmOf4Lc06Q4WfYf59PEAnbVR4dGWE2H6Z51TGxtPD5PudyOlxKpa2WXsClWuPhKt7Wg+5rqikAHwJ5BE1sX1yBbAMq0Ml9kfCMwzo0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gfuek7bA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7838340E0174;
	Tue, 12 Mar 2024 07:50:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 02ik2aRdF5bB; Tue, 12 Mar 2024 07:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710229826; bh=PZ8aTG0JAvJMFTb6smzy3OjFvRvOiNjZnnn3EorMbnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gfuek7bAjEvrmBmNNACsj+vr1Dw9OPC/nlYG1rhR3VL/QzcQww0lu5gPScQKWHXNB
	 oKfmLN141bwPo9GPU2INpyTCP2BmLZVDQphDFeo20ihWSUM0NukIj2qOh+NyhkxOeO
	 xy8v2ZoUPOA8J4IFbiZ2CmnaOTh9oX6KEo6W/xFISEfOKcDbqtXispaNqK94T3Y4FN
	 J0xTads15lPf7ZKFYzKAgO1DNn59BQYs0rqIYWIl/avkPo9hM+LzCmLb7KctKNsZ3B
	 H5LIxoxB/YlooJsyARxoA9d9hlEmK3FvNHdSKm29IgQGh+bKCUwLrw/2gp0lA9ymmh
	 Xk3s2GsS1HfnzWkCXfJiUnlVPIe5hX23TvSu+nZiykdq4PZsI4PbHF3sPaBgnUUkV3
	 /kbdgUJDd5RrvKsPJddE+RqSSRb7kk1/ytZYRs/1eFSCXyG1ltvby7bCYf7SfKapp2
	 vVsTCDQz+IeJ2X0+dP/pyHTae0iAVCvqkl4jLBh6mt231TmG8QRMaEwFtuzwZAV9BO
	 g63f3WjIdJ5pEvaeUU80ALHYtOkBMp1lqEtlZVHPzAVVblHRJnKx8iFLRbCijv1pfx
	 JmctBKDIZ0oJlrojpazGESg8F0K0hjxYe0XQh/U8myXMriqToZk+AMI8vl9XXlkmOj
	 Gd6eoy84DpFbDeaZDtzec3ZU=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D25E40E016B;
	Tue, 12 Mar 2024 07:50:23 +0000 (UTC)
Date: Tue, 12 Mar 2024 08:50:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/sev for v6.9-rc1
Message-ID: <20240312075021.GBZfAJPb5ZRBnNp3na@fat_crate.local>
References: <20240311151909.GAZe8g7SqDKRcP4XrO@fat_crate.local>
 <CAHk-=witL2fFR-FK_nt5TTLHKffueUQnv875-aDGUqn8O3+o_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=witL2fFR-FK_nt5TTLHKffueUQnv875-aDGUqn8O3+o_w@mail.gmail.com>

On Mon, Mar 11, 2024 at 05:50:48PM -0700, Linus Torvalds wrote:
> Let's hope my artistic merge resolution doesn't end up coming back to bite me.

Makes sense and looks ok to me.

I think this'll start becoming a problem when it gets referenced from
outside, see the respective example with cc_vendor:

e45964771007 ("x86/coco: Define cc_vendor without CONFIG_ARCH_HAS_CC_PLATFORM")

but we'll cross that bridge when we get to it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

