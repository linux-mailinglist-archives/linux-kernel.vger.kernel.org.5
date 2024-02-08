Return-Path: <linux-kernel+bounces-58514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27D984E761
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A451F257FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E488564E;
	Thu,  8 Feb 2024 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="L8u32hkt"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D785C54
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415569; cv=none; b=X4YOYH4KnNV65pBh0ekyCgSgHKSxNnQ4K2rv+5jt0KW3LxAibKk9lEOfFWCsgmhMw8eenWTANPWyQq1zRZ3aJpJk+L/XwUQH7Re9fsYhdhEDG2cZdfLc3k+FwRApZUhB3VaUV3ssY6ZPzgt/0gPYavwOj4Gcbzwa7jDCE9VD0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415569; c=relaxed/simple;
	bh=xC5QCnXXBK7bvpi8MCxTQICVE6CAcA0xsrG3ESr1Sfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEhF9LZ8GtP5Yqk8/0zjLeP5+ZLx0C2ukEapEbTMNEqObFUUN/N2XhZmQgzLUDwC8ZevWWTDdgkKvkARo34bSrnXIxpSl1wdYTf/Y5UGyEgT7dq3s/YBIU1PqJV2FlQN1qWueRimgxtK4ZWXmlNY6ctqFiheB5ohfwYnmGltpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=L8u32hkt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d93f2c3701so329215ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707415567; x=1708020367; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyO9y1/60yNueYfFOT27jFz7V2JcKvZg+F1VRSMO9kI=;
        b=L8u32hkt7a/1UvcUAPT1PeMkjqSG24Zl/gIwCABtn1Gvx65ADeRR6DOTVsXzkne0Aj
         pNd7sg8LBtQjQEl7S2437rL4iluyZNQnrtF+GibmEknrJ2W8jr3yCuToyxvvTzU5OxiD
         +lyM7rURcsr7hxD5acgXPsVdzDwh12DBArLzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707415567; x=1708020367;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyO9y1/60yNueYfFOT27jFz7V2JcKvZg+F1VRSMO9kI=;
        b=R1UpWS0Z0PxSADcWYh6NuXhLPCSbQsM4jaiQBfbPOE1zRUwDcaRLot6ykc17Bma5SG
         YaywUXBVjC8fOp8+1KC2uvLVJ/iyj1B1FkgSj/AclUthXIsxBVxbOe01TQJhhH3Uoqhe
         dFyLL5OP7/oZP2Ng59P6bnQJ1RqWcL1KMCE37dKDZicSsIW1Zi3cpc+uOINJ/GNnh3V4
         0vzO5doORxiX3iCUeA9n33quRlvk+8+aqpz1iShF/9wZyB/ik3WlsfexJPVHDOsKXtmb
         nItkyFhBKhhooKBLNCT7BzFn1hqRhVlTzca6L5Tsr5M+gyUHLMr3j1s3wyeFceiUGMI2
         rCKQ==
X-Gm-Message-State: AOJu0YyQSWcO7rBDGpK0e7quAvAPw7mRM1EBnnu08+7mUb5ML9aB63HL
	nBqQZMsorgjhNzBRpA4OZK9SUT5VQsII6PqVG3UALgZxJglrXtdhK8fiYFUHKwo=
X-Google-Smtp-Source: AGHT+IHrz2tFNy2QbiPOz4XPRzm4P+q7m8caXKrWJX+Ol8YJopme808b54diuilFRAG1eYJeWNDAnQ==
X-Received: by 2002:a17:902:f54f:b0:1d9:8e37:56d6 with SMTP id h15-20020a170902f54f00b001d98e3756d6mr11434017plf.40.1707415566767;
        Thu, 08 Feb 2024 10:06:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWS0j40QPWsdpPf1oTaRfWi3QohPenZFcRoP1MCYAoyp8E0jZdRYABg7JCWrjKxXQoVx1yBMwKiU4kYusKEjSlPSjT/hN148DQ1xpWyWq0iAWDyFN/auLMpJcmQp01DUgshjZaQv0ukkct555GkEQ2dKLOAU6ZxBWae3ncyukRs85HOHIKhb7FWa9VJ8JG3q6zqZK+fDl4OTcDAOSz/VFlVI0tpWmHBiswDvcSaoMqmqCTBHSSWXN3WxDp303QGKmeKNMI9Kn+pMolMKpaRV6E4JMdtH4Ob1/0+H972tJlyncQIqg9sV33nI11UsVLwNLn8sCx0ctgdFUReruGgIGwqWuQCL/9ZpTpXYiz4hTmKk6ZsiJ8Q+QvbR0yC2n6SZmS/s4XpwE+9KVwCxAit7zY/IT+2Vhgrf5LKzJP9OGQ9AO2KPQFXkOUitlU6u5W4z89IHgQR4moWfy3eVGfEVpbzNPKNOeMpMG/Z9BF93TNhjW091M6ibTksQ0GsOI0+vePh3FIaaj8r/nj8BXdobYXunYqjApilXiXHFV7x38YsUobDqgxu2+5/byP9j1kKi4hX5qOpVJ7yOnVfPoANLSyyZQZJ+0Wc7peDcDDk
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id lh5-20020a170903290500b001d8d56a8b9fsm44183plb.105.2024.02.08.10.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2024 10:06:06 -0800 (PST)
Date: Thu, 8 Feb 2024 10:06:02 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org, willemdebruijn.kernel@gmail.com, weiwan@google.com,
	David.Laight@aculab.com, arnd@arndb.de, sdf@google.com,
	amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240208180601.GA3005@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
 <20240205210453.11301-2-jdamato@fastly.com>
 <CANn89iJY8mTn3PViBvTh_DewUKWjc0z3cvJvr8AcQgcbWC4G0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJY8mTn3PViBvTh_DewUKWjc0z3cvJvr8AcQgcbWC4G0Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Thu, Feb 08, 2024 at 06:46:25PM +0100, Eric Dumazet wrote:
> On Mon, Feb 5, 2024 at 10:05 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Allow busy polling on a per-epoll context basis. The per-epoll context
> > usec timeout value is preferred, but the pre-existing system wide sysctl
> > value is still supported if it specified.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  fs/eventpoll.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 45 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 3534d36a1474..ce75189d46df 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -227,6 +227,8 @@ struct eventpoll {
> >  #ifdef CONFIG_NET_RX_BUSY_POLL
> >         /* used to track busy poll napi_id */
> >         unsigned int napi_id;
> > +       /* busy poll timeout */
> > +       u64 busy_poll_usecs;
> >  #endif
> >
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > @@ -386,12 +388,44 @@ static inline int ep_events_available(struct eventpoll *ep)
> >                 READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
> >  }
> >
> > +/**
> > + * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
> > + * from the epoll instance ep is preferred, but if it is not set fallback to
> > + * the system-wide global via busy_loop_timeout.
> > + *
> > + * @start_time: The start time used to compute the remaining time until timeout.
> > + * @ep: Pointer to the eventpoll context.
> > + *
> > + * Return: true if the timeout has expired, false otherwise.
> > + */
> > +static inline bool busy_loop_ep_timeout(unsigned long start_time, struct eventpoll *ep)
> > +{
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> 
> It seems this local helper is only called from code compiled when
> CONFIG_NET_RX_BUSY_POLL
> is set.
> 
> Not sure why you need an #ifdef here.

Thanks, you are right.

I'll move this down to be within CONFIG_NET_RX_BUSY_POLL and get rid of the
#ifdef for the v7.

Thanks for your review.
 
> > +       unsigned long bp_usec = READ_ONCE(ep->busy_poll_usecs);
> > +
> > +       if (bp_usec) {
> > +               unsigned long end_time = start_time + bp_usec;
> > +               unsigned long now = busy_loop_current_time();
> > +
> > +               return time_after(now, end_time);
> > +       } else {
> > +               return busy_loop_timeout(start_time);
> > +       }
> > +#endif
> > +       return true;
> > +}
> > +
> >  #ifdef CONFIG_NET_RX_BUSY_POLL
> > +static bool ep_busy_loop_on(struct eventpoll *ep)
> > +{
> > +       return !!ep->busy_poll_usecs || net_busy_loop_on();
> > +}
> > +
> >  static bool ep_busy_loop_end(void *p, unsigned long start_time)
> >  {
> >         struct eventpoll *ep = p;
> >
> > -       return ep_events_available(ep) || busy_loop_timeout(start_time);
> > +       return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
> >  }
> >
> >  /*
> > @@ -404,7 +438,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
> >  {
> >         unsigned int napi_id = READ_ONCE(ep->napi_id);
> >
> > -       if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
> > +       if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
> >                 napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
> >                                BUSY_POLL_BUDGET);
> >                 if (ep_events_available(ep))
> > @@ -430,7 +464,8 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
> >         struct socket *sock;
> >         struct sock *sk;
> >
> > -       if (!net_busy_loop_on())
> > +       ep = epi->ep;
> > +       if (!ep_busy_loop_on(ep))
> >                 return;
> >
> >         sock = sock_from_file(epi->ffd.file);
> > @@ -442,7 +477,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
> >                 return;
> >
> >         napi_id = READ_ONCE(sk->sk_napi_id);
> > -       ep = epi->ep;
> >
> >         /* Non-NAPI IDs can be rejected
> >          *      or
> > @@ -466,6 +500,10 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
> >  {
> >  }
> >
> > +static inline bool ep_busy_loop_on(struct eventpoll *ep)
> > +{
> > +       return false;
> > +}
> >  #endif /* CONFIG_NET_RX_BUSY_POLL */
> >
> >  /*
> > @@ -2058,6 +2096,9 @@ static int do_epoll_create(int flags)
> >                 error = PTR_ERR(file);
> >                 goto out_free_fd;
> >         }
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> > +       ep->busy_poll_usecs = 0;
> > +#endif
> >         ep->file = file;
> >         fd_install(fd, file);
> >         return fd;
> > --
> > 2.25.1
> >

