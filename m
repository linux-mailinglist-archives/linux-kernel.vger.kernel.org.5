Return-Path: <linux-kernel+bounces-51721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64758848E96
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BD2833C5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11015225CB;
	Sun,  4 Feb 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSY2tlRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B622EF4;
	Sun,  4 Feb 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057980; cv=none; b=nVE6spp48mkhlqv4f9ACD50v3BvBk992gSPo0rLAoEvtDFc9G4E2c6F2QV4GIJuj28wb+B3xQYqZktE63M6Vah6kVBB5SqGkk5wrIx5+qrGVbjFrD6H6DfzxWUjIa1Yz6pcwP2abrCQruJR+9uNddmZCxytWpTegRY1/RsyCOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057980; c=relaxed/simple;
	bh=gAKfZBo++t7DAF7lAsWsituxGMr7iF0FdWdQzQkPlyw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXtmEz0+GBG3TA2aaTysS413errx/w7YCqDGL2PbZ1a8d4mrIk/5yzDn3/9agqbikQwtLjK/80pBgVaF9y9cFVCttV3GuJzOoTF8jIuGJp9Yzkym7a3KxlAhwE0zNY2zKbdxWMDtt/zNSHK4Rt0AO2feRdumu7lK+PFmzdlFDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSY2tlRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A6CC433F1;
	Sun,  4 Feb 2024 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707057979;
	bh=gAKfZBo++t7DAF7lAsWsituxGMr7iF0FdWdQzQkPlyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSY2tlRRqx0dbu+Tm7gSU7mMf+bXGetbUKYRBebRGUExRXtybqlpxX4HWrzdPndNI
	 7OKFMVN5W1E8oxcEFMNeNbQPTKbyw/BqfKAj3mKLFKj4rbZATeE/VKqiGL5d/n6oa/
	 wbcM2Nvu7eEYxQfxCvFzt8qb1DLqnhZvn5d36scBGcQkfMR1SprtmtaL25wJp/s1+K
	 eUBkULS/Cuxghzg5bJDOrghu3LG869xOkygR7hTcDcQliHnvYW6r7QzIQ8bDpyUbR9
	 C9IcV9swv/rMiiy2rn5UJwn9Ee70A4KXsyMpLFjGSBKiXD6S727rRbfsUx21pf2HGS
	 G2vo4ztx5hNqA==
Date: Sun, 4 Feb 2024 14:46:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7380: don't use bool in FIELD_PREP
Message-ID: <20240204144607.2908b8b4@jic23-huawei>
In-Reply-To: <20240129195611.701611-3-dlechner@baylibre.com>
References: <20240129195611.701611-1-dlechner@baylibre.com>
	<20240129195611.701611-3-dlechner@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 13:56:08 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Although this technically works, it is better to avoid using bool as
> a bit value.
> 
> Fixes sparse warning:
> 
>      drivers/iio/adc/ad7380.c:353:34: sparse: sparse: dubious: x & !y
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
> ---
> 
> v2 changes:
> * use correct terinary operator syntax (had typo of : instead of ?)
> 
>  drivers/iio/adc/ad7380.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 44b8b18ab213..abd746aef868 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -350,7 +350,8 @@ static int ad7380_init(struct ad7380_state *st)
>  	/* select internal or external reference voltage */
>  	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
>  				 AD7380_CONFIG1_REFSEL,
> -				 FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->vref));
> +				 FIELD_PREP(AD7380_CONFIG1_REFSEL,
> +					    st->vref ? 1 : 0));
>  	if (ret < 0)
>  		return ret;
>  


