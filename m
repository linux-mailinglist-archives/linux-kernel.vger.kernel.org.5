Return-Path: <linux-kernel+bounces-129264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495FD8967F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29EE28CA43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73961626A0;
	Wed,  3 Apr 2024 08:06:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1086608ED;
	Wed,  3 Apr 2024 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131593; cv=none; b=tY5128GtP0ieKlJp37liFR1AS5wHlng9Dso4Xt8FmPT2bWtqT9oSGwLfUy28fHD6ZSDuRmybA/p7785sAVQtUNVGvjOIEQq+u0snkfe/oTBkpjyGTTVg4y54WDkgnKVrVO3zHZtoMUnFvUdRK6GFPfp6W+c7t8CrGmwCFnfYIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131593; c=relaxed/simple;
	bh=W0e7wyqop8fzI3z7HiFx+xaKAWPfpCQnW4nvx6iiaXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dD07EYYPyj7+QauvMmJpF3m+wgpsx6+EkKCEizOpW18mbpzQaisB6+snPaFq2yLs/NhDHDUF596fkqUqJVANFh957qJc1XN9Cyc46gm+7zntDEgKli73gC130OuYbZjsgYrI69sR1AznyvS2rr1lS/xnCsDvQJdBowKeHa6G05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AECC1007;
	Wed,  3 Apr 2024 01:07:02 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A9B03F7B4;
	Wed,  3 Apr 2024 01:06:29 -0700 (PDT)
Date: Wed, 3 Apr 2024 09:06:26 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <Zg0N8S05D329BVjN@pluto>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zgu4Tok43W5t8KM0@pluto>
 <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>
 <ZgwrKnx3hb59OG77@pluto>
 <CAHp75VeOB2_ivX5y8YfPEb64YUZBi+3U_1xUdjDVWzLiD=f+nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeOB2_ivX5y8YfPEb64YUZBi+3U_1xUdjDVWzLiD=f+nw@mail.gmail.com>

On Tue, Apr 02, 2024 at 07:39:44PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 2, 2024 at 6:58 PM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> > On Tue, Apr 02, 2024 at 04:06:06PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 2, 2024 at 10:48 AM Cristian Marussi
> > > <cristian.marussi@arm.com> wrote:
> > > > On Sun, Mar 31, 2024 at 01:44:28PM +0000, Peng Fan wrote:
> > > > > > Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoitti:
> 
> ...
> 
> > > > > > > +#include <linux/module.h>
> > > > > > > +#include <linux/scmi_protocol.h>
> > > > > > > +#include <linux/slab.h>
> > > > > >
> > > > > > This is semi-random list of headers. Please, follow IWYU principle (include
> > > > > > what you use). There are a lot of inclusions I see missing (just in the context of
> > > > > > this page I see bits.h, types.h, and  asm/byteorder.h).
> > > > >
> > > > > Is there any documentation about this requirement?
> > > > > Some headers are already included by others.
> > >
> > > The documentation here is called "a common sense".
> > > The C language is built like this and we expect that nobody will
> > > invest into the dependency hell that we have already, that's why IWYU
> > > principle, please follow it.
> >
> > Yes, but given that we have a growing number of SCMI protocols there is a
> > common local protocols.h header to group all includes needed by any
> > protocols: the idea behind this (and the devm_ saga down below) was to ease
> > development of protocols, since there are lots of them and growing, given
> > the SCMI spec is extensible.
> 
> Yes, and what you are effectively suggesting is: "Technical debt? Oh,
> fine, we do not care!" This is not good. I'm in a long term of
> cleaning up the dependency hell in the kernel (my main focus is
> kernel.h for now) and I am talking from my experience. I do not like
> what people are doing in 95% of the code, that's why I really want to
> stop the bad practices as soon as possible.
> 

Not at all, the aim was exactly the opposite, avoiding that some protocol
could have been written without all the needed includes: since a basic set
of headers is definitely common to any protocol you may think to write,
grouping all there was meant to avoid this...I thought that by moving the
problem away in one single internal common header was easier to monitor.

I certainly maybe wrong, but I dont see how you can deduce I dont care...

..and maybe, only maybe, what that 95% of people is trying to do in their
horrible code is to deliver the best reasonably possible thing within their
timeline while you are barking at them in chase of never to be released utter
perfection.

> Last to add, but not least is that your code may be used as an example
> for others, hence we really have to do our best in order to avoid bad
> design, practices, and cargo cults. If this requires more refactoring
> of the existing code, then do it sooner than later.
> 
> ...
> 
> > > > Andy made (mostly) the same remarks on this same patch ~1-year ago on
> > > > this same patch while it was posted by Oleksii.
> > > >
> > > > And I told that time that most of the remarks around devm_ usage were
> > > > wrong due to how the SCMI core handles protocol initialization (using a
> > > > devres group transparently).
> > > >
> > > > This is what I answered that time.
> > > >
> > > > https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937-lin/#t
> > > >
> > > > I wont repeat myself, but, in a nutshell the memory allocation like it
> > > > is now is fine: a bit happens via devm_ at protocol initialization, the
> > > > other is doe via explicit kmalloc at runtime and freed via kfree at
> > > > remove time (if needed...i.e. checking the present flag of some structs)
> > >
> > > This sounds like a mess. devm_ is expected to be used only for the
> > > ->probe() stage, otherwise you may consider cleanup.h (__free() macro)
> > > to have automatic free at the paths where memory is not needed.
> >
> > Indeed, this protocol_init code is called by the SCMI core once for all when
> > an SCMI driver tries at first to use this specific protocol by 'getting' its
> > protocol_ops, so it is indeed called inside the probe chain of the driver:
> > at this point you *can* decide to use devres to allocate memory and be assured
> > that if the init fails, or when the driver cease to use this protocol (calling
> > its remove()) and no other driver is using it, all the stuff that have been
> > allocated related to this protocol will be released by the core for you.
> > (using an internal devres group)
> >
> > Without this you should handle manually all the deallocation manually on
> > the init error-paths AND also provide all the cleanup explicitly when
> > the protocol is no more used by any driver (multiple users of the same
> > protocol instance are possible)...for all protocols.
> 
> Yes. Is it a problem?
> 

Well, no, but is it not a repetitive and error-prone process ?
Is it not the exact reason why devres management exist in first place, to avoid
repetitive manual alloc/free of resources and related pitfalls ? (even though
certainly it is normally used in a more conventional and straightforward way)

The idea was to give some sort of aid in the SCMI stack for writing protocols,
so regarding mem_mgmt, I just built on top of devres facilities, not invented
anything, to try to avoid repetitions and let the core handle mem allocs/free
during the probe phases as much as possible: in pinctrl case would be
particularly trivial to instead manually allocate stuff at init (due to many
lazy delayed allocations) but other protocols need a lot more to be done at init,
frequently in a loop to allocate multiple resources descriptors, and manually
undoing all of that on each error-path and on cleanup is definitely error-prone
and a pain.

Last but not least, this whole thing was designed to address the needs of the
protocols that existed at that time....it is only now with pinctrl lazy-allocations
at runtime that the ugly cohexistence of devm_ and non-devm allocations became a
thing....so clearly the thing needs to be improved/rethinked...even dropped if no
more fitting...

.. or alternatively since devres allocations are anyway optional, you could just
use regular kmalloc/kfree for this protocol and avoid this dual handling...

..this was just to put things in context...and I'll happily let Sudeep decide
what he prefers in the immediate for pinctrl or more in general about all the
scmi devres, that I've got enough of these pleasant interactions for now...

Thanks,
Cristian

