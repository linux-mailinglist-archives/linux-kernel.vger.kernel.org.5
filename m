Return-Path: <linux-kernel+bounces-47026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3518384482D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB36C2824FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC3837143;
	Wed, 31 Jan 2024 19:42:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9313B189;
	Wed, 31 Jan 2024 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706730124; cv=none; b=CKDNEWCPbTlXDsTJ4OtvtXoLCc5cbe5Y6nL5fb9NEAzrH9iuqnlFLlu/L+WduBsOLzpFvL6cFY1O5zSB+UlRS6szcs9zaNKNi/vpP+iLsuzgJ3PhmGjNp5mW/RDv+JUkmudYwbJm7SkcPf3L97/Vam5jZE5ZMgMq9R2uyTu5W+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706730124; c=relaxed/simple;
	bh=m8vwoaQsBcdyqdU5wzhrn7icali5QipJmCUL6e3LtlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgSmmo1X0nnuqNFSqPAi3M/hKaJKl7IXUIznifhU/4sIf7UCf2RTlLxAoH7FaxYO8VjtX+RXqbs7NMsTZ5wrM8OD3OXBOdyubnd9LKepAXAFHWybatEXZbIqjPLEKbRcE+rF7wFNZmxkhh8ln1DMoy/REPoVcAia/L6QjuxnQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C73CC433C7;
	Wed, 31 Jan 2024 19:42:02 +0000 (UTC)
Date: Wed, 31 Jan 2024 14:42:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <20240131144217.0130b517@gandalf.local.home>
In-Reply-To: <CAHk-=wgh0otaSyV0MNrQpwFDTjT3=TWV94Wit2eUuPdh2KdyVg@mail.gmail.com>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
	<CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
	<20240129172200.1725f01b@gandalf.local.home>
	<CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
	<CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
	<20240129174950.5a17a86c@gandalf.local.home>
	<CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
	<20240129193549.265f32c8@gandalf.local.home>
	<CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
	<CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
	<20240130132319.022817e8@gandalf.local.home>
	<CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
	<20240130143734.31b9b3f1@gandalf.local.home>
	<CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
	<20240131105847.3e9afcb8@gandalf.local.home>
	<CAHk-=wgh0otaSyV0MNrQpwFDTjT3=TWV94Wit2eUuPdh2KdyVg@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 11:35:18 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 31 Jan 2024 at 07:58, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > BTW, I ran my full test suite on your patches with the below updates and it
> > all passed.  
> 
> Those patch updates all look sane to me.
> 
> > I can break up and clean up the patches so that they are bisectable, and if
> > that passes the bisectable portion of my tests, I can still send them to
> > you for 6.8.  
> 
> Ack. That series you posted looks fine. I didn't do any actual testing
> or applying the patches, just looking at them.
> 
> The one thing I noticed is that the 'llist' removal still needs to be
> done. The logical point is that "[PATCH v2 7/7]" where the
> eventfs_workfn stuff is ripped out.
> 
> And the 'rcu' head should now be a union with something that is no
> longer used after the last kref. The only thing that *is* used after
> the last kref is the "is_freed" bit, so there's lots of choice. Using
> the 'struct list_head listl' that is used for the child list would
> seem to be the obvious choice, but it could be anything (including all
> of the beginning of that eventfs_inode, but then you would need to
> group that as another nested unnamed struct, so picking a "big enough"
> entry like 'list' makes it syntactically simpler.

Yeah, that was what I was talking about in my cover letter with:

  Note, there's more clean ups that can happen. One being cleaning up the
  eventfs_inode structure. But that's not critical now and can be added
  later.

I just want to get the majority of the broken parts done. The clean up of
the eventfs_inode is something that I'd add a separate patch. Not sure that
falls in your "fixes" category for 6.8.

-- Steve

