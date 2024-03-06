Return-Path: <linux-kernel+bounces-94743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD98744A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A321F29AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29A52577C;
	Wed,  6 Mar 2024 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZa7c3ch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8121D539
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768576; cv=none; b=oT9njD8KkdxMurOwDziUTBhIpk5RMSc9j/RaQMOQ6Xk9YhxleCO4HivhYF8ZyvMM79sNwhdXEMeCFh8710tfAqKGACkkaqQjN0YWnyEbGwFvppburDPPVjuO8mHmgOMfD/alCVWWx9SGMfESEx3yhbY5NdJ46N8vXZyvJmgtnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768576; c=relaxed/simple;
	bh=UcIj1NgElwaYVIBc4qGuz5BB8JG1G2ZXHw9GrTQfZqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQZt7AyhOAfh2UglM1ld/oGeskSmYYqLjBunJG1nC7ECC7KEoo1EKRh1xpqMgTdXE66tfGqGpniBx84F3ahpHdQLIwMvgr41a4EvYxdC+WC+gNQ7qiGOfF9S+uZaL6iJewLyxKio5w4Zj1KtL0WkY0eBbzXuybmb+B+nWsvEBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZa7c3ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21698C433C7;
	Wed,  6 Mar 2024 23:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709768575;
	bh=UcIj1NgElwaYVIBc4qGuz5BB8JG1G2ZXHw9GrTQfZqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZa7c3ch/j0MhN56RFaxAHFPOqcRbGkZoHG07cI7OhP4hLzyBnf635aWoyWUPODmo
	 HnnaFhUtb6usrMMnZhGe5UJRnNjr4JOipoBFX/Jl3B5inxP4UbGmSt4zZvbFca/J4i
	 yjyGubgFueVxZCPGroXAc30i8bSzEXvRM2ztYqwjyA3v/Ne7MPn4rXprSEX3uNbNGx
	 EUl2rs5vsxVi+Ph8kvyg7jQBlrDnD0fVJJJYyUxd42aKR1NVDxL567ibl4hZgpePfz
	 hEeQzRKN9Tm1njmuJG5khh4umJFVUNejcjEP8onmANHCpahcfN7QkJC6WuVwBmaivN
	 4OZ7HDdPyGdqw==
Date: Wed, 6 Mar 2024 15:42:53 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>,
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
	xrivendell7@gmail.com, ardb@kernel.org, peterz@infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Message-ID: <20240306234253.zporv6cypoc7yihs@treble>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
 <20240306105420.6a6bea2c@gandalf.local.home>
 <20240306193101.s2g33o4viqi2azf3@treble>
 <854e523c-c467-47f6-b977-933cbaadeb62@akamai.com>
 <20240306221650.sw3lha7kca2quv63@treble>
 <8f586bd2-c436-4334-92af-762a284e1101@akamai.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f586bd2-c436-4334-92af-762a284e1101@akamai.com>

On Wed, Mar 06, 2024 at 05:40:11PM -0500, Jason Baron wrote:
> 
> 
> On 3/6/24 5:16 PM, Josh Poimboeuf wrote:
> > On Wed, Mar 06, 2024 at 03:12:07PM -0500, Jason Baron wrote:
> > > 
> > > 
> > > On 3/6/24 2:31 PM, Josh Poimboeuf wrote:
> > > > On Wed, Mar 06, 2024 at 10:54:20AM -0500, Steven Rostedt wrote:
> > > > > Now I guess the question is, why is something trying to disable something
> > > > > that is not enabled? Is the above scenario OK? Or should the users of
> > > > > static_key also prevent this?
> > > > 
> > > > Apparently that's an allowed scenario, as the jump label code seems to
> > > > be actively trying to support it.  Basically the last one "wins".
> > > > 
> > > > See for example:
> > > > 
> > > >     1dbb6704de91 ("jump_label: Fix concurrent static_key_enable/disable()")
> > > > 
> > > > Also the purpose of the first atomic_read() is to do a quick test before
> > > > grabbing the jump lock.  So instead of grabbing the jump lock earlier,
> > > > it should actually do the first test atomically:
> > > 
> > > Makes sense but the enable path can also set key->enabled to -1.
> > 
> > Ah, this code is really subtle :-/
> > 
> > > So I think a concurrent disable could then see the -1 in tmp and still
> > > trigger the WARN.
> > 
> > I think this shouldn't be possible, for the same reason that
> > static_key_slow_try_dec() warns on -1:  key->enabled can only be -1
> > during the first enable.  And disable should never be called before
> > then.
> 
> hmm, right but I think in this case the reproducer is writing to a sysfs
> file to enable/disable randomly so i'm not sure if there is anything that
> would enforce that ordering. I guess you could try the reproducer, I haven't
> really looked at it in any detail.
> 
> The code in question here is in mm/vmscan.c which actually already takes the
> local 'state_mutex' for some cases. So that could be extended I think easily
> to avoid this warning.

Hm, right... For now I'll just continue to allow "disable before enable"
(or "double disable") since it may be harmless and I don't want to
introduce any unnecessary constraints, unless we manage to convince
ourselves that it's the right thing to do.

I'll work up a patch.

-- 
Josh

