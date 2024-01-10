Return-Path: <linux-kernel+bounces-22640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCC582A0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855BB28BC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4091B4E1C1;
	Wed, 10 Jan 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOQqFpxi"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E0A4E1BC;
	Wed, 10 Jan 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so58884766b.0;
        Wed, 10 Jan 2024 11:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704913550; x=1705518350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZpsZsIRN+bzHamFqhhdXU99QlmdJsaeUiZLcX/1HHw=;
        b=ZOQqFpxijoRV4KCOZn1ZMa9JM9bZ99FZaliEOw1cqwZPXGjYHKx1fCqfE5MREOlH4e
         XIavvv0vFiV/zv9rrcnMAYqQrNuOoC5WyiiHejCaYtC+X63gPSrGwWjuCBvEaI/2FK9o
         t/Z2PV86WXcrzVf/rsI6r2K2CItbxKs3t2bvK4cqQR9lj0RzS50/1KPFFBSPdlF/jGJZ
         AIdK9eiPWxJfHjKRYNY4apvJ3Wn2F+z4yw1i1xSrlhYTXUJLPAU7ev2ze+lSN+zHeVHb
         TL1MGFmrYHk+6W4bgH6gny6piSFpUnwmLWgKtAEJ21jad7S36jkGfc9E1kpj9AZ5ljMr
         MeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704913550; x=1705518350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZpsZsIRN+bzHamFqhhdXU99QlmdJsaeUiZLcX/1HHw=;
        b=DggMrXg86w+hTQFTu+mBm5EwGISkq+R0gcs1+ReGDyDDIdNWXA/Dwo7FKfunW8LUOJ
         rflW6NmGK7wj7rVBqafhdLaPDkj8bd7BsjafjNHWcogkeu19/beIJuYUjtfKvz4GFmiS
         l5N8sHUxS6f6c+ly8YimkwgLgFa9v5SLwiNwHA6Js34YFEY8d7Q1vHOgcAOX3YhWrqUT
         JQJFe8v1l90SA3h6eB1DYShBVcyyqD2PqDfVU7EurKkZVLa3EWATvN+HaIWxK9WqhH7G
         nnpNnQSQ8zD07P9w5LvuUBEg92kKO/DiDl2zJdLVsk9JrsUcQOoblIfLBJZ2L1rr5XgS
         hAYQ==
X-Gm-Message-State: AOJu0Ywom7cDDWHvNEKjQfQn+IiQ4xw/PRFoOC37pkW4a5HMp4Wi//ku
	7Y9hj4Kzgz5y4qxYJeEa9b4=
X-Google-Smtp-Source: AGHT+IGIJTfwmJqtwq2wBgoYLHTva5azTT7ETKZwtCsbHP8vya/7GCSPS1LSo6tEkI1WcsBOstlQMg==
X-Received: by 2002:a17:906:250e:b0:a29:445f:a1 with SMTP id i14-20020a170906250e00b00a29445f00a1mr817039ejb.140.1704913550038;
        Wed, 10 Jan 2024 11:05:50 -0800 (PST)
Received: from andrea ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id ko1-20020a170907986100b00a2714f1ba8asm2334847ejc.160.2024.01.10.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:05:49 -0800 (PST)
Date: Wed, 10 Jan 2024 20:05:44 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org, corbet@lwn.net,
	mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
	charlie@rivosinc.com, rehn@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] membarrier: Create
 Documentation/scheduler/membarrier.rst
Message-ID: <ZZ7qiIDFDEMEfNiS@andrea>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
 <20240110145533.60234-3-parri.andrea@gmail.com>
 <63046420-264a-4e7c-b45c-17f0486ba4d9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63046420-264a-4e7c-b45c-17f0486ba4d9@infradead.org>

Hi Randy,

> > +MEMBARRIER_CMD_{PRIVATE,GLOBAL}_EXPEDITED - Architecture requirements
> > +=====================================================================
> > +
> > +Memory barriers before updating rq->curr
> > +----------------------------------------
> > +
> > +The command requires each architecture to have a full memory barrier after
> > +coming from user-space, before updating rq->curr.  This barrier is implied
> > +by the sequence rq_lock(); smp_mb__after_spinlock() in __schedule().  The
> > +barrier matches a full barrier in the proximity of the membarrier system
> > +call exit, cf. membarrier_{private,global}_expedited().
> > +
> 
> What does "The command" refer to above and below, please?

The term was meant to refer to any of MEMBARRIER_CMD_PRIVATE_EXPEDITED and
MEMBARRIER_CMD_GLOBAL_EXPEDITED (from the section title); FWIW, this seems
to align with the terminology adopted in MEMBARRIER(2) for example.

Mmh, unless I get a better idea, I'll expand those occurrences to:

  "The commands MEMBARRIER_CMD_PRIVATE_EXPEDITED and MEMBARRIER_CMD_GLOBAL_EXPEDIDED
   require [...]"

  Andrea

