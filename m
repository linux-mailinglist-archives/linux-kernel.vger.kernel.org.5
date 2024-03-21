Return-Path: <linux-kernel+bounces-109884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FBA885751
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6601C20938
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07956448;
	Thu, 21 Mar 2024 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T2QWm8qW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rzqqpvn+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T2QWm8qW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rzqqpvn+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1462125CB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016318; cv=none; b=UBLWqs5qBAN2e+NMzgh8j3/q2TWjkemg3szIaYsuBYsce236b9U3olhUtcEDt0NExHJVQaCSxBrqtOTXAWX7HWeZK+ocm8Cfdv/cp/Boa5SCayS3ZKy36dG01c75orkBbs8VkgjazaWZm/VnODuql9YxCmwGPn09/ylL+LIVabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016318; c=relaxed/simple;
	bh=KH1DAtbwkIgE/3yFCBobdyfmXqzoTQdnhdEFXA1kgxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxEA6WTfMuLso4hb86ybXyAzZ3Jpz5XHUdvYUb3rFKBHlLSutNTxgUkt95R4jVIfSCM10zPRRBPNhy3nEB3DQI1lKrTim+8KukpX+7fuw4g6lUx6vuRexquRjwGQXPV7273hOKUnw8V6upA6bqY8lB4eVAFuNNJ0ymdE4fDcbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T2QWm8qW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rzqqpvn+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T2QWm8qW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rzqqpvn+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF3065CC22;
	Thu, 21 Mar 2024 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711016314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0JrAJs2mKSXHbeA7yys/qJrodJcZdvqB2ovIVFOOfg=;
	b=T2QWm8qWdk6yS4X/0bAANhZpcmr+2JyQFhimv/yIFExkpTnHDdB43ipDYO4xnHDE2Eo+BM
	LVRonvW3qpfqGTy/a0m7aPHGHhMu6+cOMDRbwvcihlPYCiYT+xWJC5MyKdV03LezYoOINA
	IFEbVz7wRXvF5sZkx6egYYxBGyVy+1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711016314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0JrAJs2mKSXHbeA7yys/qJrodJcZdvqB2ovIVFOOfg=;
	b=rzqqpvn+tYK+d2QiZOvmmXyyvV6RGdAM1ciYMvgL9NcGS1Y4yc+X7YbNDpMVQjDqPFMML1
	RnbR881FQSiyYCCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711016314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0JrAJs2mKSXHbeA7yys/qJrodJcZdvqB2ovIVFOOfg=;
	b=T2QWm8qWdk6yS4X/0bAANhZpcmr+2JyQFhimv/yIFExkpTnHDdB43ipDYO4xnHDE2Eo+BM
	LVRonvW3qpfqGTy/a0m7aPHGHhMu6+cOMDRbwvcihlPYCiYT+xWJC5MyKdV03LezYoOINA
	IFEbVz7wRXvF5sZkx6egYYxBGyVy+1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711016314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R0JrAJs2mKSXHbeA7yys/qJrodJcZdvqB2ovIVFOOfg=;
	b=rzqqpvn+tYK+d2QiZOvmmXyyvV6RGdAM1ciYMvgL9NcGS1Y4yc+X7YbNDpMVQjDqPFMML1
	RnbR881FQSiyYCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B09113976;
	Thu, 21 Mar 2024 10:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 011+D3oJ/GUBGwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 21 Mar 2024 10:18:34 +0000
Date: Thu, 21 Mar 2024 11:20:00 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <muchun.song@linux.dev>
Cc: syzbot <syzbot+3b9148f91b7869120e81@syzkaller.appspotmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags
Message-ID: <ZfwJ0JOgcMCTcSgZ@localhost.localdomain>
References: <0000000000006cfe98061423cde7@google.com>
 <812E97E8-668F-414D-9480-1D284834A034@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <812E97E8-668F-414D-9480-1D284834A034@linux.dev>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T2QWm8qW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rzqqpvn+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.48)[91.54%];
	 TAGGED_RCPT(0.00)[3b9148f91b7869120e81];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -3.49
X-Rspamd-Queue-Id: BF3065CC22
X-Spam-Flag: NO

On Thu, Mar 21, 2024 at 05:49:49PM +0800, Muchun Song wrote:
> There are some more page dumping information from console:
> 
> [ 61.367144][ T42] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888028132880 pfn:0x28130
> [ 61.371430][ T42] flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
> [ 61.374455][ T42] page_type: 0xffffffff()
> [ 61.376096][ T42] raw: 00fff80000000000 ffff888015ecd540 dead000000000100 0000000000000000
> [ 61.379994][ T42] raw: ffff888028132880 0000000000190000 00000000ffffffff 0000000000000000
> 
> Alright, the page is freed (with a refcount of 0).

Yes, basically the page changed betwen folio_test_large() (returned true
for PG_Head) and the call to const_folio_flags() (which now returned
false for PG_Head).

As David pointed out, Willy is working on making PageHutelb more
robust [1].

 
[1] https://lore.kernel.org/linux-mm/20240314012506.1600378-1-willy@infradead.org/

-- 
Oscar Salvador
SUSE Labs

