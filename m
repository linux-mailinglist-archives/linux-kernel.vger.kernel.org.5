Return-Path: <linux-kernel+bounces-167561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0924B8BAB55
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84822831CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6A152194;
	Fri,  3 May 2024 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGvnT+0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C01514F2;
	Fri,  3 May 2024 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734201; cv=none; b=aiXmoKWeevFEBfe5RN94n1Q8sCpvD++PVgwsWNafaeXsiyDHPHpvZTvuiViaN/taB6QxuTmGoERsJc/xiXQxb6+ojsfWhvI0LpytO/Kj6X+KCT6rmK8Px5hkgQvKBzEw8HHEKpZMa2Nfus1JTklVAoEMCMKUMc/rWlmpPS2wS6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734201; c=relaxed/simple;
	bh=bjai94D8ZG/7k4vsWq8jbsVW1vR8F8gcG0Y6QhbQHNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohnpbaQ60GO5sTK+qgHW7YsJgdob7nv1ERwTxUPS+4sy2HYOT95Kqib5zSfd3CK7Djx2+FyRi13bxp7lEYrQUAOx7Pwh1ZsY3trsYPBnmW+AJjERfP/BP1dgZt/ig7ZX38ybShEVfF9EVP7PYELhIZfPmY2A+f9Tag0M9yADuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGvnT+0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24BCC116B1;
	Fri,  3 May 2024 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714734200;
	bh=bjai94D8ZG/7k4vsWq8jbsVW1vR8F8gcG0Y6QhbQHNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGvnT+0NKpCaOOeu4+jBqeTD/WA0si7aIg14X+f2zP6t4+V+NLS/UBfF/n/rpul6W
	 prxRsFC5x+Qn6dNMetEszJ2YB8RDIsaj9i7hIBz+0zimd/s6RtZDuzXMVMHc5ooa3Z
	 UjudKI9VMxoO25qDzFF0+Kt2uL7CL8cZ8m4yBpWpnDYsA5l4TWseQknZrMKSRgpLFm
	 8Q+V8OfNtgX4p1GMQFJStVRD+zW2ALd8xQx9hh9d82a/9CBtYXLZUeDJNPJ3621LrH
	 IuphtzfGXgVozFgAxPFMXB4E4oDmV19CYX1ZBZIGrdZ1eMXnxtGLzGQRhy9AzvY0fM
	 WXrO1qAZmPTkQ==
Date: Fri, 3 May 2024 12:03:15 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v17 02/13] rtase: Implement the .ndo_open
 function
Message-ID: <20240503110315.GO2821784@kernel.org>
References: <20240502091847.65181-1-justinlai0215@realtek.com>
 <20240502091847.65181-3-justinlai0215@realtek.com>
 <20240503085257.GM2821784@kernel.org>
 <3199bfed19ad4e0bb8ca868b6c46588a@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3199bfed19ad4e0bb8ca868b6c46588a@realtek.com>

On Fri, May 03, 2024 at 10:19:05AM +0000, Justin Lai wrote:
> > On Thu, May 02, 2024 at 05:18:36PM +0800, Justin Lai wrote:
> > > Implement the .ndo_open function to set default hardware settings and
> > > initialize the descriptor ring and interrupts. Among them, when
> > > requesting irq, because the first group of interrupts needs to process
> > > more events, the overall structure will be different from other groups
> > > of interrupts, so it needs to be processed separately.
> > >
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > 
> > Hi Justin,
> > 
> > some minor feedback from my side.
> > 
> > > +static int rtase_open(struct net_device *dev) {
> > > +     struct rtase_private *tp = netdev_priv(dev);
> > > +     struct rtase_int_vector *ivec = &tp->int_vector[0];
> > > +     const struct pci_dev *pdev = tp->pdev;
> > > +     u16 i, j;
> > > +     int ret;
> > 
> > nit: please use reverse xmas tree order - longest line to shortest -
> >      for local variable declarations in new Networking code.
> > 
> Hi Simon,
> This is partly because ivec needs to use tp for initialization,
> so tp is placed in front of ivec, causing this situation.

Thanks Justin,

Understood.

Had I noticed that I probably wouldn't have commented as I did above.
But, FWIIW, in such cases my suggestion would be to separate the
declaration from the assignment.

Something like this:

	struct rtase_private *tp = netdev_priv(dev);
	const struct pci_dev *pdev = tp->pdev;
	struct rtase_int_vector *ivec;
	u16 i, j;
	int ret;

	ivec = &tp->int_vector[0];

