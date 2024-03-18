Return-Path: <linux-kernel+bounces-105701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3585187E2F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDDC1B2148C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE167219E1;
	Mon, 18 Mar 2024 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgiyL6nN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BE20315;
	Mon, 18 Mar 2024 05:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739026; cv=none; b=oFOvNuUcrbubmlNzPn4fvL+t/zsfCpJNmMaHZ6R8/VwW+ibB3WuGyudepRVbNCL8aZ2WJRoUqU4x4a+arGxJ2kNve961+O40t/+SAPc3h9m04w4iIcQM0U2eUH94FNFkeIYRU1YL+iykxat2sYnx+0Z97JquvWJuJonboT95Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739026; c=relaxed/simple;
	bh=/ekLKfQyyyUB1OUoHzb8lmsD0EoABbXqCAh+jLBQQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7sCWql98pCB//cmkR7zyBcPrpge+U0SgTWS6q9JiqXeehKl5fAWm2CzrpTEjVGb1IaJDzFMnRpcKG5hl5VBbHtYInAY53875cEavKOuKxBUDzkt3O96wZQtwI6lHsime3yOuqLZQRUYxn0WjkVhCM7+3vqVic/0DGC+mCxO+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgiyL6nN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ED6C433F1;
	Mon, 18 Mar 2024 05:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710739025;
	bh=/ekLKfQyyyUB1OUoHzb8lmsD0EoABbXqCAh+jLBQQ4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgiyL6nNi1Y3bWrFZl2vZLVZ5vFKdYoWAnNZbOk1RXGFy8Je9frCBkXfIZWNzgPjY
	 BULFGcsOVgTYPa3wikqNk1bLEsCWthg2qnqOa1I/4yosw+A6QgPrdyRjps8xALVErK
	 U4kaXnDITqU7uxwihZ1AelEWrhnA7b6MINPLYpfR1hyXp06gUSwDs5xqUiLRNnib3/
	 81x+bsV/OEQKvgSdarqNvIHTf3NgPyCBXuupodq0Wxyz70AtIgYhoGkD5sl0EK9I1b
	 vY4lf6Ip8/DIsQYmGWuMkmy02OMM+pBIIbN8T0Slf6yxo6VnWmAAg9ZwEm2B+r6Uuk
	 o/pfm4qntBjfA==
Date: Sun, 17 Mar 2024 22:17:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com,
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [RFC PATCH v15 18/21] ipe: enable support for fs-verity as a
 trust provider
Message-ID: <20240318051703.GB63337@sol.localdomain>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
 <1710560151-28904-19-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710560151-28904-19-git-send-email-wufan@linux.microsoft.com>

On Fri, Mar 15, 2024 at 08:35:48PM -0700, Fan Wu wrote:
> +config IPE_PROP_FS_VERITY
> +	bool "Enable property for fs-verity files"
> +	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
> +	help
> +	  This option enables the usage of properties "fsverity_signature"
> +	  and "fsverity_digest". These properties evaluate to TRUE when
> +	  a file is fsverity enabled and with a signed digest

Again: why would anyone care if there is a signature, if that signature is not
checked.

I think you meant to write something like: "when a file is fsverity enabled and
has a valid builtin signature whose signing cert is in the .fs-verity keyring".

- Eric

