Return-Path: <linux-kernel+bounces-74044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D267785CF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D7F1F25639
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295A39843;
	Wed, 21 Feb 2024 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3m4VCty"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F038F9A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708488587; cv=none; b=kpBaBsbJfe+6rXKkYn0aV18QK9/+tZswUAFREKlNXNmvEmOXG2tRSZCgnbVofm+JMh7pSDdwPVIQN6gGqk+HQpGYU+lgGc4e0NCt4Yf1J1udTwTt2Z9B6t3dGZjoo9o/p2qOb+qrXkmJpKuph1xwCOhr65X0oQVkr0pCHCQ2ZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708488587; c=relaxed/simple;
	bh=BoyCv2XA0C+7+JVVbWVZj+xrfGVaW1aWdR2j51+n5oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHrkAoAff96kf6PkFoaeLyDfqOil2sChyL6hivLCIh7RMPjA9ccAsvOGK8nBEf4QiUsRvXW0iWh52iQPiqTmPo8w5np9B2qkCP98cPq4vqRMWznzrXYL714aG3KSiYnfT6TwXG0SR19fmplSnpH8NO6j4CudvPj96BmldzqafzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3m4VCty; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708488585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsQAEkKxZb0aZZCrLYFKwxoDfNw0XHFkzbzp2yj/GkI=;
	b=N3m4VCtyRKZV+zd8ZEVZ+duFKEAggx1bKWpHK0tEPueO2lg4ioT4oBmHtltMOhYYQkXkXY
	6aYavhG3M84OF4WB5CZRNIimS64Awf7O+nVzh4YXof+2kA328HeMjL3pNmVkwjRMb2eNo0
	8X+adkFOd3ZN5+CFIYxugcRu1dK7DyM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-2UcE3aclOLOVLXgp_FzhfA-1; Tue, 20 Feb 2024 23:09:42 -0500
X-MC-Unique: 2UcE3aclOLOVLXgp_FzhfA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-787729caa1aso34249485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:09:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708488582; x=1709093382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsQAEkKxZb0aZZCrLYFKwxoDfNw0XHFkzbzp2yj/GkI=;
        b=IkloUe29CSDcgNl3Tk5WWYWuYXPGlrIqtvIjEOH/1xqA0WgPX64KehF8v6/7CV00/T
         nu6Pi7ZQB0+DKfkvCIF5qqdAEqNhK9g92Gv3IdcMvtZEUgMo/i3b1xY5nbGve5tg0yRb
         OhZmYU9cULmqo2XojclJwxSo3mueoN5slDtxmufsofpfJ5UrrqRcMqPjsGQPNv7vbq1t
         srIy3+D7uwVNCaXJMi5sE0sOoS4aIB4HSx9bvd0yE7C8UbKtE8lrwBZYtPK80NAMoW+Q
         n0OGcoDsopDNUlu9sg6EAhBbOqovVlrdC04OlUmp+f/4vM/sgUk/OTsjosH8MVflOQGj
         CS0A==
X-Forwarded-Encrypted: i=1; AJvYcCWcwgcqLnHwAn+ZqZLHaJ41LTIkOc2s0bxUrRQNtZ0Ll+QqPyF8zWyZpVk4z9VFzU5wAokQS5iX2tDIFU6SDYb/yQLAkf2eTDbRcvvm
X-Gm-Message-State: AOJu0YzfjGTzFyHN/qmaAgELtAVh9ct2Pzdi0v7j9KDpXRoCQu9FpLHN
	1iXVCW9MwQyGl4yRIIo/HOFz+R2JI0fZiMCNDvcEAPzpWKKhtAu+1GGfF6O/XL0qZd5IZBfYiRF
	e45YAu2+L/qiTBqESJYcaZF96nBdpU9qrFOuOvfj975NW6k+Azk2zCmJDDQ4PGQ==
X-Received: by 2002:ae9:e909:0:b0:787:2be6:f572 with SMTP id x9-20020ae9e909000000b007872be6f572mr18916159qkf.44.1708488581877;
        Tue, 20 Feb 2024 20:09:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5y9sT0LbGkPWM3P5wTe+4FBnoWsvYcHd8UtO9gZCCHpP2FiZzrnexj0maTEh9uzunTOHKag==
X-Received: by 2002:ae9:e909:0:b0:787:2be6:f572 with SMTP id x9-20020ae9e909000000b007872be6f572mr18916145qkf.44.1708488581624;
        Tue, 20 Feb 2024 20:09:41 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id z17-20020a05620a101100b00787375c5b64sm3967768qkj.17.2024.02.20.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 20:09:41 -0800 (PST)
Date: Tue, 20 Feb 2024 23:09:40 -0500
From: Eric Chanudet <echanude@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Changbin Du <changbin.du@huawei.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyi Su <suxiaoyi@huawei.com>
Subject: Re: [PATCH v3] modules: wait do_free_init correctly
Message-ID: <5bq77rkoutmjzv2fuw2jjsmqxfzsv2wiyz3swvpgs7hsbyxtpx@pgczoajxjvuy>
References: <20240217081810.4155871-1-changbin.du@huawei.com>
 <20240218132153.d93675d0d241f021565a08b6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218132153.d93675d0d241f021565a08b6@linux-foundation.org>

On Sun, Feb 18, 2024 at 01:21:53PM -0800, Andrew Morton wrote:
> On Sat, 17 Feb 2024 16:18:10 +0800 Changbin Du <changbin.du@huawei.com> wrote:
> > The synchronization here is just to ensure the module init's been freed
> > before doing W+X checking. But the commit 1a7b7d922081 ("modules: Use
> > vmalloc special flag") moves do_free_init() into a global workqueue
> > instead of call_rcu(). So now rcu_barrier() can not ensure that do_free_init
> > has completed. We should wait it via flush_work().
> > 
> > Without this fix, we still could encounter false positive reports in
> > W+X checking, and the rcu synchronization is unnecessary which can
> > introduce significant delay.
> > 
> > Eric Chanudet reports that the rcu_barrier introduces ~0.1s delay on a
> > PREEMPT_RT kernel.
> >   [    0.291444] Freeing unused kernel memory: 5568K
> >   [    0.402442] Run /sbin/init as init process
> > 
> > With this fix, the above delay can be eliminated.
> 
> Thanks, I'll queue this as a delta, to be folded into the base patch
> prior to upstreaming.
> 
> I added a Tested-by: Eric, if that's OK by him?

Absolutely, I should have put it in my initial reply.
Adding here as confirmation:
Tested-by: Eric Chanudet <echanude@redhat.com>

Thanks,

-- 
Eric Chanudet


