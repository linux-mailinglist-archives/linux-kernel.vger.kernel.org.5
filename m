Return-Path: <linux-kernel+bounces-141629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9578A20E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5A41C20F25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0653381B9;
	Thu, 11 Apr 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5sgudyB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB8D199AD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712870881; cv=none; b=HqWSXTIOUQE49qCpJwgF3hxFLNJASsNSp+DVR5If2Nk2eVPeftD7FQuGou8cMaZvTy7GlYDa88Fv/hRECJWPphF4VBbif2+jDM7khuNko6Fa3jz+xT1ajhGk7OQWVs8JT/FTaIMBcX+pfolZZ3LMaBkKVctVxxO8B6LCkAYeD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712870881; c=relaxed/simple;
	bh=Sa6qmjDsyUuvpBXhaxanG2UFhluRlyv65wd9j2Xu9wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTerPmanK3CMjt/r7R7w7EuFdlzRPDiBKcMqK5kWInmIVjHECl+6eIOB9jMb71ThJ88nkmoX3n4RfbrNLzLJtk2eHebQobUS65qsBgn+pKeEvg0dsW/sirWyNCrQ820ZIac0CzqdVcNcduubMr2++9IIoXTKYIiDglrcNR6AM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D5sgudyB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1tQ0lOIHbz5US+vfPM6E5TPrSdCoeYL4E06YeAvQ17s=; b=D5sgudyBnVEWp5Tvvr6jUtqqI1
	azQxRvV2ZzrQI4RjhaYwh8Amq3V/fcKd5eO55nAHPF30t972JaZpQp1HbEy99n0Usf2x7b9S9H6Le
	D4noTgL2drl3XfPVAho/3QKYQuzK8KUwKkzsZ5NkdFV3xgiEYmN0UAdd+h30keRLYngYG58LKLwqg
	GxoRaL4nAkviVNqqYNYtIW2ZPOx7FiZwJrT5x8rkrYwKTkkzc+6hdTI+tD3GLh4lTI9aaV5kkjrv6
	XKqXREhQFcWmvDpMtwZIUohklBq4brkLR040e6S4OY5QGM7NPqwlMZGH2E/X7z4xgpatpBzHFpVbu
	+EPajBPg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv1xc-00000007lZf-0YzY;
	Thu, 11 Apr 2024 21:27:56 +0000
Date: Thu, 11 Apr 2024 22:27:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhhV3PKgEX9d7_vA@casper.infradead.org>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
 <ZhhSItiyLYBEdAX3@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhhSItiyLYBEdAX3@x1n>

On Thu, Apr 11, 2024 at 05:12:02PM -0400, Peter Xu wrote:
> The question is whether that's intended to make it as complicated.  For
> example, why don't we check anon_vma for anonymous too later when prepare
> anon_vma, however we do it late for file memory.  AFAICT there's nothing
> special with file memory in this case.

Yes, it's absolutely intended.  If anything, anon memory is the special
case that checks up-front.

Congratulations on adding additional instructions to the common case.
I don't understand why you persist with your nonsense.  Please stop.

