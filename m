Return-Path: <linux-kernel+bounces-140524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3348A15C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52F71C22FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D55F14D430;
	Thu, 11 Apr 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHiPZYak"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611CD145FFA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842685; cv=none; b=FA0MNsrSkz5kFGITxvl6P6/v6LL0q2O/NEESeOU2+mS0JSwYO4hmOy0qcJ/cnBOTuEnAbSCwct8fhAOaSrzJT3+W7jj1QJMhlUeLPYUAUBgpPbXej6trUjAWyOPAwGE4dax4E4AepbLk0+BdUcoYrRtwyHz7CkenAQFNPrmmnJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842685; c=relaxed/simple;
	bh=ubjRejHhKP//LNBOtLise49krMVbPnzbk/E6iAJWZCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXJPQTVknirzWCPy9632IattF9xGBAKlMg2F/iC1RjyKxyxyAOGemkWce7RCeZMgYwLJNEPBNXJ10m/45n7FaHu5ocE+CWZG+75Nv9JvXm7ANQH7ksykiLu8LP9Jh8+wapi0fOkWXrgpLdJ/P5k5ej8pm2o7epfD3v02wU19t5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHiPZYak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5BBC072AA;
	Thu, 11 Apr 2024 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712842684;
	bh=ubjRejHhKP//LNBOtLise49krMVbPnzbk/E6iAJWZCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHiPZYakpXIq0CSgNo83dnvf7Tg7baZzDEZjPmwF0VXJDncuSfiHF/AnT0d/u4tOo
	 8tVy0uVs7pJe6vmaHKw3TCxbbjZYkQSmmxt9qMpJL/bxsFZW86PbODWdQkKgUlA6nD
	 5IsAKhgOsdfWvZQ564SvwVrVG+QRQAnoGh6Piut4Fb+FB8gaskDRKmmnrRQVK355WN
	 OaO4/7zP0UrtgQjFcAro9tq9uXIqrEdJrdbQW6z1IXe/0+OaZcPh1GQyAIv4GOlpPn
	 VmawQ6VJOXRNegf9ROCJIjEqO1/S9mCYdrsa0ubyzUv+OmhEoHOiyanrmxv16YcnU/
	 Isfs0yFzXAWcw==
Date: Thu, 11 Apr 2024 14:37:56 +0100
From: Will Deacon <will@kernel.org>
To: Zayd Qumsieh <zayd_qumsieh@apple.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Joel Granados <j.granados@samsung.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florent Revest <revest@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tso: aarch64: Expose TSO for virtualized linux on
 Apple Silicon
Message-ID: <20240411133755.GA26535@willie-the-truck>
References: <20240410211652.16640-1-zayd_qumsieh@apple.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410211652.16640-1-zayd_qumsieh@apple.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Zayd,

It makes a nice change to see an apple.com address on the mailing list!

On Wed, Apr 10, 2024 at 02:16:38PM -0700, Zayd Qumsieh wrote:
> x86 CPUs use a TSO memory model. Apple Silicon CPUs have the ability to
> selectively use a TSO memory model. This can be done by setting the
> ACTLR.TSOEN bit to 1. This feature is useful for x86 emulators, since it
> removes the need for emulators to insert memory barriers in order to abide
> by the TSO memory model. This patch series will add ACTLR.TSOEN support to
> virtualized linux on Apple Silicon machines. Userspace will be able to use
> a prctl to change the memory model of the CPU from the default ARM64 memory
> model to a TSO memory model.

FWIW: I've replied on the other series from Hector:

https://lore.kernel.org/lkml/20240411132853.GA26481@willie-the-truck/T/#t

Will

