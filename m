Return-Path: <linux-kernel+bounces-129166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64311896655
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ECF1F2141D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F558AAC;
	Wed,  3 Apr 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BrMBw/y2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qk53FNww"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D85788B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129137; cv=none; b=bkrBZppTk61a/DzP/nP7fmLJg0x71eg96XHGsBwzIE2GbBzAzrsU2V+e3t/qOouhdwTDecoOEnWWrDA20yOx1D6iKZEwe3aDUGoS73sblqctrzlMFTlEE5Brj7+gEZ2d0ZjG5ZL+JP3nqpVlj1YaPFUIx/yoSdGQzv4zBIcxijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129137; c=relaxed/simple;
	bh=TDdJ48dLCUTKzs7HsWggw5VnDEvxhN+2CybpDBCgj6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URdGlVweSqIxhQzHh+w00ECqTC2uJhP3ERG83dRrcGjv3nqCt1JR+Ns2nYtyPpxV+TQSrwq42t7uVHwPaJ7QlhULCrB4fpKb+I8SQw2nAj9H3p+cs81nfNTRh8+GTQCBmE1E6EJjbgD/+v2+fA/OdvcyVMuTn0zQT1mVLrWHhG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BrMBw/y2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qk53FNww; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EB4034A82;
	Wed,  3 Apr 2024 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712129134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RebLxOd0SLgMFmqgXlOCl+1mBGrTi8YMNEDZ3aS5lI=;
	b=BrMBw/y296S+yDp5eEuAIEdehd9g8k5Y4UZFuYhZ8CbyeTHpohF5jBXnXOqszQZ7EjirSY
	twp/EMr3hf8UVCMgk9fs4KKXmF+jx2GEjtbq/G8mMTQSxrfpQxrEumAcfxB60i8Vgf5Llq
	vryJnhpZDoZAqqfXWZMIu7tWNx3cTbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712129134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/RebLxOd0SLgMFmqgXlOCl+1mBGrTi8YMNEDZ3aS5lI=;
	b=Qk53FNwwIt1w2w1juNT1iBf1eretN6pBw0m2pmx0NOAdoalY7TkmR5yr8d7d80c3gXEL/E
	lUDa1aEtxpY04mDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 164661331E;
	Wed,  3 Apr 2024 07:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lsojBW4EDWYGFwAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Wed, 03 Apr 2024 07:25:34 +0000
Message-ID: <2cab01ce-7c5f-46d6-b8a4-c2a24c3f9a32@suse.cz>
Date: Wed, 3 Apr 2024 09:25:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm/slub: simplify get_partial_node()
To: "Song, Xiongwei" <Xiongwei.Song@windriver.com>,
 "rientjes@google.com" <rientjes@google.com>, "cl@linux.com" <cl@linux.com>,
 "penberg@kernel.org" <penberg@kernel.org>,
 "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
 "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-4-xiongwei.song@windriver.com>
 <69089796-9a3b-41a1-9b7c-18c773b96aa2@suse.cz>
 <PH0PR11MB5192C3A3806D89D0CACC2CEEEC3D2@PH0PR11MB5192.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <PH0PR11MB5192C3A3806D89D0CACC2CEEEC3D2@PH0PR11MB5192.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.49 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-0.71)[83.47%];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[windriver.com,google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_DKIM_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: 0.49
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 2EB4034A82

On 4/3/24 2:37 AM, Song, Xiongwei wrote:
>> 
>> 
>> It could be tempting to use >= instead of > to achieve the same effect but
>> that would have unintended performance effects that would best be evaluated
>> separately.
> 
> I can run a test to measure Amean changes. But in terms of x86 assembly, there 
> should not be extra  instructions with ">=".
> 
> Did a simple test, for ">=" it uses "jle" instruction, while "jl" instruction is used for ">".
> No more instructions involved. So there should not be performance effects on x86.

Right, I didn't mean the code of the test, but how the difference of the
comparison affects how many cpu partial slabs would be put on the cpu
partial list here.

> Thanks,
> Xiongwei
> 
>> 
>> >
>> > +             put_cpu_partial(s, slab, 0);
>> > +             stat(s, CPU_PARTIAL_NODE);
>> > +             partial_slabs++;
>> > +
>> > +             if (partial_slabs > slub_get_cpu_partial(s) / 2)
>> > +                     break;
>> >       }
>> >       spin_unlock_irqrestore(&n->list_lock, flags);
>> >       return partial;
> 


