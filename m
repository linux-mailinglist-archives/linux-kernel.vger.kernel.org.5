Return-Path: <linux-kernel+bounces-71094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5A685A08C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941232833AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694C25577;
	Mon, 19 Feb 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ie9r2ZKQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mj08GQn9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ie9r2ZKQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mj08GQn9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56425566
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337367; cv=none; b=Uvg3P4xjKysD2mxQmls8dh52URzJfRC7sjd9qi0qfoBHpaRvpWF6X/SmS1vFf0ETuUOEf21jlcd4gTS6da35xHzRkd8d6TixHyUj3qHIHjUgiyYuyJa56UOmyLeXQcasuOQD01W/tlQO4gJxYzKvOXhVXfSBYO7MQB7UfxHiynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337367; c=relaxed/simple;
	bh=k/voNneGbsmqIa7sMmKe9mfusvIVX5YsaJqFjBA+7RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhkH80BB9WTZcLsmQEdiLtWpZyYo1vUf9JS2+dR5ywgi0FaV/kuYMtdcDuzMua2/Hc1MRtC0kvhsa3Av7YgHkQ+f80KgS0x1p36nTw/KCZl5Ys9TR8WTlitf7tKXJBzgX4fUC7Y2T6ZM5j0BYUgSwkV5/SBNmxLoQFqv+IbiujM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ie9r2ZKQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mj08GQn9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ie9r2ZKQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mj08GQn9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1D51F7EA;
	Mon, 19 Feb 2024 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708337363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1xMHP/zh/+gHfFTx7WiqGoBVICRU6Iop804Hy+R6yo=;
	b=ie9r2ZKQZzgUNv24bcnmFrJ9tqz+ggn76d5hkfU2MThCcPp96QXxLX/AYWowXxt3yM5Iu9
	T24Yh+O/TT5cbA1O6RRc7S4zGsEAg8P8aSTcGNoE+4HsWyqJbwPfNGNYeDj2dF2wQ/WXC/
	NnpC60D9HU5Csi/s6s0HQCxICoyA9wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708337363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1xMHP/zh/+gHfFTx7WiqGoBVICRU6Iop804Hy+R6yo=;
	b=mj08GQn9qdMQI6Hm2PV+uM9RA/BCQglehIdJ1mNRi5W+BD2oMna5eevp2z7E1MKNkh/9YN
	sPW4z6gN+pXNTFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708337363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1xMHP/zh/+gHfFTx7WiqGoBVICRU6Iop804Hy+R6yo=;
	b=ie9r2ZKQZzgUNv24bcnmFrJ9tqz+ggn76d5hkfU2MThCcPp96QXxLX/AYWowXxt3yM5Iu9
	T24Yh+O/TT5cbA1O6RRc7S4zGsEAg8P8aSTcGNoE+4HsWyqJbwPfNGNYeDj2dF2wQ/WXC/
	NnpC60D9HU5Csi/s6s0HQCxICoyA9wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708337363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1xMHP/zh/+gHfFTx7WiqGoBVICRU6Iop804Hy+R6yo=;
	b=mj08GQn9qdMQI6Hm2PV+uM9RA/BCQglehIdJ1mNRi5W+BD2oMna5eevp2z7E1MKNkh/9YN
	sPW4z6gN+pXNTFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55A39139D0;
	Mon, 19 Feb 2024 10:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n+aNFNMo02XVHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Feb 2024 10:09:23 +0000
Message-ID: <91c50335-e7b6-4ae1-9dad-a0c990b52021@suse.cz>
Date: Mon, 19 Feb 2024 11:09:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regression/bisected commit
 773688a6cb24b0b3c2ba40354d883348a2befa38 make my system completely unusable
 under high load
Content-Language: en-US
To: Marco Elver <elver@google.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, glider@google.com,
 dvyukov@google.com, eugenis@google.com, Oscar Salvador <osalvador@suse.de>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsOzpRPZGg23QqJAzKnqkZPKzvieeg=W7sgjgi3q0pBo0g@mail.gmail.com>
 <CANpmjNN-5PpSQ1A_9aM3u4ei74HuvCoThiLAHi=reXXQwer67A@mail.gmail.com>
 <CANpmjNM=92PcmODNPB4DrAhfLY=0mePCbyG9=8BGrQ4MC0xZ6w@mail.gmail.com>
 <CABXGCsM+9TxxY-bOUw6MyRV7CSZsyQpfDgvwgaBBKk9UONJkBw@mail.gmail.com>
 <CABXGCsOp3Djn5uQYb3f=4k1m9rY9y3Ext9SMavWAFRTcKwtNMA@mail.gmail.com>
 <CA+fCnZeNsUV4_92A9DMg=yqyS_y_JTABguyQyNMpm6JPKVxruw@mail.gmail.com>
 <CABXGCsPerqj=zXJ0pUCnZ29JGmZFSvH6DB22r2uKio61c1bVkw@mail.gmail.com>
 <CANpmjNMn+ULqbSGQ6uOa0JDhw=2my5TtBK4Y+xyBES_iaG_SEA@mail.gmail.com>
 <CABXGCsM9BSD+SYFkvkYxmcrZL+aUfUb_M-rjNJhzb2cYHQr5ww@mail.gmail.com>
 <CANpmjNNXKiM0j4mR-Rr2KALhgz87=QjCOomEymNMWjtos=Z3Ug@mail.gmail.com>
 <CANpmjNOnbNw2fRL3_depaAgt81p-VpHh5_O_26kyxofjECgsFQ@mail.gmail.com>
 <CABXGCsPB-KEbE+SfymVmqfiomFVngFL2Je81Qyhw1F5_aZX-TQ@mail.gmail.com>
 <CABXGCsO5dcEuorLAXR3CFzDVyAWNk4_YfqCh=UJddfzpWF7hNg@mail.gmail.com>
 <CANpmjNPsdM2HrRFgEHYxX1seT2fbOFDuO6Ci-qF3X2y=9_PD1A@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNPsdM2HrRFgEHYxX1seT2fbOFDuO6Ci-qF3X2y=9_PD1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.01)[47.46%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[google.com,gmail.com,linux-foundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,google.com,suse.de,vger.kernel.org,kvack.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.40
X-Spam-Flag: NO

On 2/19/24 10:52, Marco Elver wrote:
> On Mon, 19 Feb 2024 at 10:48, Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> On Sat, Feb 3, 2024 at 1:14 AM Mikhail Gavrilov
>> <mikhail.v.gavrilov@gmail.com> wrote:
>> >
>> > You are right.
>> > Thanks for digging into it!
>> >
>>
>> This [2] revert is still not merged at least I checked on 4f5e5092fdbf.
>> Is there any plan to merge it or find another approach?
>>
>> [2] https://lore.kernel.org/all/20240118110216.2539519-2-elver@google.com/
> 
> I think it's already in -mm and -next. It just takes time, which is a
> good thing, after all we want to let -next testing confirm nothing is
> wrong with it.
> 
> Andrew, is this planned for the next merge window or as a "hot fix"
> for the current rc? Given it has the right "Fixes" tags it will make
> it to stable kernels eventually, but I also think that the previous
> "slow" version is almost unusable on big systems, so it may be
> worthwhile considering the current rc.

Yeah it would be best to fix in 6.8 to prevent regressions.

> Thanks,
> -- Marco


