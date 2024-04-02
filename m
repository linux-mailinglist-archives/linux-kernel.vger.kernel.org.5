Return-Path: <linux-kernel+bounces-127513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63296894CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AFBB222D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5865A3BBC3;
	Tue,  2 Apr 2024 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QICgIq5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+fxZRqGX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A5818635
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043615; cv=none; b=RhQUcWcHiyIBk19+DRq0Z/tkt+D+PSks0N/F4OZN13C8v7k8sSf2FdfvTzB3L3Zct8rZe4tiMa3JFs7sEuCp6fObxJz+a2JfdVou716wDt1993zIqcTv16pnAnhYGCoyF4itTdKZnaLSe46Y5/hVL3DA1t2VgS9zYCsK6zwdCvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043615; c=relaxed/simple;
	bh=4CDXvCSs/l9q6MgwceuIcm4RO1YM+MS0w/p0tGlk4AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NV7AmGOQ+wH4tLiaj+K6B4gqZanMKLWYOa2mdtHAvH7PMrPzvwF2ZJ1jnjlQ4oSFuYksQpkD/jXL+osrfftsP+KMbR4+9BWgUuCrYKlpavE0H6OzLaDvafwU2/w9wCVGAMisrVUDEW+1Il79FlpZCs9Hsv2d6FVtxC9IEISY1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QICgIq5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+fxZRqGX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED4E820D91;
	Tue,  2 Apr 2024 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712043605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0O8XWaOhNB18VZt8keyCi8JOGWnMUiDcfFZIJVXWXI=;
	b=QICgIq5TxOCGpnTid58Hbyfg7aogHixN+Fe5Nz4dmFjanHt9MTqP/aqd6+sZvJ52E2zlXP
	i9OvHCUHzfhlapfMIwdY2/0/xtpFM1R98Fp6iwC75zEFEGux/rm8r+uIQNt2CKRjkOeh1e
	Ko/JqfmeaipzthcqGTOVsTZDpMM2y2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712043605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0O8XWaOhNB18VZt8keyCi8JOGWnMUiDcfFZIJVXWXI=;
	b=+fxZRqGXQufOam6e+PeEbpg6DvKHd3ClmqR5cpOW+AO7dis0VBut1ZMmjFHdV9yMuqcChQ
	Xo3PeLgS69vI7nCA==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D0EBF13A90;
	Tue,  2 Apr 2024 07:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id GY9jMlW2C2a1UwAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 07:40:05 +0000
Message-ID: <1cd77a44-6526-431b-89ba-cd6345a7e835@suse.cz>
Date: Tue, 2 Apr 2024 09:40:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab_common: Modify mismatched function name
Content-Language: en-US
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, cl@linux.com,
 akpm@linux-foundation.org
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20240328020711.125070-1-jiapeng.chong@linux.alibaba.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240328020711.125070-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.19
X-Spamd-Result: default: False [0.19 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 BAYES_HAM(-0.02)[52.44%];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,google.com,lge.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,linux.alibaba.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO

On 3/28/24 3:07 AM, Jiapeng Chong wrote:
> No functional modification involved.
> 
> mm/slab_common.c:1215: warning: expecting prototype for krealloc(). Prototype was for krealloc_noprof() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8659
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Seems like a fix-up for the alloc tagging series in mm.

> ---
>  mm/slab_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8664da88e843..8af45e9bd2b2 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1199,7 +1199,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>  }
>  
>  /**
> - * krealloc - reallocate memory. The contents will remain unchanged.
> + * krealloc_noprof - reallocate memory. The contents will remain unchanged.
>   * @p: object to reallocate memory for.
>   * @new_size: how many bytes of memory are required.
>   * @flags: the type of memory to allocate.


