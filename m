Return-Path: <linux-kernel+bounces-133885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C572F89AA48
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B556282A55
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252E2561F;
	Sat,  6 Apr 2024 10:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXjxwyXD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182817C8B;
	Sat,  6 Apr 2024 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712398111; cv=none; b=QIYNM1KPIQCgmk/IIH4khwpKQ9XUx7QDXU6Y3RC6C1Ympv5wcqDHucxHPU9eV2jtffvRWYneg3v1iYmf1mAQRWjtdRt3Q7q/YAtXp1LR+6TYhQmyH4VwNK5Bc3SieQgUu2HHO4DJGaq1riI8wIB6U1Psu2J9hptGvKLXY2pgCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712398111; c=relaxed/simple;
	bh=Z6PBdPhnDe/NoeFHmiy0yxTrTTqhT2vxjT3G/87Rh3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMtf16UYHEoTPrUG0kcO5hrVQP6szWx4HocKLkPbjFVnNbirWTU8DsUgPuzu/YiVWH/ThxDB8iIHn+oPlezwULGdyKqQ3Fvikyb6C50ILIDGcpDcoQMfMLsC8OYBJvy2HVfZNplyYJxr9FaSJsN+Qo3y64tBGnGGvNijCCrw+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXjxwyXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1E4C433F1;
	Sat,  6 Apr 2024 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712398111;
	bh=Z6PBdPhnDe/NoeFHmiy0yxTrTTqhT2vxjT3G/87Rh3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NXjxwyXDVIcZy8q73YoR2uJHtzrPxatWvLBkDmrM9EbgJiLw7LZg5PKeJ8HN8rhzc
	 MOYgcssIUVDadAb3nCua6bAK0aXPrHxZTNP4i6lWKWOLDVOjBZREISyUqHQR8PtL47
	 UyH+0OzQW6H8WFf2VJ+WwrgE04Lq1kIgwFqI02wjkbu8HOBJ9dFuprWc205I0ENwmO
	 apxZLRsJM0xxt3vwmqE7tiaK1r3FDCoJONixS4m5QbmNQ3x7m3w49xTaV5R0CSuEyu
	 FHvz52fJDKe7Ds2sv7cqHyDANh0yW8qnrJFqoxrW4vPeeyepEqP/rdpwZFuj+UeRqR
	 JZED8C/abbwtw==
Date: Sat, 6 Apr 2024 11:08:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: HAEMMERLE Thomas <thomas.haemmerle@leica-geosystems.com>
Cc: "joel@jms.id.au" <joel@jms.id.au>, GEO-CHHER-bsp-development
 <bsp-development.geo@leica-geosystems.com>, Eddie James
 <eajames@linux.ibm.com>, Lars-Peter Clausen <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: pressure: dps310: support negative pressure and
 temperature values
Message-ID: <20240406110817.2c2be48d@jic23-huawei>
In-Reply-To: <34c1c26a-4787-4713-8c7d-040732a18092@leica-geosystems.com>
References: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
	<20240328133421.1844a83c@jic23-huawei>
	<34c1c26a-4787-4713-8c7d-040732a18092@leica-geosystems.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> -static int dps310_get_pres_k(struct dps310_data *data)
> >> +static int dps310_get_pres_k(struct dps310_data *data, int *val)
> >>   {
> >> -     int rc = dps310_get_pres_precision(data);
> >> +     int rc;
> >>
> >> -     if (rc < 0)
> >> +     rc = dps310_get_pres_precision(data, val);
> >> +     if (rc)
> >>                return rc;
> >>
> >> -     return scale_factors[ilog2(rc)];
> >> +     *val = scale_factors[ilog2(*val)];  
> > This only just went to the effort of 2^val, so why not skip that step and
> > pull the BIT() section out to read_pressure() where we do want that form.
> > You will need an extra local variable at that call site I think, but
> > in general it is a useful additional simplification of the code.  
> 
> I'm not sure if I get you correct, as this function is not directly 
> called in `read_pressure`:
> You suggest dropping this function at all, call 
> `dps310_get_pres_precision` directly in `dps310_calculate_pressure` and 
> move the lookup of the compensation scale factor there?

More simply avoid _get_pres_precision returning a value that is in the form
that requires us to immediately undo the BIT() logic at the end of that function.
One way to do that is to just call the regmap_read() directly here.

> 
> >> +
> >> +     return 0;
> >>   }
> >>
> >> -static int dps310_get_temp_k(struct dps310_data *data)
> >> +static int dps310_get_temp_k(struct dps310_data *data, int *val)
> >>   {
> >> -     int rc = dps310_get_temp_precision(data);
> >> +     int rc;
> >>
> >> -     if (rc < 0)
> >> +     rc = dps310_get_temp_precision(data, val);
> >> +     if (rc)
> >>                return rc;
> >>
> >> -     return scale_factors[ilog2(rc)];
> >> +     *val = scale_factors[ilog2(*val)];  
> > As above.  
> 
> Based on my interpretation above:
> For `dps310_get_temp_k` it would require to move the lookup of the 
> compensation scale factor to `dps310_calculate_pressure` and 
> `dps310_calculate_temp`.
> Maybe this would simplify the code, but it would make it harder to read.
Just call rc = regmap_read(data->regmap, DPS310_TMP_CFG, val);
here and use 
*val = scale_factors[val & GENMASK(2, 0)];
here which I think ends up with the same value.

> 
> 
> Thomas
> 
> >> +
> >> +     return 0;
> >>   }  
> >   
> 


