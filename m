Return-Path: <linux-kernel+bounces-45427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1041D843059
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C003F286F80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A979956;
	Tue, 30 Jan 2024 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kuPKs6Vp"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AEB78B6D;
	Tue, 30 Jan 2024 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706654550; cv=none; b=pl79K5PCB5p3fj8jU9jQsiU8MwNcAOwNaLxWRyKeVB7CvAGuqaURTOPHeZndBo2yuE2NSm2hf/CHNv/SGd1/6N2Bi9Re9RZK3Wz8PuNATbWg8+M5QWRuhNMd/7jKAOw/+qLQmNq1robk3GwJ81FGgzcTRLFjMfbWWELRWM5WONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706654550; c=relaxed/simple;
	bh=Nx1e4pop5AqEvKYE+6bTOVPXV7286s5WcoEZH12vQtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMfbw9ds1tiBPghepcMJjRelqF4VWc1scZ9L5Zk2oK0g/H388LWxxs2O9C0IJAHn5Nzfg6BxUvHU2Dxz2trstXt7HpmisX8cmfnvNClLo6CnpeAAanYXfg/SIqQVSfe6LY5cG2Sjl9s9wl/omFmvEm558n++4ChJQcQ6qN8YPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kuPKs6Vp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 53DD620B2004;
	Tue, 30 Jan 2024 14:42:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53DD620B2004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706654548;
	bh=gNgRjz+MsOXXdEsDWVg3uGol6zwXi+IHXyDrs53BXIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuPKs6VpI+veqbrIMVSY80XJ7Ktyp2BJussP+OXuGObMYSVnMSwprTCtgjxucQ4qW
	 4o4KgAldBYu9FQBgHHSojNmz4tVOIcXwd/sWiGKIkVW7f6apEdXpwuApmemax672D1
	 0E7N+5JH2iBe1KNM6WJHxbDryoYZ43WTEu/fo0zw=
Date: Tue, 30 Jan 2024 14:42:24 -0800
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH 2/4] tracing/user_events: Introduce multi-format events
Message-ID: <20240130224224.GA435-beaub@linux.microsoft.com>
References: <20240123220844.928-1-beaub@linux.microsoft.com>
 <20240123220844.928-3-beaub@linux.microsoft.com>
 <20240127000104.7c98b34d295747ab1b084bd2@kernel.org>
 <20240126191007.GA456-beaub@linux.microsoft.com>
 <20240126150445.71c5d426@gandalf.local.home>
 <20240129172907.GA444-beaub@linux.microsoft.com>
 <20240129212407.157a5533@gandalf.local.home>
 <20240130180515.GA827-beaub@linux.microsoft.com>
 <20240130135230.25eb6f21@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130135230.25eb6f21@gandalf.local.home>

On Tue, Jan 30, 2024 at 01:52:30PM -0500, Steven Rostedt wrote:
> On Tue, 30 Jan 2024 10:05:15 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > On Mon, Jan 29, 2024 at 09:24:07PM -0500, Steven Rostedt wrote:
> > > On Mon, 29 Jan 2024 09:29:07 -0800
> > > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > >   
> > > > Thanks, yeah ideally we wouldn't use special characters.
> > > > 
> > > > I'm not picky about this. However, I did want something that clearly
> > > > allowed a glob pattern to find all versions of a given register name of
> > > > user_events by user programs that record. The dot notation will pull in
> > > > more than expected if dotted namespace style names are used.
> > > > 
> > > > An example is "Asserts" and "Asserts.Verbose" from different programs.
> > > > If we tried to find all versions of "Asserts" via glob of "Asserts.*" it
> > > > will pull in "Asserts.Verbose.1" in addition to "Asserts.0".  
> > > 
> > > Do you prevent brackets in names?
> > >   
> > 
> > No. However, since brackets have a start and end token that are distinct
> > finding all versions of your event is trivial compared to a single dot.
> > 
> > Imagine two events:
> > Asserts
> > Asserts[MyCoolIndex]
> > 
> > Resolves to tracepoints of:
> > Asserts:[0]
> > Asserts[MyCoolIndex]:[1]
> > 
> > Regardless of brackets in the names, a simple glob of Asserts:\[*\] only
> > finds Asserts:[0]. This is because we have that end bracket in the glob
> > and the full event name including the start bracket.
> > 
> > If I register another "version" of Asserts, thne I'll have:
> > Asserts:[0]
> > Asserts[MyCoolIndex]:[1]
> > Asserts:[2]
> > 
> > The glob of Asserts:\[*\] will return both:
> > Asserts:[0]
> > Asserts:[2]
> 
> But what if you had registered "Asserts:[MyCoolIndex]:[1]"
> 

Good point, the above would still require a regex type pattern to not
get pulled in.

> Do you prevent colons?
> 

No, nothing is prevented at this point.

It seems we could either prevent certain characters to make it easier or
define a good regex that we should document.

I'm leaning toward just doing a simple suffix and documenting the regex
well.

> > 
> > At this point the program can either record all versions or scan further
> > to find which version of Asserts is wanted.
> > 
> > > > 
> > > > While a glob of "Asserts.[0-9]" works when the unique ID is 0-9, it
> > > > doesn't work if the number is higher, like 128. If we ever decide to
> > > > change the ID from an integer to say hex to save space, these globs
> > > > would break.
> > > > 
> > > > Is there some scheme that fits the C-variable name that addresses the
> > > > above scenarios? Brackets gave me a simple glob that seemed to prevent a
> > > > lot of this ("Asserts.\[*\]" in this case).  
> > > 
> > > Prevent a lot of what? I'm not sure what your example here is.
> > >   
> > 
> > I'll try again :)
> > 
> > We have 2 events registered via user_events:
> > Asserts
> > Asserts.Verbose
> > 
> > Using dot notation these would result in tracepoints of:
> > user_events_multi/Asserts.0
> > user_events_multi/Asserts.Verbose.1
> > 
> > Using bracket notation these would result in tracepoints of:
> > user_events_multi/Asserts:[0]
> > user_events_multi/Asserts.Verbose:[1]
> > 
> > A recording program only wants to enable the Asserts tracepoint. It does
> > not want to record the Asserts.Verbose tracepoint.
> > 
> > The program must find the right tracepoint by scanning tracefs under the
> > user_events_multi system.
> > 
> > A single dot suffix does not allow a simple glob to be used. The glob
> > Asserts.* will return both Asserts.0 and Asserts.Verbose.1.
> > 
> > A simple glob of Asserts:\[*\] will only find Asserts:[0], it will not
> > find Asserts.Verbose:[1].
> > 
> > We could just use brackets and not have the colon (Asserts[0] in this
> > case). But brackets are still special for bash.
> 
> Are these shell scripts or programs. I use regex in programs all the time.
> And if you have shell scripts, use awk or something.
> 

They could be both. In our case, it is a program.

> Unless you prevent something from being added, I don't see the protection.
> 

Yeah, it just makes it way less likely. Given that, I'm starting to lean
toward just documenting the regex well and not trying to get fancy.

> > 
> > > > 
> > > > Are we confident that we always want to represent the ID as a base-10
> > > > integer vs a base-16 integer? The suffix will be ABI to ensure recording
> > > > programs can find their events easily.  
> > > 
> > > Is there a difference to what we choose?
> > >   
> > 
> > If a simple glob of event_name:\[*\] cannot be used, then we must document
> > what the suffix format is, so an appropriate regex can be created. If we
> > start with base-10 then later move to base-16 we will break existing regex
> > patterns on the recording side.
> > 
> > I prefer, and have in this series, a base-16 output since it saves on
> > the tracepoint name size.
> 
> I honestly don't care which base you use. So if you want to use base 16,
> I'm fine with that.
> 
> > 
> > Either way we go, we need to define how recording programs should find
> > the events they care about. So we must be very clear, IMHO, about the
> > format of the tracepoint names in our documentation.
> > 
> > I personally think recording programs are likely to get this wrong
> > without proper guidance.
> > 
> 
> Agreed.
> 
> -- Steve

Thanks,
-Beau

