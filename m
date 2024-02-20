Return-Path: <linux-kernel+bounces-72681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B3485B730
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09391F21717
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB985F54D;
	Tue, 20 Feb 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E/GiE8EK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YiMkR6mr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E/GiE8EK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YiMkR6mr"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE55F477
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420889; cv=none; b=nhGSAADByz1tSi84gOkcePFqgCU0rFSqZuqhngaeOJzf1LcH2EG9owPV2Vh8lV9W2D1Hnfy5pV/eHECm6vOGtQYcWJ82eKc56YZkyfl7mDHtoWZKs59s2/sDFxbHARAxv01fPmikkoQD2zvXgwO2KO57T5mQhbFDnWDDUC6zAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420889; c=relaxed/simple;
	bh=xQ1gQYA+ji+iUjW7UGzZja03wWizPQFAjUz0snoJtAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1EJhE0eBh6+cBKQi1T5dlUdwYFTy+1CfUoOke0uit7zj1ASxc/wSZEXo7/5n2skhmxuPwTheegSxYg2mq2jQI89A8gadX0iAxwlbq4vhNJQsWqWN8VnHOG1lFkAdL8EFJI9rBKIc2Q2hErRKS68PxaePvjNQSPcry6q3L57i/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E/GiE8EK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YiMkR6mr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E/GiE8EK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YiMkR6mr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57B4C21F61;
	Tue, 20 Feb 2024 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708420885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sjz5RfeGjBV7xfeElN3pstsDd1FoRAefaT6PJlcvpA=;
	b=E/GiE8EKD9pbhN+BYbILJD+tM3xDhtj7srYKtbS8h+RhJTZp7Urc5YlkXdvlOJBkDKyJ80
	s48Ta8BSjDAuMF0HRfQtil0ljGjZ1ZUuyFIjuWPbhIxJ9gHZKo85mnDo9hvYYhRAwy/ET1
	MOB00Xi9FHkqYr4MiQIDvwcpTQ2nOL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708420885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sjz5RfeGjBV7xfeElN3pstsDd1FoRAefaT6PJlcvpA=;
	b=YiMkR6mrlwgQKkyAB1F65P0748ggXq6VbxQOmOBGSIU4xK0X9cMiOEaPRt198So/O27P5X
	7H9u4aJEoxtSrGBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708420885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sjz5RfeGjBV7xfeElN3pstsDd1FoRAefaT6PJlcvpA=;
	b=E/GiE8EKD9pbhN+BYbILJD+tM3xDhtj7srYKtbS8h+RhJTZp7Urc5YlkXdvlOJBkDKyJ80
	s48Ta8BSjDAuMF0HRfQtil0ljGjZ1ZUuyFIjuWPbhIxJ9gHZKo85mnDo9hvYYhRAwy/ET1
	MOB00Xi9FHkqYr4MiQIDvwcpTQ2nOL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708420885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Sjz5RfeGjBV7xfeElN3pstsDd1FoRAefaT6PJlcvpA=;
	b=YiMkR6mrlwgQKkyAB1F65P0748ggXq6VbxQOmOBGSIU4xK0X9cMiOEaPRt198So/O27P5X
	7H9u4aJEoxtSrGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34895134E4;
	Tue, 20 Feb 2024 09:21:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WSSDDBVv1GXVZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 09:21:25 +0000
Message-ID: <60edefec-0a78-4c23-bfb6-17ebf326c61a@suse.cz>
Date: Tue, 20 Feb 2024 10:21:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] Documentation: filesystems: introduce
 proc/slabinfo to users
Content-Language: en-US
To: zhang fangzheng <fangzheng.zhang1003@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com,
 Yuming Han <yuming.han@unisoc.com>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
 <20240219031911.10372-3-fangzheng.zhang@unisoc.com>
 <ZdLX51r1mOEZKUje@casper.infradead.org>
 <CA+kNDJ+C2b520afauSWbfNK=S1XiNHR_zF32_K-3Rf7R6m3n5Q@mail.gmail.com>
 <4591b2b3-398f-402e-b21d-55b244f05a2e@suse.cz>
 <CA+kNDJLCEdeQsaaLggxbUzF4mAqk_ZLKe=o3cnRkZO8_EKhoSQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+kNDJLCEdeQsaaLggxbUzF4mAqk_ZLKe=o3cnRkZO8_EKhoSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[infradead.org,unisoc.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,linuxfoundation.org,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/20/24 09:49, zhang fangzheng wrote:
> On Mon, Feb 19, 2024 at 4:09 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 2/19/24 07:23, zhang fangzheng wrote:
>> > On Mon, Feb 19, 2024 at 12:24 PM Matthew Wilcox <willy@infradead.org> wrote:
>> >>
>> >> On Mon, Feb 19, 2024 at 11:19:11AM +0800, Fangzheng Zhang wrote:
>> >> > +Note, <slabreclaim> comes from the collected results in the file
>> >> > +/sys/kernel/slab/$cache/reclaim_account. Next, we will mark /proc/slabinfo
>> >> > +as deprecated and recommend the use of either sysfs directly or
>> >> > +use of the "slabinfo" tool that we have been providing in linux/tools/mm.
>> >>
>> >> Wait, so you're going to all of the trouble of changing the format of
>> >> slabinfo (with the associated costs of updating every tool that currently
>> >> parses it), only to recommend that we stop using it and start using
>> >> tools/mm/slabinfo instead?
>> >>
>>
>> Hi,
>>
>> > The initial purpose was to obtain the type of each slab through
>> > a simple command 'cat proc/slabinfo'. So here, my intention is not to
>> > update all slabinfo-related tools for the time being, but to modify
>> > the version number of proc/slabinfo and further display the results
>> > of using the command.
>>
>> I'm not sure you understand the concern. There are existing consumers of
>> /proc/slabinfo, that might become broken by patch 1/2. We don't even know
>> them all, they might not be all opensource etc. So we can't even make sure
>> all of them are updated. What can happen after patch 1/2:
>> - they keep working and ignore the new column (good)
>> - they include a version check and notice a new unsupported version and
>> refuse to work
>> - confused by the new column they start throwing error, or report wrong
>> stats (that's worse)
>>
> I generally understand your concerns about modifying patch 1/2.
> 
> But judging from my modifications, this worry does not seem to be valid.
> Because the “/proc/slabinfo” is not used in related slabinfo debugging tools
> (such as tools/mm/slabinfo),

Hi,

we are not concerned about slabinfo debugging tools that are part of kernel
source tree, but about those outside, including those created privately and
we don't even know they exist.

> but "/sys/kernel/slab/<slab_name>/" (in
> Documentation/mm/slub.rst) or "/ sys/kernel/debug/slab" (in
> tools/mm/slabinfo.c).
> 
> Furthermore, the current modification only involves optimizing the output
> of proc/slabinfo,

It's not "only", the output of /proc/slabinfo is what those tools consume,
so that's what concerns us the most.

> and does not modify the  struct slabinfo or struct kmem_cache.
> So there is no need to adapt other modifications.

These on the other hand are internal details of the kernel which we can
modify as much we want

>> >> How about we simply do nothing?
>>
>> Agreed wrt modifying /proc/slabinfo
>>
>> > The note here means what changes will occur after
>> > we modify the version number of proc/slabinfo to 2.2.
>> > As for the replacement of tools/mm/slabinfo (that inspired
>> > by Christoph’s suggestions), it will be implemented in the next version
>> > or even the later version.
>>
>> So what is your motivation for all this in the first place? You have some
>> monitoring tool that relies on /proc/slabinfo and want to distinguish
>> reclaimable caches? So you can change it to parse the /sys directories. Is
>> it more work? Yes, but you only have to do that once per boot, because
>> unlike the object/memory stats in /proc/slabinfo, the reclaimable flag will
>> not change for a cache.
>>
> The situation as you mentioned is very suitable for my current needs.
> My original intention is just to get an intuitive slab screen through a
> simple ‘cat proc/slabinfo’ command. As for the description "<slabreclaim>

That would be nice, but again we must be careful about existing consumers of
/proc/slabinfo so we can't always have nice things.

> comes from the collected results in the file
> /sys/kernel/slab/$cache/reclaim_account"
> may not be appropriate. Here I want to express that the column <slabreclaim> has
> the same effect as traversing "/sys/kernel/slab/$ cache/reclaim_account".
> 
>> Would tools/mm/slabinfo almost work for you, but you're missing something?
>> Then send patches for that in the first place. Changing /proc/slabinfo (and
>> breaking other consumers) for a quick and easy fix with a different solution
>> planned for the future is simply not feasible.
>>
> Using the slabinfo tool to parse /sys/kernel/slab/$cache/reclaim_account
> is what I think about optimizing future tools during the discussion.
> It will not affect the current patch 1/2, and patch 2/2 is mainly to
> supplement the output examples of proc/slabinfo.
> 
> If the community is willing to accept it, I will only modify
> patch 1/2 to implement it.
> 
> Thanks very much!
> 
>> HTH,
>> Vlastimil
>>
>> > Thanks!
>>


