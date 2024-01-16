Return-Path: <linux-kernel+bounces-27735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40F182F50E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9202F285F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C01D692;
	Tue, 16 Jan 2024 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/zkQjxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5F71D68B;
	Tue, 16 Jan 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432217; cv=none; b=USLELk0vyFzEPkOv3so91CvNJ/Erqz2N84zW2UTTEYkifOam+6MQ/NF6eCSnrovjBJ/qUQ3GPIlus+vH0tWuUMwAYiEPZv+UvZMX2SCXq6VShhOMkw6DKAdDAtsbCZNTkLJ/4zmYwx/RcRIBiQuZPKB/jXqKSHWUBWAc+OQFS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432217; c=relaxed/simple;
	bh=goJhqzGkIgr079nD2DeN8gJaKA+Pl39WyAy4k38NqJg=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rOr5QwmPVQk1kErQBMVqtHdsHBnjC9fv5HK0Ewt0eoTIvsPi9oMr+6vTpLKytZZhXkfSTbOZOkJdLHxtk6KcDcPWHwF2Jr5f/ltZU8F65siIYENfR+XBBPrDDgidcjh+DZoZsFQsUvw2XWY2NRkjyd5R3h9XRDn3c0JhnW1F3JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/zkQjxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61085C433F1;
	Tue, 16 Jan 2024 19:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705432216;
	bh=goJhqzGkIgr079nD2DeN8gJaKA+Pl39WyAy4k38NqJg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Q/zkQjxWZ7izZ6L8QKzsPUD23n0hgHSQZ4gXn/1B5EUFSrcLeTECWbQcL/+7gJfW2
	 hMdXnQjGpGSDiZ80x1YFS5R2DTxrwqwZ2dfDhmSLmFRMPiZqBIDce+b45tIIr9jgw5
	 /Rm9dSiAnjPzQ2HKlx7/DHJA/noxB5bqF5XBDZ6hjo+7PQjFubFCiTxrpI1by8ZheJ
	 a9c/Y7Va0zL3pfPLJhHaxqbMkrFuxrC5eFTYUfqRZLcf0Gec6/HhDosMByP/FJUBgn
	 ceVPw/QB5xmf/QvrMLOTbxgisXoAZTLSGInS9m6yLUSqIV8os3pwlPb+WLHup1h11s
	 IrTtXSRIuJkEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A736CE04A3; Tue, 16 Jan 2024 11:10:14 -0800 (PST)
Date: Tue, 16 Jan 2024 11:10:14 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Onkarnarth <onkarnath.1@samsung.com>, frederic@kernel.org,
	quic_neeraju@quicinc.com, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, r.thapliyal@samsung.com,
	maninder1.s@samsung.com, tj@kernel.org, peterz@infradead.org
Subject: Re: [PATCH 1/1] rcu/sync: remove un-used rcu_sync_enter_start
 function
Message-ID: <75830847-a2ab-4bf4-bd4c-f7695e48ea3d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CGME20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c@epcas5p2.samsung.com>
 <20240111092722.322454-1-onkarnath.1@samsung.com>
 <de792eee-1f44-48e2-a122-c3ded1645155@paulmck-laptop>
 <20240116181058.GB12342@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116181058.GB12342@redhat.com>

On Tue, Jan 16, 2024 at 07:10:59PM +0100, Oleg Nesterov wrote:
> On 01/16, Paul E. McKenney wrote:
> >
> > On Thu, Jan 11, 2024 at 02:57:22PM +0530, Onkarnarth wrote:
> > > From: Onkarnath <onkarnath.1@samsung.com>
> > >
> > > With commit '6a010a49b63a ("cgroup: Make !percpu threadgroup_rwsem
> > > operations optional")' usage of rcu_sync_enter_start is removed.
> > >
> > > So this function can also be removed.
> > >
> > > Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> > > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Queued, thank you all!

> For the record, this was already discussed, see
> https://lore.kernel.org/all/20220725121208.GB28662@redhat.com/

I am clearly not keeping up.  ;-)

> Note also the patch in this message, __rcu_sync_enter(wait => false)
> is a better alternative if someone needs rcu_sync_enter_start() again.

Good to know!  I added this to the commit log, so please let me know
if this is in any way inappropriate:

------------------------------------------------------------------------

In the words of Oleg Nesterov:

	__rcu_sync_enter(wait => false) is a better alternative if
	someone needs rcu_sync_enter_start() again.

Link: https://lore.kernel.org/all/20220725121208.GB28662@redhat.com/

------------------------------------------------------------------------

> This patch probably makes sense anyway. Not only cgroup_favor_dynmods()
> can use __rcu_sync_enter(), freeze_super() can use it too to avoid
> 3 synchronize_rcu()'s in a row.

Thank you for the background information, much appreciated!

							Thanx, Paul

