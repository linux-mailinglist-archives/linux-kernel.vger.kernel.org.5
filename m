Return-Path: <linux-kernel+bounces-50331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C7084777D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25959B22916
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156D314E2F9;
	Fri,  2 Feb 2024 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l59NXk5H"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1051726ADB;
	Fri,  2 Feb 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898710; cv=none; b=MsM8AAJdd11fytb6nYpgvm9gyemj1ZVkj/6ugxpEsDBNUGSdDPzVZjx7XgUZftfffllq9mMBsnzqaibgl5VzdAVOwdUEt3SfTsQawNObS7UalAK7aetqZH6CnDUlWwnkBoO4tg6KmPtSdYhwxwp71oFavq4SjJukFxD8aTMopuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898710; c=relaxed/simple;
	bh=xnJRCLGQha+0WlKFzYB1mlxeiaNmrKg6CBv49mBIhWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql7NIX6y69z/h4Zs+6fLAR8ZKE/NqeU7zCE39c0K+Ti/P0BAOdkQ6ez/hg2EO3wEuVzMgF8W86DPK83vbKJdBSHyZTcisf2IGiJQTz2bUxbMB1r4FhUCx2fctOylceQI3Acq1pXThVDQlHJZfy0tPma0E0FW8rYvtXGQ8rK4xQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l59NXk5H; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ZmH7pVZ4sZntB67OEN91/SxNu+S/S5mMs6QiO+nVgo=; b=l59NXk5HXZsuuhjCHcQjHtqnJ/
	ZuFI8hFueGEyLPtjqk1GGn7QkxgN4PBVSlSjHsNPTt5laUBj7WqcJouVDL7madbJ529JjDBSN1tfB
	5fkI/jUNlwoHuH1C8WDJ8ymF2wDQN/xWwlSa4iE5p6Tym4EMHgw3FF1YEQtRnAi3loBPLqiCAGESu
	OzHF1ZAjdf0K4Hjb1EOFyv6LHQL9TCm4ukwFBHYODv6eGz0/0gQRlFj3cj4SnsbJlIbBb+xnwUDoT
	1r4QN86Wxhkj3+ssC/yepIbNT6WgmG8G/mpR4a4uKAwAZ1aKlcv8ifjUmWqqPS9Vi7oX6OB/jK+oM
	ooicoNVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVyKK-0000000CtQJ-1t4X;
	Fri, 02 Feb 2024 18:31:48 +0000
Date: Fri, 2 Feb 2024 10:31:48 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kernel/module: add a safer implementation of
 try_module_get()
Message-ID: <Zb01FDz3sOvKglNQ@bombadil.infradead.org>
References: <20240130193614.49772-1-marpagan@redhat.com>
 <ZblgV0ApD-9cQWwl@bombadil.infradead.org>
 <cfa6cb2b-9432-4ed4-87ea-16be499d2806@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfa6cb2b-9432-4ed4-87ea-16be499d2806@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Feb 01, 2024 at 03:27:54PM +0100, Marco Pagani wrote:
> 
> On 2024-01-30 21:47, Luis Chamberlain wrote:
> > 
> > It very much sounds like there is a desire to have this but without a
> > user, there is no justification.
> 
> I was working on a set of patches to fix an issue in the fpga subsystem
> when I came across your commit 557aafac1153 ("kernel/module: add
> documentation for try_module_get()") that made me realize we also had a
> safety problem. 
> 
> To solve this problem for the fpga manager, we had to add a mutex to
> ensure the low-level module still exists before calling
> try_module_get(). However, having a safer version of try_module_get()
> would have simplified the code and made it more robust against changes.
> 
> https://lore.kernel.org/linux-fpga/20240111160242.149265-1-marpagan@redhat.com/
> 
> I suspect there may be other cases where try_module_get() is
> inadvertently called without ensuring that the module still exists
> that may benefit from a safer implementation.

Maybe so, however I'm not yet sure if this is safe from deadlocks.
Please work on a series of selftest simple modules which demonstrate
its use / and a simple bash script selftest loader which verifies this
won't bust. Consider you may have third party modules which also race
with this too, and other users without this new API.

> >> +bool try_module_get_safe(struct module *module)
> >> +{
> >> +	struct module *mod;
> >> +	bool ret = true;
> >> +
> >> +	if (!module)
> >> +		goto out;
> >> +
> >> +	mutex_lock(&module_mutex);
> > 
> > If a user comes around then this should be mutex_lock_interruptible(),
> > and add might_sleep()
> 
> Would it be okay to return false if it gets interrupted, or should I
> change the return type to int to propagate -EINTR? My concern with
> changing the signature is that it would be less straightforward to
> use the function in place of try_module_get().

Since we want a safe mechanism we might as well not allow a simple drop
in replacement but a more robust one so that users take care of the
return value properly.

  Luis

