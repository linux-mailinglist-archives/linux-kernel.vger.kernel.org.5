Return-Path: <linux-kernel+bounces-54077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB584AA64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7761F23D1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B57E482F9;
	Mon,  5 Feb 2024 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iam+Ru/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBC4F888;
	Mon,  5 Feb 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175035; cv=none; b=AXSpwPNwUdZPO6luz2r2nodxZYFNrdRRkVlzpM28UHCj2ctseUaVx3ihSbxyByz7V0jU6sr4zsfx3/Nfu+Hz6a3rranylv2Yos1M0mBxtgtlrOZi420mktptOsX5RYkN1UrkNvGy00bp63GvCgc04indXZz9tqihP/lExlelm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175035; c=relaxed/simple;
	bh=iZ52MV6wk4qEUXCTFm8uFjRsoROdS5KKTIS+DxwKGzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brQOpxj5xGT/soPGF8Or6pdb/5rJC4G1B4lnmT0+aQtD3qU1/rAP7KRUZcFIV8qCAYhFyJmpp/fXdNR3hJSVj2WIM1ishLruUW+0MiYJoDuhQzEnhNnPRVu/sTPaC8NL1n89FE8dlc8cJew1YV0kaL313G6rkmYlTKaHlcNBqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iam+Ru/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77236C433F1;
	Mon,  5 Feb 2024 23:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707175034;
	bh=iZ52MV6wk4qEUXCTFm8uFjRsoROdS5KKTIS+DxwKGzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iam+Ru/woLHD2F6Jid7zi1R1F2IQDBUyNrxNXpy9uZa/CnW1S4Q9HPNy7Vp/anVVi
	 dzRmxhM0N+8Eg9mIU35L5K7eLCRQpvttG/SUfF3sfj3aSX0fkbRQj9NU/t4JGxyHzz
	 elT4eLotyzBl7lb7Q4f/xdosbC1VF6F0D/0Xg7Ih9tsuBlXBFh9YdcXAeureje/X+A
	 rGlIW/JgKTV1r+fFhdT/pMXUCoxDosoMRw5/kNXKm88Hup6t6fSwqzBHq9FVlC+tIq
	 Z0OrFu4bUoL8Uyjidh6ASE2GLwUYY3YsGDZgprQ9juPkV6Q3qvpyjHaG91jLE8FAcC
	 f3aDuvBDXcdCw==
Date: Mon, 5 Feb 2024 15:17:12 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Message-ID: <20240205231712.GC2220@sol.localdomain>
References: <20240205090854.make.507-kees@kernel.org>
 <20240205091233.1357377-2-keescook@chromium.org>
 <20240205202145.GB2220@sol.localdomain>
 <202402051443.A813E4D@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402051443.A813E4D@keescook>

On Mon, Feb 05, 2024 at 02:44:14PM -0800, Kees Cook wrote:
> On Mon, Feb 05, 2024 at 12:21:45PM -0800, Eric Biggers wrote:
> > On Mon, Feb 05, 2024 at 01:12:30AM -0800, Kees Cook wrote:
> > > Subject: Re: [PATCH v3 2/3] overflow: Introduce add_wrap(), sub_wrap(), and mul_wrap()
> > 
> > Maybe these should be called wrapping_add, wrapping_sub, and wrapping_mul?
> > Those names are more grammatically correct, and Rust chose those names too.
> 
> Sure, that works for me. What bout the inc_wrap() and dec_wrap() names?
> I assume wrapping_inc() and wrapping_dec() ?
> 

Yes, though I'm not sure those should exist at all.  Maybe a += b should just
become a = wrapping_add(a, b), instead of wrapping_inc(a, b)?
wrapping_inc(a, b) isn't as self-explanatory.  Likewise for wrapping_dec.

- Eric

