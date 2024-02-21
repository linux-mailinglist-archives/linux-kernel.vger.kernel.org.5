Return-Path: <linux-kernel+bounces-74586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 218D485D668
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5FF0B2265B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A73FB1E;
	Wed, 21 Feb 2024 11:03:16 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69353E499;
	Wed, 21 Feb 2024 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513396; cv=none; b=OQBLX8kK9U2Xz+yIa4bGEtK+34Zfd7tOCwpnDnH21zSndovvUccML6faAmtr488vveoe/nixu3J6Jg6BXdnW+GczkVSlz223sV9gi7x1gbuOP5WtNstltXJOYVo6QUw2zmmxm5Wz7v0iL+MRQ8SpE1G10NvmQ60n4GNrxTbS6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513396; c=relaxed/simple;
	bh=XFt13D5ylO9jzqFTzN+Xgl+UmCGXbiR0HJeGfakV0/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrogjJcB3PAaDOHg8Z6j4XLpn87VoATnpZuvtCNFwLnG+bQmt5jA7vM20sUhsCO6xE0JMRdYD3y70OePDv1mY/JlsyCKFpKdMF2zLFbD2KvLSm/wc8ODkY8EiXvu8HjECrwUMItxcuFQEtPpSNb4mvCcnoFixgyKr/BXi7nNbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=58582 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rckNY-00BKUj-D6; Wed, 21 Feb 2024 12:03:10 +0100
Date: Wed, 21 Feb 2024 12:03:07 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kovalev@altlinux.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, edumazet@google.com, laforge@gnumonks.org,
	davem@davemloft.net, pabeni@redhat.com, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Message-ID: <ZdXYa8RqNO4xZxbw@calendula>
References: <20240214162733.34214-1-kovalev@altlinux.org>
 <ZczvJKETNyFE5Glm@calendula>
 <a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
 <Zcz0tG9XMqLHMKs+@calendula>
 <1044d472-c733-3901-9df9-41a29b2c9fb4@basealt.ru>
 <Zc5NP/5Eyh8bsbH6@calendula>
 <20240220160434.29bcaf43@kernel.org>
 <ZdXUrV5YwIXnRI8u@calendula>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdXUrV5YwIXnRI8u@calendula>
X-Spam-Score: -1.9 (-)

On Wed, Feb 21, 2024 at 11:47:12AM +0100, Pablo Neira Ayuso wrote:
> On Tue, Feb 20, 2024 at 04:04:34PM -0800, Jakub Kicinski wrote:
> > On Thu, 15 Feb 2024 18:43:46 +0100 Pablo Neira Ayuso wrote:
> >
> > Pablo is anything expected to change from gtp patch itself?
> > Someone (DaveM?) marked this as Changes Requested but I don't see 
> > a clear ask, other that to follow up with patches to other families.
> 
> Thanks for your follow up.
> 
> It would be good if this patch gets a Fixes: tag. I'd suggest:
> 
> Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
> 
> Meanwhile a v3 is sent, I am going to test it so I can provide a
> Testbed-by: tag for you.

Oh. My bad.

Patch is perfectly fine, it contains the Tested-by: tag already.

Please, apply.

Thanks.

