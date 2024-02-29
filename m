Return-Path: <linux-kernel+bounces-87606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0286D66C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC851F24499
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20BA6D52C;
	Thu, 29 Feb 2024 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hJG8CwZs"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E66D50B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243681; cv=none; b=dl8AZ4VoQH0j2xJQIzOBEHTQfG0SzKfz57STQw6I+mTQahuULaW7FsgCDMCwwtMa6ZxzRknUJioGYbJ3B36XRQiV5VO25VXr2SATvp9C1YiEPykAPPKXzFV1TXz3sgaRGX+p+ugL4onwPA3hF0b7SmpyP0OjkVzHIh0Xe7lbOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243681; c=relaxed/simple;
	bh=maQigr3mbZaYTKN0yw7/tVw2rKFSCT7IUp4mO6xJHWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bH+Ho8pABozck4Va5lRSJsY8sAJ/XW95XFlIv/vtI1ne+k+FDaSLGxh0sY+EKuCZzNlGCOUl3ZFAWJJbMVqx9a9yF3oshHGTV8PZI8XRSSGHXG6ushA+N+RTxGPnNLIWekWfUD4tF4hYkrFIIAENQcYhmkmE7FqmAjj7CtIB6Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hJG8CwZs; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 16:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709243677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNGIwV9X7LvXUSTzJEP/vvC0jsvvaqoXTZbcbIniXd4=;
	b=hJG8CwZs6AyzZ6I3dWjFYpju8pNArxrH8ZRjX9tfyj5c8vckb6LA2F0deapPIisQybc+ft
	n0NxLpYg1sRrhbjC3HIoWg+eQYPhD5Z6+vjcX+Mrm0osS5zSW4dWgbuYVlPzKSEEvu/EmL
	1/Hrpe0ANiF9vXhvtxH/zSigsbu6joY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v1 1/1] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <sdjfagrzk5p736wzeqdfhzxkivtg3rnhhtt3rh672fbuzxc7ya@icgcqv2d3cr7>
References: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
 <170924355200.1509550.2313379734413200100.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170924355200.1509550.2313379734413200100.b4-ty@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 01:52:34PM -0800, Kees Cook wrote:
> On Thu, 29 Feb 2024 22:52:30 +0200, Andy Shevchenko wrote:
> > The new flags parameter allows controlling
> >  - Whether or not the units suffix is separated by a space, for
> >    compatibility with sort -h
> >  - Whether or not to append a B suffix - we're not always printing
> >    bytes.
> 
> I cleaned up the Co-developed-by/S-o-b and applied to for-next/hardening, thanks!

thanks Kees!

