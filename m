Return-Path: <linux-kernel+bounces-74559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528085D5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B1F283495
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373D43D38F;
	Wed, 21 Feb 2024 10:47:26 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15D5394;
	Wed, 21 Feb 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512445; cv=none; b=NW1C5+LkEhFXTkXrQ6vx4ZiaH+2K/nnkCj2Pbiq+Z/eg2BF/saKhAGFv3COuTYLOjIMRiHm0gdCGg7dRe+iRZS0CAxYSUfAO4EsGfYQ85ri8w87NJQZg4O9wKLwXT4s0LXuyg55G3SCK1yqkhJokFAYMjWAwSXB0lsp3ZVDYkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512445; c=relaxed/simple;
	bh=pgaidTgr2aUklB831fxm63WKX6lJB6333Vo9TNosD1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFb0SN9H4quoS56YmlpPyBTgwnJlnXVpBoqajMX36OqqHTfCD+iIlT1WSMna5CUk3xQtRhp10nZeQj2EfkznllX4Q75jcv4J6FyT3Ll2orv+P4QuMFNk+qKci4cVh47atav4vGAIN1Wdz4Qra8gyEkWwyKlY66vsGq+4cwhKsVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=47394 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rck86-00BJW7-Ia; Wed, 21 Feb 2024 11:47:12 +0100
Date: Wed, 21 Feb 2024 11:47:09 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kovalev@altlinux.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, edumazet@google.com, laforge@gnumonks.org,
	davem@davemloft.net, pabeni@redhat.com, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Message-ID: <ZdXUrV5YwIXnRI8u@calendula>
References: <20240214162733.34214-1-kovalev@altlinux.org>
 <ZczvJKETNyFE5Glm@calendula>
 <a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
 <Zcz0tG9XMqLHMKs+@calendula>
 <1044d472-c733-3901-9df9-41a29b2c9fb4@basealt.ru>
 <Zc5NP/5Eyh8bsbH6@calendula>
 <20240220160434.29bcaf43@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220160434.29bcaf43@kernel.org>
X-Spam-Score: -1.9 (-)

On Tue, Feb 20, 2024 at 04:04:34PM -0800, Jakub Kicinski wrote:
> On Thu, 15 Feb 2024 18:43:46 +0100 Pablo Neira Ayuso wrote:
> > > Yes, I can prepare several patches with the same commit message. Is it
> > > better to send them individually (like this patch) or in a series with a
> > > brief preliminary description (PATCH 0/x)?  
> > 
> > I'd suggest one patch for each subsystem as per MAINTAINER file, that
> > should also make it easier for Linux kernel -stable maintainers to
> > pick up this fix series.
> 
> Pablo is anything expected to change from gtp patch itself?
> Someone (DaveM?) marked this as Changes Requested but I don't see 
> a clear ask, other that to follow up with patches to other families.

Thanks for your follow up.

It would be good if this patch gets a Fixes: tag. I'd suggest:

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")

Meanwhile a v3 is sent, I am going to test it so I can provide a
Testbed-by: tag for you.

