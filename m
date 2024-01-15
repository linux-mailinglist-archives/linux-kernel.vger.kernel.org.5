Return-Path: <linux-kernel+bounces-25665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7F82D452
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EEC1C20DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C66AA4;
	Mon, 15 Jan 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="duDvVlZi"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54D63AE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hJrN8gZT/HYpbOMm+1QDv4p0H4Brjpdl0colo6KhxYM=; b=duDvVlZiKsVGlGusgzwGo3i5/+
	6De1nttWvMKpJbVZom4lqFwcwDbyC5+iGfM105rwq++rkD56TWmKxcPshaVHxdtlcnkcHl8si3eee
	RNXzRjFKsCKP+B9URGDky1Kaw5+W86dPKGjiXuhzoJ7hyCBTNSvbxoMaUy6vXfDrI6iX87jhTlW8y
	1hu2LmlYMnXaSCHCv5UgBNuYX51zf0hhzDKWeUVWRaEu5xVCFwM2Z/e0MtIbz3I7U18B3z2k+UBem
	0TLskF+m9jidYpZVGFgxtTXpnUBiZBv3xRz1BkG8mLIkXjZxCdcPfUC2wqFd9KwzFWZqX6yK+92Ho
	nbMad+JA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPGro-002cLQ-1N;
	Mon, 15 Jan 2024 06:54:40 +0000
Date: Mon, 15 Jan 2024 06:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Li kunyu <kunyu@nfschina.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] utsname: Optimize clone_uts_ns()
Message-ID: <20240115065440.GF1674809@ZenIV>
References: <20240115061127.30836-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115061127.30836-1-kunyu@nfschina.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 15, 2024 at 02:11:27PM +0800, Li kunyu wrote:
> Optimize the err variable assignment location so that the err variable
> is manually modified when an error occurs.

First of all, this is *not* an optimization in any meaningful sense -
compiler is perfectly capable to shift those assignments (from either
form) and choose whatever it prefers.

Incidentally, it might end up lifting the store out of if - it's
entirely possible that
	r1 = v
	flag = (r2 == 0)
	if flag goto fail
is better than
	flag = (r2 == 0)
	if flag goto l
	...
l:
	r1 = v
	goto fail
provided that assignment to r1 and checking r2 can be done in parallel
and that's assuming that it will figure out that branch is unlikely.

Readability might be a good reason; optimization... no.  Leave that to
compiler; it will override your choice here anyway.

