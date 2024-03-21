Return-Path: <linux-kernel+bounces-109986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58017885897
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565A41C218CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3155FB9C;
	Thu, 21 Mar 2024 11:52:51 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6525FB86
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021970; cv=none; b=aaZ4oJHt+zw+bDlqZugK2CSyQvxpW/fUYkGE2PmzTBoD6QBIoCCnTJo4ICmrg5OP6oGMtAhxEUi/gJIOP240bcMskGS4LSD3G5riP/Gm1xQuTNhAFWm0J1+vX8TsIolXUM12lvLqsuqpORUSbzDhh03zxtU8WloGNEqgcPcZHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021970; c=relaxed/simple;
	bh=o2AqpfgJy55VzmFbrCOgMCQrm+/rhvOZuJ6STrHhJkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skdd/Qzl5hNMMFMPM6Yk9Pf4IBampDA/BQmci56GGPKbJAqar/5ISFdpqG5pwtxC1+7SQA7gJ41nesrkZwr0uPM+kxPm+ALEyn1jb84qW+k4zePUjr6wyK4SLhQxGIcdZBdYUNw5iDQ58KqrsqECrwc9sTBo+VgQjCBl1kSNlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F9BD37307;
	Thu, 21 Mar 2024 11:52:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A855013976;
	Thu, 21 Mar 2024 11:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +W1lJo4f/GVjOgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 21 Mar 2024 11:52:46 +0000
Date: Thu, 21 Mar 2024 12:54:08 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v2 2/2] mm,page_owner: Fix accounting of pages when
 migrating
Message-ID: <Zfwf4Ei_DJVSytbR@localhost.localdomain>
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-3-osalvador@suse.de>
 <Zfnd_w0ZLOVhgACt@casper.infradead.org>
 <ZfptWDsfdxBltN6T@localhost.localdomain>
 <ed41d5cf-d068-412d-b7bb-5468df2fefb7@suse.cz>
 <ZfwU1mGQKejNaKIk@localhost.localdomain>
 <e291e52a-ae98-42ac-88c3-7463f952d490@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e291e52a-ae98-42ac-88c3-7463f952d490@suse.cz>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6F9BD37307
X-Spam-Flag: NO

On Thu, Mar 21, 2024 at 12:20:24PM +0100, Vlastimil Babka wrote:
> Understood, but migration is kinda heavy and non-fast-path operation already
> so the extra lookup wouldn't be in a critical fast path.

Ok, you convinced me, let us save that memory.

> When I mean is we have __set_page_owner_handle() setting up everything for
> tail pages and then we have __folio_copy_owner updating only the head page,
> so this will create kinda a mixed up information. Which might not be an
> issue as __folio_copy_owner() should mean it's a proper folio thus compound
> page thus nobody ever will check those mismatched tail pages... Maybe we
> could adjust  __set_page_owner_handle() to skip tail pages for compound
> pages as well and unify this, and tail pages would be only setup for those
> weird high-order non-compound pages so that the odd case in __free_pages()
> works?
> 
> Or maybe page_owner is considered debugging functionality enough so it might
> be worth having the redundant data in tail pages in case something goes
> wrong. But either way now it seems we're not doing it consistently.

So we basically have two options here, 1) is to also update tail pages
in __folio_copy_owner, and 2) is to follow __folio_copy_owner example
and skip tail pages in __set_page_owner.

The thing is, going with 2) might mean, as you pointed out, that if
something goes wrong we lose the information for those pages as
page_owner does not have a record for them.

OTOH, would that information be really useful? Sure we could see the stack, but
AFAICS not even the migrate_reason would be recorded in those tail
pages, which means that if they are migrated and freed, we would only
see that they were freed. (the free stack would point to the migrate
code though, so that is a hint).

Not really sure which path to take here, skipping tail pages would be
less of a complexity but at a risk of loosing information.

Anyway, let me first tackle the issue at hand here, and then I will
think more about that.

Thanks!

-- 
Oscar Salvador
SUSE Labs

