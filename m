Return-Path: <linux-kernel+bounces-165234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295CE8B89EC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7741F2200E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816085922;
	Wed,  1 May 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EraFYfOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C328526A;
	Wed,  1 May 2024 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566102; cv=none; b=c0nHW1g9cz5r+CJqn2bYxYA2jXa4b5wpGBO+ArOuXlzoHyMEpZmzkwxwn4O/So30dATZ98W2Duu0Jdzo5rRUwfXRiPtCnBmc3NeUcfkF4bEh6VzXPXerRaWdbwYLm2CxAJ1ef7huUWBDXwNDRGLSN5xVl12iJLlodeem9zwQ1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566102; c=relaxed/simple;
	bh=NLGmvpuGq6M4xI0VpYsigWBLG+MQqgRSX4z0hHktlOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBtcUk6Vnrs8V5HFYZIoCuILxL8wWa+r9Th9UhohJCU4JXEPBDy985sYzKWUQOx4bgHzc3gos6Ll5wrDGvQ7QiY2UOa/Xp/uWeqES+d/AGb6/pRErUwltpwLV22HUUp5hjl/3AG2q//nKEwBXYk5K2BhrGk+JeudDzUgZd9h4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EraFYfOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7DFC113CC;
	Wed,  1 May 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EraFYfOb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1714566099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLGmvpuGq6M4xI0VpYsigWBLG+MQqgRSX4z0hHktlOU=;
	b=EraFYfObXaR9macsmFHFX2GTuUdbi9YRcJxHR+2tXHAOHELXAFLXpf4NadSp1eQiu5FXpJ
	dsqYup/TraeY9Qb9yAnAqBGOxWMQfBoIXvuzBYrPCdeoEgJSheumcqsJ4EMcPjlkW0G2U1
	cgju7ZbAZmQ5wZbZ7m+oO7Dcg1+UOMM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0cf47f87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 May 2024 12:21:37 +0000 (UTC)
Date: Wed, 1 May 2024 14:21:35 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Aaron Toponce <aaron.toponce@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] random: add chacha8_block and swtich the rng to it
Message-ID: <ZjIzz5Rdkc8kxo4g@zx2c4.com>
References: <20240429134942.2873253-1-aaron.toponce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429134942.2873253-1-aaron.toponce@gmail.com>

Hey Aaron,

There are probably better ways of speeding this up (e.g. my vDSO work,
which should be coming back soon) than just removing rounds and hoping
for the best.

The problem is that there's extremely broad consensus that ChaCha20 is
good at what it does. There's much less so for ChaCha8. JP's _probably_
right, and it all seems like a sensible risk analysis...maybe...but
also, why play with fire? Is it really worth it? I don't think there's
much harm done in being really conservative about all this.

Another consideration with the RNG is that most everybody else's crypto
relies on the RNG being good. If some consumer of the RNG wants to use
single DES, so be it. If another consumer wants to use a cascade of
ChaCha20 and AES and Serpent and Keccak for something, okay. Those
aren't our choices. But we shouldn't prevent those choices by weakening
the RNG.

So while it *might* be kinda overkill, there's also broad consensus that
what we've got is *definitely* sufficient for all uses. At the same
time, it's still pretty darn fast, there exist other ways to make it
faster, and I don't think it's /overly/ much.

Jason

