Return-Path: <linux-kernel+bounces-37061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B583AAD2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C43A1F22D25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610277F07;
	Wed, 24 Jan 2024 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sl2lHko6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA43199D9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102451; cv=none; b=V6ht+QZWzrnmO9ZifawO6Jsz1NlxrDRITt8N/bYXTx+lf9vH7P2hmQ5s2XqkFLMsrsgUisna0rU/p0PKnTaqgV7wzk/gNQw8k5VtT+U9yT8XoWc/J9/CTei6rmxFZdDehWXCziHDTIOx+e1E1dlAnCPVnIYVkxon4b+x+ntzmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102451; c=relaxed/simple;
	bh=JcP8nwhiTGb9FtqCA9V4zTWJWYgfq5+axcCA8e7wbAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCJXNtWwshXMfdFf23eq16XgsSmJRrdQL0td5Mbcli39me8SloCXpjWNFSZGoAkx3xZMh4ek8YWZs9P63qCgyiC9ZijxvvLdOHIp0G4SV0iDaeHPmadPYILyaukBOt7A5FfKH9mIvcyX0DD2U+QsZ8maEwtufSuntqCBiu7ef4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sl2lHko6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pOB7vCAKoihq9Mi/fz7gX6tPYUodOZN7LLoA5qHlBxE=; b=Sl2lHko6gXK8czMgyEaf531wdJ
	HsCaUuf7W0LGVqJ7ZC6L9C/IS6Qhl59hAQOMC/3/3rnZ7tMwq+ieY8j9T+shopMX6WjnP/rFF6NEs
	+Z95aQk++UPxUdKtVAOTNvDNMTBrjp3q0Bdjx9vCrOO1LC21Wi44dOjzEkxsi2jz0HxF6Xhj4XqXw
	JWcTseOe+J0UljIgoM7VHxTLEQ8biAN+zzoU/GY/5/4/PiAS4c5QcpYGSSodf62DKv+I7i+Rm7NqQ
	PIlTBOF7zk5ZBiORmT6pD/Ldo4P1QenQ8DHqiyRU0ZBI7nA3r+Y+0eXQ4cBw1SjuEiAxVEA2ouThH
	POkphRMA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSdBO-00000006jJo-3LOI;
	Wed, 24 Jan 2024 13:20:46 +0000
Date: Wed, 24 Jan 2024 13:20:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH] mm:vmscan: shrink skip folios in the exiting task
Message-ID: <ZbEOrim8tjMXB5os@casper.infradead.org>
References: <20240124124308.461-1-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124308.461-1-justinjiang@vivo.com>

On Wed, Jan 24, 2024 at 08:43:07PM +0800, Zhiguo Jiang wrote:
> If the shrinking folio is belong to the exiting task, this folio should
> be freed in the task exit flow rather than being reclaimed in the shrink
> flow, because the former takes less time.
> 
> If the folio which is belong to the exiting task is reclaimed in the
> shrink flow, such as the anon folio, the anon folio needs to be first
> written to the swap partition by swap-in in shrink flow, and then the
> corresponding swap folio needs to be released in the task exiting flow.
> As is well known, releasing a swap folio will task more time than 
> releasing directly an anon folio.
> 
> In the scenarios of the low memory system and mutil backed-applications,
> the time-consuming problem caused by shrinking the exiting task's folios
> will be more severe.

What testing have you done of this patch?  How often does it happen?
Are there particular workloads that benefit from this?  (I'm not sure
what "mutil backed-applications" are?)

And I do mean specifically of this patch, because to my eyes it
shouldn't even compile.

