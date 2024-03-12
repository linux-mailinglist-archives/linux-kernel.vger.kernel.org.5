Return-Path: <linux-kernel+bounces-100910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C4879F82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DE8B2205F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866AF46556;
	Tue, 12 Mar 2024 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiUZw4o0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A626286
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284778; cv=none; b=sxW7XFADVHBpKdVNxk7o8ArwUM+wdWVy5HQ/OpjvdwEGd+3+O/TA+JMgbGyqFtEOdXzMJgXzDeJkw0JLXs6NWn37M+VNdWu9Uf1jaZCvHzsGB7nxjfsQPPbFCRAHzPmZDeKJ39kcS79Dtdj5So1E/QMubBwjjc5scFJvxEpNhSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284778; c=relaxed/simple;
	bh=9eDnSFXNy8nzr190Z9PURmwYJ8sNZi/Vd4eFppNmsr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5b4jo3C+t06eAHgWIh5newUrLPBFN1w/EVrOVu7bIyxjyckgymZG6BTz+osuqwIWrq/ghcOoJ8JuXarUTuxQ2ndZws2S40mcQa0OXdQnyN/h6CMzrfaO/A0Evj3y0prDgVjGcS8dnuYeniurqn/cKi6M2quvlvsidFmExjyiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiUZw4o0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1DEC43390;
	Tue, 12 Mar 2024 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710284778;
	bh=9eDnSFXNy8nzr190Z9PURmwYJ8sNZi/Vd4eFppNmsr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiUZw4o0gts/d+Cl8Spf7u6L4n9Jx5PO/CEkDIAZrGBg6wGB+Snq+b0vG09BHbiXu
	 e55wJ1cYTdAafnBcZh7e6s5OxBR0dRPPYGER2SnBJa5L/WiIGCODw6jb2OPfLwZoeo
	 ffzuf0nW2vS+tpKSORAml9i9ptVN2FH66kLNsnnFdud6WBZOAlCegvW5AM1b1tzSF5
	 1havU1JzvcSRFTRf53NioSlaE3bON9uENO2mjlkCLEhc9lmdhPyjas/CnMHJkRXMNt
	 0n+NuOtVxrStbBqhxx7EYy6g07v1XfS68WBgkkbsY91490oak7h1dvsijKMk3Atlc7
	 CJSfo0lae4Leg==
Date: Tue, 12 Mar 2024 16:06:16 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Improve performance of 'faddr2line'
Message-ID: <20240312230616.u7rvo2iowdumlm2v@treble>
References: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311204019.1183634-1-bjohannesmeyer@gmail.com>

On Mon, Mar 11, 2024 at 09:40:12PM +0100, Brian Johannesmeyer wrote:
> Hello,
> 
> I was looking at the performance of faddr2line and noticed that it spends
> most of its time performing two tasks:
> - (1) Making redundant calls to readelf and addr2line for each address
>   (e.g., it makes 7 readelf calls and 2 addr2line calls when converting 1
> address, and it makes 252 readelf calls and 51 addr2line calls when
> converting 50 addresses); and
> - (2) Calculating a symbol’s size by unnecessarily looping through every
>   symbol in a particular section.
> 
> This patch series consists of the following parts:
> - Patches 1-2 reduce the total number of readelf calls to one,
> - Patches 3-4 make minor changes in preparation for the following patches,
> - Patches 5-6 reduce the total number of addr2line calls to one, and
> - Patch 7 modifies the symbol size calculation to only check two symbols.
> 
> I evaluated the performance of the patch series by running faddr2line with
> a standard kernel image (X86_64 defconfig with CONFIG_DEBUG_INFO enabled).
> When converting only 1 address, the patch series gives a negligible
> speedup. When converting 50 addresses, however, it gives a 15x speedup.

This looks really nice.

If testing runs ok, I'll go ahead and queue it up.

Thanks!

-- 
Josh

