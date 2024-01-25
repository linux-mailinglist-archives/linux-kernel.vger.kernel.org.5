Return-Path: <linux-kernel+bounces-37870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0EA83B6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EE41B22C81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E86FB6;
	Thu, 25 Jan 2024 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StPO1YO0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710706FA7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147176; cv=none; b=oZViLPouNGuSBNQBJgzOqtEXZaRWrdvM3R0f1fuVb2LZbZ1v1gfqirKbAq2BX77FiX3Nyj4NcPXUS1/nqdR4wouPU8MzPkdu3GpE6Hp3yYH7Ck/MXucfq0rqvF7rP917gAdXtbw9K+l5dY7qhJqO1VlxBYBAAEVyudCb/ZWwOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147176; c=relaxed/simple;
	bh=fjmtpJ7q/lS0U+Khvkr75VVCbgpAmzn0ftT4yuRLr2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=pD766Wt8p5C6n1NbgW+uJaGik58AS4RqLomYlIYLPHw/xYy0KqVpnNr1lLGDGlcVayZj1ezZakAforSFnlgLk/YqUqo0IUxXfXnnao/3wHnv8wdyhv5PF00x4v8qAwDDxCKAeItFqX5LYNjiFSnvFjbScCnxVwU6DeiFCH5iv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StPO1YO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706147173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uajPvW7EGTqbPwMefv/yFhWhkkKtrL1JBmDIdQfljm4=;
	b=StPO1YO0kknCiWueiSZkm5hZ/MiNaMBL4j9cydMvd265gdb3lXYcpPTdgwZgsTFDFnrukA
	0xVweOQcBa4a/MVOPQlgR5UYf0NyPv7m7l0up5G3VphC73ngEbF7rvwMG7LkgQ3RX4bqji
	wHOyWUobA2/QlXRxu7Oko7y/QUFjIWQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-zn9GG57vNPGVcNHtcmtZxQ-1; Wed, 24 Jan 2024 20:46:11 -0500
X-MC-Unique: zn9GG57vNPGVcNHtcmtZxQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6da0d1d6674so8750937b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:46:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706147170; x=1706751970;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uajPvW7EGTqbPwMefv/yFhWhkkKtrL1JBmDIdQfljm4=;
        b=pVcvedTO+sRod1IFF32ZfZgv9iAbxA8J7amRGG4xEBUCQBVRQztyxOa6ZgYkkjlKlt
         /KOpPRy4WdACACXj0LgV0tCus1YNx9JhUAv5Pu0h7IzWZ4QHuJln+K/l3EK6pW9coR7n
         qP6FVH0bMhVagLbpBlYizNrmfB5DMZb0vnqNDi7rDdQPoScN1Xpe8ART7tO7NKEKLeR1
         oy2tFwuzjUkt1OwWFDEG6LwbPtMnlpzZDsfSr4+wW2YiMD0W8V51K8rqX55BcSVg5B4z
         Uvj2GQVNOjUsZymZYblV3kIei+yxhSGUexL3Cw905U3Y1I/7n0zYVq+73H7spREybKwO
         b6dQ==
X-Gm-Message-State: AOJu0YxB0cfX9tmlWyFl+lmjgKMeq2vq1CwCv40ekDw7u01V79TUEEfS
	yIXFoPtX8GuneNpqghZd+OIfyQSeV/Xib+BNJiTpqqL8+xDvBOa3D8ZF9aY7qH4VUkA33VrMMYa
	er1KZYzaKiseTIVPxzAobruFB6AKQYYca72UbiPn9NcLKVt7TV3gfhLebF6A8BA==
X-Received: by 2002:a62:84ce:0:b0:6db:c9d2:12da with SMTP id k197-20020a6284ce000000b006dbc9d212damr144201pfd.46.1706147170175;
        Wed, 24 Jan 2024 17:46:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoK+eEFpHqcme0zfJ7zZsUn4sk2MowErIC9zfVItATMiF2jrlpTCs/XJfu0ECni7JPR+K6rQ==
X-Received: by 2002:a62:84ce:0:b0:6db:c9d2:12da with SMTP id k197-20020a6284ce000000b006dbc9d212damr144198pfd.46.1706147169865;
        Wed, 24 Jan 2024 17:46:09 -0800 (PST)
Received: from localhost.localdomain ([2804:1b3:a803:96a5:ba81:becc:80f3:6a79])
        by smtp.gmail.com with ESMTPSA id ey20-20020a056a0038d400b006dbda7bcf3csm7437890pfb.83.2024.01.24.17.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:46:09 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] wq: Avoid using isolated cpus' timers on unbounded queue_delayed_work
Date: Wed, 24 Jan 2024 22:45:50 -0300
Message-ID: <ZbG9TjHAMJYIvwsg@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZbGFce8ixJKb6umE@slm.duckdns.org>
References: <20240124082938.2527697-2-leobras@redhat.com> <ZbGFce8ixJKb6umE@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jan 24, 2024 at 11:47:29AM -1000, Tejun Heo wrote:
> On Wed, Jan 24, 2024 at 05:29:37AM -0300, Leonardo Bras wrote:
> > +	/*
> > +	 * If the work is cpu-unbound, and cpu isolation is in place, only
> > +	 * schedule use timers from housekeeping cpus. In favor of avoiding
> > +	 * cacheline bouncing, run the WQ in the same cpu as the timer.
> > +	 */
> > +	if (cpu == WORK_CPU_UNBOUND && housekeeping_enabled(HK_TYPE_TIMER))
> > +		cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
> 
> Would it make more sense to use wq_unbound_cpumask?

Hello Tejun, thank you for this reply!

That's a good suggestion, but looking at workqueue_init_early() I see that, 
in short:
wq_unbound_cpumask = 	cpu_possible_mask & 
			housekeeping_cpumask(HK_TYPE_WQ) & 
			housekeeping_cpumask(HK_TYPE_DOMAIN) &
			wq_cmdline_cpumask

So wq_unbound_cpumask relates to domain and workqueue cpu isolation.

In our case, we are using this to choose in which cpu is the timer we want 
to use, so it makes sense to use timer-related cpu isolation, instead.

As of today, your suggestion would work the same, as the only way to enable 
WQ cpu isolation is to use nohz_full, which also enables TIMER cpu 
isolation. But since that can change in the future, for any reason, I would 
suggest that we stick to using the HK_TYPE_TIMER cpumask.

I can now notice that this can end up introducing an issue: possibly 
running on a workqueue on a cpu outside of a valid wq_cmdline_cpumask.

I would suggest fixing this in a couple ways:
1 - We introduce a new cpumask which is basically 
    housekeeping_cpumask(HK_TYPE_DOMAIN) & wq_cmdline_cpumask, allowing us 
    to keep the timer interrupt in the same cpu as the scheduled function,
2- We use the resulting cpu only to pick the right timer.

What are your thouhts on that?

Thank you!
Leo


