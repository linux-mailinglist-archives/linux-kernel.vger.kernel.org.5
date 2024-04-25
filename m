Return-Path: <linux-kernel+bounces-159165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1CE8B2A29
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C771285D60
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF4153BC7;
	Thu, 25 Apr 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bo9q4Ldl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB712BF28;
	Thu, 25 Apr 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078323; cv=none; b=sDhmg744UlSTuTIDH9cm1ssHJR4I4VswgIvVtgXXP0iJVjiM0SRu7UQ3D04P6lOW6NUAQG4rz8DNd0i4U2pRxb6hwyoI4sAJZiy3BPsHjjGInuTdo7Ng2DwgxKhE9eMHoJbEqW9vVbJdxfobg9W2uc+A/Fa0p+ybVfotQyp5q8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078323; c=relaxed/simple;
	bh=cFdB9HVYh7TvLB545AwLixKDtms5Knk/w+nGJNJ4lC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3rG4c/b2M49zwsJlV0myuE7CdPkVOGVn6XgWHPXFDwjWL/rYFY3pCz4Qo/KhKG9vUGTVQM5SX7Owl+wYsASs4hXT/WWOA1GDBYUjkB0RgOzzSKF3YaBt6AH1UJmnTovmMxZXIhBXeu603m2+Lp7i71aPbLhKjkCsRvzDIl5ntk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bo9q4Ldl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hJnGKlFsEdNJjEDM4XvaGQLENUcY5zQAR7r5FdpupwQ=; b=bo9q4LdlCZLTTK/4zwHgn4i/vy
	9RXgMPtRYqp2esiVVhqS/MCI4NYp7dVSgNn+uDvu6h5imZjgBh7pv9k2U0GpJu9pH7rh960TsMToE
	gNwAye2hN90NsgGPxN/p9AiiVjtZMZ0h3hhpbDQ8CR9TRtKQMj+3+pQTe5BNgqPgvTr19LyRNr9i7
	JFVymDZ/7tEk9V5ErQGkkUjjdIFTC7zFgiC4IKqy6FPu9BaIBnEkxYt3bZDKqQ8k33qj8l0fU8mEi
	JDQ9hOMTmNHG5QY5brxdSzvQQWbdYMwh5StdPAiOGLBx0gNFDO7Ont9NVBcjAqZJ8f2rmoeTGrZ67
	7JIJSbgA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s064S-00000003mfl-3Cuq;
	Thu, 25 Apr 2024 20:51:56 +0000
Date: Thu, 25 Apr 2024 21:51:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <ZirCbPR1XwX2WJSX@casper.infradead.org>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>

On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > The /proc/allocinfo file exposes a tremendous about of information about
> > kernel build details, memory allocations (obviously), and potentially
> > even image layout (due to ordering). As this is intended to be consumed
> > by system owners (like /proc/slabinfo), use the same file permissions as
> > there: 0400.
> 
> Err...
> 
> The side effect of locking down more and more reporting interfaces is
> that programs that consume those interfaces now have to run as root.

sudo cat /proc/allocinfo | analyse-that-fie

