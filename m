Return-Path: <linux-kernel+bounces-93527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5AB873104
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC511F2136F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A75D74F;
	Wed,  6 Mar 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2RDm71qY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCLBWCjz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2RDm71qY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCLBWCjz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F62E641
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714720; cv=none; b=EJ/d4YEfyaAj8RPPtiAM2iXAxbZ2c3ok3kEVUBdXBAA4k2tjQEI38gRIuhRamy9V3L/kbRb91hJtBlofjuOTQDn8uvcy6Gas2vG3YaI4i5Pt9F8nEHMnj/ZWFohXQkVedWjbO/gIeDYUKaajZ9x5K0CQUxORdK+Na3f0jB7Qqbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714720; c=relaxed/simple;
	bh=SAfOQXJPClJAnWs7E5f8VER84YPuD871EGJKvZeYlDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0fXfb371S8fozE17i+mhkvy3lkeJg/99UnkjRAlILVSxhaVQIXs1Se3k5ed2tLfbZkrRttFmNju/Pylj5ZsSUNZ1HQeVY6nbFl88h2jvpjtsiep5Tg42Tae0OmTvm4RKU2qxrnN8/mD4tJNb++4SO/hRJieUM7g2tA0UUVwSgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2RDm71qY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCLBWCjz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2RDm71qY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCLBWCjz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F29E21A20;
	Wed,  6 Mar 2024 08:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709714717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hNv5uA53bbnjTxhxZxB4EFwSuZ+2wclxh0E1t2ykxk=;
	b=2RDm71qYwUcCfefhb6/vy0hJdvWvBABcNFuJtMlHjtTXiuap3GoceJ/+ifKT032LDobxN0
	XlN+6I0mAigzbHc/XJenRpZK3NmxPC7voTVEcGjizktbeOu4ZHzhSwRQEX/NCPpAW2hQqd
	SU+UHLzjP0jXPJFp/RACk5ZMTwAH3uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709714717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hNv5uA53bbnjTxhxZxB4EFwSuZ+2wclxh0E1t2ykxk=;
	b=UCLBWCjzoVX1/ktiAgZfLWEybwS22JtC7bn3pqwzU2q305aQ3JcN+mlIEg8l8AeS53D1xp
	yrrP0NLLzHfLVtCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709714717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hNv5uA53bbnjTxhxZxB4EFwSuZ+2wclxh0E1t2ykxk=;
	b=2RDm71qYwUcCfefhb6/vy0hJdvWvBABcNFuJtMlHjtTXiuap3GoceJ/+ifKT032LDobxN0
	XlN+6I0mAigzbHc/XJenRpZK3NmxPC7voTVEcGjizktbeOu4ZHzhSwRQEX/NCPpAW2hQqd
	SU+UHLzjP0jXPJFp/RACk5ZMTwAH3uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709714717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5hNv5uA53bbnjTxhxZxB4EFwSuZ+2wclxh0E1t2ykxk=;
	b=UCLBWCjzoVX1/ktiAgZfLWEybwS22JtC7bn3pqwzU2q305aQ3JcN+mlIEg8l8AeS53D1xp
	yrrP0NLLzHfLVtCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CD43F1377D;
	Wed,  6 Mar 2024 08:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ctcPLxwt6GVjGwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 06 Mar 2024 08:45:16 +0000
Date: Wed, 6 Mar 2024 09:46:35 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, david@redhat.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, mhocko@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: hugetlb: make the hugetlb migration strategy
 consistent
Message-ID: <Zegta2FEb8pkV4vz@localhost.localdomain>
References: <cover.1709041586.git.baolin.wang@linux.alibaba.com>
 <bdca97e6c59f1b58f09e18defac0c47d1e38f44b.1709041586.git.baolin.wang@linux.alibaba.com>
 <Zd38_AYtr9QKp-F6@localhost.localdomain>
 <8d35b8ae-b8d8-4237-bfcf-ed63c0bb4223@linux.alibaba.com>
 <Zd7xnrzGb_8QiqcE@localhost.localdomain>
 <3eda72bd-25ad-4518-b38e-b63f75e5e94d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eda72bd-25ad-4518-b38e-b63f75e5e94d@linux.alibaba.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.86 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.76)[98.97%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.86

On Wed, Mar 06, 2024 at 04:35:26PM +0800, Baolin Wang wrote:
> On 2024/2/28 16:41, Oscar Salvador wrote:

> >   	if (folio_test_hugetlb(src)) {
> >   		struct hstate *h = folio_hstate(src);
> > +		bool allow_fallback = false;
> > +
> > +		if ((1UL << reason) & HTLB_ALLOW_FALLBACK)
> > +			allow_fallback = true;
> 
> IMHO, users also should not be aware of these hugetlb logics.

Note that what I wrote there was ugly, because it was just a PoC.

It could be a helper e.g:

 if (hugetlb_reason_allow_alloc_fallback(reason)) (or whatever)
     allow_fallback_alloc = true

> > 
> >   		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
> >   		return alloc_hugetlb_folio_nodemask(h, nid,
> > -						mtc->nmask, gfp_mask);
> > +						mtc->nmask, gfp_mask,
> > +						allow_fallback);
> 
> 'allow_fallback' can be confusing, that means it is 'allow_fallback' for a
> new temporary hugetlb allocation, but not 'allow_fallback' for an available
> hugetlb allocation in alloc_hugetlb_folio_nodemask().

Well, you can pick "alloc_fallback_on_alloc" which is more descriptive I
guess.

Bottomline line is that I do not think that choosing to allow
fallbacking or not here is spreading more logic than having the
htlb_modify_alloc_mask() here and not directly in
alloc_hugetlb_folio_nodemask().

As I said, code-wise looks fine, it is just that having to pass
the 'reason' all the way down and making the decision there makes
me go "meh..".


-- 
Oscar Salvador
SUSE Labs

