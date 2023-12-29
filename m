Return-Path: <linux-kernel+bounces-13183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D717D8200CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144971C21654
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB8312B82;
	Fri, 29 Dec 2023 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RAnE+3ZW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAF12B72
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3BTHSOqx012217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 12:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1703870906; bh=xvv1SmhHSED5xm7nKqzvvK3M85QMjvxo66YKgvrrHko=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=RAnE+3ZWlUsE5RvDQIqxABqqbfggN0D3qEsJmjAYT/C5rnL1Jg2NeHsjWrkf5ApVW
	 NYL6tsyyS6WGFJ+qKpoSZ+lBLpAICkie7DI8kB4xwLxEuu+QuiacZks/wVG4kxZS9f
	 3pgW3nL/YVfmYjv1U0TD6GapieJ8iCsByeQ7w7rSHpSHIaSEu1GTkdVFQ51OnGJ5WW
	 2LP5ikXxad2pFnB2Ftk0oiZs6LHIg0CD3lF274O8DM4YAa55stBliD6HZ/o1DkuMAV
	 ca0zh8T1PLdo92o3o3lfCGOUFxqI1iJxYDw8ZOUFyB3vvelalwJHk3bbPlg8AOoh7K
	 PA3NFUOYhBliQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B59F7340569; Fri, 29 Dec 2023 11:28:23 -0600 (CST)
Date: Fri, 29 Dec 2023 11:28:23 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Chris Rankin <rankincj@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: Does Linux still support UP?
Message-ID: <20231229172823.GC148343@mit.edu>
References: <CAK2bqVKCdaD6-PZi6gXhf=9CiKGhxQM_UHyKV_onzDPnhbAmvw@mail.gmail.com>
 <ZY7omD5OBLUg6pyx@duo.ucw.cz>
 <CAK2bqVLBZvU2fVfY4bkFrU=4X+W4O3f5pbTdeQjMW=W2sGWpeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK2bqVLBZvU2fVfY4bkFrU=4X+W4O3f5pbTdeQjMW=W2sGWpeQ@mail.gmail.com>

On Fri, Dec 29, 2023 at 04:03:56PM +0000, Chris Rankin wrote:
> 
> I have already attached as much information as I am *ever* likely to
> be able to extract about this problem to the Bugzilla ticket.

In addition to doing a bisection, something else you might want to
try, since in the bugzilla you have hypothesized that it might be a
bug in the e100 driver, is to try building a kernel without the driver
configured, and see if that makes the kernel not hang.  If it does,
then it's likely that the problem is either in the e100 driver, or
maybe somewhere in the networking stack --- although in that case it's
more likely someone else would have noticed.

Something else you might try is to connect up a serial console, so you
can get the full output from sysrq output.  The other advantage of
using a serial console is people are much more likely to scan a text
file with the consoles, as opposed to downloading and trying to make
sense of the screen snapshots.  (BTW, was the flash enabled on your
cell phone?  The bright white spot in the middle of the screen makes
it very hard to read.)

I'd also try sysrq-l (show backtrace for all active CPU's), so you can
see where the kernel is actually hanging.

For better or for worse, support for old hardware is a volunteer
effort, so owners of the said old hardware need to do a bunch of the
leg work.  Or if you can have a paid support contract, maybe you can
pay someone to gather the detail, but when you say "is feature X
supported" in an open source project, that has a different meaning
from a commercial software product.

						- Ted

