Return-Path: <linux-kernel+bounces-127846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AD8951A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB801C2250E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F92657A7;
	Tue,  2 Apr 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OpjzEZSI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sqEKNPI3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA02657D3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056702; cv=none; b=q1Z+tQ6q3n88oP3SM1GICysCJmIFvcKVspI3hMWEFhvaRmEWGAqG3TC5OBTauIcASLBgvSCoDEC+VzhROFfWnorYHPE2E9+0isloXmE5Y5YKUI8nR1m3yLERZVz8H64/1vbDcaFaDk596jb5GHoa7dkyejxrokWsYUzKB1SYUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056702; c=relaxed/simple;
	bh=ICD4Y8wvqTNQH/0MD5Y90RNOMbA2NIYL56fFbjuysDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBZT+luSat+7Cp8snm6/LEKrjRVZFgN+DQ+/Q4pJ84ZoKByC3g7hMLYh1dQeqdBTZUJv/L2ttBLWhgTPfw7xnOLhtKfwoqPv26EP+JU3qjsaVApFYP4LKUxyVOXIPXCiAh513eY6r8We7s06LKvQ955FVjpqRXloiap9OJA6bBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OpjzEZSI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sqEKNPI3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E6C1345F5;
	Tue,  2 Apr 2024 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712056697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAq/U+6X2FU1Ny7L5MaCtJaxVAMjEFjjhoVMNVa1LRA=;
	b=OpjzEZSIeaV/xVL5HxPYCzZcziyAGhwFUlrXAJCEiamSkZp7kMngXd7IvTFJs86ubo9BwB
	4/hv/kIjmcj52eCfkL8Id5Fq3NMe+Nx10EtkEpFwLBMVK9HAoBnoKWEyR2Byu3o7NF+xyP
	PcuH5bySzf/55VT4EwUNme6qF88H4e8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712056697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aAq/U+6X2FU1Ny7L5MaCtJaxVAMjEFjjhoVMNVa1LRA=;
	b=sqEKNPI3qoHg/qxrpvEH7msdmJiNVLL2N05M4q6ZjouWy9JNY8LvXoQg5JLPeCRXk/ngnv
	aaoFRSl5Vn64DUCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0875813357;
	Tue,  2 Apr 2024 11:18:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CgP9OnjpC2YJJwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 02 Apr 2024 11:18:16 +0000
Date: Tue, 2 Apr 2024 13:19:42 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v3 1/3] mm,page_owner: Update metada for tail pages
Message-ID: <ZgvpzvX8E2WOkQmW@localhost.localdomain>
References: <20240326063036.6242-1-osalvador@suse.de>
 <20240326063036.6242-2-osalvador@suse.de>
 <fede9c3a-5686-4c44-a459-bf36c7093203@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fede9c3a-5686-4c44-a459-bf36c7093203@suse.cz>
X-Rspamd-Queue-Id: 7E6C1345F5
X-Spamd-Result: default: False [-3.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -3.31
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, Apr 02, 2024 at 12:13:37PM +0200, Vlastimil Babka wrote:
> Subject: metada -> metadata

Ooops.

> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> > @@ -355,31 +375,21 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
> > -	 * We don't clear the bit on the old folio as it's going to be freed
> > -	 * after migration. Until then, the info can be useful in case of
> > -	 * a bug, and the overall stats will be off a bit only temporarily.
> > -	 * Also, migrate_misplaced_transhuge_page() can still fail the
> > -	 * migration and then we want the old folio to retain the info. But
> > -	 * in that case we also don't need to explicitly clear the info from
> > -	 * the new page, which will be freed.
> > +	 * Do not proactively clear PAGE_EXT_OWNER{_ALLOCATED} bits as the folio
> > +	 * will be freed after migration. Keep them until then as they may be
> > +	 * useful.
> >  	 */
> 
> The full old comment made sense, the new one sounds like it's talking about
> the old folio ("will be freed after migration") but we're modifying the new
> folio here. IIUC it means the case of migration failing and then the new
> folio MIGHT be freed. So I think you made the comment too much concise to be
> immediately clear?

It probably could be improved by saying that there is no need to clear
the bit from the old folio since that will be done when __reset_page_owner()
gets called on the old folio.

Now, answering your question about whether we can fail or not at this
stage.
I looked into this a few weeks ago and I made my mind that no, we cannot
fail at this stage, and the following is my reasoning.

This is the callchain that leads to folio_copy_owner:

migrate_folio_move
 move_to_new_folio
  migrate_folio
   migrate_folio_extra
    folio_migrate_copy
     folio_copy
     folio_migrate_flags
      folio_copy_owner

folio_copy_owner() gets called only from folio_migrate_flags().
And all the functions that call folio_migrate_flags(), return
MIGRATEPAGE_SUCCESS right after calling it, so it is kinda the last
step of the migration.

So no, we cannot fail at this stage, so we do not have to worry about
undoing this.


-- 
Oscar Salvador
SUSE Labs

