Return-Path: <linux-kernel+bounces-47237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A64844AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F31C21568
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657739FC6;
	Wed, 31 Jan 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jp/Dfi19"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430239AE6;
	Wed, 31 Jan 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739407; cv=none; b=BBacfr9786ih6RJG/zQXuot/F1miMFzHIPtPjrno67/I0SJ7ixYB+AC5HKrHr+2Hh6WbXnRloNQ6d8whTdk+EzVF1E2dTQeFUVnzzVL5t1OASKuh3JwCJW4oxyqaI5NURfNfFWxNphcZFpOvhZXmETyt+jcNh15uqtef+Ujj7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739407; c=relaxed/simple;
	bh=R/XixHzRmL0T5YVAQpEoTH89sD4NPDgeltb5zmNISRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Toge0k/pHMJbjp3OkHDOglu3RC8aCQoJxGLDxsjcUprmiRpVomFLd06YJ9gETT6hsI88p/gooPkM08iNHQW+q5Pi+HgwlPMHT+lP9XRhqvHf/cLW6G0N0mhloTNqxVMp+dPHO1xrGr4gSN5DgXzoQvVJTi7g7cJ+pv4NVeFdtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jp/Dfi19; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UaP7e0/xFnUox21quYuKQnRrWMG86d8f4dQdq/uGkg0=; b=jp/Dfi19gPUOUmEPG7CQh9UH2B
	hU08YzQBvtIFeMavgaf9k/O56rFCRonfIfw1OsdrprnEh+R3xxJhra3djTsnllsRhNJoVTySWIgiU
	fWhNyP59cNi0dyRKQz3ENYJZ3Trv6EEWzwYCu+MvY0sKT20usBUlWbHhgWIS4DJUd7IZaE3dGWpZf
	LxlwKRPznAE7XxYZIPkAl98n5kTkI5+qo+FqucZGkmwAUXcb9on2Pe/V4b01gpAGYfbp+c6p7zDev
	/yVUz1uAbBcMWEv1t+0sQ7RrE9p6Q6oAAlKowxOEslJ85z9ZnkYItFvqh1cQxO8TofazphVe9Kj4O
	VpKJNqTA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVIsr-00000005fbS-345v;
	Wed, 31 Jan 2024 22:16:41 +0000
Date: Wed, 31 Jan 2024 14:16:41 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH 1/3] init: Declare rodata_enabled and mark_rodata_ro() at
 all time
Message-ID: <ZbrGyWKOF1Ux9LT6@bombadil.infradead.org>
References: <7b5df1782e94a755b4a18733af44d17d8dd8b37b.1703149011.git.christophe.leroy@csgroup.eu>
 <ZbgGDlgrLhB8tcGI@bombadil.infradead.org>
 <20240130091626.GA3684878@google.com>
 <9e298fa7-a953-462a-96a4-56a1b4316a17@csgroup.eu>
 <CGME20240130174812eucas1p166f62549457fd188fed6ed72b6b4b9cd@eucas1p1.samsung.com>
 <30ddedc9-0829-4a99-9cb1-39190937981c@samsung.com>
 <ZblbuHLaK2_Xhff_@bombadil.infradead.org>
 <8b00f75d-a5ee-45a8-9ed4-5da26e4e1f41@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b00f75d-a5ee-45a8-9ed4-5da26e4e1f41@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, Jan 31, 2024 at 06:53:13AM +0000, Christophe Leroy wrote:
> The problem being identified in commit 677bfb9db8a3 ("module: Don't 
> ignore errors from set_memory_XX()"), you can keep/re-apply the series 
> [PATCH 1/3] init: Declare rodata_enabled and mark_rodata_ro() at all time.

Sure, queued that up into modules-testing before I push to modules-next.

  Luis

