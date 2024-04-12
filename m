Return-Path: <linux-kernel+bounces-141973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F88A25A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F672850D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3271BC20;
	Fri, 12 Apr 2024 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qeqoms01"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1618C1A;
	Fri, 12 Apr 2024 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899259; cv=none; b=RcAwc4cfcE7VTfeUgnNXQs/xGKa16Zn9i0gT/JOP4jBZWnqi+g+gdKd3OLOTTdISnGyJntBTgroaRHou/0i0mDhh1kmw6XcClfLX6O3TT7h+QuNQV0R8Iwi4x3IJwLiMQ+i7FXyrj1GRtXm5j8drmSQJmUYZAxFS3NBbJcupNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899259; c=relaxed/simple;
	bh=jpt7FUyFxKqQvoDaN0RnjXj5aEYMHYNMwBmKZvgoXgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/Fac/cMFv7w3IEL1QJIo/i93mO6Tc+4PgglU5/CCp7Qiv20YXQnLbMBoz/Nfz600/FCoJLt/TkbwJWhWvUdjJSx3OLciiLZsgH77tx20G+bo5IkKX3t2NERbELVtAToTfbSEpty4fFLy1v1Ync+o/FBEEXWUP1g+7Oj7dvyr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qeqoms01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1BBC2BD11;
	Fri, 12 Apr 2024 05:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712899258;
	bh=jpt7FUyFxKqQvoDaN0RnjXj5aEYMHYNMwBmKZvgoXgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeqoms01kVM5QWF97ebRi0NwHNjJ1nqnkxhVo4WeNMijuKv9gKutyHog8Q3aQyV+c
	 cI2PcgDdsLXG3iLkllfd0Pu2BIVWVu/cbmR7D69hGCcXZFBPkaU2Kgf4EeC89LlWpw
	 loik1zxnBLN9kFGniRFi6jnwXM5dbP6YFhRS9BYo=
Date: Fri, 12 Apr 2024 07:20:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Roman Storozhenko <romeusmeister@gmail.com>
Cc: jirislaby@kernel.org, Julia.Lawall@inria.fr, skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] sysrq: Auto release device node using __free attribute
Message-ID: <2024041245-surfboard-expenses-ba74@gregkh>
References: <20240411180256.61001-1-romeusmeister@gmail.com>
 <2024041111-tummy-boil-a6aa@gregkh>
 <CALsPMBOx2LeNSL+i+7K3UZ2mvpDDRz0UVoAEuB0ouiEjk73pqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALsPMBOx2LeNSL+i+7K3UZ2mvpDDRz0UVoAEuB0ouiEjk73pqw@mail.gmail.com>


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Apr 11, 2024 at 08:28:17PM +0200, Roman Storozhenko wrote:
> This change allows us to put this pointer under automatic scope
> management and get rid of node_put.  Besides, if a new code path is
> introduced we won't need to add a new of_node_put.

We worry about future stuff then, in the future.  So no need for
changing code today for things that are not present at all, otherwise
you would never be finished with anything, right?

Don't make things more complex when it is not needed.  Only add
complexity when it is needed.

thanks,

greg k-h

