Return-Path: <linux-kernel+bounces-50316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DFA84775D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF081B298A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3FD14E2F0;
	Fri,  2 Feb 2024 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1TvU+Lj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890F152DEF;
	Fri,  2 Feb 2024 18:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898161; cv=none; b=M0gZ4babYzxRRI/SmSfVTIlWbNun2kQRmbLLXoG79yM/PkrczJ09WG+Xot9BUEWi5eJ44nAr0sa7bC9FEJkFnqHanECv+j1lYQJFBkUPaZC+44GQdtfxa4IjjWbFKuYsQWFY/cWS4zf+QU16iis/Pv62xg84u5O8xVBL8RCV4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898161; c=relaxed/simple;
	bh=svlvAKv5Rsvu79CaMk7L2BcATKO9LgP+bcm0qXURTwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXT40s587iTqiLmrwCm3PglsnqX26GDXanspLQaEos6Q+x3gVLuUDWztlw0tlH4BmToxViyX52enzsEYPm1+fYGpciU6ZikEW7QcjRi7FK07cirEy1VQID4FCJAbjdr6+n7BgIlh1EWje8T5FFa7CMu0FPsPGjSEYNQhUGXqPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1TvU+Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F75C433F1;
	Fri,  2 Feb 2024 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706898161;
	bh=svlvAKv5Rsvu79CaMk7L2BcATKO9LgP+bcm0qXURTwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I1TvU+LjPjr5qbLEIXhr7/DRLc7UIpceNQ5kWHZnw0xpTGQ94/KFqA+FR7dw+gIe9
	 TAQY0kW36tFvSPdxJIwk/qePlR6anGBbBhKCAnuXDVvwO+u3737/q1pGdLwlnQORkO
	 xSF61brZecFv2S2/NxndiIyhyEPiX6cS7v/2dSJOVKqTX0Aqfb3DGpLcjPUUf9ChVL
	 wFwZeRnYRq/xjtfK8nVM+KWFYAstoemWARClHatdXrrEJP5i1KSnptzOc273mnBYOD
	 4UDD4jrAbn8EpOUc62qfT90JE1ISVJtRHOoi4/JbYdDbpMYbe1ySHALb0wbjzs5ree
	 q6FH+Kfhb/GWQ==
Date: Fri, 2 Feb 2024 10:22:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Eric Dumazet
 <edumazet@google.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chuck.lever@oracle.com>,
 <jlayton@kernel.org>, <linux-api@vger.kernel.org>, <brauner@kernel.org>,
 <davem@davemloft.net>, <alexander.duyck@gmail.com>, "Wei Wang"
 <weiwan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240202102239.274ca9bb@kernel.org>
In-Reply-To: <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
	<CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
	<5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
	<20240202032806.GA8708@fastly.com>
	<f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Feb 2024 11:23:28 -0600 Samudrala, Sridhar wrote:
> > I know I am replying to a stale thread on the patches I've submit (there is
> > a v5 now [1]), but I just looked at your message - sorry I didn't reply
> > sooner.
> > 
> > The per-queue and per-napi netlink APIs look extremely useful, thanks for
> > pointing this out.
> > 
> > In my development tree, I had added SIOCGIFNAME_BY_NAPI_ID which works
> > similar to SIOCGIFNAME: it takes a NAPI ID and returns the IF name. This is
> > useful on machines with multiple NICs where each NIC could be located in
> > one of many different NUMA zones.
> > 
> > The idea was that apps would use SO_INCOMING_NAPI_ID, distribute the NAPI
> > ID to a worker thread which could then use SIOCGIFNAME_BY_NAPI_ID to
> > compute which NIC the connection came in on. The app would then (via
> > configuration) know where to pin that worker thread; ideally somewhere NUMA
> > local to the NIC.
> > 
> > I had assumed that such a change would be rejected, but I figured I'd send
> > an RFC for it after the per epoll context stuff was done and see if anyone
> > thought SIOCGIFNAME_BY_NAPI_ID would be useful for them, as well.  
> 
> I think you should be able to get this functionality via the netdev-genl 
> API to get napi parameters. It returns ifindex as one of the parameters 
> and you should able to get the name from ifindex.
> 
> $ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
> {'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}

FWIW we also have a C library to access those. Out of curiosity what's
the programming language you'd use in user space, Joe?

