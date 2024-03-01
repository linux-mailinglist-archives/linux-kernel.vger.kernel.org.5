Return-Path: <linux-kernel+bounces-88371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755686E091
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D6328335D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E36CDCD;
	Fri,  1 Mar 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gk5wWgCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07C6A8AD;
	Fri,  1 Mar 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293316; cv=none; b=FtN6xE5Xrww0Q2nqCSrA4H4Nle14MaftEWr5tFuvU2hpUKzPwoXdEX5R3Wq/+7n5yQkl/tM0WJUCXpBAy8bYXbLdnomLyes4cLkCjbMTWoWS6dhz6ak1oe6AVYGkOJAGU4cfDijhEGOeTJf8Roig3oANvXhVSYqkqMBzmCuB8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293316; c=relaxed/simple;
	bh=EYQzIq2XsHbxPP8KNQSmIBCmBUS5ay1BMmtHwbbusNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP1uR7wkR7oOCpfHeHMM4+xTvWwlV4Gf7dH0Y82ury6w691dZgO2Xdtzf+B6DWA7FY33nKO7RyCofAvl0KgRFv1gSqUj8Go9houKsGdtbZzJevdtq+AfJzhLp35NzBe4u3k/lljb2Kt86OCwxAzFsBK65fVQBGPF9fbUSUr5fII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gk5wWgCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1844C433F1;
	Fri,  1 Mar 2024 11:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709293315;
	bh=EYQzIq2XsHbxPP8KNQSmIBCmBUS5ay1BMmtHwbbusNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gk5wWgCH0TPmRkvJzdQpj9C5HIOw9GHZ+3Xpk/EcNAXBRZVJ5Fw3FxLONXKuj5lkB
	 6CIO+Dwed/IhqsJjXS98AEknok9SQGO616enLsGTrYrv8yJtKNq+xtS7xnpBPemYdQ
	 /MLyValKXQBsFurOwXvc+NUHaSUu9MhYEFH7l1Os=
Date: Fri, 1 Mar 2024 12:41:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Coco Li <lixiaoyan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <2024030121-starring-party-7e34@gregkh>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229225910.79e224cf@kernel.org>

On Thu, Feb 29, 2024 at 10:59:10PM -0800, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:
> > Introduce a new struct net_device_priv that contains struct net_device
> > but also accounts for the commonly trailing bytes through the "size" and
> > "data" members.
> 
> I'm a bit unclear on the benefit. Perhaps I'm unaccustomed to "safe C".
> 
> > As many dummy struct net_device instances exist still,
> > it is non-trivial to but this flexible array inside struct net_device
> 
> put
> 
> Non-trivial, meaning what's the challenge?
> We also do somewhat silly things with netdev lifetime, because we can't
> assume netdev gets freed by netdev_free(). Cleaning up the "embedders"
> would be beneficial for multiple reasons.
> 
> > itself. But we can add a sanity check in netdev_priv() to catch any
> > attempts to access the private data of a dummy struct.
> > 
> > Adjust allocation logic to use the new full structure.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 118c40258d07..b476809d0bae 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
> >  	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
> >  };
> >  
> > +#define	NETDEV_ALIGN		32
> 
> Unless someone knows what this is for it should go.
> Align priv to cacheline size.
> 
> >  /**
> >   *	struct net_device - The DEVICE structure.
> >   *
> 
> > @@ -2665,7 +2673,14 @@ void dev_net_set(struct net_device *dev, struct net *net)
> >   */
> >  static inline void *netdev_priv(const struct net_device *dev)
> >  {
> > -	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> > +	struct net_device_priv *priv;
> > +
> > +	/* Dummy struct net_device have no trailing data. */
> > +	if (WARN_ON_ONCE(dev->reg_state == NETREG_DUMMY))
> > +		return NULL;
> 
> This is a static inline with roughly 11,000 call sites, according to 
> a quick grep. Aren't WARN_ONCE() in static inlines creating a "once"
> object in every compilation unit where they get used?

It also, if this every trips, will reboot the box for those that run
with panic-on-warn set, is that something that you all really want?

thanks,

greg k-h

