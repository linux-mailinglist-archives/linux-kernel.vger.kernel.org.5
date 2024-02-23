Return-Path: <linux-kernel+bounces-77996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CBA860DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C088284306
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B385CDCE;
	Fri, 23 Feb 2024 09:19:29 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4A75C61F;
	Fri, 23 Feb 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679969; cv=none; b=Gd3XEreIpvCUgMy62kxyTdbkrXLyyzmJAWuKjPa43op9w7EH7Orf9/dXFJfOhkz7xRd8i8S+XBa2QH8crG+YiBTihrMeWAMbf7ONBBdnv94EBswyi4jaIxmjONF0us5K4vIH2ZCnUujEOlR71rlHHx9G69h8io5vSsjG73eSOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679969; c=relaxed/simple;
	bh=6CMFof3aEOjiVtZ6J4iQukC3w3fqUlorNiOBhG5SfRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFnvUCXRlwTDURFCjOl+oMKx1Q0/W7y6I0Xa4KneWgUmV+YLftv59A59ObTVZBPRzjM8zbjch14Atrz1vpyq3rC4DodFE6NSiNuvVOIlSqxgB5cvIAjFc00u/kVpqaTfBygtTr+8sMJoQurzy2yV+RvtDWTpPDHy9W1HsPw67fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rdRi6-0003J9-00; Fri, 23 Feb 2024 10:19:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 089C8C0267; Fri, 23 Feb 2024 10:06:33 +0100 (CET)
Date: Fri, 23 Feb 2024 10:06:33 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mips: cm: Add CM GCR and L2-sync base address
 getters declarations
Message-ID: <ZdhgGRknaFmxKvfI@alpha.franken.de>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-3-fancer.lancer@gmail.com>
 <ZdTgSZRTDkakekkd@alpha.franken.de>
 <difioxc7b7e2ic2p4om36l6vu4vkud6qa6t3aeikxzkhlqhgqb@zsx3dmjcofw4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <difioxc7b7e2ic2p4om36l6vu4vkud6qa6t3aeikxzkhlqhgqb@zsx3dmjcofw4>

On Wed, Feb 21, 2024 at 09:39:58PM +0300, Serge Semin wrote:
> On Tue, Feb 20, 2024 at 06:24:25PM +0100, Thomas Bogendoerfer wrote:
> > On Thu, Feb 15, 2024 at 08:17:27PM +0300, Serge Semin wrote:
> > > Based on the design pattern utilized in the CM GCR and L2-sync base
> > > address getters implementation the platform-specific code is capable to
> > > re-define the getters and re-use the weakly defined initial versions. But
> > > since the re-definition is supposed to be done in another source file the
> > > interface methods have been globally defined which in its turn causes the
> > > "no previous prototype" warning printed should the re-definition is
> > > finally introduced. Since without the global declarations the pattern can
> > > be considered as incomplete and causing the warning printed, fix it by
> > > providing the respective methods prototype declarations in
> > > "arch/mips/include/asm/mips-cm.h".
> > > 
> > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > 
> > > ---
> > > 
> > > Note as I mentioned in the previous patch, since the weak implementation
> > > of the getters isn't utilized other than as a default implementation of
> > > the original methods, we can convert the denoted pattern to a simple
> > > __weak attributed methods. Let me know if that would be more preferable.
> > 
> 
> > how about simply remove __mips_cm_l2sync_phys_base() and do everything
> > via mips_cm_phys_base(). And at the moment without anyone overriding
> > mips_cm_phys_base I tend to keep static without __weak. If someone
> > needs, we can change it. Does this make sense ?
> 
> To be honest my arch code (not submitted yet) do override the
> mips_cm_l2sync_phys_base() method. The memory just behind the CM2

that's fine, I just wanted to know a reason for having it provided as
weak symbol.

> What about instead of that I'll just convert both mips_cm_phys_base()
> and mips_cm_l2sync_phys_base() to being defined with the underscored
> methods body and assign the __weak attribute to them?

works for me ;-) I'll pick patch 3/4 of this series, so no need to
resend them.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

