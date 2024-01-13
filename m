Return-Path: <linux-kernel+bounces-25319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854682CD6F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB721F223D0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963451C16;
	Sat, 13 Jan 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxNE8PlW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722DEBB;
	Sat, 13 Jan 2024 15:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED11C433C7;
	Sat, 13 Jan 2024 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705159173;
	bh=vX58YZjenHiTJxtX2xEHIR6mIG6Zrsa+Iez23OxTdYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hxNE8PlWdaMQ+h0z1BW/rJFuaHHcWOXuAYK0ApWFH3ZXaa50jiMnU9BWvFb7VL0W6
	 nXwtZ0of5I153SdWFROj1PsSXRC+KNINlFgaGfexdky1wWWiB1FBSPMT1wbN7YJMga
	 diR1DMQZ/EdEDruwKGke73ZibkCUegQ77y7EL0ZHNRgU1JoQpqTDs90Uo+Ri+AjYbG
	 xIL0/JilNQX/jOJu/2XoapGCqiLLyx+rKIXTEL6Lh5xr8FwtrTz2U+AMUYlMKbsZdS
	 1K/GLQDsufrVKpMeln9ryW/YLUlz9JqQbZDOCxGNCM3FczfIFTQFm7ML7LGJ97yBqD
	 L07s381i7Bs8A==
Date: Sat, 13 Jan 2024 15:19:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] tools: iio: replace seekdir() in iio_generic_buffer
Message-ID: <20240113151928.0857a93a@jic23-huawei>
In-Reply-To: <20240108103224.3986-1-petre.rodan@subdimension.ro>
References: <20240108103224.3986-1-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Jan 2024 12:32:20 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Replace seekdir() with rewinddir() in order to fix a localized glibc bug.
> 
> One of the glibc patches that stable Gentoo is using causes an improper
> directory stream positioning bug on 32bit arm. That in turn ends up as a
> floating point exception in iio_generic_buffer.
> 
> The attached patch provides a fix by using an equivalent function which
> should not cause trouble for other distros.
> 
> https://sourceware.org/bugzilla/show_bug.cgi?id=31212
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
I tweaked the description a tiny bit to say it's also easier to reason about
in general.

Applied to the togreg branch of iio.git and pushed out as tesing for 0-day
to probably ignore it.

Thanks,

Jonathan

> ---
>  tools/iio/iio_utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 6a00a6eecaef..c5c5082cb24e 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  		goto error_close_dir;
>  	}
> 
> -	seekdir(dp, 0);
> +	rewinddir(dp);
>  	while (ent = readdir(dp), ent) {
>  		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
>  			   "_en") == 0) {
> --
> 2.41.0
> 


