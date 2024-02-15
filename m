Return-Path: <linux-kernel+bounces-67427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F014856B62
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A222844E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A8137C2C;
	Thu, 15 Feb 2024 17:44:02 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A86341F;
	Thu, 15 Feb 2024 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019042; cv=none; b=uZTflauZ5OvL1BaYe30eosoce011beO3La7nUo2Nr0JC+wj7ago5EkKuOnX3msZZFPyaKOseV4lFnt3psrK1C+pnYpbkOFNLKlaPHdgoGkKHNGmFuvB0/enHM10fMEBAB8X+JAkOA0+/pVe36CPw9KxOlNxYeT+9Kj1PCW6VDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019042; c=relaxed/simple;
	bh=1ry+AWNCJEkQ8grJrIYN31fy69f0Sow1+fPD6I8WYMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws9W7sJF2SxP+y2qn3qNSeYCBH9cJJtj667it2K4SjOnjSbw+jOE4Ky4WP95hA/kGrBlG4tXC+kKNcHB/AkQHzJWtETiPXYG8ij1OpMZMyQwF/Rj+Vi5PbIlbrRUKZ1ta21jjku2GPLEwdyeRTljDwzfB/UwX1msOfj3oA2BKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.41.52] (port=48464 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1raflz-002uLt-27; Thu, 15 Feb 2024 18:43:49 +0100
Date: Thu, 15 Feb 2024 18:43:46 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: kovalev@altlinux.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, laforge@gnumonks.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, nickel@altlinux.org,
	oficerovas@altlinux.org, dutyrok@altlinux.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Message-ID: <Zc5NP/5Eyh8bsbH6@calendula>
References: <20240214162733.34214-1-kovalev@altlinux.org>
 <ZczvJKETNyFE5Glm@calendula>
 <a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
 <Zcz0tG9XMqLHMKs+@calendula>
 <1044d472-c733-3901-9df9-41a29b2c9fb4@basealt.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1044d472-c733-3901-9df9-41a29b2c9fb4@basealt.ru>
X-Spam-Score: -1.9 (-)

On Wed, Feb 14, 2024 at 08:30:25PM +0300, kovalev@altlinux.org wrote:
> 14.02.2024 20:13, Pablo Neira Ayuso wrote:
> > Ok, then a series of fixes probably needs to happen so each maintain
> > can review and apply them.
> > 
> > Maybe some of these subsystems above can only be compiled built-in, so
> > that cannot trigger.
> > 
> > In any case, are you up to pick on that series?
> > 
> > Thanks.
>
> Yes, I can prepare several patches with the same commit message. Is it
> better to send them individually (like this patch) or in a series with a
> brief preliminary description (PATCH 0/x)?

I'd suggest one patch for each subsystem as per MAINTAINER file, that
should also make it easier for Linux kernel -stable maintainers to
pick up this fix series.

Thanks

