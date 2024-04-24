Return-Path: <linux-kernel+bounces-157679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467CE8B147A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75578B2D228
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3494142E6E;
	Wed, 24 Apr 2024 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="TD6Za+4H"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5315113D25E;
	Wed, 24 Apr 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990041; cv=none; b=rfz/WycC1D9cB22jnQe94f1CBq/7HXJew3RR1mQFsNUmgUwbZrqVIgHkr4jpt56jNnu8hg/SFsFN7xzT1/jIhTry0X4aahpkchIfAx27gdnKS+py8DTunqcIjyhJKtVUXypbgyIbrVL6a3d5TKgFqirPn63iTkiV7wLf7Mmvbu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990041; c=relaxed/simple;
	bh=evUdA1G7V4lnHAGAdqIToss3C/AnK3uw31x0ZW7Z8tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W719qLb1/GbS88PoAMyNLOUtiVP1iFYa9LWH4wx2JUDGLUxXL7koyLrEXS4neiwA4cGgZkMWwwO8P1z4ZXtc6+hwxH0koTPXcYMQbhjnZ9A0Zr9I7yo8D9jknGbTzFlPijhUMjjOvQuH9+3cc4Kp5DG5GZxzISSC8aHrDridIFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=TD6Za+4H; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [5.228.116.47])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9038740769D4;
	Wed, 24 Apr 2024 20:20:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9038740769D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1713990035;
	bh=vrqHWArLY1GC2CmlIt6zLL/Sipn9wJVlFUF93H85+Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TD6Za+4HRVSrI+DWDliN8vmK05UQx4SECDU7t4Z5HhE+/Oy1gwQ6SMCwewXeyHFja
	 Gx8OAByxcD1tYvzgP7O3WFE1giLdjyt/8bQrPcM8OQWM9cit2C87yVHIFR5JocaAf/
	 D3XIpdZETrxrveUXHppQ0Q7sxzLBVQqYuwp+h+BI=
Date: Wed, 24 Apr 2024 23:20:31 +0300
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
Message-ID: <20240424202031.syigrtrtipbq5f2l@fpc>
References: <20240416114509.198069-1-r.smirnov@omp.ru>
 <20240424180650.tpemkolglnkb2pyn@fpc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424180650.tpemkolglnkb2pyn@fpc>

On Wed, 24. Apr 21:06, Fedor Pchelkin wrote:
> Hello Roman,
> 
> On Tue, 16. Apr 14:45, Roman Smirnov wrote:
> > tda18271_attach() uses the hybrid_tuner_request_state() macro.
> > It may return the error code -ENOMEM, but the function handle
> > the value 0 instead.
> 
> Maybe hybrid_tuner_request_state macro declaration should be fixed to
> generate zero in case of a memory allocation failure?
> 
> At least it has a comment stating the following
>  * 0 - no instances, indicates an error - kzalloc must have failed
> 
> And supposedly a number of drivers implemented the error handling based on
> this assumption.
> 
> The drivers mentioned in this series are not the only ones susceptible to
> the problem. Grepping through "hybrid_tuner_request_state" calls also gives
> out tda9887, xc2028, r820t and others.
> 
> > 
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
> > 
> > Fixes: b9302fa7ed97 ("media: tuners: fix error return code of hybrid_tuner_request_state()")

Looking more thoroughly, I think commit b9302fa7ed97 ("media: tuners: fix
error return code of hybrid_tuner_request_state()") should be reverted
because it just contradicts with the return values contract which is stated
in the comment for the macro and which is followed by all the existing
drivers.

__ret should be assigned 0 in error case as was before the commit.

> > Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
> > ---
> >  drivers/media/tuners/tda18271-fe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/tuners/tda18271-fe.c b/drivers/media/tuners/tda18271-fe.c
> > index a7e721baaa99..23432210f06a 100644
> > --- a/drivers/media/tuners/tda18271-fe.c
> > +++ b/drivers/media/tuners/tda18271-fe.c
> > @@ -1255,7 +1255,7 @@ struct dvb_frontend *tda18271_attach(struct dvb_frontend *fe, u8 addr,
> >  					      hybrid_tuner_instance_list,
> >  					      i2c, addr, "tda18271");
> >  	switch (instance) {
> > -	case 0:
> > +	case -ENOMEM:
> >  		goto fail;
> >  	case 1:
> >  		/* new tuner instance */
> > -- 
> > 2.34.1
> > 

