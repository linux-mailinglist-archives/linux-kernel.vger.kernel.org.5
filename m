Return-Path: <linux-kernel+bounces-60045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBC84FF11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E021C22A21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18187210EE;
	Fri,  9 Feb 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfYPjTW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE418623;
	Fri,  9 Feb 2024 21:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514899; cv=none; b=AnsQR5fcpDAeDxCr6toTiNq7KTqMQYXXDipnbcLKcEuvJv8/mqxjsDCk1ARnFzFcT73nKuD4VjZoRF8I5cGQyPxESO5nCgGHgyd5l8H9RDsK690FARb9cYjHJ4wbYB63HmcemHASabO3N1mgySzE98PWMOj3sxVZCLxkdCe1J0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514899; c=relaxed/simple;
	bh=OMXjOqcj0vyMRFHFb4/8FrDLB9tXXJa22mR0yzx/u/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOL3zarEykag+kdSi8Ab/e4IvPs1PoK7yJlVYt4Zr8uxh3HKCT9wjCjO8z54kjs85OxqfclQBxLx9pDopJsv9J5UnqSon72uuLkiTO9YRhTcOfUR93ctPNVC82Y5oZyZ93Y0iW2iOZsj36bPaef8/dhQlxfKaVKsVOjeR3CZj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfYPjTW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC33C433C7;
	Fri,  9 Feb 2024 21:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707514898;
	bh=OMXjOqcj0vyMRFHFb4/8FrDLB9tXXJa22mR0yzx/u/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dfYPjTW2FTFs2HsPleKyYUo/LLjuxnWefYySlI7JTawuxGy3k/jqvZ9h+PQAHodKy
	 R0z5pufwWvBVO0otzT0KkqnCGwitFOQ8bNn0jqm1E+0cpMUslRkFgD78wst2kcWMCq
	 pFsdGbzbbXEhLM1XoOIn2fRXePtupfL5J42Xh02HFWvvPF1kZpjWmq7JbzG4eyMUu1
	 gYFPI/vmudr9CsKEb9F0n0Pv4gMo6wntMKU2XPa+zyJYc9y2DmjnjLBfTzXf5D2457
	 EX+Nuj+Tmu3SwBpwmFRXB4U1b8GoKcHPjH/oUOCJsJRIWpAHzhS6hsBKpfHrsySxyJ
	 Els8UlIXbucuQ==
Date: Fri, 9 Feb 2024 13:41:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ethernet: wiznet: Use
 devm_platform_get_and_ioremap_resource() in w5300_hw_probe()
Message-ID: <20240209134137.429a0c44@kernel.org>
In-Reply-To: <46f64db3-3f8f-4c6c-8d70-38daeefccac1@web.de>
References: <46f64db3-3f8f-4c6c-8d70-38daeefccac1@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 14:28:17 +0100 Markus Elfring wrote:
> A wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source code.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied thanks!

