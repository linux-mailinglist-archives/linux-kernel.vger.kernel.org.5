Return-Path: <linux-kernel+bounces-82906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39987868BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B70B27F78
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628B21332A9;
	Tue, 27 Feb 2024 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hg1EUzVZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FD54BCB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024735; cv=none; b=XqyJYouHiZVT4+Nm+V83gMYf5FRLYzZhfi4FYCDJaE4g4oAb1hsJBzahtOpY/A2/+sUziUobhnfAvENOcrg2ImZ4jm0Ufe/gB2kBT0SXEdh7CAbvzLCLa6dNQKD4JbgcPcKqipGHGGifwC1GlP5grn+ii76/FWR9K9ZS77Y0nyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024735; c=relaxed/simple;
	bh=Am/D+g9bxO9RrGanC/9goSZgOkapPvJ6A17Yn9/q0p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wu+QXwkrtEYRBNcti3YJjz5PMeqPLF9FyhVpC4bXgn54Pdq5jPecTfuDQ5wafapkFPbuXy5g8AT4yQTJtrEdsPXZKgkN73mD2/4ebDpmw/uh0wTavn2W7ZHqHYy4Xx8IrdAHBUHxXz6LaNlDlEYASuyxcw53OpTwc2ujGiGZX58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hg1EUzVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B83C433F1;
	Tue, 27 Feb 2024 09:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709024735;
	bh=Am/D+g9bxO9RrGanC/9goSZgOkapPvJ6A17Yn9/q0p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hg1EUzVZ7XOEM1hsgrqJ3KvddHqLBU06Z0qzqQRfePSMjFAmw1+GDfC0QOLNPMdPZ
	 reR6lCFjjTSru4dEFU7h0YoMTbEnZJuBclSt2b8LOmZ7Tp5u0zglnQW2mMOv7YxAlG
	 cNB0lTFgqQowkHWZWoGuC66YDGvgyk1TgYs2/2B7GWLRpeAtgYjere1/znwxFMSwTq
	 y1NnkbYfNlxkD1IBk7SpKYkNQDV2hx3ZPBjocY0v0P5j9OVfDKcbvH7xjcsZIpGdrU
	 mVNwwZ2IE5QqRs5UivGlT5e9p6Y5nQuns41rsOBPK/Cov3fWEIGzZJXs+QwsfSesmT
	 lhLfrjZ/Ae4iQ==
Date: Tue, 27 Feb 2024 09:05:30 +0000
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/hw_breakpoint: Determine lengths from generic perf
 breakpoint macros
Message-ID: <20240227090529.GA13359@willie-the-truck>
References: <20240223113102.4027779-1-anshuman.khandual@arm.com>
 <20240223125224.GC10641@willie-the-truck>
 <1901fadb-1d71-4374-be8c-00935bb27854@arm.com>
 <ZdxwTkUALQfqjagf@FVFF77S0Q05N>
 <c37bd84e-d4f7-42df-a333-f2ad6ebc9527@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37bd84e-d4f7-42df-a333-f2ad6ebc9527@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 27, 2024 at 11:01:54AM +0530, Anshuman Khandual wrote:
> On 2/26/24 16:34, Mark Rutland wrote:
> > I don't think this needs to change, and can be left as-is.
> 
> Fair enough, but just wondering how about deriving len_in_bytes from
> hweight_long(ARM_BREAKPOINT_LEN_*) instead ? This also drops the hard
> coding using the platform macros itself, without going to user ABI.

Please leave this code alone. It's fine like it is and there are plenty of
other things that would actually benefit from your attention. The BRBE
series, for example.

Will

