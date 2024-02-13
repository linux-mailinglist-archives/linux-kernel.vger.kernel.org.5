Return-Path: <linux-kernel+bounces-62866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9588526FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B07C1C2408E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC271B7F3;
	Tue, 13 Feb 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T07/+ukb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721E1B59E;
	Tue, 13 Feb 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788157; cv=none; b=VGv+pZecfWKUI2z8NRZ+VRIgtnbveW7kNu8a2VQ73+aulAt0zlQrtDD6AYxIBhQLsYhVmIWXj0jtJ3qaCXkET+emAQNb2GRpFqImvr9qokN13GQLtMz3rBsDWyTZaNs3d4ubt9TRhBPNZ6YmGxFnpNI6pmnjOUgDLHU9EhjRsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788157; c=relaxed/simple;
	bh=aKWoMQBhztJhzWgzX1R5/kODWr7ReQymBJbcPq6O0LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkz43uUP5r82lsziPvE2ZQnKz8xOsySPNzebQhNXPug/I8R7MHxnWV7zTo2J0o4PKfDUfJ39X5h7XrUF3dyc6h0QMvri2Kw3BjI8zZ+iLXy1wIhfRGBJA5STIS4n6tNGpcKt5SWpQAU+ikLjTGo4hwuwgWvfqbwx37JPULdQOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T07/+ukb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EB9C433F1;
	Tue, 13 Feb 2024 01:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707788156;
	bh=aKWoMQBhztJhzWgzX1R5/kODWr7ReQymBJbcPq6O0LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T07/+ukbWJEp+zvZ0dmq4l5F94R6XpAQYYn+8+Xh8T6V13j5Jctwr3sRQLd5E6XAz
	 KlRexcFuMREgNQ1Er7gTkagJdJh95kEFwKPHvTZUbNAsSikyAlumifKrGhKwQ42uCU
	 q6grdcPlGlXoD5H18jndHgGkKyh8wysca++JR8TDRKxLGe7OJ391KS/113oF9HBtFi
	 Rif10WyJwBAGrisT3Y1Gm0d4NsGwZP8QSCWEZqLhM7oO1TNho6J0htog/ZDTLnQZ3g
	 gCDmivo+zMB+0/4TyKMiWIERFO477UmibH4sqsXzXifnedjhWHLwwPhVgh5Ffw1G/o
	 Xq+pXz+Oabslg==
Date: Mon, 12 Feb 2024 17:35:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Dan Williams <dan.j.williams@intel.com>, Keith
 Packard <keithp@keithp.com>, Miguel Ojeda <ojeda@kernel.org>, Alexey
 Dobriyan <adobriyan@gmail.com>, Dmitry Antipov <dmantipov@yandex.ru>,
 Nathan Chancellor <nathan@kernel.org>, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net/ipv4: Annotate imsf_slist_flex with
 __counted_by(imsf_numsrc)
Message-ID: <20240212173555.576f1d59@kernel.org>
In-Reply-To: <20240210011643.1706285-2-keescook@chromium.org>
References: <20240210011452.work.985-kees@kernel.org>
	<20240210011643.1706285-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 17:16:42 -0800 Kees Cook wrote:
> The size of the imsf_slist_flex member is determined by imsf_numsrc, so
> annotate it as such.

Acked-by: Jakub Kicinski <kuba@kernel.org>

