Return-Path: <linux-kernel+bounces-37241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CD183AD27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DC0287716
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33AF7A70E;
	Wed, 24 Jan 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur9PpaIU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C7A23C9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109765; cv=none; b=W0mx9eJjwKUFcX4r870pFDDIVfht1FT4f/71LeXNLY12tNN8kTQZDwgYYa/B0NiE7xNs5xPmPq0iZsk/DCRYGafbiO/CAUFkG4kfdLzl95wPT2hVJVhTEJUBghZNqP5eoHLmx/TczgOMPhJ62ZENyIGCZw+kHv9wGmcHlHUUm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109765; c=relaxed/simple;
	bh=/I/RVLhwzWSg4OYBfyNQJivQLrlc9TmnSoyx0fkPJjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uojFqD+jRWcvjG1iuJkbhUvWyYN0KerjQ6cTMf5RGwwJMk0BDVqdSugvtMnTfYpgNkbXElM1Hm202dhiXMww1svPdre2ajNo3yayLLz9EAPoapce7q9CKTTvAWTPWNMrRXBHnNQGyZf006ZZZgKU9h3g4PagybeF3pDw1zo6H1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur9PpaIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395B2C433C7;
	Wed, 24 Jan 2024 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706109764;
	bh=/I/RVLhwzWSg4OYBfyNQJivQLrlc9TmnSoyx0fkPJjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ur9PpaIUGlo1PFFVHccI7tRdpzJuXycTMnVze26mYM8xOYgQv9CTa2zylc0Mwvdhw
	 Z1VWDGnCb2B2r9ZKhFHJVu4nsbyYNHuw95I94OjccjsuzbomoyN45Vaj5V3FqPMTC0
	 twFxyDVQrcGaJKYCrr7QGR+yJvBKIOFQEcdzKnBHTZ1e+ZFcr0rvLtFEu/US5BaFz2
	 rNiZg9LC6bjOnD6g73qDnLwYEynY/qXMcPMTysBu/mPNhMFhnvnXkUA0lSAr6GgRH1
	 kDzbaEE0M3iFsSP/a9AlxGGD3QWvacGL8+FW8UKAJklT6zA8vz4zz1uluZaFekxfRP
	 i/usizHVXVv5g==
Date: Wed, 24 Jan 2024 08:22:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] iov_iter: streamline iovec/bvec alignment iteration
Message-ID: <ZbErQX4Z1pD0aa_5@kbusch-mbp.dhcp.thefacebook.com>
References: <544b31f7-6d4b-42f5-a544-1420501f081f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544b31f7-6d4b-42f5-a544-1420501f081f@kernel.dk>

On Tue, Jan 23, 2024 at 03:24:46PM -0700, Jens Axboe wrote:
> Rewrite the alignment checking iterators for iovec and bvec to be easier
> to read, and also significantly more compact in terms of generated code.
> This saves 270 bytes of text on x86-64 for me (with clang-18) and 224
> bytes on arm64 (with gcc-13).
> 
> In profiles, also saves a bit of time as well for the same workload:
> 
>      0.81%     -0.18%  [kernel.vmlinux]  [k] iov_iter_aligned_bvec
>      0.48%     -0.09%  [kernel.vmlinux]  [k] iov_iter_is_aligned
> 
> which is a nice side benefit as well.

Looks good

Reviewed-by: Keith Busch <kbusch@kernel.org>

