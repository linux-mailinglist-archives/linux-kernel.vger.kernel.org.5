Return-Path: <linux-kernel+bounces-45250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C22E842D95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8261F2408D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D471B4B;
	Tue, 30 Jan 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="g/karfMa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8371B35;
	Tue, 30 Jan 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645897; cv=none; b=HtCRJcDQ1EBN3n6ARfHx3QcoVCNlxhRAKKoFcRYVLxBUq4goH+cLJjL788Lb6fWN+3YnNfEMarLSCUNNLDjJmU0R4a5l9T3XjqVHQV2Nn92UEDpeuIcBQaRiGLjkuFavPWT7nywLRsxJ74MFUvbuchi2Bo3YJw99HbTm4GrPBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645897; c=relaxed/simple;
	bh=kw4/vZsQ4igABvQM8UwIbtkB/TnHdIU/pnO5e+cNS8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EpjJRm61kUwrzxssde99KjDX34wRr9ZsOqHuUX0moiyJoWct7/6Yvl/opKeBIgBFrABDpds9gOA2GX4qkRgOnXuhZEC1Lgg9Lj8xu2fT3CJWp+4qmcCdScaoZPWJg3z1uIjb96FCLcFAgKkFv/ELtG958bO9ydMRpbvkLNLK/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=g/karfMa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E576B41A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706645895; bh=9KysNAjR2JJqZckLeN84dmIjHnc6rN2+vXgE45980uU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g/karfMalEzLnFfjmYg+HXbUBUv2mpeqvy66J883uo9ZS4xhTNI19ANDbgGhXNt4E
	 qyyje5/F3tftwwKw67XZXbIXuJIixYSm+yAuxgR7ETaeNkun9o1xR//ewH6RJk6pMf
	 nHqNHB5h5fdWDVRQcI8c4dBwviuXjkJI+0+c7ByB0RRUTY1at7XhEqXweYVU0hn0uR
	 HR8ikFK2kmUIu2GuN8NVf6TKHXeJRJ5ZRPHJrY2QZaJZMcm0cdiVB2O6KoxuJaxn8K
	 CG5qwT3CD9I5CWpS6RsFHPPbYKw2B30GNXIxtojAO3XIbw5JAcKgMSF5P/J0ufiohm
	 pjp3598pgy8Hg==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E576B41A47;
	Tue, 30 Jan 2024 20:18:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 linux-doc@vger.kernel.org, Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] kernel-doc: document object-like preprocessor macros
In-Reply-To: <20240109140345.3344094-1-daniel.vetter@ffwll.ch>
References: <20240109140345.3344094-1-daniel.vetter@ffwll.ch>
Date: Tue, 30 Jan 2024 13:18:14 -0700
Message-ID: <87il3abmnt.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> I had no idea this exists, but Randy pointed out it's been added quite
> a long time ago in cbb4d3e6510b ("scripts/kernel-doc: handle
> object-like macros"). Definitely way before I started to write all the
> drm docs sadly, so there's a few things where I skipped writing
> kernel-doc since I didn't know it was possible.
>
> Fix this asap by documenting the two possible kernel-doc flavours for
> preprocessor definitions.
>
> References: https://lore.kernel.org/dri-devel/dd917333-9ae8-4e76-991d-39b6229ba8ce@infradead.org/
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  Documentation/doc-guide/kernel-doc.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Applied, thanks.

jon

