Return-Path: <linux-kernel+bounces-147476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F228E8A74CC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA29C283FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515C139593;
	Tue, 16 Apr 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GTlQe38L"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F2138496
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295958; cv=none; b=TT91DxtxF8O4QWpC3ZYc85hJdDAia5/X4SrW2ycoiYkQ1m9KrBfPl6l9+EgY8+3stz3aVDguTOl350jWNKe0DfQ9W/3FBaeBBlAAZT6RCfdpM2YeicCcYGpHiTU1ILLiaU1NSt/H1ArFFiV/qVkDoaqId+q3W0q7lfOnp3lfWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295958; c=relaxed/simple;
	bh=SO3W75qAxcT+JpicVsmbr4gasfWWlWIucpF6Fwd65rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3FaV4x+MnufZqAeYL9g/H7qk+E7BJjnBfHmO+9QvraUfw62XK8k6IOyCFvBJXNJeDKoJ2AxP9cdTm3qq0fSzMEZs6SiCMxdHc8jbb7PlsF/uSaidwqYC+3gO1q8wV/6+LV3H9cl8s0g4/8dW3z2tDUB6QnUby/d4e9yGdnBmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GTlQe38L; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713295945;
	bh=SO3W75qAxcT+JpicVsmbr4gasfWWlWIucpF6Fwd65rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTlQe38L280+IC5U7MAelAhkZPBeh3DGr1Bqg0UureZD7gy3EbhrUHwtnHexV8PgJ
	 RPufo1F0d0eMa8J/T3WKmxqCll+DurL/BIz1nYpksgb4VGK3cNMWFSQc42HYUlXYro
	 cGtldAXEo1xqA/wyn3kjYFPb76c/WwJTMbTTw9KQ=
Date: Tue, 16 Apr 2024 21:32:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Eric Dumazet <edumazet@google.com>, 
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] sysctl: treewide: constify ctl_table argument
 of sysctl handlers
Message-ID: <25166edb-4443-421f-abba-38914db2fac4@t-8ch.de>
References: <CGME20240323154426eucas1p12a061ae721193083fd0ed29016277017@eucas1p1.samsung.com>
 <20240323-sysctl-const-handler-v2-0-e80b178f1727@weissschuh.net>
 <20240328210016.33wqcpwatamupxyw@joelS2.panther.com>
 <cd60f573-ea02-4834-8bb9-9fef24088cfc@t-8ch.de>
 <20240408085928.dhvexnhvvugfvjkt@joelS2.panther.com>
 <a90e9483-f27b-4448-9fae-b768d8139ead@t-8ch.de>
 <20240416161819.prjyozfkvy3nddzh@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416161819.prjyozfkvy3nddzh@joelS2.panther.com>

(+Cc LKML to at least get the conversation into the archives)

Hi Joel,

On 2024-04-16 18:18:19+0200, Joel Granados wrote:
> On Mon, Apr 08, 2024 at 04:21:58PM +0200, Thomas Weißschuh wrote:
> > On 2024-04-08 10:59:28+0200, Joel Granados wrote:
> > > On Tue, Apr 02, 2024 at 07:15:37PM +0200, Thomas Weißschuh wrote:
> > > > On 2024-03-28 22:00:16+0100, Joel Granados wrote:
> > > > > On Sat, Mar 23, 2024 at 04:44:08PM +0100, Thomas Weißschuh wrote:
> > > > > > * Patch 1 is a bugfix for the stack_erasing sysctl handler
> > > > > > * Patches 2-10 change various helper functions throughout the kernel to
> > > > > >   be able to handle 'const ctl_table'.
> > > > > > * Patch 11 changes the signatures of all proc handlers through the tree.
> > > > > >   Some other signatures are also adapted, for details see the commit
> > > > > >   message.
> > > > > > 
> > > > > > Only patch 1 changes any code at all.
> > > > > > 
> > > > > > The series was compile-tested on top of next-20230322 for
> > > > > > i386, x86_64, arm, arm64, riscv, loongarch and s390.
> > > > > > 
> > > > > > This series was split from my larger series sysctl-const series [0].
> > > > > > It only focusses on the proc_handlers but is an important step to be
> > > > > > able to move all static definitions of ctl_table into .rodata.
> > > > > > 
> > > > > > [0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net/
> > > > > > 
> > > > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Reduce recipient list
> > > > > How did you reduce it? and why did you reduce it? This is quite an
> > > > > extensive change; if anything we should have lots of eyes on it.
> > > > 
> > > > I used get_maintainer.pl for v1 and received negative feedback about
> > > > sending the series to too many people.
> > > I completely missed that. Was that a private mail to you? Do you have a
> > > link of the message? I checked my history and I do not have it.
> > 
> > Yes that message was private. From a fairly prominent maintainer.
> > 
> > > > Advice I got was to only send it to the people whose tree it will be
> > > > going through.
> > > > 
> > > > The only change affecting actual emitted object code in the series is
> > > > "stackleak: don't modify ctl_table argument" and that got acked by Kees
> > > > already quite some time ago.
> > > > If Kees wants to pick this up for one of his own PRs during this cycle
> > > > that would be nice, too.
> > > > 
> > > > I'm open for suggestions to increase the circle of recipients, but
> > > > blindly using get_maintainer.pl again doesn't seem the right way.
> > 
> > > IMO, this can go either way: You can get feedback that tells you that it
> > > is too many people that you are "bothering" and you can also get
> > > maintainers pinging you to be included in what they consider to be part
> > > of their job. You can't make everyone happy :)
> > 
> > Absolutely, this is my expectation, too.
> > 
> > But maintainers can nicely opt-in to all patches touching their
> > subsystems using lore and lei, while it's harder to opt-out of broad
> > recipient lists.
> > (Except putting me in their killfile...)

> Not sure how possible it is to be individually black listed in a
> maintainers inbox. But it is more of a reason to make it public; because
> at least you have done your due diligence and made it available so every
> one can see what is going on (even if you are black listed
> individually).

The reference to the killfile was more meant as a joke.

> > > > The only real feedback I got was from Dave and that I addressed.
> > > yes. I saw this.
> > > 
> > > > If somebody would have had fundamental issues with the aproach they
> > > > could have spoken up on v1.
> > > This seems reasonable. I'll try to get to it this week and add it to
> > > constfy branch if I do not see anything glaring.
> 
> I Just realized that you did not include any kernel lists. I thought
> that you had just removed individuals and left the lists. This reduces
> the number of eyes on the code which is particularly important in this
> specific case where there are so many changes touching so many
> subsystems.

This is absolutely an oversight, I intended to at least keep LKML.
I have to assume it was me being inattentive.

> Not only that, but it also breaks tools like lei and b4. I have configured b4 to
> look at https://lore.kernel.org/all to handle patches coming from contributors.
> If the change is not public it breaks my command (`b4 am -o - MESSAGE_ID | git
> am -3`).

Understood, as mentioned above the trimming went to far.

FYI:
b4 can do the `git am` itself with `b4 shazam MESSAGE_ID`.
Use the config `b4.shazam-am-flags` for the `-3` flag.

> I do not know who spooked you but I suggest you just remove this person
> from the to:/cc: of your patches and leave the rest as it is. Like I
> did with Mathew Wilcox after he asked me to do so here
> https://lore.kernel.org/all/ZZbJRiN8ENV%2FFoTV@casper.infradead.org/.
> Please resend the patchset including the relevant kernel mailing lists and
> maintainers but excepting the person that sent you the private e-mail.

In addition to the complaint I also got guidance from Thomas Gleixner to
reduce the scope of recipients.

What do you think about the following:

You do a review of v2 and give feedback on that and I'll incorporate
that feedback and afterwards send a v3.
In addition to the recipients of v2 I'll add LKML, Greg and Andrew Morton.
 
> This also goes for your "[PATCH] sysctl: treewide: constify ctl_table_header::ctl_table_arg"
> which is also not public.

Thanks for this pointer, too.
I'd like to handle it the same way as proposed above.


Sorry for all the back-and-forth,
Thomas

