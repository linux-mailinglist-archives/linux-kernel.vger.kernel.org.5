Return-Path: <linux-kernel+bounces-137293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63F89E00F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F811C222F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B71D13D885;
	Tue,  9 Apr 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bd/HlzmU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lqY1P33Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bd/HlzmU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lqY1P33Q"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2913D886
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679028; cv=none; b=ANwqS63oHpMyjTHknEStaUUFld+Mcy9GovGkdjsPr9GPnE3RVTINPoGXeEVDTcGLBx9AeI9r0AJyx+gr5fbZ9avySn3gYMnh6B9+Grtsu13Op6sYN1B/p4rEnI9OkyYf36I7wNjFGqZMju7pMuiCAW2jxOsl9UvoVWK+NRik4FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679028; c=relaxed/simple;
	bh=GJsoRzq816z9gabZ96VLhbdLIDuom/uboIuzFp+MCF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdlc2nodD2VsVfGmhNZWxKNIKl9eB6xcvrqWdjkLc08VG5HQI3JDdHQdQiUMJ00hzS+zbfs+F5ywU/k5jiLAiDO+CQpUDql0ZfoCYiYf7fAwbbiJ8Gld94F5hneCPy9F95eLVH/tkbWzuHDnPnM7XSnObhMIzRQhtyCy9tMGgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bd/HlzmU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lqY1P33Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bd/HlzmU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lqY1P33Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9920533ABB;
	Tue,  9 Apr 2024 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712679024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXgA26xKibh2o58sqe/B4dfezkEe1t/U2zFmJxz2JwM=;
	b=bd/HlzmUb1UmUPcaoMwg8saPSV75UIqeAfyWXQ6tWimnXIWn7qL2Ews7h78Ce7+jpEasrk
	NS58DvrXCK6MqQQ5rkxuorUaeUHrfvMvIweF/LPmNITl5rHUjwy2w6sOLPfoClq0pgHwE6
	RrIhnpOPsoztiGCT+jc/wgFVrb/+UW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712679024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXgA26xKibh2o58sqe/B4dfezkEe1t/U2zFmJxz2JwM=;
	b=lqY1P33QMvJ12f+QN69G4Kj6wTMJoxsx5RS615NBlpSjSJY03sRq5pjBnDilVvenqyu3Fk
	BZ497XHlc6TV1RDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712679024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXgA26xKibh2o58sqe/B4dfezkEe1t/U2zFmJxz2JwM=;
	b=bd/HlzmUb1UmUPcaoMwg8saPSV75UIqeAfyWXQ6tWimnXIWn7qL2Ews7h78Ce7+jpEasrk
	NS58DvrXCK6MqQQ5rkxuorUaeUHrfvMvIweF/LPmNITl5rHUjwy2w6sOLPfoClq0pgHwE6
	RrIhnpOPsoztiGCT+jc/wgFVrb/+UW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712679024;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jXgA26xKibh2o58sqe/B4dfezkEe1t/U2zFmJxz2JwM=;
	b=lqY1P33QMvJ12f+QN69G4Kj6wTMJoxsx5RS615NBlpSjSJY03sRq5pjBnDilVvenqyu3Fk
	BZ497XHlc6TV1RDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 446511332F;
	Tue,  9 Apr 2024 16:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id E0DuDXBoFWY7JAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 09 Apr 2024 16:10:24 +0000
Date: Tue, 9 Apr 2024 18:10:18 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, naoya.horiguchi@nec.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
Message-ID: <ZhVoatdJZ1RWu2r3@localhost.localdomain>
References: <20240407085456.2798193-1-linmiaohe@huawei.com>
 <ZhVMThr9TNeP6SWj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhVMThr9TNeP6SWj@localhost.localdomain>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Apr 09, 2024 at 04:10:22PM +0200, Oscar Salvador wrote:
> On Sun, Apr 07, 2024 at 04:54:56PM +0800, Miaohe Lin wrote:
> > In short, below scene breaks the lock dependency chain:
> > 
> >  memory_failure
> >   __page_handle_poison
> >    zone_pcp_disable -- lock(pcp_batch_high_lock)
> >    dissolve_free_huge_page
> >     __hugetlb_vmemmap_restore_folio
> >      static_key_slow_dec
> >       cpus_read_lock -- rlock(cpu_hotplug_lock)
> > 
> > Fix this by calling drain_all_pages() instead.
> > 
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Acked-by: Oscar Salvador <osalvador@suse.de>

On a second though,

disabling pcp via zone_pcp_disable() was a deterministic approach.
Now, with drain_all_pages() we drain PCP queues to buddy, but nothing
guarantees that those pages do not end up in a PCP queue again before we
the call to take_page_off_budy() if we
need refilling, right?

I guess we can live with that because we will let the system know that we
failed to isolate that page.


-- 
Oscar Salvador
SUSE Labs

