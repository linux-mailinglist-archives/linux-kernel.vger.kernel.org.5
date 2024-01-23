Return-Path: <linux-kernel+bounces-34797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62083878C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A37DDB24872
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FFA50267;
	Tue, 23 Jan 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="st8wChQU"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E69524C9;
	Tue, 23 Jan 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991818; cv=none; b=EhG9Fw8L9gOzFerLSdN7GzuBeurzCIvux2n96oxm0J5NBaA35viNd9sEWZp26lcNRCq9nmlGsO7yArJqOHfpsdknjzIQtgxeLMo3122kxC/B/Q/KJFylFwihDOxexqKNRubaQVQ9phYrejfGLqR9+oVHK3sQLk1BUa0m2cqrTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991818; c=relaxed/simple;
	bh=4H939JIw9hVAR20By/afcYObJs+WyUMyRp+bhFZXd68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R290a9yVymsMWvJU8RSoO2bLewcFkkvrrjzSQG01NbY2m51p/dc+PwyFzjvGTCP231hWIXTkn+LbZHRFobtNqF0EyzPHqRJAdgeKCR225SHQzWQZnEJzXaxpAwkNHkzHLyBBOBG30KuyLDX2t82zbr8Qmp8aOpRVHKeM5F81j74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=st8wChQU; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Jan 2024 01:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705991813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=01K6hhKUL+Sc+Jb58aaPmHOz1bS6cOEKCuruEFUUrOE=;
	b=st8wChQUf53vwUZ1mf79dNKOmUC6ZPpWkl6h7VsQr1Ltkya77anVULDEfxLEb8VRzEBlIm
	5M5vyeyYHTZtP6tADRfRXWjRuPgBh9z/B9Cf+l/MVsGIuGVDtt88+n0KSotCewjj1sWLm3
	Dl4bjgMhMRZQc5tJWD/M/59mn24h7Kg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 42/82] bcachefs: Refactor intentional wrap-around test
Message-ID: <lzb2gaizubakkhf5zqozshnt4ivghyg4sddxwrn46hroozacdc@lcctrys76hys>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-42-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-42-keescook@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 22, 2024 at 04:27:17PM -0800, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Brian Foster <bfoster@redhat.com>
> Cc: linux-bcachefs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

