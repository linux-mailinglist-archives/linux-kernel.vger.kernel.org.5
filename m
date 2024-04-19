Return-Path: <linux-kernel+bounces-151799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6F8AB3FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BB41F2128B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CEB4C63A;
	Fri, 19 Apr 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDLXBmZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6497328F0;
	Fri, 19 Apr 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545916; cv=none; b=OagjQWS019TYUpHKXOISFl7KJekx8gy9Fmtgt2Vfoqi80/L4mHKMSlh2pzpdTMl27DqaFyCbAfhIT7995TE53h5oBwQOd9XB3VIT8FBl4ZTu6D617fqtDE0XLSSjtnnQJtRyUU0r9oj/KpWE3oypJ/4OQan1z1f5BjvJIZMCSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545916; c=relaxed/simple;
	bh=HIgCb+JE6x/kqPa8JPKJqEjhxyfPx7QjED0kmm5TGiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC/TG6c3Qilw9gQwsHYXse1KFtTxpp4MrZ7ssLzUVS6TTDT2za6w96lHoLgFMpVplcspev//J/A8y9p9mLJlz6U/0owXT4nnqYEhW/qWlbtyFj7XSyk9jivQxRswtaSGaNviIwDu23cFn9S0amcZF1A+cEPb9dS+uMbD/8X6Nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDLXBmZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171ABC072AA;
	Fri, 19 Apr 2024 16:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713545916;
	bh=HIgCb+JE6x/kqPa8JPKJqEjhxyfPx7QjED0kmm5TGiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDLXBmZ+NXfb6opY7MuJxTpeo266f1cEmqQM8duZzC9duFXiqaaX8XRqWBVmOvp7B
	 Pd3pSBAiqX6a7O8yFfFnlfJtUw/gG5x5vbDFHJbin1uEvBc3aIttdSnREvEyrGVffR
	 614xm7U9Hp2rY8IH7hdr9/FNA9s34y82Gpyj9tmn9jviMXcZaHdIzpcq2TFEHNeflw
	 IWvd9qzowSceuA5o8+wfJcViVCLFRsmLZUSqTYOWcHsu8tFzncBr0TPr6iXsTg9dx0
	 xPANVXlAuL5k6fq9u1L9+YIGZZKEybdRQLQHed82syMf0swc7yiVCD7EA/gBvyJr9z
	 cvFgOiY2rIddA==
Date: Fri, 19 Apr 2024 17:58:26 +0100
From: Will Deacon <will@kernel.org>
To: Zayd Qumsieh <zayd_qumsieh@apple.com>
Cc: Hector Martin <marcan@marcan.st>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Justin Lu <ih_justin@apple.com>,
	Ryan Houdek <Houdek.Ryan@fex-emu.org>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Message-ID: <20240419165826.GB4020@willie-the-truck>
References: <f6484dcd-ebf6-4b6f-be17-69b05539e33b@marcan.st>
 <20240416022242.89623-1-zayd_qumsieh@apple.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416022242.89623-1-zayd_qumsieh@apple.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Apr 15, 2024 at 07:22:41PM -0700, Zayd Qumsieh wrote:
> >I'm probably going to make myself hugely unpopular here, but I have a
> >strong objection to this patch series as it stands. I firmly believe
> >that providing a prctl() to query and toggle the memory model to/from
> >TSO is going to lead to subtle fragmentation of arm64 Linux userspace.
> 
> It's definitely not our intent to fragment the ecosystem.
> The goal of this memory ordering is to simplify emulation layers that benefit from this.
> If you have suggestions to reduce the risk of it being misused outside of emulators, we'd be happy to look into it.

Once you have exposed this toggle via prctl(), it doesn't really matter
what your intentions where. It will get used outside of emulation laters
and we'll be stuck supporting it.

Will

