Return-Path: <linux-kernel+bounces-67071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E1A8565BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B95DB2606E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C48131E32;
	Thu, 15 Feb 2024 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgC1OkQR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D6129A73
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006695; cv=none; b=GubnBY2t/wdAcmOnTt2qJcK3htzt6z3r5xRP2GIsznFmV7kAzqULkT2Ffn0cSBO9ypyP/biJMDz8jzOeB45eHPM3Tw6dc+lKUBHJ5lyt3WcjNB4UUJ2A+CEaMj7Gpkz6T+CPDMZ3PKkRAMovsjk5jJmB53Ms9uhymEI8lX+qhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006695; c=relaxed/simple;
	bh=4bponqr+cXqIij1rXjTmt1CR6Ub5f39mO6gYdR7XDjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOq/2aMBZK3qKCpc4JZeCsiXSLSDRgVJ2aKlSah6cD14riyIpNMQH/QCKGPn01jXHD8BUNanLfTZc+PtnzHbi8YGNbg1G/Uf2bgjO1z6Wxdm+bF1C7mXlxReFQ2fWg0OF4VXeclEPKzJ5PBOgbFoSpla1W1zoFdCuTZJqNvAoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgC1OkQR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708006692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTgy7CmCplgGNTODQfgNUD/LxhamGxog3zQ/EAXJjp8=;
	b=KgC1OkQR+8mKEKJJxG03hJFMblII3HR8+oyfOAS97DKv227j6BKWN4NP4wZWJkEjT8DSEX
	SV4xmgTZlfoxeiK0ThLvHeXcty3XB3F3qoD71SNYkuNLY+NfqosAGuUrEyOQ38HKnaZWpJ
	aq8yiahVS2VKDvwiGq85CL8InwS0taY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-ECAYe8b2MSavNm3iq8_DUw-1; Thu, 15 Feb 2024 09:18:11 -0500
X-MC-Unique: ECAYe8b2MSavNm3iq8_DUw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dbf618042daso1388216276.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006690; x=1708611490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTgy7CmCplgGNTODQfgNUD/LxhamGxog3zQ/EAXJjp8=;
        b=mFF+4vUn/gpdjdiP3s6MDIBUtSRfrMsQOtEC9FMPbNb+bTPdi0gg/R091du2FpyrSU
         /F9/QNYEmewpnND1nsARuxncohzEH/Jay578Nh1UVB90eOy6Mbxy4yyChx5U6nYe769m
         SjNqg/1l4cfMlgMnyDpT8zwSExnzLEzDU6Ine5GRP1YzNQGkYz1GlC9sRzz9z5FEkVyP
         VpZK/aR/4A0fd68tdkHLRGkA7MvQfrJUfEVIEVAGjQM18q+BCuc4UK/c45leBUJqKSJh
         eIbfLj32ocTNAelalW2eIEbcUTBg0FzUXRu8osDM3E/e7szQE6aJVNImV1/rYq7tBFpL
         9CXA==
X-Forwarded-Encrypted: i=1; AJvYcCWwjg1jTR8wDvTIj3B2S9eKlsd8Gp2gacf3qCTvS0VZJVn9lJlaOlnjAAlIHOaUO+O5WLw72HnVs2bwYnDJPBDoUPtLagkytdBIlh1q
X-Gm-Message-State: AOJu0Yy2XS6GEJVgd6yCLn0R0nqRKU5L5NCY/HSxiKvJBsiZuW3Bbs9D
	BvKsXXhUgYFhEP/5a/fGrNhgL7bhRARuhHHEftcV+x7dsu7I//cuMu8OTfmF6exxRfIbuNVscdp
	ZWvYR3NWtjfHQS3DfqKukYU7HTBHuT9/QxCTFyJJqsJ+uP5/WHi5UdlKbzkd1jku5lkXcBg==
X-Received: by 2002:a25:db86:0:b0:dc6:ad43:8cf4 with SMTP id g128-20020a25db86000000b00dc6ad438cf4mr1645739ybf.20.1708006690429;
        Thu, 15 Feb 2024 06:18:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/FgYIb2Y2SWwX4F80y1w/8RsMHS5vvJx3Man/kK6c6YWBouMVWYxGxnUv4WzL7MwYO11v4Q==
X-Received: by 2002:a25:db86:0:b0:dc6:ad43:8cf4 with SMTP id g128-20020a25db86000000b00dc6ad438cf4mr1645713ybf.20.1708006690076;
        Thu, 15 Feb 2024 06:18:10 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id a8-20020a05620a16c800b0078721ebcfc8sm628090qkn.65.2024.02.15.06.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:18:09 -0800 (PST)
Date: Thu, 15 Feb 2024 09:18:09 -0500
From: Eric Chanudet <echanude@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Changbin Du <changbin.du@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyi Su <suxiaoyi@huawei.com>
Subject: Re: [RESEND PATCH v2] modules: wait do_free_init correctly
Message-ID: <qrq7emx7zxnmyv6qoakxpaisan2hiophf5lte4ag4di4euqzfi@3kjtbfau6nlm>
References: <20240129020304.1981372-1-changbin.du@huawei.com>
 <ZbfmNiY52KdAet7_@bombadil.infradead.org>
 <20240130014038.mawqxwoc34v6hztb@M910t>
 <ZbkFz25DtYuhkIEj@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbkFz25DtYuhkIEj@bombadil.infradead.org>

On Tue, Jan 30, 2024 at 06:21:03AM -0800, Luis Chamberlain wrote:
> On Tue, Jan 30, 2024 at 09:40:38AM +0800, Changbin Du wrote:
> > On Mon, Jan 29, 2024 at 09:53:58AM -0800, Luis Chamberlain wrote:
> > > On Mon, Jan 29, 2024 at 10:03:04AM +0800, Changbin Du wrote:
> > > > The commit 1a7b7d922081 ("modules: Use vmalloc special flag") moves
> > > > do_free_init() into a global workqueue instead of call_rcu(). So now
> > > > rcu_barrier() can not ensure that do_free_init has completed. We should
> > > > wait it via flush_work().
> > > > 
> > > > Without this fix, we still could encounter false positive reports in
> > > > W+X checking, and rcu synchronization is unnecessary.

The comment in do_init_module(), just before
schedule_work(&init_free_wq), mentioning rcu_barrier(), should be
amended as well.

> > > 
> > > You didn't answer my question, which should be documented in the commit log.
> > > 
> > > Does this mean we never freed modules init because of this? If so then
> > > your commit log should clearly explain that. It should also explain that
> > > if true (you have to verify) then it means we were no longer saving
> > > the memory we wished to save, and that is important for distributions
> > > which do want to save anything on memory. You may want to do a general
> > > estimate on how much that means these days on any desktop / server.
> >
> > Actually, I have explained it in commit msg. It's not about saving memory. The
> > synchronization here is just to ensure the module init's been freed before
> > doing W+X checking. The problem is that the current implementation is wrong,
> > rcu_barrier() cannot guarantee that. So we can encounter false positive reports.
> > But anyway, the module init will be freed, and it's just a timing related issue.
> 
> Your desciption here is better than the commit log.

I saw this problem using a PREEMPT_RT kernel as well. Setting DEBUG_WX=n
stills show a significant delay due to the rcu_barrier:
  [    0.291444] Freeing unused kernel memory: 5568K
  [    0.402442] Run /sbin/init as init process

The same delay is shorter using linux-next, but still noticeable
(DEBUG_WX=n):
  [    0.384362] Freeing unused kernel memory: 14080K
  [    0.413423] Run /sbin/init as init process

Matching trace_event=rcu:rcu_barrier trace:
         systemd-1       [002] .....     0.384391: rcu_barrier: rcu_preempt Begin cpu -1 remaining 0 # 4
         systemd-1       [002] d..1.     0.384394: rcu_barrier: rcu_preempt Inc1 cpu -1 remaining 0 # 1
         systemd-1       [002] .....     0.384395: rcu_barrier: rcu_preempt NQ cpu 0 remaining 2 # 1
          <idle>-0       [001] d.h2.     0.384407: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 2 # 1
         systemd-1       [002] .....     0.384408: rcu_barrier: rcu_preempt OnlineQ cpu 1 remaining 3 # 1
         systemd-1       [002] .....     0.384409: rcu_barrier: rcu_preempt NQ cpu 2 remaining 3 # 1
          <idle>-0       [003] d.h2.     0.384416: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 3 # 1
         systemd-1       [002] .....     0.384418: rcu_barrier: rcu_preempt OnlineQ cpu 3 remaining 4 # 1
          <idle>-0       [004] d.h2.     0.384428: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 4 # 1
         systemd-1       [002] .....     0.384430: rcu_barrier: rcu_preempt OnlineQ cpu 4 remaining 5 # 1
          <idle>-0       [005] d.h2.     0.384438: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 5 # 1
         systemd-1       [002] .....     0.384441: rcu_barrier: rcu_preempt OnlineQ cpu 5 remaining 6 # 1
          <idle>-0       [006] d.h2.     0.384450: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 6 # 1
         systemd-1       [002] .....     0.384452: rcu_barrier: rcu_preempt OnlineQ cpu 6 remaining 7 # 1
          <idle>-0       [007] d.h2.     0.384461: rcu_barrier: rcu_preempt IRQ cpu -1 remaining 7 # 1
         systemd-1       [002] .....     0.384463: rcu_barrier: rcu_preempt OnlineQ cpu 7 remaining 8 # 1
          <idle>-0       [004] ..s1.     0.385339: rcu_barrier: rcu_preempt CB cpu -1 remaining 5 # 1
          <idle>-0       [007] ..s1.     0.397335: rcu_barrier: rcu_preempt CB cpu -1 remaining 4 # 1
          <idle>-0       [003] ..s1.     0.397337: rcu_barrier: rcu_preempt CB cpu -1 remaining 3 # 1
          <idle>-0       [005] ..s1.     0.401336: rcu_barrier: rcu_preempt CB cpu -1 remaining 2 # 1
          <idle>-0       [006] ..s1.     0.401336: rcu_barrier: rcu_preempt CB cpu -1 remaining 1 # 1
          <idle>-0       [001] .Ns1.     0.413338: rcu_barrier: rcu_preempt LastCB cpu -1 remaining 0 # 1
         systemd-1       [002] .....     0.413351: rcu_barrier: rcu_preempt Inc2 cpu -1 remaining 0 # 1

With this patch the delay is no longer there:
  [    0.377662] Freeing unused kernel memory: 14080K
  [    0.377767] Run /sbin/init as init process

AFAIU, for the race to happen, module_alloc() needs to create a W+X
mapping (neither x86 nor arm64 does) and debug_checkwx() has to happen
before module_enable_nx() in complete_formation(), I didn't get a
reproducer so far.

Best,

-- 
Eric Chanudet


