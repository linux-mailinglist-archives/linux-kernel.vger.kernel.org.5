Return-Path: <linux-kernel+bounces-88804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B1486E6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F631F21F1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF84FC0F;
	Fri,  1 Mar 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHcos0Pz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B45F9FD;
	Fri,  1 Mar 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312919; cv=none; b=Uov+lzzJf76OK9uMB/cWQzIgnUTC0uxR7cEDyu8vO2ZiJSwsEdpZIatWT2Xt7QkIqqGW+OybO5NS/xMveVRoVgr3fZjlymzS+pi3t7Hx4jUZEw9Xk7JgpFil1zIbW67rQQ50z312HIBBSf1pq2BycAB+447msbR0BNjsWD6IfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312919; c=relaxed/simple;
	bh=dQWhTKqicP29reyqSeNu/vMazISZHdnkYuuXEej6Pz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W257XcJdzEOIR7o5wFleG5zjb6Lz3TQ47wF5WUhSl6zgZxg85xShEft6sSDSaZAYrkeXA5A4G1xHsy9gPYo5QXPdaCwEvjv01+znxCJFjWh8DpoQib9uUMM9DxtZims7GwH57Pjl8fcNLjJYK5aBDKTb9j+g3PjN4keUoKXe3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHcos0Pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D44C433F1;
	Fri,  1 Mar 2024 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709312918;
	bh=dQWhTKqicP29reyqSeNu/vMazISZHdnkYuuXEej6Pz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHcos0PzRuz4UdjZjyMoX73NdGAjqFbDAr1Jd8vyGXu3BayLGaB7uwICV/c8BU1m9
	 agaOQYfKzMN5o71Azn12aXvklX/paZlRt/2ibz8nMsmUNJGsKhgYUqL9tcPirqRsC7
	 Zdo/QgNfo9NQYkasAp+Rp8vDyfGLW8Zwqou9ADlOg9lXRvo5Tmrd3eS57IB5YB8Rax
	 T6/XOoD4ejiZ4B+rJzWjwVvqRwagMPfj3mKx5lHMAGHqHSOwf3hYLncHHANvCphqba
	 D7zEThR8hRDP/CK/5LYHDLJCleFEU+zfBuSjU1FsANZACmVniTpf3q9iMkStOuuMR4
	 skExEjJ0Owx2g==
Date: Fri, 1 Mar 2024 09:08:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mateusz Pacuszka
 <mateuszx.pacuszka@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Lukasz Plachno <lukasz.plachno@intel.com>, Jakub Buchocki
 <jakubx.buchocki@intel.com>, Pawel Kaminski <pawel.kaminski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
 <mateusz.polchlopek@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Pawel Chmielewski" <pawel.chmielewski@intel.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 0/5] ice: LLDP support for VFs
Message-ID: <20240301090836.185e3b79@kernel.org>
In-Reply-To: <ZeDb8Dr8mBvov9fc@lzaremba-mobl.ger.corp.intel.com>
References: <20240228155957.408036-1-larysa.zaremba@intel.com>
	<20240228084745.2c0fef0e@kernel.org>
	<ZeBMRXUjVSwUHxU-@nanopsycho>
	<20240229072813.5d7614c3@kernel.org>
	<ZeDb8Dr8mBvov9fc@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 20:33:04 +0100 Larysa Zaremba wrote:
> > This is an LLDP agent which runs as part of the NIC FW, AFAIU, not about
> > forwarding or filtering.
> > 
> > They already have the priv flag, so best to reuse that. If not possible
> > we can explore options, but as Larysa mentioned herself in the cover
> > letter sysfs is probably low on the preference list :(
> 
> FW agent is disabled NIC-wide, so only PF should be able to set such flag.

Sorry, then I misread. If it's about which VF gets the LLDP traffic
from the _wire_, then I'm with Jiri. It's a basic forwarding problem,
isn't it? Match on EtherType and forward?

> The lazy part of me likes the private flag direction, because just
> replacing sysfs entries with corresponding private flags would make
> patch look better while not changing the implementation much.
> 
> I guess, treating it like a normal eswitch configuration would be
> ideal, but it would not be purely generic, as there is an added level
> of complexity because of FW Agent interactions.

