Return-Path: <linux-kernel+bounces-157440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367748B11B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624621C2546C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1716D9BD;
	Wed, 24 Apr 2024 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="NP7S3Ph6"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5858516C6A5;
	Wed, 24 Apr 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982026; cv=none; b=YDEV3Y0EzE77WJC5bUCDFh+zf2cgiTKSODmD8jXyqyNoCbAzD94rKLjHyGiG/pidTu0Kpsb3rMh5XnzRCnRMi10SM+bmANdmwgePBBYjq0MiMDqslki9000QSt4wMJn5Z1w3SSl3Tlb/BjYYywYrtUWjhFrjWz/en29TsllQOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982026; c=relaxed/simple;
	bh=aAXKUwAx4OeGu7HuWw77OwGHHF+wHScj0s8yaIYfPC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/hj80A2YNuq5zlYWTxuJhNTw8i4DBGSM+qF+tsGXR/phpbEWXr+BeuKgTvcV3vhJe3us3eMKhalGG/cjWMEo5UJ6eNsv6Gl6kQqxnxWvwiQEKD/UafGpaCs2FmguN5CVx4a8Tpt6+0mtCwgR13Im7koyJ1L2TGntrDlxq3h99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=NP7S3Ph6; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9BFC64076723;
	Wed, 24 Apr 2024 18:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9BFC64076723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1713982014;
	bh=PTDsiKi+3vxRG67GT75ud/6SfAqbbzKbDZvPVeKIgWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NP7S3Ph6CoCwfcfc7c557yKOlv45Fe9EpZZ6QdSyQMqdRmXK1pEKZgVpwTMe9Bi57
	 SyMZdApnnUtHA3mZhjY2BDp161/bdSNrc5y6C1SyNhukT24RPONUTWYBGU/OF8/7QI
	 wwmj4voGCXKUHsDBbVjvHboJY0NKGn3weEIzTjEU=
Date: Wed, 24 Apr 2024 21:06:50 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Michael Krufky <mkrufky@linuxtv.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	lvc-project@linuxtesting.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [lvc-project] [PATCH 1/3] media: tuners: tda18271: fix error
 code handling in tda18271_attach()
Message-ID: <20240424180650.tpemkolglnkb2pyn@fpc>
References: <20240416114509.198069-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240416114509.198069-1-r.smirnov@omp.ru>

Hello Roman,

On Tue, 16. Apr 14:45, Roman Smirnov wrote:
> tda18271_attach() uses the hybrid_tuner_request_state() macro.
> It may return the error code -ENOMEM, but the function handle
> the value 0 instead.

Maybe hybrid_tuner_request_state macro declaration should be fixed to
generate zero in case of a memory allocation failure?

At least it has a comment stating the following
 * 0 - no instances, indicates an error - kzalloc must have failed

And supposedly a number of drivers implemented the error handling based on
this assumption.

The drivers mentioned in this series are not the only ones susceptible to
the problem. Grepping through "hybrid_tuner_request_state" calls also gives
out tda9887, xc2028, r820t and others.

> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: b9302fa7ed97 ("media: tuners: fix error return code of hybrid_tuner_request_state()")
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> ---
>  drivers/media/tuners/tda18271-fe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/tuners/tda18271-fe.c b/drivers/media/tuners/tda18271-fe.c
> index a7e721baaa99..23432210f06a 100644
> --- a/drivers/media/tuners/tda18271-fe.c
> +++ b/drivers/media/tuners/tda18271-fe.c
> @@ -1255,7 +1255,7 @@ struct dvb_frontend *tda18271_attach(struct dvb_frontend *fe, u8 addr,
>  					      hybrid_tuner_instance_list,
>  					      i2c, addr, "tda18271");
>  	switch (instance) {
> -	case 0:
> +	case -ENOMEM:
>  		goto fail;
>  	case 1:
>  		/* new tuner instance */
> -- 
> 2.34.1
> 

