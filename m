Return-Path: <linux-kernel+bounces-109919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCA08857C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F66283FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083E157880;
	Thu, 21 Mar 2024 11:05:46 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16B57311
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019145; cv=none; b=AWZj8gkNGXyT63Ua7f1JLCKzB+1oG838qEJQUMdN8SpO/VoK1H1nE0G4EBl0PsIZUD+6gHKj7eqtTLhFx5yRPcE3fc0FpLD9/toh+Jrtr/mh/xPawCd6F6Gh/NxaFPQpQigwBAikFW/EY/2TODE685wvg8l/jDI/tjeGVrchHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019145; c=relaxed/simple;
	bh=slbxlN2nSei3VCKDGLMiugztkO4zWq96JKaboOhSAAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0/CeZEFBLLoyVHuMhJkyM7J+oTEWVgMLIctGyx28MRu4Gujpg1rSBP/3DU/yJiUDXdFZFQge5FOENqFzTYIkHjH7HClDBAkYqAzp8uQ5jYwutaWDp/lGbKB+KoYPDbcQTnT4oicDcKprAsEB2e5aKCz9H71tCH8gdCys7jHGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6973B37268;
	Thu, 21 Mar 2024 11:05:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1123136AD;
	Thu, 21 Mar 2024 11:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8LM4MIAU/GUXKwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 21 Mar 2024 11:05:36 +0000
Date: Thu, 21 Mar 2024 12:07:02 +0100
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
Message-ID: <ZfwU1mGQKejNaKIk@localhost.localdomain>
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-3-osalvador@suse.de>
 <Zfnd_w0ZLOVhgACt@casper.infradead.org>
 <ZfptWDsfdxBltN6T@localhost.localdomain>
 <ed41d5cf-d068-412d-b7bb-5468df2fefb7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed41d5cf-d068-412d-b7bb-5468df2fefb7@suse.cz>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6973B37268
X-Spam-Flag: NO

On Thu, Mar 21, 2024 at 11:50:36AM +0100, Vlastimil Babka wrote:
> Yeah I think we could keep that logic.

I am all for keeping it.

> But we could also simply subtract the refcount of the old handle (the
> "allocated for migration") in __folio_copy_owner() no? Then we wouldn't need
> the extra migrate_handle.

Since new_page will have the old handle pointing to the old stack after
the call, we
could uncharge the old_page to the migrate_stack, which new_page->_handle holds
before it gets changed.

So we basically swap it.

It could work, but I kinda have a bittersweet feeling here.
I am trying to work towards to reduce the number of lookups in the
hlist, but for the approach described above I would need to lookup
the stack for new_page->handle in order to substract the page.

OTHO, I understand that adding migrate_handle kinda wasted memory.
16MB for 16GB of memory.

> Also we might have more issues here. Most page owner code takes care to set
> everything for all pages within a folio, but __folio_copy_owner() and
> __set_page_owner_migrate_reason() don't.

I did not check deeply but do not we split the folio upon migration
in case it is large?
Which means we should reach split_page_owner() before the copy takes
place. Do I get it right?

-- 
Oscar Salvador
SUSE Labs

