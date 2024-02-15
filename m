Return-Path: <linux-kernel+bounces-66847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62C6856255
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB781F27CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A3612B17F;
	Thu, 15 Feb 2024 11:57:39 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179F12B171
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998259; cv=none; b=gEgTnH/I+T4mHtLfi7itUVAsZG5/ItYeJaaxTSubf9pgFwfumI4xP6U97exqDPOtK9D+WidgcFbZjnsuzRhvoAnZ3awM087jjbEQI0s7CljW0OwV0ikBO4ZZrMOFiWFH/hOosPXC/j5TBsAW2yW6wi4XCSkpFoe4FKLGb9uusoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998259; c=relaxed/simple;
	bh=WNgeeoZaOMOZt+4Bl0O7s3ta+T1aHv+7CYkip/mTMGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI3mj3SaHt+0bp/emzROc0jlFZWKXA7lkZNIf0XK26JU3hRou7hGIsbuqT8jXxiKSPr+M4vY3654TNnjnMZtRzTSkDLa/tQPxwTL6xlZWzC4KodYgjm21FyY2Zn4QriN8BYmf9BQY+EhlZtmeXIWsGnt9qzu7G3DsO5t5gpklB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA9F722205;
	Thu, 15 Feb 2024 11:57:34 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 53DA21346A;
	Thu, 15 Feb 2024 11:57:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sGO6ES78zWVaBwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 11:57:34 +0000
Date: Thu, 15 Feb 2024 12:58:44 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v9 5/7] mm,page_owner: Display all stacks and their count
Message-ID: <Zc38dMg3t8L7xVyc@localhost.localdomain>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-6-osalvador@suse.de>
 <4f4f008b-bde1-4551-ae24-db2c0778eb27@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4f008b-bde1-4551-ae24-db2c0778eb27@suse.cz>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: CA9F722205
X-Spam-Flag: NO

On Thu, Feb 15, 2024 at 12:10:38PM +0100, Vlastimil Babka wrote:
> On 2/14/24 18:01, Oscar Salvador wrote:
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Acked-by: Marco Elver <elver@google.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks

> > +	for (i = 0; i < nr_entries; i++)
> > +		seq_printf(m, " %pS\n", (void *)entries[i]);
> > +	seq_printf(m, "stack_count: %d\n\n", refcount_read(&stack_record->count));
> 
> So count - 1 here to report actual usage, as explained in reply to 4/7?

Yes, will do.


-- 
Oscar Salvador
SUSE Labs

