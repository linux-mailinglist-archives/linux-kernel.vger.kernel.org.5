Return-Path: <linux-kernel+bounces-77771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D311860A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CCE1C23185
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF2B12B82;
	Fri, 23 Feb 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+sGzeHW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B88125D9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663954; cv=none; b=Gr62WBlmfwHjiXwCmeZSpVeZv75BTC1D+jPQ0zntOhq9y23/nv8ALXz4991+HcuCgm1m3IUS6YG8Ve20hAXS9EMXHQw2L2CXUG7GJ9LQlzq4AhlaBrQ8/6sq0xdrhtauBqJSX2RARLZNnJ1jgAWxRJp+RwBe5gJn81LoreDy0DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663954; c=relaxed/simple;
	bh=XkHvRIn9l8T02N+1IdFfX69n71P34OHEy6ZzjjC0NSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=gXP6MjUHhKUIkfZYEbrNsdASysf1Ws8PRukWs7ayMZhnUeI/ZNNGxX7YMKrl302bP+bQvP2KRH3UyesqC+KV0bEV1rcyyd/xmijP3pStZNVtR+PO3haXF8yVe+L28jygp9CAG7DX6TuoYW8A+Bpq9Nv7n2ePqaRcpKEc3ew7Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+sGzeHW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708663952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2a79SnguKy7LS5/McK8Bl18qsnHZ6N+ea/bVlJ73jc=;
	b=L+sGzeHWINB+pvex9HrnEA/lcMPpXCjG/hjtoJgld+edDAVt0YjyIysjoJziXpwFHWb3Sj
	0nEFyL7gH0Jq38wqHZVmG/FylkdA3z/DTnlJ7EHt5yMpLuDnKx3sQwW6HdKTl+lKJHKLfJ
	/8BozwvGLAk+MmTOV1TUM3BY1NckY+E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-pxgBLHZmNJSjygogYECgcQ-1; Thu, 22 Feb 2024 23:52:30 -0500
X-MC-Unique: pxgBLHZmNJSjygogYECgcQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42dbd942e22so3211761cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663949; x=1709268749;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2a79SnguKy7LS5/McK8Bl18qsnHZ6N+ea/bVlJ73jc=;
        b=OqFHML28m9MUrtg5rvBnAHwQJjeWDhXUs2bfUc6WqxyRCebRjiKlgcPZROlap4p2Wj
         wGkw4eevTKDmnzuaXpWIKuesTfw9b3opOll5d3aXibGUBwYOfmDI8pYvaqJWdA6bRZpc
         MhOHsVPxEsJpUsPB3lZLbbzS8f2SaUYdrqiW6KeA8pY+Td7MZv5HjgJDmZgT3MNHlcvH
         yRhifvUUDGwhsrGtVi78rD2b5Z8GhLqsBubwwPHfguqipbv8d5EH5+cXaM6Gw2k45Crp
         JzW0CU1t1f6QMx/sjmE4xqrICgCXiMrqtVLwc3Bq7tJHJolEdfVGtMtWVTuqJbbADwPQ
         hfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnOigiU/d+0JDCXb5Bh2C0V68LlHF5wRfs8Dgazmbpl2lTnbWwpqljhddlL2OeKnWhyIMJUvop7IeurMrErIIglh0sz53ZVqWMdpT2
X-Gm-Message-State: AOJu0YxrrZhaXFHQbQv4Omvv2260zStJT3z2YdpaN+csuS4ud/gOrWTr
	vduZpS5lgRvj2E6JlLHlpDSEezcsXnR11SxVqSdG2deWyNtmFO8Y7S8nOMXEjnY2QsBtOJEPnEE
	nv9JouDqztH3tWDjPmxLHE46VifM4Ew2LR4AxoQdMV5oq96DtnjzFEMLEXlbLOwnhwko+Tg==
X-Received: by 2002:a05:622a:180d:b0:42d:c884:a8fd with SMTP id t13-20020a05622a180d00b0042dc884a8fdmr1352574qtc.21.1708663949072;
        Thu, 22 Feb 2024 20:52:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAYNmpNAPMHq9a3bKc8/5KZU5bBJoUez07kPRCSYkfORJyMPrsrissYELud8isvWNRNSwRuw==
X-Received: by 2002:a05:622a:180d:b0:42d:c884:a8fd with SMTP id t13-20020a05622a180d00b0042dc884a8fdmr1352559qtc.21.1708663948756;
        Thu, 22 Feb 2024 20:52:28 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7ec:a28e:99bd:8c92:cf80:d1bd])
        by smtp.gmail.com with ESMTPSA id qn5-20020a056214570500b0068fbdafa771sm1585415qvb.5.2024.02.22.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 20:52:28 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Leonardo Bras <leobras@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
Date: Fri, 23 Feb 2024 01:52:22 -0300
Message-ID: <ZdgkhkOCGtfQbf8i@LeoBras>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <87bk89hhpm.ffs@tglx>
References: <20240216075948.131372-2-leobras@redhat.com> <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx> <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras> <87edd5hljz.ffs@tglx> <87bk89hhpm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Feb 21, 2024 at 06:04:21PM +0100, Thomas Gleixner wrote:
> On Wed, Feb 21 2024 at 16:41, Thomas Gleixner wrote:
> > On Wed, Feb 21 2024 at 02:39, Leonardo Bras wrote:
> > But as I pointed out above the detection logic is flawed due to the
> > unconditional accumulation. Can you give the uncompiled below a test
> > ride with your scenario?
> 
> Bah. Ignore this. I misread the code completely. No idea where my brain
> was.
> 
> This thing triggers only when there are 100K interrupts and 99.9k of
> them unhandled. The 100k total resets the unhandled counts.
> 
> Though one thing which strikes me odd is that this actually triggers at
> all because it needs 99.9k unhandled out of 100k total. That means on
> average every thread handler invocation handles 1000 hardware interrupts
> in one go. Is that even realistic?

Yeap, it triggers pretty easily if you bring a vm with a serial console, 
and try to use it to work with something very verbose.

It was detected by someone trying to unpack a kernel source tarball.

Maybe this is an issue that only becomes reproducible for this and maybe a 
couple extra drivers, so the solution will only need to be implemented in 
those drivers when (if) this bug reproduces.

This being said, thank you for helping me improve my understandig of this 
piece of code. I will put some effort in trying to find a solution that 
works by changing generic-code only, but would like to understand if the 
current proposal is valid if I am unable to find any.

Thanks!
Leo


> 
> Thanks,
> 
>         tglx
> 
> 


