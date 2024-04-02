Return-Path: <linux-kernel+bounces-127242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54389488B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAC61F21ADA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0536FB1;
	Tue,  2 Apr 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V5MN0H9A"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626F10E4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712019475; cv=none; b=kvH2WiziWQK7x6UByDVl3ulXOOwNyu9MYaKKGpIQa6DL5vuV6qvOs8VOGRXfyslW4Ed31IHQFBfVkJG+OBXoL5mFYd5x7OLCRVubKF90Niawo1JtqrPjR4RyUZOG10enMXXXz18DNYeRAPAUjb35lCV4fc9XsAHGnkhDXl+hAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712019475; c=relaxed/simple;
	bh=mdX/zocFGi8Z/qg02EaM5C4nmq6umUxIBi5Es44T1RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay/MIe2DY6Br6flatVCCcrvC4YjmqJogQylKyBcrWaHpye5iPWSDTrN1wTfqBdib9c4UKirzhRrJusU1ds0BpB9kMP7VU41pJIwlGU0sQ2WuHimUg1ZKabyZ01EAaRciwihmhiUIlbyG37PV3nxaPKEHS5pwmhR3epquXKnk5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V5MN0H9A; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=suK68QcHJYTLzDpzyhvm9yLtrwLoePi2gZr24hTu5zc=; b=V5MN0H9AvSSw0EyKTUczgrq8w2
	DnGO5vK5wCWjumK8zm143W+JqNDbEEndW6W11OEHS/VVX22te+4VqGdPSlgroN7f6ZjrkBXvDjPPL
	lTDW01rDeUm5+8i9Nj/dGNM93z+XoC3RIm0UTVlBxCtnrE9qweJ4a5gPcx04XhY+rXzSuhI8Vr//R
	X7SOVBGSsab1CnZoI+GmEjTDkfGhKrvFzz85DcD05jecqoce8SsS3PYJyzmctLP195txLnxR1v9j1
	DjP62f2Z0aqTW0Xlmse+JJ/YcW09OuO+LxpkOa5CLUgEOuHYmCUm3AxQW/rkImWcoWClxQjesnPiJ
	nos73Krg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rrSTG-003qhS-0e;
	Tue, 02 Apr 2024 00:57:50 +0000
Date: Tue, 2 Apr 2024 01:57:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH 0/8] kernel: replace seq_puts by seq_putc
Message-ID: <20240402005750.GD538574@ZenIV>
References: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 26, 2024 at 09:45:14PM +0300, Maxim Moskalets wrote:
> Using seq_putc for single characters is faster and more appropriate
> than seq_puts, since only one character is passed and there is no need
> to use a more powerful and less fast function.

Could we simply do this:

static inline void seq_puts(struct seq_file *m, const char *s)
{
	if (__builtin_constant_p(*s) && s[0] && !s[1])
		seq_putc(m, s[0]);
	else
		__seq_puts(m, s);
}

IIRC, __builtin_constant_p(*s) is true when s is a string literal.
Works for recent gcc and clang...

