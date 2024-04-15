Return-Path: <linux-kernel+bounces-145498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F18A56F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D611C21EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3380031;
	Mon, 15 Apr 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pIukbNHa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8437F47B;
	Mon, 15 Apr 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196927; cv=none; b=uHGd3E3pQfJTtodqM7l7UjBgqhN7HAuuVOKVYq/mAkI80InTU1ewDLo9vZaGGugJua6u/vdsaHK5AVNvb21QVllmPBxpbexeydtwj20xz5a6Yo87a+z6fsF6HckIcNTgM+HP7fU6RI8BerDswxIleLY/xrutlhCEid7LsWjLJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196927; c=relaxed/simple;
	bh=/BGZa66OTjq9deqh1Znv9nfCC2KLBveMvqHZgba1FCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bMb/fdQBKw2RpGxVsYc93A+gmd5cyKjo/X4XIvTLb3GKPs9zdKPHjNzYoz/Lfkb5ew0G9NToLRQ2OhLDP/7/os4jOEJHrlFU+p8sckhf0iKXz4X0Bq68M64aX27KdrGptllNxsNqghNFaaufPE2bSqWqIFdru+UbU10tz6LpuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pIukbNHa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D08DB47C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1713196917; bh=v662RrsMqneLeLe6D1Sdsis1Ejt/Y1b5HbSUQwtNkOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pIukbNHa4VPK81NZ87bc5ZoEq7pEwTmv80ww3+YW/xltKBoqPfK+naBSCqGX18nv8
	 XjprSRdzn1V9v6UAs62J3dMuhYBoGbY3oA0emwew3pBPLsiciFZzvKCCn6KSxCtW32
	 0aNtuGSZmArvzNE0ZHZpeOVE+NniQmlUGds6lcbDCj3xA92+fxus3jJSPNjZmQ7DE3
	 Ld5w0iMdjNPues541zoe/9+LeP3An71n4poDvyGuV2hrYJzvO/DnwE+s0Bp8opuNqI
	 XKXC7VTVvoBBR4YBKWxP6SeYhRbCw6ISOydw3Kiu3Ykpy+Dbyrq8tavdelPUK7zilP
	 O6Cgbv3GLTiiw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D08DB47C1D;
	Mon, 15 Apr 2024 16:01:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Petr
 =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v2 0/6] docs: verify/bisect: fine tuning, testing fixes,
 build host, order
In-Reply-To: <cover.1712647788.git.linux@leemhuis.info>
References: <cover.1712647788.git.linux@leemhuis.info>
Date: Mon, 15 Apr 2024 10:01:55 -0600
Message-ID: <87bk6awr64.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> A quick series with various improvements for
> Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst after
> receiving feedback on the text or seeing people struggle with certain
> tasks.
>
> * The first two patches contains various fixes and some fine tuning.
>
> * The third is mainly a layout improvement that results in a somewhat
>   large patch.
>
> * The fourth adds instructions for later testing of reverts, fixes, or
>   newer versions. This was already hinted at; but during some early
>   work on Documentation/admin-guide/reporting-issues.rst to better
>   reconcile the two it seemed wise to cover this properly here.
>
> * The fifth patch briefly outlines how to build kernels on a different
>   host; it came into being after a second user within one week asked for
>   this. That also allowed the text to briefly cover cross-compilation.
>
> * The sixth makes users that face a regression within a stable series
>   test that series first before they are told to test mainline.
> ---
>
> Hi! While at it let me mention one more thing unrelated to the changes
> that came up where I'm unsure if the current approach by the text was
> a wise choice:
>
> * Should the document tell users to avoid mainline during merge windows?
>
> Some input from the community on this would be splendid.
>
> Ciao, Thorsten
>
> P.S.: Not totally sure, but I think this should go into 6.9 as this is
> a new document; if not I guess it would be wise to pick the first two,
> as they fix bugs.

Nobody seems to be complaining, so I've gone ahead and applied the set
to docs-fixes.

Thanks,

jon

