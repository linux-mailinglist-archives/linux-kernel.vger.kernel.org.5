Return-Path: <linux-kernel+bounces-45322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8AD842E81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577911F2513C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9AC762E0;
	Tue, 30 Jan 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W8Z0Ly5y"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491D86D1D0;
	Tue, 30 Jan 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706649136; cv=none; b=uuB7bDE1ayWploTWdjCQ0/B89m1na1245r+6afMGjPM1n4PVqVkGoUHfNIp13Kzntl7E8Z1A8WQseT5XYqCOAk+JFwwYxocvR3Kp6aHFuuOZlw21LBCMDMivIba9rw7wVeVY+0teFoK6Nxgsrqk/wHqfbkyTdUSiVIBp2fYM+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706649136; c=relaxed/simple;
	bh=no+za9y9P/8+260SExAlGKhL9xW7ZZB8GrD6eZTJ9m8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HPzJBCHd0+1o+kjpMuF5epSMPPHRtZen+j1mbQGWhY+oYibBrfxbnI8y4SjGko2dFWzQeebeFgXuCNATxvH+vZsRvHZsYsA+s/fSIjQgJaQLa6gQkAbAg/bYyMHjXp+zmVv0vmiRaJqwaTIS4+FaX2OFO03N65g5fI3C1qdTo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W8Z0Ly5y; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 782BE41A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706649134; bh=feI9SeP4VYJn59VIlhZ3NpsSzXCYwJA8/l0T6od0SQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W8Z0Ly5yt4RYjEDOCpdUXGYbFI66/1W3OxeDuXP/NqYb/q8wAKAIri6F6kOq+ifsv
	 Y3hhcXbpfV2Gil0dKAsjKxxKJ7AnAtDy0p5AgwPK54hSZ6VgBPg8TqiAMnhuY8Ssol
	 zOuY+KR42NpjE9HLQmGXXW/fjG9aKVwZbijxOYMRi4zyIhvvr4GJs1zcqW3ODlXOfw
	 WvHi2zqJ3ZDykN9vgUgVtfJsnAet9u4rPbLSBOZk9bS9b5K0SEQcl6Cd9AA295hIDI
	 nqPmpG72sfyFvqQiRmBrctjCbUZrR0yxH7Kel0isk+zGn7W8oE1VbPT7n4IJ3EtSWk
	 TUFSGldb4ejsQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 782BE41A47;
	Tue, 30 Jan 2024 21:12:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Krishna Kurapati
 <quic_kriskura@quicinc.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-doc@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v2] usb: gadget: fix max_segment_size malformed table
In-Reply-To: <20240128045347.25909-1-rdunlap@infradead.org>
References: <20240128045347.25909-1-rdunlap@infradead.org>
Date: Tue, 30 Jan 2024 14:12:13 -0700
Message-ID: <877cjqa5le.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Sphinx reports a malformed table due to the table begin/end line
> segments being too short for the word "max_segment_size", so
> extend them by one more '=' character to prevent the error.
>
> Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
> Text in column margin in table line 9.
>
> Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> ---
> v2: s /to error/the error/ in the patch description.
>
>  Documentation/usb/gadget-testing.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon

