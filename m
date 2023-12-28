Return-Path: <linux-kernel+bounces-12561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72981F6D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F27F1F211E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A626AAD;
	Thu, 28 Dec 2023 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mzksk20R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F363C6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A93C433C7;
	Thu, 28 Dec 2023 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703758659;
	bh=E52uTUo/hljsQwQ023swY2xZdyNV3GH52IXVtrNIF48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mzksk20R7PZW9oY90SUixy6imTJzFkT8Uhv47wEow8bwfucNfgXandFSuzcOJQBEG
	 Tn7Gf3x9giWfziUCRlXayNqfcoo3EHo0ZZ8Fe8miQpA7jqwKMkCRNqGbncxk6cOqd2
	 Tkb9oSoRGJkZUQYCo0lOmG95mm+IKWNE76rJ+3RA=
Date: Thu, 28 Dec 2023 10:17:37 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, rafael@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, surenb@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	souravpanda@google.com
Subject: Re: Sysfs one-value-per-file (was Re: [PATCH] vmstat: don't auto
 expand the sysfs files)
Message-ID: <2023122824-washout-shrubs-1d6d@gregkh>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
 <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com>
 <CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
 <b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
 <CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com>
 <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com>

On Tue, Dec 26, 2023 at 04:53:31PM -0800, David Rientjes wrote:
> I'd argue that the ship on the "sysfs one-value-per-file rule" has sailed 
> for long-standing use cases where either (1) switching is just not 
> possible or (2) switching would be an undue burden to the user.
> 
> An example of (1) would be THP enablement and defrag options:
> 
> $ grep . /sys/kernel/mm/transparent_hugepage/{defrag,enabled,shmem_enabled}
> /sys/kernel/mm/transparent_hugepage/defrag:always defer defer+madvise [madvise] never
> /sys/kernel/mm/transparent_hugepage/enabled:[always] madvise never
> /sys/kernel/mm/transparent_hugepage/shmem_enabled:always within_size advise [never] deny force
> 
> This convention isn't going to change.  We're not going to suddenly add a 
> new enablement or defrag option that can only be set in a newly added 
> file that is one-value-per-file.
> 
> THP was obviously introduced before any sysfs "one-value-per-file rule" 

No, the rule has been there since "day one" for sysfs, this file snuck
in much later with no one noticing it against the "rules" and I've been
complaining about it every time someone tries to add a new field to it
that I notice.

> and, in retrospect, I think most people would agree that these files would 
> be much better off implemented returning a single word.  But, choices 
> where made in the "before times", and it was implemented in a way that 
> shows all the possible choices and which one is in effect.  Owell.  We 
> deal with it, and we move on.
> 
> Imagine if I add a new choice of "lightweight" to the "defrag" file.  The 
> only rational way to do that would be to extend the current interface, not 
> create a new /sys/kernel/mm/transparent_hugepage/defrag/lightweight file 
> that is one-value-per-file that unsets all the other options in "defrag."
> Please.

Please remember that the sysfs rule is there for a good reason, it makes
it very hard to break existing userspace tools if you stick with it.  If
you decide to ignore that rule, then you are on your own and better make
sure that nothing breaks.

Again, please learn from our previous mistakes with proc files, that is
why the rule is there.

If you wish to ignore the rule, you all really are on your own, good
luck!

greg k-h

