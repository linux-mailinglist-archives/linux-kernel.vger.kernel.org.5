Return-Path: <linux-kernel+bounces-69281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA83858697
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197571C2154D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78995139567;
	Fri, 16 Feb 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODJ+UIRH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D8B1384A6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114708; cv=none; b=cC4u3V+D3TR0MLHC++XMLRyalrBZsDe2w2xv6VF3GsxBDIHrCBtXaRa0plkB0A4hZx49d/d8rn62I1GAiiv/FpWl+XmIV0+3qg+EfOMc/6i/bFrWQhCNKpHtQxQDl23GE6mJCV8zBtLkAQSjVLU++7y+lE6BV7L16L/AFWXWMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114708; c=relaxed/simple;
	bh=02fBze+VPiN2IlWJArLIcZJnV5U0/kJfFuoQ8de5peM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=nJnQdMdvUtZJu3MUNdtdMmJBwGImN2gfK+gLPANhxpfY6JkZzCdCYnAGtlc42OA4C+Xb/P8WfoVPq163RJlCrq843lvK0nISQQDIF3D/TjvgmVTPwaIumPXaAiEGYrLOly5p7A4Lidy/NnrokiZOb/Dl8oXsN8bjRuXDJqZNxpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODJ+UIRH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708114705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEAq0tKZP/23jzaMIN60ZwyZvpQxftOTebhwinddGfA=;
	b=ODJ+UIRHnWqVoFOjIX2g9mgT685gkR3iqcOQJLabRoqTMfpjYVrq49vm241hnFsiBq8iIk
	7hdr3R/5R20Jnr1vjEwP3Ww+xjYSlgu8bgU+g79f8QfLgEoYjZsEWSMjFHjb7nySb1gQWH
	fHCylqGsBVTMOfeWIr7hWH3ksLBwS8s=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-qoTQBVzBPFieHnwr0xCSMg-1; Fri, 16 Feb 2024 15:18:23 -0500
X-MC-Unique: qoTQBVzBPFieHnwr0xCSMg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bd66680a39so2509342b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:18:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708114702; x=1708719502;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEAq0tKZP/23jzaMIN60ZwyZvpQxftOTebhwinddGfA=;
        b=W79tMLs4uKsQM4V7RNb8dhRuxxjA4gu4iMZKjanz+yK/3NCLwjO+shsFPq567+UcyZ
         5hzfEfTaRNNGAn8Y1rueIc9KVXuzlk7lxknq3fOdTSPClY1fZhsyBy2kDKrLShVMBiix
         /7xwnjwfwMCk4Z18tsCmh9PNCf3AdyMGPzkEchfrC7jQP8s7qPoNN5M1LsjH0QbgrjGL
         hGzAMLFFpp+JYbTbbAAQKx5ZdoZmr6d+40YJv5YYQBfe5KgCo66vjbiifiy1r059JALJ
         xDxZQ5tqQouMLqhcoCqvvy72nTAsLS37fdnjE8ZVDq/G4QyiJatnhTxtTWR8wqD0Ow+K
         9g1A==
X-Forwarded-Encrypted: i=1; AJvYcCVF4t+I5Itf47PYMg/btZ2E/hNZ2xdOv/t/NXNUhTpqkA3ZLyKI4QsC5aVTEjVzkQ3rfb9UCyMVJqbD0SmIhafPttkCWVHzOLqWXQWt
X-Gm-Message-State: AOJu0YxwiuZY6jduA/Z2urdje5+HoMly6lznLOfHOiEsImfJBNuP6koy
	nWpX61uMIm3wmrajabH+7UbDnDzPCHJQ6B9HuH1SKjkWYrA+MlOlyDdj9djSiqKx6Fe5/w+AWoG
	F55OXS36UjwZ/zWQKgfCDMgOTR8MCjs49epb/cqnlRokLl0PmMT30kLALGFCIMw==
X-Received: by 2002:a05:6808:23c6:b0:3c0:4bf1:b5a6 with SMTP id bq6-20020a05680823c600b003c04bf1b5a6mr7162889oib.2.1708114702671;
        Fri, 16 Feb 2024 12:18:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIzTp9rWVLDjQHfPe/31aF2/OhORAsPOJi3O5mQOLuN1b8kQlFOth9/cWEAuTxyAiepvFRzg==
X-Received: by 2002:a05:6808:23c6:b0:3c0:4bf1:b5a6 with SMTP id bq6-20020a05680823c600b003c04bf1b5a6mr7162868oib.2.1708114702447;
        Fri, 16 Feb 2024 12:18:22 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:4770:9d0:4bac:1782:4637])
        by smtp.gmail.com with ESMTPSA id pf2-20020a056214498200b0068f2aba4842sm239481qvb.129.2024.02.16.12.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:18:21 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] irq/spurious: Account for multiple handles in note_interrupt
Date: Fri, 16 Feb 2024 17:18:15 -0300
Message-ID: <Zc_DBym2GuwPmAne@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <Zc-BBQGauwIEJJXy@smile.fi.intel.com>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-4-leobras@redhat.com> <Zc-BBQGauwIEJJXy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Feb 16, 2024 at 05:36:37PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 16, 2024 at 04:59:44AM -0300, Leonardo Bras wrote:
> > Currently note_interrupt() will check threads_handled for changes and use
> > it to mark an IRQ as handled, in order to avoid having a threaded
> > interrupt to falsely trigger unhandled IRQ detection.
> > 
> > This detection can still be falsely triggered if we have many IRQ handled
> > accounted between each check of threads_handled, as those will be counted
> > as a single one in the unhandled IRQ detection.
> > 
> > In order to fix this, subtract from irqs_unhandled the number of IRQs
> > handled since the last check (threads_handled_last - threads_handled).
> 
> ...
> 
> > +static inline int get_handled_diff(struct irq_desc *desc)
> > +{
> > +	unsigned int handled;
> > +	int diff;
> > +
> > +	handled = (unsigned int)atomic_read(&desc->threads_handled);
> > +	handled |= SPURIOUS_DEFERRED;
> > +
> > +	diff = handled - desc->threads_handled_last;
> > +	diff >>= SPURIOUS_DEFERRED_SHIFT;
> > +
> > +	/*
> > +	 * Note: We keep the SPURIOUS_DEFERRED bit set. We are handling the
> > +	 * previous invocation right now. Keep it for the current one, so the
> > +	 * next hardware interrupt will account for it.
> > +	 */
> 

Hello Andy, thanks for reviewing!

> > +	if (diff != 0)
> 
> 	if (diff)

Sure

> 
> > +		desc->threads_handled_last = handled;
> > +
> > +	return diff;
> > +}
> 
> ...
> 
> > +			diff = get_handled_diff(desc);
> > +			if (diff > 0) {
> 
> diff may not be negative as you always right shift by 1 (or more) bit.

Agree

> Hence
> 
> 			if (diff)
> 
> will suffice (also be aligned with the similar check inside the helper) and
> making the helper to return unsigned value will be clearer. Am I correct?

Sure, you are correct.

I just think having it be (diff > 0) makes it clear that we only do the 
subtraction if diff is bigger than zero, while (diff) could mean diff being 
valid, and would require the reader to go back in code to see that diff is 
an int. 

Does it make sense?

Other than that, I agree the negative half of diff is never going to get 
used, and it's better to go with unsigned int in both cases.

That will be changed on the next version.

Thanks!
Leo

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


