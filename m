Return-Path: <linux-kernel+bounces-143691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52FE8A3C52
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CF4B21939
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811413D96B;
	Sat, 13 Apr 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1j0+eXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF22032B;
	Sat, 13 Apr 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713005471; cv=none; b=d4SWKO6lAO0Tc58g3o+/YqNUgni6TvZsOun5a0PGqbMusdo8g3Lp6jbdkOBsNi5vDDa4oo2s53tjI6DwSus4ODu3WMbLT28M+s2lDhpnELn7YADBsGuUk8cgtR3OI+HstSp5nfazfTVHyrVPORM9CBIfnSTLgSjtQ7Ct2xO6aVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713005471; c=relaxed/simple;
	bh=1I9aNImIGoSMVbeQ1cOQLSbD7GRmUwabTf9B4XP8dhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkf9QyIYp63QZF9U7DKgTntw57t7o3/pkxTEBj9UKUuPIHQA2qni3CqkVlWKb39KPxIs0oDLhPUpYij19e8d+k5snqOranvWVhP4A/ggVy3gQkGQggL8Aox1ULhTdETnX6qPcIQzvNoXu3zQ1kz3b2z9XbdbFOf92wCwYw8YqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1j0+eXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CC7C113CD;
	Sat, 13 Apr 2024 10:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713005471;
	bh=1I9aNImIGoSMVbeQ1cOQLSbD7GRmUwabTf9B4XP8dhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k1j0+eXL1VZR5woVbQsVy0+ucqsBoUvbUu/TfAEw2hG8/NJL6ckoX3tU4T5v7BjLC
	 HhXZCyaD5FhzGJ/wZkC3FRiGS6DRaD9EZ/E0QBEyHKuCavHZDA50aPVnTgj9rY/Rdn
	 r8HSfpYJzdPtsOCM16lUtitqosP7eZa4YH/0RoDnMTKQjrj+zYiMf2eqKNrb2+MNAm
	 OYTdNCwl+DRgNRlrIyY5ZO5JNcXyKRzkqcDQg0MdgnuG412OSKjmnNT4002oQ/n2TE
	 A9+hB1pZ03RHkQYnagiCTaQzQbTYQLb4TlhvxcxesI6ea56Bssm4F0XEYmQjhuaesh
	 jdHo3Cp3+Gpag==
Date: Sat, 13 Apr 2024 11:50:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
Cc: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: adc: ad7173: fix buffers enablement for
 ad7176-2
Message-ID: <20240413115055.4f7a5892@jic23-huawei>
In-Reply-To: <05ef3e35-1ce0-48c4-9517-e8c1280cf96d@gmail.com>
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
	<20240401-ad4111-v1-2-34618a9cc502@analog.com>
	<20240406155646.694f710b@jic23-huawei>
	<05ef3e35-1ce0-48c4-9517-e8c1280cf96d@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Apr 2024 19:40:26 +0300
"Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:

> On 06/04/2024 17:56, Jonathan Cameron wrote:
> > On Mon, 01 Apr 2024 18:32:20 +0300
> > Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >   
> >> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> >>
> >> AD7176-2 does not feature input buffers, enable buffers only on
> >>  supported models.
> >>
> >> Fixes: cff259bf7274 ("iio: adc: ad7173: fix buffers enablement for ad7176-2")
> >> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>  
> > How bad is this?  If you can find out if writing those bits does anything
> > harmful (they are reserved and datasheet says should be written 0 I think)
> > That will help people decide whether to backport the fix?  
> 
> The bits are marked as read-only and there does not seem to be any effect on the ADC.
> So drop this one?

Patch is good as makes the driver more consistent, just drop the Fixes tag so we
don't end up backporting this.  That is basically treat it as code improvement
rather than a fix.  Add a note on the bits being read only so this not fixing
a bug, just an inconsistency.

Thanks,

Jonathan

