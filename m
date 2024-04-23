Return-Path: <linux-kernel+bounces-155313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D289C8AE8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1028F1C215E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538BA1369BC;
	Tue, 23 Apr 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ek/9j0ik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YAU9kVFi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ek/9j0ik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YAU9kVFi"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3264CCC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880302; cv=none; b=dvyKnRXDgZH22mB6JE6PS2U/Z/iJUcxYm+gWNmOeW9RRrX5Yu52Y3OooKk9wHSApyTX0oddsPklQFuJuYixPrYrK6jLjtr4uQZdM6lrRtSP9oAsSX2Yp0LoVNI4nRL0c2PMquNEAo1QCuAaYtmcj1vxd1po8ZNYRGSaAV4w9Vz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880302; c=relaxed/simple;
	bh=ii1mOYxyeDfonuF8ZMo6BnhNMvbKKmJsq3pE2/0jSX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q14LWyzytdXBHEJGQtvlfFzaNYN/kwSfYc+BETfgh8EWnN+4ca5WJK8vvjsnuFlAWLK5UB7l03UcalaIz6eNwU6L+Wms2Hxd5rlVx+qyCm+ZGWgKNj9TwdDrCBj25tvHl3ejBxn6h2Uk9a7ssCPF+rjwPHIhrKkR39PmCwSlrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ek/9j0ik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YAU9kVFi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ek/9j0ik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YAU9kVFi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 537AD38044;
	Tue, 23 Apr 2024 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713880299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nNDYWhAMUr5BYb/IUllkBXMo9i6OC9KEcl7WK30r0Y=;
	b=Ek/9j0ikEwb2fBivuYFM4U44EvCDJG4BmiVcPr55e6l2su5UYXMt8McNZThgnAVeKaxLW9
	mZkOGkj6etV1VtrBskdx3yNFRBobO6GH4Y6WBpgQLkpyxCO8RazVCTCnFPptQ8XSWhZ4WZ
	OX2OUilka0BkrpG4XccEyqF/ZZbPtlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713880299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nNDYWhAMUr5BYb/IUllkBXMo9i6OC9KEcl7WK30r0Y=;
	b=YAU9kVFim6OWfKlIDP6glcAJPF9QDgBZa+U7o/KzpPDBuWhJH/7jiJQQ7hpclD47t8dIYJ
	jLJOUB1GSKddWhAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713880299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nNDYWhAMUr5BYb/IUllkBXMo9i6OC9KEcl7WK30r0Y=;
	b=Ek/9j0ikEwb2fBivuYFM4U44EvCDJG4BmiVcPr55e6l2su5UYXMt8McNZThgnAVeKaxLW9
	mZkOGkj6etV1VtrBskdx3yNFRBobO6GH4Y6WBpgQLkpyxCO8RazVCTCnFPptQ8XSWhZ4WZ
	OX2OUilka0BkrpG4XccEyqF/ZZbPtlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713880299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nNDYWhAMUr5BYb/IUllkBXMo9i6OC9KEcl7WK30r0Y=;
	b=YAU9kVFim6OWfKlIDP6glcAJPF9QDgBZa+U7o/KzpPDBuWhJH/7jiJQQ7hpclD47t8dIYJ
	jLJOUB1GSKddWhAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 382E413929;
	Tue, 23 Apr 2024 13:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CxMaDeu8J2ZpcAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 23 Apr 2024 13:51:39 +0000
Date: Tue, 23 Apr 2024 15:51:37 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev,
	mike.kravetz@oracle.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
 dissolve_free_hugetlb_folio()
Message-ID: <Zie86XQGN91OcXHj@localhost.localdomain>
References: <20240419085819.1901645-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419085819.1901645-1-linmiaohe@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Fri, Apr 19, 2024 at 04:58:19PM +0800, Miaohe Lin wrote:
> When I did memory failure tests recently, below warning occurs:
> 
..
> 
> Fix this issue by checking whether folio is hugetlb directly instead
> of checking clear_flag to close the race window.
> 
> Fixes: 32c877191e02 ("hugetlb: do not clear hugetlb dtor until allocating vmemmap")
> CC: stable@vger.kernel.org
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

