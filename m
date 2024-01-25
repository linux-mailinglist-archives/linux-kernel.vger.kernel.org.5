Return-Path: <linux-kernel+bounces-37944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F883B8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05DC62882F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183D79F5;
	Thu, 25 Jan 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dyPVqaQl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3572579C3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706156872; cv=none; b=MdVHzqij/RSCETZ9PJG5X1YvPEtaxzo0C62IRByBzNhFdj/oSVpAlB63PMh61rZJU3lc5wcih0cz7MmLpWc+XiTdJVJ0RU+SEm666r8VLJ9DJjU7HsTXZI7lN73iFFJHJbV1aBSHQvBK2qM79CBkV+N5XnB7sGtegAGlipH9KPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706156872; c=relaxed/simple;
	bh=lIfuTtl3aEsKWd1/M5iG6xOhbAb1ZbPoQeY3ffJT+Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sllO9nR8GiwWpBf1dIlSyCP0fSMWFnImyilQCY/Bv7ygz6sYfoCpmPsKzqGiK/UAqLm83QJvOHYiClHooV6r0j/OXj2oQzUgjiPcdToMXBeN4EKMePFbNG7I45Z0eMD9AebjSFlQtIaO5/af2qEVPWH+QS05zdtQwS/khAmDAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dyPVqaQl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so23111b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706156869; x=1706761669; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpH2KvFiU/STY59iJ6mG2mSK7bet26SLv0PAMIAM0Ao=;
        b=dyPVqaQlUmcgNRSYSxzP1E5VmhAMzDARWg3sX4UdRDMLJZbVF5lpceW3hzAIIiv6M3
         kChJW1UOatLQY3LoZFbA/vER6LJbvGVc4V0gPiz/dLGK3hLltLuY800UZS6fz5seb7Qy
         Cwqp3TbngEFoyKE66aD3N5zLszD957gfsu5Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706156869; x=1706761669;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpH2KvFiU/STY59iJ6mG2mSK7bet26SLv0PAMIAM0Ao=;
        b=tCXPJ9xHOixWZzCgGwkG5ABJU0x6XlOnxbVeIbgSgOkQHyNUhHwG5lQF8hDuQLQkuF
         owKVovUCRIWni6Q1u9noSbwzIy6qlFTzNV1KcatNQHYd5S+67RNNAtx9B0QhlWHzcMeE
         XLfNhZXuBsJmbyLgoNXHgRbXBgQwNu431pMc9aBQRuqSgzH4+k6471wj/ZD/4ZYEmo9y
         Mme53RG85VrWqakiukDF/sRQG/F/cb8jsXz09kxLQBXfgbWMX7TZFFjvUkkJDqfsfA/q
         sbMGZTTDbxgNxUQk4V5a5iIt2yOnbC2bnkQsbCgcu1xenWzfBXx4ZKVVcql1+tX0dL6Y
         ef9A==
X-Gm-Message-State: AOJu0Yx7IHbwh8nhjHqXSHh/NDsgtiQhU/qeNtWLTb08lv57NbmeFmaT
	2O2ZjrN26Bm1J/wpPgs0NLNBiUlmv1sU/FEVTA8DYcQu6bezhjUXCRZSDJ+1/YQ=
X-Google-Smtp-Source: AGHT+IEMK60hM9+dvuHXVTLdv6XvNIPdbOe/Hr8XPAw+3D9QI2ixN0Ub2N/p6vZUgwOyj/PaRC9xhw==
X-Received: by 2002:a17:902:d4cb:b0:1d5:e300:37bc with SMTP id o11-20020a170902d4cb00b001d5e30037bcmr404300plg.51.1706156869509;
        Wed, 24 Jan 2024 20:27:49 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902c9cc00b001d7267934c7sm8806684pld.298.2024.01.24.20.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2024 20:27:49 -0800 (PST)
Date: Wed, 24 Jan 2024 20:27:46 -0800
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org, weiwan@google.com
Subject: Re: [net-next v2 3/4] eventpoll: Add epoll ioctl for epoll_params
Message-ID: <20240125042746.GA1294@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
 <20240125003014.43103-4-jdamato@fastly.com>
 <65b1cb7f73a6a_250560294bd@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b1cb7f73a6a_250560294bd@willemb.c.googlers.com.notmuch>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Jan 24, 2024 at 09:46:23PM -0500, Willem de Bruijn wrote:
> Joe Damato wrote:
> > Add an ioctl for getting and setting epoll_params. User programs can use
> > this ioctl to get and set the busy poll usec time or packet budget
> > params for a specific epoll context.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> Please be sure to include the lists and people suggested by
> `get_maintainer.pl -f fs/eventpoll.c`.

Thanks - I must have done something wrong when trying to get the maintainer
list.

Should I resend this v2? Not sure what the appropriate thing to do is in
this case. My apologies.

> Adding ioctls is generally discouraged.
> 
> As this affects the behavior of epoll_wait, should this just be a
> flag to (a new variant of) epoll_wait?

I have no strong preference either way. It seems to me that adding a new
system call is a fairly significant change vs adding an ioctl, but I am
open to whatever is preferred by the maintainers.

I have no idea who would need to weigh-in to make this decision.

> Speaking from some experience with adding epoll_pwait2. I initially
> there added a stateful change that would affect wait behavior. The
> sensible feedback as the time was to just change the behavior of the
> syscall it affected. Even if that requires a syscall (which is not
> that different from an ioctl, if better defined).
> 
> The discussion in that thread may be informative to decide on API:
> https://lwn.net/ml/linux-kernel/20201116161001.1606608-1-willemdebruijn.kernel@gmail.com/

Interesting thread, thanks for sending.

> Agreed on the overall principle that it is preferable to be able to
> enable busypolling selectively. We already do for SO_BUSY_POLL and
> sysctl busy_read.

Thanks for taking a look and providing feedback.

>
> > ---
> >  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
> >  fs/eventpoll.c                                | 47 +++++++++++++++++++
> >  include/uapi/linux/eventpoll.h                | 12 +++++
> >  3 files changed, 60 insertions(+)
> > 
> > diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > index 457e16f06e04..b33918232f78 100644
> > --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> > +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> > @@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
> >  0x89  0B-DF  linux/sockios.h
> >  0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
> >  0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
> > +0x8A  00-1F  linux/eventpoll.h
> >  0x8B  all    linux/wireless.h
> >  0x8C  00-3F                                                          WiNRADiO driver
> >                                                                       <http://www.winradio.com.au/>
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 40bd97477b91..c1ee0fe01da1 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -6,6 +6,8 @@
> >   *  Davide Libenzi <davidel@xmailserver.org>
> >   */
> >  
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/sched/signal.h>
> > @@ -869,6 +871,49 @@ static void ep_clear_and_put(struct eventpoll *ep)
> >  		ep_free(ep);
> >  }
> >  
> > +static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +	int ret;
> > +	struct eventpoll *ep;
> > +	struct epoll_params epoll_params;
> > +	void __user *uarg = (void __user *) arg;
> > +
> > +	if (!is_file_epoll(file))
> > +		return -EINVAL;
> > +
> > +	ep = file->private_data;
> > +
> > +	switch (cmd) {
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> > +	case EPIOCSPARAMS:
> > +		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> > +			return -EFAULT;
> > +
> > +		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT)
> > +			pr_err("busy poll budget %u exceeds suggested maximum %u\n",
> > +					epoll_params.busy_poll_budget, NAPI_POLL_WEIGHT);
> > +
> > +		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> > +		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> > +		return 0;
> > +
> > +	case EPIOCGPARAMS:
> > +		memset(&epoll_params, 0, sizeof(epoll_params));
> > +		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
> > +		epoll_params.busy_poll_budget = ep->busy_poll_budget;
> > +		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
> > +			return -EFAULT;
> > +
> > +		return 0;
> > +#endif
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int ep_eventpoll_release(struct inode *inode, struct file *file)
> >  {
> >  	struct eventpoll *ep = file->private_data;
> > @@ -975,6 +1020,8 @@ static const struct file_operations eventpoll_fops = {
> >  	.release	= ep_eventpoll_release,
> >  	.poll		= ep_eventpoll_poll,
> >  	.llseek		= noop_llseek,
> > +	.unlocked_ioctl	= ep_eventpoll_ioctl,
> > +	.compat_ioctl   = compat_ptr_ioctl,
> >  };
> >  
> >  /*
> > diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> > index cfbcc4cc49ac..8eb0fdbce995 100644
> > --- a/include/uapi/linux/eventpoll.h
> > +++ b/include/uapi/linux/eventpoll.h
> > @@ -85,4 +85,16 @@ struct epoll_event {
> >  	__u64 data;
> >  } EPOLL_PACKED;
> >  
> > +struct epoll_params {
> > +	u64 busy_poll_usecs;
> > +	u16 busy_poll_budget;
> > +
> > +	/* for future fields */
> > +	u8 data[118];
> > +} EPOLL_PACKED;
> > +
> > +#define EPOLL_IOC_TYPE 0x8A
> > +#define EPIOCSPARAMS _IOW(EPOLL_IOC_TYPE, 0x01, struct epoll_params)
> > +#define EPIOCGPARAMS _IOR(EPOLL_IOC_TYPE, 0x02, struct epoll_params)
> > +
> >  #endif /* _UAPI_LINUX_EVENTPOLL_H */
> > -- 
> > 2.25.1
> > 
> 
> 

