Return-Path: <linux-kernel+bounces-71279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370485A2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E731C23335
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1A2D604;
	Mon, 19 Feb 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pgQnDRCt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pgQnDRCt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA552D059
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344456; cv=none; b=LpKWxyhhBmeM6lbZfhCOF8YtoNil6awqOpgQxLDubd+m9GNcSikAQPmxcAbXT1V6z2YEzOdjnyrE+D+TybOBzzGAa+0qhr52Zw6DVokgbmf87qDNZzQYIbZCsxX+jag5l5npHqQdAie+eFsI581siq9Lzosu2GDK15Tx8T+btvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344456; c=relaxed/simple;
	bh=AejfWbyL99l8I22HrWQkEtRR0Vbh3sfo/tZWSGUXnmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIb0LbnnB3vUCcTSkhAAGFKasvt8a3sLDpw46JxJEgLhKpFMS9ORq5nqXdUL03P9xoJiNa2TbaG3l0JW4KCJoRsY2gmX9lIyLLwoqbEKpT1mQVZCDAuUVWheAmq1lkCephDPOI5TYqLO7hj1hbrM0s5wm2GeMmptIdZrhlF9Jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pgQnDRCt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pgQnDRCt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7B2D21FD08;
	Mon, 19 Feb 2024 12:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708344452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0a/KddcLKmhK2Pu1JkEfLqBM9Cv44V7yFOdZCyPJ9I=;
	b=pgQnDRCtmlh5EOcF3ZdBgkI/xnPrlEqIusjMT6GNppnwaC7BTcBLPyEZlHBJljZkFI/cJ8
	0mz3kXR9tImVrJleTm126gLED/2mQ/5MVj4nzZOz6KTu0m1axAjpVETb8/mPHvIm/oqijX
	WbxhPHb5XnoxciPDIusG+2z+YFPj7Nk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708344452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0a/KddcLKmhK2Pu1JkEfLqBM9Cv44V7yFOdZCyPJ9I=;
	b=pgQnDRCtmlh5EOcF3ZdBgkI/xnPrlEqIusjMT6GNppnwaC7BTcBLPyEZlHBJljZkFI/cJ8
	0mz3kXR9tImVrJleTm126gLED/2mQ/5MVj4nzZOz6KTu0m1axAjpVETb8/mPHvIm/oqijX
	WbxhPHb5XnoxciPDIusG+2z+YFPj7Nk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587BB139D0;
	Mon, 19 Feb 2024 12:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDGYEoRE02ViPQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 19 Feb 2024 12:07:32 +0000
Date: Mon, 19 Feb 2024 13:07:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Aneesh Kumar <aneesh.kumar@kernel.org>,
	Huang Ying <ying.huang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Mel Gorman <mgorman@suse.de>, Ben Widawsky <ben.widawsky@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 3/3] mm/numa_balancing:Allow migrate on protnone
 reference with MPOL_PREFERRED_MANY policy
Message-ID: <ZdNEg_aA0LHJY22T@tiehlicka>
References: <9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com>
 <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7737208bd24e754dc7a538a3f7f02de84f1f72.1708097962.git.donettom@linux.ibm.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pgQnDRCt
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7B2D21FD08
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Sat 17-02-24 01:31:35, Donet Tom wrote:
> commit bda420b98505 ("numa balancing: migrate on fault among multiple bound
> nodes") added support for migrate on protnone reference with MPOL_BIND
> memory policy. This allowed numa fault migration when the executing node
> is part of the policy mask for MPOL_BIND. This patch extends migration
> support to MPOL_PREFERRED_MANY policy.
> 
> Currently, we cannot specify MPOL_PREFERRED_MANY with the mempolicy flag
> MPOL_F_NUMA_BALANCING. This causes issues when we want to use
> NUMA_BALANCING_MEMORY_TIERING. To effectively use the slow memory tier,
> the kernel should not allocate pages from the slower memory tier via
> allocation control zonelist fallback. Instead, we should move cold pages
> from the faster memory node via memory demotion. For a page allocation,
> kswapd is only woken up after we try to allocate pages from all nodes in
> the allocation zone list. This implies that, without using memory
> policies, we will end up allocating hot pages in the slower memory tier.
> 
> MPOL_PREFERRED_MANY was added by commit b27abaccf8e8 ("mm/mempolicy: add
> MPOL_PREFERRED_MANY for multiple preferred nodes") to allow better
> allocation control when we have memory tiers in the system. With
> MPOL_PREFERRED_MANY, the user can use a policy node mask consisting only
> of faster memory nodes. When we fail to allocate pages from the faster
> memory node, kswapd would be woken up, allowing demotion of cold pages
> to slower memory nodes.
> 
> With the current kernel, such usage of memory policies implies we can't
> do page promotion from a slower memory tier to a faster memory tier
> using numa fault. This patch fixes this issue.
> 
> For MPOL_PREFERRED_MANY, if the executing node is in the policy node
> mask, we allow numa migration to the executing nodes. If the executing
> node is not in the policy node mask but the folio is already allocated
> based on policy preference (the folio node is in the policy node mask),
> we don't allow numa migration. If both the executing node and folio node
> are outside the policy node mask, we allow numa migration to the
> executing nodes.

The feature makes sense to me. How has this been tested? Do you have any
numbers to present?

> Signed-off-by: Aneesh Kumar K.V (IBM) <aneesh.kumar@kernel.org>
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  mm/mempolicy.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)

I haven't spotted anything obviously wrong in the patch itself but I
admit this is not an area I am actively familiar with so I might be
missing something.
-- 
Michal Hocko
SUSE Labs

