Return-Path: <linux-kernel+bounces-4559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F92817F47
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13351C22EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2217D5;
	Tue, 19 Dec 2023 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1/rkGsP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2315B1;
	Tue, 19 Dec 2023 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Dec 2023 20:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702949500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Og+ebVjdtObkh/9hZzSUL0YvYnnGqKkNV0U89WgdwhY=;
	b=P1/rkGsPhU373ucv7wBZ+fBBFamyyw9UmxNMe3CHvxWKumP7w5wBjacgwCRn/7dWM7qK62
	cobI4lsHTx2SHyXRikmlUWgbpUKU3Kn+LzWWV4Z19Dwd+ZjeMxXiK7WuujbvK+r+2pbsdR
	IYDc//4ot7IL1UZj1xwx8G4kYVVnOKM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Replace zero-length array with
 flex-array member and use __counted_by
Message-ID: <20231219013138.c6jo33i7oowk4vgr@moria.home.lan>
References: <ZYDi1bWIKRSs2NpH@work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYDi1bWIKRSs2NpH@work>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 18, 2023 at 06:24:53PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are
> deprecated, and should be replaced by flexible-array members.
> So, replace zero-length array with a flexible-array member in
> `struct bch_ioctl_fsck_offline`.
> 
> Also annotate array `devs` with `__counted_by()` to prepare for the
> coming implementation by GCC and Clang of the `__counted_by` attribute.
> Flexible array members annotated with `__counted_by` can have their
> accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for
> array indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family
> functions).
> 
> This fixes the following -Warray-bounds warnings:
> fs/bcachefs/chardev.c: In function 'bch2_ioctl_fsck_offline':
> fs/bcachefs/chardev.c:363:34: warning: array subscript 0 is outside array bounds of '__u64[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
>   363 |         if (copy_from_user(devs, &user_arg->devs[0], sizeof(user_arg->devs[0]) * arg.nr_devs)) {
>       |                                  ^~~~~~~~~~~~~~~~~~
> In file included from fs/bcachefs/chardev.c:5:
> fs/bcachefs/bcachefs_ioctl.h:400:33: note: while referencing 'devs'
>   400 |         __u64                   devs[0];
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied

