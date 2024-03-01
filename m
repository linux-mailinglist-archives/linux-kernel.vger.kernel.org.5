Return-Path: <linux-kernel+bounces-89022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B72186E998
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DF1284DF4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8C3BB55;
	Fri,  1 Mar 2024 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iNE8hwhO"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA03A1B0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321419; cv=none; b=TYR6uHtNjO/8hNJOPtLZnKUrhmCKrrC1f9djEVMG+JduMKheYdYNKmPObfQVofE9YBWZjuiDt5P2xvQvU+ZkjJ7lPuD0QfC29kjHCG4/P31P5s/OlCf3xXrzKZuSVDnYZOK6aqkdx0QO3YmIdAiitkrcB7Dcg79XMoFFTJ0aj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321419; c=relaxed/simple;
	bh=fC8yO5GWYw+06lbv+gmvQc70RO0jzfxz/BUuBmtcRTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FuvVmuxsm7WjXNpRfV+4E1YlybRWsZh7J/rlFA7SBtPxvPec8t8qlrP8JpUvWluYGvc936XG4eeUMyz5Ff5P3epZvowDKiN2Vp50BNN/Zh7OXc90aY/mXWBJ54v9t3QsLeILCU5kpM0bllBJ3r24jbBRNSwpPVmTxyYEHWWR/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iNE8hwhO; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 1 Mar 2024 14:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709321415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KVORUB8MfdgpvFduZPozM66OeXPUqmhrFFOZyuRPc9k=;
	b=iNE8hwhOIYqwMWCsgj7YwWxI+o4wpI/RWuHzWRfRtHlhGO6nngoPvBnN710qq8ORRCLgsN
	jHacogkkt5a2w6i/CCMc3asHARnnbCbMObcUFMzv1iQFYu0SuSoNWZ4uajtB4+lGHM+fGu
	Kv47NrxHkfnRRUF6w3nRh/CVYXuaAw4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH 01/21] bcachefs: KEY_TYPE_accounting
Message-ID: <gmyoy7dfs67dnoc3vznfpcjbe2vgo3fuqlssw5lk2opbb2jmu3@nxlkvv724i5u>
References: <20240225023826.2413565-1-kent.overstreet@linux.dev>
 <20240225023826.2413565-2-kent.overstreet@linux.dev>
 <Zd4Ef49kHX3g69VT@bfoster>
 <t6cc6gqgla2csyvrsv2znel5lg76vx7t2zna772qpw7zd6pnft@rxdakxza5cab>
 <ZeDQQ8cyMTgYaY6D@bfoster>
 <r2ieuj2kvitrrg7sqhuossm3wn4zzlkhygfqx7bxorzbaylnw2@kpgfn4e42iuw>
 <ZeHuKv4ciR22X87z@bfoster>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeHuKv4ciR22X87z@bfoster>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 10:03:06AM -0500, Brian Foster wrote:
> On Thu, Feb 29, 2024 at 04:24:37PM -0500, Kent Overstreet wrote:
> > On Thu, Feb 29, 2024 at 01:43:15PM -0500, Brian Foster wrote:
> > > Hmm.. I think the connection I missed on first look is basically
> > > disk_accounting_key_to_bpos(). I think what is confusing is that calling
> > > this a key makes me think of bkey, which I understand to contain a bpos,
> > > so then overlaying it with a bpos didn't really make a lot of sense to
> > > me conceptually.
> > >
> > > So when I look at disk_accounting_key_to_bpos(), I see we are actually
> > > using the bpos _pad field, and this structure basically _is_ the bpos
> > > for a disk accounting btree bkey. So that kind of makes me wonder why
> > > this isn't called something like disk_accounting_pos instead of _key,
> > > but maybe that is wrong for other reasons.
> > 
> > hmm, I didn't consider calling it disk_accounting_pos. I'll let that
> > roll around in my brain.
> > 
> > 'key' is more standard terminology to me outside bcachefs, but 'pos'
> > does make more sense within bcachefs.
> > 
> 
> Ok, so I'm not totally crazy at least. :)
> 
> Note again that wasn't an explicit suggestion, just that it seems more
> logical to me based on my current understanding. I'm just trying to put
> down my initial thoughts/confusions in hopes that at least some of this
> triggers ideas for improvements...

I liked it because it makes the relationship between disk_accounting_pos
and bpos more explicit - they're both the same kind of thing.

> > > Either way, what I'm trying to get at is that I think this documentation
> > > would be better if it explained conceptually how disk_accounting_key
> > > relates to bkey/bpos, and why it exists separately from bkey vs. other
> > > key types, rather than (or at least before) getting into the lower level
> > > side effects of a union with bpos.
> > 
> > Well, that gets into some fun territory - ideally bpos would not be a
> > fixed thing that every btree was forced to use, we'd be able to define
> > different types per btree.
> > 
> 
> Ok, but this starts to sound orthogonal to the accounting bits. Since I
> don't really grok why this is called a key, here's how I would add to
> the existing documentation:
> 
> "Here, the key has considerably more structure than a typical key
> (bpos); an accounting key is 'struct disk_accounting_key', which is a
> union of bpos. We do this because disk_account_key actually is bpos for
> the related bkey that ends up in the accounting btree.
> 
> This btree uses nontraditional bpos semantics because accounting btree
> keys are indexed differently <reasons based on the counter
> structures..?>. Yadda yadda..
> 
> Unlike with other key types, <continued existing comment> ...

I'm just going to go with my latest revision for now, I think it's a
reasonable balance between terse and explanatory:

 * More specifically: a key is just a muliword integer (where word endianness
 * matches native byte order), so we're treating bpos as an opaque 20 byte
 * integer and mapping bch_accounting_pos to that.

