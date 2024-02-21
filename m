Return-Path: <linux-kernel+bounces-74312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE3085D2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706A51F24253
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AFC3C6AC;
	Wed, 21 Feb 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OCdUT3lC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF726AC9;
	Wed, 21 Feb 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504705; cv=none; b=ruTe45m4CIM/j4h6TTxnNGOA3KAJ5BromtFkzLZKFIl/+GakNXRwnj+aJvzYIwLXJLYia+xKKim4F3UQ10CwTdTibZEpt0NyJgp4GmLYTwOxr0ytoG54P0ah4eXGMBPQjuEVcxDJWf6UEJX9ccViRpheIK33bLdWt/RrliOPj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504705; c=relaxed/simple;
	bh=qy9AQ02rPvVSd4+VJvnL3Bwv0mokRcv3LTo1TdQhgbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvYUUnGGjY/jEHlxwuS0AbX75VpjQWGdvVSsb42S9wn3TtF1JVVKH2aqETw4h3pLWLVOe6WN4BtXpCHNW+/fmZwFGW6WcCY1A28rBeXqiOocu3uOM8BrAqNfoiPXPlAIWirp8iABzB+k8su8qfPSVmCqoc+1jUFWHCsRjNlbUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OCdUT3lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E8C433C7;
	Wed, 21 Feb 2024 08:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708504704;
	bh=qy9AQ02rPvVSd4+VJvnL3Bwv0mokRcv3LTo1TdQhgbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCdUT3lCG6rUmkvrwpJ/zeNEHg1dPv0hzs5vwKxwKSud6ZaUy8AN3Re2gdDe1De2f
	 +pVWwdSnpjo8FkiFsowAEVuJ1DJzsiTiZ3jlcexmO4sQGrNnnIb9ZndAR0xFWwxOPF
	 Lwwf+KaXYRqIDjTZu/Xd+4nfqOb/cwSH1nckG1p8=
Date: Wed, 21 Feb 2024 09:38:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	stable <stable@vger.kernel.org>, Xu Yang <xu.yang_2@nxp.com>,
	kernel-team@android.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] of: property: Add in-ports/out-ports support to
 of_graph_get_port_parent()
Message-ID: <2024022112-evolve-pyramid-e0f3@gregkh>
References: <20240207011803.2637531-1-saravanak@google.com>
 <20240207011803.2637531-4-saravanak@google.com>
 <CAGETcx9eiLvRU6XXsyWWcm+eu+5-m2fQgkcs2t1Dq1vXQ1q7CQ@mail.gmail.com>
 <2024022149-bartender-wrangle-7f93@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024022149-bartender-wrangle-7f93@gregkh>

On Wed, Feb 21, 2024 at 08:00:00AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 20, 2024 at 04:47:35PM -0800, Saravana Kannan wrote:
> > On Tue, Feb 6, 2024 at 5:18 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Similar to the existing "ports" node name, coresight device tree bindings
> > > have added "in-ports" and "out-ports" as standard node names for a
> > > collection of ports.
> > >
> > > Add support for these name to of_graph_get_port_parent() so that
> > > remote-endpoint parsing can find the correct parent node for these
> > > coresight ports too.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > 
> > Greg,
> > 
> > I saw that you pulled the previous 2 patches in this series to 6.1,
> > 6.6 and 6.7 kernel branches. I really should have added both of those
> > Fixes tag to this patch too.
> > 
> > Can you please pull in the patch to those stable branches too?
> 
> Sure, what's the git id?

Nevermind, I found it...

