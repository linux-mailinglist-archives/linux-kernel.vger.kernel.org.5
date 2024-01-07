Return-Path: <linux-kernel+bounces-18899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F65C8264D7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104B11F213D5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754613AC3;
	Sun,  7 Jan 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pddtAirI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23013AC7;
	Sun,  7 Jan 2024 15:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C887C433C8;
	Sun,  7 Jan 2024 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704642820;
	bh=N3zMWKjNEPsOHFTqHdAQObaikNXq+RfseLXrPFfE4zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pddtAirIHEGyn3Rpb9aKuT/dOW4ax8lNoCtvZDVQ4ZOgm0ucCNy6FmyrfeflM4IxB
	 BkQkqxkedRmkumagR/PyeVR/hGzgqOERIe99ZX88AO6v95gZWQIW2SCpd844w7ERuG
	 yvEHb0MuG8SD3OwzTjyanWpHi7QC0CdTbBGiPkcVCvAVeeyw9G/JaNBIxNNdXhSqr1
	 c2+KpMogZeTvkqtGCBdn07phoArQZ8VyJMDlN1ceNm7QcG1aKDB5ajkSWPutG2VWEp
	 AKjh3Qv8bEw0BfM2fJ5aUESHmMo9wN7pGu6PUvmBCiohJDTh7XLC/xowbPEPl5se24
	 eKy/yVtmO3YQw==
Date: Sun, 7 Jan 2024 15:53:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] tools: iio: fix iio_generic_buffer
Message-ID: <20240107155333.0e43b041@jic23-huawei>
In-Reply-To: <20240104101253.25896-2-petre.rodan@subdimension.ro>
References: <20240104101253.25896-1-petre.rodan@subdimension.ro>
	<20240104101253.25896-2-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jan 2024 12:12:45 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Fix code flow problem and floating point exception caused by improper
> directory stream positioning.
> 
> Fixes: <e58537ccce733> ("staging: iio: update example application.")
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Hi Petre,

This doesn't really explain 'why' seeekdir(dp, 0) is wrong.
My assumption is that telldir() would not have returned 0 on this particular
system?  Could you confirm that and update the message to explain why
seekdir(dp, 0) is not equivalent to rewinddir(dp). 

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


