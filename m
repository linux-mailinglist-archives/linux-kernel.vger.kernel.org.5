Return-Path: <linux-kernel+bounces-23340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5E82AB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419681F22C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617911C85;
	Thu, 11 Jan 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yu27uoyA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2723CB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e60e13799so2800225e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704966773; x=1705571573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/bwyoUlj5RFkg/2AGlXQggNwtIEjVVUzKBYI85mjvA=;
        b=yu27uoyA2XiaVtQ1khyZJ6l3itnUb5WcE14CZAlvbDvaY3btk6luKMRLbcg79qsPfu
         6FlpfaF6dH+6w12e3RjdShedSZbCPSgPRMReLwJZ20vRcY5FUg5noXxZXYpwe7Zukb/Q
         JzkBZSAjSV8z8FGI3Yl82SKPFHIPGnhau32zws2D5LLE6btYafc/2AQ/S8FBgDk2SIJe
         8+8/rHSPjPsd12SsNTdGbcMAsMco9RixGvFT53vEyRMcEneac/ZDF30atN1NSs9U5KZC
         ZZ5/k9TWgg1VGOQaU/8EsFY+kt4PqsfBZwbruM+HDMxgly8PL0jKX7iIF7fuane8uBMa
         wNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704966773; x=1705571573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/bwyoUlj5RFkg/2AGlXQggNwtIEjVVUzKBYI85mjvA=;
        b=xE8Fr2Im7g32BqtVkUWiZYyiSLImdUS0pRXba59ZgLq4a25nbC4I3FCUf62Foc+87n
         OltesX+U7jfViztOaAzv/dIxDmvoe1j9TW3aFjOxx+oqCCQ1tlxKpeozJ6QiOdMKTHOU
         slxhIkZFbNn1Y0TUpnKj7UK6VPaWcA7c0j+O4iyyeBxg6YUH5i8WG1V6UU5M0tEg8Lu7
         k0c+xSkRP6Qj4iCame+UwTyFsRQPmbYiwF3roLyLhlQXWU2/54CKcMscXoQxScmjQhyE
         UIhLEyVQcvbghY7TMkodCR+unKI4zL4Ah89yp/6R3fVjPkYABaQlmFM8FeibmNvd5vVk
         H9lg==
X-Gm-Message-State: AOJu0Yw7f+i4TvWgytcWBLtdeK8eTbEq7wWyAMMF3QTjhVTSyG485OgM
	8MgePmSbskmIXzrUyFHNuaX0PxV59yqu
X-Google-Smtp-Source: AGHT+IEktLB3zxjXBruDI/lcCgkzMrMI7MyWCGvE3+Giv7rJ5camo0QlU/jlj4z8HKX03sZpaqnJjA==
X-Received: by 2002:a05:600c:6a8d:b0:40e:52d3:ff64 with SMTP id jl13-20020a05600c6a8d00b0040e52d3ff64mr272953wmb.188.1704966773239;
        Thu, 11 Jan 2024 01:52:53 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm5064362wmn.23.2024.01.11.01.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:52:52 -0800 (PST)
Date: Thu, 11 Jan 2024 09:52:49 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com
Subject: Re: [PATCH v10 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZZ-6cQkdehcnNNDy@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
 <20240105094729.2363579-2-vdonnefort@google.com>
 <20240109234230.e99da87104d58fee59ad75c6@kernel.org>
 <ZZ1ir0edlY3OzjyC@google.com>
 <20240110084205.2943f88bf8b797b04297b0ae@kernel.org>
 <20240109185813.5e071eab@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109185813.5e071eab@gandalf.local.home>

On Tue, Jan 09, 2024 at 06:58:13PM -0500, Steven Rostedt wrote:
> On Wed, 10 Jan 2024 08:42:05 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > On Tue, 9 Jan 2024 15:13:51 +0000
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > > > @@ -388,6 +389,7 @@ struct rb_irq_work {
> > > > >  	bool				waiters_pending;
> > > > >  	bool				full_waiters_pending;
> > > > >  	bool				wakeup_full;
> > > > > +	bool				is_cpu_buffer;  
> > > > 
> > > > I think 'is_cpu_buffer' is a bit unclear (or generic),
> > > > what about 'meta_page_update'?  
> > > 
> > > Hum not sure about that change. This was really to identify if parent of
> > > rb_irq_work is a cpu_buffer or a trace_buffer. It can be a cpu_buffer regardless
> > > of the need to update the meta-page.  
> > 
> > Yeah, I just meant that is "for_cpu_buffer", not "rb_irq_work is_cpu_buffer".
> > So when reading the code, I just felt uncomfortable.
> > 
> 
> How about "in_cpu_buffer" as that is what it is.
> 
> struct ring_buffer_per_cpu {
> 	struct rb_irq_work {
> 		bool	in_cpu_buffer;
> 	}
> }
> 
> Would that make you feel more comfortable? ;-)
> 
> -- Steve

I'll actually solve that by moving that update from the rb_irq_work to
ring_buffer_map_get_reader().

Reason is the rb_irq_work is only triggered when !O_NONBLOCK is set.

> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 

