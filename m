Return-Path: <linux-kernel+bounces-157813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2D8B1699
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3790B25EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A095816F0C5;
	Wed, 24 Apr 2024 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oX74QSnT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26616E885;
	Wed, 24 Apr 2024 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999350; cv=none; b=n+oBLEEOU4f9Ebd3qpLbQie/1Z1tlF7u1cgUAoXRC/ZCZ+d1HUDfiSUUfk8iCLea6eK2QiqAulwmQEuBDfW8HlkJjsnY2PKe3MgQcDZk8SUeTPpD7mmKWkS+dirMTgwfsZ/sKFARicfmWGpit9L7BRq03AY9F83kZcjOPv9EYqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999350; c=relaxed/simple;
	bh=SoqgKiPsjlfQQVdCnSt/8UdtE2eQVHk2pQpqV7bYkm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7ZMP5q6Z22U6CmEGUd1t107KRWMoCjplmv29pCzH6VB7Eof8ajtyxHwhWdx5p1bVAA0I/MoseVNGo/RQPI2BiRTJyP/Y/vzebQM2GSxXQWg3DzWyqTWxxPzcjdRMZIrzIPRiul2n9Lo2kJDPFn6dkXIgeJIckHKUhQfYEKmSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oX74QSnT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dwfj4VPEjqw9mDDnRZx4vOPhgLD9BZ3niFJTQJzmgCs=; b=oX74QSnTBe9OiRjSCvr/7kbl7d
	NkSGdybylOV3whKdAu6he/LUIeFu22yt11u/sc/VMEb0NNi/sC7NdCybLVfXqdoDTB6Lym0GkvBjt
	wG0PTF1VLjqdEsJPpOvaPXme/0BYO1UQFMamqAjAIgk6Z2w+OvILurmB897JVD66BpG3hzggG7QNJ
	zVevlgG/XCGCoETx7uuG6FH7LqNOc+Uh7e+/zMuKiRPjj59NV9v348jbXJCaVzaQEAXsCWEaiys5J
	GHvukj5h799I859CQ03nabUpCTfZURBBrQnPterFBxi1JfionYbYRwOcblf4Au9QJoV7Hhhr+/fDM
	obRCk6fg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzlWm-00000006I5S-03n4;
	Wed, 24 Apr 2024 22:55:48 +0000
Date: Wed, 24 Apr 2024 15:55:47 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org, ziy@nvidia.com, linux-mm@kvack.org
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy@infradead.org, hare@suse.de,
	john.g.garry@oracle.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 0/2] mm/huge_memory: couple fixes and one cleanup
Message-ID: <ZimN87OsXRdws49d@bombadil.infradead.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424225449.1498244-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

The subject hints at a cleanup but I decided to leave that for another
separate patch which I'll send next.

  Luis

