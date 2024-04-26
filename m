Return-Path: <linux-kernel+bounces-160193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613678B3A69
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A2A1C244B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225014883E;
	Fri, 26 Apr 2024 14:52:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867B13F43A;
	Fri, 26 Apr 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143150; cv=none; b=XxUjZMokLmiS5OR0SdIxsGKfxKV/3lHFcr4m00JRAoF4aE93LhyqMI9p4Mui9cfrzvB6iVZvn0ge4NkBEXnj8szoDFwSvlhOIlFneZJUglKQ7warqDB4Xh1ZCKFPVTTESHici6xt9Ii17OEq31EhbFbGdNf+7Y9iWT848TDAWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143150; c=relaxed/simple;
	bh=vm7uE0ygsHjc1lkXNtHN0seN3qvRdYiwxzxP9waGNUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD8pEWQyDJz9hOEgUdNRxWVn8y1C7SipSG7nxD+W4gchSO4Jbk5Txu0kHa7lUmdoFFwb3k2K408kqYVBYOMBt8cHaNHFQ5VSg0lhae61FTrZlGWbUBI0ApCgbh9ajrCNAHLEqWb+Msz8SfFx/+dYtSbvdBL2Mwowhb8Nh9CPNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1989DC113CD;
	Fri, 26 Apr 2024 14:52:26 +0000 (UTC)
Date: Fri, 26 Apr 2024 15:52:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Avoid recursive loop with kmemleak
Message-ID: <Ziu_qOmgnWRdAByp@arm.com>
References: <20240425205516.work.220-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425205516.work.220-kees@kernel.org>

On Thu, Apr 25, 2024 at 01:55:23PM -0700, Kees Cook wrote:
> The system will immediate fill up stack and crash when both
> CONFIG_DEBUG_KMEMLEAK and CONFIG_MEM_ALLOC_PROFILING are enabled.
> Avoid allocation tagging of kmemleak caches, otherwise recursive
> allocation tracking occurs.
> 
> Fixes: 279bb991b4d9 ("mm/slab: add allocation accounting into slab allocation and free paths")
> Signed-off-by: Kees Cook <keescook@chromium.org>

For the kmemleak bits:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

